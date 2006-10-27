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

unit debugwait;

interface

uses
  Sysutils, Classes, version, StrUtils,
{$IFDEF WIN32}
  Windows, ShellAPI, Dialogs, ComCtrls, Forms;
{$ENDIF}
{$IFDEF LINUX}
  QDialogs, QComCtrls, QForms;
{$ENDIF}

type
  TDebugReader = class(TThread)
  public
    hPipeRead: THandle;
    EventReady: THandle;
    OutputCrit: TRTLCriticalSection;
    Output: string;
    Idle: boolean;

  protected
    procedure Execute; override;
  end;

  TDebugWait = class(TThread)
  public
    Stop: Boolean;
    Event: THandle;
    Reader: TDebugReader;
    OnOutput: procedure(s: string) of object;

  protected
    procedure Execute; override;
    procedure Update;
  end;

  TDebugStatus = class(TThread)
  public
    procedure Update;
  protected
    procedure Execute; override;
  end;

implementation

uses 
  main, devcfg, utils, dbugintf, debugger;

procedure TDebugReader.Execute;
var
  Buffer: array[0..1024] of char;
  LastRead: DWORD;
begin
  while True do
  begin
    FillChar(Buffer, sizeof(Buffer), 0);
    if not ReadFile(hPipeRead, Buffer, sizeof(Buffer), LastRead, nil) then
      Break;

    //Now that we have read the data from the pipe, copy the contents
    EnterCriticalSection(OutputCrit);
    Output := Output + Buffer;
    LeaveCriticalSection(OutputCrit);

    //Then pass control to our other half.
    SetEvent(EventReady);
  end;
end;

procedure TDebugWait.Execute;
begin
  Stop := false;

  while (not Stop) and (not Reader.Suspended) do begin
    //Wait for an event
    WaitForSingleObject(Event, INFINITE);
    if Stop then
      Exit;

    //Call the callback
    Synchronize(Update);
  end;
end;

procedure TDebugWait.Update;
begin
  EnterCriticalSection(Reader.OutputCrit);
  OnOutput(Reader.Output);
  Reader.Output := '';
  LeaveCriticalSection(Reader.OutputCrit);
end;

procedure TDebugStatus.Execute;
begin
  while true do
  begin
    Self.Suspend;
    Synchronize(Update);
  end;
end;

procedure TDebugStatus.Update;
var
  I: integer;
  list: TList;
begin
  with MainForm do
  begin
    fDebugger.RefreshContext;
    lvBacktrace.Items.BeginUpdate;
    lvBacktrace.Items.Clear;
    if fDebugger.Executing then
    begin
      //Ask the debugger for the call stack
      list := fDebugger.CallStack;
      if Assigned(list) then
      begin
        for I := 0 to list.Count - 1 do
          with lvBacktrace.Items.Add do
          begin
            Caption := PStackFrame(list[I])^.FuncName;
            SubItems.Add(PStackFrame(list[I])^.Args);
            SubItems.Add(PStackFrame(list[I])^.Filename);
            SubItems.Add(IntToStr(PStackFrame(list[I])^.Line));
            Data := CppParser1.Locate(Caption, True);
          end;
      end;
    end;
    lvBacktrace.Items.EndUpdate;

    lvLocals.Items.BeginUpdate;
    lvLocals.Items.Clear;
    if fDebugger.Executing then
    begin
      //Ask the debugger for the local variables
      list := fDebugger.Locals;
      if Assigned(list) then
      begin
        for I := 0 to list.Count - 1 do
          with lvLocals.Items.Add do begin
            Caption := PVariable(list[I])^.Name;
            SubItems.Add(PVariable(list[I])^.Value);
            SubItems.Add(PVariable(list[I])^.Location);
          end;
      end;
    end;
    lvLocals.Items.EndUpdate;
  end;
end;

end.
