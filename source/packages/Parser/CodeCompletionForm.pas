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

unit CodeCompletionForm;

interface

uses
  U_IntList,
{$IFDEF WIN32}
  Windows, SysUtils, Variants, Classes, Graphics, Forms, StdCtrls, Controls,
  CodeCompletion, CppParser, Grids, Dialogs;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, SysUtils, Variants, Classes, QGraphics, QForms, QStdCtrls, QControls,
  CodeCompletion, CppParser, QGrids, QDialogs, Types;
{$ENDIF}

type
  {** Modified by Peter **}
  TCompletionEvent = procedure(Sender: TObject; const AIndex: Integer) of object;
  
  TCodeComplForm = class(TForm)
    lbCompletion: TListBox;
    procedure FormShow(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure lbCompletionDblClick(Sender: TObject);
    procedure lbCompletionDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lbCompletionKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fOwner: TCodeCompletion;
    fColor: TColor;
    FOnCompletion: TCompletionEvent; {** Modified by Peter **}
  protected
    procedure DoCompletion; virtual;
  public
    { Public declarations }
    fCompletionStatementList: TIntList;
    fParser: TCppParser;
    constructor Create(AOwner: TComponent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetColor(Value: TColor);
  published
    property OnCompletion: TCompletionEvent read FOnCompletion write FOnCompletion; {** Modified by Peter **}
  end;

var
  CodeComplForm: TCodeComplForm;

implementation

{$R *.dfm}

procedure TCodeComplForm.FormCreate(Sender: TObject);
begin
  DesktopFont := True;
end;

procedure TCodeComplForm.FormShow(Sender: TObject);
begin
  Width := fOwner.Width;
  Height := fOwner.Height;
{  lbCompletion.Font.Name := 'Tahoma';
  lbCompletion.Font.Size := 8;}
  lbCompletion.DoubleBuffered := True;
  lbCompletion.SetFocus;
  if lbCompletion.Items.Count > 0 then
    lbCompletion.ItemIndex := 0;
end;

procedure TCodeComplForm.FormDeactivate(Sender: TObject);
begin
  Hide;
end;

procedure TCodeComplForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  Params.Style := Params.Style or WS_SIZEBOX;
end;

constructor TCodeComplForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  
  fOwner := TCodeCompletion(AOwner); 
end;

procedure TCodeComplForm.DoCompletion;
begin
  Hide;
  Application.ProcessMessages;
   
  with lbCompletion do
  begin
    if (FCompletionStatementList.Count > ItemIndex) and (ItemIndex > -1) then
    begin
      if Assigned(FOnCompletion) then
        FOnCompletion(FOwner, ItemIndex); 
    end;
  end;
end;

procedure TCodeComplForm.SetColor(Value: TColor);
begin
  if Value <> fColor then begin
    fColor := Value;
    lbCompletion.Color := fColor;
    Color := fColor;
  end;
end;

procedure TCodeComplForm.lbCompletionDblClick(Sender: TObject);
var
  Key: Char;
begin
  if Assigned(OnKeyPress) then 
  begin
    Key := #13;
    OnKeyPress(Self, Key);
  end;

  DoCompletion;
end;

procedure TCodeComplForm.lbCompletionDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Identifier: TParseIdentifier;
  TextToWrite: string;
  Offset: integer;
  C, BC: TColor;
begin
  if fCompletionStatementList = nil then
    Exit;
  if not lbCompletion.Visible then
    Exit;
  if fCompletionStatementList.Count <= Index {+ 1  ??? }then
    Exit;

  with lbCompletion do
  begin
    if fCompletionStatementList.Count > 0 then
    begin
      Canvas.Font.Assign(Self.Font);
      Identifier := fParser.GetIdentifierDetails(fCompletionStatementList[Index]);
      if odSelected in State then begin
        Canvas.Brush.Color := clHighlight;
        Canvas.FillRect(Rect);
        Canvas.Font.Color := clHighlightText;
      end
      else begin
        Canvas.Brush.Color := fColor;
        Canvas.FillRect(Rect);
        case Identifier.IdentifierType of
          itFunction: Canvas.Font.Color := clGreen;
          itClass: Canvas.Font.Color := clMaroon;
          itVariable: Canvas.Font.Color := clBlue;
          itTypedef: Canvas.Font.Color := clOlive;
          itEnum: Canvas.Font.Color := clNavy;
        else
          Canvas.Font.Color := clGray;
        end;
      end;
      assert(Identifier <> nil);
      Offset := Rect.Bottom - Rect.Top;
      C := Canvas.Font.Color;
      BC := Canvas.Brush.Color;
      Canvas.Font.Color := clWhite;
      Canvas.Pen.Style := psClear;
      Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Left + Offset, Rect.Bottom);
      case Identifier.AccessSpec of
        iaPrivate: Canvas.Brush.Color := clRed;
        iaProtected: Canvas.Brush.Color := clMaroon;
        iaPublic: Canvas.Brush.Color := clGreen;
      end;
      Canvas.Rectangle(Rect.Left + 4, Rect.Top + 4, Rect.Left + Offset - 4, Rect.Bottom - 4);
      Inc(Offset, 8);

      Canvas.Brush.Color := BC;
      Canvas.Font.Color := C;
      Canvas.TextOut(Rect.Left + Offset, Rect.Top, Identifier.IdentifierTypeAsText);
      if not (odSelected in State) then
        Canvas.Font.Color := clWindowText;
      Canvas.Font.Style := [];

      if Identifier is TParseFunctionIdentifier then
        TextToWrite := fParser.FindIdentifierName(TParseFunctionIdentifier(Identifier).Returns)
      else if Identifier is TParseVariableIdentifier then
        TextToWrite := fParser.FindIdentifierName(TParseVariableIdentifier(Identifier).DataType);
      Canvas.TextOut(64 + Rect.Left + Offset, Rect.Top, TextToWrite);
      Offset := Offset + Canvas.TextWidth(TextToWrite + ' ');
      //TODO: lowjoel: Other types of identifiers have different meanings?

      Canvas.Font.Style := [fsBold];
      Canvas.TextOut(64 + Rect.Left + Offset, Rect.Top, Identifier.Name);

      if Identifier is TParseFunctionIdentifier then
      begin
        Offset := Offset + Canvas.TextWidth(Identifier.Name + ' ');
        Canvas.Font.Style := [];
        Canvas.TextOut(64 + Rect.Left + Offset, Rect.Top, TParseFunctionIdentifier(Identifier).Prototype);
      end;

      Identifier.Free;
    end;
  end;
end;

procedure TCodeComplForm.lbCompletionKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
{$IFDEF WIN32}
    VK_TAB,
    VK_RETURN:     
{$ENDIF}
{$IFDEF LINUX}
    XK_TAB,
    XK_RETURN:     
{$ENDIF}
      begin
        DoCompletion;  
      end;
  end;
end;

end.

