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

unit debugger;

interface

uses
  Sysutils, Classes, debugwait, version, editor,
{$IFDEF WIN32}
  Windows, ShellAPI, Dialogs, Controls, ComCtrls;
{$ENDIF}
{$IFDEF LINUX}
  QDialogs, QControls, debugwait, QComCtrls;
{$ENDIF}

type
  AssemblySyntax = (asATnT, asIntel);
  TRegisters = class
    EAX: string;
    EBX: string;
    ECX: string;
    EDX: string;
    ESI: string;
    EDI: string;
    EBP: string;
    ESP: string;
    EIP: string;
    CS: string;
    DS: string;
    SS: string;
    ES: string;
  end;

  PBreakpoint = ^TBreakpoint;
  TBreakpoint = class
  public
    Index: integer;
    Editor: TEditor;
    Filename: string;
    Line: integer;
  end;

  PStackFrame = ^TStackFrame;
  TStackFrame = packed record
    Filename: string;
    Line: integer;
    FuncName: string;
    Args: string;
  end;

  PCommand = ^TCommand;
  TCommand = class
  public
    Command: String;
    Callback: procedure of object;
  end;

  PCommandWithResult = ^TCommandWithResult;
  TCommandWithResult = class(TCommand)
  public
    constructor Create;
    destructor Destroy; override;
  public
    Event: THandle;
    Result: TStringList;
  end;

  PVariable = ^TVariable;
  TVariable = packed record
    Name: string;
    Value: string;
    Location: string;
  end;

  PWatch = ^TWatch;
  TWatch = packed record
    Name: string;
    Address: string;
  end;

  TDebugger = class
    constructor Create; virtual;
    destructor Destroy; override;

  protected
    fBusy: Boolean;
    fPaused: Boolean;
    fExecuting: Boolean;
    fDebugTree: TTreeView;
    fBreakpoints: TList;

    CommandQueue: TList;
    FileName: string;
    hInputWrite: THandle;
    hOutputRead: THandle;
    hPid: THandle;
    Event: THandle;
    Wait: TDebugWait;
    Reader: TDebugReader;
    CurrentCommand: TCommand;

    //These functions pass the debugger output to individual functions
    function GetOutputOfCommand(command: TCommand): TStringList; overload;
    function GetOutputOfCommand(command, param: string): TStringList; overload;

    procedure DisplayError(s: string);
    function GetBreakpointFromIndex(index: integer): TBreakpoint;
    function GetLocals: TList; virtual; abstract;
    function GetCallStack: TList; virtual; abstract;
    function GetRegisters: TRegisters; virtual; abstract;
    function GetDisassembly: string; virtual; abstract;
    function GetWatchValue: string; virtual;
    function GetWatchVar: string; virtual;

    procedure Launch(hChildStdOut, hChildStdIn, hChildStdErr: THandle); virtual; abstract;
    procedure OnOutput(Output: string); virtual; abstract;
    procedure SendCommand; virtual;

    //I don't know what these do... yet
    procedure OnDebugFinish(Sender: TObject);
    procedure OnNoDebuggingSymbolsFound;
    procedure OnSourceMoreRecent;
    procedure OnAccessViolation;

  published
    property Busy: Boolean read fBusy;
    property Locals: TList read GetLocals;
    property CallStack: TList read GetCallStack;
    property Disassembly: string read GetDisassembly;
    property Registers: TRegisters read GetRegisters;

    property Breakpoints: TList read fBreakpoints;
    property Executing: Boolean read fExecuting;
    property Paused: Boolean read fPaused;

    property WatchVar: string read GetWatchVar;
    property WatchValue: string read GetWatchValue;
    property DebugTree: TTreeView read fDebugTree write fDebugTree;

  public
    //Debugger basics
    procedure Execute(filename: string);
    procedure SetAssemblySyntax(syntax: AssemblySyntax); virtual; abstract;
    procedure QueueCommand(command, params: String); overload; virtual;
    procedure QueueCommand(command: TCommand); overload; virtual;

    //Breakpoint handling
    procedure AddBreakpoint(breakpoint: TBreakpoint); virtual; abstract;
    procedure RemoveBreakpoint(breakpoint: TBreakpoint); virtual; abstract;
    procedure RemoveAllBreakpoints; virtual;
    procedure RefreshBreakpoints;
    procedure RefreshBreakpoint(var breakpoint: TBreakpoint); virtual; abstract;
    function BreakpointExists(filename: string; line: integer): boolean;

    //Debugger control funtions
    procedure Go; virtual; abstract;
    procedure Pause; virtual; abstract;
    procedure Next; virtual; abstract; //fDebugger.SendCommand(GDB_NEXT, '');
    procedure Step; virtual; abstract; //fDebugger.SendCommand(GDB_STEP, '');
    function Disassemble(func: string): string; virtual; abstract;
    function GetVariableHint(name: string): string; virtual; abstract; //fDebugger.SendCommand(GDB_DISPLAY, fCurrentHint);

    //Source lookup directories
    procedure AddIncludeDir(s: string); virtual; abstract;
    procedure ClearIncludeDirs; virtual; abstract;

    //Variable watches
    procedure RefreshContext; virtual; abstract;
    procedure AddWatch(varname: string); virtual; abstract;
    procedure RemoveWatch(varname: string); virtual; abstract;
    procedure ModifyVariable(varname, newvalue: string); virtual; abstract;

    //Havn't looked at these
    procedure CloseDebugger(Sender: TObject);
    function WaitForIdle: Boolean;
    function Idle: Boolean;
  end;

  TCDBDebugger = class(TDebugger)
    constructor Create; override;
    destructor Destroy; override;

  protected
    IncludeDirs: TStringList;

    //Transfer variables (from parsing to request)
    Disassembly: String;

  protected
    procedure Launch(hChildStdOut, hChildStdIn, hChildStdErr: THandle); override;
    function GetLocals: TList; override;
    function GetCallStack: TList; override;
    function GetRegisters: TRegisters; override;
    function GetDisassembly: string; override;

    //Output parsing
    procedure OnOutput(Output: string); override;

  public
    //Set the include paths
    procedure AddIncludeDir(s: string); override;
    procedure ClearIncludeDirs; override;

    //Override the breakpoint handling
    procedure AddBreakpoint(breakpoint: TBreakpoint); override;
    procedure RemoveBreakpoint(breakpoint: TBreakpoint); override;
    procedure RefreshBreakpoint(var breakpoint: TBreakpoint); override;

    //Variable watches
    procedure RefreshContext; override;
    procedure AddWatch(varname: string); override;
    procedure RemoveWatch(varname: string); override;

    //Debugger control
    procedure Go; override;
    procedure OnGo;
    procedure Pause; override;
    procedure Next; override;
    procedure Step; override;
    function Disassemble(func: string): string; override;
    function GetVariableHint(name: string): string; override;
  end;

implementation

uses 
  main, devcfg, MultiLangSupport, cpufrm, prjtypes, StrUtils, dbugintf, RegExpr,
  madstacktrace, Forms, utils;

constructor TCommandWithResult.Create;
begin
  Event := CreateEvent(nil, false, false, nil);
  Result := TStringList.Create;
end;

destructor TCommandWithResult.Destroy;
begin
  CloseHandle(Event);
  Result.Free;
end;

constructor TDebugger.Create;
begin
  fBreakpoints := TList.Create;
  CommandQueue := TList.Create;
  fExecuting := False;
  fBusy := False;

  FileName := '';
  Event := CreateEvent(nil, false, false, nil);
end;

destructor TDebugger.Destroy;
begin
  if (Executing) then
    CloseDebugger(nil);
  CloseHandle(Event);
  RemoveAllBreakpoints;
  
  fBreakpoints.Free;
  CommandQueue.Free;
  inherited Destroy;
end;

function TDebugger.WaitForIdle: boolean;
var
  I : integer;
begin
  I := 0;
  Result := false;
  while not Reader.Idle do
  begin
    Sleep(20);
    I := I + 1;
    if (i = 200) then begin
      MessageDlg('Timeout elapsed while waiting for previous debugger command to complete.'#10#13#10#13 +
                 'Check if the debugger has hung.', mtError, [mbOK], MainForm.Handle);
      Reader.Idle := True;
      Result := true;
    end;
  end;
end;

function TDebugger.Idle: boolean;
begin
  result := Reader.Idle;
end;

procedure TDebugger.Execute(filename: string);
var
  hOutputReadTmp, hOutputWrite,
  hInputWriteTmp, hInputRead,
  hErrorWrite: THandle;
  sa: TSecurityAttributes;
begin
  fExecuting := true;
  self.FileName := filename;
  
  // Set up the security attributes struct.
  sa.nLength := sizeof(TSecurityAttributes);
  sa.lpSecurityDescriptor := nil;
  sa.bInheritHandle := true;

  // Create the child output pipe.
  if (not CreatePipe(hOutputReadTmp, hOutputWrite, @sa, 0)) then
    DisplayError('CreatePipe');

  // Create a duplicate of the output write handle for the std error
  // write handle. This is necessary in case the child application
  // closes one of its std output handles.
  if (not DuplicateHandle(GetCurrentProcess(), hOutputWrite,
    GetCurrentProcess(), @hErrorWrite, 0,
    true, DUPLICATE_SAME_ACCESS)) then
    DisplayError('DuplicateHandle');

  // Create the child input pipe.
  if (not CreatePipe(hInputRead, hInputWriteTmp, @sa, 0)) then
    DisplayError('CreatePipe');

  // Create new output read handle and the input write handles.
  // The Properties are set to FALSE, otherwise the child inherits the
  // properties and as a result non-closeable handles to the pipes
  // are created.
  if (not DuplicateHandle(GetCurrentProcess(), hOutputReadTmp,
    GetCurrentProcess(), @hOutputRead, // Address of new handle.
    0, false, // Make it uninheritable.
    DUPLICATE_SAME_ACCESS)) then
    DisplayError('DuplicateHandle');

  if (not DuplicateHandle(GetCurrentProcess(), hInputWriteTmp,
    GetCurrentProcess(), @hInputWrite, // Address of new handle.
    0, false, // Make it uninheritable.
    DUPLICATE_SAME_ACCESS)) then
    DisplayError('DupliateHandle');

  // Close inheritable copies of the handles you we not want to be
  // inherited.
  if (not CloseHandle(hOutputReadTmp)) then
    DisplayError('CloseHandle');
  if (not CloseHandle(hInputWriteTmp)) then
    DisplayError('CloseHandle');

  Launch(hOutputWrite, hInputRead, hErrorWrite);

  // Close pipe handles (do not continue to modify the parent).
  // Make sure that no handles of the
  // output pipe are maintained in this process or else the pipe will
  // not close when the child process exits and the ReadFile will hang.
  if (not CloseHandle(hOutputWrite)) then
    DisplayError('CloseHandle');
  if (not CloseHandle(hInputRead)) then
    DisplayError('CloseHandle');
  if (not CloseHandle(hErrorWrite)) then
    DisplayError('CloseHandle');

  // Create a thread that will read the child's output.
  Reader := TDebugReader.Create(true);
  Reader.hPipeRead := hOutputRead;
  Reader.EventReady := Event;
  Reader.OnTerminate := CloseDebugger;
  Reader.FreeOnTerminate := True;
  Reader.Idle := True;
  InitializeCriticalSection(Reader.OutputCrit);

  // Create a thread that will notice when an output is ready to be sent for processing
  Wait := TDebugWait.Create(true);
  Wait.OnOutput := OnOutput;
  Wait.Reader := Reader;
  Wait.Event := Event;
  Wait.Resume;
  Reader.Resume;
end;

procedure TDebugger.DisplayError(s: string);
begin
  MessageDlg('Error with debugging process: ' + s, mtError, [mbOK], Mainform.Handle);
end;

procedure TDebugger.CloseDebugger(Sender: TObject);
begin
  if Executing then begin
    fPaused := false;
    fExecuting := false;

    // Force the read on the input to return by closing the stdin handle.
    Wait.Stop := True;
    SetEvent(Event);
    TerminateProcess(hPid, 0);
    Wait.Terminate;
    Wait := nil;
    Reader.Terminate;
    Reader := nil;

    //Close the handles
    if (not CloseHandle(hPid)) then
      DisplayError('CloseHandle - gdb process');
    if (not CloseHandle(hOutputRead)) then
      DisplayError('CloseHandle - output read');
    if (not CloseHandle(hInputWrite)) then
      DisplayError('CloseHandle - input write');
    MainForm.RemoveActiveBreakpoints;

    //Clear the command queue
    CommandQueue.Clear;
  end;
end;

procedure TDebugger.QueueCommand(command, params: String);
var
  Combined: String;
  Cmd: TCommand;
begin
  //Combine the strings to get the final command
  Combined := command;
  if Length(params) > 0 then
    Combined := Combined + ' ' + params;

  //Create the command object
  Cmd := TCommand.Create;
  Cmd.Command := Combined;
  Cmd.Callback := nil;
  QueueCommand(Cmd);
end;

procedure TDebugger.QueueCommand(command: TCommand);
var
  Ptr: PCommand;
begin
  //Copy the object
  New(Ptr);
  Ptr^ := command;
  Command.Command := Command.Command + #10;

  //Add it into our list of commands
  CommandQueue.Add(Ptr);

  //Can we execute the command now?
  if Executing and Paused then
    SendCommand;
end;

procedure TDebugger.SendCommand;
var
  Str: array[0..512] of char;
  nBytesWrote, Copied: DWORD;
  I, CommandLength: UInt;
const
  StrSize = 511;
begin
  //Do we have anything left? Are we paused?
  if (CommandQueue.Count = 0) or (not Paused) then
    Exit;
  
  //Initialize stuff
  Copied := 0;
  CurrentCommand := PCommand(CommandQueue[0])^;
  CommandLength := Length(CurrentCommand.Command);

  //Remove the entry from the list
  if not (CurrentCommand is TCommandWithResult) then
    Dispose(CommandQueue[0]);
  CommandQueue.Delete(0);

  //Write the command to the pipe, sequentially
  repeat
    //Copy the current string to as much as our buffer allows
    I := 0;
    while (I < StrSize) and (I + Copied < CommandLength) do
    begin
      Str[I] := CurrentCommand.Command[I + 1 + Copied];
      Inc(I);
    end;

    //Set the last character to be NULL
    Str[I] := #0;

    //Then write the block to the pipe
    if WriteFile(hInputWrite, Str, StrLen(Str), nBytesWrote, nil) then
    begin
      with MainForm.DebugOutput do
        Lines[Lines.Count - 1] := Lines[Lines.Count - 1] + Str;
      Inc(Copied, nBytesWrote);
    end
    else if (GetLastError() <> ERROR_NO_DATA) then
    begin
      DisplayError('WriteFile');
      Break;
    end;
  until Copied >= CommandLength;

  //Call the callback function if we are provided one
  if Assigned(CurrentCommand.Callback) then
    CurrentCommand.Callback;
end;

function TDebugger.GetOutputOfCommand(command: TCommand): TStringList;
var
  Ptr: PCommandWithResult;
begin
  //Copy the command
  New(Ptr);
  Ptr^ := TCommandWithResult.Create;
  Ptr^.Command := command.Command + #10;
  Ptr^.Callback := command.Callback;

  //Send the command to the debugger
  fBusy := True;
  CommandQueue.Add(Ptr);
  if Executing and Paused then
    SendCommand;

  //Wait for the event
  while WaitForSingleObject(Ptr^.Event, 20) = WAIT_TIMEOUT do
    Application.ProcessMessages;
  Result := Ptr^.Result;
  Dispose(Ptr);
end;

function TDebugger.GetOutputOfCommand(command, param: string): TStringList;
var
  Cmd: TCommand;
begin
  Cmd := TCommand.Create;
  Cmd.Command := command + ' ' + param;
  Cmd.Callback := nil;
  Result := GetOutputOfCommand(Cmd);
end;

procedure TDebugger.OnDebugFinish(Sender: TObject);
begin
  if Executing then
    CloseDebugger(sender);
end;

procedure TDebugger.OnNoDebuggingSymbolsFound;
var
  opt: TCompilerOption;
  idx: integer;
  spos: integer;
  opts: TProjProfile;
begin
  CloseDebugger(nil);
  //Todo: lowjoel: Add multiple-compiler support
  if (MessageDlg(Lang[ID_MSG_NODEBUGSYMBOLS], mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    if devCompiler.FindOption('-g3', opt, idx) then begin
      opt.optValue := 1;
      if not Assigned(MainForm.fProject) then
        devCompiler.Options[idx]:=opt; // set global debugging option only if not working with a project

      MainForm.SetProjCompOpt(idx, True); // set the project's correpsonding option too

      // remove "-s" from the linker''s command line
      if Assigned(MainForm.fProject) then begin
        opts := MainForm.fProject.CurrentProfile;
        // look for "-s" in all the possible ways
        // NOTE: can't just search for "-s" because we might get confused with
        //       some other option starting with "-s...."
        spos := Pos('-s ', opts.Linker); // following more opts
        if spos = 0 then
          spos := Pos('-s'#13, opts.Linker); // end of line
        if spos = 0 then
          spos:=Pos('-s_@@_', opts.Linker); // end of line (dev 4.9.7.3+)
        if (spos = 0) and
          (Length(opts.Linker) >= 2) and // end of string
           (Copy(opts.Linker, Length(opts.Linker)-1, 2) = '-s') then
          spos := Length(opts.Linker) - 1;
        // if found, delete it
        if spos>0 then begin
          Delete(opts.Linker, spos, 2);
          MainForm.fProject.CurrentProfile.CopyProfileFrom(opts);
        end;
      end;
      if devCompiler.FindOption('-s', opt, idx) then begin
        opt.optValue := 0;
        if not Assigned(MainForm.fProject) then
          devCompiler.Options[idx]:=opt; // set global debugging option only if not working with a project
        MainForm.SetProjCompOpt(idx, False); // set the project's correpsonding option too
      end;
      MainForm.actRebuildExecute(nil);
    end;
  end;
end;

//Todo: lowjoel: This isn't referenced anywhere...
procedure TDebugger.OnSourceMoreRecent;
begin
  if (MessageDlg(Lang[ID_MSG_SOURCEMORERECENT], mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    CloseDebugger(nil);
    MainForm.actCompileExecute(nil);
  end;
end;

procedure TDebugger.OnAccessViolation;
begin
  case MessageDlg(Lang[ID_MSG_SEGFAULT], mtError, [mbYes, mbNo, mbAbort], MainForm.Handle) of
    mrNo: Go;
    mrAbort: CloseDebugger(nil);
  end;
end;

function TDebugger.BreakpointExists(filename: string; line: integer): Boolean;
var
  I: integer;
begin
  Result := False;
  for I := 0 to Breakpoints.Count - 1 do
    if (PBreakpoint(Breakpoints[I])^.Filename = filename) and
       (PBreakpoint(Breakpoints[I])^.Line = line) then
    begin
      Result := true;
      Break;
    end;
end;

procedure TDebugger.RemoveAllBreakpoints;
var
  I: integer;
begin
  for I := 0 to Breakpoints.Count - 1 do
    RemoveBreakpoint(Breakpoints[I]);
end;

procedure TDebugger.RefreshBreakpoints;
var
  I: Integer;
begin
  for I := 0 to Breakpoints.Count - 1 do
    RefreshBreakpoint(PBreakPoint(Breakpoints.Items[I])^);
end;

function TDebugger.GetBreakpointFromIndex(index: integer): TBreakpoint;
var
  I: integer;
begin
  Result := nil;
  for I := 0 to fBreakpoints.Count - 1 do
    if PBreakpoint(fBreakpoints[I])^.Index = index then
    begin
      Result := PBreakpoint(fBreakpoints[I])^;
      Exit;
    end;
end;

function TDebugger.GetWatchValue: string;
begin
{  if Assigned(Wait) then
    Result := Wait.tmpWatchValue
  else}
    Result := '';
end;

function TDebugger.GetWatchVar: string;
begin
{  if Assigned(Wait) then
    Result := Wait.tmpWatchVar
  else}
    Result := '';
end;

//------------------------------------------------------------------------------
// TCDBDebugger
//------------------------------------------------------------------------------
constructor TCDBDebugger.Create;
begin
  inherited;
  IncludeDirs := TStringList.Create;
end;

destructor TCDBDebugger.Destroy;
begin
  IncludeDirs.Free;
  inherited;
end;

procedure TCDBDebugger.Launch(hChildStdOut, hChildStdIn, hChildStdErr: THandle);
var
  ProcessInfo: TProcessInformation;
  StartupInfo: TStartupInfo;
  Executable: string;
  Srcpath: string;
  I: Integer;
begin
  //Set up the start up info structure.
  FillChar(StartupInfo, sizeof(TStartupInfo), 0);
  StartupInfo.cb := sizeof(TStartupInfo);
  StartupInfo.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
  StartupInfo.hStdOutput := hChildStdOut;
  StartupInfo.hStdInput := hChildStdIn;
  StartupInfo.hStdError := hChildStdErr;
  StartupInfo.wShowWindow := SW_HIDE;

  //Get the name of the debugger
  if (devCompiler.gdbName <> '') then
    Executable := devCompiler.gdbName
  else
    Executable := DBG_PROGRAM(devCompiler.CompilerType);

  //Strip the beginning and trailing " so we can deal with the path more easily
  if (Filename[1] = '"') and (Filename[Length(Filename)] = '"') then
    Filename := Copy(Filename, 2, Length(Filename) - 2);

  //Create the command line
  Executable := Format('%s -lines -2 -y "%s" "%s"', [Executable, ExtractFilePath(Filename), FileName]);

  //Launch the process
  if not CreateProcess(nil, PChar(Executable), nil, nil, True, CREATE_NEW_CONSOLE,
                       nil, nil, StartupInfo, ProcessInfo) then
  begin
    DisplayError('Could not find program file ' + Executable);
    Exit;
  end;

  //Send the source mode setting (enable all except ONLY source)
  QueueCommand('l+t; l+l; l+s', '');

  //Set all the paths
  Srcpath := ExtractFilePath(Filename) + ';';
  for I := 0 to IncludeDirs.Count - 1 do
    Srcpath := Srcpath + IncludeDirs[I] + ';';
  QueueCommand('.srcpath+', Srcpath);
  QueueCommand('.exepath+', ExtractFilePath(Filename));

  //Get the PID of the new process
  hPid := ProcessInfo.hProcess;

  //Close any unnecessary handles.
  if (not CloseHandle(ProcessInfo.hThread)) then
    DisplayError('CloseHandle');
end;

procedure TCDBDebugger.OnOutput(Output: string);
var
  RegExp: TRegExpr;
  CurLine: String;
  CurOutput: TStringList;
  SentCommand: Boolean;

  procedure ParseOutput(const line: string);
  begin
    if (not SentCommand) and RegExp.Exec(line, '^([0-9]+):([0-9]+)>') then
    begin
      //The debugger is waiting for input, we're paused!
      fPaused := True;
      fBusy := False;

      //Because we are here, we probably are a side-effect of a previous instruction
      //If we have to redirect the output (somewhere) do so!
      if Assigned(CurrentCommand) then
        if CurrentCommand is TCommandWithResult then
        begin
          TCommandWithResult(CurrentCommand).Result.Assign(CurOutput);
          SetEvent(TCommandWithResult(CurrentCommand).Event);
        end;
      CurOutput.Clear;

      //Send the command, and do not send any more
      SendCommand;
      SentCommand := True;

      //Make sure we don't save the current line!
      Exit;
    end
    else if RegExp.Exec(line, 'Symbol search path is: (.*)') then
    begin
      if RegExp.Substitute('$1') = '*** Invalid ***' then
        OnNoDebuggingSymbolsFound;
    end
    else if RegExp.Exec(line, '\((.*)\): Access violation - code c0000005 \((.*)\)') then
      OnAccessViolation
    else if RegExp.Exec(line, 'Breakpoint ([0-9]+) hit') then
      with GetBreakpointFromIndex(StrToInt(RegExp.Substitute('$1'))) do
        MainForm.GotoBreakpoint(Filename, Line);

    CurOutput.Add(Line);
  end;
begin
  //Update the memo
  SentCommand := False;
  CurOutput := TStringList.Create;
  RegExp := TRegExpr.Create;
  while Pos(#10, Output) > 0 do
  begin
    //Extract the current line
    CurLine := Copy(Output, 0, Pos(#10, Output) - 1);

    //Process the output
    MainForm.DebugOutput.Lines.Add(CurLine);
    ParseOutput(CurLine);

    //Remove those that we've already processed
    Delete(Output, 1, Pos(#10, Output));
  end;

  if Length(Output) > 0 then
  begin
    MainForm.DebugOutput.Lines.Add(Output);
    ParseOutput(Output);
  end;

  //Clean up
  RegExp.Free;
  CurOutput.Free;
end;

procedure TCDBDebugger.AddIncludeDir(s: string);
begin
  IncludeDirs.Add(s);
end;

procedure TCDBDebugger.ClearIncludeDirs;
begin
  IncludeDirs.Clear;
end;

procedure TCDBDebugger.AddBreakpoint(breakpoint: TBreakpoint);
var
  aBreakpoint: PBreakpoint;
begin
  if (not Paused) and Executing then
  begin
    MessageDlg('Cannot add a breakpoint while the debugger is executing.', mtError, [mbOK], MainForm.Handle);
    Exit;
  end;

  New(aBreakpoint);
  aBreakpoint^ := breakpoint;
  fBreakpoints.Add(aBreakpoint);
  RefreshBreakpoint(aBreakpoint^);
end;

procedure TCDBDebugger.RemoveBreakpoint(breakpoint: TBreakpoint);
var
  I: Integer;
begin
  if (not Paused) and Executing then
  begin
    MessageDlg('Cannot remove a breakpoint while the debugger is executing.', mtError, [mbOK], MainForm.Handle);
    Exit;
  end;

  for i := 0 to Breakpoints.Count - 1 do
  begin
    if (PBreakPoint(Breakpoints.Items[i])^.line = breakpoint.Line) and (PBreakPoint(Breakpoints.Items[i])^.editor = breakpoint.Editor) then
    begin
      if Executing then
        QueueCommand('bc', IntToStr(PBreakpoint(Breakpoints.Items[i])^.Index));
      Dispose(Breakpoints.Items[i]);
      Breakpoints.Delete(i);
      Break;
    end;
  end;
end;

procedure TCDBDebugger.RefreshBreakpoint(var breakpoint: TBreakpoint);
begin
  if Executing then
  begin
    if fBreakpoints.Count > 1 then
      breakpoint.Index := PBreakpoint(fBreakpoints[fBreakpoints.Count - 2])^.Index + 1
    else
      breakpoint.Index := fBreakpoints.Count;
    QueueCommand('bp' + IntToStr(breakpoint.Index), '`' + breakpoint.Filename + ':' + IntToStr(breakpoint.Line) + '`');
  end;
end;

procedure TCDBDebugger.RefreshContext;
var
  Output: TStringList;
  RegExp: TRegExpr;
  Node: TTreeNode;
  I, J: Integer;

  procedure ParseStructure(Output: TStringList; ParentNode: TTreeNode);
  const
    VariableExpr = '( +)\+0x([0-9a-fA-F]{1,8}) ([^ ]*)?( +): (.*)';
  var
    SubStructure: TStringList;
    Indent: Integer;
    I: Integer;
  begin
    I := 0;
    Indent := 0;
    while I < Output.Count do
    begin
      if RegExp.Exec(Output[I], VariableExpr) then
      begin
        if Indent = 0 then
          Indent := Length(RegExp.Substitute('$1'));

        //Check if this is a sub-structure
        if Indent <> Length(RegExp.Substitute('$1')) then
        begin
          //Populate the substructure string list
          SubStructure := TStringList.Create;
          while I < Output.Count do
          begin
            if RegExp.Exec(Output[I], VariableExpr) then
              if Length(RegExp.Substitute('$1')) = Indent then
                Break
              else
                SubStructure.Add(Output[I]);
            Inc(I);
          end;

          //Process it
          with ParentNode.Item[ParentNode.Count - 1] do
          begin
            SelectedIndex := 39;
            ImageIndex := 39;
          end;
          ParseStructure(SubStructure, ParentNode.Item[ParentNode.Count - 1]);
          SubStructure.Free;

          //Decrement I, since we will increment one at the end of the loop
          Dec(I);
        end
        
        //Otherwise just add the value
        else
          with DebugTree.Items.AddChild(ParentNode, RegExp.Substitute('$3 = $5')) do
          begin
            SelectedIndex := 32;
            ImageIndex := 32;
          end;
      end;

      //Increment I
      Inc(I);
    end;
  end;
begin
  if not Executing then
    Exit;

  RegExp := TRegExpr.Create;
  if Assigned(DebugTree) then
    for I := 0 to DebugTree.Items.Count - 1 do
    begin
      Node := DebugTree.Items[I];
      with PWatch(Node.Data)^ do
      begin
        //Decide what command we should send - dv for locals, dt for structures
        if Pos('.', Name) > 0 then
        begin
          //Issue the command
          Output := GetOutputOfCommand('dt', '-r ' + Copy(name, 1, Pos('.', name) - 1));

          //Set the type of the structure/class/whatever
          if RegExp.Exec(Output[0], '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*)') then
            Node.Text := RegExp.Substitute(Copy(name, 1, Pos('.', name) - 1) + ' = $4 (0x$3)');

          //Then find the member name
          Node.DeleteChildren;
          ParseStructure(Output, Node);
        end
        else
        begin
          Output := GetOutputOfCommand('dv', name);
          for J := 0 to Output.Count - 1 do
            if RegExp.Exec(Output[J], '( +)' + name + ' = (.*)') then
              Node.Text := Trim(Output[J]);
        end;

        Output.Free;
      end;
    end;

  //Clean up
  RegExp.Free;
end;

procedure TCDBDebugger.AddWatch(varname: string);
var
  Watch: PWatch;
begin
  with DebugTree.Items.Add(nil, varname + ' = (unknown)') do
  begin
    ImageIndex := 21;
    SelectedIndex := 21;
    New(Watch);
    Watch^.Name := varname;
    Data := Watch;
  end;
end;

procedure TCDBDebugger.RemoveWatch(varname: string);
var
  node: TTreeNode;
begin
  //Find the top-most node
  node := DebugTree.Selected;
  while Assigned(node) and (Assigned(node.Parent)) do
    node := node.Parent;

  //Then clean it up
  if Assigned(node) then
  begin
    Dispose(node.Data);
    DebugTree.Items.Delete(node);
  end;
end;

function TCDBDebugger.GetCallStack: TList;
var
  I: Integer;
  RegExp: TRegExpr;
  Output: TStringList;
  StackFrame: PStackFrame;
begin
  if (not Paused) or (not Executing) then
  begin
    Result := nil;
    Exit;
  end;

  Result := TList.Create;
  RegExp := TRegExpr.Create;
  Output := GetOutputOfCommand('kp', '256');
  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], 'ChildEBP RetAddr') then
      Continue
    else if RegExp.Exec(Output[I], '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!([^ ]*)\((.*)\)(|.*) \[(.*) @ ([0-9]*)\]') then
    begin
      //Stack frame with source information
      New(StackFrame);
      Result.Add(StackFrame);

      //Fill the fields
      with StackFrame^ do
      begin
        Filename := RegExp.Substitute('$7');
        Line := StrToInt(RegExp.Substitute('$8'));
        FuncName := RegExp.Substitute('$4$6');
        Args := RegExp.Substitute('$5');
      end;
    end
    else if RegExp.Exec(Output[I], '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!([^ ]*)(|\((.*)\))(.*)') then
    begin
      //Stack frame without source information
      New(StackFrame);
      Result.Add(StackFrame);

      //Fill the fields
      with StackFrame^ do
      begin
        FuncName := RegExp.Substitute('$4$6');
        Args := RegExp.Substitute('$5');
        Line := 0;
      end;
    end;

  //Clean up
  RegExp.Free;
  Output.Free;
end;

function TCDBDebugger.GetLocals: TList;
var
  I: Integer;
  Local: PVariable;
  RegExp: TRegExpr;
  Output: TStringList;
begin
  if (not Executing) or (not Paused) then
  begin
    Result := nil;
    Exit;
  end;

  Result := TList.Create;
  RegExp := TRegExpr.Create;
  Output := GetOutputOfCommand('dv', '/i /t /v');
  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], '(.*)( +)(.*)( +)([0-9a-fA-F]{1,8}) (.*) = (.*)') then
    begin
      New(Local);
      Result.Add(Local);

      //Fill the fields
      with Local^ do
      begin
        Name := RegExp.Substitute('$6');
        Value := RegExp.Substitute('$7');
        Location := RegExp.Substitute('$5');
      end;
    end;

  //Clean up
  RegExp.Free;
  Output.Free;
end;

function TCDBDebugger.GetRegisters: TRegisters;
var
  I: Integer;
  RegExp: TRegExpr;
  Output: TStringList;
begin
  if (not Executing) or (not Paused) then
  begin
    Result := nil;
    Exit;
  end;

  Result := TRegisters.Create;
  RegExp := TRegExpr.Create;
  Output := GetOutputOfCommand('r', '');
  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], 'eax=([0-9a-fA-F]{1,8}) ebx=([0-9a-fA-F]{1,8}) ecx=([0-9a-fA-F]{1,8}) edx=([0-9a-fA-F]{1,8}) esi=([0-9a-fA-F]{1,8}) edi=([0-9a-fA-F]{1,8})') then
      begin
        with Result do
        begin
          EAX := RegExp.Substitute('$1');
          EBX := RegExp.Substitute('$2');
          ECX := RegExp.Substitute('$3');
          EDX := RegExp.Substitute('$4');
          ESI := RegExp.Substitute('$5');
          EDI := RegExp.Substitute('$6');
        end;
      end
      else if RegExp.Exec(Output[I], 'eip=([0-9a-fA-F]{1,8}) esp=([0-9a-fA-F]{1,8}) ebp=([0-9a-fA-F]{1,8}) iopl=([0-9a-fA-F]{1,8})') then
      begin
        with Result do
        begin
          EIP := RegExp.Substitute('$1');
          ESP := RegExp.Substitute('$2');
          EBP := RegExp.Substitute('$3');
        end;
      end
      else if RegExp.Exec(Output[I], 'cs=([0-9a-fA-F]{1,4})  ss=([0-9a-fA-F]{1,4})  ds=([0-9a-fA-F]{1,4})  es=([0-9a-fA-F]{1,4})  fs=([0-9a-fA-F]{1,4})  gs=([0-9a-fA-F]{1,4})             efl=([0-9a-fA-F]{1,8})') then
      begin
        with Result do
        begin
          CS := RegExp.Substitute('$1');
          SS := RegExp.Substitute('$2');
          DS := RegExp.Substitute('$3');
          ES := RegExp.Substitute('$4');
        end;
      end;

  //Clean up
  RegExp.Free;
  Output.Free;
end;

function TCDBDebugger.GetDisassembly: string;
begin
  if (not Executing) or (not Paused) then
  begin
    Result := '';
    Exit;
  end;

  Result := Disassemble('');
end;

function TCDBDebugger.Disassemble(func: string): string;
var
  I: Integer;
  RegExp: TRegExpr;
  Output: TStringList;
begin
  if (not Executing) or (not Paused) then
  begin
    Result := '';
    Exit;
  end;

  RegExp := TRegExpr.Create;
  Output := GetOutputOfCommand('ub ' + func + ';u ' + func, '');
  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], '^(.*)!(.*) \[(.*) @ ([0-9]+)]:') then
      Result := Result + #9 + ';' + Output[I] + #10
    else if RegExp.Exec(Output[I], '^([0-9a-fA-F]{1,8})( +)([^ ]*)( +)(.*)( +)(.*)') then
      Result := Result + Output[I] + #10;

  //Clean up
  RegExp.Free;
  Output.Free;
end;

function TCDBDebugger.GetVariableHint(name: string): string;
var
  I, Depth: Integer;
  RegExp: TRegExpr;
  Output: TStringList;
begin
  if (not Executing) or (not Paused) then
  begin
    Result := '';
    Exit;
  end;

  //Decide what command we should send - dv for locals, dt for structures
  RegExp := TRegExpr.Create;
  if Pos('.', name) > 0 then
  begin
    //Remove the dots and count the number of indents
    Depth := 0;
    for I := 1 to Length(name) do
      if name[I] = '.' then
        Inc(Depth);

    //Issue the command
    Output := GetOutputOfCommand('dt', Copy(name, 1, Pos('.', name) - 1));

    //Then find the member name
    for I := 0 to Output.Count - 1 do
      if RegExp.Exec(Output[I], '( {' + IntToStr(Depth * 3) + '})\+0x([0-9a-fA-F]{1,8}) ' +
                     Copy(name, GetLastPos('.', name) + 1, Length(name)) + '( +): (.*)') then
        Result := RegExp.Substitute(name + ' = $4');
  end
  else
  begin
    Output := GetOutputOfCommand('dv', name);
    for I := 0 to Output.Count - 1 do
      if RegExp.Exec(Output[I], '( +)(.*) = (.*)') then
        Result := Trim(Output[I]);
  end;

  //Clean up
  RegExp.Free;
  Output.Free;
end;

procedure TCDBDebugger.Go;
var
  Command: TCommand;
begin
  Command := TCommand.Create;
  Command.Command := 'g';
  Command.Callback := OnGo;
  QueueCommand(Command);
end;

procedure TCDBDebugger.OnGo;
begin
  fPaused := False;
  fBusy := False;
end;

procedure TCDBDebugger.Pause;
begin
end;

procedure TCDBDebugger.Next;
begin
  QueueCommand('p', '');
end;

procedure TCDBDebugger.Step;
begin
  QueueCommand('t', '');
end;

end.
