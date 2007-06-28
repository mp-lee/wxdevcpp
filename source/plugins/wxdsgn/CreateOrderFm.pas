// $Id: CreateOrderFm.pas 938 2007-05-15 03:57:34Z gururamnath $
{                                                                    }
{   Copyright � 2003-2007 by Guru Kathiresan                         }
{                                                                    }
{License :                                                           }
{=========                                                           }
{The wx-devC++ Components, Form Designer, Utils classes              }
{are exclusive properties of Guru Kathiresan.                        }
{The code is available in dual Licenses:                             }
{                               1)GPL Compatible  License            }
{                               2)Commercial License                 }
{                                                                    }
{1)GPL License :                                                     }
{ Code can be used in any project as long as the project's sourcecode}
{ is published under GPL license.                                    }
{                                                                    }
{2)Commercial License:                                               }
{Use of code in this file or the one that bear this license text     }
{can be used in Non-GPL projects as long as you get the permission   }
{from the Author - Guru Kathiresan.                                  }
{Use of the Code in any non-gpl projects without the permission of   }
{the author is illegal.                                              }
{Contact gururamnath@yahoo.com for details                           }
{ ****************************************************************** }

unit CreateOrderFm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, wxUtils, XPMenu;

type
  TCreationOrderForm = class(TForm)
    btClose: TBitBtn;
    btRefresh: TBitBtn;
    XPMenu: TXPMenu;
    GroupBox1: TGroupBox;
    ControlListBox: TListBox;
    btMoveUp: TBitBtn;
    btMoveDown: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btMoveUpClick(Sender: TObject);
    procedure btMoveDownClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FMainControl:TWinControl;
  public
    { Public declarations }
    procedure SetMainControl(winCtrl:TWinControl);
    procedure PopulateControlList;
  end;

var
  CreationOrderForm: TCreationOrderForm;

implementation

{$R *.DFM}
uses
  wxdesigner;

procedure TCreationOrderForm.SetMainControl(winCtrl:TWinControl);
begin
    FMainControl := winCtrl;
end;

procedure TCreationOrderForm.FormCreate(Sender: TObject);
begin
    DesktopFont := True;
    if wx_designer.XPTheme then
        XPMenu.Active := true
    else
        XPMenu.Active := false;
    FMainControl:=nil;
end;

procedure TCreationOrderForm.PopulateControlList;
var
  I: Integer;
begin
    if FMainControl = nil then
        exit;

    ControlListBox.Items.Clear;
    for I := 0 to FMainControl.ControlCount - 1 do    // Iterate
    begin
      ControlListBox.AddItem(FMainControl.Controls[i].Name, FMainControl.Controls[i]);
    end;
end;

procedure TCreationOrderForm.btMoveUpClick(Sender: TObject);
var
    SelectionObj:TObject;
begin
    if ControlListBox.ItemIndex = -1 then
    begin
        MessageDlg('Please select a control to change creation order.', mtError, [mbOK], 0);
        exit;
    end;
    SelectionObj:=ControlListBox.Items.Objects[ControlListBox.ItemIndex];
    ChangeControlZOrder(ControlListBox.Items.Objects[ControlListBox.ItemIndex],false);
    PopulateControlList;
    if SelectionObj <> nil then
        ControlListBox.ItemIndex:=ControlListBox.Items.IndexOfObject(SelectionObj);
end;

procedure TCreationOrderForm.btMoveDownClick(Sender: TObject);
var
    SelectionObj:TObject;
begin
    if ControlListBox.ItemIndex = -1 then
    begin
        MessageDlg('Please select a control to change creation order.', mtError, [mbOK], 0);
        exit;
    end;

    SelectionObj:=ControlListBox.Items.Objects[ControlListBox.ItemIndex];

    ChangeControlZOrder(ControlListBox.Items.Objects[ControlListBox.ItemIndex],true);
    PopulateControlList;
    if SelectionObj <> nil then
        ControlListBox.ItemIndex:=ControlListBox.Items.IndexOfObject(SelectionObj);
end;

procedure TCreationOrderForm.btCloseClick(Sender: TObject);
begin
    close;
end;

procedure TCreationOrderForm.btRefreshClick(Sender: TObject);
begin
    if FMainControl = nil then
        exit;
    FMainControl.repaint;
end;

procedure TCreationOrderForm.FormShow(Sender: TObject);
begin
  if wx_designer.XPTheme then
    XPMenu.Active := true
  else
    XPMenu.Active := false;
end;

end.