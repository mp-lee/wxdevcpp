{
    $Id$
    
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

//{$DEFINE DISPLAYOUTPUT}   // enable byte count output in ReadThread for debugging
//{$DEFINE DISPLAYOUTPUTHEX}// enable debugging display of GDB output
//  in 'HEX Editor' style

interface

uses
    Classes, editor, Sysutils, version, debugCPU

    {$IFDEF WIN32}
    , ComCtrls, Controls, Dialogs, ShellAPI, Windows
    {$ENDIF}
    {$IFDEF LINUX}
    , QComCtrls, QControls, QDialogs
    {$ENDIF};

var
    //output from GDB
    TargetIsRunning: boolean = false;       // result of status messages
    gui_critSect: TRTLCriticalSection;
    // Why do we need this? Once the pipe
    // has been read, all processing is in
    // the Main Thread anyway!!!
    // Answer: Only when using debugging display
    // - and then there's little chance of conflict!

    Send_critSect: TRTLCriticalSection;
    // Not sure this is necessary either...
    //  we WRITE from only one place,
    //  we have our own handshake?

    // Globals for the Reader buffer data
    bytesInBuffer: DWORD;   // Number of unprocessed bytes
    buf: PChar;             // The main buffer into which data is read


{$IFDEF DISPLAYOUTPUTHEX}
// (Global because it is a useful data analysis tool).
procedure HexDisplay(buf: PChar; LastRead: DWORD);
{$ENDIF}

// These don't really belong in T(GDB)Debugger
function AnsiBeforeFirst(Sub: String; Target: String): String;
function AnsiAfterFirst(Sub: String; Target: String): String;
function AnsiAfterLast(Sub: String; Target: String): String;
function AnsiFindLast(Src: String; Target: String): Integer;
function AnsiLeftStr(const AText: string; ACount: Integer): string;
function AnsiMidStr(const AText: string;
    const AStart, ACount: Integer): string;
function AnsiRightStr(const AText: string; ACount: Integer): string;
function unescape(s: PString): String;
function OctToHex(s: PString): String;


const GDBPrompt: String = '(gdb)';
const GDBerror: String = 'error,';
const GDBdone: String = 'done,';
const GDBaddr: String = 'addr=';
const GDBaddress: String = 'address=';
const GDBasminst: String = 'asm_insns=';
const GDBasmline: String = 'line_asm_insns=';
const GDBbegin     : String = 'begin';
const GDBbkpt: String = 'bkpt={';
const GDBbkptno: String = 'bkptno';
const GDBbkpttable: String = 'BreakpointTable={';
const GDBbody: String = 'body=[';
const GDBcontents: String = 'contents';
const GDBcontinue: String = '-exec-continue';
const GDBcurthread: String = 'current-thread-id';
const GDBdataeval: String = '-data-evaluate-expression ';
const GDBDisassem: String = '-data-disassemble ';
const GDBend: String = 'end';
const GDBexp: String = 'exp=';
const GDBExit: String = '-gdb-exit';
const GDBExitmsg: String = 'exit';
const GDBfile: String = 'file';
const GDBfileq: String = 'file=';
const GDBframe: String = 'frame={';
const GDBfunc: String = 'func';
const GDBfuncname: String = 'func-name=';
const GDBid: String = 'id';
const GDBidq: String = 'id=';
const GDBinstr: String = 'inst=';
const GDBlevel: String = 'level';
const GDBlocals: String = 'locals';
const GDBlocalsq: String = 'locals=';
const GDBline: String = 'line';
const GDBlineq: String = 'line=';
const GDBmemq: String = 'memory=';
const GDBmult: String = '<MULTIPLE>';
const GDBnr_rows: String = 'nr_rows';
const GDBname: String = 'name';
const GDBnameq: String = 'name=';
const GDBnew: String = 'new';
const GDBnumber: String = 'number';
const GDBNoSymbol: String = 'No symbol';
const GDBoffset: String = 'offset=';
const GDBold: String = 'old';
const GDBorig_loc: String = 'original-location=';
const GDBregnames: String = 'register-names=';
const GDBregvalues: String = 'register-values=';
const GDBreason: String = 'reason=';
const GDBrunning: String = 'running';
const GDBsigmean: String = 'signal-meaning';
const GDBsigname: String = 'signal-name';
const GDBsigsegv: String = 'SIGSEV';
const GDBsrcline: String = 'src_and_asm_line=';
const GDBstack: String = 'stack=[';
const GDBstopped: String = 'stopped';
const GDBtargetid: String = 'target-id';
const GDBthreadid: String = 'thread-id';
const GDBthreads: String = 'threads=';
const GDBthreadgcr : String = 'thread-group-created';
const GDBtype: String = 'type';
const GDBvalue: String = 'value';
const GDBvalueq: String = 'value=';
const GDBvalueqb: String = 'value={';
const GDBwhat: String = 'what=';
const GDBwpt: String = 'wpt=';
const GDBwpta: String = 'hw-awpt=';
const GDBwptr: String = 'hw-rwpt=';
const GDBwpscope: String = 'watchpoint-scope';
const GDBwpNum: String = 'wpnum=';
const GDBqStrEmpty: String = '\"';
const wxStringBase: String = '<wxStringBase>';
const wpUnknown: String = '(unknown)';
const FileStr: String = 'File';
const FuncStr: String = 'Function';
const LineStr: String = 'Line';
const LinesStr: String = 'Lines';
const NoDisasmStr: String = 'No disassembly available';
const CPURegList: String = '0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15';
const CPURegCount: Integer = 15;  // The number of values above - 1
//            If this is changed, alter TRegisters & ParseRegisterValues and the
//            arrays CPURegNames, CPURegValues to suit.
const ExpandClasses: Boolean = true;
// set to false to treat contents of classes as string constants

const HT: Char = #9;
const LF: Char = #10;
const CR: Char = #13;
const NL: String = #13 + #10;
const MAXSTACKDEPTH: Integer = 99;
// Arbitrary limit to the depth of stack that can
// be displayed, to prevent an infinite loop.
// The display gets silly and probably not useful
// long before this. A sensible limit is around 10 - 20
// This just flags a user warning and returns.
//  (N.B. For GDB, the request can limit the range returned)

const
  PARSELIST = false;
  PARSETUPLE = true;
  INDENT = 3;                       // Amount of indentation of Locals display
  WATCHTOKENBASE = 9000;			// Token base for Watchpoint values
  MODVARTOKEN = 9998;
  TOOLTOKEN = 9999;

type
    AssemblySyntax = (asATnT, asIntel);
    ContextData = (cdLocals, cdCallStack, cdWatches, cdThreads);
    ContextDataSet = set of ContextData;
    TCallback = procedure(Output: TStringList) of object;

	PList = ^TList;

  TWatchBreakOn = (wbRead, wbWrite, wbBoth);
	PWatchPt = ^TWatchPt;
	TWatchPt = packed record
		Name: string;
		Value: String;
		BPNumber: Integer;
		BPType: TWatchBreakOn;
		Token: Longint;       // Last used Token - not necessarily unique!
		Inactive: Boolean;    // Unused at present
		Deleted: Boolean;     // deleted by GDB
	end;

    ReadThread = class(TThread)

    public
        ReadChildStdOut: THandle;

    protected

        procedure Execute; override;

        // called when the thread exits - whether it terminates normally or is
        // stopped with Delete() (but not when it is Kill()ed!)
        //  OnExit: procedure;

    end;

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
        EFLAGS: string;
        CS: string;
        DS: string;
        SS: string;
        ES: string;
        GS: string;
        FS: string;
    end;
    TRegistersCallback = procedure(Registers: TRegisters) of object;
    TString = class
    public
        Str: string;
        constructor Create(AStr: string);
    end;

     PBreakpoint = ^TBreakpoint;
    TBreakpoint = class
    public
        Index: Integer;
        Valid: Boolean;
        Editor: TEditor;
        Filename: string;
        Line: Integer;
        BPNumber: Integer;
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

// redundant ? 20110409
    PWatch = ^TWatch;
    
    TWatch = packed record
        Name: string;
        Address: string;
        BreakOn: TWatchBreakOn;
        ID: Integer;
    end;
// end redundant

	PDebuggerThread = ^TDebuggerThread;
	TDebuggerThread = packed record
		Active: Boolean;
		Index: String;
		ID: String;
	end;

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    TCommand = class
    public
        Data: TObject;
        Command: String;
        Callback: procedure of object;
        OnResult: procedure(Output: TStringList) of object;
    end;

    PCommand = ^TCommand;

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    PCommandWithResult = ^TCommandWithResult;
    TCommandWithResult = class(TCommand)
    public
        constructor Create;
        destructor Destroy; override;
    public
        Event: THandle;
        Result: TStringList;
    end;

    ////////////////////////////////////
    // TDebugger
    /////////////////////////////////
    TDebugger = class

    public
        handle: THandle;

        constructor Create; virtual;
        destructor Destroy; override;
        procedure Launch(commandline, startupdir: String); virtual;
        procedure Execute(filename, arguments: string); virtual; abstract;
        procedure DisplayError(s: string);
        procedure CreateChildProcess(ChildCmd: String;
            StdIn: THandle; StdOut: THandle; StdErr: THandle);
        procedure QueueCommand(command, params: String); overload; virtual;
        procedure QueueCommand(command: TCommand); overload; virtual;
        procedure SendCommand; virtual;
		function  KillProcess(PID: DWORD): Boolean;
        procedure CloseDebugger(Sender: TObject); virtual;

    private
        Token: Longint;

    protected
        fBusy: Boolean;
        fPaused: Boolean;
        fExecuting: Boolean;
        fDebugTree: TListView;
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
        Reader: ReadThread;
        CurOutput: TStringList;
		TargetPID: Integer;
		DebuggerPID: DWORD;

        procedure OnOutput(Output: string); virtual; abstract;

        function GetBreakpointFromIndex(index: integer): TBreakpoint;

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
        property DebugTree: TListView read fDebugTree write fDebugTree;

    public

        //Callback functions
        OnVariableHint: procedure(Hint: string) of object;
        OnDisassemble: procedure(Disassembly: string) of object;
        OnRegisters: procedure(Registers: TRegisters) of object;
        OnCallStack: procedure(Callstack: TList) of object;
        OnThreads: procedure(Threads: TList) of object;
        OnLocals: procedure(Locals: TList) of object;

        //Debugger basics
        procedure Attach(pid: integer); virtual; abstract;
        procedure SetAssemblySyntax(syntax: AssemblySyntax); virtual; abstract;

        //Breakpoint handling
        procedure AddBreakpoint(breakpoint: TBreakpoint); virtual; abstract;
        procedure RemoveBreakpoint(breakpoint: TBreakpoint); virtual; abstract;
        procedure RemoveAllBreakpoints;
        procedure RefreshBreakpoints;
        procedure RefreshWatches; virtual; abstract;
        procedure RefreshBreakpoint(var breakpoint: TBreakpoint);
            virtual; abstract;
        function BreakpointExists(filename: string; line: integer): boolean;
		procedure LoadAllWatches; virtual; abstract;
		procedure ReLoadWatches; virtual; abstract;
		procedure GetWatchedValues; virtual;
		procedure AddWatch(VarName: String; when: TWatchBreakOn); virtual;
		procedure RemoveWatch(node: TTreenode); virtual;
		procedure ModifyVariable(VarName: String; Value: String); virtual;

        procedure ReplaceWxStr(Str: PString); virtual; 

		
        //Debugger control funtions
        procedure Go; virtual; abstract;
        procedure Pause; virtual;
        procedure Next; virtual; abstract;
        procedure Step; virtual; abstract;
        procedure Finish; virtual; abstract;
        procedure SetThread(thread: Integer); virtual; abstract;
        procedure SetContext(frame: Integer); virtual; abstract;
        function GetVariableHint(name: string): string; virtual; abstract;

        // Debugger virtual functions
        procedure FirstParse; virtual;
        procedure ExitDebugger; virtual;
        procedure WriteToPipe(Buffer: String); virtual;
        procedure AddToDisplay(Msg: String); virtual;

        //Source lookup directories
        procedure AddIncludeDir(s: string); virtual; abstract;
        procedure ClearIncludeDirs; virtual; abstract;

        //Variable watches
        procedure RefreshContext(refresh: ContextDataSet =
            [cdLocals, cdCallStack, cdWatches, cdThreads]);
            virtual; abstract;
//        procedure AddWatch(varname: string; when: TWatchBreakOn);
//            virtual; abstract;
//        procedure RemoveWatch(varname: string); virtual; abstract;
//        procedure ModifyVariable(varname, newvalue: string); virtual; abstract;

        //Low-level stuff
        procedure GetRegisters; virtual; abstract;
        procedure Disassemble; overload;
        procedure Disassemble(func: string); overload; virtual; abstract;
    end;

    ////////////////////////////////////
    // TGDBDebugger
    /////////////////////////////////
    TGDBDebugger = class(TDebugger)

        constructor Create; override;
        destructor Destroy; override;

    protected
        OverrideHandler: TCallback;
        RegistersFilled: Integer;
        Registers: TRegisters;
		CPURegNames: array[0..15] of String;
		CPURegValues: array[0..15] of String;
        LastWasCtrl: Boolean;
        Started: Boolean;
		LastVOident: String;
		LastVOVar: String;
		WatchPtList: TTreeView;
        // Pipe handles
        g_hChildStd_IN_Wr: THandle;		//we write to this
        g_hChildStd_IN_Rd: THandle;		//Child process reads from here
        g_hChildStd_OUT_Wr: THandle;		//Child process writes to this
        g_hChildStd_OUT_Rd: THandle;		//we read from here

    protected
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
      //  procedure OnWatchesSet(Output: TStringList);

        procedure FillBreakpointNumber(SrcFile: PString; Line: Integer; Num: Integer);

    public
        //Debugger control
        procedure Attach(pid: integer); override;
       
        // Debugger virtual functions
        procedure FirstParse; override;
        procedure ExitDebugger; override;
        procedure WriteToPipe(Buffer: String); override;
        procedure AddToDisplay(Msg: String); override;

        procedure Launch(commandline, startupdir: String); override;
        procedure Execute(filename, arguments: string); override;

        procedure Cleanup;
		procedure CloseDebugger(Sender: TObject); override;
		function  Notify(buf: PChar; bsize: PLongInt; verbose: Boolean): PChar;
        procedure SendCommand; override;
        function SendToDisplay(buf: PChar; bsize: PLongInt;
            verbose: Boolean): PChar;

        //Set the include paths
        procedure AddIncludeDir(s: string); override;
        procedure ClearIncludeDirs; override;

        //Override the breakpoint handling
        procedure AddBreakpoint(breakpoint: TBreakpoint); override;
        procedure RemoveBreakpoint(breakpoint: TBreakpoint); override;
        procedure RefreshBreakpoint(var breakpoint: TBreakpoint); override;
//        procedure RefreshWatches; override;

        //Variable watches
        procedure RefreshContext(refresh: ContextDataSet =
            [cdLocals, cdCallStack, cdWatches,
            cdThreads]); override;
        procedure AddWatch(varname: string; when: TWatchBreakOn); override;
        
		procedure LoadAllWatches; override;
		procedure ReLoadWatches; override;
		procedure RemoveWatch(node: TTreenode); override;
		procedure GetWatchedValues; override;
		procedure FillWatchValue(Msg: String);
		procedure FillTooltipValue(Msg: String);
		procedure ModifyVariable(VarName: String; Value: String); override; 

        // Parser functions
        function  GetToken(buf: PChar; bsize: PLongInt;
            Token: PInteger): PChar;
        function  FindFirstChar(Str: String; c: Char): Integer;
        function  Result(buf: PChar; bsize: PLongInt): PChar;
        function  ExecResult(buf: PChar; bsize: PLongInt): PChar;
        function  breakOut(Next: PPChar; bsize: PLongInt): String;
        function  ParseConst(Msg: PString; Vari: PString;
            Value: PString): Boolean; overload;
        function  ParseConst(Msg: PString; Vari: PString;
            Value: PInteger): Boolean; overload;
        function  ParseConst(Msg: PString; Vari: PString;
            Value: PBoolean): Boolean; overload;
		function  ExtractLocals(Str: PString): String;
		function  ParseResult(Str: PString; Level: Integer; List: TList): String;
		function  ExtractList(Str: PString; Tuple: Boolean; Level: Integer; List: TList): String;
		function  ParseValue(Str: PString; Level: Integer; List: TList): String;
        function  SplitResult(Str: PString; Vari: PString): String;
        function  ExtractWxStr(Str: PString): String;
		procedure ReplaceWxStr(Str: PString); override;
        function  ExtractBracketed(Str: PString; start: Pinteger;
            next: PInteger; c: Char; inclusive: Boolean): String;
        function  ExtractNamed(Src: PString; Target: PString;
            count: Integer): String;
		function  ParseVObjCreate(Msg: String): Boolean;
		function  ParseVObjAssign(Msg: String): Boolean;
        procedure ParseWatchpoint(Msg: String);
        procedure ParseWatchpointError(Msg: String);


		procedure ParseBreakpoint(Msg: String; List: PList);
		procedure ParseBreakpointTable(Msg: String);
		procedure ParseCPUDisassem(Msg: String);
		function  ParseCPUMixedMode(List: String): String;
		function  ParseCPUDisasmMode(List: String; CurrentFuncName: PString): String;
		procedure ParseRegisterNames(Msg: String);
		procedure ParseRegisterValues(Msg: String);
		procedure ParseCPUMemory(Msg: String);
        procedure ParseStack(Msg: String);
        function  ParseFrame(Msg: String; Frame: PStackFrame): String;
        procedure ParseThreads(Msg: String);
        procedure WatchpointHit(Msg: PString);
        procedure BreakpointHit(Msg: PString);
        procedure StepHit(Msg: PString);
		procedure WptScope(Msg: PString);		
        procedure SigRecv(Msg: PString);

        //Debugger control
        procedure Go; override;
        procedure Next; override;
        procedure Step; override;
        procedure Finish; override;
        procedure Pause; override;
        procedure SetThread(thread: Integer); override;
        procedure SetContext(frame: Integer); override;
        function  GetVariableHint(name: string): string; override;

        //Low-level stuff
        procedure GetRegisters; override;
        procedure Disassemble(func: string); overload; override;
        procedure SetAssemblySyntax(syntax: AssemblySyntax); override;
    end;

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    TCDBDebugger = class(TDebugger)
        constructor Create; override;
        destructor Destroy; override;

    protected
        LocalsList: TList;
        procedure OnOutput(Output: string); override;

        //Instruction callbacks
        procedure OnTrace;

        //Parser callbacks
        procedure OnBreakpointSet(Output: TStringList);
        procedure OnRefreshContext(Output: TStringList);
        procedure OnVariableHint(Output: TStringList);
        procedure OnDisassemble(Output: TStringList);
        procedure OnCallStack(Output: TStringList);
        procedure OnRegisters(Output: TStringList);
        procedure OnThreads(Output: TStringList);
        procedure OnLocals(Output: TStringList);
        procedure OnDetailedLocals(Output: TStringList);

    public
        //Run the debugger
        procedure Attach(pid: integer); override;
        procedure Execute(filename, arguments: string); override;

        //Set the include paths
        procedure AddIncludeDir(s: string); override;
        procedure ClearIncludeDirs; override;

        //Override the breakpoint handling
        procedure AddBreakpoint(breakpoint: TBreakpoint); override;
        procedure RemoveBreakpoint(breakpoint: TBreakpoint); override;
        procedure RefreshBreakpoint(var breakpoint: TBreakpoint); override;
        procedure RefreshWatches; override;

        //Variable watches
        procedure RefreshContext(refresh: ContextDataSet =
            [cdLocals, cdCallStack, cdWatches, cdThreads]); override;
        procedure AddWatch(varname: string; when: TWatchBreakOn); override;
        //procedure RemoveWatch(varname: string); override;

        //Debugger control
        procedure Go; override;
        procedure Next; override;
        procedure Step; override;
        procedure Finish; override;
        procedure SetThread(thread: Integer); override;
        procedure SetContext(frame: Integer); override;
        function GetVariableHint(name: string): string; override;

        // Debugger virtual functions
        procedure FirstParse; override;
        procedure ExitDebugger; override;
        procedure WriteToPipe(Buffer: String); override;
        procedure AddToDisplay(Msg: String); override;

        //Low-level stuff
        procedure GetRegisters; override;
        procedure Disassemble(func: string); overload; override;
    end;

var
    Breakpoints: TList;

implementation

uses
    devcfg, Forms, madExcept, main, MultiLangSupport,
    prjtypes, RegExpr, //dbugintf,  EAB removed Gexperts debug stuff.
    StrUtils, utils;

procedure ReadThread.Execute;

var
    BufMem: PChar;           // The originally allocated memory (pointer 'buf' gets moved!)
    BytesAvailable: DWORD;
    PipeBufSize: DWORD;
    BytesToRead: DWORD;
    LastRead: DWORD;
    BufType: DWORD;
    TotalBytesRead: DWORD;
    ReadSuccess: Boolean;

    Buffer: String;


begin

    buf := Nil;
    BytesAvailable := 0;
    BytesToRead := 0;
    LastRead := 0;
    TotalBytesRead := 0;

    while (not Terminated) do
    begin
        Sleep(100);       // Give other processes some time

        PeekNamedPipe(ReadChildStdOut, Nil, 0, Nil, @BytesAvailable, @BytesToRead);

                        // Poll the pipe buffer
        if ( (BytesAvailable > 0) and (buf = Nil)) then
                        // Indicates data is available and
                        // the buffer is unused or empty and can accept data.
                        // When done, the handler must free the memory and
                        // set bytesInBuffer to zero in order for this to accept
                        // more data.
                        // BytesAvailable and bytesInBuffer > zero (for any length
                        // of time) could indicate a possible deadlock.
                        // (Resolve this by counting iterations round the loop
                        // while bytesInBuffer > zero and set an arbitrary limit? )
                        //(This possible deadlock has never been observed!)
        begin
			if (MainForm.VerboseDebug.Checked) then
			begin
				Buffer := 'PeekPipe bytes available: ' + IntToStr(BytesAvailable);
				//gui_critSect.Enter();               // Maybe needed while debugging
				MainForm.fDebugger.AddtoDisplay(Buffer);
				//gui_critSect.Leave();               // Maybe needed while debugging
			end;

        try
			BufMem := AllocMem(BytesAvailable+16);          
                                                          // bump it up just to give some in hand
                                                          // in case we screw up the count!
                                                          // NOTE: WE do not free the memory
                                                          // but rely on it being freed externally.

			ReadSuccess := ReadFile(ReadChildStdOut, BufMem^, BytesAvailable, LastRead, Nil);
			if (ReadSuccess) then
			begin

{$ifdef DISPLAYOUTPUT}
				Buffer := 'Readfile (Pipe) bytes read: ' + IntToStr(LastRead);
				// gui_critSect.Enter();               // Maybe needed while debugging
				MainForm.fDebugger.AddtoDisplay(Buffer);
				// gui_critSect.Leave();               // Maybe needed while debugging
{$endif}
            Sleep(5);                              // Allow the pipe to refill
            TotalBytesRead := LastRead;
            PeekNamedPipe(ReadChildStdOut, Nil, 0, Nil, @BytesAvailable, @BytesToRead);
            while (BytesAvailable > 0) do
            begin
              ReAllocMem(BufMem, TotalBytesRead + BytesAvailable + 16);
              ReadSuccess := ReadSuccess and
                  ReadFile(ReadChildStdOut, (BufMem+TotalBytesRead)^, BytesAvailable, LastRead, Nil);

{$ifdef DISPLAYOUTPUT}
				Buffer := 'Readfile (Pipe) bytes read: ' + IntToStr(LastRead);
				// gui_critSect.Enter();               // Maybe needed while debugging
				MainForm.fDebugger.AddtoDisplay(Buffer);
				// gui_critSect.Leave();               // Maybe needed while debugging
{$endif}

              TotalBytesRead := TotalBytesRead + LastRead;
              Sleep(5);                              // Allow the pipe to refill
              PeekNamedPipe(ReadChildStdOut, Nil, 0, Nil, @BytesAvailable, @BytesToRead);
            end;
            if ((LastRead > 0) and (ReadSuccess)) then
              begin
                buf := BufMem;
                buf[TotalBytesRead] := (#0);  // Terminate it, thus can handle as Cstring

{$ifdef DISPLAYOUTPUT}
                Buffer := 'Readfile (Pipe) total bytes read: ' + IntToStr(TotalBytesRead);
                // gui_critSect.Enter();               // Maybe needed while debugging
                MainForm.fDebugger.AddtoDisplay(Buffer);
                // gui_critSect.Leave();               // Maybe needed while debugging
{$endif}
{$ifdef DISPLAYOUTPUTHEX}
                // gui_critSect.Enter();               // Maybe needed while debugging
                HexDisplay(buf, TotalBytesRead);
                // gui_critSect.Leave();               // Maybe needed while debugging

{$endif}

//            Pass details (Pointer, length) of the buffer to the Parser
//             in Global vars (buf: PChar and bytesInBuffer: DWORD) and
//             run the Parser and all that follows in the main thread.

              bytesInBuffer := TotalBytesRead;
              Synchronize(MainForm.fDebugger.FirstParse);
            end;
          end;  // of Readfile
        except
          on EOutOfMemory do MainForm.fDebugger.DisplayError('Unable to allocate memory to read Debugger output');
        end;
      end;  // ... of main loop

    end;    // ... of while(Terminated)

end;

//=============================================================
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

constructor TString.Create(AStr: String);
begin
    Str := AStr;
end;

function GenerateCtrlCEvent(PGenerateConsoleCtrlEvent: Pointer): DWORD;
    stdcall;
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

//////////////////////////////////////////
// TDebugger
/////////////////////////////////////////
constructor TDebugger.Create;
begin
    CurOutput := TStringList.Create;
    SentCommand := False;
    fExecuting := False;

    JumpToCurrentLine := False;
    CommandQueue := TList.Create;
    IncludeDirs := TStringList.Create;
    FileName := '';
    Event := CreateEvent(nil, false, false, nil);

    buf := Nil;
    bytesInBuffer := 0;

end;

//=============================================================

procedure TDebugger.GetWatchedValues;
begin
end;

procedure TDebugger.AddWatch(VarName: String; when: TWatchBreakOn);
begin
end;

procedure TDebugger.RemoveWatch(node: TTreenode);
begin
end;

procedure TDebugger.ModifyVariable(VarName: String; Value: String);
begin
end;

procedure TDebugger.ReplaceWxStr(Str: PString);
begin
end;

procedure TDebugger.Launch(commandline, startupdir: String);
begin
end;

//=============================================================

destructor TDebugger.Destroy;
begin

    if (buf <> Nil) then
        FreeMem(buf);

    CloseDebugger(nil);
    CloseHandle(Event);
    RemoveAllBreakpoints;

    CurOutput.Free;
    CommandQueue.Free;
    IncludeDirs.Free;

    inherited Destroy;
end;

//=============================================================
function TDebugger.KillProcess(PID: DWORD): Boolean;
// returns 'TRUE' on success
var
	hProc: THandle;

begin
	KillProcess := false;
	hProc := OpenProcess(PROCESS_TERMINATE,FALSE,PID);
	if (not(hProc = 0)) then
	begin
		if(TerminateProcess(hProc,0)) then
			begin
// 				process terminated
				CloseHandle(hProc);
				KillProcess := true;
			end
    end;
end;

//=============================================================

procedure TDebugger.RemoveAllBreakpoints;
var
    I: integer;
begin
    for I := 0 to Breakpoints.Count - 1 do
        RemoveBreakpoint(Breakpoints[I]);
end;

//=============================================================

procedure TDebugger.RefreshBreakpoints;
var
    I: Integer;
begin
    //Refresh the execution breakpoints
    for I := 0 to Breakpoints.Count - 1 do
        RefreshBreakpoint(PBreakPoint(Breakpoints.Items[I])^);
end;

//=============================================================

procedure TDebugger.CloseDebugger(Sender: TObject);

begin

end;

//  All moved in to TGDBDebugger. was:
{
var
i :integer;
begin
    if Executing then
    begin

        fPaused := false;
        fExecuting := false;

        //      Note we SHOULD NOT pull the plug on GDB debugger unless it fails
        //      to stop when commanded to exit (manual page 306: Quitting GDB)
        //      Would similar considerations apply to other debuggers?

        // First don't let us be called twice. Set the secondary threads to not call
        // us when they terminate

  //GAR     Reader.OnTerminate := nil;

        // Force the read on the input to return by closing the stdin handle.
        // Wait.Stop := True;
 //GAR       SetEvent(Event);
  //GAR      TerminateProcess(hPid, 0);
        //  Wait.Terminate;
        //  Wait := nil;
  //GAR      Reader.Terminate;

  //GAR      Reader := nil;

        //Close the handles
        //   if (not CloseHandle(hPid)) then
        //      DisplayError('CloseHandle - process handle');
        //  if (not CloseHandle(hOutputRead)) then
        //     DisplayError('CloseHandle - output read');
        //    if (not CloseHandle(hInputWrite)) then
        //     DisplayError('CloseHandle - input write');

        MainForm.RemoveActiveBreakpoints;

        //Clear the command queue
        CommandQueue.Clear;
        CurrentCommand := nil;
    end;
end;
}

//=============================================================

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

//=============================================================

procedure TDebugger.QueueCommand(command: TCommand);
var
    Ptr: PCommand;
begin
    //Copy the object
    New(Ptr);
    Ptr^ := command;
    Command.Command := Command.Command;

    //Add it into our list of commands
    CommandQueue.Add(Ptr);

    //Can we execute the command now?
    if Executing and Paused then
        SendCommand;
end;

//=============================================================

procedure TDebugger.SendCommand;
begin
end;

//=============================================================

procedure TDebugger.OnGo;
begin
    fPaused := False;
end;

//=============================================================

// Debugger virtual functions
procedure TDebugger.FirstParse;
begin
end;

procedure TDebugger.ExitDebugger;
begin
end;

procedure TDebugger.WriteToPipe(Buffer: String);
begin
end;

procedure TDebugger.AddToDisplay(Msg: String);
begin
end;

//=============================================================

procedure TDebugger.CreateChildProcess(ChildCmd: String; StdIn: THandle;
    StdOut: THandle; StdErr: THandle);

// Create a child process that uses the handles to previously created pipes
//   for STDIN and STDOUT.
var
    piProcInfo: PROCESS_INFORMATION;
    siStartInfo: STARTUPINFO;
    bSuccess: boolean;

begin

    // Set up members of the PROCESS_INFORMATION structure.
    ZeroMemory(@piProcInfo, SizeOf(PROCESS_INFORMATION));

    // Set up members of the STARTUPINFO structure.
    // This structure specifies the STDIN and STDOUT handles for redirection.

    ZeroMemory(@siStartInfo, sizeof(STARTUPINFO));
    siStartInfo.cb := SizeOf(STARTUPINFO);
    siStartInfo.hStdError := StdErr;
    siStartInfo.hStdOutput := StdOut;
    siStartInfo.hStdInput := StdIn;
    siStartInfo.dwFlags := siStartInfo.dwFlags or STARTF_USESTDHANDLES;

    // Hide child window
    siStartInfo.dwFlags := siStartInfo.dwFlags or STARTF_USESHOWWINDOW;
    //   siStartInfo.wShowWindow = siStartInfo.wShowWindow |= SW_SHOWDEFAULT; //SW_HIDE;
    siStartInfo.wShowWindow := SW_HIDE;

    // Create the child process.

    bSuccess := CreateProcess(Nil,
        PChar(ChildCmd),          // command line
        Nil,                      // process security attributes
        Nil,                      // primary thread security attributes
        TRUE,                     // handles are inherited
        0,                        // creation flags
        Nil,                      // use parent's environment
        Nil,                      // use parent's current directory
        siStartInfo,              // STARTUPINFO pointer
        piProcInfo);              // receives PROCESS_INFORMATION

    // If an error occurs, exit the application.
    if (not bSuccess) then
        DisplayError('Cannot create process: ' + ChildCmd)
    // WARNING ! ! ! Delphi gives a Thread error: The handle is invalid (6)
    //               if the child's _Command Line_ is invalid  ! ! !
    else
    begin
        // Close handles to the child process and its primary thread.
	       // Some applications might keep these handles to monitor the status
	       // of the child process, for example.

        CloseHandle(piProcInfo.hProcess);
        CloseHandle(piProcInfo.hThread);
		DebuggerPID := piProcInfo.dwProcessId;
        fExecuting := True;
        fPaused := True;
    end;
end;

//=============================================================

procedure TDebugger.DisplayError(s: string);
begin
    MessageDlg('Error with debugging process: ' + s, mtError,
        [mbOK], Mainform.Handle);
end;

//=============================================================

procedure TDebugger.OnNoDebuggingSymbolsFound;
var
    opt: TCompilerOption;
    idx: integer;
    spos: integer;
    opts: TProjProfile;

begin
    if MessageDlg(Lang[ID_MSG_NODEBUGSYMBOLS], mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then
    begin
        CloseDebugger(nil);
        if ((devCompiler.CompilerType = ID_COMPILER_MINGW) or
            (devCompiler.CompilerType = ID_COMPILER_LINUX)) then
        begin
            if devCompiler.FindOption('-g3', opt, idx) then
            begin
                opt.optValue := 1;
                if not Assigned(MainForm.fProject) then
                    devCompiler.Options[idx] := opt;
                // set global debugging option only if not working with a project
                MainForm.SetProjCompOpt(idx, True);
                // set the project's correpsonding option too

                // remove "-s" from the linker''s command line
                if Assigned(MainForm.fProject) then
                begin
                    opts := MainForm.fProject.CurrentProfile;
                    // look for "-s" in all the possible ways
                    // NOTE: can't just search for "-s" because we might get confused with
                    //       some other option starting with "-s...."
                    spos := Pos('-s ', opts.Linker); // following more opts
                    if spos = 0 then
                        spos := Pos('-s'#13, opts.Linker); // end of line
                    if spos = 0 then
                        spos := Pos('-s_@@_', opts.Linker);
                    // end of line (dev 4.9.7.3+)
                    if (spos = 0) and (Length(opts.Linker) >= 2) and
                        // end of string
                        (Copy(opts.Linker, Length(opts.Linker) - 1, 2) =
                        '-s') then
                        spos := Length(opts.Linker) - 1;

                    // if found, delete it
                    if spos > 0 then
                        Delete(opts.Linker, spos, 2);

                end;

                // remove "--no-export-all-symbols" from the linker''s command line
                if Assigned(MainForm.fProject) then
                begin
                    opts := MainForm.fProject.CurrentProfile;
                    // look for "--no-export-all-symbols"
                    spos := Pos('--no-export-all-symbols', opts.Linker);
                    // following more opts
                    // if found, delete it
                    if spos > 0 then
                        Delete(opts.Linker, spos,
                            length('--no-export-all-symbols'));

                end;

                // remove -s from the compiler options
                if devCompiler.FindOption('-s', opt, idx) then
                begin
                    opt.optValue := 0;
                    if not Assigned(MainForm.fProject) then
                        devCompiler.Options[idx] := opt;
                    // set global debugging option only if not working with a project
                    MainForm.SetProjCompOpt(idx, False);
                    // set the project's correpsonding option too
                end;
            end;
        end
        else
        if devCompiler.CompilerType in ID_COMPILER_VC then
            if devCompiler.FindOption('/ZI', opt, idx) then
            begin
                opt.optValue := 1;
                if not Assigned(MainForm.fProject) then
                    devCompiler.Options[idx] := opt;
                MainForm.SetProjCompOpt(idx, True);
                MainForm.fProject.CurrentProfile.Linker :=
                    MainForm.fProject.CurrentProfile.Linker + '/Debug';
            end;
        MainForm.Compiler.OnCompilationEnded := MainForm.doDebugAfterCompile;
        MainForm.actRebuildExecute(nil);
    end;
end;

//=============================================================

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

//=============================================================

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

//=============================================================

procedure TDebugger.OnAccessViolation;
begin
    Application.BringToFront;
    case MessageDlg(Lang[ID_MSG_SEGFAULT], mtError, [mbYes, mbNo, mbAbort],
            MainForm.Handle) of
        mrNo:
            Go;
        mrAbort:
            CloseDebugger(nil);
        mrYes:
            JumpToCurrentLine := True;
    end;
end;

//=============================================================

procedure TDebugger.OnBreakpoint;
begin
    Application.BringToFront;
    case MessageDlg(Lang[ID_MSG_BREAKPOINT], mtError,
            [mbYes, mbNo, mbAbort], MainForm.Handle) of
        mrNo:
            Go;
        mrAbort:
            CloseDebugger(nil);
        mrYes:
            JumpToCurrentLine := True;
    end;
end;

//=============================================================

procedure TDebugger.Disassemble;
begin
    Disassemble('');
end;

procedure TDebugger.Pause;
const
    CodeSize = 1024;
var
    Thread: THandle;
    BytesWritten, ThreadID, ExitCode: DWORD;
    WriteAddr: Pointer;
begin
    WriteAddr := VirtualAllocEx(hPid, nil, CodeSize, MEM_COMMIT,
        PAGE_EXECUTE_READWRITE);
    if WriteAddr <> nil then
    begin
        WriteProcessMemory(hPid, WriteAddr, @GenerateCtrlCEvent,
            CodeSize, BytesWritten);
        if BytesWritten = CodeSize then
        begin
            //Create and run the thread
            Thread := CreateRemoteThread(hPid, nil, 0, WriteAddr,
                GetProcAddress(LoadLibrary('kernel32.dll'),
                'GenerateConsoleCtrlEvent'),
                0, ThreadID);
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
        VirtualFreeEx(hPid, WriteAddr, 0, MEM_RELEASE);
        // free the memory we allocated
    end;
end;

////////////////////////////////////////////

//------------------------------------------------------------------------------
// TGDBDebugger
//------------------------------------------------------------------------------
function TGDBDebugger.ExtractNamed(Src: PString; Target: PString;
    count: Integer): String;

    // Find count-th (ONE-based) occurrence of Target in Src
    //    e.g. it returns item={ListItem2} when called with
    //     Param1 = "value=[item={ListItem1},item={ListItem2},item={ListItem3}]"
    //     Param2 = "item={"
    //     Param3 = 2
    //
    //    the last character of Target must be either '{' or '[' or '"'
    //    The target is deemed to end with the matching closing character
    //
    //    Returns a string EXCLUSIVE of the enclosing brackets/quotes
    //    Returns an empty string on failure

var
    Temp: String;
    TargetLength: Integer;
    c: Char;
    s, e, l: Integer;
    m: Char;

begin
    TargetLength := Length(Target^);
    c := AnsiLastChar(Target^)^;
    s := 1;                       // start index
    e := 1;                       // end index
    l := 0;                       // level of nesting
    m := #0;

    if (count = 0) then
        ExtractNamed := Temp
    else
    begin
        case (c) of
            '{':
                m := '}';
            '[':
                m := ']';
            '"':
                m := '"';
        end;
        Temp := Src^;
        repeat
            begin

                Temp := AnsiMidStr(Temp, e - s + 1, Length(Temp) - e + s);
                s := AnsiPos(Target^, Temp);
                if (s = 0) then
                begin
                    Temp := '';
                    ExtractNamed := Temp;
                    break; //  return Temp;

                end;
                e := s + TargetLength - 1;
                while (e <= Length(Temp)) do
                begin
                    if (Temp[e] = c) then
                        Inc(l)
                    else
                    if (Temp[e] = m) then
                    begin
                        Dec(l);
                        if (l = 0) then
                            break;
                    end;
                    Inc(e);
                end;
                Temp := AnsiRightStr(Temp, Length(Temp) - s + 1);
                Dec(count);
            end
        until not (count > 0);

        Temp := AnsiMidStr(Temp, TargetLength + 1, e - s - TargetLength);
        ExtractNamed := Temp;
    end;

end;

//=================================================================

function TGDBDebugger.ParseConst(Msg: PString; Vari: PString;
    Value: PString): Boolean;
{
   Parses out and obtains the value of one variable in a results string
   (Note: our variable must be unique within Msg)

   *Msg = ptr to Message string from GDB, containing one or many results
    of the form Var="Value",Var2="Value2" etc.
   *Vari = NAME of variable as a string -- Var in GDB documentation
   *Value = ptr to variable to receive value
       overloaded for String, long and bool only
   Returns FALSE if Vari is not found, else TRUE
}

var
    s: integer;     // Start index of "Var"
    Sub: String;

begin
    // Find our Variable
    s := AnsiPos(Vari^, Msg^);
    if (s = 0) then
        ParseConst := false
    else
    begin
        Sub := AnsiRightStr(Msg^, Length(Msg^) - s);
        // Sub = OurVar="Value",....
        Sub := ExtractBracketed(@Sub, Nil, Nil, '"', false);
        // Remove quotes
        Sub := AnsiDequotedStr(Sub, '"');
        Value^ := Sub;
        ParseConst := true;
    end;
end;

//-----------------------------------------------------------------

function TGDBDebugger.ParseConst(Msg: PString; Vari: PString;
    Value: PInteger): Boolean;
var
    Val: String;
begin

    if (ParseConst(Msg, Vari, PString(@Val)) = false) then
        ParseConst := false
    else
    begin
        Value^ := StrToInt(Val);
        ParseConst := true;
    end;
end;

//-----------------------------------------------------------------

function TGDBDebugger.ParseConst(Msg: PString; Vari: PString;
    Value: PBoolean): Boolean;
var
    Val: String;
begin
    if (ParseConst(Msg, Vari, PString(@Val)) = false) then
        ParseConst := false
    else
    begin
        if ((Val = 'true') or (Val = 'y')) then
            Value^ := true
        else
        if ((Val = 'false') or (Val = 'n')) then
            Value^ := false;
        ParseConst := true;
    end;
end;

//=================================================================

function TGDBDebugger.ParseVObjCreate(Msg: String): Boolean;

//   Parses out simple Variable value
//   Does not work for compound variables: GDB returns {...}

var
  Value: String;
  VarType: String;
  ValStrings : TStringList;
  Name: String;
  start: Integer;
  Ret: Boolean;
  Buffer, Output: String;

begin

  start := 0;
  Ret := true;

  Name := ExtractBracketed(@Msg, @start, Nil, '"', false); // because 'name=' gets stripped off!

  Ret := Ret and ParseConst(@Msg, @GDBtype, PString(@VarType));


{/* If type=="wxString", do
    "-var-evaluate-expression -f natural var1.wxStringBase.protected.m_pchData"
   in stages to build the VO Tree.
   (The type when you get there is "const wxChar *"  and you get a pointer plus
   the string)
   The following works but we'd be better with the IDE to supply the name of the
   variable in question via LastVOVar.
 */}

    if (VarType = 'wxString') then
    begin

        Buffer := '-var-info-path-expression ' + Name + NL;
        Buffer := Buffer + '-var-list-children 1 ' + Name + NL;
        Buffer := Buffer + '-var-list-children 1 ' + Name + '.wxStringBase' + NL;
        Buffer := Buffer + '-var-list-children 1 ' + Name + '.wxStringBase.protected' + NL;
        Buffer := Buffer + '-var-evaluate-expression -f natural ' + Name + '.wxStringBase.protected.m_pchData' + NL;
        WriteToPipe(Buffer);
        ParseVObjCreate := false;
    end
    else
    begin
      Ret := Ret and ParseConst(@Msg, @GDBvalue, PString(@Value));
      Ret := Ret and ParseConst(@Msg, @GDBNameq, PString(@LastVOident));

      ParseVObjCreate := false;
      if (Ret) then            // If all 3 are found it probably was a VObj... but we can't prove it
      begin
        LastVOVar := '<fix me>'; //MidStr(MainForm.Edit1.Text, 17, 99);    // ! ! !  We need the real name from the IDE
        Value := OctToHex(@Value);
        Value := unescape(@Value);

        ValStrings := TStringList.Create;
        ValStrings.Add(Value);
        OnVariableHint(ValStrings);
        ValStrings.Clear; ValStrings.Free;
        
        Output := format('%s has value %s', [LastVOVar, Value]);
        // gui_critSect.Enter();
        AddToDisplay(Output);
        // gui_critSect.Leave();
        ParseVObjCreate := true;
      end;
    end;
end;

//=================================================================

function TGDBDebugger.ParseVObjAssign(Msg: String):Boolean;
{
/*
   Parses out Variable new value
   (also works for -data-evaluate-expression expr but will attach the name
    of the last VObj used to the output string unless LastVOVar has been set
    to 'expression' by the IDE).
*/
}
var
  Value: String;
  ValStrings : TStringList;
  start: Integer;
  Buffer, Output: String;

begin
  start := 0;

  Value := ExtractBracketed(@Msg, @start, Nil, '"', false); // because 'value' gets stripped off!

  ParseVObjAssign := false;
  if (start = 13) then            // 13 = length('done,value=') - Most likely it was a VObj or expression value ... but we can't prove it
  begin
    // Handle wxString
    start := Pos(wxStringBase, Value);
    if ((start < 6) and not (start = 0)) then
      Value := ExtractWxStr(@Value);
    Value := OctToHex(@Value);
    Value := unescape(@Value);
    ValStrings := TStringList.Create;
    ValStrings.Add(Value);
    OnVariableHint(ValStrings);
    ValStrings.Clear;
    ValStrings.Free;

    Output := format('%s has value %s', [LastVOVar, Value]);
    // gui_critSect.Enter();
    AddtoDisplay(Output);
    // gui_critSect.Leave();
    ParseVObjAssign := true;
  end;
end;


//=================================================================

procedure TGDBDebugger.FillTooltipValue(Msg: String);
{
/*
   Parses out the Tooltip value
*/
}
var
  Value: String;
  ValStrings : TStringList;
  start: Integer;
  Output: String;

begin
  start := 0;

  Value := ExtractBracketed(@Msg, @start, Nil, '"', false); // strip 'value'

  if (start = 13) then            // 13 = length('done,value=')
  begin
    // Handle wxString
    ReplaceWxStr(@Value);
    Value := OctToHex(@Value);
    Value := unescape(@Value);
    ValStrings := TStringList.Create;
    ValStrings.Add(Value);
    OnVariableHint(ValStrings);
    ValStrings.Clear;
    ValStrings.Free;
    if (MainForm.VerboseDebug.Checked) then
    begin
      Output := format('Tooltip has value %s', [Value]);
      // gui_critSect.Enter();
      AddtoDisplay(Output);
      // gui_critSect.Leave();
    end;
  end;
end;

//=================================================================

procedure TGDBDebugger.ParseBreakpoint(Msg: String; List: PList);
{

   Part of Third Level Parse of Output.

}
var

    Num: Integer;
    BPType: String;
    SrcFile: String;
    Line: Integer;
    Expr: String;
    Addr: String;
    Vari: PWatchVar;

    Output: String;
    {Ret: Boolean;}

begin
    Num := 0;
    Line := 0;
    {Ret := false;}

    {Ret := }ParseConst(@Msg, @GDBnumber, PInteger(@Num));
    {Ret := }ParseConst(@Msg, @GDBtype, PString(@BPType));

    if (BPType = 'breakpoint') then
    begin
        ParseConst(@Msg, @GDBaddr, PString(@Addr));
        if (ParseConst(@Msg, @GDBorig_loc, PString(@SrcFile)) and (Addr = GDBmult)) then
          Output := format('Breakpoint No %d set at multiple addresses at %s', [Num, SrcFile])
        else
        begin
			ParseConst(@Msg, @GDBline, PInteger(@Line));
			ParseConst(@Msg, @GDBfile, PString(@SrcFile));
			Output := format('Breakpoint No %d set at line %d in %s', [Num, Line, SrcFile]);
            FillBreakpointNumber(@SrcFile, Line, Num);
        end;
        if (MainForm.VerboseDebug.Checked) then
		begin
			// gui_critSect.Enter();
			AddtoDisplay(Output);
			// gui_critSect.Leave();
		end;
    end
    else
    begin
		{Ret := }ParseConst(@Msg, @GDBwhat, PString(@Expr));
		if (BPType = 'read watchpoint') then
			Output := format('Watchpoint No %d (read) set for %s', [Num, Expr]);
		if (BPType = 'acc watchpoint') then
			Output := format('Watchpoint No %d (acc) set for %s', [Num, Expr]);
		if (BPType = 'hw watchpoint') then
			Output := format('Watchpoint No %d (hw)  set for %s', [Num, Expr]);
		if (BPType = 'watchpoint') then
			Output := format('Watchpoint No %d set for %s', [Num, Expr]);
        if (MainForm.VerboseDebug.Checked) then
		begin
			// gui_critSect.Enter();
			AddtoDisplay(Output);
			// gui_critSect.Leave();
		end;
		if not(List = nil) then
		begin
			New(Vari);
			Vari.Name := format('%s',[Expr]);
			Vari.Value := '';
			List.Add(Vari);
		end;
    end;
end;

//=================================================================

procedure TGDBDebugger.ParseBreakpointTable(Msg: String);
{
   Part of Third Level Parse of Output.
}
var
    N_rows, row: Integer;
    Str: String;
    BkptStr: String;
    {Ret: Boolean;}

begin
    N_rows := 0;
    {Ret := false;}
    {Ret := }ParseConst(@Msg, @GDBnr_rows, PInteger(@N_rows));
    Str := ExtractNamed(@Msg, @GDBbody, 1);

    if (not(Str = '')) then
    begin
        for row := 1 to N_rows do
        begin
            BkptStr := ExtractNamed(@Str, @GDBbkpt, row);
            ParseBreakpoint(BkptStr, nil);
        end;
    end;

end;

//=================================================================

procedure TGDBDebugger.AddWatch(VarName: String; when: TWatchBreakOn);
{
   Adds a watch variable/expression VarName to the TTreeView list,
   and to GDB's list.
   Uses token to allow us to identify our result when it is returned.
}
var
  Watch: PWatchPt;
  Command: TCommand;
begin
  with MainForm.WatchTree.Items.Add(nil, VarName) do
  begin
    ImageIndex := 21;
    SelectedIndex := 21;
    New(Watch);
    Watch^.Name := varname;
    Watch^.Value := wpUnknown;
    Watch^.BPNumber := 0;
    Watch^.Deleted := false;
    Watch^.Token := WATCHTOKENBASE + MainForm.WatchTree.Items.Count - 1;
    Watch^.BPType := when;
    Data := Watch;
    Text := Watch^.Name + ' = ' + Watch^.Value;
  end;

  Command := TCommand.Create;
  Command.Data := Pointer(Watch);
  case when of
    wbRead:
      Command.Command := Format('%d-break-watch -r %s',
        [Watch^.Token,varname]);
    wbWrite:
      Command.Command := Format('%d-break-watch %s',
        [Watch^.Token,varname]);
    wbBoth:
      Command.Command := Format('%d-break-watch -a %s',
        [Watch^.Token,varname]);
  end;
  QueueCommand(Command);
end;

//=================================================================

procedure TGDBDebugger.LoadAllWatches;
{
   MUST ONLY BE CALLED ON GDB STARTUP

   Loads GDB with all the watches in the TTreeView list.
   Uses token to allow us to identify our returning result.
}
var
  Watch: PWatchPt;
  Command: TCommand;
  index: Integer;
begin
  with MainForm.WatchTree do
  for index := 0 to Items.Count - 1 do
  begin
    Watch := Items[index].Data;
    Watch^.Value := wpUnknown;
    Watch^.BPNumber := 0;
    Watch^.Deleted := false;
    Watch^.Token := WATCHTOKENBASE + index;
    Items[index].Text := Watch^.Name + ' = ' + Watch^.Value;

    Command := TCommand.Create;
    case Watch^.BPType of
      wbRead:
        Command.Command := Format('%d-break-watch -r %s',
          [Watch^.Token,Watch^.Name]);
      wbWrite:
        Command.Command := Format('%d-break-watch %s',
          [Watch^.Token,Watch^.Name]);
      wbBoth:
        Command.Command := Format('%d-break-watch -a %s',
          [Watch^.Token,Watch^.Name]);
    end;
    QueueCommand(Command);
  end;
end;

//=================================================================

procedure TGDBDebugger.ReLoadWatches;
{
   Automatically reloads GDB with deleted watches.

   Loads GDB with all the watches flagged as 'deleted' in the TTreeView list.
   Uses token to allow us to identify our result when it is returned.
}
var
  Watch: PWatchPt;
  Command: TCommand;
  index: Integer;
begin
  with MainForm.WatchTree do
  for index := 0 to Items.Count - 1 do
  begin
    Watch := Items[index].Data;
    if (Watch^.Deleted) then
    begin
      Watch^.Value := wpUnknown;
      Watch^.BPNumber := 0;
      Watch^.Deleted := false;
      Watch^.Token := WATCHTOKENBASE + index;
      Items[index].Text := Watch^.Name + ' = ' + Watch^.Value;

      Command := TCommand.Create;
      case Watch^.BPType of
        wbRead:
          Command.Command := Format('%d-break-watch -r %s',
            [Watch^.Token,Watch^.Name]);
        wbWrite:
          Command.Command := Format('%d-break-watch %s',
            [Watch^.Token,Watch^.Name]);
        wbBoth:
          Command.Command := Format('%d-break-watch -a %s',
            [Watch^.Token,Watch^.Name]);
      end;
      QueueCommand(Command);
    end;
  end;
end;

//=================================================================

procedure TGDBDebugger.RemoveWatch(node: TTreenode);
{
    Removes a watch from the TTreeView list and from GDB's list.
}
var
    Watch: PWatchPt;
    Command: TCommand;
begin
    //while Assigned(node) and (Assigned(node.Parent)) do
    //  node := node.Parent;

    //Then clean it up
    if Assigned(node) then
    begin
      Watch := node.Data;
      if ((Watch.BPNumber = 0) and not (Watch.Deleted)) then
      begin
        DisplayError('Internal Error: unable to identify Watchpoint');
        Exit;
      end;
      Command := TCommand.Create;
      Command.Command := Format('-break-delete %d',[watch.BPNumber]);
      QueueCommand(Command);
      Dispose(node.Data);
      MainForm.WatchTree.Items.Delete(node);
    end;
end;

//=================================================================

procedure TGDBDebugger.GetWatchedValues;
{
    Part of Third Level Parse of Output.
    Reads a list of Watched variables in the WatchTree list and emits a request
    for the present values for each in the list.


    Uses token to allow us to identify our result when it is returned.
}

var
    I: Integer;

    Watch: PWatchPt;
    Command: TCommand;

begin
    with MainForm.WatchTree do
    for I := 0 to (Items.Count - 1) do
    begin
      Watch := Items[I].Data;
      Watch.Token := WATCHTOKENBASE + I;
      Command := TCommand.Create;
      Command.Command := format('%d%s%s',[Watch.Token, GDBdataeval, Watch.Name]);
      Command.Callback := Nil;
      QueueCommand(Command);
    end;

end;

//=================================================================

procedure TGDBDebugger.FillWatchValue(Msg: String);
{
   Part of Third Level Parse of Output.
   Receives the result of a single "-data-evaluate-expression ..."
   identified by a designated token, and adds the variable value to the
   Watched variable in WachTree list.
}

var
    Value: String;
    start: Integer;
    I: Integer;
    Watch: PWatchPt;

begin
    Value := ExtractBracketed(@Msg, @start, Nil, '"', false); // must strip 'value'
    Value := OctToHex(@Value);
    ReplaceWxStr(@Value);
    I := Token - WATCHTOKENBASE;
    Watch := MainForm.WatchTree.Items[I].Data;
    Watch.Value := Value;
    MainForm.WatchTree.Items[I].Text :=
      Format('%s = %s', [Watch.Name, Watch.Value]);
    Token := 0;
end;

//=================================================================

procedure TGDBDebugger.ParseStack(Msg: String);
{

   Part of Third Level Parse of Output.

}
var
    level: Integer;
    FrameStr: String;
    Output: String;
    CallStack: TList;
    Frame: PStackFrame;
    I: Integer;

begin
    level := 0;

    if (not (Msg = '')) then
    begin
        CallStack := TList.Create;
        repeat
        begin
            Inc(level);
            New (Frame);
            FrameStr := ExtractNamed(@Msg, @GDBframe, level);
            if (FrameStr = '') then
                break;
            Output := ParseFrame(FrameStr, Frame);
            CallStack.Add(Frame);
            if (MainForm.VerboseDebug.Checked) then
                AddtoDisplay(Output);

        end
        until (level >= MAXSTACKDEPTH);               // Arbitrary limit for safety!
        if (level = MAXSTACKDEPTH) then
        if (MainForm.VerboseDebug.Checked) then
        begin
            // gui_critSect.Enter();
            AddtoDisplay('Stack is too deep, Aborting...');
            // gui_critSect.Leave();
        end;

        MainForm.OnCallStack(CallStack);

        try
        { Cleanup: must free the list items as well as the list }
        for I := 0 to (CallStack.Count - 1) do
        begin
            Frame := CallStack.Items[I];
            Dispose(Frame);
        end;
        finally
            CallStack.Free;
        end;
    end;
end;

//=================================================================

function TGDBDebugger.ParseFrame(Msg: String; Frame: PStackFrame): String;
{
   Part of Third Level Parse of Output.
}
var
    Level: Integer;
    Func: String;
    SrcFile: String;
    Line: Integer;

    Output: String;
    {Ret: Boolean;}
    SubOutput: String;
    SubOutput1: String;

begin

    Level := 0;
    Line := 0;
    {Ret := false;}

    if (not (Msg = '')) then
    begin

        Output := format('Stack Frame: %s', [Msg]);

        {Ret := }ParseConst(@Msg, @GDBlevel, PInteger(@Level));
        {Ret := }ParseConst(@Msg, @GDBfunc,  PString(@Func));
        {Ret := }ParseConst(@Msg, @GDBline,  PInteger(@Line));
        {Ret := }ParseConst(@Msg, @GDBfile,  PString(@SrcFile));
        if not (Frame = nil) then
        begin
            Frame.Filename := ExtractFileName(SrcFile);
            Frame.FuncName := format('%*s%s',[Level, '', Func]);
            Frame.Line := Line;
            Frame.Args := '';
        end;

        if (Level = 0) then
            SubOutput := 'Stopped in '
        else
            SubOutput := 'called from';
        if (Line = 0) then
            SubOutput1 := '<no line number>'
        else
            SubOutput1 := format('at Line %d',[Line]);

        Output := format('Level %2d: %*s %s  %s  %s', [Level, Level+1 , ' ', SubOutput, Func, SubOutput1]);
    end;
    ParseFrame := Output;
end;

//=================================================================

procedure TGDBDebugger.ParseThreads(Msg: String);
{
   Part of Third Level Parse of Output.
}
var

    ThreadStr: String;
    ThreadList: String;
    CurrentThread: String;
    start: Integer;
    next: Integer;
    ThreadID: String;
    TargetID: String;
    Output: String;
    Threads: TList;
    Thread: PDebuggerThread;
    I: Integer;

begin

	Threads := TList.Create;

	ParseConst(@Msg, @GDBcurthread, PString(@CurrentThread));
	ThreadList := ExtractBracketed(@Msg, @start, @next, '[', false);
	if (ThreadList = '') then
	begin
        // gui_critSect.Enter();
		AddtoDisplay('No active threads');
        // gui_critSect.Leave();
	end
	else
	begin
		// gui_critSect.Enter();
		AddtoDisplay('Current Thread ID = ' + CurrentThread);
		// gui_critSect.Leave();

		repeat
		begin
			ThreadStr := ExtractBracketed(@ThreadList, @start, @next, '{', false);
			// gui_critSect.Enter();
			AddtoDisplay('Thread: ');
			AddtoDisplay(ThreadStr);
			// gui_critSect.Leave();
			if (not(ThreadStr = '')) then
			begin
				New(Thread);
				ParseConst(@ThreadList, @GDBid, PString(@ThreadID));
				ParseConst(@ThreadList, @GDBtargetid, PString(@TargetID));
				// gui_critSect.Enter();
				AddtoDisplay('Thread ID = ' + ThreadID);
				// gui_critSect.Leave();

				Output := ParseFrame(ThreadStr, nil);
				Threads.Insert(0, Thread);
				with Thread^ do
				begin
					Active := (ThreadId = CurrentThread);
					Index := ThreadId;
					ID := TargetID + '  ' + Output;
				end;

			end;
			ThreadList := AnsiRightStr(ThreadList, Length(ThreadList) - next);
		end
		until ((ThreadList = '') or (next = 0));
	end;

	MainForm.OnThreads(Threads);

	try
      { Cleanup: must free the list items as well as the list }
	for I := 0 to (Threads.Count - 1) do
	begin
		Thread := Threads.Items[I];
		Dispose(Thread);
	end;
	finally
		Threads.Free;
	end;

end;

//=================================================================

procedure TGDBDebugger.ParseWatchpoint(Msg: String);
{
   Part of Third Level Parse of Output.

   Acknowledgement of watchpoint loaded by GDB.
   Updates the Watchpoint data record.
}
var
    Num: Integer;
    Expr: String;

    Watch: PWatchPt;
    Output: String;
    index: Integer;
    {Ret: Boolean;}
begin
    Num := 0;
    {Ret := false;}

    {Ret := }ParseConst(@Msg, @GDBnumber, PInteger(@Num));
    {Ret := }ParseConst(@Msg, @GDBexp, PString(@Expr));
    if ((Token >= WATCHTOKENBASE) and (Token < MODVARTOKEN)) then
    with MainForm.WatchTree.Items do
    begin
      if not(Count = 0) then
      begin
        for index := 0 to Count-1   do
        begin
          Watch := Item[index].Data;
          if ((Watch.Name = Expr) and (Watch.BPNumber = 0)) then
          begin
            Watch.BPNumber := Num;
            Watch.Inactive := False;
            Watch.Deleted := False;
            Item[index].Text := Format('%s = %s', [Watch.Name, Watch.Value]);
          end;
        end;
      end;
    end;
    Token := 0;
    if (MainForm.VerboseDebug.Checked) then
	begin
		Output := format('Watchpoint No %d set for %s', [Num, Expr]);
		// gui_critSect.Enter();
		AddtoDisplay(Output);
		// gui_critSect.Leave();
	end;

end;

//=================================================================

procedure TGDBDebugger.ParseWatchpointError(Msg: String);
{
   Part of Third Level Parse of Output.
   Handles errors accompanied by a Watchpoint Token.
   Updates and may delete the Watchpoint data record.
}
var
    varname: String;
    watch: pWatchPt;
    index: Integer;

begin
    // These messages were gathered from GDB source. Not all might be seen.
    if ((AnsiStartsStr(GDBError+'Expression cannot be implemented', Msg))
        // "Expression cannot be implemented with read/access watchpoint."
      or (AnsiStartsStr(GDBError+'Target does not support', Msg))
        // "Target does not support this type of hardware watchpoint."
      or (AnsiStartsStr(GDBError+'Target can only support', Msg))
        // "Target can only support one kind of HW watchpoint at a time."
      or (AnsiStartsStr(GDBError+'Junk at end of command.', Msg))
        // "Junk at end of command."
      or (AnsiStartsStr(GDBError+'Cannot watch constant value', Msg))
        // "Cannot watch constant value ..."
      or (AnsiStartsStr(GDBError+'Cannot enable watchpoint', Msg))
        // "Cannot enable watchpoint"
      or (AnsiStartsStr(GDBError+'Unexpected error setting', Msg))
        // "Unexpected error setting breakpoint or watchpoint"
      or (AnsiStartsStr(GDBError+'Cannot understand watchpoint', Msg))
        // "Cannot understand watchpoint access type."
      or (AnsiStartsStr(GDBError+'Too many watchpoints', Msg))) then
        // "Too many watchpoints"
    begin
      index := Token - WATCHTOKENBASE;
      Watch := MainForm.WatchTree.Items[index].Data;
      Dispose(Watch);
      MainForm.WatchTree.Items[index].Delete;
      DisplayError('GDB Error: ' + Msg);
    end
    else
    if (AnsiStartsStr(GDBError+GDBNoSymbol, Msg)) then
    // It has gone out of scope or doesn't exist in present context
    begin
      // Flag as deleted - it can be resurrected if/when it comes into scope
      varname := ExtractBracketed(@Msg, Nil, Nil, '"', false);
      // Find ALL watchpoints with a name starting with 'varname' and flag as deleted
      with MainForm.WatchTree do
      for index := 0 to Items.Count - 1 do
        begin
          Watch := Items[index].Data;
          if (AnsiStartsStr(varname, Watch^.Name)) then
          begin
            Watch^.Value := wpUnknown;
            Watch^.BPNumber := 0;
            Watch^.Token := 0;
            Watch^.Deleted := true;
            Items[index].Text := Watch^.Name + ' = ' + Watch^.Value;
          end;
        end;
    end
    else
    begin
      // It must be something else!
      DisplayError('GDB Error: ' + Msg);
{$ifdef DISPLAYOUTPUT}
      // gui_critSect.Enter();
      AddtoDisplay(Msg);
      // gui_critSect.Leave();
{$endif}
    end;
end;

//=================================================================

procedure TGDBDebugger.ParseCPUMemory(Msg: String);
{
   Part of Third Level Parse of Output.
   Parses memory display and writes to a RichText edit window
   in the familiar 'Hex Editor' style.
}
var
  MemList, List: String;
  memnext, next: Integer;
  i, j, b: Integer;
  displaystart, memstart, memend, mem: Int64;
  Smemstart, Smemend: String;
  MemContent: String;
  Output, AscChars: String;
  AscChar: Byte;

begin
  MemList := ExtractBracketed(@Msg, nil, @memnext, '[', false);
  repeat
  begin
    List := ExtractBracketed(@MemList, nil, @next, '{', false);
    if (not(List = '')) then
    begin
      ParseConst(@List, @GDBbegin, PString(@Smemstart));
      ParseConst(@List, @GDBend, PString(@Smemend));
      ParseConst(@List, @GDBcontents, PString(@MemContent));
      memstart := StrToInt64(Smemstart);
      memend := StrToInt64(Smemend);
      displaystart := memstart and (not $0f);
      mem := displaystart;
      //  (66 = length of preamble 'begin=" ..... contents="'
      if (memend > memstart + Trunc((Length(List) - 66) / 2)) then
        memend := memstart + Trunc((Length(List) - 66) / 2);
      i := 0;
      j := 0;
      while (mem < memend) do
      begin
        // Line loop
        AscChars := '';
        Output := Output + format('0x%8.8X ', [displaystart+i] );
        for b := 0 to 15 do
        // byte loop (Hex)
        begin
          if ((mem < memstart) or (mem >= memend)) then
          begin
            Output := Output + '   ';
            AscChars := AscChars + ' ';
          end
          else
            begin
            Output := Output + format('%.1s%.1s ',
                              [MemContent[j*2 + 1], MemContent[j*2 + 2]]);
            AscChar := StrToInt('$' + MemContent[j*2 + 1] + MemContent[j*2 + 2]);
            if ((AscChar < 32) or (AscChar > 127)) then
              AscChars := AscChars + ' '
            else
              AscChars := AscChars + Chr(AscChar);
            Inc(j);
          end;
          if ( (mem and $07) = $07) then
            Output := Output + ' ';
          Inc(mem);
          Inc(i);
        end;
          Output := Output + AscChars + NL;
      end;
    end;
  MemList := AnsiRightStr(MemList, Length(MemList) - next);
  Output := Output + NL;
  end;
  until (next = 0);

  debugCPUFrm.MemoryRichEdit.Lines.Add(Output);

end;

//=================================================================

procedure TGDBDebugger.ParseCPUDisassem(Msg: String);

{
   Part of Third Level Parse of Output.
   Initial parse of Disassembly display.
}
var
  line: String;
  List: String;
  CurrentFuncName: String;
  next: Integer;
  Output: String;

//  We expect:
//  Disassembly
//    Preamble:
//    ^done,asm_insns=[ <list 1> ]
//    <list 1> is 1 or more of
//      {address="<hex string>",func-name="<string>",offset="<int>",inst="<string>"},
//
//  Mixed Mode
//    Preamble:
//    ^done,asm_insns=[ <list 2> ]
//    <list 2> is 1 or more of
//      src_and_asm_line={ <tuple 1> },
//
//  <tuple 1> is
//  line="64",file="DebugeeFrm.cpp",line_asm_insn=[ <list 1> | empty ]
//

begin
  CurrentFuncName := '';
  List := ExtractBracketed(@Msg, nil, @next, '[', false);
  if (AnsiStartsStr(GDBsrcline, List)) then
  // Mixed Mode
    Output := ParseCPUMixedMode(List);
  if (AnsiStartsStr('{' + GDBaddress, List)) then
  // Disassemby Mode
    Output := ParseCPUDisasmMode(List, @CurrentFuncName);
  DebugCPUFrm.DisassemblyRichEdit.Lines.Add(Output);
end;

//=================================================================

function TGDBDebugger.ParseCPUMixedMode(List: String): String;
{
   Part of Third Level Parse of Output.
   Parses Mixed Mode (disassembly related to line numbers) and writes
   to a RichText edit window.
   Redundant lines, etc, are removed.
   (Takes data preprocessed by ParseCPUDisassem)

   Display algorithm for <tuple>:
 	 Extract vars but pass line_asm_insn to ParseCPUDisasmMode;
     if 'file' = same as stored, skip it
      else write it and store it;
     write vars to Output.
   Skip but report empty lines to reduce output bloat. 
}
var
  Line, LineNum, FileName, AsmInstr, Output: String;
  CurrentFileName, CurrentFuncName, FirstLine, LastLine: String;
  next: Integer;
  NoAsm: Boolean;

begin
  CurrentFileName := '';
  CurrentFuncName := '';
  NoAsm := false;

  repeat
  begin
    Line := ExtractBracketed(@List, nil, @next, '{', false);
    if (not(Line = '')) then
    begin
      ParseConst(@Line, @GDBlineq, PString(@LineNum));
      ParseConst(@Line, @GDBfileq, PString(@FileName));
      AsmInstr := ExtractBracketed(@Line, nil, nil, '[', false);
      FileName := ExtractFileName(FileName);
      
      if (not(FileName = CurrentFileName)) then
      begin
        Output := Output + format('%s: %s%s',[FileStr, FileName, NL]);
        CurrentFileName := FileName;
      end;
      if (AsmInstr = '') then
        begin
          if (NoAsm = false) then
            FirstLine := LineNum;
          NoAsm := true;
          LastLine := LineNum;
        end
      else
      begin
        NoAsm := false;
        if ((FirstLine = '') and (LastLine = '')) then
           // Do nothing!
        else if (FirstLine = LastLine) then
          Output := Output + 'Line: ' + FirstLine
            + ' ' + NoDisasmStr + NL
        else if ((FirstLine = '') or (LastLine = '')) then
          Output := Output + LineStr + ': ' + LineNum + NL
        else
          Output := Output + LinesStr + ': ' + FirstLine + ' - ' + LastLine
            + ' ' + NoDisasmStr + NL;
        Output := Output + LineStr + ': ' + LineNum + NL;
        Output := Output + ParseCPUDisasmMode(AsmInstr, @CurrentFuncName);
        FirstLine := '';
        LastLine := '';
      end;
    end;
    List := AnsiRightStr(List, Length(List) - next);
  end;
  until (next = 0);
  ParseCPUMixedMode := Output;
end;

//=================================================================

function TGDBDebugger.ParseCPUDisasmMode(List: String; CurrentFuncName: PString): String;
{
   Part of Third Level Parse of Output.
   Parses disassembly display and writes to a RichText edit window.
   (Takes data preprocessed by ParseCPUDisassem and ParseCPUMixedMode)
}
//   Disassembly Mode
//   We expect a list of
//     {address="<hex string>",func-name="<string>",offset="<int>",inst="<string>"},
{
    Display algorithm:
    	Extract vars;
      if 'func-name' = same as stored, skip it
       else write it and store it;
      write vars to Output.
}
var
  Line, Address, FuncName, Offset, Instr, Output: String;
  next: Integer;

begin
  repeat
  begin
    Line := ExtractBracketed(@List, nil, @next, '{', false);
    if (not(Line = '')) then
    begin
      ParseConst(@Line, @GDBaddress, PString(@Address));
      ParseConst(@Line, @GDBfuncname, PString(@FuncName));
      ParseConst(@Line, @GDBoffset, PString(@Offset));
      ParseConst(@Line, @GDBinstr, PString(@Instr));
      if (not(FuncName = CurrentFuncName^)) then
      begin
        Output := Output + format('%s: %s%s',[FuncStr, FuncName, NL]);
        CurrentFuncName^ := FuncName;
      end;
      Output := Output + Address + HT + Offset + HT + Instr + NL;

    end;
    List := AnsiRightStr(List, Length(List) - next);
  end;
  until (next = 0);
  ParseCPUDisasmMode := Output;
end;

//=================================================================

procedure TGDBDebugger.ParseRegisterNames(Msg:String);
{
   Part of Third Level Parse of Output.
   Parses list of register names, then generates request to get their values.
}
var
  List: String;
  start, next, i: Integer;

begin
  List := ExtractBracketed(@Msg, @start, @next, '[', false);
  for i:=0 to CPURegCount do
  begin
    CPURegNames[i] := ExtractBracketed(@List, @start, @next, '"', false);
    List := MidStr(List, next, Length(List));
  end;

  WriteToPipe('-data-list-register-values r ' + CPURegList);

end;

//=================================================================

procedure TGDBDebugger.ParseRegisterValues(Msg:String);
{
   Part of Third Level Parse of Output.
   Parses and pairs up the list of register values against the list of register names.
}
var
  List, Reg, Value: String;
  start, next, Number, i: Integer;

begin
  List := ExtractBracketed(@Msg, @start, @next, '[', false);
   
  for i:=0 to CPURegCount do
  begin
    Reg := ExtractBracketed(@List, @start, @next, '{', false);
    ParseConst(@Reg, @GDBvalue, PString(@Value));
    ParseConst(@Reg, @GDBnumber, PInteger(@Number));
    if ((Number >= 0) and (Number <= CPURegCount)) then
      CPURegValues[Number] := Value;
    List := MidStr(List, next, Length(List));
    if (MainForm.VerboseDebug.Checked) then
      AddtoDisplay(CPURegNames[i] + '  '+CPURegValues[i]);
    DebugCPUFrm.RegisterList.InsertRow(CPURegNames[i], Value, true);
  end;

{      If the 'natural' order of registers as GDB sends them is good enough,
       then retain the last 2 lines above, then the Registers class and the rest
       below can be removed.

  Registers := TRegisters.Create;
  for i:= 0 to CPURegCount do
  begin
    if      (CPURegNames[i] = 'eax') then Registers.EAX := CPURegValues[i]
    else if (CPURegNames[i] = 'ebx') then Registers.EBX := CPURegValues[i]
    else if (CPURegNames[i] = 'ecx') then Registers.ECX := CPURegValues[i]
    else if (CPURegNames[i] = 'edx') then Registers.EDX := CPURegValues[i]
    else if (CPURegNames[i] = 'esi') then Registers.ESI := CPURegValues[i]
    else if (CPURegNames[i] = 'edi') then Registers.EDI := CPURegValues[i]
    else if (CPURegNames[i] = 'ebp') then Registers.EBP := CPURegValues[i]
    else if (CPURegNames[i] = 'esi') then Registers.ESI := CPURegValues[i]
    else if (CPURegNames[i] = 'esp') then Registers.ESP := CPURegValues[i]
    else if (CPURegNames[i] = 'eip') then Registers.EIP := CPURegValues[i]
    else if (CPURegNames[i] = 'eflags') then Registers.EFLAGS := CPURegValues[i]
    else if (CPURegNames[i] = 'cs') then Registers.CS := CPURegValues[i]
    else if (CPURegNames[i] = 'ds') then Registers.DS := CPURegValues[i]
    else if (CPURegNames[i] = 'ss') then Registers.SS := CPURegValues[i]
    else if (CPURegNames[i] = 'es') then Registers.ES := CPURegValues[i]
    else if (CPURegNames[i] = 'gs') then Registers.GS := CPURegValues[i]
    else if (CPURegNames[i] = 'fs') then Registers.FS := CPURegValues[i];
  end;
  if (MainForm.VerboseDebug.Checked)
    AddtoDisplay(CPURegNames[i] + '  '+CPURegValues[i]);
  DebugCPUFrm.RegisterList.InsertRow(CPURegNames[i], Value, true);
}

end;

//=================================================================

procedure TGDBDebugger.WatchpointHit(Msg: PString);
{
   INCOMPLETE
   Does nothing with the result apart from writing to display
   Needs to build a list to pass back to the IDE
   Parses out Watchpoint details
   May be easier to split this for the 3 types of Watchpoint
}
var
    Temp: String;
    Num, Line: Integer;
    Expr, Wpt, Val, Old, New, Value, Func, SrcFile, frame, Output: String;
    hasOld, hasNew, hasValue: Boolean;
    //Ret: Boolean;

begin
    Temp := Msg^;
    Num := 0;
    Line := 0;

    //Ret := false;
    Val := ExtractNamed(@Temp, @GDBvalueqb, 1);
    Wpt := ExtractNamed(@Temp, @GDBwpt, 1);
    {Ret := }ParseConst(@Wpt, @GDBnumber, PInteger(@Num));

    hasOld := ParseConst(@Val, @GDBold, PString(@Old));
    if (hasOld) then
        Old := ' was ' + Old;
    hasNew := ParseConst(@Val, @GDBnew, PString(@New));
    if (hasNew) then
        New := ' now ' + New;
    hasValue := ParseConst(@Val, @GDBvalue, PString(@Value));
    if (hasValue) then
        Value := ' Presently ' + Value;

    {Ret := }ParseConst(@Wpt, @GDBexp, PString(@Expr));

    Frame := ExtractNamed(@Temp, @GDBframe, 1);
    {Ret := }ParseConst(@Frame, @GDBfile, PString(@SrcFile));
    {Ret := }ParseConst(@Frame, @GDBfunc, PString(@Func));
    {Ret := }ParseConst(@Frame, @GDBline, PInteger(@Line));

    if (MainForm.VerboseDebug.Checked) then
	begin
		Output := Format('Watchpoint No %d hit. %s%s%s%s in %s at line %d in %s',
			[Num, Expr, Old, New, Value, Func, Line, SrcFile]);
		// gui_critSect.Enter();
		AddtoDisplay(Output);
		// gui_critSect.Leave();
	end;

    // Line No. is not meaningful - need to find some way to relate to source line in editor,
    //  else disable GDB's ability to trace into headers/libraries.
    MainForm.GotoBreakpoint(SrcFile, Line);
end;

//=================================================================

procedure TGDBDebugger.BreakpointHit(Msg: PString);
// Parses out Breakpoint details

var
    Temp: String;
    Num, Line: Integer;
    Func, SrcFile, frame, Output: String;
    //Ret: Boolean;

begin

    Temp := Msg^;
    Num := 0;

    //Ret := false;

    {Ret := }ParseConst(Msg, @GDBbkptno, PInteger(@Num));
    Frame := ExtractNamed(@Temp, @GDBframe, 1);
    {Ret := }ParseConst(@frame, @GDBfile, PString(@SrcFile));
    {Ret := }ParseConst(@frame, @GDBfunc, PString(@Func));
    {Ret := }ParseConst(@frame, @GDBline, PInteger(@Line));

    if (MainForm.VerboseDebug.Checked) then
	begin
		Output := Format('Breakpoint No %d hit in %s at line %d in %s',
			[Num, Func, Line, SrcFile]);
		// gui_critSect.Enter();
		AddtoDisplay(Output);
		// gui_critSect.Leave();
	end;

    // Line No. is not always meaningful - need to find some way to relate to source line in editor,
    //  else disable GDB's ability to trace into headers/libraries.
    MainForm.GotoBreakpoint(SrcFile, Line);
end;

//=================================================================

procedure TGDBDebugger.ModifyVariable(VarName: String; Value: String);
{
/*
   Writes 3 commands in succession to create a Variable Object, change its
   value and then delete the Variable Object.
   The name for the VO is made from the Variable Name with certain characters
   replaced and prefixed with 'VO'. I.E. MyClass.Prop[3] is named
     MyClass_Prop_3_
   Uses token to allow us to identify our result when it is returned.
*/
}
var
  VOName: String;
  i: Integer;

begin
  VOName := VarName;
  // create a name
  for i := 1 to length(VOName) do
    if ((VOName[i] = '.') or (VOName[i] = '[') or (VOName[i] = ']')) then
      VOName[i] := '_';

{$ifdef DISPLAYOUTPUT}
  AddtoDisplay(format('Writing %d-var-create VO%s @ %s',[MODVARTOKEN, VOName, VarName]));
  AddtoDisplay(format('Writing %d-var-assign VO%s %s',[MODVARTOKEN, VOName, Value]));
  AddtoDisplay(format('Writing %d-var-delete VO%s',[MODVARTOKEN, VOName]));
{$endif}
  WriteToPipe(format('%d-var-create VO%s @ %s',[MODVARTOKEN, VOName, VarName]));
  WriteToPipe(format('%d-var-assign VO%s %s',[MODVARTOKEN, VOName, Value]));
  WriteToPipe(format('%d-var-delete VO%s',[MODVARTOKEN, VOName]));

end;

//=================================================================

procedure TGDBDebugger.WptScope(Msg: PString);
// Parses out Watchpoint details
// N.B. "Msg" may contain multiple pairs of values:
//    reason="watchpoint-scope",wpnum="n",

var
  Temp: String;
  Reason, Output: String;
  Thread: Integer;
  wpnum: Integer;
  index: Integer;
//  count: Integer;
  watch: PWatchPt;
  //Ret: Boolean;
  comma1, comma2: Integer;
  BPStr: String;

begin

  Temp := Msg^;
  // reason="watchpoint-scope",wpnum="3",  <etc> ,thread-id="1",frame={addr="0x77c2c3d9",func="msvcrt!free",args=[],from="C:\\WINDOWS\\system32\\msvcrt.dll"}'

  ParseConst(Msg, @GDBthreadid, PInteger(@Thread));
  comma1 := FindFirstChar(Temp, ',');
  Temp := AnsiMidStr(Temp, (comma1+1), Length(Temp)-comma1-1);
//  count := 1;
  repeat
    comma1 := FindFirstChar(Temp, ',');
    if (comma1 = 0) then Break;
    comma2 := FindFirstChar(AnsiMidStr(Temp, (comma1+1), Length(Temp)-comma1-1), ',');
    if (comma2 = 0) then Break;
    BPStr := AnsiLeftStr(Temp, comma1+comma2);
    Temp := AnsiMidStr(Temp, (comma1+comma2+1), Length(Temp)-comma1-comma2-1);

    ParseConst(@BPStr, @GDBreason, PString(@Reason));
    ParseConst(@BPStr, @GDBwpNum, PInteger(@wpnum));
    if ((not(Reason = '')) and (not(wpnum = 0))) then
    begin
      with MainForm.WatchTree.Items do
      begin
        if not(Count = 0) then
        begin
          for index := 0 to Count-1   do
          begin
            Watch := Item[index].Data;
            if (Watch.BPNumber = wpnum) then
            begin
              Watch.Deleted := true;
              Watch.Value := wpUnknown;
              Item[index].Text := Format('%s = %s', [Watch.Name, Watch.Value]);
              Output := Format('Stopped - %s for %s in Thread %d', [Reason, Watch.Name, Thread]);
              
            end;
          end;
        end;
      end;
    end;
//    Inc(count);
  until((Reason = '') or (wpnum = 0));

  // Restart the Target:
  //WriteToPipe(GDBcontinue);

  // gui_critSect.Enter();
  AddtoDisplay(Output);
  // gui_critSect.Leave();

end;

//=================================================================

procedure TGDBDebugger.StepHit(Msg: PString);
// Parses out Breakpoint details

var
    Temp: String;
    Line: Integer;
    Func, SrcFile, frame, Output: String;
    //Ret: Boolean;

begin

    Temp := Msg^;

    //Ret := false;

    Frame := ExtractNamed(@Temp, @GDBframe, 1);
    {Ret := }ParseConst(@frame, @GDBfile, PString(@SrcFile));
    {Ret := }ParseConst(@frame, @GDBfunc, PString(@Func));
    {Ret := }ParseConst(@frame, @GDBline, PInteger(@Line));

    if (MainForm.VerboseDebug.Checked) then
	begin
		Output := Format('Stopped in %s at line %d in %s', [Func, Line, SrcFile]);
		// gui_critSect.Enter();
		AddtoDisplay(Output);
		// gui_critSect.Leave();
	end;

    // Line No. is not meaningful - need to find some way to relate to source line in editor,
    //  else disable GDB's ability to trace into headers/libraries.
    MainForm.GotoBreakpoint(SrcFile, Line);
end;

//=================================================================


function TGDBDebugger.SplitResult(Str: PString; Vari: PString): String;
{
/*
    Expects a string of form Variable = Value, where value may be a const, tuple or list
    Returns Value:
        Variable in Var
    Str MUST be well-formed, i.e. with no unmatched braces, etc.
 */
}
var
    Val: String;

begin          // SplitResult
    Vari^ := AnsiBeforeFirst('=', Str^);
    Val := AnsiAfterFirst('=', Str^);
    Vari^ := Trim(Vari^);
    Val := Trim(Val);
    SplitResult := Val;
end;

//=================================================================

function TGDBDebugger.ExtractLocals(Str: PString): String;
// expects Str to be of form "done,locals=Result"
var
	Output: String;
	Level: Integer;
	LocalsStr: String;
	Val: String;
	Vari: String;   // This is called Var in the GDB spec !
	I: Integer;
	Local: PVariable;
	LocalsList: TList;

begin

	LocalsList := TList.Create;
	Level := 0;

	LocalsStr := AnsiMidStr(Str^, Length(GDBdone)+1, Length(Str^) - Length(GDBdone));
	if (AnsiStartsStr(GDBlocalsq, LocalsStr)) then
	begin
		LocalsStr := MidStr(Str^, Length(GDBdone)+1, Length(Str^)-Length(GDBdone));
		Val := SplitResult(@LocalsStr, @Vari);    // Must start with a List or a Tuple

		if (AnsiStartsStr('{', Val )) then
			Output := ExtractList(@LocalsStr, PARSETUPLE, Level, LocalsList)
		else // it starts '['
			Output := ExtractList(@LocalsStr, PARSELIST, Level, LocalsList);
		ExtractLocals := GDBlocalsq + Output;
	end;
	MainForm.OnLocals(LocalsList);
	try
		{ Cleanup: must free the list items as well as the list }
	for I := 0 to (LocalsList.Count - 1) do
	begin
		Local := LocalsList.Items[I];
		Dispose(Local);
	end;
	finally
		LocalsList.Free;
	end;

end;

//=================================================================

function TGDBDebugger.ParseResult(Str: PString; Level: Integer; List: TList): String;
{
/*
    Parses a Result extracted from a Result-record of the form var = value.
    The Result must NOT be enclosed in quotes, brackets or braces,
    and must be well-formed.
    A special case - wxString - is handled specially.

    [In the comments of this and the functions that follow, words like
     "Result", "Tuple", "List" with initial capitals have the meanings
     defined in the GDB formal output syntax specification.
     N.B "list" - with lower-case l - has the ordinary meaning].

    Returns the sub-string reassembled from parsing the original Str.
    wxStrings are condensed into the form var = "string"
    This is suitable for display on one line.

    Str is expected to be of the form variable = value (as defined in the formal
    specification, where value can be a Const or Tuple or List, etc
    Level is the recursion level or degree of indentation in the list
    Plist is a pointer to the TList of TVariables that accepts the list of
    local variables.
}
Var
  Output: String;
  Vari: String;   // This is called Var in the GDB spec !
  start: Integer;
  Val: String;
  Local: PWatchVar;

begin          // ParseResult
  Val := SplitResult(Str, @Vari);
  Output := Vari;
  Output := Output + ' = ';
  start := Pos(wxStringBase, Val);
  if (Vari = GDBname) then                        // a name of a Tuple
  begin
    New(Local);

    Local.Number := 0;

    Output := Output + Val;
    Local.Name := format('%*s%s',[Level*INDENT, '',
    ExtractBracketed(@Val, nil, nil, '"', false)]);
    Local.Value := '';
    List.Add(Local);
  end
  else
  if (Vari = GDBvalue) then                      // a value of named a Tuple
  begin

    ReplaceWxStr(@Val);
//    else
//    if (AnsiStartsStr('"{', Val)) then           // it's a named Tuple
//    begin
//      Output := Output + ExtractList(Str, PARSETUPLE, Level, List);
//    end

    if (AnsiStartsStr('"', Val)) then            // it's a quoted string e.g. a value of a Tuple
    begin
      New(Local);
      Local.Number := 0;
      Output := Output + OctToHex(@Val);
      if (List.Count > 0) then
        Local := List.Last;                      // so add the value to the last item
      Val := OctToHex(@Val);
      Local^.Value := Val;

      List.Remove(Local);
      List.Add(Local);
    end
    else
    begin
      if (List.Count = 0) then
      begin
          New(Local);

          Local.Number := 0;

          Local^.Value := Val;
      end
      else
      begin
          Local := List.Last;                      // so add it to the last item
          Local^.Value := Val;
          List.Remove(Local);
      end;
      List.Add(Local);
      Output := Output + Val;




    end;

  end

  else
  if (AnsiStartsStr('[', Val)) then              // it's a List
    begin

      Output := Output + ExtractList(Str, PARSELIST, Level, List);
    end

  else
  if (AnsiStartsStr('{', Val)) then              // it's a Tuple
  begin
    New(Local);
    Local.Number := 0;
    Local^.Name := format('%*s%s',[Level*INDENT, '',
      ExtractBracketed(@Vari, nil, nil, '"', false)]);
    List.Add(Local);
    Output := Output + ExtractList(Str, PARSETUPLE, Level, List);
  end
  else
  begin                                          // it's a simple Const
    New(Local);
    Local.Number := 0;
    Local^.Name := format('%*s%s',[Level*INDENT, '',
      ExtractBracketed(@Vari, nil, nil, '"', false)]);
    Val := OctToHex(@Val);
    Local^.Value := Val;
    List.Add(Local);
    Output := Output + Val;
  end;

  ParseResult := Output;
end;

//=================================================================

function TGDBDebugger.ExtractList(Str: PString; Tuple: Boolean; Level: Integer; List: TList): String;
{
    Extracts a comma-separated list of values or results from a List,
    of the form "[value(,value)*]"
             or "[result(,result)*]"

    N.B. This is recursive and will fully parse the Result tree.
}
var
	delim1, delim2: Char;
	Remainder: String;
	Item: String;
	start, next: Integer;
	Output: String;

	len, comma, lbrace, lsqbkt, equals: Integer;

begin          // ParseList

  // Get the first result or value.
    // Remove outermost "[ ]" or "{ }"
    if (Tuple) then
    begin
		delim1 := '{';
		delim2 := '}';
    end
    else   // it's a List
    begin
		delim1 := '[';
		delim2 := ']';
    end;
    Remainder := ExtractBracketed(Str, @start, @next, delim1, false);
    Output := Output + delim1;
    //
    //    At this point, we're inside  '[' ... ']' and expecting either
    //      result ("," result )*
    //    or
    //      value ("," value )*
    //
    //    A result starts with "variable = "  i.e. '=' must come before
    //       any of ',' '{' or '['
    //       -- anything else is a value,
    //
    //    A value must be a Tuple (start with '{'), a List (start with '[')
    //     otherwise it's a const.
    //

    while (true) do
    begin                                                // Loop through the list
		len := Length(Remainder);                          // find out which
		if (Len = 0) then
			break;
		comma := FindFirstChar(Remainder, ',');
		lbrace := FindFirstChar(Remainder, '{');
		lsqbkt := FindFirstChar(Remainder, '[');
		equals := FindFirstChar(Remainder, '=');

		if (not(equals = 0)
			and ((lbrace = 0) or (equals < lbrace))
			and ((lsqbkt = 0) or (equals < lsqbkt))
			and ((comma  = 0) or (equals < comma ))) then    // we have a Result

        begin
            if (comma = 0) then                         // and the only or the last one
            begin
				Output := Output + ParseResult(@Remainder, Level+1, List);
				break;                                    // done
            end
            else
            begin
				Item := AnsiLeftStr(Remainder, comma-1);  // ... or the first of many
				Output := Output + ParseResult(@Item, Level+1, List);
				next := comma+1;
				Output := Output + ', ';
            end;
        end
        else                                            // we have a value
        begin
            if (comma = 0) then                         // and the only or the last one
            begin
                Output := Output + ParseValue(@Remainder, Level+1, List);
                break;                                  // done
            end
            else
            begin
                Item := AnsiLeftStr(Remainder, comma-1); // ... or the first of many
                Output := Output + ParseValue(@Item, Level+1, List);
                Output := Output + ', ';
                next := comma+1;
            end;
        end;
		if (next < len) then
			Remainder := AnsiMidStr(Remainder, next, Length(Remainder)-next + 1);
    end;
    Output := Output + delim2;
    ExtractList := Output;
end;

//=================================================================

function TGDBDebugger.ParseValue(Str: PString; Level: Integer; List: TList): String;

//    Determines the content of a Value, i.e.
//        const | tuple | list
//    The Value must NOT be enclosed in {...} or [...]  -- although its
//    contents will be if those are a Tuple or a List.
//
//    N.B. This is recursive and will fully parse the Result tree.

var
	Output: String;
	s: Integer;
	n: Integer;
	Str2: String;
	Local: PWatchVar;





begin

        Str^ := TrimLeft(Str^);
        
       // ParseValue
	if (AnsiStartsStr('{', Str^)) then                          // a Tuple
		Output := Output + ExtractList(Str, PARSETUPLE, Level, List)
	else
	if (AnsiStartsStr('[', Str^)) then                          // a List
		Output := Output + ExtractList(Str, PARSELIST, Level, List)
	else
	if ((Str^[1] = '"')
		and ((Str^[2] = '{') or (Str^[2] = '{')) and ExpandClasses) then  // it might be a class
	begin
		Str2 := ExtractBracketed(Str, @s, @n, '"', false);
		Output := Output + ExtractList(@Str2, PARSELIST, Level, List);
	end
	else
	begin
		New(Local);                           // a const
		Local^.Value := Trim(OctToHex(Str));
                Local^.Name := '';
		List.Add(Local);
		Output := Output + OctToHex(Str);         // a const
	end;
	ParseValue := Output;
end;

//=================================================================

function TGDBDebugger.ExtractWxStr(Str: PString): String;

    //    Expects a Value specifically of the form:

    //    {<wxStringBase> = {static npos = 1234567890,
    //    m_pchData = 0x12abcd \"A String with or without \\\"quotes\\\" embedded\"},
    //     <No data fields>}
    //
    //    or
    //
    //    {<wxStringBase> = {static npos = 4294967295,
    //    m_pchData = 0x13 <Address 0x13 out of bounds>},
    //     <No data fields>}
    //
    //    (and may start with a quote and end with a comma)
    //    and returns the string only.

var
    starts: Integer;
    ends: Integer;
    QStr: String;

begin          // ExtractwxStr
    QStr := AnsiLeftStr(Str^, Length(Str^) - 20);
    if (AnsiPos('"{', QStr) = 1) then
        QStr := AnsiMidStr(QStr, 3, Length(QStr) - 3);    // Strip the wrapping
    if (AnsiPos('{', QStr) = 1) then
        QStr := AnsiMidStr(QStr, 2, Length(QStr) - 1);    // Strip the wrapping
    if (AnsiLastChar(QStr) = '>') then                // An Error Msg
        QStr := '<' + AnsiAfterLast('<', QStr)
    else                                              // a quoted string
    begin
        starts := AnsiPos('\"', QStr);
        ends := AnsiFindLast(GDBqStrEmpty, QStr);
        QStr := AnsiMidStr(QStr, starts + 2, ends - starts - 2);
    end;
    ExtractWxStr := unescape(@QStr);

end;

//=================================================================

procedure TGDBDebugger.ReplaceWxStr(Str: PString);

//    Expects a string with embedded wxStrings specifically of the form expected
//     by ExtractWxStr
//    and returns with the string that has only the quoted string itself embedded.
//      e.g. {MywxStr = {<wxStringBase> = {static npos = ..., m_pchData = 0x... \"AString\"}, <No data fields>}}
//    becomes
//      {MywxStr = "AString"}


var
  wxstarts: Integer;
  starts: Integer;
  ends: Integer;
  QStr, Remainder, Output: String;

begin
  Remainder := Str^;
  Output := '';
  wxstarts := AnsiPos( '{'+wxStringBase, Remainder);
  while (not(wxstarts = 0)) do
  begin
    Output := Output + AnsiLeftStr(Remainder, wxstarts-1);
    Remainder := AnsiRightStr(Remainder, Length(Remainder) - wxstarts +1 );
    QStr := ExtractBracketed(@Remainder, @starts, @ends, '{', true);
    Output := Output + '"' + ExtractWxStr(@QStr) + '"';
    if (ends = 0) then
    begin
      Remainder := '';
      break;
    end;
    Remainder := AnsiRightStr(Remainder, Length(Remainder) - ends + starts );
    wxstarts := AnsiPos( '{'+wxStringBase, Remainder);
  end;
  Str^ := Output + Remainder;
end;

//=================================================================

function unescape(s: PString): String;
// Unescapes a GDB double-escaped C-style string.
// E.g 'A \\\"quote\\\"'  becomes  'A \"quote\"'
var
	i: Integer;
	temp: String;

begin
	if (length(s^) >1) then
	begin
		i := 1;

		repeat
		begin
			if ((s^[i] = '\') and
			((s^[i+1] = '\') or (s^[i+1] = '"'))) then
				inc(i);
			temp := temp + s^[i];
			inc (i);
		end;
		until i > length(s^);
		unescape := temp;
	end
	else
		unescape := s^;
end;

//=================================================================

function OctToHex(s: PString): String;
// Replaces each Octal representation of an 8-bit number embedded in a string
//  with its Hex equivalent. Format must be '\nnn' or '\\0nn'
//  (i.e. escaped leading zero)
//  E.g.  '\302' => '0xC2'    '\\025' => '0x15'

//  Note: 3 digits, 1 or 2 backslashes and the surrounding single quotes
//  are all required.
// Returns the converted string.

var
	i,k: Integer;
	temp: String;
	c: Integer;

begin
	if (length(s^) > 5) then
	begin
		i := 1;
		k := 0;
		repeat
		begin
		if ((s^[i+1] = '\') and (s^[i+2] = '\')) then
			k := 1;
		if (s^[i] = '''') and
			(s^[i+1] = '\') and
			(s^[i+k+1] = '\') and
			(s^[i+k+2] >= '0') and
			(s^[i+k+2] < '8') and
			(s^[i+k+3] >= '0') and
			(s^[i+k+3] < '8') and
			(s^[i+k+4] >= '0') and
			(s^[i+k+4] < '8') and
			(s^[i+k+5] = '''') then
			begin
				c := ((StrToInt(s^[i+k+2]) * 8) + StrToInt(s^[i+k+3])) * 8 + StrToInt(s^[i+k+4]);
				temp := temp + format('''0x%2.2x''', [c]);
				i := i + k + 6;
			end
			else
			begin
				temp := temp + s^[i];
				inc (i);
			end;
		end;
		until (i > length(s^));
		OctToHex := temp;
	end
	else
		OctToHex := s^;
end;

//=================================================================

function AnsiBeforeFirst(Sub: String; Target: String): String;
    // Returns the string before the first 'Sub' in 'Target'
begin
    //AnsiBeforeFirst := AnsiLeftStr(Target, AnsiPos(Sub,Target)-1);
    AnsiBeforeFirst := LeftStr(Target, AnsiPos(Sub, Target) - 1);
end;

//=================================================================

function AnsiAfterFirst(Sub: String; Target: String): String;
    // Returns the string after the first 'Sub' in 'Target'
begin
    // AnsiAfterFirst := AnsiRightStr(Target, Length(Target) - AnsiPos(Sub, Target));
    AnsiAfterFirst := RightStr(Target, Length(Target) - AnsiPos(Sub, Target));
end;

//=================================================================

function AnsiAfterLast(Sub: String; Target: String): String;
    // Returns the string after the last 'Sub' in 'Target'
var
    RTarget, RSub, Res: String;

begin
    RTarget := ReverseString(Target);
    RSub := ReverseString(Sub);
    Res := LeftStr(RTarget, AnsiPos(RSub, RTarget) - 1);
    AnsiAfterLast := ReverseString(Res);
end;

//=================================================================

function AnsiFindLast(Src: String; Target: String): Integer;
    // Find the index of the last occurrence of Src in Target
var
    RTarget, RSrc: String;

begin
    RTarget := ReverseString(Target);
    RSrc := ReverseString(Src);
    AnsiFindLast := Length(Target) - AnsiPos(RSrc, RTarget);
end;

function AnsiMidStr(const AText: string;
    const AStart, ACount: Integer): string;
begin
    Result := MidStr(AText, AStart, ACount);
end;

function AnsiRightStr(const AText: string; ACount: Integer): string;
begin
    Result := RightStr(AText, ACount);
end;

function AnsiLeftStr(const AText: string; ACount: Integer): string;
begin
    Result := LeftStr(AText, ACount);
end;

//=================================================================

function TGDBDebugger.FindFirstChar(Str: String; c: Char): Integer;

    //    Finds the first occurrence of 'c' in Str that is
    //    not enclosed in { ... }, [ ... ] or  " ... "
    //    although it WILL find the opening { or [ or " provided it is
    //    not otherwise enclosed.
    //    A well-formed input string is assumed.
    //    Returns the one-based index of 'c', or 0.


var
    pos, p: Integer;
    isquoted: Boolean;

begin

    isquoted := false;
    FindFirstChar := 0;
    pos := 1;

    while ((not (Str[pos] = c) or isquoted) and (pos <= Length(Str))) do
    begin
        if (Str[pos] = '"') then
            isquoted := not isquoted
        else
        if (Str[pos] = '{') then
        begin
            p := FindFirstChar(AnsiMidStr(Str, (pos + 1),
                Length(Str) - pos - 1), '}');
            if (p = 0) then
            begin
                FindFirstChar := 0;
                break;
            end;
            pos := pos + p;
        end
        else
        if (Str[pos] = '[') then
        begin
            p := FindFirstChar(AnsiMidStr(Str, (pos + 1),
                Length(Str) - pos - 1), ']');
            if (p = 0) then
            begin
                FindFirstChar := 0;
                break;
            end;
            pos := pos + p;
        end;

        Inc(pos);
        FindFirstChar := pos;
    end;

    if (pos > Length(Str)) then
        FindFirstChar := 0;

end;

//=================================================================


function TGDBDebugger.ExtractBracketed(Str: PString; start: Pinteger;
    next: PInteger; c: Char; inclusive: Boolean): String;


    //    Returns the sub-string from the first occurrence of 'c'
    //    (which must be one of '{' '[' '<' '"')
    //    to the matching  '}' ']' '>' '"' character. If inclusive, 'c' and its match
    //    are returned, otherwise they are stripped.
    //    Nesting is allowed.
    //    RETURN VALUES:
    //    start is the index in the original string where the sub-string was found,
    //    and next the index of the character immediately after sub-string.
    //    If not required, these can be NULL pointers.
    //    If the sub-string is not found, an empty string is returned and start & next
    //    both are zero.
    //    If the sub-string is the whole of the input string, a non-empty string is
    //    returned and start & next both are zero.
    //    If the sub-string starts at the beginning of the input string, a non-empty string is
    //    returned and start is zero.
    //    If the sub-string ends at the end of the input string, a non-empty string is
    //    returned and next is zero.


var
    Output: String;
    l1, l2, l3, l4, s, e: Integer;
    nestedin: Array[0..9] of Integer;

begin          // ExtractBracketed
    Output := Str^;
    for e := 9 downto 0 do
        nestedin[e] := 0;
    // we are expecting a closing '"' at this level (arbitrary limit of 256)

    l1 := 0;             // level of nesting of ""
    l2 := 0;             // level of nesting of {}
    l3 := 0;             // level of nesting of []
    l4 := 0;             // level of nesting of <>
    s := -1;             // index of start of our region -1 = not found
    e := 0;              // index of end of our region

    begin

        while (e <= Length(Output)) do
        begin
            if (not (Output[e] = c) and (s = -1)) then
            begin                   // skip over all before our start char
                Inc(e);
                continue;
            end;

            case (Output[e]) of
                '\':
                    if (Output[e + 1] = '"') then
                        // a literal quote - ignore
                    begin
                        e := e + 2;                         // & skip over
                        continue;
                    end;

                '"':
                    if ((nestedin[l1] = 0) and not (s = -1)) then
                        Dec(l1)
                    else
                        Inc(l1);

                '{':
                begin
                    Inc(l2);
                    Inc(nestedin[l1]);
                end;

                '}':
                begin
                    Dec(l2);
                    Dec(nestedin[l1]);
                end;

                '[':
                begin
                    Inc(l3);
                    Inc(nestedin[l1]);
                end;

                ']':
                begin
                    Dec(l3);
                    Dec(nestedin[l1]);
                end;

                '<':
                begin
                    Inc(l4);
                    Inc(nestedin[l1]);
                end;

                '>':
                begin
                    Dec(l4);
                    Dec(nestedin[l1]);
                end;
            end;

            if ((s = -1) and (Output[e] = c)) then
                s := e;
            Inc(e);
            if (not (s = -1) and ((l1 = 0) and (c = '"') or (l2 = 0)
                and (c = '{') or (l3 = 0)
                and (c = '[') or (l4 = 0)
                and (c = '<'))) then
                break;
        end;

		if ((e > Length(Output)) and (s = -1)) then          // was e = Length(Output)
        begin
            if (not (start = Nil)) then
                start^ := 0;
            if (not (next = Nil)) then
                next^ := 0;
            Output := '';
            ExtractBracketed := Output;
        end;
    end;

    if (not (next = Nil)) then
        if (e > Length(Output)) then
            next^ := 0
        else
            next^ := e;

    if (not (inclusive)) then
    begin
        Inc(s);
        Output := AnsiMidStr(Str^, s, e - s - 1);
    end
    else
        Output := AnsiMidStr(Str^, s, e - s);

    if (not (start = Nil)) then
        start^ := s;

    ExtractBracketed := Output;
end;

//=================================================================


constructor TGDBDebugger.Create;
begin
    inherited;
    OverrideHandler := nil;
    LastWasCtrl := True;
    Started := False;
end;

//=============================================================

procedure TGDBDebugger.CloseDebugger(Sender: TObject);
begin

	if Executing then
	begin

        // Reset breakpoint colors in editor
        MainForm.RemoveActiveBreakpoints;
        MainForm.DebugOutput.Lines.Add('Debugger closed.');

		fPaused := false;
		fExecuting := false;

//		DLLs attached to the process are not notified that the process
//  	is terminating. Thus using Reset may result in an unstable system.
//  	The Windows API documentation on TerminateProcess explains all.

		if (TargetIsRunning) then
// 			Kill the target
			KillProcess(TargetPID);
// 		Kill the Debugger
		KillProcess(DebuggerPID);
		Cleanup;

// First don't let us be called twice. Set the secondary threads to not call
// us when they terminate

		Reader.OnTerminate := nil;
		Reader := nil;

//    	MainForm.RemoveActiveBreakpoints;

//		Clear the command queue
		CommandQueue.Clear;
		CurrentCommand := nil;
	end;
end;

//=============================================================

destructor TGDBDebugger.Destroy;
begin
    inherited;
end;

//=============================================================

procedure TGDBDebugger.ExitDebugger;
begin

    QueueCommand(GDBExit, '');

    //		Note we SHOULD NOT pull the plug on the debugger unless it fails
    //      to stop when commanded to exit (manual page 306: Quitting GDB)
    //      It should be safe to stop the reader and close the pipes after
    //      telling GDB to exit, even though it might not have finished.
    //      GDB won't stop if the target is running.
    //      We will never know when GDB has actually stopped, even though it
    //      has reported 'exit', because it still must clean up.
    //      Killing GDB will still not terminate the target. (Neither will
    //      stopping the IDE).
    //      The Windows API documentation on TerminateProcess explains all.


end;

//=============================================================
procedure TGDBDebugger.Cleanup;


begin

	Reader.Terminate;
    //Close the handles
	try
		if (not CloseHandle(g_hChildStd_IN_Wr)) then
			DisplayError('CloseHandle - ChildStd_IN_Wr');
		if (not CloseHandle(g_hChildStd_OUT_Rd)) then
			DisplayError('CloseHandle - ChildStd_OUT_Rd');
		//	See the note above about TerminateProcess
	except
		on EExternalException do DisplayError('Closing Pipe Handles');
	end;

end;

//=============================================================


procedure TGDBDebugger.Execute(filename, arguments: string);
const
    gdbInterp: String = '--interpreter=mi';
    gdbSilent: String = '--silent';

var
    Executable: string;
    WorkingDir: string;
    Includes: string;
    I: Integer;

begin
    //Reset our variables
    self.FileName := filename;
    fNextBreakpoint := 0;
    IgnoreBreakpoint := False;
    Started := False;
    TargetIsRunning := False;

    //Get the name of the debugger
    if (devCompiler.gdbName <> '') then
        Executable := devCompiler.gdbName
    else
        Executable := DBG_PROGRAM(devCompiler.CompilerType);


    Executable := Executable + ' ' + gdbInterp;

    // Verbose output requested?
    if (not MainForm.VerboseDebug.Checked) then
        Executable := Executable + ' ' + gdbSilent;

    //Add in the include paths

    for I := 0 to IncludeDirs.Count - 1 do
        Includes := Includes + '--directory=' +
            GetShortName(IncludeDirs[I]) + ' ';
    if Includes <> '' then
        Executable := Executable + ' ' + Includes;


    //Add the target executable
    Executable := Executable + ' "' + filename + '"';

    //Launch the process

    if Assigned(MainForm.fProject) then
        WorkingDir := MainForm.fProject.CurrentProfile.ExeOutput;

    Launch(Executable, WorkingDir);

    QueueCommand('-gdb-set', 'new-console on'); // For console applications
    // ??? Will this have any effect - see GDB Documentation: "the debuggee will be started in a new console on next start"
    //     I read this as implying it WILL go into effect because the target is only loaded, not yet started.
    QueueCommand('-gdb-set', 'height 0');
    QueueCommand('-gdb-set', 'breakpoint pending on');
    // Fix for DLL breakpoints
    QueueCommand('-gdb-set args', arguments);

    LoadAllWatches;
    
end;

//=============================================================
procedure TGDBDebugger.AddtoDisplay(Msg: String);
// Write to the IDE debugger output window

// This is equivalent to the calls in TGDBDebugger.OnOutput:
//   MainForm.DebugOutput.Lines.AddStrings(TempLines);
// around line 2487
// GAR: Change this to suit

begin
    MainForm.DebugOutput.Lines.Add(Msg);
end;

//=============================================================
procedure TGDBDebugger.SendCommand;
// called by QueueCommand( ) initially, then by the parser once the present
//  debugger output is exhausted in order to process the next in the queue.

begin
    //Do we have anything left? Are we paused?
    // SentCommand is reset by the parser
    if Executing and Paused then
        while ((CommandQueue.Count > 0) and (Paused) and (not SentCommand)) do
        begin

            //Initialize stuff
            // Let's assume commands have been queued up

            SentCommand := True;
            CurrentCommand := PCommand(CommandQueue[0])^;

            //Remove the entry from the list
            if not (CurrentCommand is TCommandWithResult) then
                Dispose(CommandQueue[0]);
            CommandQueue.Delete(0);

{
  For the Exerciser only: We write the command in to the Edit Box, and to
  the output window, purely for User Information.
  Unless required for logging, we don't NEED even the output window write.
  There should be no problem with writing directly to the Pipe from here:
  All commands should be well within the capabilities of the native OS Pipe
  Buffers (4K Windows, 32K Linux?) so the main thread should not hang while
  the debugger runs.
  If for any reason the debugger fails to read off the end of the pipe, the
  only thing that will happen is the list will build with unpiped commands.

  The pipe buffer and GDB are capable of processing commands sequentially.
  Thus there is no need to wait until the result of the command has been read.
}

            if (MainForm.VerboseDebug.Checked) then
				AddtoDisplay('Sending ' + CurrentCommand.Command);

            // For proper handling of multi-threaded targets, we might need to prefix each
            // command with '--thread' and �--frame�  (See GDB Manual: 27.1.1 Context management)
            // with parameters got from ExecResult() or ParseThreads() unless changed by user.
            //  (can see no evidence for this having been done in existing version)

            WriteToPipe(CurrentCommand.Command);

            //Call the callback function if we are provided one
            if Assigned(CurrentCommand.Callback) then
                CurrentCommand.Callback;
        end;
end;

//=============================================================

procedure TGDBDebugger.Attach(pid: integer);
var
    Executable: string;
    Includes: string;
    I: Integer;
begin
    //Reset our variables
    self.FileName := filename;
    fNextBreakpoint := 0;
    IgnoreBreakpoint := False;

    //Get the name of the debugger
    if (devCompiler.gdbName <> '') then
        Executable := devCompiler.gdbName
    else
        Executable := DBG_PROGRAM(devCompiler.CompilerType);
    Executable := Executable + ' --annotate=2 --silent';

    //Add in the include paths
    for I := 0 to IncludeDirs.Count - 1 do
        Includes := Includes + '--directory=' +
            GetShortName(IncludeDirs[I]) + ' ';
    if Includes <> '' then
        Executable := Executable + ' ' + Includes;

    //Launch the process
    Launch(Executable, '');

    //Tell GDB which file we want to debug
    QueueCommand('-gdb-set', 'height 0');
    QueueCommand('-target-attach', inttostr(pid));
end;

function RegexEscape(str: string): string;
begin
   Assert(false, 'RegexEscape: I am not redundant');
end;

// ===============================================

procedure TGDBDebugger.OnOutput(Output: string);
begin
   Assert(false, 'TGDBDebugger.OnOutput: I am not redundant');
end;

//=================================================================

procedure TGDBDebugger.OnSignal(Output: TStringList);
begin
   Assert(false, 'TGDBDebugger.OnSignal: I am not redundant');
end;

//=================================================================

procedure TGDBDebugger.OnLocals(Output: TStringList);
begin
   Assert(false, 'TGDBDebugger.OnLocals: I am not redundant');
end;
//=================================================================

procedure TGDBDebugger.OnThreads(Output: TStringList);
begin
   Assert(false, 'TGDBDebugger.OnThreads: I am not redundant');
end;

//=================================================================

procedure TGDBDebugger.GetRegisters;
begin
   Assert(false, 'TGDBDebugger.GetRegisters: I am not redundant');
end;

//=================================================================

procedure TGDBDebugger.OnRegisters(Output: TStringList);
begin
   Assert(false, 'TGDBDebugger.OnRegisters: I am not redundant');
end;

//=================================================================

procedure TGDBDebugger.OnSourceMoreRecent;
begin
    if (MessageDlg(Lang[ID_MSG_SOURCEMORERECENT], mtConfirmation,
        [mbYes, mbNo], 0) = mrYes) then
    begin
        CloseDebugger(nil);
        MainForm.actCompileExecute(nil);
    end;
end;

//=================================================================

procedure TGDBDebugger.AddIncludeDir(s: string);
begin
    IncludeDirs.Add(s);
end;

//=================================================================

procedure TGDBDebugger.ClearIncludeDirs;
begin
    IncludeDirs.Clear;
end;

//=================================================================

procedure TGDBDebugger.AddBreakpoint(breakpoint: TBreakpoint);
var
    aBreakpoint: PBreakpoint;
begin
    if (not Paused) and Executing then
    begin
        MessageDlg('Cannot add a breakpoint while the debugger is executing.',
            mtError, [mbOK], MainForm.Handle);
        Exit;
    end;

    New(aBreakpoint);
    aBreakpoint^ := breakpoint;
    Breakpoints.Add(aBreakpoint);
    RefreshBreakpoint(aBreakpoint^);
end;

//=================================================================

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
        if (PBreakPoint(Breakpoints.Items[i])^.line = breakpoint.Line) and
            (PBreakPoint(Breakpoints.Items[i])^.editor =
            breakpoint.Editor) then
        begin
            if Executing then
                QueueCommand('-break-delete ',
                    IntToStr(PBreakpoint(Breakpoints.Items[i])^.BPNumber));

            Dispose(Breakpoints.Items[i]);
            Breakpoints.Delete(i);
            Break;
        end;
end;

//=================================================================

procedure TGDBDebugger.RefreshBreakpoint(var breakpoint: TBreakpoint);
begin
    if Executing then
    begin
        Inc(fNextBreakpoint);
        breakpoint.Index := fNextBreakpoint;
        breakpoint.Valid := True;
        QueueCommand('-break-insert ', Format('"%s:%d"',
            [breakpoint.Filename, breakpoint.Line]));
    end;
end;

//=================================================================

procedure TGDBDebugger.RefreshContext(refresh: ContextDataSet);
var
    I: Integer;
    Node: TListItem;
    Command: TCommand;
begin
    if not Executing then
        Exit;

    //First send commands for stack tracing, locals and threads
    if cdCallStack in refresh then
    begin
        Command := TCommand.Create;
        Command.Command := '-stack-list-frames'; //'bt';
        Command.OnResult := OnCallStack;
        QueueCommand(Command);
    end;
    if cdLocals in refresh then
    begin
        Command := TCommand.Create;
        Command.Command := '-stack-list-locals 1';
        Command.OnResult := OnLocals;
        QueueCommand(Command);
    end;
    if cdThreads in refresh then
    begin
        Command := TCommand.Create;
        Command.Command := '-thread-info'; 
        Command.OnResult := OnThreads;
        QueueCommand(Command);
    end;

    //Then update the watches
    if (cdWatches in refresh) and Assigned(MainForm.WatchTree) then
    begin
		ReLoadWatches;
		GetWatchedValues;
    end;
	
	
end;

//=================================================================

procedure TGDBDebugger.OnRefreshContext(Output: TStringList);
begin

end;

//=================================================================

//=================================================================

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
        else
        if Output[I] = 'frame-function-name' then
        begin
            Inc(I);
            StackFrame^.FuncName := Output[I];
        end
        else
        if Output[I] = 'frame-args' then
        begin
            Inc(I);

            //Make sure it's valid
            if Output[I] <> ' (' then
            begin
                Inc(I);
                Continue;
            end
            else
            begin Inc(I); end;

            while (I < Output.Count - 6) do
            begin
                if Output[I] = 'arg-begin' then
                begin
                    if StackFrame^.Args <> '' then
                        StackFrame^.Args := StackFrame^.Args + ', ';
                    StackFrame^.Args :=
                        StackFrame^.Args + Output[I + 1] + ' = ' +
                        Output[I + 5];
                end;
                Inc(I, 6);

                //Do we stop?
                if Trim(Output[I + 1]) <> ',' then
                    Break
                else
                    Inc(I, 2);
            end;
        end
        else
        if Output[I] = 'frame-source-file' then
        begin
            Inc(I);
            StackFrame^.Filename := ExtractFileName(Output[I]);
        end
        else
        if Output[I] = 'frame-source-line' then
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

//=================================================================

procedure TGDBDebugger.Disassemble(func: string);
begin
   Assert(false, 'TGDBDebugger.Disassemble: I am not redundant');
end;

//=================================================================

procedure TGDBDebugger.OnDisassemble(Output: TStringList);
begin
   Assert(false, 'TGDBDebugger.OnDisassemble: I am not redundant');
end;

//=================================================================


procedure TGDBDebugger.SetAssemblySyntax(syntax: AssemblySyntax);
begin
    case syntax of
        asIntel:
            QueueCommand('-gdb-set disassembly-flavor', 'intel');
        asATnT:
            QueueCommand('-gdb-set disassembly-flavor', 'att');
    end;
end;

//=================================================================

function TGDBDebugger.GetVariableHint(name: string): string;
var
    Command: TCommand;
begin
    if (not Executing) or (not Paused) then
        Exit;

    Command := TCommand.Create;
    Command.OnResult := OnVariableHint;
    //Command.Command := 'print ' + name;
    Command.Command := format('%d%s%s',[TOOLTOKEN, GDBdataeval, name]);

    //Send the command;
    QueueCommand(Command);
end;

//=================================================================

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
        Command.Command := '-exec-run'
    else
        Command.Command := '-exec-continue';
    Command.Callback := OnGo;
    QueueCommand(Command);
end;

//=================================================================

procedure TGDBDebugger.OnGo;
begin
    inherited;
    Started := True;
end;

//=================================================================

procedure TGDBDebugger.Launch(commandline, startupdir: String);
var
    saAttr: TSecurityAttributes;

begin

    saAttr.nLength := SizeOf(SECURITY_ATTRIBUTES);
    saAttr.bInheritHandle := TRUE;
    saAttr.lpSecurityDescriptor := Nil;

    // Create a pipe for the child process's STDOUT.

    if (not CreatePipe(g_hChildStd_OUT_Rd, g_hChildStd_OUT_Wr,
        @saAttr, 0)) then
        DisplayError('Std_OUT CreatePipe');

    // Ensure the read handle to the pipe for STDOUT is not inherited.

    if (not SetHandleInformation(g_hChildStd_OUT_Rd,
        HANDLE_FLAG_INHERIT, 0)) then
        DisplayError('Std_OUT SetHandleInformation');

    // Create a pipe for the child process's STDIN.

    if (not CreatePipe(g_hChildStd_IN_Rd, g_hChildStd_IN_Wr, @saAttr, 0)) then
        DisplayError('Std_IN CreatePipe');

    // Ensure the write handle to the pipe for STDIN is not inherited.

    if (not SetHandleInformation(g_hChildStd_IN_Wr,
        HANDLE_FLAG_INHERIT, 0)) then
        DisplayError('Std_IN SetHandleInformation');

    //  Pipes created

    //-----------------------------------------------------------------

    // Start the Reader thread

    // May want to pass the TDebugger address to ReadThread

    Reader := ReadThread.Create(true);
    Reader.ReadChildStdOut := g_hChildStd_OUT_Rd;
    Reader.FreeOnTerminate := True;
    Reader.Resume;

    //---------------------------------------------------------

    // Create a child process that uses the previously created pipes for STDIN and STDOUT.

    CreateChildProcess(commandline, g_hChildStd_IN_Rd,
        g_hChildStd_OUT_Wr, g_hChildStd_OUT_Wr);

    // Reader Thread created & running

    if (not CloseHandle(g_hChildStd_OUT_Wr)) then
        DisplayError('CloseHandle Std_OUT');
    if (not CloseHandle(g_hChildStd_IN_Rd)) then
        DisplayError('CloseHandle Std_IN');

    Reader.Resume;

end;

//============================================

procedure TGDBDebugger.WriteToPipe(Buffer: String);

var
    BytesWritten: DWORD;

begin
    BytesWritten := 0;

    Buffer := Buffer + NL;               // GDB requires a newline

    // Send it to the pipe
    WriteFile(g_hChildStd_IN_Wr, PChar(Buffer)^, Length(Buffer),
        BytesWritten, Nil);

end;

//=============================================================

function TGDBDebugger.Result(buf: PChar; bsize: PLongInt): PChar;
{
/*
   Part of Second Level Parse of Output.

   Parse Result Record.

   Looks from beginning up to [0x0d][0x0a] pair.
   MODIFIES the input buffer.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
   Note: embedded cr or cr-lf are replaced by nulls.
 */
}

var
    OutputBuffer: String;
    msg: String;
    Mainmsg, AllReason, ThreadID: String;
    thread: Integer;

begin
	if (MainForm.VerboseDebug.Checked) then
	begin
		AddtoDisplay('Parsing ^');
	end;

    Result := nil;
    msg := breakOut(@buf, bsize);
    msg := AnsiMidStr(msg, 2, Maxint-1);

    if (MainForm.VerboseDebug.Checked) then
    begin
      OutputBuffer := msg;
      // gui_critSect.Enter();
      AddtoDisplay(OutputBuffer);
      // gui_critSect.Leave();
    end;

    if (not(msg = '')) then
      begin
        if (AnsiStartsStr(GDBerror, msg)) then
        begin
          Mainmsg := StringReplace(msg, 'msg="','', []);
          Mainmsg := StringReplace(Mainmsg, '\','',[rfReplaceAll]);

          if ((Token >= WATCHTOKENBASE) and (Token < MODVARTOKEN)) then
            ParseWatchpointError(Mainmsg)
          else
          if (Mainmsg = 'error,mi_cmd_var_assign: Variable object is not editable"') then
          begin
            DisplayError('This Variable is not editable');
          end
          else
            DisplayError('GDB Error: ' + Mainmsg);
        end

        else if (AnsiStartsStr(GDBrunning, msg)) then
        begin
          // get rest into , &AllReason))
          AllReason := AnsiRightStr(msg, (Length(msg)-Length(GDBrunning)));
          TargetIsRunning := true;
          // gui_critSect.Enter();
          //MainForm.SetRunStatus(true);
          // gui_critSect.Leave();

          if (ParseConst(@AllReason, @GDBthreadid, PString(@threadID))) then
          begin
            if (threadID = 'all') then
            begin
//              thread := -1;                              // Thread No.
              OutputBuffer := 'Running all threads'
            end
            else
            begin
              thread := StrToInt(threadID);
              OutputBuffer := Format('Running thread %d', [thread]);
              AddtoDisplay(OutputBuffer);
            end;
          end;
        end

        else if (AnsiStartsStr(GDBExitmsg, msg)) then
        begin
            AddtoDisplay('GDB is exiting');
            Cleanup;
        end

        else if (AnsiStartsStr(GDBdone+GDBbkpt, msg)) then
        begin
          ParseBreakpoint(msg, nil);
        end

        else if (AnsiStartsStr(GDBdone+GDBbkpttable, msg)) then
        begin
            ParseBreakpointTable(msg);
        end

        else if (AnsiStartsStr(GDBdone+GDBstack, msg)) then
        begin
            ParseStack(msg);
        end

        else if (AnsiStartsStr(GDBdone+GDBlocalsq, msg)) then
        begin
            OutputBuffer := ExtractLocals(@msg);  // Parses & Reassembles Result
            if (MainForm.VerboseDebug.Checked) then
				AddtoDisplay(OutputBuffer);
        end

        else if (AnsiStartsStr(GDBdone+GDBthreads, msg)) then
        begin
            ParseThreads(msg);
        end

        else if (AnsiStartsStr(GDBdone+GDBwpt, msg)) then
        begin
            ParseWatchpoint(msg);
        end

        else if (AnsiStartsStr(GDBdone+GDBwpta, msg)) then
        begin
            ParseWatchpoint(msg);
        end

        else if (AnsiStartsStr(GDBdone+GDBwptr, msg)) then
        begin
            ParseWatchpoint(msg);
        end

        else if (AnsiStartsStr(GDBdone+GDBregnames, msg)) then
        begin
          ParseRegisterNames(msg);
        end

        else if (AnsiStartsStr(GDBdone+GDBmemq, msg)) then
        begin
          ParseCPUMemory(msg);
        end

        else if (AnsiStartsStr(GDBdone+GDBasminst, msg)) then
        begin
          ParseCPUDisassem(msg);
        end

        else if (AnsiStartsStr(GDBdone+GDBregvalues, msg)) then
        begin
          ParseRegisterValues(msg);
        end;

        if ((AnsiStartsStr(GDBdone+GDBnameq, msg))
            and not (Token = MODVARTOKEN)) then  // It's not from Modify Variable
        begin
          ParseVObjCreate(msg);           // if it was a VObj create...
        end;

        if (AnsiStartsStr(GDBdone+GDBvalue, msg))  then
        begin
            if ((Token >= WATCHTOKENBASE) and (Token < MODVARTOKEN)) then
              FillWatchValue(msg)         // it came from a request from GetWatchedValues
            else
            if ((Token = TOOLTOKEN)) then
              FillTooltipValue(msg)       // it came from a request from Tooltip (GetVariableHint)
            else
              ParseVObjAssign(msg);       // else it was a VObj assign
//                                            or another -data-evaluate-expression...

        end;

        Result := buf;

      end;
end;

//=================================================================

function TGDBDebugger.ExecResult(buf: PChar; bsize: PLongInt): PChar;
{
   Part of Second Level Parse of Output.

   INCOMPLETE - see below.
   Looks from beginning up to [0x0d][0x0a] pair.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
   Note: embedded cr-lf are replaced by nulls.
}

var
    OutputBuffer: String;
    msg: String;
    AllReason: String;
    Reason: String;
    Errmsg: String;

    threadID: String;
    thread: LongInt;

begin

	if (MainForm.VerboseDebug.Checked) then
	begin
		AddtoDisplay('Parsing *');
	end;

    ExecResult := nil;
    msg := breakOut(@buf, bsize);
    msg := AnsiMidStr(msg, 2, Maxint - 1);


    if (MainForm.VerboseDebug.Checked) then
    begin
        OutputBuffer := msg;
        // gui_critSect.Enter();
        AddtoDisplay(OutputBuffer);
        // gui_critSect.Leave();
    end;


    if (not (msg = '')) then
    begin
        if (AnsiStartsStr(GDBrunning, msg)) then
        begin
            // get rest into , &AllReason))
            AllReason := AnsiRightStr(msg, (Length(msg) - Length(GDBrunning)));
            TargetIsRunning := true;

            if (ParseConst(@AllReason, @GDBthreadid, PString(@threadID))) then
                if (threadID = 'all') then
                    OutputBuffer :=
                        'Running all threads'
                else
                begin
                    thread := StrToInt(threadID);
                    OutputBuffer := Format('Running thread %d', [thread]);
                    AddtoDisplay(OutputBuffer);
                end;

            // INCOMPLETE: does nothing with the thread number

        end
        else
        if (AnsiStartsStr(GDBstopped, msg)) then
        begin
            // get rest into , &AllReason))
            AllReason := AnsiRightStr(msg, (Length(msg) - Length(GDBstopped)));
            if (TargetIsRunning) then
                RefreshContext;
                
            TargetIsRunning := false;

            if (ParseConst(@msg, @GDBreason, PString(@Reason))) then
                if (Reason = 'exited-normally') then
                begin
                    // gui_critSect.Enter();
                    AddtoDisplay('Stopped - Exited normally');
                    // gui_critSect.Leave();
                    Started := False;
					ExitDebugger;

                    CloseDebugger(nil);
                end
                else
                if (Reason = 'breakpoint-hit') then
                begin
                    if (MainForm.VerboseDebug.Checked) then
					begin
						// gui_critSect.Enter();
						AddtoDisplay('Stopped - breakpoint-hit');
						// gui_critSect.Leave();
                    end;
					BreakpointHit(@msg);
                end
                else
                if (Reason = 'watchpoint-trigger') then
                begin
                    if (MainForm.VerboseDebug.Checked) then
					begin
						// gui_critSect.Enter();
						AddtoDisplay('Stopped - watchpoint-trigger');
						// gui_critSect.Leave();
					end;
                    WatchpointHit(@msg);
                end
                else
                if (Reason = 'read-watchpoint-trigger') then
                begin
                    if (MainForm.VerboseDebug.Checked) then
					begin
						// gui_critSect.Enter();
						AddtoDisplay('Stopped - read-watchpoint-trigger');
						// gui_critSect.Leave();
					end;
                    WatchpointHit(@msg);
                end
                else
                if (Reason = 'access-watchpoint-trigger') then
                begin
                    if (MainForm.VerboseDebug.Checked) then
					begin
						// gui_critSect.Enter();
						AddtoDisplay('Stopped - access-watchpoint-trigger');
						// gui_critSect.Leave();
					end;
                    WatchpointHit(@msg);
                end
                else
                if (Reason = 'end-stepping-range') then
                begin
                    if (MainForm.VerboseDebug.Checked) then
					begin
						// gui_critSect.Enter();
						AddtoDisplay('Stopped - end-stepping-range');
						// gui_critSect.Leave();
					end;
                    StepHit(@msg);
                end
				else if (Reason = 'watchpoint-scope') then
				begin
					// gui_critSect.Enter();
					AddtoDisplay('Stopped - watchpoint-scope');
					// gui_critSect.Leave();
					WptScope(@msg);
				end
                else if (Reason = 'signal-received') then
                begin
                   AddtoDisplay('Stopped - signal received');
                   SigRecv(@msg);
                end
                else
                begin
                    Errmsg := AnsiReplaceStr(Errmsg, 'msg="', '');
                    Errmsg := AnsiReplaceStr(Errmsg, '\"', '');
                    DisplayError('GDB Error:' + Errmsg);
                end;
        end;
        ExecResult := buf;
    end;
end;

//===============================================

procedure TGDBDebugger.FirstParse;
var

    BufMem: PChar;          // Keep a copy of the originally allocated memory
    //  so that we can free the memory
begin
    BufMem := buf;           // because pointer 'buf' gets moved!

    while ((bytesInBuffer > 0) and not (buf = Nil)) do
	       // && some arbitrary counter to prevent an infinite loop in case
	       // a programming error fails to clear the buffer?
        if ((buf^ >= '0') and (buf^ <= '9')) then
		          // a token
        begin
            buf := GetToken(buf, @bytesInBuffer, @Token);
            if (MainForm.VerboseDebug.Checked) then
                AddtoDisplay('Token ' + IntToStr(Token));
        end
        else
        if (buf^ = '~') then
		          // console stream
		          // Not of interest: display it

            buf := SendToDisplay(buf, @bytesInBuffer, true)

        else
        if (buf^ = '=') then
		          // notify async
			buf := Notify(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked)
        else
        if ((buf^ = '@') or (buf^ = '&')) then
		          // target output ||  log stream
		          // Not of interest: display it

            buf := SendToDisplay(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked)

        else
        if (buf^ = '^') then
		          // A result or error
        begin
			         // gui_critSect.Enter();
            if (MainForm.VerboseDebug.Checked) then
                AddtoDisplay('Result or Error:');
			         // gui_critSect.Leave();
            buf := Result(buf, @bytesInBuffer);
        end
        else
        if (buf^ = '*') then
		          // executing async
        begin
			         // gui_critSect.Enter();
            if (MainForm.VerboseDebug.Checked) then
                AddtoDisplay('Executing Async:');
			         // gui_critSect.Leave();
            buf := ExecResult(buf, @bytesInBuffer);
        end
        else
        if (buf^ = '+') then
		          // status async
        begin
            if (MainForm.VerboseDebug.Checked) then
                AddtoDisplay('Status Output:');
            buf := SendToDisplay(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked);
        end
        else
        if (buf^ = '(') then
		          // might be GDB prompt - cannot really be anything else!
        begin

			    
            if (MainForm.VerboseDebug.Checked) then
			begin
			    //gui_critSect.Enter(); 
				AddtoDisplay('GDB Ready');
			    //gui_critSect.Leave();
			end;
            buf := SendToDisplay(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked);
        end
        else
		          // Don't know, what is left?
        begin
			// gui_critSect.Enter();
            AddtoDisplay('Cannot decide about:');
			// gui_critSect.Leave();
            buf := SendToDisplay(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked);
        end;

    FreeMem(BufMem);
    // The reader will only get the next lot from
    // the pipe buffer when it sees this:
    buf := Nil;              
	SentCommand := false;    // Requests next command to be sent from queue
    fPaused := True;
    SendCommand;             //  (these are only needed to maintain sync. between
    //  the outgoing and incoming data streams).

end;

//=============================================================

function TGDBDebugger.Notify(buf: PChar; bsize: PLongInt; verbose: Boolean): PChar;
{
/*
   Part of Second Level Parse of Output.

   Parse Notify Record.

   Looks from beginning up to [0x0d][0x0a] pair.
   MODIFIES the input buffer.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
   Note: embedded cr or cr-lf are replaced by nulls.
 */
}

var
    OutputBuffer: String;
    msg: String;

begin

if (verbose) then
begin
	// gui_critSect.Enter();
	AddtoDisplay('Parsing =');
	// gui_critSect.Leave();
end;

    Result := nil;
    msg := breakOut(@buf, bsize);
    msg := AnsiMidStr(msg, 2, Maxint-1);

    if (verbose) then
    begin
		OutputBuffer := msg;
		// gui_critSect.Enter();
		AddtoDisplay(OutputBuffer);
		// gui_critSect.Leave();
    end;

    if (not(msg = '')) then
	begin
		if (AnsiStartsStr(GDBthreadgcr, msg)) then
		// Only extract Target PID for now - can add more if required
			ParseConst(@msg, @GDBidq, PInteger(@TargetPID));

		Result := buf;

	end;
end;

//=============================================================

function TGDBDebugger.breakOut(Next: PPChar; bsize: PLongInt): String;
{
/*
  Supports the Second Level Parse.
  Takes the buffer and returns a String up to but excluding the first
  CR or CR-LF pair.
  N.B. an embedded newline appears as the string '\n', NOT as #13#10
  MODIFIES the input buffer (replaces CR and LF with Null(s)).
  Parameters:
    Next: Pointer to pointer to the buffer. On return this points to
      the first char following the first CR or CR-LF pair, else NULL
    bsize: a pointer to the buffer size. On return this size has been
      modified to reflect the size of the unprocessed buffer remaining.
*/
}
var
    s, c: PChar;

begin
    breakOut := '';
    s := Next^;
    c := Next^;

    while (not (c^ = CR) and (c < (Next^ + bsize^))) do
        Inc(c);
    c^ := #0;
    Inc(c);
    if (c^ = LF) then
    begin
        c^ := #0;
        Inc(c);
    end;
    bsize^ := bsize^ - (c - s);
    if (bsize^ <= 0) then                         // nothing remains
        Next^ := Nil
    else
        Next^ := c;
    breakOut := s;                                // copies NULL-terminated part


end;

//=============================================================

function TGDBDebugger.GetToken(buf: PChar; bsize: PLongInt;
    Token: PInteger): PChar;
var
    OutputBuffer: String;
    c, s: PChar;
    sToken: String;

begin
{
   Part of Second Level Parse of Output.

   Looks from beginning up to first non-digit.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
}

if (MainForm.VerboseDebug.Checked) then
begin
    // gui_critSect.Enter();
	AddtoDisplay('Parsing Token');
	// gui_critSect.Leave();
end;

    c := buf;
    s := buf;

    while ((c^ >= '0') and (c^ <= '9') and (c < (buf + bsize^))) do
    begin
        sToken := sToken + c^;
        Inc(c);
    end;

    if (c = s) then
    begin
        Token^ := 0;                  // We should never get here
        GetToken := c;                // return c;
    end
    else
    begin
        try
            Token^ := StrToInt(sToken);
        except
            Token^ := 0;
        end;

        bsize^ := bsize^ - (c - s);
        if (bsize^ = 0) then                          // nothing remains
            GetToken := Nil
        else
            GetToken := c;
    end;
end;

//=================================================================

function TGDBDebugger.SendToDisplay(buf: PChar; bsize: PLongInt;
    verbose: Boolean): PChar;
var
    OutputBuffer: String;
    msg: String;

begin
{
/*
   Part of Second Level Parse of Output.

   Sends from beginning up to [0x0d][0x0a] pair to display.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
   Note: embedded cr or cr-lf are replaced by nulls.
 */
}
    
if (verbose) then
begin
    // gui_critSect.Enter();
	AddtoDisplay('Output to Display...');
	// gui_critSect.Leave();
end;

    if ((buf = Nil) or (bsize^ = 0)) then
        SendToDisplay := Nil
    else
    begin
        msg := breakOut(@buf, bsize);
        if (not (AnsiLeftStr(msg, 5) = GDBPrompt)) then
            // Special case exception: "(gdb)"
            msg := AnsiMidStr(msg, 2, Maxint - 1);

        if (verbose) then
        begin
            OutputBuffer := msg;
            // gui_critSect.Enter();
            AddtoDisplay(OutputBuffer);
            // gui_critSect.Leave();
        end;


        if (bsize^ = 0) then  // nothing remains
            SendToDisplay := Nil
        else
            SendToDisplay := buf;
    end;
end;

//===================================================

procedure TGDBDebugger.Next;
var
    Command: TCommand;
begin
    Command := TCommand.Create;
    Command.Command := '-exec-next';
    Command.Callback := OnTrace;
    QueueCommand(Command);
end;

//=================================================================

procedure TGDBDebugger.Step;
var
    Command: TCommand;
begin
    Command := TCommand.Create;
    Command.Command := '-exec-step';
    Command.Callback := OnTrace;
    QueueCommand(Command);
end;

//=================================================================

procedure TGDBDebugger.Finish;
var
    Command: TCommand;
begin
    Command := TCommand.Create;
    Command.Command := devData.DebugCommand;   // -exec-finish
    Command.Callback := OnTrace;
    QueueCommand(Command);

end;

//=================================================================

procedure TGDBDebugger.OnTrace;
begin
    JumpToCurrentLine := True;
    fPaused := False;
    fBusy := False;
end;

//=================================================================

procedure TGDBDebugger.Pause;
begin
    //Do nothing. GDB does not support break-ins.
end;

//=================================================================

procedure TGDBDebugger.SetThread(thread: Integer);
begin
    QueueCommand('-thread-select ', IntToStr(thread));
    RefreshContext;
end;

//=================================================================

procedure TGDBDebugger.SetContext(frame: Integer);
begin
    QueueCommand('-stack-select-frame ', IntToStr(frame));
    RefreshContext([cdLocals, cdWatches]);
end;


//==================================================================
procedure TGDBDebugger.SigRecv(Msg: PString);
// Parses out Signal details

var
  Temp: String;
  Thread, Line: Integer;
  SigName, SigMeaning, Func, SrcFile, frame, Output: String;
  // Ret: Boolean;

begin

  Temp := Msg^;

  //Ret := false;
  frame := ExtractNamed(@Temp, @GDBframe, 1);
  {Ret := }ParseConst(Msg, @GDBsigname, PString(@SigName));
  {Ret := }ParseConst(Msg, @GDBsigmean, PString(@SigMeaning));
  {Ret := }ParseConst(Msg, @GDBthreadid, PInteger(@Thread));
  {Ret := }ParseConst(@frame, @GDBfile, PString(@SrcFile));
  {Ret := }ParseConst(@frame, @GDBfunc, PString(@Func));
  {Ret := }ParseConst(@frame, @GDBline, PInteger(@Line));

  Output := Format('Thread %d stopped in %s at line %d in %s with %s',
    [Thread, Func, Line, SrcFile, SigMeaning]);

  // gui_critSect.Enter();
  AddtoDisplay(Output);
  // gui_critSect.Leave();

  if (SigName = GDBsigsegv) then
    OnAccessViolation;
  // else any other signal?

end;

// ----------------------------------------

procedure TGDBDebugger.FillBreakpointNumber(SrcFile: PString; Line: Integer; Num: Integer);
{

   Part of Third Level Parse of Output.
   Fills Breakpoint table with GDB's breakpoint number
}
var
    I: Integer;
begin

    for I := 0 to Breakpoints.Count - 1 do
        if (PBreakpoint(Breakpoints[I])^.Filename = SrcFile^) and
            (PBreakpoint(Breakpoints[I])^.Line = Line) then
        begin
            PBreakpoint(Breakpoints[I])^.BPNumber := Num;
            Break;
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

procedure TCDBDebugger.Execute(filename, arguments: string);
const
    InputPrompt = '^([0-9]+):([0-9]+)>';
var
    Executable: string;
    WorkingDir: string;
    Srcpath: string;
    I: Integer;
begin
    //Heck about the breakpoint thats coming.
    IgnoreBreakpoint := True;
    self.FileName := filename;

    //Get the name of the debugger
    if (devCompiler.gdbName <> '') then
        Executable := devCompiler.gdbName
    else
        Executable := DBG_PROGRAM(devCompiler.CompilerType);

    //Create the command line
    {if MainForm.fProject.CurrentProfile.compilerType = ID_COMPILER_VC2008 then
        Executable := Format('%s -lines -2 -G -n -s -y "%s" "%s" %s', [Executable, ExtractFilePath(filename) +
    ';SRV*' + IncludeTrailingPathDelimiter(ExtractFilePath(devDirs.Exec)) +
    'Symbols*http://msdl.microsoft.com/download/symbols', filename, arguments]);
    else}
    Executable := Format('%s -lines -2 -G -n -s -y "%s" "%s" %s',
        [Executable, ExtractFilePath(filename) +
        ';SRV*' + IncludeTrailingPathDelimiter(ExtractFilePath(devDirs.Exec)) +
        'Symbols*http://msdl.microsoft.com/download/symbols',
        filename, arguments]);

    //Executable := Format('%s -lines -2 -G -n -s -y "%s" "%s" %s', [Executable, IncludeTrailingPathDelimiter(ExtractFilePath(filename)) +
    //  ';SRV*' + devDirs.Exec +
    //  'Symbols*http://msdl.microsoft.com/download/symbols', filename, arguments]);

    //Run the thing!
    if Assigned(MainForm.fProject) then
        WorkingDir := MainForm.fProject.CurrentProfile.ExeOutput;


    Launch(Executable, WorkingDir);

    //Tell the wait function that another valid output terminator is the 0:0000 prompt
    //Wait.OutputTerminators.Add(InputPrompt);

    //Send the source mode setting (enable all except ONLY source)
    QueueCommand('l+t; l+l; l+s', '');

    //Set all the paths
    Srcpath := ExtractFilePath(Filename) + ';';
    for I := 0 to IncludeDirs.Count - 1 do
        Srcpath := Srcpath + IncludeDirs[I] + ';';
    QueueCommand('.srcpath+', Srcpath);
    QueueCommand('.exepath+', ExtractFilePath(Filename));
end;

procedure TCDBDebugger.Attach(pid: integer);
const
    InputPrompt = '^([0-9]+):([0-9]+)>';
var
    Executable: string;
    Srcpath: string;
    I: Integer;
begin
    //Heck about the breakpoint thats coming.
    IgnoreBreakpoint := True;
    self.FileName := filename;

    //Get the name of the debugger
    if (devCompiler.gdbName <> '') then
        Executable := devCompiler.gdbName
    else
        Executable := DBG_PROGRAM(devCompiler.CompilerType);

    //Create the command line
    Executable := Format('%s -lines -2 -G -n -s -y "%s" -p %d',
        [Executable, ExtractFilePath(filename) +
        ';SRV*' + IncludeTrailingPathDelimiter(ExtractFilePath(devDirs.Exec)) +
        'Symbols*http://msdl.microsoft.com/download/symbols', pid]);

    //Run the thing!
    Launch(Executable, '');

    //Tell the wait function that another valid output terminator is the 0:0000 prompt
    // Wait.OutputTerminators.Add(InputPrompt);

    //Send the source mode setting (enable all except ONLY source)
    QueueCommand('l+t; l+l; l+s', '');

    //Set all the paths
    Srcpath := ExtractFilePath(Filename) + ';';
    for I := 0 to IncludeDirs.Count - 1 do
        Srcpath := Srcpath + IncludeDirs[I] + ';';
    QueueCommand('.srcpath+', Srcpath);
    QueueCommand('.exepath+', ExtractFilePath(Filename));
end;

procedure TCDBDebugger.OnOutput(Output: string);
const
    InputPrompt = '^([0-9]+):([0-9]+)>';
var
    NewLines: TStringList;
    RegExp: TRegExpr;
    CurrBp: TBreakpoint;
    CurLine: String;

    procedure FlushOutputBuffer;
    begin
        if NewLines.Count <> 0 then
        begin
            MainForm.DebugOutput.Lines.BeginUpdate;
            MainForm.DebugOutput.Lines.AddStrings(NewLines);
            MainForm.DebugOutput.Lines.EndUpdate;
            SendMessage(MainForm.DebugOutput.Handle, $00B6 {EM_LINESCROLL}, 0,
                MainForm.DebugOutput.Lines.Count);
            NewLines.Clear;
        end;
    end;

    procedure ParseError(const line: string);
    begin
        if RegExp.Substitute('$3') = 'c0000005' then
            OnAccessViolation
        else
        if RegExp.Substitute('$3') = '40010005' then

        else
        if RegExp.Substitute('$3') = 'c00000fd' then

        else
        if RegExp.Substitute('$3') = '80000003' then
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
            if (CurOutput.Count <> 0) and (CurrentCommand <> nil) and
                Assigned(CurrentCommand.OnResult) then
                CurrentCommand.OnResult(CurOutput);

            if CurrentCommand <> nil then
                if (CurrentCommand.Command = 'g'#10) or
                    (CurrentCommand.Command = 't'#10) or
                    (CurrentCommand.Command = 'p'#10) then
                begin
                    RefreshContext;
                    Application.BringToFront;
                end;
            CurOutput.Clear;

            //Send the command, and do not send any more
            FlushOutputBuffer;
            SendCommand;

            //Make sure we don't save the current line!
            Exit;
        end;

        if RegExp.Exec(line, 'DBGHELP: (.*) - no symbols loaded') then
        begin
            if LowerCase(RegExp.Substitute('$1')) =
                LowerCase(ChangeFileExt(ExtractFileName(Filename), '')) then
                OnNoDebuggingSymbolsFound;
        end
        else
        if RegExp.Exec(line,
            'ModLoad: +([0-9a-fA-F]{1,8}) +([0-9a-fA-F]{1,8}) +(.*)') then
            MainForm.StatusBar.Panels[3].Text :=
                'Loaded ' + RegExp.Substitute('$3')
        else
        if RegExp.Exec(line,
            '\((.*)\): (.*) - code ([0-9a-fA-F]{1,8}) \((.*)\)') then
            ParseError(line)
        else
        if RegExp.Exec(line, 'Breakpoint ([0-9]+) hit') then
        begin
            CurrBp := GetBreakpointFromIndex(
                StrToInt(RegExp.Substitute('$1')));
            if CurrBp <> nil then
                MainForm.GotoBreakpoint(CurrBp.Filename, CurrBp.Line)
            else
                JumpToCurrentLine := True;
        end;

        CurOutput.Add(Line);
    end;
begin
    //Update the memo
    Screen.Cursor := crHourglass;
    Application.ProcessMessages;
    RegExp := TRegExpr.Create;
    NewLines := TStringList.Create;

    try
        while Pos(#10, Output) > 0 do
        begin
            //Extract the current line
            CurLine := Copy(Output, 0, Pos(#10, Output) - 1);

            //Process the output
            if not AnsiStartsStr('DBGHELP: ', CurLine) then
                NewLines.Add(CurLine);
            ParseOutput(CurLine);

            //Remove those that we've already processed
            Delete(Output, 1, Pos(#10, Output));
        end;

        if Length(Output) > 0 then
        begin
            NewLines.Add(Output);
            ParseOutput(Output);
        end;
    except
        on E: Exception do
            madExcept.HandleException;
    end;

    //Add the new lines to the edit control if we have any
    FlushOutputBuffer;

    //Clean up
    RegExp.Free;
    NewLines.Free;
    Screen.Cursor := crDefault;
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
        MessageDlg('Cannot add a breakpoint while the debugger is executing.',
            mtError, [mbOK], MainForm.Handle);
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
        if (PBreakPoint(Breakpoints.Items[i])^.line = breakpoint.Line) and
            (PBreakPoint(Breakpoints.Items[i])^.editor =
            breakpoint.Editor) then
        begin
            if Executing then
                QueueCommand('bc',
                    IntToStr(PBreakpoint(Breakpoints.Items[i])^.Index));
            Dispose(Breakpoints.Items[i]);
            Breakpoints.Delete(i);
            Break;
        end;
end;

procedure TCDBDebugger.RefreshBreakpoint(var breakpoint: TBreakpoint);
var
    Command: TCommand;
begin
    if Executing then
    begin
        Inc(fNextBreakpoint);
        breakpoint.Valid := True;
        breakpoint.Index := fNextBreakpoint;
        Command := TCommand.Create;
        Command.Data := breakpoint;
        Command.Command :=
            Format('bp%d `%s:%d`', [breakpoint.Index, breakpoint.Filename,
            breakpoint.Line]);
        Command.OnResult := OnBreakpointSet;
        QueueCommand(Command);
    end;
end;

procedure TCDBDebugger.OnBreakpointSet(Output: TStringList);
var
    e: TEditor;
begin
    if CurrentCommand.Data = nil then
        Exit;

    with TBreakpoint(CurrentCommand.Data) do
    begin
        Valid := False;
        e := MainForm.GetEditorFromFileName(FileName, True);
        if e <> nil then
            e.InvalidateGutter;
    end;
end;

procedure TCDBDebugger.RefreshContext(refresh: ContextDataSet);
var
    I: Integer;
    Node: TTreeNode;
    Command: TCommand;
    MemberName: string;
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
        Command.Command := 'dv -i -v';
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

       
    end;
end;

procedure TCDBDebugger.OnRefreshContext(Output: TStringList);
begin
end;

procedure TCDBDebugger.AddWatch(varname: string; when: TWatchBreakOn);
var
    Command: TCommand;
    bpType: string;
    Watch: PWatch;
begin

end;

procedure TCDBDebugger.RefreshWatches;
begin
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
        else
        if RegExp.Exec(Output[I],
            '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!(.*)\((.*)\)(|.*) \[(.*) @ ([0-9]*)\]')
        then
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
        else
        if RegExp.Exec(Output[I],
            '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!(.*)(|\((.*)\))(.*)')
        then
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
        if RegExp.Exec(Output[I],
            '([.#]*)( +)([0-9]*)( +)Id: ([0-9a-fA-F]*)\.([0-9a-fA-F]*) Suspend: ([0-9a-fA-F]*) Teb: ([0-9a-fA-F]{1,8}) (.*)') then
        begin
            New(Thread);
            Threads.Add(Thread);

            //Fill the fields
            with Thread^ do
            begin
                Active := RegExp.Substitute('$1') = '.';
                Index := RegExp.Substitute('$3');
                ID := RegExp.Substitute('$5.$6');
                Suspended := RegExp.Substitute('$7') <> '0';
                Frozen := RegExp.Substitute('$9') = 'frozen';
                if Suspended and Frozen then
                    ID := ID + ' (Suspended, Frozen)'
                else
                if Suspended then
                    ID := ID + ' (Suspended)'
                else
                if Frozen then
                    ID := ID + ' (Frozen)';
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
    Command: TCommand;
begin
    Locals := TList.Create;
    LocalsList := TList.Create;
    RegExp := TRegExpr.Create;

    for I := 0 to Output.Count - 1 do
        if RegExp.Exec(Output[I],
            '(.*)( +)(.*)( +)([0-9a-fA-F]{1,8}) +(.*) = (.*)') then
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

    //Now that the locals list has a complete list of values, we want to get the
    //full variable stuff if it is a structure.
    Command := TCommand.Create;
    Command.Command := '';
    for I := 0 to Locals.Count - 1 do
        with PVariable(Locals[I])^ do
            if (Pos('class', Value) > 0) or (Pos('struct', Value) > 0) or
                (Pos('union', Value) > 0) then
                Command.Command :=
                    Format('%sdt -r -b -n %s;', [Command.Command, Name])
            else
            if Pos('[', Value) > 0 then
                Command.Command :=
                    Format('%sdt -a -r -b -n %s;', [Command.Command, Name])
            else
            if Pos('0x', Value) = 1 then
                Command.Command :=
                    Format('%sdt -a -r -b -n %s;', [Command.Command, Name])
            else
                LocalsList.Add(Locals[I]);

    if Command.Command <> '' then
    begin
        Command.OnResult := OnDetailedLocals;
        QueueCommand(Command);
    end
    else
    begin
        if Assigned(TDebugger(Self).OnLocals) then
            TDebugger(Self).OnLocals(LocalsList);
        FreeAndNil(LocalsList);
    end;

    //Clean up
    Locals.Free;
    RegExp.Free;
end;

//This is a complete rip of the watch (dt) parsing code. But I have no choice...
procedure TCDBDebugger.OnDetailedLocals(Output: TStringList);
const
    NotFound = 'Cannot find specified field members.';
    PtrVarPrompt = '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*?)([\[\]\*]+)';
    VarPrompt = '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*)';
    StructExpr = '( +)[\+|=]0x([0-9a-fA-F]{1,8}) ([^ ]*)?( +): (.*)';
    ArrayExpr = '\[([0-9a-fA-F]*)\] @ ([0-9a-fA-F]*)';
    StructArrayExpr = '( *)\[([0-9a-fA-F]*)\] (.*)';
var
    Variables: TStringList;
    SubStructure: TStringList;
    RegExp: TRegExpr;
    Local: PVariable;
    I, J: Integer;

    function SynthesizeIndent(Indent: Integer): string;
    var
        I: Integer;
    begin
        Result := '';
        for I := 0 to Indent - 1 do
            Result := Result + ' ';
    end;

    procedure ParseStructure(Output: TStringList; exIndent: Integer); forward;
    procedure ParseStructArray(Output: TStringList; Indent: Integer);
    var
        I: Integer;
        SubStructure: TStringList;
    begin
        I := 0;
        Indent := 0;
        while I < Output.Count do
            if RegExp.Exec(Output[I], StructArrayExpr) then
            begin
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
                            begin SubStructure.Add(Output[I]); end;
                        end
                        else
                        if RegExp.Exec(Output[I], StructArrayExpr) then
                            if Length(RegExp.Substitute('$1')) <= Indent then
                                Break
                            else
                                SubStructure.Add(Output[I]);

                        Inc(I);
                    end;

                    //Determine if it is a structure or an array
                    ParseStructure(SubStructure, Indent + 4);
                    SubStructure.Free;
                    Dec(I);
                end;
            end;
    end;

    procedure ParseStructure(Output: TStringList; exIndent: Integer);
    var
        SubStructure: TStringList;
        Indent, I: Integer;
    begin
        I := 0;
        Indent := 0;
        while I < Output.Count do
        begin
            if RegExp.Exec(Output[I], StructExpr) or
                RegExp.Exec(Output[I], StructArrayExpr) then
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
                        if RegExp.Exec(Output[I], StructArrayExpr) or
                            RegExp.Exec(Output[I], StructExpr) then
                            if Length(RegExp.Substitute('$1')) <= Indent then
                            begin
                                Inc(I);
                                Break;
                            end
                            else
                                SubStructure.Add(Output[I]);
                        Inc(I);
                    end;

                    //Determine if it is a structure or an array
                    if SubStructure.Count <> 0 then
                        if Trim(SubStructure[0])[1] = '[' then
                            ParseStructArray(SubStructure, Indent + 4)
                        else
                            ParseStructure(SubStructure, Indent + 4);
                    SubStructure.Free;

                    //Decrement I, since we will increment one at the end of the loop
                    Dec(I);
                end
                //Otherwise just add the value
                else
                begin
                    New(Local);
                    Local^.Name :=
                        SynthesizeIndent(Indent + exIndent) +
                        RegExp.Substitute('$3');
                    Local^.Value := RegExp.Substitute('$5');
                    LocalsList.Add(Local);
                end;
            end;

            //Increment I
            Inc(I);
        end;
    end;

    procedure ParseArray(Output: TStringList; Indent: Integer);
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
                        New(Local);
                        Local^.Name :=
                            SynthesizeIndent(Indent) + Substitute('$1');
                        LocalsList.Add(Local);
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
                    ParseStructure(SubStructure, Indent + 4);
                    SubStructure.Free;

                    //Decrement I, since we will increment one at the end of the loop
                    Dec(I);
                end
                else
                    with TRegExpr.Create do
                    begin
                        Exec(Output[I - Increment], ArrayExpr);
                        New(Local);
                        Local^.Name :=
                            SynthesizeIndent(Indent) + Substitute('[$1]');
                        Local^.Value := Output[I];
                        LocalsList.Add(Local);
                        Inc(I);

                        if (I < Output.Count - 1) and
                            Exec(Output[I],
                            ' -> 0x([0-9a-fA-F]{1,8}) +(.*)') then
                        begin
                            New(Local);
                            Local^.Name :=
                                SynthesizeIndent(Indent + 4) +
                                Substitute('$1');
                            Local^.Value := Substitute('$2');
                            LocalsList.Add(Local);
                            Inc(I);
                        end
                        else
                        if RegExp.Exec(Output[I], StructExpr) then
                        begin
                            //Populate the substructure string list
                            SubStructure := TStringList.Create;
                            while (I < Output.Count) and (Output[I] <> '') do
                            begin
                                SubStructure.Add(Output[I]);
                                Inc(I);
                            end;

                            //Process it
                            ParseStructure(SubStructure, Indent + 4);
                            SubStructure.Free;

                            //Decrement I, since we will increment one at the end of the loop
                            Dec(I);
                        end;
                        Free;
                    end;
            end;

            //Increment I
            Inc(I);
        end;
    end;
begin
    SubStructure := TStringList.Create;
    Variables := TStringList.Create;
    RegExp := TRegExpr.Create;

    //Compute the list of commands
    I := 1;
    while I <= Length(CurrentCommand.Command) do
    begin
        if Copy(CurrentCommand.Command, I, 3) = '-n ' then
        begin
            Inc(I, 3);
            J := I;
            while I <= Length(CurrentCommand.Command) do
            begin
                if CurrentCommand.Command[I] = ';' then
                begin
                    Variables.Add(Copy(CurrentCommand.Command, J, I - J));
                    Break;
                end;
                Inc(I);
            end;
        end;
        Inc(I);
    end;

    //Set the type of the structure/class/whatever
    J := 0;
    I := 0;
    while I < Output.Count do
        if RegExp.Exec(Output[I], PtrVarPrompt) then
        begin
            New(Local);
            Local^.Name := Variables[J];
            Local^.Value := RegExp.Substitute('$4$5');
            Local^.Location := RegExp.Substitute('0x$3');
            LocalsList.Add(Local);
            Inc(I);

            while (I < Output.Count) and not
                RegExp.Exec(Output[I], VarPrompt) do
            begin
                SubStructure.Add(Output[I]);
                Inc(I);
            end;

            ParseArray(SubStructure, 4);
            SubStructure.Clear;
            Inc(J);
        end
        else
        if RegExp.Exec(Output[I], VarPrompt) then
        begin
            New(Local);
            Local^.Name := Variables[J];
            Local^.Location := RegExp.Substitute('0x$3');
            Local^.Value := RegExp.Substitute('$4');
            LocalsList.Add(Local);
            Inc(I);

            while (I < Output.Count) and not
                RegExp.Exec(Output[I], VarPrompt) do
            begin
                SubStructure.Add(Output[I]);
                Inc(I);
            end;

            ParseStructure(SubStructure, 4);
            SubStructure.Clear;
            Inc(J);
        end
        else
            Inc(I);

    //Send the list of locals
    if Assigned(TDebugger(Self).OnLocals) then
        TDebugger(Self).OnLocals(LocalsList);
    FreeAndNil(LocalsList);

    SubStructure.Free;
    Variables.Free;
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
        if RegExp.Exec(Output[I],
            'eax=([0-9a-fA-F]{1,8}) ebx=([0-9a-fA-F]{1,8}) ecx=([0-9a-fA-F]{1,8}) edx=([0-9a-fA-F]{1,8}) esi=([0-9a-fA-F]{1,8}) edi=([0-9a-fA-F]{1,8})') then
            with Registers do
            begin
                EAX := RegExp.Substitute('$1');
                EBX := RegExp.Substitute('$2');
                ECX := RegExp.Substitute('$3');
                EDX := RegExp.Substitute('$4');
                ESI := RegExp.Substitute('$5');
                EDI := RegExp.Substitute('$6');
            end
        else
        if RegExp.Exec(Output[I],
            'eip=([0-9a-fA-F]{1,8}) esp=([0-9a-fA-F]{1,8}) ebp=([0-9a-fA-F]{1,8}) iopl=([0-9a-fA-F]{1,8})')
        then
            with Registers do
            begin
                EIP := RegExp.Substitute('$1');
                ESP := RegExp.Substitute('$2');
                EBP := RegExp.Substitute('$3');
            end
        else
        if RegExp.Exec(Output[I],
            'cs=([0-9a-fA-F]{1,4})  ss=([0-9a-fA-F]{1,4})  ds=([0-9a-fA-F]{1,4})  es=([0-9a-fA-F]{1,4})  fs=([0-9a-fA-F]{1,4})  gs=([0-9a-fA-F]{1,4})             efl=([0-9a-fA-F]{1,8})') then
            with Registers do
            begin
                CS := RegExp.Substitute('$1');
                SS := RegExp.Substitute('$2');
                DS := RegExp.Substitute('$3');
                ES := RegExp.Substitute('$4');
                FS := RegExp.Substitute('$5');
                GS := RegExp.Substitute('$6');
                EFLAGS := RegExp.Substitute('$7');
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

    //If func is empty, assume the value of the reguister eip.
    if func = '' then
        func := 'eip';

    Command := TCommand.Create;
    Command.Command := 'uf ' + func;
    Command.OnResult := OnDisassemble;
    QueueCommand(Command);
end;

procedure TCDBDebugger.OnDisassemble(Output: TStringList);
var
    I, CurLine: Integer;
    RegExp: TRegExpr;
    CurFile: string;
    Disassembly: string;
begin
    CurLine := -1;
    RegExp := TRegExpr.Create;
    for I := 0 to Output.Count - 1 do
        if RegExp.Exec(Output[I], '^(.*)!(.*) \[(.*) @ ([0-9]+)]:') then
        begin
            CurLine := StrToInt(RegExp.Substitute('$4'));
            CurFile := RegExp.Substitute('$1!$2 [$3 @ ');
            Disassembly := Disassembly + #9 + ';' + Output[I] + #10;
        end
        else
        if RegExp.Exec(Output[I], '^(.*)!(.*):') then
            Disassembly := Disassembly + #9 + ';' + Output[I] + #10
        else
        if RegExp.Exec(Output[I],
            '^ +([0-9]+) +([0-9a-fA-F]{1,8})( +)([^ ]*)( +)(.*)( +)(.*)') then
        begin
            if StrToInt(RegExp.Substitute('$1')) <> CurLine then
            begin
                CurLine := StrToInt(RegExp.Substitute('$1'));
                Disassembly :=
                    Disassembly + #9 + ';' + CurFile +
                    RegExp.Substitute('$1') + ']:' + #10;
            end;
            Disassembly := Disassembly +
                RegExp.Substitute('$2$3$4$5$6$7$8') + #10;
        end
        else
        if RegExp.Exec(Output[I],
            '^([0-9a-fA-F]{1,8})( +)([^ ]*)( +)(.*)( +)(.*)') then
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
    Command.Data := TString.Create(name);
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
    Name := TString(CurrentCommand.Data).Str;
    CurrentCommand.Data.Free;
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
            if RegExp.Exec(Output[I], '( {' + IntToStr(Depth * 3) +
                '})\+0x([0-9a-fA-F]{1,8}) ' +
                Copy(name, GetLastPos('.', name) + 1, Length(name)) +
                '( +): (.*)') then
                Hint := RegExp.Substitute(name + ' = $4');
    end
    else
        for I := 0 to Output.Count - 1 do
            if RegExp.Exec(Output[I], '( +)(.*) = (.*)') then
                Hint := Trim(Output[I]);

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

procedure TCDBDebugger.Finish;
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
    RefreshContext;
end;

procedure TCDBDebugger.SetContext(frame: Integer);
begin
    QueueCommand('.frame', IntToStr(frame));
    RefreshContext([cdLocals, cdWatches]);
end;

// Debugger virtual functions
procedure TCDBDebugger.FirstParse;
begin
end;

procedure TCDBDebugger.ExitDebugger;
begin
end;

procedure TCDBDebugger.WriteToPipe(Buffer: String);
begin
end;

procedure TCDBDebugger.AddToDisplay(Msg: String);
begin
end;


/////////////////////////////////////////////

{$IFDEF DISPLAYOUTPUTHEX}
{*
 * This is a debugging display
 * Turn on only for development or fault-finding.
 *
}
procedure HexDisplay(buf: PChar; LastRead: DWORD);
var
    Buffer: String;
    CBuffer: String;
    i, j: DWORD;

begin
    Buffer := 'Bytes actually read: ' + IntToStr(LastRead);
    TGDBDebugger(MainForm.fDebugger).AddtoDisplay(Buffer);
    Buffer := '';
    TGDBDebugger(MainForm.fDebugger).AddtoDisplay(buf);
    i := 0;
    repeat
        for j := 0 to 15 do
        begin
            if ((buf[i + j] = CR) or (buf[i + j] = LF)) then
                CBuffer := '   '
            else
                CBuffer := ' ' + buf[i + j] + ' ';
            Buffer := Buffer + CBuffer;
            if (i + j >= LastRead) then
                break;
        end;
        Buffer := Buffer;
        TGDBDebugger(MainForm.fDebugger).AddtoDisplay(Buffer);
        Buffer := '';
        for j := 0 to 15 do
        begin
            CBuffer := ' ' + IntToHex(Ord(buf[i + j]), 2);
            Buffer := Buffer + CBuffer;
            if (i + j >= LastRead) then
                break;
        end;
        Buffer := Buffer;
        TGDBDebugger(MainForm.fDebugger).AddtoDisplay(Buffer);
        Buffer := '';
        i := i + 16;
    until (i >= LastRead);
end;

{$endif}

initialization
    Breakpoints := TList.Create;

finalization
    Breakpoints.Free;

end.