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
  QDialogs, QControls, QComCtrls;
{$ENDIF}

type
  AssemblySyntax = (asATnT, asIntel);
  ContextData = (cdLocals, cdCallStack, cdWatches, cdThreads);
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

  PDebuggerThread = ^TDebuggerThread;
  TDebuggerThread = packed record
    Active: Boolean;
    ID: string;
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
    IgnoreBreakpoint: Boolean;
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

    //Common events
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
    OnThreads: procedure(Threads: TList) of object;
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
    procedure Pause; virtual;
    procedure Next; virtual; abstract;
    procedure Step; virtual; abstract;
    procedure SetThread(thread: Integer); virtual; abstract;
    procedure SetContext(frame: Integer); virtual; abstract;
    function GetVariableHint(name: string): string; virtual; abstract;

    //Source lookup directories
    procedure AddIncludeDir(s: string); virtual; abstract;
    procedure ClearIncludeDirs; virtual; abstract;

    //Variable watches
    procedure RefreshContext(refresh: ContextDataSet = [cdLocals, cdCallStack, cdWatches, cdThreads]); virtual; abstract;
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
    procedure OnThreads(Output: TStringList);
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
    procedure RefreshContext(refresh: ContextDataSet = [cdLocals, cdCallStack, cdWatches, cdThreads]); override;
    procedure AddWatch(varname: string); override;
    procedure RemoveWatch(varname: string); override;

    //Debugger control
    procedure Go; override;
    procedure Next; override;
    procedure Step; override;
    procedure SetThread(thread: Integer); override;
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
    procedure OnThreads(Output: TStringList);
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
    procedure RefreshContext(refresh: ContextDataSet = [cdLocals, cdCallStack, cdWatches, cdThreads]); override;
    procedure AddWatch(varname: string); override;
    procedure RemoveWatch(varname: string); override;
    procedure ModifyVariable(varname, newvalue: string); override;

    //Debugger control
    procedure Go; override;
    procedure Next; override;
    procedure Step; override;
    procedure Pause; override;
    procedure SetThread(thread: Integer); override;
    procedure SetContext(frame: Integer); override;
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

  // Create a thread that will read the child's output.
  Reader := TDebugReader.Create(true);
  Reader.Pipe := hOutputRead;
  Reader.Event := Event;
  Reader.OnTerminate := CloseDebugger;
  Reader.FreeOnTerminate := True;

  // Create a thread that will notice when an output is ready to be sent for processing
  Wait := TDebugWait.Create(true);
  Wait.OnOutput := OnOutput;
  Wait.Reader := Reader;
  Wait.Event := Event;

  // Call the derived class' launch function to actually start execution
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

  //Run both wait threads
  Wait.Resume;
  Reader.Resume;
end;

procedure TDebugger.DisplayError(s: string);
begin
  MessageDlg('Error with debugging process: ' + s, mtError, [mbOK], Mainform.Handle);
end;

procedure TDebugger.CloseDebugger(Sender: TObject);
begin
  if Executing then
  begin
    fPaused := false;
    fExecuting := false;

    // First don't let us be called twice. Set the secondary threads to not call
    // us when they terminate
    Reader.OnTerminate := nil;

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

function GenerateCtrlCEvent(PGenerateConsoleCtrlEvent: Pointer): DWORD; stdcall;
begin
  Result := 0;
  if PGenerateConsoleCtrlEvent <> nil then
  begin
    asm
      //Call assembly code! We just want to get the console function thingo
      push 0;
      push 0;
      call PGenerateConsoleCtrlEvent;
    end;
    Result := 1;
  end;
end;

procedure TDebugger.Pause;
const
  CodeSize = 1024;
var
  Thread: THandle;
  BytesWritten, ThreadID, ExitCode: DWORD;
  WriteAddr: Pointer;
begin
  WriteAddr := VirtualAllocEx(hPid, nil, CodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
  if WriteAddr <> nil then
  begin
    WriteProcessMemory(hPid, WriteAddr, @GenerateCtrlCEvent, CodeSize, BytesWritten);
    if BytesWritten = CodeSize then
    begin
      //Create and run the thread
      Thread := CreateRemoteThread(hPid, nil, 0, WriteAddr, GetProcAddress(LoadLibrary('kernel32.dll'), 'GenerateConsoleCtrlEvent'), 0, ThreadID);
      if Thread <> 0 then
      begin
        //Wait for its termination
        WaitForSingleObject(Thread, INFINITE);

        //And see if it succeeded
        GetExitCodeThread(Thread, ExitCode);
        if ExitCode <> 0 then
          //We've triggered a breakpoint, so yes, ignore it
          IgnoreBreakpoint := True;

        //Destroy the thread
        CloseHandle(Thread);
      end;
    end;

    //Free the memory we injected
    VirtualFreeEx(hPid, WriteAddr, 0, MEM_RELEASE); // free the memory we allocated
  end;
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
const
  InputPrompt = '^([0-9]+):([0-9]+)>';
var
  ProcessInfo: TProcessInformation;
  StartupInfo: TStartupInfo;
  Executable: string;
  Srcpath: string;
  I: Integer;
begin
  //Tell the wait function that another valid output terminator is the 0:0000 prompt
  Wait.OutputTerminators.Add(InputPrompt);

  //Heck about the breakpoint thats coming.
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
  Executable := Format('%s -lines -2 -G -sflags 0x800B8633 -y "%s" "%s" %s', [Executable, ExtractFilePath(Filename), FileName, arguments]);

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
const
  InputPrompt = '^([0-9]+):([0-9]+)>';
var
  RegExp: TRegExpr;
  CurLine: String;

  procedure ParseError(const line: string);
  begin
    if RegExp.Exec(line, '\((.*)\): Access Violation - code c0000005 \((.*)\)') then
      OnAccessViolation
    else if RegExp.Exec(line, '\((.*)\): Control-C exception - code 40010005 \((.*)\)') then
    else if RegExp.Exec(line, '\((.*)\): Break instruction exception - code 80000003 \((.*)\)') then
      if IgnoreBreakpoint then
        IgnoreBreakpoint := False
      else
        OnBreakpoint;
  end;

  procedure ParseOutput(const line: string);
  begin
    if RegExp.Exec(line, InputPrompt) then
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
    else if RegExp.Exec(line, 'DBGHELP: (.*) - no symbols loaded') then
    begin
      if LowerCase(RegExp.Substitute('$1')) = LowerCase(ChangeFileExt(ExtractFileName(Filename), '')) then
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
  MainForm.DebugOutput.Lines.BeginUpdate;

  while Pos(#10, Output) > 0 do
  begin
    //Extract the current line
    CurLine := Copy(Output, 0, Pos(#10, Output) - 1);

    //Process the output
    if not AnsiStartsStr('DBGHELP: ', CurLine) then
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
  MainForm.DebugOutput.Lines.EndUpdate;
  SendMessage(MainForm.DebugOutput.Handle, $00B6 {EM_LINESCROLL}, 0,
              MainForm.DebugOutput.Lines.Count);
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

  //First send commands for stack tracing, locals and the threads list
  if cdCallStack in refresh then
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
  if cdThreads in refresh then
  begin
    Command := TCommand.Create;
    Command.Command := '~';
    Command.OnResult := OnThreads;
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
        else if AnsiStartsStr('*', name) then
          Command.Command := 'dt -r -b ' + Copy(name, Pos('*', name) + 1, Length(name))
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
  StructExpr = '( +)[\+|=]0x([0-9a-fA-F]{1,8}) ([^ ]*)?( +): (.*)';
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
                SubStructure.Add(Output[I]);
                
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
          Indent := 0;

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
      end;

      //Increment I
      Inc(I);
    end;
  end;

  procedure ParseArray(Output: TStringList; ParentNode: TTreeNode);
  var
    SubStructure: TStringList;
    Increment: Integer;
    I: Integer;
  begin
    I := 0;
    while I < Output.Count do
    begin
      if RegExp.Exec(Output[I], ArrayExpr) then
      begin
        Inc(I, 2);
        Increment := 2;
        while Trim(Output[I]) = '' do
        begin
          Inc(I);
          Inc(Increment);
        end;
        
        //Are we an array (with a basic data type) or with a UDT?
        if RegExp.Exec(Output[I], StructExpr) then
        begin
          with TRegExpr.Create do
          begin
            Exec(Output[I - Increment], ArrayExpr);
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
          with TRegExpr.Create do
          begin
            Exec(Output[I - Increment], ArrayExpr);
            with DebugTree.Items.AddChild(ParentNode, Substitute('[$1]') + ' = ' + Output[I]) do
            begin
              SelectedIndex := 21;
              ImageIndex := 21;
            end;

            Free;
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
  Output.SaveToFile('D:\Output.txt');
  
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
      if Pos('.', name) <> 0 then
        Node.Text := RegExp.Substitute(Copy(name, 1, Pos('.', name) - 1) + ' = $4 (0x$3)')
      else
        Node.Text := RegExp.Substitute(name + ' = $4 (0x$3)');
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
    else if RegExp.Exec(Output[I], '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!(.*)\((.*)\)(|.*) \[(.*) @ ([0-9]*)\]') then
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
    else if RegExp.Exec(Output[I], '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!(.*)(|\((.*)\))(.*)') then
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

procedure TCDBDebugger.OnThreads(Output: TStringList);
var
  I: Integer;
  Thread: PDebuggerThread;
  Threads: TList;
  RegExp: TRegExpr;
  Suspended, Frozen: Boolean;
begin
  Threads := TList.Create;
  RegExp := TRegExpr.Create;
  
  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], '([.#]*)( +)([0-9]*)( +)Id: ([0-9a-fA-F]*)\.([0-9a-fA-F]*) Suspend: ([0-9a-fA-F]*) Teb: ([0-9a-fA-F]{1,8}) (.*)') then
    begin
      New(Thread);
      Threads.Add(Thread);

      //Fill the fields
      with Thread^ do
      begin
        Active := RegExp.Substitute('$1') = '.';
        ID := RegExp.Substitute('$5.$6');
        Suspended := RegExp.Substitute('$7') <> '0';
        Frozen := RegExp.Substitute('$9') = 'frozen';
        if Suspended and Frozen then
          ID := ID + ' (Suspended, Frozen)'
        else if Suspended then
          ID := ID + ' (Suspended)'
        else if Frozen then
          ID := ID + ' (Frozen)'
      end;
    end;

  //Pass the locals list to the callback function that wants it
  if Assigned(TDebugger(Self).OnThreads) then
    TDebugger(Self).OnThreads(Threads);

  //Clean up
  Threads.Free;
  RegExp.Free;
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

procedure TCDBDebugger.SetThread(thread: Integer);
begin
  QueueCommand('~' + IntToStr(thread), 's');
  RefreshContext([cdLocals, cdWatches, cdCallStack, cdThreads]);
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
  Includes: string;
  I: Integer;
begin
  //Reset our variables
  fExecuting := True;
  fNextBreakpoint := 0;
  IgnoreBreakpoint := False;

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

  //Add in the include paths
  for I := 0 to IncludeDirs.Count - 1 do
    Includes := Includes + '--directory=' + GetShortName(IncludeDirs[I]) + ' ';
  if Includes <> '' then
    Executable := Executable + ' ' + Includes;

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

  procedure StripCtrlChars(var line: string);
  var
    Idx: Integer;
  begin
    Idx := Pos(#26, line);
    while Idx <> 0 do
    begin
      Delete(line, Idx, 1);
      Idx := Pos(#26, line);
    end;
  end;

  procedure ParseOutput(const line: string);
  begin
    //Exclude these miscellaneous messages
    if (line = 'pre-prompt') or (line = 'prompt') or (line = 'post-prompt') or
       (line = 'frames-invalid') then
      Exit
    //Empty lines
    else if Trim(line) = '' then
      Exit
    else if Pos('(gdb) ', line) = 1 then
    begin
      //The debugger is waiting for input, we're paused!
      SentCommand := False;
      fPaused := True;
      fBusy := False;

      //Because we are here, we probably are a side-effect of a previous instruction
      //Execute the process function for the command.
      if Assigned(OverrideHandler) then
      begin
        OverrideHandler(CurOutput);
        OverrideHandler := nil;
      end
      else if (CurOutput.Count <> 0) and (CurrentCommand <> nil) and Assigned(CurrentCommand.OnResult) then
        CurrentCommand.OnResult(CurOutput);

      if CurrentCommand <> nil then
      begin
        if (CurrentCommand.Command = 'run'#10) or (CurrentCommand.Command = 'next'#10) or
           (CurrentCommand.Command = 'step'#10) or (CurrentCommand.Command = '') then
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
    else if (Pos('no debugging symbols found', line) > 0) or (Pos('No symbol table is loaded', line) > 0) then
      OnNoDebuggingSymbolsFound
    else if Pos('file is more recent than executable', line) > 0 then
      OnSourceMoreRecent
    else if line = 'signal' then
      OverrideHandler := OnSignal 
    else if RegExp.Exec(line, 'Breakpoint ([0-9]+),') then
      with GetBreakpointFromIndex(StrToInt(RegExp.Substitute('$1'))) do
        MainForm.GotoBreakpoint(Filename, Line)
    else if Pos('exited ', line) = 1 then
      CloseDebugger(nil);

    CurOutput.Add(Line);
  end;
begin
  //Update the memo
  SentCommand := False;
  RegExp := TRegExpr.Create;
  MainForm.DebugOutput.Lines.BeginUpdate;

  while Pos(#13, Output) > 0 do
  begin
    //Extract the current line
    CurLine := Copy(Output, 0, Pos(#13, Output) - 1);

    //Process the output
    StripCtrlChars(CurLine);
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
  MainForm.DebugOutput.Lines.EndUpdate;
  SendMessage(MainForm.DebugOutput.Handle, $00B6 {EM_LINESCROLL}, 0,
              MainForm.DebugOutput.Lines.Count);
  RegExp.Free;
end;

procedure TGDBDebugger.OnSignal(Output: TStringList);
var
  I: Integer;
begin
  for I := 0 to Output.Count - 1 do
  begin
    if Output[I] = 'signal-name' then
      if Output[I + 1] = 'SIGSEGV' then
        OnAccessViolation
      else;
  end;
end;

procedure TGDBDebugger.OnSourceMoreRecent;
begin
  if (MessageDlg(Lang[ID_MSG_SOURCEMORERECENT], mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    CloseDebugger(nil);
    MainForm.actCompileExecute(nil);
  end;
end;

procedure TGDBDebugger.AddIncludeDir(s: string);
begin
  IncludeDirs.Add(s);
end;

procedure TGDBDebugger.ClearIncludeDirs;
begin
  IncludeDirs.Clear;
end;

procedure TGDBDebugger.AddBreakpoint(breakpoint: TBreakpoint);
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

procedure TGDBDebugger.RemoveBreakpoint(breakpoint: TBreakpoint);
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
        QueueCommand('delete', IntToStr(PBreakpoint(Breakpoints.Items[i])^.Index));
      Dispose(Breakpoints.Items[i]);
      Breakpoints.Delete(i);
      Break;
    end;
  end;
end;

procedure TGDBDebugger.RefreshBreakpoint(var breakpoint: TBreakpoint);
begin
  if Executing then
  begin
    Inc(fNextBreakpoint);
    breakpoint.Index := fNextBreakpoint;
    QueueCommand('break', Format('"%s:%d"', [ExtractFileName(breakpoint.Filename), breakpoint.Line]));
  end;
end;

procedure TGDBDebugger.RefreshContext(refresh: ContextDataSet);
var
  I: Integer;
  Node: TTreeNode;
  Command: TCommand;
begin
  if not Executing then
    Exit;

  //First send commands for stack tracing, locals and threads
  if cdCallStack in refresh then
  begin
    Command := TCommand.Create;
    Command.Command := 'bt';
    Command.OnResult := OnCallStack;
    QueueCommand(Command);
  end;
  if cdLocals in refresh then
  begin
    Command := TCommand.Create;
    Command.Command := 'info locals 1';
    Command.OnResult := OnLocals;
    QueueCommand(Command);
  end;
  if cdThreads in refresh then
  begin
    Command := TCommand.Create;
    Command.Command := 'info threads';
    Command.OnResult := OnThreads;
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
          Command.Command := 'display ' + Copy(name, 1, Pos('.', name) - 1)
        else
          Command.Command := 'display ' + name;

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

procedure TGDBDebugger.OnRefreshContext(Output: TStringList);
var
  I: Integer;
  Node: TTreeNode;

  procedure RecurseArray(Parent: TTreeNode; var I: Integer); forward;
  procedure RecurseStructure(Parent: TTreeNode; var I: Integer);
  var
    Child: TTreeNode;
  begin
    while I < Output.Count - 4 do
      if Output[I] = '}' then
        Exit
      else if Pos('{', Output[I + 4]) <> 1 then
      begin
        with DebugTree.Items.AddChild(Parent, Output[I] + ' = ' + Output[I + 4]) do
        begin
          SelectedIndex := 21;
          ImageIndex := 21;
        end;

        Inc(I, 6);
        if (I < Output.Count) and (Pos(',', Output[I]) <> 0) then
          Inc(I, 2);
      end
      else
      begin
        Child := DebugTree.Items.AddChild(Parent, Output[I]);
        with Child do
        begin
          SelectedIndex := 32;
          ImageIndex := 32;
        end;
        
        Inc(I, 6);
        if Pos('array-section-begin', Output[I - 1]) = 1 then
          RecurseArray(Child, I)
        else
          RecurseStructure(Child, I);

        Inc(I, 2);
        if (I < Output.Count) and (Pos(',', Output[I]) = 1) then
          Inc(I, 2);
      end;
  end;

  procedure RecurseArray(Parent: TTreeNode; var I: Integer);
  var
    Child: TTreeNode;
    Count: Integer;
  begin
    Count := 0;
    while (I < Output.Count - 2) do
    begin
      if Output[I] = '}' then
        Break
      else if Pos(',', Output[I]) = 1 then
        Output[I] := Trim(Copy(Output[I], 2, Length(Output[I])));

      if Pos('{', Output[I]) = 1 then
      begin
        Child := DebugTree.Items.AddChild(Parent, Format('[%d]', [Count]));
        with Child do
        begin
          SelectedIndex := 32;
          ImageIndex := 32;
        end;
        
        Inc(I, 2);
        RecurseStructure(Child, I);
      end
      else if (Trim(Output[I]) <> '') and (Output[I] <> 'array-section-end') then
      begin
        with DebugTree.Items.AddChild(Parent, Format('[%d]', [Count]) + ' = ' + Output[I]) do
        begin
          SelectedIndex := 21;
          ImageIndex := 21;
        end;
      end
      else
      begin
        Inc(I);
        Continue;
      end;

      Inc(Count);
      Inc(I, 2);
    end;
  end;
begin
  I := 0;
  Node := TTreeNode(CurrentCommand.Data);
  
  while I < Output.Count do
  begin
    if Output[I] = 'display-expression' then
    begin
      Node.Text := Output[I + 1];
      Node.SelectedIndex := 32;
      Node.ImageIndex := 32;
      
      if Pos('{', Output[I + 5]) = 1 then
      begin
        Inc(I, 7);

        //Determine if it is a structure of an array
        if Pos('array-section-begin', Output[I - 1]) = 1 then
          RecurseArray(Node, I)
        else
          RecurseStructure(Node, I);
      end
      else
        Node.Text := Output[I + 1] + ' = ' + Output[I + 5];
      Break;
    end;
    Inc(I);
  end
end;

procedure TGDBDebugger.AddWatch(varname: string);
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

procedure TGDBDebugger.RemoveWatch(varname: string);
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

procedure TGDBDebugger.ModifyVariable(varname, newvalue: string);
begin
  QueueCommand('set variable', varname + ' = ' + newvalue);
end;

procedure TGDBDebugger.OnCallStack(Output: TStringList);
var
  I: Integer;
  CallStack: TList;
  RegExp: TRegExpr;
  StackFrame: PStackFrame;
begin
  StackFrame := nil;
  CallStack := TList.Create;
  RegExp := TRegExpr.Create;

  I := 0;
  while I < Output.Count do
  begin
    if Pos('frame-begin', Output[I]) = 1 then
    begin
      //Stack frame with source information
      New(StackFrame);
      CallStack.Add(StackFrame);
    end
    else if Output[I] = 'frame-function-name' then
    begin
      Inc(I);
      StackFrame^.FuncName := Output[I]; 
    end
    else if Output[I] = 'frame-args' then
    begin
      Inc(I);

      //Make sure it's valid
      if Output[I] <> ' (' then
      begin
        Inc(I);
        Continue;
      end
      else
        Inc(I);

      while (I < Output.Count - 6) do
      begin
        if Output[I] = 'arg-begin' then
        begin
          if StackFrame^.Args <> '' then
            StackFrame^.Args := StackFrame^.Args + ', ';
          StackFrame^.Args := StackFrame^.Args + Output[I + 1] + ' = ' + Output[I + 5];
        end;
        Inc(I, 6);

        //Do we stop?
        if Trim(Output[I + 1]) <> ',' then
          Break
        else
          Inc(I, 2);
      end;
    end
    else if Output[I] = 'frame-source-file' then
    begin
      Inc(I);
      StackFrame^.Filename := Output[I];
    end
    else if Output[I] = 'frame-source-line' then
    begin
      Inc(I);
      StackFrame^.Line := StrToInt(Output[I]);
    end;
    Inc(I);
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

procedure TGDBDebugger.OnLocals(Output: TStringList);
var
  I: Integer;
  RegExp: TRegExpr;
  Local: PVariable;
  Locals: TList;

  function SynthesizeIndent(Indent: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to Indent - 1 do
      Result := Result + ' ';
  end;

  procedure RecurseArray(Indent: Integer; var I: Integer); forward;
  procedure RecurseStructure(Indent: Integer; var I: Integer);
  begin
    while I < Output.Count - 4 do
      if Output[I] = '}' then
        Exit
      else if Pos('{', Output[I + 4]) <> 1 then
      begin
        New(Local);
        Locals.Add(Local);
        with Local^ do
        begin
          Name := SynthesizeIndent(Indent) + Output[I];
          Value := Output[I + 4];
        end;

        Inc(I, 6);
        if (I < Output.Count) and (Pos(',', Output[I]) <> 0) then
          Inc(I, 2);
      end
      else
      begin
        New(Local);
        Locals.Add(Local);
        with Local^ do
        begin
          Name := SynthesizeIndent(Indent) + Output[I];
          Value := '';
        end;
        
        Inc(I, 6);
        if Pos('array-section-begin', Output[I - 1]) = 1 then
          RecurseArray(Indent + 4, I)
        else
          RecurseStructure(Indent + 4, I);

        Inc(I, 2);
        if (I < Output.Count) and (Pos(',', Output[I]) = 1) then
          Inc(I, 2);
      end;
  end;

  procedure RecurseArray(Indent: Integer; var I: Integer);
  var
    Count: Integer;
  begin
    Count := 0;
    while (I < Output.Count - 2) do
    begin
      if Output[I] = '}' then
        Break
      else if Pos(',', Output[I]) = 1 then
        Output[I] := Trim(Copy(Output[I], 2, Length(Output[I])));

      if Pos('{', Output[I]) = 1 then
      begin
        New(Local);
        Locals.Add(Local);
        with Local^ do
          Name := Format('%s[%d]', [SynthesizeIndent(Indent), Count]);
        
        Inc(I, 2);
        RecurseStructure(Indent + 4, I);
      end
      else if (Trim(Output[I]) <> '') and (Output[I] <> 'array-section-end') then
      begin
        New(Local);
        Locals.Add(Local);
        with Local^ do
        begin
          Name := Format('%s[%d]', [SynthesizeIndent(Indent), Count]);
          Value := Output[I];
        end;
      end
      else
      begin
        Inc(I);
        Continue;
      end;

      Inc(Count);
      Inc(I, 2);
    end;
  end;
begin
  RegExp := TRegExpr.Create;
  Locals := TList.Create;

  I := 0;
  while I < Output.Count do
  begin
    if RegExp.Exec(Output[I], '(.*) = (.*)') then
    begin
      New(Local);
      Locals.Add(Local);
      
      if RegExp.Substitute('$2') = '{' then
      begin
        with Local^ do
        begin
          Name := RegExp.Substitute('$1');
          Value := '';
        end;

        Inc(I, 2);
        //Determine if it is a structure of an array
        if Pos('array-section-begin', Output[I - 1]) = 1 then
          RecurseArray(4, I)
        else
          RecurseStructure(4, I);
      end
      else
      begin
        //Fill the fields
        with Local^ do
        begin
          Name := RegExp.Substitute('$1');
          Value := RegExp.Substitute('$2');
        end;
      end;
    end;
    Inc(I);
  end;

  //Pass the locals list to the callback function that wants it
  if Assigned(TDebugger(Self).OnLocals) then
    TDebugger(Self).OnLocals(Locals);

  //Clean up
  Locals.Free;
  RegExp.Free;
end;

procedure TGDBDebugger.OnThreads(Output: TStringList);
var
  I: Integer;
  RegExp: TRegExpr;
  Thread: PDebuggerThread;
  Threads: TList;
begin
  RegExp := TRegExpr.Create;
  Threads := TList.Create;

  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], '(\**)( +)([0-9]+)( +)thread ([0-9a-fA-F]*).0x([0-9a-fA-F]*)') then
    begin
      New(Thread);
      Threads.Insert(0, Thread);

      with Thread^ do
      begin
        Active := RegExp.Substitute('$1') = '*';
        ID := RegExp.Substitute('$5.$6');
      end;
    end;

  //Call the callback function to list the threads
  if Assigned(TDebugger(Self).OnThreads) then
    TDebugger(Self).OnThreads(Threads);

  Threads.Free;
  RegExp.Free;
end;

procedure TGDBDebugger.GetRegisters;
var
  Command: TCommand;
begin
  if (not Executing) or (not Paused) then
    Exit;

  RegistersFilled := 0;
  Registers := TRegisters.Create;
  Command := TCommand.Create;
  Command.Command := 'displ/x $eax';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $ebx';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $ecx';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $edx';
  Command.OnResult := OnRegisters;

  QueueCommand(Command);
  Command := TCommand.Create;
  Command.Command := 'displ/x $esi';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $edi';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $ebp';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $esp';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $eip';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $cs';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $ds';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $ss';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $es';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);
end;

procedure TGDBDebugger.OnRegisters(Output: TStringList);
var
  I: Integer;
  Reg: String;
  RegExp: TRegExpr;
begin
  RegExp := TRegExpr.Create;

  I := 0;
  while I < Output.Count do
  begin
    if Output[I] = ' = ' then
    begin
      Inc(I, 2);

      //Determine the register
      if RegExp.Exec(CurrentCommand.Command, 'displ/x \$(.*)') then
      begin
        Inc(RegistersFilled);
        Reg := Trim(RegExp.Substitute('$1'));
        if Reg = 'eax' then
          Registers.EAX := Output[I]
        else if Reg = 'ebx' then
          Registers.EBX := Output[I]
        else if Reg = 'ecx' then
          Registers.ECX := Output[I]
        else if Reg = 'edx' then
          Registers.EDX := Output[I]
        else if Reg = 'esi' then
          Registers.ESI := Output[I]
        else if Reg = 'edi' then
          Registers.EDI := Output[I]
        else if Reg = 'ebp' then
          Registers.EBP := Output[I]
        else if Reg = 'eip' then
          Registers.EIP := Output[I]
        else if Reg = 'esp' then
          Registers.ESP := Output[I]
        else if Reg = 'cs' then
          Registers.CS := Output[I]
        else if Reg = 'ds' then
          Registers.DS := Output[I]
        else if Reg = 'ss' then
          Registers.SS := Output[I]
        else if Reg = 'es' then
          Registers.ES := Output[I]
        else
          Dec(RegistersFilled);
      end;
    end;
    Inc(I);
  end;

  //Pass the locals list to the callback function that wants it
  if (RegistersFilled = 13) and Assigned(TDebugger(Self).OnRegisters) then
  begin
    TDebugger(Self).OnRegisters(Registers);
    Registers.Free;
  end;

  //Clean up
  RegExp.Free;
end;

procedure TGDBDebugger.Disassemble(func: string);
var
  Command: TCommand;
begin
  if (not Executing) or (not Paused) then
    Exit;

  Command := TCommand.Create;
  Command.Command := 'disas ' + func;
  Command.OnResult := OnDisassemble;
  QueueCommand(Command);
end;

procedure TGDBDebugger.OnDisassemble(Output: TStringList);
begin
  //Pass the disassembly to the callback function that wants it
  if Assigned(TDebugger(Self).OnDisassemble) then
    TDebugger(Self).OnDisassemble(Output.Text);
end;

procedure TGDBDebugger.SetAssemblySyntax(syntax: AssemblySyntax);
begin
  case syntax of
   asIntel: QueueCommand('set disassembly-flavor', 'intel');
   asATnT:  QueueCommand('set disassembly-flavor', 'att');
  end;
end;

function TGDBDebugger.GetVariableHint(name: string): string;
var
  Command: TCommand;
begin
  if (not Executing) or (not Paused) then
    Exit;

  Command := TCommand.Create;
  Command.Data := TObject(name);
  Command.OnResult := OnVariableHint;
  Command.Command := 'print ' + name;

  //Send the command;
  QueueCommand(Command);
end;

procedure TGDBDebugger.OnVariableHint(Output: TStringList);
begin
  //Call the callback
  if Assigned(TDebugger(Self).OnVariableHint) then
    TDebugger(Self).OnVariableHint(Output[0]);
end;

procedure TGDBDebugger.Go;
var
  Command: TCommand;
begin
  Command := TCommand.Create;
  if not Started then
    Command.Command := 'run'
  else
    Command.Command := 'continue';
  Command.Callback := OnGo;
  QueueCommand(Command);
end;

procedure TGDBDebugger.OnGo;
begin
  inherited;
  Started := True;
end;

procedure TGDBDebugger.Next;
var
  Command: TCommand;
begin
  Command := TCommand.Create;
  Command.Command := 'next';
  Command.Callback := OnTrace;
  QueueCommand(Command);
end;

procedure TGDBDebugger.Step;
var
  Command: TCommand;
begin
  Command := TCommand.Create;
  Command.Command := 'step';
  Command.Callback := OnTrace;
  QueueCommand(Command);
end;

procedure TGDBDebugger.OnTrace;
begin
  JumpToCurrentLine := True;
  fPaused := False;
  fBusy := False;
end;

procedure TGDBDebugger.Pause;
begin
  //Do nothing. GDB does not support break-ins.
end;

procedure TGDBDebugger.SetThread(thread: Integer);
begin
  QueueCommand('thread', IntToStr(thread + 1));
  RefreshContext([cdLocals, cdWatches, cdCallStack, cdThreads]);
end;

procedure TGDBDebugger.SetContext(frame: Integer);
begin
  QueueCommand('frame', IntToStr(frame));
  RefreshContext([cdLocals, cdWatches]);
end;

initialization
  Breakpoints := TList.Create;

finalization
  Breakpoints.Free;

end.
