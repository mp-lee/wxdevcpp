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

(* derived from the free pascal editor project source *)
unit Incrementalfrm;

interface

uses
{$IFDEF WIN32}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ActnList, SciLexer, SciLexerMemo, SciLexerMod, ScintillaLanguageManager;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QActnList, QSynEdit, QSynEditTypes;
{$ENDIF}

type
  TfrmIncremental = class(TForm)
    Edit: TEdit;
    ActionList1: TActionList;
    SearchAgain: TAction;
    procedure EditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure SearchAgainExecute(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  public
    SearchString: string;
{$IFDEF SCINTILLA}
    Editor: TScintilla;
{$ELSE}
    Editor: TSynEdit;
    OrgPt        : TBufferCoord;
{$ENDIF}
  private
{$IFDEF SCINTILLA}
{$ELSE}
    rOptions: TSynSearchOptions;
{$ENDIF}
  end;

var
  frmIncremental: TfrmIncremental;

implementation

{$R *.dfm}

uses
{$IFDEF WIN32}
  main;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, main;
{$ENDIF}

procedure TfrmIncremental.EditChange(Sender: TObject);
var
  ALen: Integer;
begin
  ALen := 0;
{$IFDEF SCINTILLA}
  if (Editor.GetAnchor <> Editor.GetCurrentPos) then
  begin
    ALen := Editor.GetSelectionEnd - Editor.GetSelectionStart;
//    Editor.CaretX := Editor.CaretX - ALen;
  end;
{mn  if Editor.SearchReplace(Edit.Text, '', rOptions) = 0 then
  begin
    Include(rOptions, ssoBackwards);
    Editor.CaretX := Editor.CaretX + ALen;
    if Editor.SearchReplace(Edit.Text, '', rOptions) = 0 then
      Edit.Font.Color := clRed
    else
      Edit.Font.Color := clBlack;
  end
  else
    Edit.Font.Color := clBlack;
  rOptions := [];
  if Length(Edit.Text) = 0 then
  begin
    Editor.BlockBegin := OrgPt;
    Editor.BlockEnd := OrgPt;
    Editor.CaretXY := OrgPt;
  end;
mn}
{$ELSE}
  if Editor.SelAvail then
  begin
    ALen := Length(Editor.SelText);
    Editor.CaretX := Editor.CaretX - ALen;
  end;
  if Editor.SearchReplace(Edit.Text, '', rOptions) = 0 then
  begin
    Include(rOptions, ssoBackwards);
    Editor.CaretX := Editor.CaretX + ALen;
    if Editor.SearchReplace(Edit.Text, '', rOptions) = 0 then
      Edit.Font.Color := clRed
    else
      Edit.Font.Color := clBlack;
  end
  else
    Edit.Font.Color := clBlack;
  rOptions := [];
  if Length(Edit.Text) = 0 then
  begin
    Editor.BlockBegin := OrgPt;
    Editor.BlockEnd := OrgPt;
    Editor.CaretXY := OrgPt;
  end;
{$ENDIF}

end;

procedure TfrmIncremental.FormShow(Sender: TObject);
begin
  SearchString := Edit.Text;
  Edit.Text := '';
{$IFDEF SCINTILLA}
{$ELSE}
  OrgPt := Editor.CaretXY;
{$ENDIF}
end;

procedure TfrmIncremental.EditKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    #27: Close;
    #13: Close;
  else
    begin
    end;
  end;
end;

procedure TfrmIncremental.SearchAgainExecute(Sender: TObject);
begin
  MainForm.actFindNextExecute(Self);
{$IFDEF SCINTILLA}
{$ELSE}
  OrgPt := Editor.CaretXY;
{$ENDIF}
end;

procedure TfrmIncremental.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
{$IFDEF WIN32}
    VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN: Close;
{$ENDIF}
{$IFDEF LINUX}
    XK_LEFT, XK_RIGHT, XK_UP, XK_DOWN : Close;
{$ENDIF}
  end;
end;

end.
