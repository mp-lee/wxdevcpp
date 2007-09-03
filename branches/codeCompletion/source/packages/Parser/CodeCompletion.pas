{
    $Id$

    This file is part of wxDev-C++
    Copyright (c) 2007 wxDev-C++ Developers

    wxDev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    wxDev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with wxDev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}
{

    History:
    
      23 May 2004 - Peter Schraut (peter_)
        * Fixed this issue in TCodeCompletion.Search: 
          https://sourceforge.net/tracker/index.php?func=detail&aid=935068&group_id=10639&atid=110639
    
}
unit CodeCompletion;

interface

uses
  CodeToolTip,
{$IFDEF WIN32}
  Windows, Classes, Forms, SysUtils, Controls, Graphics, StrUtils, CppParser,
  ExtCtrls, U_IntList, Dialogs;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, Classes, QForms, SysUtils, QControls, QGraphics, StrUtils, CppParser,
  QExtCtrls, U_IntList, QDialogs, Types;
{$ENDIF}

type
  TCompletionEvent = procedure(Sender: TObject; const AIndex: Integer) of object;
  
  TCodeCompletion = class(TComponent)
  private
    fParser: TCppParser;
    fCompletionStatementList: TIntList;
    fMinWidth: integer;
    fMinHeight: integer;
    fMaxWidth: integer;
    fMaxHeight: integer;
    fPos: TPoint;
    fColor: TColor;
    fWidth: integer;
    fHeight: integer;
    fEnabled: boolean;
    fHintWindow: TBaseCodeToolTip;
    fHintTimer: TTimer;
    fHintTimeout: cardinal;
    fOnKeyPress: TKeyPressEvent;
    fOnResize: TNotifyEvent;
    fOnlyGlobals: Boolean;
    fIncludedFiles: TStringList;

    function GetOnCompletion: TCompletionEvent;
    procedure SetOnCompletion(Value: TCompletionEvent);
    function GetSelectedStatement: Int64;

    procedure GetCompletionFor(Phrase, Filename: string; Line: Integer);
    procedure SetParser(Value: TCppParser);
    procedure SetPosition(Value: TPoint);
    procedure SetHintTimeout(Value: cardinal);
    procedure HintTimer(Sender: TObject);
    procedure ComplKeyPress(Sender: TObject; var Key: Char);
    procedure OnFormResize(Sender: TObject);
    procedure SetColor(Value: TColor);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    procedure Search(Sender: TWinControl; Phrase, Filename: string; Line: Integer);
    procedure Hide;

    procedure ShowArgsHint(Phrase, Filename: string; Line: Integer);
    procedure ShowMsgHint(Rect: TRect; HintText: string);

    property Tooltip: TBaseCodeToolTip read fHintWindow;
  published
    property Parser: TCppParser read fParser write SetParser;
    property SelectedStatement: Int64 read GetSelectedStatement;
    property Position: TPoint read fPos write SetPosition;
    property Color: TColor read fColor write SetColor;
    property Width: integer read fWidth write fWidth;
    property Height: integer read fHeight write fHeight;
    property Enabled: boolean read fEnabled write fEnabled;
    property HintTimeout: cardinal read fHintTimeout write SetHintTimeout;
    property MinWidth: integer read fMinWidth write fMinWidth;
    property MinHeight: integer read fMinHeight write fMinHeight;
    property MaxWidth: integer read fMaxWidth write fMaxWidth;
    property MaxHeight: integer read fMaxHeight write fMaxHeight;
    property OnCompletion: TCompletionEvent read GetOnCompletion write SetOnCompletion;
    property OnKeyPress: TKeyPressEvent read fOnKeyPress write fOnKeyPress;
    property OnResize: TNotifyEvent read fOnResize write fOnResize;
  end;

implementation

uses
  CodeCompletionForm;

{ TCodeCompletion }

constructor TCodeCompletion.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fHintWindow := TBaseCodeToolTip.Create(Self);
  fHintWindow.Color := clInfoBk;
  
  fHintTimer := TTimer.Create(Self);
  fHintTimeout := 4000;
  fHintTimer.Interval := fHintTimeout;
  fHintTimer.OnTimer := HintTimer;
  fHintTimer.Enabled := False;

  fIncludedFiles := TStringList.Create;
  fIncludedFiles.Sorted := True;
  fIncludedFiles.Duplicates := dupIgnore;
  fCompletionStatementList := TIntList.Create;
  CodeComplForm := TCodeComplForm.Create(Self);
  CodeComplForm.fParser := fParser;
  CodeComplForm.fCompletionStatementList := fCompletionStatementList;
  CodeComplForm.OnResize := OnFormResize;
  fWidth := 320;
  fHeight := 240;
  fMinWidth := 256;
  fMinHeight := 128;
  fMaxWidth := 0;
  fMaxHeight := 0;
  fColor := clWindow;
  fEnabled := True;
  fOnlyGlobals := False;
end;

destructor TCodeCompletion.Destroy;
begin
  FreeAndNil(CodeComplForm);
  FreeAndNil(fCompletionStatementList);
  FreeAndNil(fHintWindow);
  FreeAndNil(fHintTimer);
  FreeAndNil(fIncludedFiles);
  inherited Destroy;
end;

procedure TCodeCompletion.GetCompletionFor(Phrase, Filename: string; Line: Integer);
var
  FilteredList: TIntList;
  IdentifierID: Int64;
  IncompleteID: string;
  Scope: Integer;
  I: Integer;
begin
  //Before we can find the identifier we are talking about, we need to find the
  //scope of the current character.
  Scope := fParser.FindScopeOfLine(Filename, Line);

  //Then find the Identifier referred to by Phrase. Phrase can be a class name
  //or a variable, and we're trying to resolve the variable. The Identifier returned
  //is the type of the expression left of the . or -> or ::
  IdentifierID := fParser.FindTypeOf(Phrase, Scope, IncompleteID);

  //Then narrow the list of identifiers to be that of those which are accessible
  //from the scope IdentifierID
  if IdentifierID <> -1 then
    FilteredList := fParser.GetDescendantsOf(IdentifierID, IncompleteID)
  else
    FilteredList := fParser.GetIdentifiersInScope(Scope, True, IncompleteID);
  fCompletionStatementList.Assign(FilteredList);
  FilteredList.Free;

  //Then update the list-box
  CodeComplForm.lbCompletion.Items.BeginUpdate;
  CodeComplForm.lbCompletion.Items.Clear;
  try
    for I := 0 to fCompletionStatementList.Count - 1 do
      CodeComplForm.lbCompletion.Items.Add('');
  except
  end;
  CodeComplForm.lbCompletion.Items.EndUpdate;
end;

procedure TCodeCompletion.Hide;
begin
  CodeComplForm.Hide;
end;

procedure TCodeCompletion.ComplKeyPress(Sender: TObject; var Key: Char);
begin
  if fEnabled then begin
    case Key of
{$IFDEF WIN32}
      Char(vk_Escape), '.', '>': CodeComplForm.Hide;
{$ENDIF}
{$IFDEF LINUX}
      Char(xk_Escape), '.', '>': CodeComplForm.Hide;
{$ENDIF}
    end;

    if Assigned(fOnKeyPress) then
      fOnKeyPress(Sender, Key);
  end;
end;

procedure TCodeCompletion.Search(Sender: TWinControl; Phrase, Filename: string; Line: Integer);
var
  P: TPoint;
begin
  if fEnabled then
  begin
    CodeComplForm.OnKeyPress := ComplKeyPress;
    CodeComplForm.SetColor(fColor);
    
    if (Sender <> nil) and (Sender is TWinControl) then
    begin
      P.X := TWinControl(Sender).Left;
      P.Y := TWinControl(Sender).Top + 16;
      if (Sender.Parent <> nil) and (Sender.Parent is TWinControl) then
        P := TWinControl(Sender.Parent).ClientToScreen(P)
      else
        P := TWinControl(Sender).ClientToScreen(P);
      fPos := P;
      SetPosition(fPos);
    end;

    CodeComplForm.Constraints.MinWidth := fMinWidth;
    CodeComplForm.Constraints.MinHeight := fMinHeight;
    CodeComplForm.Constraints.MaxWidth := 0;
    CodeComplForm.Constraints.MaxHeight := 0;

    CodeComplForm.lbCompletion.Visible := False;

    try
      Screen.Cursor := crHourglass;
      GetCompletionFor(Phrase, Filename, Line);
    finally
      Screen.Cursor := crDefault;
    end;

    CodeComplForm.lbCompletion.Visible := True;
    if fCompletionStatementList.Count > 0 then
    begin
      SetWindowPos(CodeComplForm.Handle, 0, CodeComplForm.Left, CodeComplForm.Top, fWidth, fHeight, SWP_NOZORDER);
      CodeComplForm.lbCompletion.Repaint;
      CodeComplForm.Show;
      CodeComplForm.lbCompletion.SetFocus;
      if CodeComplForm.lbCompletion.Items.Count > 0 then
        CodeComplForm.lbCompletion.ItemIndex := 0;
    end
    else
      CodeComplForm.Hide;
  end;
end;

procedure TCodeCompletion.SetParser(Value: TCppParser);
begin
  if fParser <> Value then begin
    fParser := Value;
    CodeComplForm.fParser := Value;
  end;
end;

procedure TCodeCompletion.SetPosition(Value: TPoint);
begin
  fPos := Value;
  if fPos.X + fWidth > Screen.Width then
    CodeComplForm.Left := fPos.X - fWidth
  else
    CodeComplForm.Left := fPos.X;
  if fPos.Y + fHeight > Screen.Height then
    CodeComplForm.Top := fPos.Y - fHeight - 16
  else
    CodeComplForm.Top := fPos.Y;
end;

procedure TCodeCompletion.OnFormResize(Sender: TObject);
begin
  if Enabled then begin
    fWidth := CodeComplForm.Width;
    fHeight := CodeComplForm.Height;
    if Assigned(fOnResize) then
      fOnResize(Self);
  end;
end;

procedure TCodeCompletion.ShowArgsHint(Phrase, Filename: string; Line: Integer);
var
  I: Integer;
  Overloads: TIntList;
  Prototypes: TStringList;
  FunctionName: string;
  IdentifierDetails: TParseFunctionIdentifier;
  
  TypeID: Int64;
  FuncID: Int64;
  Scope: Int64;
begin
  //Before we can find the identifier we are talking about, we need to find the
  //scope of the current character.
  Scope := fParser.FindScopeOfLine(Filename, Line);

  //Then find the function referred to by Phrase. Phrase can be a class name
  //or a variable, and we're trying to resolve the variable. The Identifier returned
  //is the type of the expression left of the . or -> or ::
  TypeID := fParser.FindTypeOf(Phrase, Scope, FunctionName);

  //Then narrow the list of identifiers to be that of those which are accessible
  //from the scope IdentifierID
  FuncID := fParser.FindIdentifierID(FunctionName, TypeID, [itFunction]);
  if FuncID <> -1 then
  begin
    Overloads := fParser.GetOverloadsOf(FuncID);
    Prototypes := TStringList.Create;
    for I := 0 to Overloads.Count - 1 do
    begin
      IdentifierDetails := fParser.GetIdentifierDetails(Overloads[I]) as TParseFunctionIdentifier;
      Prototypes.Add(IdentifierDetails.Name + IdentifierDetails.Prototype);
      IdentifierDetails.Free;
    end;

    fHintWindow.Hints := Prototypes;
    Overloads.Free;
    Prototypes.Free;

    if fHintWindow.Hints.Count <> 0 then
      fHintWindow.Show
  end
  else
    fHintWindow.ReleaseHandle;
end;

procedure TCodeCompletion.ShowMsgHint(Rect: TRect; HintText: string);
var
  P, MaxX, Lines: integer;
  s, s1: string;
begin
  asm int 3; end;
 { MaxX := 0;
  Lines := 1;
  S := HintText;

  repeat
    P := Pos(#10, S);
    if P > 0 then begin
      S1 := Copy(S, 1, P - 1);
      S := Copy(S, P + 1, MaxInt);
      if fHintWindow.Canvas.TextWidth(S1) > MaxX then
        MaxX := fHintWindow.Canvas.TextWidth(S1) + 8;
      Inc(Lines);
    end
    else begin
      if fHintWindow.Canvas.TextWidth(S) > MaxX then
        MaxX := fHintWindow.Canvas.TextWidth(S) + 8;
    end;
  until P = 0;

  Rect.Right := Rect.Left + MaxX;
  Rect.Bottom := Rect.Top + fHintWindow.Canvas.TextHeight(HintText) * Lines;
  fHintWindow.ActivateHint(Rect, HintText);
  fHintTimer.Enabled := true;}
end;

procedure TCodeCompletion.HintTimer(Sender: TObject);
begin
  fHintWindow.ReleaseHandle;
end;

procedure TCodeCompletion.SetHintTimeout(Value: cardinal);
begin
  if Value <> fHintTimer.Interval then
    fHintTimer.Interval := fHintTimeout;
end;

procedure TCodeCompletion.SetColor(Value: TColor);
begin
  fColor := Value;
end;

function TCodeCompletion.GetOnCompletion: TCompletionEvent;
begin
  Result := CodeComplForm.OnCompletion;
end;

procedure TCodeCompletion.SetOnCompletion(Value: TCompletionEvent);
begin
  CodeComplForm.OnCompletion := Value;
end;

function TCodeCompletion.GetSelectedStatement: Int64;
begin
  Result := fCompletionStatementList[CodeComplForm.lbCompletion.ItemIndex];
end;

end.

