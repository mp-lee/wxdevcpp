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
{$IFDEF WIN32}
  Sysutils, Classes, Windows, ShellAPI, debugreader,
  version, Dialogs, ComCtrls, StrUtils, Forms;
{$ENDIF}
{$IFDEF LINUX}
  Sysutils, Classes, debugreader,
  version, QDialogs, QComCtrls, StrUtils, QForms;
{$ENDIF}

type
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
  main, devcfg, utils, dbugintf;

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

end.
