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
  ContextData = (cdLocals, cdStackTrace, cdWatches);
  ContextDataSet = set of ContextData;
  TCallback = procedure(Output: TStringList) of object;
  
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
  TRegistersCallback = procedure(Registers: TRegisters) of object;

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
    Data: TObject;
    Command: String;
    Callback: procedure of object;
    OnResult: procedure(Output: TStringList) of object;
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
    fNextBreakpoint: Integer;
    IncludeDirs: TStringList;
    JumpToCurrentLine: Boolean;

    hInputWrite: THandle;
    hOutputRead: THandle;
    hPid: THandle;
    
    SentCommand: Boolean;
    CurrentCommand: TCommand;
    CommandQueue: TList;

    FileName: string;
    Event: THandle;
    Wait: TDebugWait;
    Reader: TDebugReader;
    CurOutput: TStringList;

    procedure DisplayError(s: string);
    function GetBreakpointFromIndex(index: integer): TBreakpoint;

    procedure Launch(arguments: string; hChildStdOut, hChildStdIn, hChildStdErr: THandle); virtual; abstract;
    procedure OnOutput(Output: string); virtual; abstract;
    procedure SendCommand; virtual;

    //Instruction callbacks
    procedure OnGo;

    //I don't know what these do... yet
    procedure OnNoDebuggingSymbolsFound;
    procedure OnAccessViolation;
    procedure OnBreakpoint;

  published
    property Busy: Boolean read fBusy;
    property Executing: Boolean read fExecuting;
    property Paused: Boolean read fPaused;
    property DebugTree: TTreeView read fDebugTree write fDebugTree;

  public
    //Callback functions
    OnVariableHint: procedure(Hint: string) of object;
    OnDisassemble: procedure(Disassembly: string) of object;
    OnRegisters: procedure(Registers: TRegisters) of object;
    OnCallStack: procedure(Callstack: TList) of object;
    OnLocals: procedure(Locals: TList) of object;

    //Debugger basics
    procedure Execute(filename, arguments: string);
    procedure CloseDebugger(Sender: TObject); virtual;
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
    procedure Next; virtual; abstract;
    procedure Step; virtual; abstract;
    procedure SetContext(frame: Integer); virtual; abstract;
    function GetVariableHint(name: string): string; virtual; abstract;

    //Source lookup directories
    procedure AddIncludeDir(s: string); virtual; abstract;
    procedure ClearIncludeDirs; virtual; abstract;

    //Variable watches
    procedure RefreshContext(refresh: ContextDataSet = [cdLocals, cdStackTrace, cdWatches]); virtual; abstract;
    procedure AddWatch(varname: string); virtual; abstract;
    procedure RemoveWatch(varname: string); virtual; abstract;
    procedure ModifyVariable(varname, newvalue: string); virtual; abstract;

    //Low-level stuff
    procedure GetRegisters; virtual; abstract;
    procedure Disassemble; overload;
    procedure Disassemble(func: string); overload; virtual; abstract;
  end;

  TCDBDebugger = class(TDebugger)
    constructor Create; override;
    destructor Destroy; override;

  protected
    IgnoreBreakpoint: Boolean;

  protected
    procedure Launch(arguments: string; hChildStdOut, hChildStdIn, hChildStdErr: THandle); override;
    procedure OnOutput(Output: string); override;

    //Instruction callbacks
    procedure OnTrace;

    //Parser callbacks
    procedure OnRefreshContext(Output: TStringList);
    procedure OnVariableHint(Output: TStringList);
    procedure OnDisassemble(Output: TStringList);
    procedure OnCallStack(Output: TStringList);
    procedure OnRegisters(Output: TStringList);
    procedure OnLocals(Output: TStringList);

  public
    //Set the include paths
    procedure AddIncludeDir(s: string); override;
    procedure ClearIncludeDirs; override;

    //Override the breakpoint handling
    procedure AddBreakpoint(breakpoint: TBreakpoint); override;
    procedure RemoveBreakpoint(breakpoint: TBreakpoint); override;
    procedure RefreshBreakpoint(var breakpoint: TBreakpoint); override;

    //Variable watches
    procedure RefreshContext(refresh: ContextDataSet = [cdLocals, cdStackTrace, cdWatches]); override;
    procedure AddWatch(varname: string); override;
    procedure RemoveWatch(varname: string); override;

    //Debugger control
    procedure Go; override;
    procedure Pause; override;
    procedure Next; override;
    procedure Step; override;
    procedure SetContext(frame: Integer); override;
    function GetVariableHint(name: string): string; override;

    //Low-level stuff
    procedure GetRegisters; override;
    procedure Disassemble(func: string); overload; override;
  end;

  TGDBDebugger = class(TDebugger)
    constructor Create; override;
    destructor Destroy; override;

  protected
    OverrideHandler: TCallback;
    RegistersFilled: Integer;
    Registers: TRegisters;
    Started: Boolean;

  protected
    procedure Launch(arguments: string; hChildStdOut, hChildStdIn, hChildStdErr: THandle); override;
    procedure OnOutput(Output: string); override;
    procedure OnSignal(Output: TStringList);
    procedure OnSourceMoreRecent;

    //Instruction callbacks
    procedure OnGo;
    procedure OnTrace;

    //Parser callbacks
    procedure OnRefreshContext(Output: TStringList);
    procedure OnVariableHint(Output: TStringList);
    procedure OnDisassemble(Output: TStringList);
    procedure OnCallStack(Output: TStringList);
    procedure OnRegisters(Output: TStringList);
    procedure OnLocals(Output: TStringList);

  public
    //Debugger control
    procedure CloseDebugger(Sender: TObject); override;

    //Set the include paths
    procedure AddIncludeDir(s: string); override;
    procedure ClearIncludeDirs; override;

    //Override the breakpoint handling
    procedure AddBreakpoint(breakpoint: TBreakpoint); override;
    procedure RemoveBreakpoint(breakpoint: TBreakpoint); override;
    procedure RefreshBreakpoint(var breakpoint: TBreakpoint); override;

    //Variable watches
    procedure RefreshContext(refresh: ContextDataSet = [cdLocals, cdStackTrace, cdWatches]); override;
    procedure AddWatch(varname: string); override;
    procedure RemoveWatch(varname: string); override;
    procedure ModifyVariable(varname, newvalue: string); override;

    //Debugger control
    procedure Go; override;
    procedure Pause; override;
    procedure Next; override;
    procedure Step; override;
    function GetVariableHint(name: string): string; override;

    //Low-level stuff
    procedure GetRegisters; override;
    procedure Disassemble(func: string); overload; override;
    procedure SetAssemblySyntax(syntax: AssemblySyntax); override;
  end;

var
  Breakpoints: TList;

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
  CurOutput := TStringList.Create;
  SentCommand := False;
  fNextBreakpoint := 0;
  fExecuting := False;
  fBusy := False;

  JumpToCurrentLine := False;
  CommandQueue := TList.Create;
  IncludeDirs := TStringList.Create;
  FileName := '';
  Event := CreateEvent(nil, false, false, nil);
end;

destructor TDebugger.Destroy;
begin
  if (Executing) then
    CloseDebugger(nil);
  CloseHandle(Event);
  RemoveAllBreakpoints; 

  CurOutput.Free;
  CommandQueue.Free;
  IncludeDirs.Free;
  inherited Destroy;
end;

procedure TDebugger.Execute(filename, arguments: string);
var
  hOutputReadTmp, hOutputWrite,
  hInputWriteTmp, hInputRead,
  hErrorWrite: THandle;
  sa: TSecurityAttributes;
begin
  //Strip the beginning and trailing " so we can deal with the path more easily
  if (Filename[1] = '"') and (Filename[Length(Filename)] = '"') then
    self.Filename := Copy(Filename, 2, Length(Filename) - 2)
  else
    self.FileName := filename;
  fExecuting := True;
  
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

  Launch(arguments, hOutputWrite, hInputRead, hErrorWrite);

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
      DisplayError('CloseHandle - process handle');
    if (not CloseHandle(hOutputRead)) then
      DisplayError('CloseHandle - output read');
    if (not CloseHandle(hInputWrite)) then
      DisplayError('CloseHandle - input write');
    MainForm.RemoveActiveBreakpoints;
    
    //Clear the command queue
    CommandQueue.Clear;
    CurrentCommand := nil;
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
  if (CommandQueue.Count = 0) or (not Paused) or Busy or SentCommand then
    Exit;
  
  //Initialize stuff
  Copied := 0;
  SentCommand := True;
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

procedure TDebugger.OnGo;
begin
  fPaused := False;
  fBusy := False;
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
  for I := 0 to Breakpoints.Count - 1 do
    if PBreakpoint(Breakpoints[I])^.Index = index then
    begin
      Result := PBreakpoint(Breakpoints[I])^;
      Exit;
    end;
end;

procedure TDebugger.OnAccessViolation;
begin
  Application.BringToFront;
  case MessageDlg(Lang[ID_MSG_SEGFAULT], mtError, [mbYes, mbNo, mbAbort], MainForm.Handle) of
    mrNo: Go;
    mrAbort: CloseDebugger(nil);
    mrYes: JumpToCurrentLine := True;
  end;
end;

procedure TDebugger.OnBreakpoint;
begin
  Application.BringToFront;
  case MessageDlg(Lang[ID_MSG_BREAKPOINT], mtError, [mbYes, mbNo, mbAbort], MainForm.Handle) of
    mrNo: Go;
    mrAbort: CloseDebugger(nil);
    mrYes: JumpToCurrentLine := True;
  end;
end;

procedure TDebugger.Disassemble;
begin
  Disassemble('');
end;

//------------------------------------------------------------------------------
// TCDBDebugger
//------------------------------------------------------------------------------
constructor TCDBDebugger.Create;
begin
  inherited;
end;

destructor TCDBDebugger.Destroy;
begin
  inherited;
end;

procedure TCDBDebugger.Launch(arguments: string; hChildStdOut, hChildStdIn, hChildStdErr: THandle);
var
  ProcessInfo: TProcessInformation;
  StartupInfo: TStartupInfo;
  Executable: string;
  Srcpath: string;
  I: Integer;
begin
  //Set this to true for CDB and WinDbg will have an initial process initialization
  //breakpoint. We do not want to raise false alarms when starting the debugger
  IgnoreBreakpoint := True;
  
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
  
  //Create the command line
  Executable := Format('%s -lines -2 -y "%s" "%s" %s', [Executable, ExtractFilePath(Filename), FileName, arguments]);

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

  procedure ParseError(const line: string);
  begin
    if RegExp.Exec(line, '\((.*)\): Access Violation - code c0000005 \((.*)\)') then
    begin
      JumpToCurrentLine := True;
      OnAccessViolation;
    end
    else if RegExp.Exec(line, '\((.*)\): Control-C exception - code 40010005 \((.*)\)') then
    else if RegExp.Exec(line, '\((.*)\): Break instruction exception - code 80000003 \((.*)\)') then
      if IgnoreBreakpoint then
        IgnoreBreakpoint := False
      else
      begin
        JumpToCurrentLine := True;
        OnBreakpoint;
      end;
  end;

  procedure ParseOutput(const line: string);
  begin
    if RegExp.Exec(line, '^([0-9]+):([0-9]+)>') then
    begin
      //The debugger is waiting for input, we're paused!
      SentCommand := False;
      fPaused := True;
      fBusy := False;

      //Because we are here, we probably are a side-effect of a previous instruction
      //Execute the process function for the command.
      if (CurOutput.Count <> 0) and (CurrentCommand <> nil) and Assigned(CurrentCommand.OnResult) then
          CurrentCommand.OnResult(CurOutput);

      if CurrentCommand <> nil then
      begin
        if (CurrentCommand.Command = 'g'#10) or (CurrentCommand.Command = 't'#10) or (CurrentCommand.Command = 'p'#10) then
        begin
          RefreshContext;
          Application.BringToFront;
        end;
      end;
      CurOutput.Clear;

      //Send the command, and do not send any more
      SendCommand;

      //Make sure we don't save the current line!
      Exit;
    end
    else if RegExp.Exec(line, 'Symbol search path is: (.*)') then
    begin
      if RegExp.Substitute('$1') = '*** Invalid ***' then
        OnNoDebuggingSymbolsFound;
    end
    else if RegExp.Exec(line, '\((.*)\): (.*) - code ([0-9a-fA-F]{1,8}) \((.*)\)') then
      ParseError(line)
    else if RegExp.Exec(line, 'Breakpoint ([0-9]+) hit') then
      with GetBreakpointFromIndex(StrToInt(RegExp.Substitute('$1'))) do
        MainForm.GotoBreakpoint(Filename, Line);

    CurOutput.Add(Line);
  end;
begin
  //Update the memo
  SentCommand := False;
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
end;

procedure TCDBDebugger.AddIncludeDir(s: string);
begin
  IncludeDirs.Add(s);
  if Executing then
    QueueCommand('.sympath+', s);
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
  Breakpoints.Add(aBreakpoint);
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
    Inc(fNextBreakpoint);
    breakpoint.Index := fNextBreakpoint;
    QueueCommand('bp' + IntToStr(breakpoint.Index), '`' + breakpoint.Filename + ':' + IntToStr(breakpoint.Line) + '`');
  end;
end;

procedure TCDBDebugger.RefreshContext(refresh: ContextDataSet);
var
  I: Integer;
  Node: TTreeNode;
  Command: TCommand;
begin
  if not Executing then
    Exit;

  //First send commands for stack tracing and locals
  if cdStackTrace in refresh then
  begin
    Command := TCommand.Create;
    Command.Command := 'kp 512';
    Command.OnResult := OnCallStack;
    QueueCommand(Command);
  end;
  if cdLocals in refresh then
  begin
    Command := TCommand.Create;
    Command.Command := 'dv -i -t -v';
    Command.OnResult := OnLocals;
    QueueCommand(Command);
  end;

  //Then update the watches
  if (cdWatches in refresh) and Assigned(DebugTree) then
  begin
    I := 0;
    while I < DebugTree.Items.Count do
    begin
      Node := DebugTree.Items[I];
      if Node.Data = nil then
        Continue;
      with PWatch(Node.Data)^ do
      begin
        Command := TCommand.Create;

        //Decide what command we should send - dv for locals, dt for structures
        if Pos('.', Name) > 0 then
          Command.Command := 'dt -r -b ' + Copy(name, 1, Pos('.', name) - 1)
        else if Pos('[', Name) > 0 then
          Command.Command := 'dt -a -r -b ' + Copy(name, 1, Pos('[', name) - 1)
        else
          Command.Command := 'dv ' + name;

        //Fill in the other data
        Command.Data := Node;
        Command.OnResult := OnRefreshContext;
        Node.DeleteChildren;

        //Then send it
        QueueCommand(Command);
      end;

      //Increment our counter
      Inc(I);
    end;
  end;
end;

procedure TCDBDebugger.OnRefreshContext(Output: TStringList);
const
  StructExpr = '( +)\+0x([0-9a-fA-F]{1,8}) ([^ ]*)?( +): (.*)';
  ArrayExpr = '\[([0-9a-fA-F]*)\] @ ([0-9a-fA-F]*)';
  StructArrayExpr = '( *)\[([0-9a-fA-F]*)\] (.*)';
var
  NeedsRefresh: Boolean;
  Expanded: Boolean;
  RegExp: TRegExpr;
  Node: TTreeNode;
  J: Integer;

  procedure ParseStructure(Output: TStringList; ParentNode: TTreeNode); forward;
  procedure ParseStructArray(Output: TStringList; ParentNode: TTreeNode);
  var
    I: Integer;
    Indent: Integer;
    SubStructure: TStringList;
  begin
    I := 0;
    Indent := 0;
    while I < Output.Count do
    begin
      SendDebug(inttostr(i) + ': ' + Output[I]);
      if RegExp.Exec(Output[I], StructArrayExpr) then
      begin
        with DebugTree.Items.AddChild(ParentNode, RegExp.Substitute('[$2] $3')) do
        begin
          SelectedIndex := 21;
          ImageIndex := 21;
        end;

        Inc(I);
        if I >= Output.Count then
           Continue;

        if RegExp.Exec(Output[I], StructExpr) then
        begin
          if Indent = 0 then
            Indent := Length(RegExp.Substitute('$1'));

          SubStructure := TStringList.Create;
          while I < Output.Count do
          begin
            if RegExp.Exec(Output[I], StructExpr) then
            begin
              if Length(RegExp.Substitute('$1')) < Indent then
                Break
              else
                SubStructure.Add(Output[I]);
            end
            else if RegExp.Exec(Output[I], StructArrayExpr) then
              if Length(RegExp.Substitute('$1')) <= Indent then
                Break
              else
              begin
                showmessage(inttostr(Length(RegExp.Substitute('$1'))) + '/' + inttostr(indent));
                SubStructure.Add(Output[I]);
              end;
                
            Inc(I);
          end;
          Indent := 0;

          //Process it
          with ParentNode.Item[ParentNode.Count - 1] do
          begin
            SelectedIndex := 32;
            ImageIndex := 32;
          end;

          //Determine if it is a structure or an array
          ParseStructure(SubStructure, ParentNode.Item[ParentNode.Count - 1]);
          ParentNode.Item[ParentNode.Count - 1].Expand(false);
          SubStructure.Free;
          Dec(I);
        end;
      end;

      Inc(I);
    end;
  end;

  procedure ParseStructure(Output: TStringList; ParentNode: TTreeNode);
  var
    SubStructure: TStringList;
    Indent: Integer;
    Node: TTreeNode;
    I: Integer;
  begin
    I := 0;
    Indent := 0;
    while I < Output.Count do
    begin
      if RegExp.Exec(Output[I], StructExpr) or RegExp.Exec(Output[I], StructArrayExpr) then
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
            if RegExp.Exec(Output[I], StructArrayExpr) or RegExp.Exec(Output[I], StructExpr) then
              if Length(RegExp.Substitute('$1')) <= Indent then
                Break
              else
                SubStructure.Add(Output[I]);
            Inc(I);
          end;

          //Process it
          with ParentNode.Item[ParentNode.Count - 1] do
          begin
            SelectedIndex := 32;
            ImageIndex := 32;
          end;

          //Determine if it is a structure or an array
          if SubStructure.Count <> 0 then
            if Trim(SubStructure[0])[1] = '[' then
              ParseStructArray(SubStructure, ParentNode.Item[ParentNode.Count - 1])
            else
              ParseStructure(SubStructure, ParentNode.Item[ParentNode.Count - 1]);
          ParentNode.Item[ParentNode.Count - 1].Expand(false);
          SubStructure.Free;

          //Decrement I, since we will increment one at the end of the loop
          Dec(I);
        end
        //Otherwise just add the value
        else
        begin
          if RegExp.Substitute('$5') = '' then
            Node := DebugTree.Items.AddChild(ParentNode, RegExp.Substitute('$3'))
          else
            Node := DebugTree.Items.AddChild(ParentNode, RegExp.Substitute('$3 = $5'));

          with Node do
          begin
            SelectedIndex := 21;
            ImageIndex := 21;
          end;
        end;
      end
      else
        SendDebug(Output[i]);

      //Increment I
      Inc(I);
    end;
  end;

  procedure ParseArray(Output: TStringList; ParentNode: TTreeNode);
  var
    SubStructure: TStringList;
    I: Integer;
  begin
    I := 0;
    while I < Output.Count do
    begin
      if RegExp.Exec(Output[I], ArrayExpr) then
      begin
        Inc(I, 2);
        if Output[I] = '' then
          Inc(I);
        
        //Are we an array (with a basic data type) or with a UDT?
        if RegExp.Exec(Output[I], StructExpr) then
        begin
          with TRegExpr.Create do
          begin
            Exec(Output[I - 2], ArrayExpr);
            with DebugTree.Items.AddChild(ParentNode, Substitute('[$1]')) do
            begin
              SelectedIndex := 32;
              ImageIndex := 32;
            end;

            Free;
          end;

          //Populate the substructure string list
          SubStructure := TStringList.Create;
          while (I < Output.Count) and (Output[I] <> '') do
          begin
            SubStructure.Add(Output[I]);
            Inc(I);
          end;

          //Process it
          ParseStructure(SubStructure, ParentNode.Item[ParentNode.Count - 1]);
          ParentNode.Item[ParentNode.Count - 1].Expand(false);
          SubStructure.Free;

          //Decrement I, since we will increment one at the end of the loop
          Dec(I);
        end
        else
          with DebugTree.Items.AddChild(ParentNode, RegExp.Substitute('[$1]') + ' = ' + Output[I]) do
          begin
            SelectedIndex := 21;
            ImageIndex := 21;
          end;
      end;

      //Increment I
      Inc(I);
    end;
  end;
begin
  NeedsRefresh := False;
  RegExp := TRegExpr.Create;
  Node := TTreeNode(CurrentCommand.Data);
  
  //Set the type of the structure/class/whatever
  with PWatch(Node.Data)^ do
    if RegExp.Exec(Output[0], '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*)\[\]') then
    begin
      Expanded := Node.Expanded;
      Node.Text := RegExp.Substitute(Copy(name, 1, Pos('[', name) - 1) + ' = $4 (0x$3)');
      Node.SelectedIndex := 32;
      Node.ImageIndex := 32;
      ParseArray(Output, Node);

      if Expanded then
        Node.Expand(True);
    end
    else if RegExp.Exec(Output[0], '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*)') then
    begin
      Expanded := Node.Expanded;
      Node.Text := RegExp.Substitute(Copy(name, 1, Pos('.', name) - 1) + ' = $4 (0x$3)');
      Node.SelectedIndex := 32;
      Node.ImageIndex := 32;
      ParseStructure(Output, Node);

      if Expanded then
        Node.Expand(True);
    end
    else
      for J := 0 to Output.Count - 1 do
        if RegExp.Exec(Output[J], '( +)' + name + ' = (.*) \[(.*)\]') then
        begin
          PWatch(Node.Data)^.Name := PWatch(Node.Data)^.Name + '[';
          NeedsRefresh := True;
        end
        else if RegExp.Exec(Output[J], '( +)' + name + ' = (struct|class|union) (.*)') then
        begin
          PWatch(Node.Data)^.Name := PWatch(Node.Data)^.Name + '.';
          NeedsRefresh := True;
        end
        else if RegExp.Exec(Output[J], '( +)' + name + ' = (.*)') then
          Node.Text := Trim(Output[J]);

  //Do we have to refresh the entire thing?
  if NeedsRefresh then
    RefreshContext;
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

procedure TCDBDebugger.OnCallStack(Output: TStringList);
var
  I: Integer;
  RegExp: TRegExpr;
  CallStack: TList;
  StackFrame: PStackFrame;
begin
  CallStack := TList.Create;
  RegExp := TRegExpr.Create;
  
  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], 'ChildEBP RetAddr') then
      Continue
    else if RegExp.Exec(Output[I], '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!([^ ]*)\((.*)\)(|.*) \[(.*) @ ([0-9]*)\]') then
    begin
      //Stack frame with source information
      New(StackFrame);
      CallStack.Add(StackFrame);

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
      CallStack.Add(StackFrame);

      //Fill the fields
      with StackFrame^ do
      begin
        FuncName := RegExp.Substitute('$4$6');
        Args := RegExp.Substitute('$5');
        Line := 0;
      end;
    end;

  //Now that we have the entire callstack loaded into our list, call the function
  //that wants it
  if Assigned(TDebugger(Self).OnCallStack) then
    TDebugger(Self).OnCallStack(CallStack);

  //Do we show the new execution point?
  if JumpToCurrentLine then
  begin
    JumpToCurrentLine := False;
    MainForm.GotoTopOfStackTrace;
  end;

  //Clean up
  RegExp.Free;
  CallStack.Free;
end;

procedure TCDBDebugger.OnLocals(Output: TStringList);
var
  I: Integer;
  Local: PVariable;
  Locals: TList;
  RegExp: TRegExpr;
begin
  Locals := TList.Create;
  RegExp := TRegExpr.Create;
  
  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], '(.*)( +)(.*)( +)([0-9a-fA-F]{1,8}) (.*) = (.*)') then
    begin
      New(Local);
      Locals.Add(Local);

      //Fill the fields
      with Local^ do
      begin
        Name := RegExp.Substitute('$6');
        Value := RegExp.Substitute('$7');
        Location := RegExp.Substitute('$5');
      end;
    end;

  //Pass the locals list to the callback function that wants it
  if Assigned(TDebugger(Self).OnLocals) then
    TDebugger(Self).OnLocals(Locals);

  //Clean up
  Locals.Free;
  RegExp.Free;
end;

procedure TCDBDebugger.GetRegisters;
var
  Command: TCommand;
begin
  if (not Executing) or (not Paused) then
    Exit;

  Command := TCommand.Create;
  Command.Command := 'r';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);
end;

procedure TCDBDebugger.OnRegisters(Output: TStringList);
var
  I: Integer;
  RegExp: TRegExpr;
  Registers: TRegisters;
begin
  RegExp := TRegExpr.Create;
  Registers := TRegisters.Create;

  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], 'eax=([0-9a-fA-F]{1,8}) ebx=([0-9a-fA-F]{1,8}) ecx=([0-9a-fA-F]{1,8}) edx=([0-9a-fA-F]{1,8}) esi=([0-9a-fA-F]{1,8}) edi=([0-9a-fA-F]{1,8})') then
      begin
        with Registers do
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
        with Registers do
        begin
          EIP := RegExp.Substitute('$1');
          ESP := RegExp.Substitute('$2');
          EBP := RegExp.Substitute('$3');
        end;
      end
      else if RegExp.Exec(Output[I], 'cs=([0-9a-fA-F]{1,4})  ss=([0-9a-fA-F]{1,4})  ds=([0-9a-fA-F]{1,4})  es=([0-9a-fA-F]{1,4})  fs=([0-9a-fA-F]{1,4})  gs=([0-9a-fA-F]{1,4})             efl=([0-9a-fA-F]{1,8})') then
      begin
        with Registers do
        begin
          CS := RegExp.Substitute('$1');
          SS := RegExp.Substitute('$2');
          DS := RegExp.Substitute('$3');
          ES := RegExp.Substitute('$4');
        end;
      end;

  //Pass the locals list to the callback function that wants it
  if Assigned(TDebugger(Self).OnRegisters) then
    TDebugger(Self).OnRegisters(Registers);

  //Clean up
  RegExp.Free;  
end;

procedure TCDBDebugger.Disassemble(func: string);
var
  Command: TCommand;
begin
  if (not Executing) or (not Paused) then
    Exit;

  Command := TCommand.Create;
  Command.Command := 'ub ' + func + ';u ' + func;
  Command.OnResult := OnDisassemble;
  QueueCommand(Command);
end;

procedure TCDBDebugger.OnDisassemble(Output: TStringList);
var
  I: Integer;
  RegExp: TRegExpr;
  Disassembly: String;
begin
  RegExp := TRegExpr.Create;
  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], '^(.*)!(.*) \[(.*) @ ([0-9]+)]:') then
      Disassembly := Disassembly + #9 + ';' + Output[I] + #10
    else if RegExp.Exec(Output[I], '^([0-9a-fA-F]{1,8})( +)([^ ]*)( +)(.*)( +)(.*)') then
      Disassembly := Disassembly + Output[I] + #10;

  //Pass the disassembly to the callback function that wants it
  if Assigned(TDebugger(Self).OnDisassemble) then
    TDebugger(Self).OnDisassemble(Disassembly);

  //Clean up
  RegExp.Free;
end;

function TCDBDebugger.GetVariableHint(name: string): string;
var
  Command: TCommand;
begin
  if (not Executing) or (not Paused) then
    Exit;

  Command := TCommand.Create;
  Command.Data := TObject(name);
  Command.OnResult := OnVariableHint;

  //Decide what command we should send - dv for locals, dt for structures
  if Pos('.', name) > 0 then
    Command.Command := 'dt ' + Copy(name, 1, Pos('.', name) - 1)
  else
    Command.Command := 'dv ' + name;

  //Send the command;
  QueueCommand(Command);
end;

procedure TCDBDebugger.OnVariableHint(Output: TStringList);
var
  Hint, Name: String;
  I, Depth: Integer;
  RegExp: TRegExpr;
begin
  if CurrentCommand <> nil then
    Name := string(CurrentCommand.Data);
  RegExp := TRegExpr.Create;

  if Pos('.', Name) <> 0 then
  begin
    //Remove the dots and count the number of indents
    Depth := 0;
    for I := 1 to Length(name) do
      if name[I] = '.' then
        Inc(Depth);

    //Then find the member name
    for I := 0 to Output.Count - 1 do
      if RegExp.Exec(Output[I], '( {' + IntToStr(Depth * 3) + '})\+0x([0-9a-fA-F]{1,8}) ' +
                     Copy(name, GetLastPos('.', name) + 1, Length(name)) + '( +): (.*)') then
        Hint := RegExp.Substitute(name + ' = $4');
  end
  else
  begin
    for I := 0 to Output.Count - 1 do
      if RegExp.Exec(Output[I], '( +)(.*) = (.*)') then
        Hint := Trim(Output[I]);
  end;

  //Call the callback
  if Assigned(TDebugger(Self).OnVariableHint) then
    TDebugger(Self).OnVariableHint(Hint);

  //Clean up
  RegExp.Free;
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

procedure TCDBDebugger.Pause;
begin
end;

procedure TCDBDebugger.Next;
var
  Command: TCommand;
begin
  Command := TCommand.Create;
  Command.Command := 'p';
  Command.Callback := OnTrace;
  QueueCommand(Command);
end;

procedure TCDBDebugger.Step;
var
  Command: TCommand;
begin
  Command := TCommand.Create;
  Command.Command := 't';
  Command.Callback := OnTrace;
  QueueCommand(Command);
end;

procedure TCDBDebugger.OnTrace;
begin
  JumpToCurrentLine := True;
  fPaused := False;
  fBusy := False;
end;

procedure TCDBDebugger.SetContext(frame: Integer);
begin
  QueueCommand('.frame', IntToStr(frame));
  RefreshContext([cdLocals, cdWatches]);
end;

//------------------------------------------------------------------------------
// TGDBDebugger
//------------------------------------------------------------------------------
constructor TGDBDebugger.Create;
begin
  inherited;
  OverrideHandler := nil;
  Started := False;
end;

destructor TGDBDebugger.Destroy;
begin
  inherited;
end;

procedure TGDBDebugger.Launch(arguments: string; hChildStdOut, hChildStdIn, hChildStdErr: THandle);
var
  ProcessInfo: TProcessInformation;
  StartupInfo: TStartupInfo;
  Executable: string;
begin
  //Reset our variables
  fExecuting := True;
  fNextBreakpoint := 0;

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
  Executable := Executable + ' --annotate=2 --silent';

  //Launch the process
  if not CreateProcess(nil, PChar(Executable), nil, nil, True, CREATE_NEW_CONSOLE,
                       nil, nil, StartupInfo, ProcessInfo) then
  begin
    DisplayError('Could not find program file ' + Executable);
    Exit;
  end;

  //Get the PID of the new process
  hPid := ProcessInfo.hProcess;

  //Close any unnecessary handles.
  if (not CloseHandle(ProcessInfo.hThread)) then
    DisplayError('CloseHandle');

  //Tell GDB which file we want to debug
  QueueCommand('file', '"' + filename + '"');
  QueueCommand('set args', arguments);
end;

procedure TGDBDebugger.CloseDebugger(Sender: TObject);
begin
  inherited;
  Started := False;
end;

procedure TGDBDebugger.OnOutput(Output: string);
var
  RegExp: TRegExpr;
  CurLine: String;

  procedure ParseOutput(const line: string);
  begin
    //Exclude these miscellaneous messages
    if (line = '