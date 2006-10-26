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

unit CPUFrm;

interface

uses
{$IFDEF WIN32}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, SynEdit, XPMenu, debugger,
  SynEditHighlighter, SynHighlighterAsm;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QButtons, QSynEdit, debugger;
{$ENDIF}

type
  TCPUForm = class(TForm)
    gbAsm: TGroupBox;
    gbSyntax: TGroupBox;
    rbIntel: TRadioButton;
    rbATT: TRadioButton;
    CloseBtn: TBitBtn;
    edFunc: TEdit;
    lblFunc: TLabel;
    CodeList: TSynEdit;
    gbRegisters: TGroupBox;
    lblEIP: TLabel;
    EIPText: TEdit;
    EAXText: TEdit;
    lblEAX: TLabel;
    EBXText: TEdit;
    lblEBX: TLabel;
    lblECX: TLabel;
    ECXText: TEdit;
    lblEDX: TLabel;
    EDXText: TEdit;
    lblESI: TLabel;
    ESIText: TEdit;
    lblEDI: TLabel;
    EDIText: TEdit;
    lblEBP: TLabel;
    EBPText: TEdit;
    lblESP: TLabel;
    ESPText: TEdit;
    lblCS: TLabel;
    CSText: TEdit;
    lblDS: TLabel;
    DSText: TEdit;
    lblSS: TLabel;
    SSText: TEdit;
    lblES: TLabel;
    ESText: TEdit;
    XPMenu: TXPMenu;
    SynAsmSyn1: TSynAsmSyn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rbSyntaxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edFuncKeyPress(Sender: TObject; var Key: Char);
  private
    ActiveLine: integer;
    fDebugger: TDebugger;

    procedure LoadText;
    procedure OnActiveLine(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
    procedure SetDisassembly(disasm: string);

    { Private declarations }
  public
    { Public declarations }
    procedure PopulateRegisters(debugger: TDebugger);
  end;

var
  CPUForm: TCPUForm;

implementation

uses 
  main, version, MultiLangSupport, utils, devcfg, debugwait, Types; 

{$R *.dfm}

procedure TCPUForm.FormCreate(Sender: TObject);
begin
  ActiveLine := -1;
  CodeList.OnSpecialLineColors := OnActiveLine;
  LoadText;
end;

procedure TCPUForm.LoadText;
begin
  if devData.XPTheme then
    XPMenu.Active := true
  else
    XPMenu.Active := false;
  with Lang do begin
    Caption := Strings[ID_CPU_CAPTION];
    gbAsm.Caption := Strings[ID_CPU_ASMCODE];
    gbSyntax.Caption := Strings[ID_CPU_SYNTAX];
    gbRegisters.Caption := Strings[ID_CPU_REGISTERS];
    lblFunc.Caption := Strings[ID_CPU_FUNC];
    CloseBtn.Caption := Strings[ID_BTN_CLOSE];
  end;
end;

procedure TCPUForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CPUForm := nil;
end;

procedure TCPUForm.edFuncKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and fDebugger.Executing then
    SetDisassembly(fDebugger.Disassemble(edFunc.Text));
end;

procedure TCPUForm.rbSyntaxClick(Sender: TObject);
var
  cb : TCheckBox;
begin
  cb := TCheckBox(sender);
  if fDebugger.Executing then
  begin
    if cb.Tag = 0 then
      fDebugger.SetAssemblySyntax(asATnT)
    else
      fDebugger.SetAssemblySyntax(asIntel);
    SetDisassembly(fDebugger.Disassembly);
  end;
end;

procedure TCPUForm.PopulateRegisters(debugger: TDebugger);
var
  registers: TRegisters;
begin
  fDebugger := debugger;
  registers := fDebugger.Registers;
  if registers <> nil then
    with registers do
    begin
      EAXText.Text := EAX;
      EBXText.Text := EBX;
      ECXText.Text := ECX;
      EDXText.Text := EDX;
      ESIText.Text := ESI;
      EDIText.Text := EDI;
      EBPText.Text := EBP;
      ESPText.Text := ESP;
      EIPText.Text := EIP;
      CSText.Text := CS;
      DSText.Text := DS;
      SSText.Text := SS;
      ESText.Text := ES;
    end;

  SetDisassembly(fDebugger.Disassembly);
end;

procedure TCPUForm.OnActiveLine(Sender: TObject; Line: Integer;
  var Special: Boolean; var FG, BG: TColor);
var pt : TPoint;
  begin
   if (Line = ActiveLine) then begin
    StrtoPoint(pt, devEditor.Syntax.Values[cABP]);
    BG := pt.X;
    FG := pt.Y;
    Special := TRUE;
  end;
end;

procedure TCPUForm.SetDisassembly(disasm: string);
var
  i: integer;
begin
  CodeList.Lines.Text := disasm;
  for i := 0 to CodeList.Lines.Count - 1 do
    if pos(EIPText.Text, CodeList.Lines[i]) <> 0 then begin
      if (ActiveLine <> i) and (ActiveLine <> -1) then
        CodeList.InvalidateLine(ActiveLine);
      ActiveLine := i + 1;
      CodeList.InvalidateLine(ActiveLine);
      CodeList.CaretY := ActiveLine;
      CodeList.EnsureCursorPosVisible;
      break;
    end;
end;

end.
