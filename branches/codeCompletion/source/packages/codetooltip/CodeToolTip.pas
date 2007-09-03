{
    $Id$

    This file is part of wxDev-C++
    Copyright (c) 2006 wxDev-C++ Developers

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

    The Initial Developer of the Original Code is Peter Schraut.
    Portions created by Peter Schraut are Copyright (C) 2002, 2003, 2004 by
    Peter Schraut (http://www.console-dev.de)
    All Rights Reserved.
}

unit CodeToolTip;

//The xptooltip looks nicer than the original THintWindow from Delphi and it
//supports alpha blending under Windows 2000 and shadows under XP. It is
//backwards compatible. It should run on Windows 9x too!
{$DEFINE USE_XPTOOLTIP}

interface
uses
  SysUtils, Classes, XPToolTip,
{$IFDEF WIN32}
  Dialogs, Windows, Messages, Graphics, Controls, Menus, Forms, StdCtrls,
  SynEditKbdHandler, SynEdit, SynEditHighlighter;
{$ENDIF}
{$IFDEF LINUX}
  QDialogs, Xlib, QGraphics, QControls, QMenus, QForms, QStdCtrls,
  QSynEditKbdHandler, QSynEdit, QSynEditHighlighter, Types;
{$ENDIF}

type
  TCustomCodeToolTipButton = class(TPersistent)
  private
    FLeft,
    FTop,
    FWidth,
    FHeight: Integer;

  protected
    procedure Paint(const TargetCanvas: TCanvas); virtual; abstract;
    property Left: Integer read FLeft write FLeft;
    property Top: Integer read FTop write FTop;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;

  public
    constructor Create; virtual;
    function ClientRect: TRect;
  end;
  
  
  TCodeToolTipUpButton = class(TCustomCodeToolTipButton)
  private
    FBitmap: TBitmap;

  protected
    procedure Paint(const TargetCanvas: TCanvas); override;

  public
    constructor Create; override;
    destructor Destroy; override;
  end;


  TCodeToolTipDownButton = class(TCustomCodeToolTipButton)
  private
    FBitmap: TBitmap;

  protected
    procedure Paint(const TargetCanvas: TCanvas); override;

  public
    constructor Create; override;
    destructor Destroy; override;
  end;


  { Options to customize the CodeToolTip behavior }
  TToolTipOptions = set of 
  (
    ttoHideOnEnter,               // hides the tooltip when Return has been pressed
    ttoHideOnEsc,                 // hides the tooltip when ESC has been pressed
    ttoPaintStipples,             // paints stippled under the current highlighted argument
    ttoCurrentArgumentBlackOnly,  // force the current argument to be black only
    shoFindBestMatchingToolTip    // automatically find the best matching tooltip (for overloaded functions)
  );
      
      
{$IFDEF USE_XPTOOLTIP}
  TBaseCodeToolTip = class(TXPToolTip)
{$ELSE}
  TBaseCodeToolTip = class(TToolTip)
{$ENDIF}
  private
    FPoint: TPoint;
    FUpButton: TCustomCodeToolTipButton;
    FDownButton: TCustomCodeToolTipButton;
    FDoubleBuffer: TBitmap;

    FOptions: TToolTipOptions;
    FToolTips: TStringList;
    FLookupEditor: TCustomSynEdit;

    FCurrParam: Integer;
    FCustomSelIndex: Boolean; // user clicked up/down
    FSelIndex: Integer;

    procedure SetSelIndex(Value: Integer);
    procedure SetToolTips(const Strings: TStringList);
    procedure SetHighlighter(Highlighter: TSynCustomHighlighter);
    function GetHighlighter: TSynCustomHighlighter;

    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;

  protected
    function FindClosestToolTip: Integer; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    function PaintToolTip: Integer; virtual;

    procedure Activate;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure PositionTooltip(Editor: TCustomSynEdit);
    procedure Show;

  published
    property Hints: TStringList read FToolTips write SetToolTips;
    property Options: TToolTipOptions read FOptions write FOptions;
    property SelIndex: Integer read FSelIndex write SetSelIndex;
    property CurrParam: Integer write FCurrParam;
    property Highlighter: TSynCustomHighlighter read GetHighlighter write SetHighlighter;
  end;

  TCodeToolTip = class(TBaseCodeToolTip)
  published
    property Hints;
    property Options;
    property SelIndex;
    property CurrParam;
    property Highlighter;
  end;
  
implementation
// contains the up/down buttons
// i tried to draw them using DrawFrameControl first,
// but it looked very bad, so I use a bitmap instead.
{$R CodeToolTip.res}

resourcestring
  SCodeToolTipIndexXOfX = '%d / %d';

//----------------- TCustomCodeToolTipButton ---------------------------------------------------------------------------

constructor TCustomCodeToolTipButton.Create;
begin
  FLeft := 0;
  FTop := 0;
  FWidth := 9;
  FHeight := 11;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomCodeToolTipButton.ClientRect: TRect;
begin
  Result := Rect(FLeft, FTop, FLeft + FWidth, FTop + FHeight);
end;

//----------------- TCodeToolTipUpButton -------------------------------------------------------------------------------

constructor TCodeToolTipUpButton.Create;
begin
  inherited;

  FBitmap := TBitmap.Create;
  FBitmap.LoadFromResourceName(HInstance, 'UPBUTTON');
end;

//----------------------------------------------------------------------------------------------------------------------

destructor TCodeToolTipUpButton.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCodeToolTipUpButton.Paint(const TargetCanvas: TCanvas);
begin
  StretchBlt(TargetCanvas.Handle, FLeft, FTop, FWidth, FHeight, 
    FBitmap.Canvas.Handle, 0, 0, FBitmap.Width, FBitmap.Height, SRCCOPY);
end;

//----------------- TCodeToolTipDownButton -----------------------------------------------------------------------------

constructor TCodeToolTipDownButton.Create;
begin
  inherited;

  FBitmap := TBitmap.Create;
  FBitmap.LoadFromResourceName(HInstance, 'DOWNBUTTON');
end;

//----------------------------------------------------------------------------------------------------------------------

destructor TCodeToolTipDownButton.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCodeToolTipDownButton.Paint(const TargetCanvas: TCanvas);
begin
  StretchBlt(TargetCanvas.Handle, FLeft, FTop, FWidth, FHeight, 
    FBitmap.Canvas.Handle, 0, 0, FBitmap.Width, FBitmap.Height, SRCCOPY);
end;

//----------------- TBaseCodeToolTip ---------------------------------------------------------------------------------------

constructor TBaseCodeToolTip.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLookupEditor := TSynEdit.Create(Self);
  FOptions := [ttoHideOnEsc,ttoCurrentArgumentBlackOnly,shoFindBestMatchingToolTip];
  
  FDoubleBuffer := TBitmap.Create;
  with FDoubleBuffer do
  begin
    PixelFormat := pf24Bit;
    Width := Screen.Width; // worst case hintwidth
    Height := 32;
    Canvas.Font := Screen.HintFont;
  end; 

  FToolTips := TStringList.Create;
  with FToolTips do
  begin
    Sorted := True;
    CaseSensitive := True;
    Duplicates := dupIgnore;
  end;

  FUpButton := TCodeToolTipUpButton.Create;
  FUpButton.Left := 4;
  FUpButton.Top := 3;

  FDownButton := TCodeToolTipDownButton.Create;
  FDownButton.Left := 20; // unknown, it's calculated at runtime
  FDownButton.Top := 3;
end;

//----------------------------------------------------------------------------------------------------------------------

destructor TBaseCodeToolTip.Destroy;
begin
  if Activated then
    ReleaseHandle;

  FreeAndNil(FUpButton);
  FreeAndNil(FDownButton);

  FDoubleBuffer.Free;
  FToolTips.Free;

  inherited;
end;

//----------------------------------------------------------------------------------------------------------------------

function TBaseCodeToolTip.FindClosestToolTip: Integer;
  //TODO: lowjoel: Generalize this function (also seen in Editor.pas)
  function CountCommas(const S: string): Integer;
  var
    J: Integer;
  begin
    Result := 0;
    for J := 1 to Length(S) do
      if S[J] = ',' then Inc(Result);
  end;
var
  I, K: Integer;
begin
  Result := FSelIndex;

  // current commacount fits still in the selected tooltip and just do nothing
  if (FSelIndex < FToolTips.Count) and
     (CountCommas(FToolTips.Strings[FSelIndex]) <= FCurrParam) then
    Exit;

  // loop through the list and find the closest matching tooltip
  // we compare the comma counts
  for I := 0 to FToolTips.Count - 1 do
  begin
    K := CountCommas(FToolTips.Strings[I]);
    if (K > FCurrParam) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TBaseCodeToolTip.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Pt: TPoint;
  NeedRefresh: Boolean;
begin  
  inherited;
  
  if Button = mbLeft then
  begin
    NeedRefresh := False;
  
    try
      Pt := ScreenToClient(Mouse.CursorPos);
    
      // check if we clicked in the UpButton
      if PtInRect(FUpButton.ClientRect, Pt) then
      begin
        if FSelIndex < FToolTips.Count - 1 then
          Inc(FSelIndex, 1)
        else
          FSelIndex := 0;
        NeedRefresh := True;
        FCustomSelIndex := True;
      end;

      // check if we clicked in the DownButton
      if PtInRect(FDownButton.ClientRect, Pt) then
      begin
        if FSelIndex > 0
          then Dec(FSelIndex, 1)
        else
          FSelIndex := FToolTips.Count - 1;
        NeedRefresh := True;
        FCustomSelIndex := True;
      end; 

    finally
      //FEditor.SetFocus;
      if NeedRefresh then
        Show;
    end;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TBaseCodeToolTip.Paint;
begin
  PaintToolTip;
  Canvas.CopyRect(ClientRect, FDoubleBuffer.Canvas, ClientRect);
end;

//----------------------------------------------------------------------------------------------------------------------

function TBaseCodeToolTip.PaintToolTip:Integer;
const
  cStipple : array [0..3] of Integer = (0,1,2,1);
var
 BracePos: Integer;
 WidthParam: Integer;
 I: Integer;
 CurParam: Integer;
 S: string;
{$IFDEF WIN32}
 CurChar: Char;
{$ENDIF}
{$IFDEF LINUX}
 CurChar: WideChar;
{$ENDIF}

  procedure DrawParamLetterEx(Index: Integer; CurrentParam: Boolean);
  var
    J: Integer;
    CharW: Integer;
    CharH: Integer;
    StrToken: string;
    HLAttr: TSynHighlighterAttributes;
  begin
    // we use a lookup editor to get the syntax coloring for the tooltips
    FLookupEditor.CaretX := Index;
    FLookupEditor.GetHighlighterAttriAtRowCol(FLookupEditor.CaretXY, StrToken, HLAttr);
    
    with FDoubleBuffer.Canvas do
    begin
      Brush.Style := bsClear;
      if HLAttr <> nil then
        Font.Color := HLAttr.Foreground;

      // if it is the word where the cursor currently is
      // we draw it in bold and also check for further drawing options
      if CurrentParam then
      begin
        Font.Style := [fsBold];
        if (ttoCurrentArgumentBlackOnly in FOptions) then
          Font.Color := clBlack;        
      end
      else if HLAttr <> nil then
        Font.Style := HLAttr.Style
      else
        Font.Style := [];
      
      CharH := TextHeight('Wg');
      CharW := TextWidth(FLookupEditor.Text[Index]);

      // draw the stipple line under the current param-char
      if CurrentParam and (ttoPaintStipples in FOptions) then
        for J := 0 to CharW do
          Pixels[WidthParam+J, CharH-cStipple[J and 3]] := clRed;

      // draw the char and then increase the current width by the
      // width of the just drawn char ...
      TextOut(WidthParam, 1, FLookupEditor.Text[Index]);
      Inc(WidthParam, CharW);      
    end;
  end;

begin
  BracePos := AnsiPos('(', Caption);
  if BracePos > 0 then
  begin
    CurParam := 0;
    WidthParam := 4; // left start position in pixels

    // clear the double buffer
    with FDoubleBuffer.Canvas do
    begin    
      Brush.Color := Self.Color; 
      FillRect(ClientRect); 
    end;

    // when more than one tooltip is in the list
    // we must draw the buttons as well ...
    if FToolTips.Count > 1 then
    begin
      // paint the UP button
      FUpButton.Paint(FDoubleBuffer.Canvas);
      Inc(WidthParam, FUpButton.Left + FUpButton.Width);

      // output text between the buttons
      FDoubleBuffer.Canvas.Font.Style := [];
      S := Format(SCodeToolTipIndexXOfX, [FSelIndex+1, FToolTips.Count]);
      FDoubleBuffer.Canvas.TextOut(WidthParam, 1, S);
      Inc(WidthParam, FDoubleBuffer.Canvas.TextWidth(S)+3);

      // paint the DOWN button
      FDownButton.Paint(FDoubleBuffer.Canvas);
      FDownButton.Left := WidthParam;
      Inc(WidthParam, 3 + FDownButton.Width+FUpButton.Left);
    end;

    // now loop through the hint and draw each letter
    for i := 1 to Length(Caption) do
    begin
      CurChar := Caption[I];
      if AnsiPos(CurChar, ',') > 0 then
        Inc(CurParam);

      if (CurParam = FCurrParam) and not ((CurChar in [')', ' '])) and (I > BracePos) then
        DrawParamLetterEx(I, True) // at current comma index
      else
        DrawParamLetterEx(I, False); // normal
    end;
  end;

  Result := WidthParam + 6;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TBaseCodeToolTip.PositionTooltip(Editor: TCustomSynEdit);
var
  Point: TPoint;
begin
  Point := Editor.ClientToScreen(Editor.RowColumnToPixels(Editor.DisplayXY));
  Inc(Point.Y, Editor.LineHeight);

  if Point.Y = FPoint.Y then
    Point.X := FPoint.X;
  FPoint := Point;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TBaseCodeToolTip.Activate;
var
  NewWidth: Integer;
begin
  NewWidth := PaintToolTip;
  ActivateHint(Rect(FPoint.X, FPoint.Y, FPoint.X + NewWidth,
                    FPoint.Y + Canvas.TextHeight('Wg')),
               Caption)
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TBaseCodeToolTip.SetSelIndex(Value: Integer);
// sets the selection index and repaints the hint when it is activated
begin
  if (Value < 0) or (Value > FToolTips.Count) then
    raise Exception.Create('ToolTip selection index is out of list range!');

  if Value <> FSelIndex then
  begin
    FSelIndex := Value;
    if Activated then 
    begin
      FCustomSelIndex := True;
      Show;
    end;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TBaseCodeToolTip.SetToolTips(const Strings: TStringList);
begin
  FToolTips.Clear;
  FToolTips.Assign(Strings);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TBaseCodeToolTip.SetHighlighter(Highlighter: TSynCustomHighlighter);
begin
  FLookupEditor.Highlighter := Highlighter;
end;

//----------------------------------------------------------------------------------------------------------------------

function TBaseCodeToolTip.GetHighlighter: TSynCustomHighlighter;
begin
  Result := FLookupEditor.Highlighter;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TBaseCodeToolTip.Show;
begin
  Assert(FToolTips <> nil, 'FToolTips must not be nil');

  // when the tooltip is not activated yet we don't have an index of a function
  // prototype to display, so we set it to zero
  if not Activated then
  begin
    FSelIndex := 0;
    FCustomSelIndex := False;
  end;

  // when the user has chosen his own index, when he clicked
  // either the UP or DOWN button, don't try to find the closest
  // tooltip, use the selected index as the string
  if (shoFindBestMatchingToolTip in FOptions) and (not FCustomSelIndex) then
    SelIndex := FindClosestToolTip;

  if (FToolTips.Count > 0) and (FSelIndex < FToolTips.Count) then
    Caption := FToolTips.Strings[FSelIndex]
  else
    Caption := '<unknown>';

  // we use the LookupEditor to get the highlighter-attributes. See PaintToolTip.
  FLookupEditor.Text := Caption;
  Activate;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TBaseCodeToolTip.WMNCHitTest(var Message: TWMNCHitTest);
var
  Pt: TPoint;
begin    
  Message.Result := HTTRANSPARENT;
  Pt := ScreenToClient(Point(Message.XPos,Message.YPos));

  // hitcheck against the position of our both buttons
  if PtInRect(FUpButton.ClientRect, Pt) or PtInRect(FDownButton.ClientRect, Pt) then
  begin
    Message.Result := HTCLIENT;
  end;
end;
  
end.
