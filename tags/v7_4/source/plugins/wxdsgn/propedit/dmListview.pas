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

unit dmListview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, XPMenu;

type
  TListviewForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    txtCaption: TEdit;
    txtWidth: TEdit;
    cbAlign: TComboBox;
    btMoveDown: TButton;
    btMoveUp: TButton;
    btDelete: TButton;
    btAdd: TButton;
    lbxColumnNames: TListBox;
    GroupBox3: TGroupBox;
    LstViewObj: TListView;
    XPMenu: TXPMenu;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btUpdate: TButton;
    procedure btAddClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbxColumnNamesClick(Sender: TObject);
    procedure btMoveUpClick(Sender: TObject);
    procedure btMoveDownClick(Sender: TObject);
    procedure btUpdateClick(Sender: TObject);
  private
    { Private declarations }
    lastidx: integer;

  public
    { Public declarations }
    lstColumns: TListColumns;
    procedure fillListInfo;
  end;

var
  ListviewForm: TListviewForm;

implementation

uses
  wxdesigner;

{$R *.DFM}

procedure TListviewForm.FormCreate(Sender: TObject);
begin
  DesktopFont := True;
  XPMenu.Active := wx_designer.XPTheme;
  cbAlign.ItemIndex := 0;
  lastIdx := -1;
end;

procedure TListviewForm.fillListInfo;
var
  I: Integer;
begin
  lbxColumnNames.Items.BeginUpdate;
  lbxColumnNames.Items.Clear;
  for I := 0 to LstViewObj.Columns.Count - 1 do // Iterate
  begin
    lbxColumnNames.Items.Add(LstViewObj.Columns[i].Caption);
  end; // for
  lbxColumnNames.Items.EndUpdate;
end;

procedure TListviewForm.btAddClick(Sender: TObject);
var
  lstColumn: TListColumn;
begin
  lstColumn := LstViewObj.Columns.Add;
  lstColumn.Width := StrToInt(txtWidth.Text);
  lstColumn.Caption := txtCaption.Text;
  lstColumn.ImageIndex := -1;
  case cbAlign.ItemIndex of
    -1, 0: lstColumn.Alignment := taLeftJustify;
    1: lstColumn.Alignment := taCenter;
    2: lstColumn.Alignment := taRightJustify;
  end; // case
  fillListInfo;
end;

procedure TListviewForm.btDeleteClick(Sender: TObject);
var
  intColPos: Integer;
begin
  intColPos := lbxColumnNames.ItemIndex;
  if intColPos = -1 then
    Exit;

  lbxColumnNames.DeleteSelected;
  LstViewObj.Columns.Delete(intColPos);

  if lbxColumnNames.ItemIndex > lbxColumnNames.Items.Count then
    lbxColumnNames.ItemIndex := 0
  else
    lbxColumnNames.ItemIndex := -1;
  lbxColumnNamesClick(lbxColumnNames);
end;

procedure TListviewForm.lbxColumnNamesClick(Sender: TObject);
begin
  //Should we enable the buttons?
  btDelete.Enabled   := lbxColumnNames.ItemIndex <> -1;
  btMoveUp.Enabled   := lbxColumnNames.ItemIndex > 0;
  btMoveDown.Enabled := (lbxColumnNames.ItemIndex <> -1) and
                        (lbxColumnNames.ItemIndex <> lbxColumnNames.Count - 1);

  btUpdate.Enabled := lbxColumnNames.ItemIndex <> -1;

  if lbxColumnNames.ItemIndex = -1 then
  begin
    lastidx := -1;
    Exit;
  end;

  //Save the old panel
  if lastIdx <> -1 then
  begin
    lbxColumnNames.Items[lastIdx]       := txtCaption.Text;
    LstViewObj.Columns[lastIdx].Caption := txtCaption.Text;
    LstViewObj.Columns[lastIdx].Width   := StrToInt(txtWidth.Text);
    case cbAlign.ItemIndex of
      0: LstViewObj.Columns[lbxColumnNames.ItemIndex].Alignment := taLeftJustify;
      1: LstViewObj.Columns[lbxColumnNames.ItemIndex].Alignment := taCenter;
      2: LstViewObj.Columns[lbxColumnNames.ItemIndex].Alignment := taRightJustify;
    end;
  end;

  lastIdx := lbxColumnNames.ItemIndex;
  txtCaption.Text := LstViewObj.Columns[lbxColumnNames.ItemIndex].Caption;
  txtWidth.Text := IntToStr(LstViewObj.Columns[lbxColumnNames.ItemIndex].Width);
  case LstViewObj.Columns[lbxColumnNames.ItemIndex].Alignment of //
    taLeftJustify: cbAlign.ItemIndex := 0;
    taCenter: cbAlign.ItemIndex := 1;
    taRightJustify: cbAlign.ItemIndex := 2;
  end; // case

end;

procedure TListviewForm.btMoveUpClick(Sender: TObject);
var
  idx: integer;
begin
  idx := lbxColumnNames.ItemIndex;
  if idx = -1 then
    Exit;

  //Perform a swap
  LstViewObj.Columns[idx].Index := idx - 1;

  //Set the new listbox selection
  lbxColumnNames.Items.Move(lastIdx, lastIdx - 1);
  lbxColumnNames.ItemIndex := lastIdx - 1;
  lastIdx := lastIdx - 1;

  //Lastly, do the button enabling
  btDelete.Enabled   := lastIdx <> -1;
  btMoveUp.Enabled   := lastIdx > 0;
  btMoveDown.Enabled := lastIdx < lbxColumnNames.Count - 1;
end;

procedure TListviewForm.btMoveDownClick(Sender: TObject);
var
  idx: integer;
begin
  idx := lbxColumnNames.ItemIndex;
  if idx = -1 then
    Exit;

  //Perform a swap
  LstViewObj.Columns[idx].Index := idx + 1;

  //set the new listbox selection
  lbxColumnNames.Items.Move(lastIdx, lastIdx + 1);
  lbxColumnNames.ItemIndex := lastIdx + 1;
  lastIdx := lastIdx + 1;

  //Lastly, do the button enabling
  btDelete.Enabled   := lastIdx <> -1;
  btMoveUp.Enabled   := lastIdx > 0;
  btMoveDown.Enabled := lastIdx < lbxColumnNames.Count - 1;
end;

procedure TListviewForm.btUpdateClick(Sender: TObject);
var
  idx: integer;
begin
  idx := lbxColumnNames.ItemIndex;
  if idx = -1 then
    Exit;

  if idx <> -1 then
  begin
    LstViewObj.Columns[idx].Caption := txtCaption.Text;
    LstViewObj.Columns[idx].Width   := StrToInt(txtWidth.Text);
    case cbAlign.ItemIndex of
      0: LstViewObj.Columns[idx].Alignment := taLeftJustify;
      1: LstViewObj.Columns[idx].Alignment := taCenter;
      2: LstViewObj.Columns[idx].Alignment := taRightJustify;
    end;
  end;

end;

end.
