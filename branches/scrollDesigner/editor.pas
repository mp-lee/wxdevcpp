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

unit editor;

interface

uses 
{$IFDEF WIN32}
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, CodeCompletion, CppParser,
  Menus, ImgList, ComCtrls, StdCtrls, ExtCtrls, SynEdit, SynEditKeyCmds, version, Grids,
  SynCompletionProposal, StrUtils, SynEditTypes, SynEditHighlighter,

  {** Modified by Peter **}
  CodeToolTip, SynAutoIndent, utils

  {$IFDEF WX_BUILD}
    ,Designerfrm, CompFileIo, wxutils,DbugIntf
  {$ENDIF}
    ;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, Graphics, QControls, QForms, QDialogs, CodeCompletion, CppParser,
  QMenus, QImgList, QComCtrls, QStdCtrls, QExtCtrls, QSynEdit, QSynEditKeyCmds, version, QGrids,
  QSynCompletionProposal, StrUtils, QSynEditTypes, QSynEditHighlighter, 

  {** Modified by Peter **}
  DevCodeToolTip, QSynAutoIndent, Types;
{$ENDIF}

type
  TEditor = class;
  TDebugGutter = class(TSynEditPlugin)
  protected
    fEditor: TEditor;
    procedure AfterPaint(ACanvas: TCanvas; const AClip: TRect;
      FirstLine, LastLine: integer); override;
    procedure LinesInserted(FirstLine, Count: integer); override;
    procedure LinesDeleted(FirstLine, Count: integer); override;
  public
    constructor Create(ed: TEditor);
  end;

  // RNC no longer uses an Editor to toggle
  TBreakpointToggleEvent = procedure (index: integer; BreakExists: boolean) of object;

  TEditor = class
  private
    fInProject: boolean;
    fFileName: string;
    fNew: boolean;
    fRes: boolean;
    fModified: boolean;
    fText: TSynEdit;
{$IFDEF WX_BUILD}
    fDesigner: TfrmNewForm;
    fScrollDesign: TScrollBox;
    fEditorType: TEditorType;
{$ENDIF}
       
    fTabSheet: TTabSheet;
    fErrorLine: integer;
    fActiveLine: integer;
    fErrSetting: boolean;
    fDebugGutter: TDebugGutter;
    fDebugHintTimer: TTimer;
    fCurrentHint: string;
    //////// CODE-COMPLETION - mandrav /////////////
    fCompletionEatSpace: boolean;
    fToolTipTimer: TTimer;
    fTimer: TTimer;
    fTimerKey: Char;
    fCompletionBox: TCodeCompletion;
    fRunToCursorLine: integer;
    fFunctionArgs: TSynCompletionProposal;
    fLastParamFunc: TList;
    FAutoIndent: TSynAutoIndent;
    procedure CompletionTimer(Sender: TObject);
    procedure ToolTipTimer(Sender: TObject);
    procedure EditorOnScroll(Sender: TObject; ScrollBar: TScrollBarKind);
    procedure EditorKeyPress(Sender: TObject; var Key: Char);
    procedure EditorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditorMouseDown(Sender: TObject; Button: TMouseButton; Shift:TShiftState; X, Y: Integer);
    procedure SetEditorText(Key: Char);
    procedure InitCompletion;
    procedure DestroyCompletion;
    function CurrentPhrase: string;
    function CheckAttributes(P: TBufferCoord; Phrase: string): boolean;
    //////// CODE-COMPLETION - mandrav - END ///////
    function GetModified: boolean;
    procedure SetModified(value: boolean);

    procedure TurnOffBreakpoint(line: integer);
    procedure TurnOnBreakpoint(line: integer);

    procedure EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure EditorSpecialLineColors(Sender: TObject; Line: integer;
      var Special: boolean; var FG, BG: TColor);
    procedure EditorGutterClick(Sender: TObject; Button: TMouseButton;
      x, y, Line: integer; mark: TSynEditMark);
    procedure EditorReplaceText(Sender: TObject;
      const aSearch, aReplace: string; Line, Column: integer;
      var Action: TSynReplaceAction);
    procedure EditorDropFiles(Sender: TObject; x, y: integer;
      aFiles: TStrings);
    procedure EditorDblClick(Sender: TObject);
    procedure EditorMouseMove(Sender: TObject; Shift: TShiftState; X, Y:Integer);
    procedure DebugHintTimer(sender: TObject);
    procedure OnVariableHint(Hint: string);

    procedure SetFileName(value: string);
    procedure DrawGutterImages(ACanvas: TCanvas; AClip: TRect;
                               FirstLine, LastLine: integer);
    procedure EditorPaintTransient(Sender: TObject; Canvas: TCanvas;TransientType: TTransientType);
    procedure FunctionArgsExecute(Kind: SynCompletionType; Sender: TObject;
      var AString: String; var x, y: Integer; var CanExecute: Boolean);
  protected
    procedure DoOnCodeCompletion(Sender: TObject; const AIndex: Integer); {** Modified by Peter **}
  public
    procedure Init(In_Project: boolean; Caption_, File_name: string; DoOpen: boolean; const IsRes: boolean = FALSE);
    destructor Destroy; override;
{$IFDEF WX_BUILD}
    procedure Close; // New fnc for wx
{$ENDIF}
    // RNC set the breakpoints for this file when it is opened
    procedure SetBreakPointsOnOpen;

    // RNC 07-21-04
    // Add remove a breakpoint without calling OnBreakpointToggle
    function HasBreakPoint(line_number: integer): integer;
    procedure InsertBreakpoint(line: integer);
    procedure RemoveBreakpoint(line: integer);
    procedure InvalidateGutter;

    procedure Activate;
    function ToggleBreakPoint(Line: integer): boolean;
    procedure RunToCursor(Line: integer);
    procedure GotoLine;
    procedure GotoLineNr(Nr: integer);
    function Search(const isReplace: boolean): boolean;
    procedure SearchAgain;
    procedure SearchKeyNavigation(MoveForward:Boolean = true);
    procedure Exportto(const isHTML: boolean);
    procedure InsertString(const Value: string; const move: boolean);
    {$IFDEF WX_BUILD}
    procedure SetString(const Value: string); // new fnc for wx
    {$ENDIF}
    function GetWordAtCursor: string;
    procedure SetErrorFocus(const Col, Line: integer);
    procedure SetActiveBreakpointFocus(const Line: integer);
    procedure RemoveBreakpointFocus;
    procedure UpdateCaption(NewCaption: string);
    procedure InsertDefaultText;
    procedure PaintMatchingBrackets(TransientType: TTransientType);

    procedure CommentSelection;
    procedure UncommentSelection;
    procedure IndentSelection;
    procedure UnindentSelection;
    
    procedure UpdateParser; // Must be called after recreating the parser
    //////// CODE-COMPLETION - mandrav /////////////
    procedure ReconfigCompletion;
    function GetCodeToolTip: TBaseCodeToolTip;
    //////// CODE-COMPLETION - mandrav /////////////

    property FileName: string read fFileName write SetFileName;
    property InProject: boolean read fInProject write fInProject;
    property New: boolean read fNew write fNew;
    property Modified: boolean read GetModified write SetModified;
    property IsRes: boolean read fRes write fRes;
    property Text: TSynEdit read fText write fText;
    property TabSheet: TTabSheet read fTabSheet write fTabSheet;

    property CodeToolTip: TBaseCodeToolTip read GetCodeToolTip; // added on 23rd may 2004 by peter_
{$IFDEF WX_BUILD}
  private
    fDesignerClassName, fDesignerTitle: string;
    fDesignerStyle: TWxDlgStyleSet;
    fDesignerDefaultData: Boolean;
  public
    procedure ActivateDesigner;
    procedure UpdateDesignerData;
    procedure UpdateXRC;
    function GetDesigner: TfrmNewForm;
    procedure InitDesignerData(strFName, strCName, strFTitle: string; dlgSStyle:TWxDlgStyleSet);
    function GetDesignerHPPFileName: string;
    function GetDesignerCPPFileName: string;

    function GetDesignerHPPText: TSynEdit;
    function GetDesignerCPPText: TSynEdit;

    function IsDesignerCPPOpened: Boolean;
    function IsDesignerHPPOpened: Boolean;

    function GetDesignerHPPEditor: TEditor;
    function GetDesignerCPPEditor: TEditor;
    procedure ReloadForm;
    procedure ReloadFormFromFile(strFilename:String);
    function isForm: Boolean;    
{$ENDIF}

    
  end;

implementation

uses
  MigrateFrm, Main, project, MultiLangSupport, devcfg, Search_Center, datamod,
  GotoLineFrm, Macros, debugger
{$IFDEF LINUX}
  ,Xlib, utils
{$ENDIF};

{ TDebugGutter }

constructor TDebugGutter.Create(ed: TEditor);
begin
  inherited Create(ed.Text);
  fEditor := ed;
end;

procedure TDebugGutter.AfterPaint(ACanvas: TCanvas; const AClip: TRect;
                                  FirstLine, LastLine: integer);
begin
  fEditor.DrawGutterImages(ACanvas, AClip, FirstLine, LastLine);
end;

procedure TDebugGutter.LinesInserted(FirstLine, Count: integer);
begin
  // if this method is not defined -> Abstract error
end;

procedure TDebugGutter.LinesDeleted(FirstLine, Count: integer);
begin
  // if this method is not defined -> Abstract error
end;

{ TEditor }

procedure TEditor.Init(In_Project: boolean; Caption_, File_name: string;
  DoOpen: boolean; const IsRes: boolean = FALSE);
var
  s: string;
  pt: TPoint;
  allowChange: Boolean;
begin
  fModified := false;
  fErrorLine := -1;
  fActiveLine := -1;
  fRunToCursorLine := -1;
  fRes := IsRes;
  fInProject := In_Project;
  fLastParamFunc := nil;
  if File_name = '' then
    fFileName := Caption_
  else
    fFileName := File_name;

{$IFDEF WX_BUILD}
  if iswxForm(fFileName) then
    fEditorType := etForm
  else
    fEditorType := etSource;
{$ENDIF}

  fTabSheet := TTabSheet.Create(MainForm.PageControl);
  fTabSheet.Caption := Caption_;
  fTabSheet.PageControl := MainForm.PageControl;
  fTabSheet.TabVisible := FALSE;
  // This is to have a pointer to the TEditor using the PageControl in MainForm
  fTabSheet.Tag := integer(self);

  fText := TSynEdit.Create(fTabSheet);
  fText.Parent := fTabSheet;

{$IFDEF WX_BUILD}
  if fEditorType = etForm then
  begin
    //Dont allow anyone to edit the text content
    fText.Hide;
    fText.ReadOnly := True;

    //Create the scroll box which we will use to scroll the designer
    fScrollDesign            := TScrollBox.Create(fTabSheet);
    fScrollDesign.AutoScroll := True;
    fScrollDesign.Parent     := fTabSheet;
    fScrollDesign.Align      := alClient;
    fScrollDesign.Visible    := True;
    fScrollDesign.Color      := clWhite;

    //Then create the designer form where the controls will be placed
    fDesigner := TfrmNewForm.Create(fScrollDesign);
    fDesigner.synEdit := fText;
    fDesigner.Parent := fScrollDesign;
  end
  else
  begin
    fDesigner := nil;
    fText.Align := alClient;
  end;
{$ELSE}
  fText.Align := alClient;
{$ENDIF}

  if (DoOpen) then
    try
      fText.Lines.LoadFromFile(FileName);
      fNew := False;
      if devData.Backups then // create a backup of the file
      begin
        s := ExtractfileExt(FileName);
        insert('~', s, pos('.', s) + 1);
        delete(s, length(s) - 1, 1);
          if devEditor.AppendNewline then
            with fText do
              if Lines.Count > 0 then
                if Lines[Lines.Count -1] <> '' then
                  Lines.Add('');
        fText.Lines.SaveToFile(ChangeFileExt(FileName, s));
      end;

{$IFDEF WX_BUILD}
      if fEditorType = etForm then
        ReloadForm;
{$ENDIF}
    except
      raise;
    end
  else
    fNew := True;

{$IFDEF WX_BUILD}
  if fEditorType = etForm then
  begin
    fText.Visible := false;

    fDesigner.Visible := True;
    fDesigner.Left := 8;
    fDesigner.Top := 8;

    if fDesignerDefaultData then
    begin
      if Trim(fDesignerClassName) <> '' then
        fDesigner.Wx_Name := Trim(fDesignerClassName);

      if Trim(fDesigner.Wx_Name) <> '' then
        fDesigner.Wx_IDName := UpperCase('ID_' + fDesigner.Wx_Name);

      if fDesigner.Wx_IDValue = 0 then
        fDesigner.Wx_IDValue := 1000;

      if fDesignerStyle <> [] then
        fDesigner.Wx_DialogStyle := fDesignerStyle;

      if Trim(fDesignerTitle) <> '' then
        fDesigner.Caption := Self.fDesignerTitle;
    end;
  end
  else
{$ENDIF}
    fText.Visible := True;

  fDebugHintTimer := TTimer.Create(Application);
  fDebugHintTimer.Interval := 1000;
  fDebugHintTimer.OnTimer := DebugHintTimer;
  fDebugHintTimer.Enabled := False;

  fToolTipTimer := TTimer.Create(Application);
  fToolTipTimer.Interval := 100;
  fToolTipTimer.OnTimer := ToolTipTimer;
  fToolTipTimer.Enabled := False;

  fText.PopupMenu := MainForm.EditorPopupMenu;
  fText.Font.Color := clWindowText;
  fText.Color := clWindow;
  fText.Font.Name := 'Courier';
  fText.Font.Size := 10;
  fText.WantTabs := True;
  fText.OnStatusChange := EditorStatusChange;
  fText.OnSpecialLineColors := EditorSpecialLineColors;
  fText.OnGutterClick := EditorGutterClick;
  fText.OnReplaceText := EditorReplaceText;
  fText.OnDropFiles := EditorDropFiles;
  fText.OnDblClick := EditorDblClick;
  fText.OnMouseDown := EditorMouseDown;
  fText.OnPaintTransient := EditorPaintTransient;
  fText.OnScroll := EditorOnScroll;

  fText.MaxScrollWidth:=4096; // bug-fix #600748
  fText.MaxUndo := 4096;

  devEditor.AssignEditor(fText);
  if not fNew then
    fText.Highlighter := dmMain.GetHighlighter(fFileName)
  else if fRes then
    fText.Highlighter := dmMain.Res
  else
    fText.Highlighter := dmMain.cpp;

{$IFDEF WX_BUILD}
  if self.isForm then
  begin
    fText.Highlighter := dmMain.Res;
    fDesigner.PopupMenu:=MainForm.DesignerPopup;
  end;
{$ENDIF}

  // update the selected text color
  StrtoPoint(pt, devEditor.Syntax.Values[cSel]);
  fText.SelectedColor.Background := pt.X;
  fText.SelectedColor.Foreground := pt.Y;

  // select the new editor
  MainForm.PageControl.OnChanging(MainForm.PageControl, allowChange);
  fTabSheet.PageControl.ActivePage := fTabSheet;
  fTabSheet.TabVisible := TRUE;

  fDebugGutter := TDebugGutter.Create(self);
  Application.ProcessMessages;
  InitCompletion;

  fFunctionArgs := TSynCompletionProposal.Create(fText);
  with fFunctionArgs do begin
    EndOfTokenChr := '';

    // we dont need triggerchars here anymore, because the tooltips
    // are handled by FCodeToolTip now
    TriggerChars := '';
    TimerInterval := devCodeCompletion.Delay;
    DefaultType := ctParams;
    OnExecute := FunctionArgsExecute;
    Editor := fText;
    Options := Options + [scoUseBuiltInTimer];
{$IFDEF WIN32}
    ShortCut := Menus.ShortCut(Word(VK_SPACE), [ssCtrl, ssShift]);
{$ENDIF}
{$IFDEF LINUX}
    ShortCut := Menus.ShortCut(Word(XK_SPACE), [ssCtrl, ssShift]);
{$ENDIF}
  end;

  // The Editor must have 'Auto Indent' activated  to use FAutoIndent.
  // It's under Tools | Editor Options and then the General tab
  FAutoIndent := TSynAutoIndent.Create(Application);
  FAutoIndent.Editor := FText;
  FAutoIndent.IndentChars := '{:';
  FAutoIndent.UnIndentChars := '}';
  fText.OnMouseMove := EditorMouseMove;

  // monitor this file for outside changes
  MainForm.devFileMonitor.Files.Add(fFileName);
  MainForm.devFileMonitor.Refresh(False);

  // set any breakpoints that should be set in this file
  SetBreakPointsOnOpen;
end;

destructor TEditor.Destroy;
var
  idx: integer;
  lastActPage: Integer;
begin
{$IFDEF WX_BUILD}
  if isForm then
    MainForm.SelectedComponent := nil;
{$ENDIF}

  idx := MainForm.devFileMonitor.Files.IndexOf(fFileName);
  if idx <> -1 then begin
    // do not monitor this file for outside changes anymore
    MainForm.devFileMonitor.Files.Delete(idx);
    MainForm.devFileMonitor.Refresh(False);
  end;

  if Assigned(fDebugHintTimer) then
  begin
    fDebugHintTimer.Enabled := False;
    FreeAndNil(fDebugHintTimer);
  end;

  if Assigned(fToolTipTimer) then
  begin
    fToolTipTimer.Enabled := False;
    FreeAndNil(fToolTipTimer);
  end;

  DestroyCompletion;
  FreeAndNil(fText);

{$IFDEF WX_BUILD}
  if Assigned(fDesigner) then
    FreeAndNil(fScrollDesign);
{$ENDIF}

  //this activates the previous tab if the last one was
  //closed, instead of moving to the first one
  with fTabSheet.PageControl do
  begin
    lastActPage := ActivePageIndex;
    FreeAndNil(fTabSheet);
    if lastActPage >= PageCount then
    begin
      Dec(lastActPage);
      if (lastActPage > 0) and (lastActPage < PageCount) then
        ActivePageIndex := lastActPage;
    end;
  end;

  if Assigned(FAutoIndent) then
    FreeAndNil(FAutoIndent);

  inherited;
end;

procedure TEditor.Activate;
var
  Allow: Boolean;
begin
  if assigned(fTabSheet) then
  begin
    //Broadcast the page change event
    fTabSheet.PageControl.OnChanging(fTabSheet.PageControl, Allow);

    //Then do the actual changing
    fTabSheet.PageControl.Show;
    fTabSheet.PageControl.ActivePage := fTabSheet;
    if fText.Visible then
      fText.SetFocus;

    //Call the post-change event handler
    if MainForm.ClassBrowser1.Enabled {$IFDEF WX_BUILD} or isForm {$ENDIF} then
      MainForm.PageControl.OnChange(MainForm.PageControl); // this makes sure that the classbrowser is consistent
  end;
end;

function TEditor.GetModified: boolean;
var
    boolFTextModified:Boolean;
begin
  boolFTextModified:=false;
  if assigned(fText) then
    boolFTextModified := fText.Modified;
  result := fModified or boolFTextModified;
end;

procedure TEditor.SetModified(value: boolean);
begin
  fModified := value;
  fText.Modified := value;
end;

// RNC 07-21-04 These functions are used to turn off/on a breakpoint
// without calling RemoveBreakpoint or AddBreakpoint in fDebugger.
// This is helpful when trying to automitically remove a breakpoint
// when a user tries to add one while the debugger is running
procedure TEditor.InsertBreakpoint(line: integer);
begin
  if(line>0) and (line <= fText.Lines.Count) then
    begin
      fText.InvalidateLine(line);
      fText.InvalidateGutterLine(line);
    end;
end;

procedure TEditor.RemoveBreakpoint(line: integer);
begin
  if(line > 0) and (line <= fText.Lines.Count) then
    begin
      fText.InvalidateLine(line);
      // RNC new synedit stuff
      fText.InvalidateGutterLine(line);
  end;
end;


// RNC -- 07-02-2004
// I added methods to turn a breakpoint on or off.  Sometimes run to cursor
// got confused and by toggling a breakpoint was turning something on that should
// have been turned off.  By using these functions to explicitly turn on or turn
// off a breakpoint, this cannot happen
procedure TEditor.TurnOnBreakpoint(line: integer);
begin
  if(line > 0) and (line <= fText.Lines.Count) then
  begin
    fText.InvalidateLine(line);
    fText.InvalidateGutterLine(line);
    MainForm.AddBreakPointToList(line, self);
  end;
end;

procedure TEditor.TurnOffBreakpoint(line: integer);
begin
  if(line > 0) and (line <= fText.Lines.Count) then
  begin
    fText.InvalidateLine(line);
    fText.InvalidateGutterLine(line);
    MainForm.RemoveBreakPointFromList(line, self);
  end;
end;

//RNC function to set breakpoints in a file when it is opened
procedure TEditor.SetBreakPointsOnOpen;
var
  i: Integer;
begin
  for i := 0 to debugger.Breakpoints.Count - 1 do
    if PBreakpoint(debugger.Breakpoints.Items[i])^.Filename = fFilename then
    begin
      InsertBreakpoint(PBreakpoint(debugger.Breakpoints.Items[i])^.Line);
      PBreakpoint(debugger.Breakpoints.Items[i])^.Editor := self;
    end;
end;
        
procedure TEditor.Close;
begin
  fText.OnStatusChange := nil;
  fText.OnSpecialLineColors := nil;
  fText.OnGutterClick := nil;
  fText.OnReplaceText := nil;
  fText.OnDropFiles := nil;
  fText.OnDblClick := nil;
  fText.OnMouseDown := nil;
  fText.OnPaintTransient := nil;
  fText.OnKeyPress := nil;

{$IFDEF WX_BUILD}
  //Disable all the form designer features since we no longer exist
  if isForm then
    MainForm.DisableDesignerControls;
{$ENDIF}
  try
    Free;
  except
  end;
end;

function TEditor.ToggleBreakpoint(Line: integer): boolean;
begin
  result := FALSE;
  if (line > 0) and (line <= fText.Lines.Count) then
  begin
    fText.InvalidateGutterLine(line);
    fText.InvalidateLine(line);
    
    //RNC moved the check to see if the debugger is running to here
    if HasBreakPoint(Line) <> -1 then
      MainForm.RemoveBreakPointFromList(line, self)
    else
      MainForm.AddBreakPointToList(line, self);
  end
  else
    fText.Invalidate;
end;

function TEditor.HasBreakPoint(line_number: integer): integer;
begin
  for Result:= 0 to debugger.Breakpoints.Count - 1 do
    if PBreakpoint(debugger.Breakpoints.Items[Result])^.Editor = self then
      if PBreakpoint(debugger.Breakpoints.Items[result])^.Line = line_number then
        Exit;

  //Cannot find an entry
  Result := -1;
end;

procedure TEditor.EditorSpecialLineColors(Sender: TObject; Line: Integer;
  var Special: Boolean; var FG, BG: TColor);
var
  pt: TPoint;
begin
  if (Line = fActiveLine) then begin
    StrtoPoint(pt, devEditor.Syntax.Values[cABP]);
    BG := pt.X;
    FG := pt.Y;
    Special := TRUE;
  end
  else if (HasBreakpoint(line) <> -1) then
  begin
    StrtoPoint(pt, devEditor.Syntax.Values[cBP]);
    BG := pt.x;
    FG := pt.y;
    Special := TRUE;
  end
  else 
   if Line = fErrorLine then
   begin
    StrtoPoint(pt, devEditor.Syntax.Values[cErr]);
    bg := pt.x;
    fg := pt.y;
    Special := TRUE;
  end;
end;

// ** undo after insert removes all text above insert point;
// ** seems to be a synedit bug!!
procedure TEditor.EditorDropFiles(Sender: TObject; x, y: integer;
  aFiles: TStrings);
var
  sl: TStringList;
  idx, idx2: integer;
begin
  if devEditor.InsDropFiles then
  begin
     fText.CaretXY:= fText.DisplayToBufferPos(fText.PixelsToRowColumn(x, y));

    sl := TStringList.Create;
    try
      for idx := 0 to pred(aFiles.Count) do
      begin
        sl.LoadFromFile(aFiles[idx]);
        fText.SelText := sl.Text;
      end;
    finally
      sl.Free;
    end;
  end
  else
    for idx := 0 to pred(aFiles.Count) do
    begin
      idx2 := MainForm.FileIsOpen(aFiles[idx]);
      if idx2 = -1 then
        if GetFileTyp(aFiles[idx]) = utPrj then
        begin
          MainForm.OpenProject(aFiles[idx]);
          exit;
        end
        else
          MainForm.OpenFile(aFiles[idx])
      else
        TEditor(MainForm.PageControl.Pages[idx2].Tag).Activate;
    end;
end;

procedure TEditor.EditorDblClick(Sender: TObject);
begin
  if devEditor.DblClkLine then
  begin
     fText.BlockBegin:= BufferCoord(1, fText.CaretY);
     fText.BlockEnd:= BufferCoord(1, fText.CaretY +1);
  end;
end;

procedure TEditor.EditorGutterClick(Sender: TObject; Button: TMouseButton;
  x, y, Line: integer; mark: TSynEditMark);
begin
  ToggleBreakPoint(Line);
end;

procedure TEditor.EditorReplaceText(Sender: TObject; const aSearch,
  aReplace: string; Line, Column: integer; var Action: TSynReplaceAction);
var
  pt: TPoint;
begin
  if SearchCenter.SingleFile then
  begin
    if aSearch = aReplace then
    begin
        fText.CaretXY:= BufferCoord(Column, Line +1);
      action := raSkip;
    end
    else
    begin
        pt:= fText.ClienttoScreen(fText.RowColumnToPixels(DisplayCoord(Column, Line +1)));

      MessageBeep(MB_ICONQUESTION);
      case MessageDlgPos(format(Lang[ID_MSG_SEARCHREPLACEPROMPT], [aSearch]),
        mtConfirmation, [mbYes, mbNo, mbCancel, mbAll], 0, pt.x, pt.y) of
        mrYes: action := raReplace;
        mrNo: action := raSkip;
        mrCancel: action := raCancel;
        mrAll: action := raReplaceAll;
      end;
    end;
  end;
end;

procedure TEditor.EditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if scModified in Changes then begin
    if Modified then
      UpdateCaption('[*] ' + ExtractfileName(fFileName))
    else
      UpdateCaption(ExtractfileName(fFileName));
  end;
  with MainForm.Statusbar do
  begin
    if Changes * [scAll, scCaretX, scCaretY] <> [] then
    begin
      Panels[0].Text := format('%6d: %-4d', [fText.DisplayY, fText.DisplayX]);
      if not fErrSetting and (fErrorLine <> -1) then
      begin
        fText.InvalidateLine(fErrorLine);
           fText.InvalidateGutterLine(fErrorLine);
        fErrorLine := -1;
        fText.InvalidateLine(fErrorLine);
           fText.InvalidateGutterLine(fErrorLine);
        Application.ProcessMessages;
      end;
    end;
    if Changes * [scAll, scModified] <> [] then
      if fText.Modified then
        Panels[1].Text := Lang[ID_MODIFIED]
      else
        Panels[1].Text := '';
    if fText.ReadOnly then
      Panels[2].Text := Lang[ID_READONLY]
    else 
    if fText.InsertMode then
      Panels[2].Text := Lang[ID_INSERT]
    else
      Panels[2].Text := Lang[ID_OVERWRITE];
    Panels[3].Text := format(Lang[ID_LINECOUNT], [fText.Lines.Count]);
  end;

  if ((scCaretX in Changes) or (scCaretY in Changes)) and
     (Assigned(CodeToolTip) and CodeToolTip.Enabled) then
  begin
    fToolTipTimer.Enabled := False;
    fToolTipTimer.Enabled := True;
  end;
end;

procedure TEditor.ExportTo(const isHTML: boolean);
begin
  if IsHTML then
  begin
    with dmMain.SaveDialog do
    begin
      Filter := dmMain.SynExporterHTML.DefaultFilter;
      DefaultExt := HTML_EXT;
      Title := Lang[ID_NV_EXPORT];
      if Execute then
      begin
        dmMain.ExportToHtml(fText.Lines, dmMain.SaveDialog.FileName);
        fText.BlockEnd := fText.BlockBegin;
      end;
    end;
  end
  else
    with dmMain.SaveDialog do
    begin
      Filter := dmMain.SynExporterRTF.DefaultFilter;
      Title := Lang[ID_NV_EXPORT];
      DefaultExt := RTF_EXT;
      if Execute then
      begin
        dmMain.ExportToRtf(fText.Lines, dmMain.SaveDialog.FileName);
        fText.BlockEnd := fText.BlockBegin;
      end;
    end;
end;

function TEditor.GetWordAtCursor: string;
begin
  result := fText.GetWordAtRowCol(fText.CaretXY);
end;

{** Modified by Peter **}
procedure TEditor.GotoLine;
var
  GotoForm: TGotoLineForm;
begin
  GotoForm := TGotoLineForm.Create(FText);
  try
    GotoForm.Editor := FText;

    if GotoForm.ShowModal = mrOK then
     FText.CaretXY:= BufferCoord(FText.CaretX, GotoForm.Line.Value);

    Activate;
  finally
    GotoForm.Free;
  end;
end;

procedure TEditor.SetString(const Value: string);
begin
  if not assigned(fText) then
    Exit;
  fText.Lines.Text := Value;
end;

procedure TEditor.InsertString(const Value: string; const move: boolean);
var
  Line: string;
  idx,
    idx2: integer;
 pt: TBufferCoord;
  tmp: TStringList;
begin
  if not assigned(fText) then exit;
  pt := fText.CaretXY;
  tmp := TStringList.Create;
  try // move cursor to pipe '|'
    tmp.Text := Value;
    if Move then
      for idx := 0 to pred(tmp.Count) do
      begin
        Line := tmp[idx];
        idx2 := AnsiPos('|', Line);
        if idx2 > 0 then
        begin
          delete(Line, idx2, 1);
          tmp[idx] := Line;

          inc(pt.Line, idx);
          if idx = 0 then
           inc(pt.Char, idx2 -1)
          else
           pt.Char:= idx2;

          break;
        end;
      end;
    Line := tmp.Text;
    fText.SelText := Line;
    fText.CaretXY := pt;
    fText.EnsureCursorPosVisible;
  finally
    tmp.Free;
  end;
end;

function TEditor.Search(const isReplace: boolean): boolean;
var
  s: string;
begin
  if devEditor.FindText then
    if (fText.SelText = '') then
      s := GetWordAtCursor
    else
      s := fText.SelText;

  with SearchCenter do
  begin
    FindText := s;
    Replace := IsReplace;
    ReplaceText := '';
    SingleFile := TRUE;
    Editor := Self;
    Result := ExecuteSearch and not SingleFile; // if changed to "find in all files", open find results
  end;
  Activate;
end;

procedure TEditor.SearchAgain;
var
  Options: TSynSearchOptions;
  return: integer;
begin
  SearchCenter.Editor := Self;
  SearchCenter.AssignSearchEngine;

  if not SearchCenter.SingleFile then exit;
  if SearchCenter.FindText = '' then begin
    Search(false);
    exit;
  end;
  Options := SearchCenter.Options;
  Exclude(Options, ssoEntireScope);

  return := fText.SearchReplace(SearchCenter.FindText,
    SearchCenter.ReplaceText,
    Options);
  if return <> 0 then
    Activate
  else
    MessageDlg(format(Lang[ID_MSG_TEXTNOTFOUND], [SearchCenter.FindText]),
      mtInformation, [mbOk], 0);
end;

procedure TEditor.SearchKeyNavigation(MoveForward:Boolean);
var
  Options: TSynSearchOptions;
  return,MidCursorPos: integer;
  s:String;
  bSelected:boolean;
begin
  bSelected:=false;
  if (fText.SelText = '') then
    s := GetWordAtCursor
  else
  begin
    s := fText.SelText;
    bSelected:=true;
  end;

  SearchCenter.Editor := Self;
  SearchCenter.AssignSearchEngine;
  SearchCenter.FindText := s;

  if not SearchCenter.SingleFile then exit;
  if SearchCenter.FindText = '' then begin
    exit;
  end;
  Options := SearchCenter.Options;
  Exclude(Options, ssoEntireScope);

  if (MoveForward) then
    Exclude(Options, ssoBackwards)
  else
    Include(Options, ssoBackwards);

  return := fText.SearchReplace(SearchCenter.FindText,SearchCenter.ReplaceText,Options);
  if bSelected = false then
  begin
    if fText.SelEnd - fText.SelStart <> 1 then
    begin
      MidCursorPos := fText.SelEnd - ((fText.SelEnd-fText.SelStart) div 2);
      fText.SelStart:= MidCursorPos;
      fText.SelEnd:= MidCursorPos;
    end;
  end;

  if return <> 0 then
    Activate
end;

procedure TEditor.SetErrorFocus(const Col, Line: integer);
begin
  fErrSetting := TRUE;
  Application.ProcessMessages;
  if fErrorLine <> Line then
  begin
    if fErrorLine <> -1 then
      fText.InvalidateLine(fErrorLine);
      fText.InvalidateGutterLine(fErrorLine);
    fErrorLine := Line;
    fText.InvalidateLine(fErrorLine);
     fText.InvalidateGutterLine(fErrorLine);
  end;
     fText.CaretXY:= BufferCoord(col, line);
  fText.EnsureCursorPosVisible;
  fErrSetting := FALSE;
end;

procedure TEditor.SetActiveBreakpointFocus(const Line: integer);
begin
  if (fActiveLine <> Line) and (fActiveLine <> -1) then
    fText.InvalidateLine(fActiveLine);
  fText.InvalidateGutterLine(fActiveLine);
  fActiveLine := Line;
  fText.InvalidateLine(fActiveLine);
  fText.InvalidateGutterLine(fActiveLine);
  fText.CaretY := Line;
  fText.EnsureCursorPosVisible;

  if fRunToCursorLine <> -1 then begin
    TurnOffBreakpoint(fRunToCursorLine);
    fRunToCursorLine := -1;
  end;
end;

procedure TEditor.RemoveBreakpointFocus;
begin
  if fActiveLine <> -1 then
    fText.InvalidateLine(fActiveLine);
   fText.InvalidateGutterLine(fActiveLine);
  fActiveLine := -1;
end;

procedure TEditor.UpdateCaption(NewCaption: string);
begin
  if assigned(fTabSheet) then
    fTabSheet.Caption := NewCaption;
end;

procedure TEditor.SetFileName(value: string);
begin
  if value <> fFileName then
  begin
    ffileName := value;
    UpdateCaption(ExtractfileName(fFileName));
  end;
end;

procedure TEditor.DrawGutterImages(ACanvas: TCanvas; AClip: TRect;
  FirstLine, LastLine: integer);
var
  LH, X, Y: Integer;
  ImgIndex: Integer;
  BreakpointIdx: Integer;

  function IsValidBreakpoint(Breakpoint: Integer): Boolean;
  var
    BP: PBreakpoint;
  begin
    BP := PBreakpoint(debugger.Breakpoints[Breakpoint]);
    Result := Bp^.Valid;
  end;
begin
  X := 14;
  LH := fText.LineHeight;
  Y := (LH - dmMain.GutterImages.Height) div 2
    + LH * (FirstLine - fText.TopLine);

  while FirstLine <= LastLine do begin
    BreakpointIdx := HasBreakpoint(FirstLine);
    if BreakpointIdx  <> -1 then
    begin
      if (not MainForm.fDebugger.Executing) or IsValidBreakpoint(BreakpointIdx) then
        ImgIndex := 0
      else
        ImgIndex := 3;
    end
    else if fActiveLine = FirstLine then
      ImgIndex := 1
    else if fErrorLine = FirstLine then
      ImgIndex := 2
    else
      ImgIndex := -1;
    if ImgIndex >= 0 then
      dmMain.GutterImages.Draw(ACanvas, X, Y, ImgIndex);
    Inc(FirstLine);
    Inc(Y, LH);
  end;
end;

procedure TEditor.InsertDefaultText;
var
  tmp: TStrings;
begin
{$IFDEF WX_BUILD}
  if fEditorType = etSource then
  begin
{$ENDIF}
    if FileExists(devDirs.Config + DEV_DEFAULTCODE_FILE) then
    begin
      tmp := TStringList.Create;
      try
        tmp.LoadFromFile(devDirs.Config + DEV_DEFAULTCODE_FILE);
        InsertString(ParseMacros(tmp.Text), FALSE);
      finally
        tmp.Free;
      end;
    end;
  {$IFDEF WX_BUILD}
  end
  else
  begin
    if fDesigner <> nil then
    begin
      //I dont know how to make the editor to modified stated;
      //so I'm using the InsertString function
      InsertString(' ', FALSE);
      SetString(CompFileIo.ComponentToString(fDesigner));
    end;
  end;
  {$ENDIF}
end;

procedure TEditor.GotoLineNr(Nr: integer);
begin
  fText.CaretXY:= BufferCoord(1, Nr);
  fText.TopLine := Nr;
  Activate;
end;

//////// CODE-COMPLETION - mandrav /////////////
procedure TEditor.EditorKeyPress(Sender: TObject; var Key: Char);
var
  P: TPoint;
begin
  //Guru's CodeRush Commenting function
  //TODO: Guru: Can we make this generic so that other keys can do similar things?
  if fText.SelAvail and (Key = '/') and (Trim(fText.SelText) <> '') then
  begin
    Key := #0;
    fText.SelText := '/* ' + fText.SelText + ' */';
    Exit;
  end;

  if fCompletionBox.Enabled then
  begin
    if not (Sender is TForm) then
    begin // TForm is the code-completion window
      fTimer.Enabled := False;
      fTimerKey := Key;
      case Key of
        '.': fTimer.Enabled := True;
        '>': if (fText.CaretX > 1) and (Length(fText.LineText) > 0) and (fText.LineText[fText.CaretX - 1] = '-') then fTimer.Enabled := True;
        ':': if (fText.CaretX > 1) and (Length(fText.LineText) > 0) and (fText.LineText[fText.CaretX - 1] = ':') then fTimer.Enabled := True;
        ' ': if fCompletionEatSpace then Key := #0; // eat space if it was ctrl+space (code-completion)
      end;
      P := fText.RowColumnToPixels(fText.DisplayXY);
      P.Y := P.Y + fText.LineHeight;

      P := fText.ClientToScreen(P);
      fCompletionBox.Position := P;
    end
    else
    begin
      case Key of
{$IFDEF WIN32}
        Char(vk_Back): if fText.SelStart > 0 then
{$ENDIF}
{$IFDEF LINUX}
        Char(XK_BackSpace): if fText.SelStart > 0 then 
{$ENDIF}
        begin
          fText.SelStart := fText.SelStart - 1;
          fText.SelEnd := fText.SelStart + 1;
          fText.SelText := '';
          fCompletionBox.Search(nil, CurrentPhrase, fFileName, fText.CaretY);
        end;
{$IFDEF WIN32}
        Char(vk_Return):
{$ENDIF}
{$IFDEF LINUX}
        Char(XK_Return):
{$ENDIF}
        begin
          SetEditorText(Key);
          fCompletionBox.Hide;
        end;
        ';', '(':
        begin
          SetEditorText(Key);
          fCompletionBox.Hide;
        end;
        '.', '>', ':':
        begin
          SetEditorText(Key);
          fCompletionBox.Search(nil, CurrentPhrase, fFileName, fText.CaretY);
        end;
        else if Key >= ' ' then
        begin
          fText.SelText := Key;
          fCompletionBox.Search(nil, CurrentPhrase, fFileName, fText.CaretY);
        end;
      end;
    end;
    fCompletionEatSpace := False;
  end;
end;

procedure TEditor.EditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{$IFDEF WIN32}
  if Key = VK_TAB then
{$ENDIF}
{$IFDEF LINUX}
  if Key = XK_TAB then
{$ENDIF}
  begin
    // Indent/Unindent selected text with TAB key, like Visual C++ ...
    if FText.SelText <> '' then
    begin
      if not (ssShift in Shift) then
        FText.ExecuteCommand(ecBlockIndent, #0, nil)
      else
        FText.ExecuteCommand(ecBlockUnindent, #0, nil);
    end;

    Exit;
  end;

{$IFDEF WIN32}
  if CodeToolTip.Activated and (Key in [VK_DOWN, VK_UP, VK_ESCAPE]) then
  begin
    case Key of
      VK_UP:
        if CodeToolTip.SelIndex <> CodeToolTip.Hints.Count - 1 then
          CodeToolTip.SelIndex := CodeToolTip.SelIndex + 1
        else
          CodeToolTip.SelIndex := 0;

      VK_DOWN:
        if CodeToolTip.SelIndex > 0 then
          CodeToolTip.SelIndex := CodeToolTip.SelIndex - 1
        else
          CodeToolTip.SelIndex := CodeToolTip.Hints.Count - 1;

      VK_ESCAPE:
        CodeToolTip.ReleaseHandle;
    end;
    Key := 0;
  end;

  if fCompletionBox.Enabled then
  begin
    fCompletionBox.OnKeyPress := EditorKeyPress;
    if ssCtrl in Shift then
      if Key = VK_SPACE then
      begin
        Key := 0;
        if not (ssShift in Shift) then
          fCompletionBox.Search(nil, CurrentPhrase, fFileName, fText.CaretY);
        fCompletionEatSpace := True;
      end;
  end;
{$ENDIF}
{$IFDEF LINUX}
  NOT IMPLEMENTED;
{$ENDIF}
end;

procedure TEditor.EditorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fText.Cursor := crIBeam;
end;

procedure TEditor.CompletionTimer(Sender: TObject);
var
  curr: string;
begin
  fTimer.Enabled := False;
  curr := CurrentPhrase;

  if not CheckAttributes(BufferCoord(fText.CaretX-1, fText.CaretY), curr) then
  begin
    fTimerKey := #0;
    Exit;
  end;

  case fTimerKey of
    '.': fCompletionBox.Search(nil, curr, fFileName, fText.CaretY);
    '>': if fText.CaretX - 2 >= 0 then
        if fText.LineText[fText.CaretX - 2] = '-' then // it makes a '->'
          fCompletionBox.Search(nil, curr, fFileName, fText.CaretY);
    ':': if fText.CaretX - 2 >= 0 then
        if fText.LineText[fText.CaretX - 2] = ':' then // it makes a '::'
          fCompletionBox.Search(nil, curr, fFileName, fText.CaretY);
  end;
  fTimerKey := #0;
end;

procedure TEditor.ReconfigCompletion;
begin
  // re-read completion options
  fCompletionBox.Enabled := devClassBrowsing.Enabled and devCodeCompletion.Enabled;
  if fCompletionBox.Enabled then
    InitCompletion
  else
    DestroyCompletion;
end;

procedure TEditor.DestroyCompletion;
begin
  if Assigned(fTimer) then
    FreeAndNil(fTimer);
end;

procedure TEditor.InitCompletion;
begin
  fCompletionBox := MainForm.CodeCompletion1;
  fCompletionBox.Enabled := devCodeCompletion.Enabled;
  fCompletionBox.OnCompletion := DoOnCodeCompletion;

  if fCompletionBox.Enabled then begin
    fText.OnKeyPress := EditorKeyPress;
    fText.OnKeyDown := EditorKeyDown;
    fText.OnKeyUp := EditorKeyUp;
    fCompletionBox.OnKeyPress := EditorKeyPress;
    fCompletionBox.Width := devCodeCompletion.Width;
    fCompletionBox.Height := devCodeCompletion.Height;

    if fTimer = nil then
      fTimer := TTimer.Create(nil);
    fTimer.Enabled := False;
    fTimer.OnTimer := CompletionTimer;
    fTimer.Interval := devCodeCompletion.Delay;
  end;

  fCompletionEatSpace := False;
end;

function TEditor.CurrentPhrase: string;
var
  I: integer;
  AllowPar: boolean;
  NestedPar: integer;
begin
  I := fText.CaretX;
  Dec(I, 1);
  NestedPar := 0;
  AllowPar := ((Length(fText.LineText) > 1) and (Copy(fText.LineText, I - 1, 2) = ').')) or
              (Length(fText.LineText) > 2) and (Copy(fText.LineText, I - 2, 3) = ')->');
  while (I <> 0) and (fText.LineText <> '') and (fText.LineText[I] in ['A'..'Z', 'a'..'z', '0'..'9', '_', '.', '-', '>', ':', '(', ')', '[', ']', '~']) do
  begin
    if (fText.LineText[I] = ')') then
      if not AllowPar then
        Break
      else
        Inc(NestedPar)
    else if fText.LineText[I] = '(' then
      if AllowPar then
        if NestedPar > 0 then
          Dec(NestedPar)
        else
          AllowPar := False
      else
        Break;
    Dec(I, 1);
  end;

  //Since the current character is _invalid_ we need to increment it by one
  Inc(I);

  //If the string starts with a delimiter we should remove it
  while (I <= Length(fText.LineText)) and (fText.LineText[I] in ['.', '-', '>', ':', '(', ')', '[', ']']) do
    Inc(I);

  //Then extract the relevant string
  Result := Copy(fText.LineText, I, fText.CaretX - I);
end;

procedure TEditor.SetEditorText(Key: Char);
var
  I, SelEnd: Integer;
  CurrText: string;
  Selection: Int64;
  FuncAddOn: string;
  Identifier: TParseIdentifier;
begin
  CurrText := CurrentPhrase;
  Selection := fCompletionBox.SelectedStatement;
  Identifier := fCompletionBox.Parser.GetIdentifierDetails(Selection);

  try
    if Identifier is TParseFunctionIdentifier then
    begin
      case Key of
        ';': FuncAddOn := '();';
        '.': FuncAddOn := '().';
        '>': FuncAddOn := '()->';
      else
        FuncAddOn := '(';
      end;

      if (not (Key in ['.', '>'])) and (Pos('()', TParseFunctionIdentifier(Identifier).Prototype) = 0) then
      begin
        fText.CaretX := fText.CaretX + 1;
        fFunctionArgs.ExecuteEx(Identifier.Name, fText.DisplayX, fText.DisplayY, ctParams);
      end;
    end
    else
      case Key of
        ';': FuncAddOn := ';';
        ':': FuncAddOn := '::';
        '.': FuncAddOn := '.';
        '>': FuncAddOn := '->';
{$IFDEF WIN32}
        Char(vk_Return)
{$ENDIF}
{$IFDEF LINUX}
        Char(Xk_Return)
{$ENDIF}
           : ;
      else
        FuncAddOn := Key;
      end;

    FuncAddOn := Identifier.Name + FuncAddOn;
  finally
    Identifier.Free;
  end;

  //If there is already a selection, clear it
  if fText.SelAvail then
    fText.SelText := '';

  // find the start of the word
  SelEnd := fText.SelStart;
  I := fText.SelStart;
  while (I <> 0) and (fText.Text[I] in ['A'..'Z', 'a'..'z', '0'..'9', '_']) do
    Dec(I);
  fText.SelStart := I;
  fText.SelEnd := SelEnd;
  fText.SelText := FuncAddOn;
end;

function TEditor.CheckAttributes(P: TBufferCoord; Phrase: string): boolean;
var
  token: string;
  attri: TSynHighlighterAttributes;
begin
  fText.GetHighlighterAttriAtRowCol(P, token, attri);
  Result := not ((not Assigned(Attri)) or
    AnsiStartsStr('.', Phrase) or
    AnsiStartsStr('->', Phrase) or
    AnsiStartsStr('::', Phrase) or
    (
    Assigned(Attri) and
    (
    (Attri.Name = 'Preprocessor') or
    (Attri.Name = 'Comment') or
    (Attri.Name = 'String')
    )
    ));
end;

procedure TEditor.ToolTipTimer(Sender: TObject);
  function PreviousWordString(S: string; Index: Integer):string;
  var
    I: Integer;
    TplArgs: Integer;

    procedure SkipSpaces;
    begin
      repeat
        Dec(Index);
      until (Index = 0) or (not (S[Index] in [#32,#9]));
    end;
  begin
    Result := '';
    if (Index <= 1) or (S = '') then
      Exit;

    // Skip blanks and tabs
    SkipSpaces;

    // Skip template parameters
    if S[Index] = '>' then //template parameter
    begin
      TplArgs := 1;
      while (TplArgs <> 0) and (Index > 1) do
      begin
        Dec(Index);
        case S[Index] of
          '>':
            Inc(TplArgs);
          '<':
            Dec(TplArgs);
        end;
      end;
    end;

    Inc(Index);
    I := Index;
    repeat
      Dec(Index);
      if Index < 2 then
        Break;
    until not (S[Index] in ['a'..'z', 'A'..'Z', '_', '.']);

    if not (S[Index] in ['a'..'z', 'A'..'Z', '_', '.']) then
      Inc(Index);

    Result := Copy(S, Index, I-Index);
  end;
  
  function FindStart: integer;
  var
    FillingParameter: Boolean;
    Brackets: Integer;
    I: Integer;
  begin
    //Give the current selection index, we need to find the start of the function
    FillingParameter := False;
    I := FText.SelStart;
    Brackets := -1;
    Result := -1;
    
    //Make sure the offset is valid
    if I > Length(FText.Text) then
      Exit;
    
    while I > 0 do
    begin
      if (I < 0) then
        break;
      case FText.Text[I] of
        ')':
          Dec(Brackets);
        '(':
          begin
            Inc(Brackets);
            if Brackets = 0 then
            begin
              Result := I;
              Exit;
            end
          end;
        #10, #13:
          //Make sure we are not within a function call
          if not FillingParameter then
          begin
            //Skip whitespace so we can see what is the last character
            while (I > 1) and (FText.Text[I - 1] in [#10, #13, #9, ' ']) do
              Dec(I); //Previous character is whitespace, skip it

            //Is the character a comma or an opening parenthesis?
            if I > 2 then
              if not (FText.Text[I - 1] in [',', '(']) then
                Exit;
          end;
        '{', '}':
          Exit;
        ',':
          FillingParameter := True;
        else
          FillingParameter := False;
      end;

      Dec(I);
    end;
  end;

  function CountCommas(const S: string): Integer;
  var
    J: Integer;
  begin
    Result := 0;
    for J := 1 to Length(S) do
      if S[J] = ',' then Inc(Result);
  end;
var
  Phrase: string;
  Start: Integer;
begin
  // stop the timer so we don't recurse
  fToolTipTimer.Enabled := False;

  //Then look for the string to pass to the Completion object
  Start := FindStart;
  Phrase := PreviousWordString(fText.Text, Start);

  //Position the text box properly
  fCompletionBox.Tooltip.PositionTooltip(fText);
  fCompletionBox.Tooltip.CurrParam := CountCommas(Copy(fText.Text, Start + 1, fText.SelStart - Start));
  fCompletionBox.ShowArgsHint(Phrase, FileName, fText.CaretY);
end;

procedure TEditor.EditorOnScroll(Sender: TObject; ScrollBar: TScrollBarKind);
begin
  if Assigned(CodeToolTip) and (CodeToolTip.Caption <> '') and CodeToolTip.Activated then
    CodeToolTip.PositionTooltip(fText);
end;
//////// CODE-COMPLETION - mandrav - END ///////

// variable info
procedure TEditor.EditorMouseMove(Sender: TObject; Shift: TShiftState; X, Y:Integer);
var s, s1: string;
    p : TBufferCoord;
  	I,j,slen: integer;
    attr:TSynHighlighterAttributes;
begin
  fDebugHintTimer.Enabled := false;

  //check if not comment or string
  //if yes - exit without hint
  p := fText.DisplayToBufferPos(fText.PixelsToRowColumn(X, Y));
  if fText.GetHighlighterAttriAtRowCol(p, s, attr) then
    if (attr = fText.Highlighter.StringAttribute)
    or (attr = fText.Highlighter.CommentAttribute) then
    begin
      fText.Hint:='';
      Exit;
    end;

  if devEditor.ParserHints and (not MainForm.fDebugger.Executing) then begin // editing - show declaration of word under cursor in a hint
    p.Char := X;
    p.Line := Y;
    p := fText.DisplayToBufferPos(fText.PixelsToRowColumn(p.Char, p.Line));
    s := fText.GetWordAtRowCol(p);
  end
  else if devData.WatchHint and MainForm.fDebugger.Executing then begin // debugging - evaluate var under cursor and show value in a hint
    p := fText.DisplayToBufferPos(fText.PixelsToRowColumn(X, Y));
    I:=P.Char;
    s1:=fText.Lines[p.Line-1];
    if (I <> 0) and (s1 <> '') then
    begin
      j := Length(s1);
      while (I < j) and (s1[I] in ['A'..'Z', 'a'..'z', '0'..'9', '_']) do
      Inc(I); 
    end;
    P.Char:=I;
    Dec(I);

    if (s1 <> '') then
    begin
      slen := Length(s1);
      //index of S was not checked before we use it.
      //The debugger mode crash is due to this.
      while (slen >= I) and (I <> 0) and (s1[I] in ['A'..'Z', 'a'..'z', '0'..'9', '_', '.', '-', '>', '&', '*']) do
      Dec(I, 1);
    end;
    s := Copy(s1, I + 1, p.Char - I - 1);
  end;

  if (s <> '') and (not fDebugHintTimer.Enabled) then begin
    fDebugHintTimer.Enabled := true;
    fCurrentHint := s;
  end
  else if s = '' then
    fText.Hint := '';

  if s<>'' then begin
    if ssCtrl in Shift then
      fText.Cursor := crHandPoint
    else
      fText.Cursor := crIBeam;
  end
  else
    fText.Cursor := crIBeam;
end;

procedure TEditor.DebugHintTimer(sender: TObject);
var
  r: TRect;
  p: TPoint;
//  st: PStatement;
  M: TMemoryStream;
begin
  fDebugHintTimer.Enabled := false;
  p := fText.ScreenToClient(Mouse.CursorPos);
  // is the mouse still inside the editor?
  if (p.X <= 0) or (p.X >= fText.Width) or
    (p.Y <= 0) or (p.Y >= fText.Height) then
    Exit;

  if fCurrentHint <> '' then begin
    if not MainForm.fDebugger.Executing then begin // editing - show declaration of word under cursor in a hint
      r.Left := Mouse.CursorPos.X;
      r.Top := Mouse.CursorPos.Y;
      r.Bottom := Mouse.CursorPos.Y + 10;
      r.Right := Mouse.CursorPos.X + 60;
      M := TMemoryStream.Create;
      try
        fText.Lines.SaveToStream(M);
        //TODO: lowjoel: How do we determine the current class we're in?
        //MainForm.CppParser1.FindAndScanBlockAt(fFileName, fText.PixelsToRowColumn(fText.ScreenToClient(Mouse.CursorPos).X,
//          fText.ScreenToClient(Mouse.CursorPos).Y).Row, M)
      finally
        M.Free;
      end;
//      st := PStatement(MainForm.CppParser1.Locate(fCurrentHint, False));
//      if Assigned(st) and (not FCodeToolTip.Activated) then begin
//        fCurrentHint := st^._FullText;
//        fCompletionBox.ShowMsgHint(r, fCurrentHint);
//      end;
    end
    else if devData.WatchHint and MainForm.fDebugger.Executing then // debugging - evaluate var under cursor and show value in a hint
    begin
      MainForm.fDebugger.OnVariableHint := OnVariableHint;
      MainForm.fDebugger.GetVariableHint(fCurrentHint);
    end;
  end;
end;

procedure TEditor.OnVariableHint(Hint: string);
begin
  fText.Hint := Hint;
  fText.ShowHint := True;
  if not CodeToolTip.Activated then
    Application.ActivateHint(Mouse.CursorPos);
end;

procedure TEditor.CommentSelection;
var
  S: string;
  Offset: integer;
  backup: TBufferCoord;
begin
  if Text.SelAvail then begin // has selection
    backup := Text.CaretXY;
    Text.BeginUpdate;
    S := '//' + Text.SelText;
    Offset := 0;
    if S[Length(S)]=#10 then begin // if the selection ends with a newline, eliminate it
      if S[Length(S) - 1] = #13 then // do we ignore 1 or 2 chars?
        Offset := 2
      else
        Offset := 1;
      S := Copy(S, 1, Length(S) - Offset);
    end;
    S := StringReplace(S, #10, #10'//', [rfReplaceAll]);
    if Offset = 1 then
      S := S + #10
    else if Offset = 2 then
      S := S + #13#10;
    Text.SelText := S;
    Text.EndUpdate;
    Text.CaretXY := backup;
  end
  else // no selection; easy stuff ;)
    Text.LineText := '//' + Text.LineText;
  Text.UpdateCaret;
  Text.Modified := True;
end;

{** Modified by Peter **}
procedure TEditor.IndentSelection;
begin
  if FText.SelAvail then
  begin
    FText.ExecuteCommand(ecBlockIndent, #0, nil);
  end;
end;

{** Modified by Peter **}
procedure TEditor.UnindentSelection;
begin
  if FText.SelAvail then
  begin
    FText.ExecuteCommand(ecBlockUnIndent, #0, nil);
  end;
end;

{** Modified by Peter **}
procedure TEditor.UncommentSelection;

  function FirstCharIndex(const S: string): Integer;
    //  Get the index of the first non whitespace character in
    //  the string specified by S
    //  On success it returns the index, otherwise it returns 0
  var
    I: Integer;
  begin
    Result := 0;

    if S <> '' then
      for I := 1 to Length(S) do
        if not (S[I] in [#0..#32]) then
        begin
          Result := I;
          Break;
        end;
  end;

var
  S: string;
  I: Integer;
  Idx: Integer;
  Strings: TStringList;
begin
  // has selection
  if Text.SelAvail then
  begin
    // start an undoblock, so we can undo
    // it afterwards!
    FText.BeginUndoBlock;

    Strings := TStringList.Create;
    try
      Strings.Text := FText.SelText;

      if Strings.Count > 0 then
      begin
        for I := 0 to Strings.Count - 1 do
        begin
          S := Strings.Strings[I];
          Idx := FirstCharIndex(S);

          // check if the very first two letters in the string are '//'
          // if they are, then delete them from the string and set the
          // modified string to the stringlist ...
          if (Length(S) > Idx) and (S[Idx] = '/') and (S[Idx + 1] = '/') then
          begin
            Delete(S, Idx, 2);
            Strings.Strings[I] := S;
          end;
        end;
      end;

      FText.SelText := Strings.Text;
    finally
      Strings.Free;
    end;

    FText.EndUndoBlock;
    FText.UpdateCaret;
    FText.Modified := True;
  end;
end;


procedure TEditor.EditorMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  procedure DoOpen(Fname: string; Line: integer; wrd: string);
  var
    e: TEditor;
    ws: integer;
  begin
    if fname = ExtractFileName(fname) then // no path info, so prepend path of active file
      fname := ExtractFilePath(fFileName) + fname;

    // refer to the editor of the filename (will open if needed and made active)
    e := MainForm.GetEditorFromFileName(fname);

    if Assigned(e) then begin
      // go to the specific line
      e.GotoLineNr(line);

      if wrd<>'' then begin
        // find the clicked word on this line and set the cursor on it ;)
        ws := AnsiPos(wrd, e.Text.LineText);
        if ws > 0 then
          e.Text.CaretX := ws;
      end;

      // remove any selection made by Synedit.OnMouseDown
      fText.BlockBegin := fText.CaretXY;
      fText.BlockEnd := fText.BlockBegin;
    end;
  end;
var
  p: TPoint;
  s, s1: string;
  I: integer;
//  umSt: PStatement;
  fname: string;
  line: integer;
  f1, f2: integer;
begin
  p.X := X;
  p.Y := Y;

  p.X := fText.PixelsToRowColumn(p.X, p.Y).Column;
  p.Y := fText.PixelsToRowColumn(p.X, p.Y).Row;
  s := fText.GetWordAtRowCol(BufferCoord(p.X, p.Y));

  // if ctrl+clicked
  if (ssCtrl in Shift) and (Button=mbLeft) then begin

    // reset the cursor
    fText.Cursor := crIBeam;

    // see if it's #include
    s1 := fText.Lines[p.Y - 1];
    s1 := StringReplace(s1, ' ', '', [rfReplaceAll]);
    if AnsiStartsStr('#include', s1) then begin
      // it is #include
      // check for #include <...>
      f1 := AnsiPos('<', s1);
      if f1>0 then begin
        Inc(f1);
        f2 := f1;
        while (f2 < Length(s1)) and (s1[f2] <> '>') do
          Inc(f2);
        if s1[f2] <> '>' then
          // not located...
          Abort;
        f2 := f2 - f1;
//        DoOpen(MainForm.CppParser1.GetFullFileName(Copy(s1, f1, f2)), 1, '');
        // the mousedown must *not* get to the SynEdit or else it repositions the caret!!!
        Abort;
      end;

      f1 := AnsiPos('"', s1);
      // since we reached here, we haven't found it yet
      // check for #include "..."
      if f1>0 then begin
        Inc(f1);
        f2 := f1;
        while (f2 < Length(s1)) and (s1[f2] <> '"') do
          Inc(f2);
        if s1[f2] <> '"' then
          // not located...
          Abort;
        f2 := f2 - f1;
//        DoOpen(MainForm.CppParser1.GetFullFileName(Copy(s1, f1, f2)), 1, '');
        // the mousedown must *not* get to the SynEdit or else it repositions the caret!!!
        Abort;
      end;

      // if we reached here, exit; we cannot locate and extract the filename...
      Exit;
    end; // #include


//    umSt := nil;
    // if there *is* a word under the mouse cursor
    if S<>'' then begin
      // search for statement
{      for I := 0 to MainForm.CppParser1.Statements.Count - 1 do
      if AnsiCompareStr(PStatement(MainForm.CppParser1.Statements[I])^._ScopelessCmd, S)=0 then begin
          umSt := PStatement(MainForm.CppParser1.Statements[I]);
          Break;
        end;}
    end;

    // if statement found
{    if Assigned(umSt) then begin
      // get the filename and the line number declared
      if umSt^._IsDeclaration then begin
        fname := umSt^._DeclImplFileName;
        line := umSt^._DeclImplLine;
      end
      else begin
        fname := umSt^._FileName;
        line := umSt^._Line;
      end;

      DoOpen(fname, line, s);

      // the mousedown must *not* get to the SynEdit or else it repositions the caret!!!
      Abort;
    end;}
  end;
end;

procedure TEditor.RunToCursor(Line: integer);
begin
  if fRunToCursorLine <> -1 then
    TurnOffBreakpoint(fRunToCursorLine);
  fRunToCursorLine := Line;
  TurnOnBreakpoint(fRunToCursorLine);
end;

procedure TEditor.PaintMatchingBrackets(TransientType: TTransientType);
const
  OpenChars: array[0..2] of Char = ('{', '[', '(');
  CloseChars: array[0..2] of Char = ('}', ']', ')');

  function CharToPixels(P: TBufferCoord): TPoint;
  begin
    Result:= fText.RowColumnToPixels(fText.BufferToDisplayPos(p));
  end;

  procedure SetColors(Editor: TSynEdit; virtualCoord: TBufferCoord; Attri: TSynHighlighterAttributes);
    function GetEditorBackgroundColor: TColor;
    var
      Attri: TSynHighlighterAttributes;
      PhysicalIndex: Integer;
    begin
      PhysicalIndex := Editor.RowColToCharIndex(virtualCoord);

      //Start by checking for selections
      if (PhysicalIndex >= Editor.SelStart) and (PhysicalIndex < Editor.SelEnd) then
        Result := Editor.SelectedColor.Background
      else if (Editor.ActiveLineColor <> clNone) and (Editor.CaretY = virtualCoord.Line) then
        Result := Editor.ActiveLineColor
      else
      begin
        Result := Editor.Color;
        if Editor.Highlighter <> nil then
        begin
          Attri := Editor.Highlighter.WhitespaceAttribute;
          if (Attri <> nil) and (Attri.Background <> clNone) then
            Result := Attri.Background;
        end;
      end;
    end;

    function GetEditorForegroundColor: TColor;
    var
      PhysicalIndex: Integer;
    begin
      PhysicalIndex := Editor.RowColToCharIndex(virtualCoord);

      //Start by checking for selections
      if (PhysicalIndex >= Editor.SelStart) and (PhysicalIndex < Editor.SelEnd) then
        Result := Editor.SelectedColor.Foreground
      else
        Result := Editor.Font.Color;
    end;
  var
    Special: Boolean;
    Foreground, Background: TColor;
  begin
    //Initialize the editor colors to defaults
    Foreground := GetEditorForegroundColor;
    Background := GetEditorBackgroundColor;

    Editor.OnSpecialLineColors(Self, virtualCoord.Line, Special, Foreground, Background);
    Editor.Canvas.Brush.Style := bsSolid;
    Editor.Canvas.Font.Assign(fText.Font);
    Editor.Canvas.Font.Style := Attri.Style;
    if TransientType = ttAfter then
      fText.Canvas.Font.Style := Editor.Canvas.Font.Style + [fsBold];

    Editor.Canvas.Brush.Color := Background;
    Editor.Canvas.Font.Color := Foreground;
  end;

var
  P: TBufferCoord;
  Pix: TPoint;
  S: String;
  I: Integer;
  Attri: TSynHighlighterAttributes;
begin
  P := fText.CaretXY;
  fText.GetHighlighterAttriAtRowCol(P, S, Attri);
  if Assigned(Attri) and (fText.Highlighter.SymbolAttribute = Attri) and
     (fText.CaretX <= length(fText.LineText) + 1) then
  begin
    for i := 0 to 2 do
    begin
      if (S = OpenChars[i]) or (S = CloseChars[i]) then
      begin
        //Draw the brackets
        SetColors(fText, P, Attri);
        Pix := CharToPixels(P);
        fText.Canvas.TextOut(Pix.X, Pix.Y, S);

        P := fText.GetMatchingBracketEx(P);
        if (P.Char > 0) and (P.Line > 0) then
        begin
          SetColors(fText, P, Attri);
          Pix := CharToPixels(P);
          if S = OpenChars[i] then
            fText.Canvas.TextOut(Pix.X, Pix.Y, CloseChars[i])
          else
            fText.Canvas.TextOut(Pix.X, Pix.Y, OpenChars[i]);
        end;
      end;
    end;
    fText.Canvas.Brush.Style := bsSolid;
  end;
end;

procedure TEditor.EditorPaintTransient(Sender: TObject; Canvas: TCanvas;
  TransientType: TTransientType);
begin
  if (not Assigned(fText.Highlighter)) or (devEditor.Match = false) then
    Exit;
  PaintMatchingBrackets(TransientType);
end;

procedure TEditor.FunctionArgsExecute(Kind: SynCompletionType; Sender: TObject;
  var AString: String; var x, y: Integer; var CanExecute: Boolean);
var
  TmpX, savepos, StartX, ParenCounter: Integer;
  locline, lookup: String;
  FoundMatch: Boolean;
  sl: TList;
begin
  sl := nil;
  try
    with TSynCompletionProposal(Sender).Editor do
    begin
      locLine := LineText;

      //go back from the cursor and find the first open paren
      TmpX := CaretX;
      if TmpX > length(locLine) then
        TmpX := length(locLine)
      else
        dec(TmpX);
      FoundMatch := False;

      while (TmpX > 0) and not (FoundMatch) do
      begin
        if LocLine[TmpX] = ',' then
          Dec(TmpX)
        else if LocLine[TmpX] = ')' then
        begin
          //We found a close, go till it's opening paren
          ParenCounter := 1;
          dec(TmpX);
          while (TmpX > 0) and (ParenCounter > 0) do begin
            if LocLine[TmpX] = ')' then
              inc(ParenCounter)
            else if LocLine[TmpX] = '(' then
              dec(ParenCounter);
            dec(TmpX);
          end;
          if TmpX > 0 then
            dec(TmpX); //eat the open paren
        end
        else if locLine[TmpX] = '(' then begin
          //we have a valid open paren, lets see what the word before it is
          StartX := TmpX;
          while (TmpX > 0) and not (locLine[TmpX] in TSynValidStringChars) do
            Dec(TmpX);
          if TmpX > 0 then begin
            SavePos := TmpX;
            while (TmpX > 0) and (locLine[TmpX] in TSynValidStringChars) do
              dec(TmpX);
            inc(TmpX);
            lookup := Copy(LocLine, TmpX, SavePos - TmpX + 1);
            if Assigned(fLastParamFunc) then begin
              if (fLastParamFunc.Count > 0) then
{                if (PStatement(fLastParamFunc.Items[0])^._Command = lookup) then // this avoid too much calls to CppParser.FillListOf
                  sl := fLastParamFunc;}
            end;
            if not Assigned(sl) then begin
              sl := TList.Create;
{              if MainForm.CppParser1.FillListOf(Lookup, False, sl) then begin  // and try to use only a minimum of FillListOf
                if Assigned(fLastParamFunc) then
                  FreeAndNil(fLastParamFunc);
                fLastParamFunc := sl;
              end
              else
                FreeAndNil(sl);}
            end;
            FoundMatch := Assigned(sl);
            if not(FoundMatch) then begin
              TmpX := StartX;
              dec(TmpX);
            end;
          end;
        end
        else
          dec(TmpX);
      end;
    end;

    CanExecute := FoundMatch;
  finally

  end;
end;

//this event is triggered whenever the codecompletion box is going to do the actual
//code completion
procedure TEditor.DoOnCodeCompletion(Sender: TObject; const AIndex: Integer);
//
//  this event is triggered whenever the codecompletion box is going to make its work,
//  or in other words, when it did a codecompletion ...
//
{$IFNDEF PRIVATE_BUILD}
var
    bUnIntialisedToolTip:Boolean;
begin
  // disable the tooltip here, becasue we check against Enabled
  // in the 'EditorStatusChange' event to prevent it's redrawing there
  if assigned(FCodeToolTip)then
  begin
    //TODO: specu: FCodeToolTip may not be initialized under some circumstances
    //             when creating TEditor. I suspect it's in TProject.OpenUnit
    //TODO: Guru: I'm checking if the tooltip is created; if it isn't, create a
    //            new one on the fly
    bUnIntialisedToolTip:=false;
    try
        FCodeToolTip.Enabled := False;
    except
        bUnIntialisedToolTip:=true;
    end;
    if bUnIntialisedToolTip then
    begin
        FCodeToolTip:=nil;
        FCodeToolTip := TDevCodeToolTip.Create(Application);
        FCodeToolTip.Editor := FText;
        FCodeToolTip.Parser := MainForm.CppParser1;
    end;
    FCodeToolTip.Enabled := False;
    FCodeToolTip.ReleaseHandle;
    FCodeToolTip.Show;
    FCodeToolTip.Select(AStatement._FullText);
    FCodeToolTip.Enabled := True;
    FCodeToolTip.Show;
  end;
{$ELSE}
begin
{  try
    Assert(CodeToolTip <> nil);
//    FCodeToolTip.Select(AStatement._FullText);
    CodeToolTip.Enabled := True;
    CodeToolTip.Show;
  except
//    ShowMessage(inttostr(integer(FCodeToolTip)) + '/' + inttostr(integer(@AStatement)));
    raise;
  end;}
{$ENDIF}

  //When we don't invalidate the SynEditor here, it occurs sometimes that
  //fragments of the codecompletion listbox are stuff displayed on the SynEdit
  fText.Invalidate;
end;

// Editor needs to be told when class browser has been recreated otherwise AV !
procedure TEditor.UpdateParser;
begin
//  FCodeToolTip.Parser := MainForm.CppParser1;
end;

procedure TEditor.InvalidateGutter;
begin
fText.InvalidateGutter;
end;

{$IFDEF WX_BUILD}
function TEditor.isForm: Boolean;
begin
  if fEditorType = etForm then
    Result := True
  else
    Result := false;
end;

procedure TEditor.ActivateDesigner;
begin                       
  if isForm then
  begin
    if Assigned(fDesigner) then
    begin
      MainForm.ELDesigner1.Active := False;
      try
        MainForm.ELDesigner1.DesignControl := fDesigner;
        MainForm.ELDesigner1.Active := True;
      except
      end;
      MainForm.BuildComponentList(fDesigner);
    end;
  end;
end;

procedure TEditor.UpdateDesignerData;
var
  e: TEditor;
  STartTimeX: longword;

  function GetElapsedTimeStr(StartTime : LongWord):String;
  begin
    Result := Format('%.3f seconds', [(GetTickCount - StartTime) / 1000]);
  end;
begin
  if isForm then
  begin
    StartTimeX := GetTickCount;
    Modified:=true;
    InsertDefaultText;

    if FileExists(ChangeFileExt(FileName, CPP_EXT)) then
    begin
      MainForm.OpenFile(ChangeFileExt(FileName, CPP_EXT), true);

      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, CPP_EXT));
      if Assigned(e) then
      begin
        e.Text.BeginUpdate;
        try
          GenerateCpp(fDesigner, fDesigner.Wx_Name, e.Text,e.FileName);
        except
        end;
        e.Text.EndUpdate;
        e.Modified:=true;
        e.InsertString('', false);
        MainForm.StatusBar.Panels[3].Text := ('C++ Source Generation: ' + GetElapsedTimeStr(StartTimeX));

      end;

    end;

    if FileExists(ChangeFileExt(FileName, H_EXT)) then
    begin
      StartTimeX := GetTickCount;
      MainForm.OpenFile(ChangeFileExt(FileName, H_EXT), true);
      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, H_EXT));
      if Assigned(e) then
      begin
        e.Text.BeginUpdate;
        try
          GenerateHpp(fDesigner, fDesigner.Wx_Name, e.Text);
        except
        end;
        e.Text.EndUpdate;
        e.Modified:=true;
        e.InsertString('', false);
        MainForm.StatusBar.Panels[3].Text := MainForm.StatusBar.Panels[3].Text + (' / Header Declaration Generation = ' + GetElapsedTimeStr(StartTimeX));
      end;
    end;
  end;
  if MainForm.ELDesigner1.GenerateXRC then
     UpdateXRC;
end;

function TEditor.GetDesigner: TfrmNewForm;
begin
  if isForm then
    Result := fDesigner
  else
    Result := nil;
end;

procedure TEditor.InitDesignerData(strFName, strCName, strFTitle: string;
  dlgSStyle: TWxDlgStyleSet);
begin
  fDesignerClassName := strCName;
  fDesignerTitle := strFTitle;
  fDesignerStyle := dlgSStyle;
  fDesignerDefaultData := True;
end;

function TEditor.GetDesignerHPPFileName: string;
begin
  if not isForm then
    Exit;

  if FileExists(ChangeFileExt(FileName, H_EXT)) then
    Result := ChangeFileExt(FileName, H_EXT);
end;

function TEditor.GetDesignerCPPFileName: string;
begin
  if not isForm then
    Exit;

  if FileExists(ChangeFileExt(FileName, CPP_EXT)) then
    Result := ChangeFileExt(FileName, CPP_EXT);
end;

function TEditor.GetDesignerHPPText: TSynEdit;
var
  e: TEditor;
begin
  Result := nil;
  if FileExists(ChangeFileExt(FileName, H_EXT)) then
  begin
    e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, H_EXT));

    if not Assigned(e) then
    begin
      MainForm.OpenFile(ChangeFileExt(FileName, H_EXT), true);
      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, H_EXT));
    end;

    if Assigned(e) then
    begin
      Result := e.Text;
    end;
  end;
end;

function TEditor.GetDesignerCPPText: TSynEdit;
var
  e: TEditor;
begin
  Result := nil;
  if FileExists(ChangeFileExt(FileName, CPP_EXT)) then
  begin
    e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, CPP_EXT));

    if not Assigned(e) then
    begin
      MainForm.OpenFile(ChangeFileExt(FileName, CPP_EXT), true);
      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, CPP_EXT));
    end;

    if Assigned(e) then
    begin
      Result := e.Text;
    end;
  end;
end;

function TEditor.IsDesignerHPPOpened: Boolean;
begin
    Result := MainForm.isFileOpenedinEditor(ChangeFileExt(FileName, H_EXT));
end;

function TEditor.IsDesignerCPPOpened: Boolean;
begin
    Result := MainForm.isFileOpenedinEditor(ChangeFileExt(FileName, CPP_EXT));
end;

function TEditor.GetDesignerHPPEditor: TEditor;
var
  e: TEditor;
begin
  Result := nil;
  if FileExists(ChangeFileExt(FileName, H_EXT)) then
  begin
    e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, H_EXT));

    if not Assigned(e) then
    begin
      MainForm.OpenFile(ChangeFileExt(FileName, H_EXT), true);
      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, H_EXT));
    end;
    if Assigned(e) then
    begin
      Result := e;
    end;
  end;
end;

function TEditor.GetDesignerCPPEditor: TEditor;
var
  e: TEditor;
begin
  Result := nil;
  if FileExists(ChangeFileExt(FileName, CPP_EXT)) then
  begin
    e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, CPP_EXT));

    if not Assigned(e) then
    begin
      MainForm.OpenFile(ChangeFileExt(FileName, CPP_EXT), true);
      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, CPP_EXT));
    end;

    if Assigned(e) then
    begin
      Result := e;
    end;
  end;
end;

procedure TEditor.ReloadForm;
begin
    ReloadFormFromFile(self.FileName);
end;

procedure TEditor.ReloadFormFromFile(strFilename:String);
var
  I:Integer;
begin
  if not self.isForm then
    exit;

  try
    //Delete all the Components
    for I := self.fDesigner.ComponentCount -1  downto 0 do    // Iterate
    begin
      self.fDesigner.Components[i].Destroy;
    end;    // for

    ReadComponentFromFile(self.fDesigner, strFilename);
  except
    on e: Exception do
      with TMigrateFrm.Create(Application.MainForm) do
      begin
        Source.Text := strFileName;
        if ShowModal = mrOK then
          ReloadFormFromFile(strFileName);
        
        Destroy;
      end;
  end;
end;

procedure TEditor.UpdateXRC;
var
  e: TEditor;

begin
  if isForm and MainForm.ELDesigner1.GenerateXRC then
  begin
    if FileExists(ChangeFileExt(FileName, XRC_EXT)) then
    begin
      MainForm.OpenFile(ChangeFileExt(FileName, XRC_EXT), true);
      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, XRC_EXT));

      if Assigned(e) then
      begin
        e.Text.BeginUpdate;
        try
          GenerateXRC(fDesigner, fDesigner.Wx_Name, e.Text,e.FileName);
        except
        end;
        e.Text.EndUpdate;
        e.Modified := True;
        e.InsertString('', false);
      end;
    end;
  end;
end;

function TEditor.GetCodeToolTip: TBaseCodeToolTip;
begin
  Result := fCompletionBox.Tooltip; 
end;

{$ENDIF}

end.

