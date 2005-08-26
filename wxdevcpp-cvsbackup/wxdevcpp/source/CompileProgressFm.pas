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

unit CompileProgressFm;

interface

uses
{$IFDEF WIN32}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, XPMenu, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QExtCtrls, QComCtrls;
{$ENDIF}

type
  TCompileProgressForm = class(TForm)
    btnClose: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    pb: TProgressBar;
    XPMenu: TXPMenu;
    Label1: TLabel;
    lblCompiler: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lblStatus: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    lblFile: TLabel;
    Bevel3: TBevel;
    lblErr: TLabel;
    Bevel5: TBevel;
    Label4: TLabel;
    lblWarn: TLabel;
    Bevel6: TBevel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CompileProgressForm: TCompileProgressForm;

implementation

{$R *.dfm}

procedure TCompileProgressForm.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  if devData.XPTheme then
    XPMenu.Active := true
  else
    XPMenu.Active := false;
end;

procedure TCompileProgressForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
