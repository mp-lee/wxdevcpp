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

unit debugreader;

interface

uses 
{$IFDEF WIN32}
  Classes, Windows, ShellAPI, Dialogs, SysUtils, version;
{$ENDIF}
{$IFDEF LINUX}
  Classes, QDialogs, SysUtils, version;
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

implementation

procedure TDebugReader.Execute;
var
  Buffer: array[0..1024] of char;
  LastRead: DWORD;
begin
  while True do
  begin
    Idle := False;
    FillChar(Buffer, sizeof(Buffer), 0);
    if not ReadFile(hPipeRead, Buffer, sizeof(Buffer), LastRead, nil) then
      Break;

    //Now that we have read the data from the pipe, copy the contents
    EnterCriticalSection(OutputCrit);
    Self.Output := Self.Output + Buffer;
    LeaveCriticalSection(OutputCrit);
    Idle := true;

    //Then pass control to our other half.
    SetEvent(EventReady);
  end;
end;

end.
