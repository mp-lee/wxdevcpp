{
    This file is part of Dev-C++
    Copyright (c) 2004 Bloodshed Software

    Dev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Dev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

{$WARN SYMBOL_PLATFORM OFF}
unit CppParser;

interface

uses
  SQLiteTable3, SyncObjs, Classes, SysUtils, StrUtils, RegExpr, U_IntList,
{$IFDEF WIN32}
  Dialogs, Windows, ComCtrls;
{$ENDIF}
{$IFDEF LINUX}
  QDialogs, QComCtrls;
{$ENDIF}
  
type
  TIdentifierType = (
    itPrimitive = 0,
    itStructure,
    itClass,
    itUnion,
    itEnum,
    itTypedef,
    itFunction,
    itVariable,
    itConstant,
    itNamespace
  );
  TIdentifierGroup = set of TIdentifierType;

  TPointerType = (
    ptValue = 0,
    ptPointer,
    ptReference
  );

  TIdentifierAccess = (
    iaPublic = 0,
    iaPrivate,
    iaProtected
  );

  TParseIdentifier = class
  public
    ID: Int64;
    Name: string;
    Scope: Int64;
    IdentifierType: TIdentifierType;
    AccessSpec: TIdentifierAccess;

    DeclarationFile: string;
    DeclarationLine: Integer;
    ImplementationFile: string;
    ImplementationLine: Integer;

  public
    function IdentifierTypeAsText: string;
  end;

  TParseFunctionIdentifier = class(TParseIdentifier)
  public
    Returns: Int64;
    Prototype: string;
    Modifiers: Integer; //Discrete type later
  end;

  TParseVariableIdentifier = class(TParseIdentifier)
  public
    DataType: Int64;
  end;

  TProgressEvent = procedure(Sender: TObject; FileName: string; Total, Current: integer) of object;
  TParseThread = class;

  TCppParser = class(TComponent)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    //Open existing databases
    procedure LoadStore(Store: string);
    procedure LoadCache(Cache: string);
    procedure Save(Store: string);

    //List the current entries in the database
    function ListFiles: TStringList;

    //And supplement data
    procedure QueueFile(Path: string);

    //Change how parsing works
    procedure AddIncludePath(Path: string); //TODO: lowjoel: NOT IMPLEMENTED

    //Retrieve stuff from the database
    function FindIdentifierID(Identifier: string; Scope: Int64;
                              IdType: TIdentifierGroup = []): Int64; overload;
    function FindIdentifierID(Identifier: string; IdType:
                              TIdentifierGroup = []): Int64; overload;
    function FindIdentifierName(IdentifierID: Int64): string;
    function FilterByType(IdentifierType: TIdentifierGroup; PartialName: string = ''): TIntList;

    //Using the code fragment Phrase find the possible candidates for completion
    function FindTypeOf(Phrase: string; Scope: Int64; out IncompleteID: string): Int64;
    function FindScopeOfLine(Filename: string; Line: Integer): Int64;

    function GetDescendantsOf(IdentifierID: Int64; PartialName: string = ''): TIntList;
    function GetIdentifiersInScope(Scope: Int64; PartialName: string = ''): TIntList;
    function GetIdentifierDetails(IdentifierID: Int64): TParseIdentifier;

  private
    //Initialize a database file (Data source) if necessary
    procedure CreateDataSource;

  private
    //Make sure that only one thread can use our class at a time
    Lock: TCriticalSection;

    //The first DataSource is made up of tokens parsed in this session.
    LocalSource: TSQLiteDatabase;
    SourcePath: TFileName;

    //The actual scanning thread
    Parser: TParseThread;

    //Do we want to do parsing?
    fEnabled: Boolean;
    fDepth: Integer;

    //Event callbacks
    fOnFileProgress: TProgressEvent;
    fOnTotalProgress: TProgressEvent;
    fOnCacheProgress: TProgressEvent;
    fOnStartParsing: TNotifyEvent;
    fOnEndParsing: TNotifyEvent;

  published
    property OnFileProgress: TProgressEvent read fOnFileProgress write fOnFileProgress;
    property OnTotalProgress: TProgressEvent read fOnTotalProgress write fOnTotalProgress;
    property OnCacheProgress: TProgressEvent read fOnCacheProgress write fOnCacheProgress; //NOT IMPLEMENTED

    property OnStartParsing: TNotifyEvent read fOnStartParsing write fOnStartParsing;
    property OnEndParsing: TNotifyEvent read fOnEndParsing write fOnEndParsing;

    //Dummy properties
    property Enabled: Boolean read fEnabled write fEnabled;
    property RecursionDepth: Integer read fDepth write fDepth;
  end;

  TParseThread = class(TThread)
  public
    constructor Create(CreateSuspended: Boolean; Parser: TCppParser);
    destructor Destroy; override;
    procedure Execute; override;

    procedure QueueFile(Path: string);

  private
    function ProcessFile(Path: string): string;
    function ProcessFunction(Header, ClassMembers, FunctionDecl: TRegExpr;
                             Definition: Boolean): Int64;
    procedure InsertIdentifier(Name: string; Scope: Int64; IdType: TIdentifierType;
                               AccessSpec: string; DeclFile: string; DeclLine: Integer);

    function FindIdentifierID(Identifier: string; Scope: Int64; IdType: TIdentifierGroup = []): Int64; overload;
    function FindIdentifierID(Identifier: string; IdType: TIdentifierGroup = []): Int64; overload;

    procedure BreakUpVariableStr(VariableStr: string; var RegExp: TRegExpr; NameHint: string);
    function GetBaseDataType(VariableStr: string; NameHint: string = ''): string;
    function GetDataType(VariableStr: string; NameHint: string = ''): string;
    function GetPointerType(VariableName: string): TPointerType;
    procedure DeleteIdentifiersInFile(Path: string);

    function AccessSpecToIdAccess(AccessSpec: string): Integer;

  private //Synchronization functions
    SyncMarshal: TObject;
    procedure OnFileProgress;
    procedure OnTotalProgress;
    procedure OnStartParsing;
    procedure OnEndParsing;

  private
    Parser: TCppParser;
    DataSource: TSQLiteDatabase;
    DataLock: TCriticalSection;
    InputQueue: TStringList;
    Lock: TCriticalSection;
  end;

  TIntegrityError = class(Exception)
  end;

implementation
uses
  Dbugintf;

//Replace with the one in utils.pas
type
  TParseThreadProgressMarshal = class
    FileName: string;
    Total: Integer;
    Current: Integer;
  end;

TErrFunc = procedure(Msg: String) of Object;
TLineOutputFunc = procedure(Line: String) of Object;
TCheckAbortFunc = procedure(var AbortThread: boolean) of object;

function RunAndGetOutput(Cmd, WorkDir: string;
  ErrFunc: TErrFunc; LineOutputFunc: TLineOutputFunc;
  CheckAbortFunc: TCheckAbortFunc;
  ShowReturnValue: Boolean): string;
var
  tsi: TStartupInfo;
  tpi: TProcessInformation;
  nRead: DWORD;
  aBuf: array[0..32768] of Char;
  sa: TSecurityAttributes;
  hOutputReadTmp, hOutputRead, hOutputWrite, hInputWriteTmp, hInputRead,
    hInputWrite, hErrorWrite: THandle;
  FOutput: string;
  CurrentLine: String;
  bAbort: boolean;
begin
  FOutput := '';
  CurrentLine := '';
  sa.nLength := SizeOf(TSecurityAttributes);
  sa.lpSecurityDescriptor := nil;
  sa.bInheritHandle := True;

  CreatePipe(hOutputReadTmp, hOutputWrite, @sa, 0);
  DuplicateHandle(GetCurrentProcess(), hOutputWrite, GetCurrentProcess(),
    @hErrorWrite, 0, true, DUPLICATE_SAME_ACCESS);
  CreatePipe(hInputRead, hInputWriteTmp, @sa, 0);

  // Create new output read handle and the input write handle. Set
  // the inheritance properties to FALSE. Otherwise, the child inherits
  // the these handles; resulting in non-closeable handles to the pipes
  // being created.
  DuplicateHandle(GetCurrentProcess(), hOutputReadTmp, GetCurrentProcess(),
    @hOutputRead, 0, false, DUPLICATE_SAME_ACCESS);
  DuplicateHandle(GetCurrentProcess(), hInputWriteTmp, GetCurrentProcess(),
    @hInputWrite, 0, false, DUPLICATE_SAME_ACCESS);
  CloseHandle(hOutputReadTmp);
  CloseHandle(hInputWriteTmp);

  FillChar(tsi, SizeOf(TStartupInfo), 0);
  tsi.cb := SizeOf(TStartupInfo);
  tsi.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
  tsi.hStdInput := hInputRead;
  tsi.hStdOutput := hOutputWrite;
  tsi.hStdError := hErrorWrite;

  if not CreateProcess(nil, PChar(Cmd), @sa, @sa, true, 0, nil, nil,
                        tsi, tpi) then begin
    result := 'Unable to run "' + Cmd + '": ' + SysErrorMessage(GetLastError);
    exit;
  end;
  CloseHandle(hOutputWrite);
  CloseHandle(hInputRead);
  CloseHandle(hErrorWrite);

  bAbort := False;
  while True do
  begin
    if Assigned(CheckAbortFunc) then
      CheckAbortFunc(bAbort);
    if bAbort then begin
      TerminateProcess(tpi.hProcess, 1);
      Break;
    end;

    if (not ReadFile(hOutputRead, aBuf, SizeOf(aBuf) - 1, nRead, nil)) or (nRead = 0) then
      if GetLastError = ERROR_BROKEN_PIPE then
        Break
      else
        ErrFunc('Pipe read error, could not execute file');
    aBuf[nRead] := #0;
    FOutput := FOutput + PChar(@aBuf[0]);

    if Assigned(LineOutputFunc) then
    begin
      CurrentLine := CurrentLine + PChar(@aBuf[0]);
      if CurrentLine[Length(CurrentLine)] = #10 then
      begin
        Delete(CurrentLine, Length(CurrentLine), 1);
        LineOutputFunc(CurrentLine);
        CurrentLine := '';
      end;
    end;
  end;

  GetExitCodeProcess(tpi.hProcess, nRead);
  if ShowReturnValue then
    Result := FOutput + ' ' + inttostr(nread)
  else
    Result := FOutput;

  CloseHandle(hOutputRead);
  CloseHandle(hInputWrite);
  CloseHandle(tpi.hProcess);
  CloseHandle(tpi.hThread);
end;

function GetWindowsDir: TFileName;
  var
    WinDir: array [0..MAX_PATH-1] of char;
  begin
    SetString(Result, WinDir, GetWindowsDirectory(WinDir, MAX_PATH));
    if Result = '' then
      raise Exception.Create(SysErrorMessage(GetLastError));
  end;

  function GetTempDir: TFileName;
  var
    TmpDir: array [0..MAX_PATH-1] of char;
  begin
    try
      SetString(Result, TmpDir, GetTempPath(MAX_PATH, TmpDir));
      if not DirectoryExists(Result) then
        if not CreateDirectory(PChar(Result), nil) then begin
          Result := IncludeTrailingBackslash(GetWindowsDir) + 'TEMP';
          if not DirectoryExists(Result) then
            if not CreateDirectory(Pointer(Result), nil) then begin
              Result := ExtractFileDrive(Result) + '\TEMP';
              if not DirectoryExists(Result) then
                if not CreateDirectory(Pointer(Result), nil) then begin
                  Result := ExtractFileDrive(Result) + '\TMP';
                  if not DirectoryExists(Result) then
                    if not CreateDirectory(Pointer(Result), nil) then begin
                      raise Exception.Create(SysErrorMessage(GetLastError));
                    end;
                end;
            end;
        end;
    except
      Result := '';
      raise;
    end;
  end;

function GetTempName: string;
var
  Path: array [0..MAX_PATH-1] of char;
begin
  if GetTempFileName(PChar(GetTempDir), '~', 0, Path) = 0 then
    raise Exception.Create(SysErrorMessage(GetLastError));
  Result := Path;
end;

function TParseIdentifier.IdentifierTypeAsText: string;
begin
  case IdentifierType of
    itPrimitive: Result := 'Primitive';
    itStructure: Result := 'Structure';
    itClass:     Result := 'Class';
    itUnion:     Result := 'Union';
    itEnum:      Result := 'Enum';
    itTypedef:   Result := 'Typedef';
    itFunction:  Result := 'Function';
    itVariable:  Result := 'Variable';
    itConstant:  Result := 'Constant';
    itNamespace: Result := 'Namespace';
  end;
end;

//
//       TCppParser
//
constructor TCppParser.Create(AOwner: TComponent);
var
  TempName: string;
begin
  //Create our parent
  inherited;

  //Initialize the Wave recursion depth
  RecursionDepth := 0;

  //Create the synchronization object so we don't corrupt each other's memory
  Lock := TCriticalSection.Create;

  //Initialize the database structures
  //TempName := GetTempName;
  TempName := 'D:\Test.sqlite';
  try
    LoadStore(TempName);
  except
    on E: Exception do
      MessageBox(0, PChar('SQLite database could not be loaded: ' + E.Message),
                 'TCppParser', MB_ICONERROR or MB_OK or MB_APPLMODAL);
  end;

  //Then wait for parse requests
  Parser := TParseThread.Create(True, Self);
  Parser.FreeOnTerminate := True;
end;

destructor TCppParser.Destroy;
begin
  Parser.Terminate;
  Parser.Resume;
  Lock.Acquire;
  Lock.Free;

  LocalSource.Free;
  inherited;
end;

procedure TCppParser.CreateDataSource;
  procedure InsertPrimitiveType(Primitive: string);
  begin
    LocalSource.ExecSQL('INSERT INTO Identifiers (Name, Scope, Type) VALUES (''' +
                        Primitive + ''', -2, ' + IntToStr(Integer(itPrimitive)) + ');');
  end;
begin
  LocalSource.ExecSQL('CREATE TABLE IF NOT EXISTS Identifiers (' +
    'ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
    'Name VARCHAR(2048) NOT NULL,' +
    'Scope INTEGER(8) DEFAULT -1,' +
    'Type INTEGER(4) NOT NULL,' +
    'AccessSpec INTEGER(2) DEFAULT 0' +
  ');');

  LocalSource.ExecSQL('CREATE TABLE IF NOT EXISTS Locations (' +
    'ID INTEGER PRIMARY KEY NOT NULL,' +
    'DeclarationFile TEXT NOT NULL,' +
    'DeclarationLine INTEGER(8),' +
    'ImplementationFile TEXT,' +
    'ImplementationLine INTEGER(8)' +
  ');');

  LocalSource.ExecSQL('CREATE TABLE IF NOT EXISTS Inheritance (' +
    'ClassID INTEGER(8) PRIMARY KEY,' +
    'BaseClass INTEGER(8)' +
  ');');

  LocalSource.ExecSQL('CREATE TABLE IF NOT EXISTS Functions (' +
    'ID INTEGER(8),' +
    'Returns INTEGER(8),' +
    'Prototype TEXT,' +
    'Modifiers INTEGER(6)' +
  ');');

  LocalSource.ExecSQL('CREATE TABLE IF NOT EXISTS Variables (' +
    'ID INTEGER(8),' +
    'Datatype INTEGER(8),' +
    'Pointer INTEGER(2),' +
    'Modifiers INTEGER(6)' +
  ');');

  //Insert the default primitives
  if LocalSource.GetTableValue('SELECT COUNT(*) FROM Identifiers') = 0 then
  begin
    InsertPrimitiveType('void');
    InsertPrimitiveType('char');
    InsertPrimitiveType('int');
    InsertPrimitiveType('bool');
    InsertPrimitiveType('float');
    InsertPrimitiveType('double');
    InsertPrimitiveType('wchar_t');
  end;
end;

procedure TCppParser.LoadStore(Store: string);
begin
  //Open the handle
  if SourcePath <> '' then
    Exit;
  SourcePath := Store;
  LocalSource := TSQLiteDatabase.Create(SourcePath);
  CreateDataSource;

  //Then clean up
//  senddebug(SourcePath);
{  LocalSource.ExecSQL('DELETE FROM Identifiers WHERE ID > 7');
  LocalSource.ExecSQL('DELETE FROM Variables');
  LocalSource.ExecSQL('DELETE FROM functions');
  LocalSource.ExecSQL('DELETE FROM locations');
  LocalSource.ExecSQL('DELETE FROM inheritance');}
end;

procedure TCppParser.LoadCache(Cache: string);
resourcestring
  Message = 'A temporary file has the same name as the current data source.';
var
  NewStore: string;
begin
  //Differs from loading the store in that cache's force the database contents to
  //be copied before use.
  Exit;
  NewStore := GetTempName;
  if FileExists(Cache) and not CopyFile(PChar(Cache), PChar(NewStore), False) then
    raise Exception.Create(IntToStr(GetLastError));
  LoadStore(NewStore);
end;

procedure TCppParser.Save(Store: string);
resourcestring
  Message = 'The path you are saving to has an existing file.';
begin
  FreeAndNil(LocalSource); //Close the file
  setlasterror(0);
  if FileExists(Store) and not DeleteFile(PChar(Store)) then
    raise Exception.Create('Could not delete destination file ' + Store + ': ' +
                           SysErrorMessage(GetLastError));
  if not CopyFile(PChar(SourcePath), PChar(Store), False) then
    raise Exception.Create('Could not save to destination file: ' + Store +
                           SysErrorMessage(GetLastError));
  LoadStore(Store);
end;

function TCppParser.ListFiles: TStringList;
  procedure DistinctFiles(Column: string);
  var
    Table: TSQLiteTable;
  begin
    Table := LocalSource.GetTable('SELECT DISTINCT (' + Column + '), * FROM Locations;');
    while not Table.EOF do
    begin
      Result.Add(Table.FieldAsString(0));
      Table.Next;
    end;
    Table.Free;
  end;
begin
  Result := TStringList.Create;
  Result.Duplicates := dupIgnore;
  DistinctFiles('DeclarationFile');
  DistinctFiles('ImplementationFile');
end;

procedure TCppParser.QueueFile(Path: string);
begin
  Parser.QueueFile(Path);
end;

procedure TCppParser.AddIncludePath(Path: string);
begin
  //TODO: lowjoel: NOT IMPLEMENTED
end;

//TODO: lowjoel: Allow searching for identifiers given a function scope
function TCppParser.FindIdentifierID(Identifier: string; Scope: Int64;
                                     IdType: TIdentifierGroup): Int64;
var
  I: Integer;
  Query: string;
  Table: TSQLiteTable;
  ScopeOperatorPos: Integer;
begin
  //Process the identifier string for identifiers of the sort className::memberName
  ScopeOperatorPos := Pos('::', Identifier);
  if ScopeOperatorPos <> 0 then
    Result := FindIdentifierID(Copy(Identifier, ScopeOperatorPos + 2, Length(Identifier)),
                               FindIdentifierID(Copy(Identifier, 1, ScopeOperatorPos - 1),
                                                Scope, [itClass, itStructure, itUnion, itNamespace]),
                               IdType)
  else
  begin
    Query := 'SELECT ID FROM Identifiers WHERE Name=''' + Identifier + '''';
    if Scope >= 0 then
      Query := Query + ' AND Scope=' + IntToStr(Scope);
    if IdType <> [] then
    begin
      Query := Query + ' AND Type IN (';
      for I := Integer(itPrimitive) to Integer(itNamespace) do
        if TIdentifierType(I) in IdType then
          Query := Query + IntToStr(Integer(I)) + ', ';
      Query := Copy(Query, 1, Length(Query) - 2) + ');';
    end;

    Table := LocalSource.GetTable(Query + ';');
    if not Table.EOF then
      Result := StrToInt(Table.Fields[0])
    else
      Result := -1;

    Table.Free;
  end;
end;

function TCppParser.FindIdentifierID(Identifier: string; IdType: TIdentifierGroup): Int64;
begin
  Result := FindIdentifierID(Identifier, -1, IdType);
end;

function TCppParser.FindIdentifierName(IdentifierID: Int64): string;
var
  Table: TSQLiteTable;
begin
  Table := LocalSource.GetTable('SELECT Name FROM Identifiers WHERE ID=' + IntToStr(IdentifierID) +
                                ';');
  if not Table.EOF then
    Result := Table.FieldAsString(0)
  else
    Result := '<unknown>';
  Table.Free;
end;

function TCppParser.FilterByType(IdentifierType: TIdentifierGroup; PartialName: string): TIntList;
var
  Table: TSQLiteTable;
  NameFilter: string;

  function IdentifierGroupToSQL(Identifiers: TIdentifierGroup): string;
  var
    IdentifierTypes: TStringList;
  begin
    IdentifierTypes := TStringList.Create;
    if (itPrimitive in Identifiers) then
      IdentifierTypes.Add(IntToStr(Integer(itPrimitive)));
    if (itStructure in Identifiers) then
      IdentifierTypes.Add(IntToStr(Integer(itStructure)));
    if (itClass in Identifiers) then
      IdentifierTypes.Add(IntToStr(Integer(itClass)));
    if (itUnion in Identifiers) then
      IdentifierTypes.Add(IntToStr(Integer(itUnion)));
    if (itEnum in Identifiers) then
      IdentifierTypes.Add(IntToStr(Integer(itEnum)));
    if (itTypedef in Identifiers) then
      IdentifierTypes.Add(IntToStr(Integer(itTypedef)));
    if (itFunction in Identifiers) then
      IdentifierTypes.Add(IntToStr(Integer(itFunction)));
    if (itVariable in Identifiers) then
      IdentifierTypes.Add(IntToStr(Integer(itVariable)));
    if (itConstant in Identifiers) then
      IdentifierTypes.Add(IntToStr(Integer(itConstant)));
    if (itNamespace in Identifiers) then
      IdentifierTypes.Add(IntToStr(Integer(itNamespace)));

    IdentifierTypes.Delimiter := ',';
    Result := IdentifierTypes.DelimitedText;
    IdentifierTypes.Free;
  end;
begin
  //Create the SQL Filter
  if PartialName <> '' then
    NameFilter := ' AND Name LIKE ''' + PartialName + '''';

  //Then give our own IDs
  Table := LocalSource.GetTable('SELECT ID FROM Identifiers WHERE Type IN (' +
                                IdentifierGroupToSQL(IdentifierType) + ')' +
                                NameFilter + ';');

  //Populate the results
  Result := TIntList.Create;
  while not Table.EOF do
  begin
    Result.Add(Table.FieldAsInteger(0));
    Table.Next;
  end;
  Table.Free;
end;

function TCppParser.FindTypeOf(Phrase: string; Scope: Int64; out IncompleteID: string): Int64;
var
  IdentifierDetails: TParseIdentifier;
  IdentifierParts: TStringList;
  RegExp: TRegExpr;
  CurrId: Int64;
  I: Integer;

  function BreakUpIdentifier(Phrase: string): TStringList;
  var
    start, stop: Integer;
    delimiter: string;
  begin
    Result := TStringList.Create;
    Start := 1;
    Stop := 1;
    while Stop <= Length(Phrase) do
    begin
      //Look ahead
      delimiter := Copy(Phrase, Stop, 1);
      if delimiter <> '.' then
      begin
        delimiter := Copy(Phrase, Stop, 2);
        if delimiter <> '::' then
        begin
          delimiter := Copy(Phrase, Stop, 2);
          if delimiter <> '->' then
            delimiter := '';
        end;
      end;

      //Do we have a delimiter?
      if delimiter <> '' then
      begin
        Result.Add(Trim(Copy(Phrase, Start, Stop - Start)));
        Result.Add(Delimiter);
        Inc(Stop, Length(Delimiter));
        Start := Stop;
      end
      else
        Inc(Stop);
    end;

    if Start <= Length(Phrase) then
      IncompleteID := Copy(Phrase, Start, Length(Phrase));
  end;

  function AccessibleScopes(ID: Int64): string;
  var
    AvailableScopes: TStringList;
  begin
    AvailableScopes := TStringList.Create;

    //Iterate over the scopes of every identifier, to see which scopes are accessible
    while ID <> -1 do
    begin
      AvailableScopes.Add(IntToStr(ID));
      IdentifierDetails := GetIdentifierDetails(ID);
      if Assigned(IdentifierDetails) then
      begin
        ID := IdentifierDetails.Scope;
        IdentifierDetails.Free;
      end
      else
        ID := -1;
    end;

    AvailableScopes.Delimiter := ',';
    Result := AvailableScopes.DelimitedText;
    AvailableScopes.Free;
  end;

  function MatchIdentifierFromScope(Identifier: string; Scope: Int64; StrictMatch: Boolean): Int64;
  begin
    //First simplify the part of the string. Return function name if it is a function
    if RegExp.Exec(Identifier, '([0-9a-zA-Z_]+)[ '#9']*\(.*\)') then
    begin
      if StrictMatch then
        Result := LocalSource.GetTableValue('SELECT ID FROM Identifiers WHERE Scope IN (' +
                                             AccessibleScopes(Scope) + ',-1) AND Name=''' +
                                             Identifier + '''')
      else
        Result := LocalSource.GetTableValue('SELECT ID FROM Identifiers WHERE Scope IN (' +
                                             AccessibleScopes(Scope) + ',-1) AND Name ' +
                                             'LIKE ''' + Identifier + '%''');
    end
    else
    begin
      if StrictMatch then
        Result := LocalSource.GetTableValue('SELECT ID FROM Identifiers WHERE Scope IN (' +
                                             AccessibleScopes(Scope) + ',-1) AND Name=''' +
                                             Identifier + ''' AND Type <> ' +
                                             IntToStr(Integer(itFunction)))
      else
        Result := LocalSource.GetTableValue('SELECT ID FROM Identifiers WHERE Scope IN(' +
                                             AccessibleScopes(Scope) + ',-1) ' +
                                             ' AND Name LIKE ''' + Identifier +
                                             '%'' AND Type <> ' + IntToStr(Integer(itFunction)));
    end;
  end;
begin
  currID := -1;
  Result := Scope;
  RegExp := TRegExpr.Create;
  IdentifierParts := BreakUpIdentifier(Phrase);

  //Parse the thing left-to-right. Use the delimiter ahead of the current token
  //as a guide for the identifier to look up for.
  I := 0;
  while I < IdentifierParts.Count do
  begin
    //Get the ID of the identifier we are trying to use
    try
      currID := MatchIdentifierFromScope(IdentifierParts[I], Result, I < IdentifierParts.Count - 1);
    except
      on E: ESqliteException do
      begin
        Result := -1;
        Exit;
      end;
    end;

    //Then retrieve the identifier details
    IdentifierDetails := GetIdentifierDetails(currID);

    //Reduce the scope to the return type of the function or to list the class members
    case IdentifierDetails.IdentifierType of
      itClass:
        Result := currID;
      itVariable:
      begin
        //Resolve the variable's type
        Assert(Assigned(IdentifierDetails) and ((IdentifierDetails is TParseVariableIdentifier)));
        if Assigned(IdentifierDetails) then
        begin
          Result := (IdentifierDetails as TParseVariableIdentifier).DataType;
          IdentifierDetails.Free;
        end;
      end;
      itFunction:
      begin
        if Assigned(IdentifierDetails) then
        begin
          Result := (IdentifierDetails as TParseFunctionIdentifier).Returns;
          IdentifierDetails.Free;
        end;
      end;
    end;
    Inc(I, 2);
  end;

  //If I is still zero, return the WHOLE scope since we don't have any information
  if I = 0 then
    Result := -1; 
  IdentifierParts.Free;
end;

//TODO: lowjoel: Improve this?
function TCppParser.FindScopeOfLine(Filename: string; Line: Integer): Int64;
var
  Table: TSQLiteTable;
begin
  Table := LocalSource.GetTable('SELECT ID ' +
                                'FROM Locations WHERE ImplementationFile=''' +
                                StringReplace(FileName, '\', '\\', [rfReplaceAll]) + '''' +
                                ' AND (ImplementationLine - ' + IntToStr(Line) + ') < 0 ' +
                                'ORDER BY ImplementationLine DESC;');
  if not Table.Eof then
    Result := Table.FieldAsInteger(0)
  else
    Result := -1;
end;

function TCppParser.GetDescendantsOf(IdentifierID: Int64; PartialName: string): TIntList;
  procedure RecurseDescendant(IdentifierID: Int64);
  var
    Table: TSQLiteTable;
    currRow: Int64;
  begin
    Table := LocalSource.GetTable('SELECT ID FROM Identifiers WHERE Scope=' + IntToStr(IdentifierID) + ';');
    try
      while not Table.EOF do
      begin
        currRow := Table.FieldAsInteger(0);
        Result.Add(currRow);
        RecurseDescendant(currRow);
        Table.Next;
      end;
    finally
      Table.Free;
    end;
  end;
var
  Table: TSQLiteTable;
  currRow: Int64;
  NameFilter: string;
begin
  Result := TIntList.Create;
  if PartialName <> '' then
    NameFilter := ' AND Name LIKE ''' + PartialName + '%''';

  Table := LocalSource.GetTable('SELECT ID FROM Identifiers WHERE Scope=' + IntToStr(IdentifierID) + NameFilter + ';');
  try
    while not Table.EOF do
    begin
      currRow := Table.FieldAsInteger(0);
      Result.Add(currRow);
      RecurseDescendant(currRow);
      Table.Next;
    end;
  finally
    Table.Free;
  end;
end;

function TCppParser.GetIdentifiersInScope(Scope: Int64; PartialName: string): TIntList;
var
  NameFilter: string;
  procedure ListScopeIdentifiers(Scope: Int64);
  var
    Table: TSQLiteTable;
    currRow: Int64;
  begin
    Table := LocalSource.GetTable('SELECT ID FROM Identifiers WHERE Scope=' +
                                  IntToStr(Scope) + NameFilter + ';');
    try
      while not Table.EOF do
      begin
        currRow := Table.FieldAsInteger(0);
        Result.Add(currRow);
        Table.Next;
      end;
    finally
      Table.Free;
    end;
  end;
begin
  Result := TIntList.Create;
  if PartialName <> '' then
    NameFilter := ' AND Name LIKE ''' + PartialName + '%''';

  //The following code finds identifiers in the current scope
  while Scope <> -1 do
  begin
    ListScopeIdentifiers(Scope);
    Scope := LocalSource.GetTableValue('SELECT Scope FROM Identifiers WHERE ID=' +
                                       IntToStr(Scope) + ';');
  end;
end;

function TCppParser.GetIdentifierDetails(IdentifierId: Int64): TParseIdentifier;
var
  Table: TSQLiteTable;
  SpecialTable: TSQLiteTable;
begin
  //First query the database
  Table := LocalSource.GetTable('SELECT * FROM Identifiers INNER JOIN Locations ON ' +
                                'Locations.ID=Identifiers.ID WHERE Identifiers.ID=' +
                                IntToStr(IdentifierId));
  if Table.Eof then
  begin
    Result := nil;
    Exit;
  end;
  
  case TIdentifierType(Table.FieldAsInteger(3)) of
    itVariable:
    begin
      Result := TParseVariableIdentifier.Create;
      SpecialTable := LocalSource.GetTable('SELECT * FROM Variables WHERE ID=' + IntToStr(IdentifierId));
      with TParseVariableIdentifier(Result) do
      begin
        DataType := SpecialTable.FieldAsInteger(1);
      end;

      SpecialTable.Free;
    end;

    itPrimitive,
    itNamespace,
    itConstant:
      Result := TParseIdentifier.Create;

    itClass,
    itStructure,
    itUnion:
      Result := TParseIdentifier.Create;

    itEnum,
    itTypedef:
      Result := TParseIdentifier.Create;

    itFunction:
    begin
      Result := TParseFunctionIdentifier.Create;
      SpecialTable := LocalSource.GetTable('SELECT * FROM Functions WHERE ID=' + IntToStr(IdentifierId));
      with TParseFunctionIdentifier(Result) do
      begin
        Returns := SpecialTable.FieldAsInteger(1);
        Prototype := SpecialTable.FieldAsString(2);
      end;

      SpecialTable.Free;
    end;
  else
    raise EAbstractError.Create('Error: Unknown Identifier Type');
  end;

  with Result do
  begin
    ID := IdentifierId;
    Name := Table.FieldAsString(1);
    Scope := Table.FieldAsInteger(2);
    IdentifierType := TIdentifierType(Table.FieldAsInteger(3));
    AccessSpec := TIdentifierAccess(Table.FieldAsInteger(4));

    DeclarationFile := Table.FieldAsString(4);
    DeclarationLine := Table.FieldAsInteger(5);
    ImplementationFile := Table.FieldAsString(6);
    ImplementationLine := Table.FieldAsInteger(7);
  end;

  Table.Free;
end;

//
//   TParseThread
//
constructor TParseThread.Create(CreateSuspended: Boolean; Parser: TCppParser);
begin
  InputQueue := TStringList.Create;
  Self.DataLock := Parser.Lock;
  Self.DataSource := Parser.LocalSource;
  Self.Parser := Parser;
  Lock := TCriticalSection.Create;
  inherited Create(CreateSuspended);
end;

destructor TParseThread.Destroy;
begin
  InputQueue.Free;
  Lock.Free;
end;

procedure TParseThread.Execute;
var
  Path: string;
  QueueLength: Integer;
  CurrentConsecutiveFile: Integer;
begin
  QueueLength := 0;
  CurrentConsecutiveFile := 0;
  while not Self.Terminated do
  begin
    try
      //Check if we have incoming files to parse
      Lock.Acquire;
      if InputQueue.Count = 0 then
      begin
        Lock.Release;
        if Assigned(Parser.OnEndParsing) then
          Synchronize(OnEndParsing);
        CurrentConsecutiveFile := 0;
        Suspend;
        Continue;
      end;

      //Yep we do.
      Path := InputQueue[0];
      QueueLength := InputQueue.Count;
      InputQueue.Delete(0);

      Inc(CurrentConsecutiveFile);
    finally
      Lock.Release;
    end;

    //Keep the main frame up to date about our parse progress
    if Assigned(Parser.OnStartParsing) then
      Synchronize(OnStartParsing);
    if Assigned(Parser.OnTotalProgress) then
    begin
      SyncMarshal := TParseThreadProgressMarshal.Create;
      with TParseThreadProgressMarshal(SyncMarshal) do
      begin
        FileName := Path;
        Total := QueueLength;
        Current := CurrentConsecutiveFile;
      end;
      Synchronize(OnTotalProgress);
      SyncMarshal.Free;
    end;

    //Process the file we are looking at
    ProcessFile(Path);
  end;
end;

procedure TParseThread.QueueFile(Path: string);
begin
  try
    Lock.Acquire;
    InputQueue.Add(PChar(Path));
  finally
    Lock.Release;
  end;

  if Self.Suspended then
    Self.Resume;
end;

function TParseThread.FindIdentifierID(Identifier: string; Scope: Int64; IdType: TIdentifierGroup): Int64;
begin
  Result := Parser.FindIdentifierID(Identifier, Scope, IdType);
end;

function TParseThread.FindIdentifierID(Identifier: string; IdType: TIdentifierGroup): Int64;
begin
  Result := Parser.FindIdentifierID(Identifier, IdType);
end;

//TODO: lowjoel: functions whose return type is const do lose their const-ness if they
//               include another function return type modifiers (long, short, unsigned, signed)
procedure TParseThread.BreakUpVariableStr(VariableStr: string; var RegExp: TRegExpr;
                                          NameHint: string);
begin
  //First Replace the variable strings' ; and , with \r\n
  VariableStr := StringReplace(Trim(VariableStr), ';', #13#10, [rfReplaceAll]);
  VariableStr := StringReplace(VariableStr, ',', #13#10, [rfReplaceAll]);
  if Trim(NameHint) = '' then
    NameHint := '[_a-zA-Z0-9<>]+';

  //Then do the quick check -- is the VariableStr equal to the NameHint? If so then
  //the answer is straightforward
  if Trim(VariableStr) = NameHint then
    Exit;

  //Function declarations
  if not RegExp.Exec(VariableStr, '(static\s|extern\s|virtual\s|inline\s)*(const\s|long\s|short\s|unsigned\s|signed\s)*([_a-zA-Z0-9<>]+)([\s*&]+){0,1}(~{0,1}[_a-zA-Z0-9:]*)[\s]*\(.*\)') then

  //Operator functions
  if not RegExp.Exec(VariableStr, '(static\s|extern\s|virtual\s|inline\s)*operator\s+(const\s|long\s|short\s|unsigned\s|signed\s)*(' + NameHint + ')([\s*&]*)\(.*?\)(.{0,0})') then
  if not RegExp.Exec(VariableStr, '(static\s|extern\s|virtual\s|inline\s)*(const\s|long\s|short\s|unsigned\s|signed\s)*([_a-zA-Z0-9<>]+)\s+operator\s*([+-]{1,2}|[/*|!%&()=]|[+\-/*~|&]\=|\[\])\s*\(.*?\)(.{0,0})') then

  //Constructor and destructor
  if not RegExp.Exec(VariableStr, '(static\s|extern\s|virtual\s|inline\s)*()()()(~{0,1}[_a-zA-Z0-9:]*)[\s]*\(.*\)') then

  //Variables
  if not RegExp.Exec(VariableStr, '(static\s|extern\s)*(const\s|long\s|short\s|unsigned\s|signed\s)*([_a-zA-Z0-9<>]+)([\s*&]*)(' + NameHint + ')') then
    SendDebug('Cannot break up variable string: ' + VariableStr);
end;

function TParseThread.GetBaseDataType(VariableStr: string; NameHint: string): string;
var
  RegExp: TRegExpr;
begin
  RegExp := TRegExpr.Create;
  BreakUpVariableStr(VariableStr, RegExp, NameHint);

  if RegExp.SubExprMatchCount <> 0 then
    Result := RegExp.Match[3];
  RegExp.Free;
end;

function TParseThread.GetDataType(VariableStr: string; NameHint: string): string;
var
  RegExp: TRegExpr;
begin
  RegExp := TRegExpr.Create;
  BreakUpVariableStr(VariableStr, RegExp, NameHint);

  if RegExp.SubExprMatchCount <> 0 then
    Result := RegExp.Match[2] + RegExp.Match[3] + Trim(RegExp.Match[4]);
  RegExp.Free;
end;

function TParseThread.AccessSpecToIdAccess(AccessSpec: string): Integer;
var
  RegExp: TRegExpr;
begin
  RegExp := TRegExpr.Create;
  if RegExp.Exec(AccessSpec, 'access:(private|public|protected)') then
  begin
    if RegExp.Match[1] = 'private' then
      Result := Integer(iaPrivate)
    else if RegExp.Match[1] = 'public' then
      Result := Integer(iaPublic)
    else
      Result := Integer(iaProtected);
  end
  else
    Result := Integer(iaPublic);
  RegExp.Free;
end;

function TParseThread.GetPointerType(VariableName: string): TPointerType;
begin
  Result := ptValue;
  if AnsiStartsStr('*', VariableName) then
    Result := ptPointer
  else if AnsiStartsStr('&', VariableName) then
    Result := ptReference;
end;

procedure TParseThread.DeleteIdentifiersInFile(Path: string);
begin
  //TODO: lowjoel: Library function for this? All files are added with the \\ instead of \ (escaping)
  Path := AnsiReplaceStr(AnsiReplaceStr(Path, '\', '\\'), '/', '\\');

  //Delete functions in current file
  DataSource.BeginTransaction;
  DataSource.ExecSQL('DELETE FROM Inheritance WHERE ClassID IN (SELECT ID FROM Locations WHERE ' +
                    'DeclarationFile=''' + Path + ''')');
  //Delete variables found in current
  DataSource.ExecSQL('DELETE FROM Variables WHERE ID IN (SELECT ID FROM Locations WHERE ' +
                     'DeclarationFile=''' + Path + ''')');
  //Delete identifiers in current file
  DataSource.ExecSQL('DELETE FROM Identifiers WHERE ID IN (SELECT ID FROM Locations WHERE ' +
                     'DeclarationFile=''' + Path + ''')');
  //And leave no loose ends
  DataSource.ExecSQL('DELETE FROM Locations WHERE DeclarationFile=''' + Path + '''');
  DataSource.Commit;
end;

procedure TParseThread.InsertIdentifier(Name: string; Scope: Int64; IdType: TIdentifierType;
                                        AccessSpec: string; DeclFile: string; DeclLine: Integer);
const
  IdentifiersSQL: string = 'INSERT INTO Identifiers (Name, Scope, Type, AccessSpec) VALUES (''%s'', %d, %d, %d);';
  LocationSQL: string    = 'INSERT INTO Locations (ID, DeclarationFile, DeclarationLine) VALUES '+
                           '(%d, ''%s'', %d)';
var
  Tbl: TSQLiteTable;
begin
  Tbl := DataSource.GetTable('SELECT ID FROM Identifiers WHERE Name=''' + Name + ''' AND Scope=' + IntToStr(Scope) +
                             ' AND Type=' + IntToStr(Integer(IdType)) + ' AND NOT ' +
                             'Type  IN(' + Format('%d, %d', [Integer(itFunction), Integer(itClass)]) + ');');
  if tbl.RowCount <> 0 then
    SendDebug('Error: Integrity Failure: Duplicate entries of ' +
                                 Name + ' found in code: ' + IntToStr(Tbl.RowCount));
  DataSource.ExecSQL(Format(IdentifiersSQL, [Name, Scope, Integer(IdType), AccessSpecToIdAccess(AccessSpec)]));
  DataSource.ExecSQL(Format(LocationSQL, [DataSource.GetLastInsertRowID, DeclFile, DeclLine]));
end;

function TParseThread.ProcessFile(Path: string): string;
var
  Header, ClassDecl, ClassMembers, EnumDecl, FunctionDecl: TRegExpr;
  PreProcFile: string;
  //Tags: TStringList;
  Properties: string;

  RawTags: string;
  CurrentTagStart: Integer;
  CurrentTagEnd: Integer;
  CurrentTag: string;

  CurrentFunction: Int64;
  CurrentType: string;
  CachedType: Int64; //Temporary variable to hold variable types across commas
  ScopeId: Int64;

  procedure InsertLineDirective(PreProcFile: string; RealPath: string);
  var
    Lines: TStringList;
  begin
    Lines := TStringList.Create;
    Lines.LoadFromFile(PreProcFile);
    Lines.Insert(0, '#line 1 "' + AnsiReplaceStr(RealPath, '\', '\\') + '"');
    Lines.SaveToFile(PreProcFile);
    Lines.Free;
  end;
  
  function KindToIdentifierType(Kind: Char): TIdentifierType;
  begin
    case Kind of
      'c': Result := itClass;
      's': Result := itStructure;
      'e': Result := itConstant;
      'f', 'p': Result := itFunction;
      'g': Result := itEnum;
      'l': Result := itVariable;
      'm': Result := itVariable;
      'u': Result := itUnion;
      'v': Result := itVariable;
      't': Result := itTypeDef;
    else
      raise EAbstractError.Create('Unknown ctags tag kind value: ' + Kind);
    end;
  end;
begin
  PreProcFile := GetTempName + '.cpp';
  //TODO: Make wave emulate another compiler?
  Properties :=
  RunAndGetOutput('wave -n ' + IntToStr(Parser.RecursionDepth) + ' ' +
                  '-S "C:\Program Files\Microsoft Visual Studio 8\VC\include" ' +
                  '-I "D:\Visual Studio 2005\Libraries\wxWidgets\include" ' +
                  '-D MSC_VER=1401 -D _WIN32 -o "' + PreProcFile + '" "' + Path +
                  '"', '', nil, nil, nil, False);
  if Properties <> '' then
  begin
    if MessageBox(0, PChar('Wave had output: '#10#13 + Properties + #10#13#10#13 +
                           'Continue with tagging?'), 'Code Completion',
                  MB_ICONHAND or MB_APPLMODAL or MB_YESNO) = IDNO then
      Exit;
  end;

  //Cheat ctags. The first few lines need to get a #line directive to set the
  //correct "source" file
  InsertLineDirective(PreProcFile, Path);

  Header := TRegExpr.Create;
  ClassDecl := TRegExpr.Create;
  EnumDecl := TRegExpr.Create;
  FunctionDecl := TRegExpr.Create;
  ClassMembers := TRegExpr.Create;

  try
    //Retrieve the tags from the file
    RawTags := RunAndGetOutput('ctags -u -f - --fields=+a+i+m+n+S+z --c++-kinds=+lpx ' +
                              '--line-directives=yes "' + PreProcFile + '"', '',
                              nil, nil, nil, False);

    //Begin parsing!
    Header.Expression := '([^'#9']+)	([^'#9']+)	\/\^(.*)\$\/;"['#9' ]+kind:([a-zA-Z])['#9' ]+line:([0-9]+)['#9' ]*(.*)';
    ClassDecl.Expression := 'inherits:(.*)['#9' ]*';
    ClassMembers.Expression := '(class|struct|union):([^'#9']*)	*(file:){0,1}	*(access:public|access:private|access:protected){0,1}	*(implementation:[^'#9']*){0,1}	*(.*)';
    EnumDecl.Expression := 'enum:([^'#9' ]+)';
    FunctionDecl.Expression := 'signature:(.*)';

    //Lock our database access
    DataLock.Acquire;

    //Clean up the old entries found in this file, since we are used for both parsing
    //and reparsing
    DeleteIdentifiersInFile(Path);

    //Then start a new transaction to speed things up
    DataSource.BeginTransaction;

    CachedType := -1;
    CurrentFunction := -1;
    CurrentTagEnd := -1;
    while CurrentTagEnd + 2 < Length(RawTags) do
    begin
      CurrentTagStart := CurrentTagEnd + 2;
      CurrentTagEnd := PosEx(#13#10, RawTags, CurrentTagStart);
      CurrentTag := Trim(Copy(RawTags, CurrentTagStart, CurrentTagEnd - CurrentTagStart));

      if Assigned(Parser.OnFileProgress) then
      begin
        SyncMarshal := TParseThreadProgressMarshal.Create;
        with TParseThreadProgressMarshal(SyncMarshal) do
        begin
          FileName := Path;
          Total := Length(RawTags);
          Current := CurrentTagStart;
        end;
        Self.Synchronize(OnFileProgress);
        SyncMarshal.Free;
      end;
      
      //Skip empty lines
      if Length(CurrentTag) = 0 then
        Continue;

      try
        if Header.Exec(CurrentTag) then
        begin
          //Remove the class body stuff (access spec, parent class etc)
          if ClassMembers.Exec(Header.Match[6]) then
            Properties := ClassMembers.Match[6]
          else
            Properties := Header.Match[6];

          //Ignore tags from files which is not the file we are told to parse
          if StringReplace(Header.Match[2], '\\', '\', [rfReplaceAll]) <> Path then
            Continue;

          ScopeId := FindIdentifierID(ClassMembers.Match[2], [itClass, itStructure, itUnion, itNamespace]);
          case Header.Match[4][1] of
            'c', //classes
            'u', //union names
            's': //structures
            begin
              //TODO: lowjoel: multiple inheritance not supported
              InsertIdentifier(Header.Match[1], ScopeId, KindToIdentifierType(Header.Match[4][1]),
                               ClassDecl.Match[4], Header.Match[2], StrToInt(Header.Match[5]));
              if (Properties <> '') then
                if ClassDecl.Exec(Properties) then
                  DataSource.ExecSQL('INSERT INTO Inheritance VALUES (' + IntToStr(DataSource.GetLastInsertRowID) +
                                     ', ' + IntToStr(FindIdentifierID(ClassDecl.Match[1])) + ');')
                else
                  raise Exception.Create('Parse Failure: ' + CurrentTag);
            end;

            'e': //enumerators (values inside an enumeration)
            begin
              if EnumDecl.Exec(Properties) then
                InsertIdentifier(Header.Match[1], FindIdentifierID(EnumDecl.Match[1]),
                                 KindToIdentifierType(Header.Match[4][1]),
                                 ClassDecl.Match[4], Header.Match[2],
                                 StrToInt(Header.Match[5]))
              else
                raise Exception.Create('Parse Failure: ' + CurrentTag);
            end;

            'f', //function definitions
            'p': //function prototypes [off]
            begin
              if not FunctionDecl.Exec(Properties) then
                raise Exception.Create('Parse Failure: ' + CurrentTag);

              if Header.Match[4][1] = 'f' then
              begin
                CurrentFunction := ProcessFunction(Header, ClassMembers, FunctionDecl,
                                                   True);
              end
              else
                ProcessFunction(Header, ClassMembers, FunctionDecl, False);
            end;

            'g': //enumeration names
            begin
              if (not EnumDecl.Exec(Properties)) and (Properties <> '') then
                raise Exception.Create('Parse Failure: ' + CurrentTag);
              InsertIdentifier(Header.Match[1], ScopeID,
                               KindToIdentifierType(Header.Match[4][1]),
                               ClassDecl.Match[4], Header.Match[2],
                               StrToInt(Header.Match[5]));
            end;

            'l', //local variables
            'v', //variable definitions
            'm': //class, struct, and union members
            begin
              //It is extremely important we filter the variable types since it is one
              //sure marker of an invalid tag (forward-declaration-like)
              CurrentType := GetDataType(Header.Match[3], Header.Match[1]);
              if (CurrentType = 'class') or (CurrentType = 'union') or
                 (CurrentType = 'struct') then
              begin
                raise Exception.Create(Header.Match[1] + ' is in function ' +
                                       IntToStr(CurrentFunction) + ', is of type '+
                                       CurrentType + ', and is a pointer of type ' +
                                       IntToStr(Integer(GetPointerType(Header.Match[1]))) +
                                       '            '#10#13 + Header.Match[0]);
                Continue;
              end;

              //Cache the current data type, since the next few variables may not
              //have the full type (like, int a, b, c)
              if CurrentType <> '' then
                CachedType := FindIdentifierID(CurrentType);

              //Insert the identifier, defining scope and stuff
              if Header.Match[4][1] = 'm' then
              begin
                InsertIdentifier(Header.Match[1], ScopeID, KindToIdentifierType(Header.Match[4][1]),
                                 ClassDecl.Match[4], Header.Match[2], StrToInt(Header.Match[5]));
              end
              else if Header.Match[4][1] = 'l' then
                //CurrentFunction can be used ONLY because locals can only be in a function (hence, locals)
                InsertIdentifier(Header.Match[1], CurrentFunction, KindToIdentifierType(Header.Match[4][1]),
                                 'access:public', Header.Match[2], StrToInt(Header.Match[5]))
              else if Header.Match[4][1] = 'v' then
                InsertIdentifier(Header.Match[1], -1, KindToIdentifierType(Header.Match[4][1]),
                                 'access:public', Header.Match[2], StrToInt(Header.Match[5]));

              //Then add the other stuff like datatype and modifiers
              DataSource.ExecSQL('INSERT INTO Variables (ID, Datatype, Pointer, Modifiers) VALUES (' +
                                 IntToStr(DataSource.GetLastInsertRowID) + ', ' +
                                 IntToStr(CachedType) + ', ' +
                                 IntToStr(Integer(GetPointerType(Header.Match[1]))) +
                                 ', 0)');
            end;

            't': //typedefs
            begin
              InsertIdentifier(Header.Match[1], ScopeID,
                               KindToIdentifierType(Header.Match[4][1]),
                               ClassDecl.Match[4], Header.Match[2],
                               StrToInt(Header.Match[5]));
            end;

           {'d', //macro definitions
            'n', //namespaces
            'x': //external variable declarations [off]
            else
              raise EAbstractError.Create('Parse Failure: Not implemented: ' + CurrentTag);}
          end
        end
        else
          raise Exception.Create('Parse Failure: Unknown tag: ' + CurrentTag);
      except
        on E: EAbstractError do
          SendDebug(E.Message);
        on E: TIntegrityError do
          SendDebug(E.Message);
        on E: Exception do
          MessageBox(0, PChar('Code Completion Error: ' + E.Message), 'wxDev-C++ Code Completion',
                     MB_ICONSTOP or MB_OK or MB_APPLMODAL);
      end;
    end;

    DataSource.Commit;
  finally
    if DataSource.isTransactionOpen then
      DataSource.Rollback;
    DataLock.Release;
    Header.Free;
    ClassDecl.Free;
    EnumDecl.Free;
    FunctionDecl.Free;
    ClassMembers.Free;
  end;
end;

//TODO: lowjoel: modifiers list not used.
function TParseThread.ProcessFunction(Header, ClassMembers, FunctionDecl: TRegExpr;
                                      Definition: Boolean): Int64;
const
  FunctionSQL: string     = 'INSERT INTO Functions (ID, Returns, Prototype, Modifiers) VALUES ' +
                           '(%d, %d, ''%s'', %d);';
  LocationSQL: string     = 'INSERT INTO Locations (ID, ImplementationFile, ImplementationLine, ' +
                            'DeclarationFile, DeclarationLine) VALUES (%d, ''%s'', %s, ''%s'', %s);';
  ImplLocationSQL: string = 'UPDATE Locations SET ImplementationFile=''%s'', ImplementationLine=%s ' +
                            'WHERE ID=%d;';
var
  NewOverload: Boolean;
  ReturnType: string;
  Table: TSQLiteTable;
  Scope: Int64;

  procedure InsertPrototype(ID, Scope, Returns: Int64; Prototype: string; Modifiers: Integer;
                            ImplementationFile: string; ImplementationLine: string);
  begin
    DataSource.ExecSQL(Format(FunctionSQL, [ID, Returns, FunctionDecl.Match[1], 0]));
    DataSource.ExecSQL(Format(ImplLocationSQL, [ImplementationFile, ImplementationLine, ID]));

    if Scope <> -1 then
    begin
      //These functions are in classes, so they have a THIS pointer. Account for it.
      InsertIdentifier('this', ID, itVariable, 'access:public', ImplementationFile,
                       StrToIntDef(ImplementationLine, -1));
      DataSource.ExecSQL(Format('INSERT INTO Variables (ID, Datatype, Pointer, Modifiers) ' +
                                'VALUES (%d, %d, %d, 0)',
                                [DataSource.GetLastInsertRowID, Scope, Integer(ptPointer)]));
    end;
  end;
begin
  //Firstly find the class this function is in
  {Scope := DataSource.GetTableValue('SELECT ID FROM Identifiers WHERE Name=''' +
                                    ClassMembers.Match[2] + ''' AND Type=' +
                                    IntToStr(Integer(itClass)));}
  Scope := Parser.FindIdentifierID(ClassMembers.Match[2], [itClass, itStructure, itUnion, itNamespace]);
  if (Scope = -1) and (ClassMembers.Match[2] <> '') then
  begin
    {DataSource.Commit;
    asm int 3; end;
    DataSource.BeginTransaction;}
//DELETE FROM IDENTIFIERS; DELETE FROM VARIABLES; DELETE FROM LOCATIONS; DELETE FROM FUNCTIONS; DELETE FROM INHERITANCE; VACUUM;    
  end;

  //Then determine if we have any other overloads for this function
  Table := DataSource.GetTable('SELECT ID FROM Identifiers WHERE Name=''' +
                               Header.Match[1] + ''' AND Type=' + IntToStr(Integer(itFunction)) +
                               ' AND Scope=' + IntToStr(Scope));
  ReturnType := GetBaseDataType(Header.Match[3]);
  NewOverload := (not Table.Eof) and
                 (DataSource.GetTableValue('SELECT COUNT(*) FROM Functions WHERE ID=' +
                                           IntToStr(Table.FieldAsInteger(0)) + ' AND Prototype=''' +
                                           FunctionDecl.Match[1] + '''') = 0);

  if Table.EOF or NewOverload then
  begin
    InsertIdentifier(Header.Match[1], Scope, itFunction, ClassMembers.Match[4],
                     Header.Match[2], StrToInt(Header.Match[5]));
    Result := DataSource.GetLastInsertRowID;
    if Definition then
      InsertPrototype(Result, Scope, FindIdentifierID(ReturnType), FunctionDecl.Match[1],
                      0, Header.Match[2], Header.Match[5])
    else
      InsertPrototype(Result, Scope, FindIdentifierID(ReturnType), FunctionDecl.Match[1],
                      0, 'NULL', 'NULL');
  end
  else
  begin
    Result := Table.FieldAsInteger(0);
    if Definition then
    begin
      DataSource.ExecSQL(Format(ImplLocationSQL, [Header.Match[2], Header.Match[5],
                                                  Result]));
      try
      DataSource.ExecSQL(Format(ImplLocationSQL, [Header.Match[2], Header.Match[5],
          DataSource.GetTableValue('SELECT ID FROM Identifiers WHERE Name=''this'' AND ' +
                                   'Scope=' + IntToStr(Result))]));
      except
        on E: Exception do
          asm int 3; end;
      end;
    end;
  end;

  Table.Free;
end;

//TParseThread synchronizations functions (mainly event handlers)
procedure TParseThread.OnFileProgress;
begin
  Parser.OnFileProgress(Parser, (SyncMarshal as TParseThreadProgressMarshal).FileName,
                        (SyncMarshal as TParseThreadProgressMarshal).Total,
                        (SyncMarshal as TParseThreadProgressMarshal).Current);
end;

procedure TParseThread.OnTotalProgress;
begin
  Parser.OnTotalProgress(Parser, (SyncMarshal as TParseThreadProgressMarshal).FileName,
                        (SyncMarshal as TParseThreadProgressMarshal).Total,
                        (SyncMarshal as TParseThreadProgressMarshal).Current);
end;

procedure TParseThread.OnStartParsing;
begin
  Parser.OnStartParsing(Parser);
end;

procedure TParseThread.OnEndParsing;
begin
  Parser.OnEndParsing(Parser);
end;

end.
