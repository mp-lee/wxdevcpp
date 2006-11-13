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
  protected
    fEvent: THandle;
    hInputPipe: THandle;
    OutputCrit: TRTLCriticalSection;
    procedure Execute; override;

  public
    Output: string;
    property Event: THandle write fEvent;
    property Pipe: THandle write hInputPipe;
    constructor Create(start: Boolean);
    destructor Destroy; override;
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

implementation

uses 
  main, devcfg, utils, dbugintf, debugger;

constructor TDebugReader.Create(start: Boolean);
begin
  inherited;
  InitializeCriticalSection(OutputCrit);
end;

destructor TDebugReader.Destroy;
begin
  EnterCriticalSection(OutputCrit);
  DeleteCriticalSection(OutputCrit);
  inherited;
end;

procedure TDebugReader.Execute;
var
  Buffer: array[0..1024] of char;
  LastRead: DWORD;
begin
  while True do
  begin
    FillChar(Buffer, sizeof(Buffer), 0);
    if not ReadFile(hInputPipe, Buffer, sizeof(Buffer), LastRead, nil) then
      Break;

    //Now that we have read the data from the pipe, copy the contents
    EnterCriticalSection(OutputCrit);
    Output := Output + Buffer;
    LeaveCriticalSection(OutputCrit);

    //Then pass control to our other half.
    SetEvent(fEvent);
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
var
  LastNewline: Integer;
begin
  EnterCriticalSection(Reader.OutputCrit);
  LastNewLine := GetLastPos(#10, Reader.Output);
  OnOutput(Copy(Reader.Output, 0, LastNewLine));
  Reader.Output := Copy(Reader.Output, LastNewLine + 1, Length(Reader.Output));
  LeaveCriticalSection(Reader.OutputCrit);
end;

end.
