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

unit EditorOptfrm;

interface

uses
  dbugintf,
{$IFDEF WIN32}
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  Dialogs, ComCtrls, devTabs, StdCtrls, ExtCtrls, Spin, ColorPickerButton,
  SciLexer, SciLexerMemo, SciLexerMod, sciPrint, sciAbbrevationManager, SciActions,
  SciActionsRes, sciAddLanguageFormUnit, SciAutoComplete, SciCallTips, SciConfirmReplaceDlg,
  SciControllerHandler, SciDetectUtils, SciDocuments, SciFileExtensionsManager, SciKeyBindings,
  SciKeyEditForm, SciLexerOptionsDlg, SciMacroRecording, ScintillaLanguageManager,
  SciPropertyMgr, SciReplaceTextDlg, SciResLang, SciResLangDcl, SciSearchReplace,
  SciSearchReplaceBase, SciSearchTextDlg, SciStreamDefault, SciStyleLoader, SciSupport,
  sciUtils, SciWhatToFillUnit, CheckLst,
  Buttons, ClassBrowser, CppParser, CppTokenizer, StrUtils, XPMenu, Classes;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, QGraphics, QControls, QForms,
  QDialogs, QComCtrls, devTabs, QStdCtrls, QExtCtrls, ColorPickerButton,
  QSynEdit, QSynEditHighlighter, QSynHighlighterCpp, QCheckLst, QSynMemo,
  QButtons, ClassBrowser, CppParser, CppTokenizer, StrUtils, Types;
{$ENDIF}

type
  TEditorOptForm = class(TForm)
    PagesMain: TPageControl;
    tabGeneral: TTabSheet;
    tabSyntax: TTabSheet;
    CppEdit: TScintilla;
    tabCode: TTabSheet;
    codepages: TPageControl;
    tabCPInserts: TTabSheet;
    tabCPDefault: TTabSheet;
    seDefault: TScintilla;
    btnAdd: TButton;
    btnEdit: TButton;
    btnRemove: TButton;
    lvCodeins: TListView;
    lblCode: TLabel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    btnHelp: TBitBtn;
    cboQuickColor: TComboBox;
    lblSpeed: TLabel;
    CodeIns: TScintilla;
    tabClassBrowsing: TTabSheet;
    chkEnableClassBrowser: TCheckBox;
    devPages1: TPageControl;
    tabCBBrowser: TTabSheet;
    tabCBCompletion: TTabSheet;
    lblClassBrowserSample: TLabel;
    ClassBrowser1: TClassBrowser;
    gbCBEngine: TGroupBox;
    chkCBParseGlobalH: TCheckBox;
    chkCBParseLocalH: TCheckBox;
    gbCBView: TGroupBox;
    lblCompletionDelay: TLabel;
    cpCompletionBackground: TColorPickerButton;
    lblCompletionColor: TLabel;
    chkEnableCompletion: TCheckBox;
    chkCBUseColors: TCheckBox;
    chkCCCache: TCheckBox;
    CppTokenizer1: TCppTokenizer;
    CppParser1: TCppParser;
    lbCCC: TListBox;
    lblCCCache: TLabel;
    pbCCCache: TProgressBar;
    XPMenu: TXPMenu;
    chkCBShowInherited: TCheckBox;
    lblEditorOpts: TGroupBox;
    cbAppendNewline: TCheckBox;
    cbSpecialChars: TCheckBox;
    cbDropFiles: TCheckBox;
    cbGroupUndo: TCheckBox;
    cbTrailingBlanks: TCheckBox;
    cbTabtoSpaces: TCheckBox;
    cbSmartTabs: TCheckBox;
    cbInsertMode: TCheckBox;
    cbPastEOL: TCheckBox;
    cbFindText: TCheckBox;
    cbHalfPage: TCheckBox;
    cbScrollHint: TCheckBox;
    cbParserHints: TCheckBox;
    cbSmartScroll: TCheckBox;
    cbDoubleLine: TCheckBox;
    cbEHomeKey: TCheckBox;
    cbPastEOF: TCheckBox;
    btnCCCnew: TButton;
    btnCCCdelete: TButton;
    btnSaveSyntax: TSpeedButton;
    edCompletionDelay: TSpinEdit;
    cbDefaultintoprj: TCheckBox;
    btnScintillaOptions: TSpeedButton;
    StaticText1: TStaticText;
    pLoadEdit: TSciPropertyLoader;
    ScintillaOptionsDlg1: TScintillaOptionsDlg;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
{$IFDEF SCINTILLA}
{$ELSE}
    procedure ElementListClick(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
{$ENDIF}
    procedure FontChange(Sender: TObject);
    procedure cpMarginColorHint(Sender: TObject; Cell: Integer;
      var Hint: String);
    procedure cpMarginColorDefaultSelect(Sender: TObject);
{$IFDEF SCINTILLA}
    procedure cppEditStatusChange(Sender: TObject{; Changes: TSynStatusChanges});
{$ELSE}
    procedure cppEditStatusChange(Sender: TObject; Changes: TSynStatusChanges);
{$ENDIF}
    procedure DefaultSelect(Sender: TObject);
    procedure PickerHint(Sender: TObject; Cell: integer; var Hint: string);
    procedure StyleChange(Sender: TObject);
    procedure cbLineNumClick(Sender: TObject);
    procedure cbSyntaxHighlightClick(Sender: TObject);
    procedure cbGutterFntClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure PagesMainChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lvCodeinsColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvCodeinsCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure lvCodeinsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
{$IFDEF SCINTILLA}
{$ELSE}
    procedure CodeInsStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
{$ENDIF}

    function FormHelp(Command: Word; Data: Integer;
      var CallHelp: Boolean): Boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboDblClick(Sender: TObject);
    procedure cboQuickColorSelect(Sender: TObject);
    procedure CppEditSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
    procedure chkEnableCompletionClick(Sender: TObject);
    procedure chkEnableClassBrowserClick(Sender: TObject);
    procedure btnSaveSyntaxClick(Sender: TObject);
    procedure chkCBUseColorsClick(Sender: TObject);
    procedure btnCCCnewClick(Sender: TObject);
    procedure btnCCCdeleteClick(Sender: TObject);
    procedure chkCCCacheClick(Sender: TObject);
    procedure CppParser1StartParsing(Sender: TObject);
    procedure CppParser1EndParsing(Sender: TObject);
    procedure CppParser1TotalProgress(Sender: TObject; FileName: String;
      Total, Current: Integer);
    procedure CppParser1CacheProgress(Sender: TObject; FileName: String;
      Total, Current: Integer);
    procedure devPages1Change(Sender: TObject);
    procedure chkCBShowInheritedClick(Sender: TObject);
{$IFDEF SCINTILLA}
{$ELSE}
    procedure OnGutterClick(Sender: TObject; Button: TMouseButton; X, Y,
      Line: Integer; Mark: TSynEditMark);
{$ENDIF}

    procedure cbHighCurrLineClick(Sender: TObject);
    procedure seTabSizeChange(Sender: TObject);
    procedure btnScintillaOptionsClick(Sender: TObject);
  private
    ffgColor: TColor;
    fbgColor: TColor;
    fUpdate: boolean;

    fGutColor: TPoint;
    fBPColor: TPoint;
    fErrColor: TPoint;
    fABPColor: TPoint;
    fSelColor: TPoint;
    HasProgressStarted: boolean;
    //fBMColor : TPoint;
    procedure LoadFontNames;
    procedure LoadFontSize;
    procedure LoadText;
    procedure LoadCodeIns;
    procedure LoadSampleText;
    procedure GetOptions;
    procedure CheckAssoc;
    procedure SaveCodeIns;
    procedure UpdateCIButtons;
    procedure SetGutter;
    procedure LoadSyntax(Value: string);
    procedure FillSyntaxSets;
    procedure FillCCC;
    function CompactFilename(filename: string): string;
  end;

var
  EditorOptForm: TEditorOptForm;
  function PathCompactPath(hDC: HDC; lpszPath: PChar; dx: UINT): Boolean; stdcall;
  external 'shlwapi.dll' name 'PathCompactPathA';

implementation

uses 
{$IFDEF WIN32}
  shlobj, MultiLangSupport, devcfg, version, utils, CodeIns, datamod,
  IniFiles, editor, main;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, MultiLangSupport, devcfg, version, utils, CodeIns, datamod, IniFiles, editor,
  main;
{$ENDIF}

{$R *.dfm}
const
  Help_Topic: array[0..5] of string =
  ('EditorOpt_General',
    'EditorOpt_Display',
    'EditorOpt_Syntax',
    'EditorOpt_Code',
    'EditorOpt_Complete',
    'EditorOpt_Browser');

  cBreakLine = 9;
  cABreakLine = 11;
  cErrorLine = 13;
  cSelection = 19;
var
  fUseDefaults: boolean; // use default array of font sizes
  fGutter: boolean; // user is editing gutter font

  { ---------- Form Events ---------- }

procedure TEditorOptForm.FormCreate(Sender: TObject);
var
{$IFDEF SCINTILLA}
  InitialStylesFile: String;
{$ENDIF}
begin
  LoadText;
  LoadCodeIns;
  LoadFontNames;
  LoadSampleText;
  PagesMainChange(Self);
  cbLineNumClick(Self);
  FillSyntaxSets;

{$IFDEF SCINTILLA}
  InitialStylesFile := devDirs.Styles + 'devcpp' + STYLES_EXT;
   pLoadEdit.FileName:=InitialStylesFile;

  pLoadEdit.Load;
  pLoadEdit.LoadStyles(InitialStylesFile);
{$ENDIF}
end;

procedure TEditorOptForm.FormShow(Sender: TObject);
begin
  PagesMain.ActivePageIndex := 0;
  CodePages.ActivePageIndex := 0;
end;

procedure TEditorOptForm.FormActivate(Sender: TObject);
begin
  GetOptions;
  UpdateCIButtons;
end;

function TEditorOptForm.FormHelp(Command: Word; Data: Integer;
  var CallHelp: Boolean): Boolean;
begin
  result := false;
  // another debug message
  showmessage('Hello from FormHelp');
end;

procedure TEditorOptForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{$IFDEF WIN32}
  if key = vk_F1 then
{$ENDIF}
{$IFDEF LINUX}
  if key = XK_F1 then
{$ENDIF}
    Application.HelpJump(HelpKeyword);
end;

{ ---------- Font Methods ---------- }

(*
  enum font families callback function
   adds a font to the list if it is of the Modern font family
   i.e. any font that is monospaced (same as delphi)
*)
function EnumFontFamilyProc(LogFont: PEnumLogFont; var TextMetric: PNewTextMetric;
  FontType: integer; LParam: integer): integer; stdcall;
begin
  if LogFont.elfLogFont.lfPitchAndFamily and FF_MODERN = FF_MODERN then
    TStrings(LParam).Add(LogFont.elfLogFont.lfFaceName);
  result := -1;
end;

// Fills combobox with font names.
// editor and gutter both use same fonts

procedure TEditorOptForm.LoadFontNames;
var
  DC: HDC;
begin
{$IFDEF SCINTILLA}
{$ELSE}
  DC := GetDC(0);
  EnumFontFamilies(DC, nil, @EnumFontFamilyProc, integer(cboEditorFont.Items));
  ReleaseDC(0, DC);
  cboEditorFont.Sorted := TRUE;
  cboGutterFont.Items := cboEditorFont.Items;
  cboGutterFont.Sorted := TRUE;
{$ENDIF}
end;

(*
  enum font families callback function for font sizes
  adds font sizes to list.  if font is not a RASTER then
  uses default font sizes (7..30)
*)

function EnumFontSizeProc(LogFont: PEnumLogFont; var TextMetric: PNewTextMetric;
  FontType: integer; LParam: integer): integer; stdcall;
var
  size: string;
begin
  result := 1;
  if FontType and RASTER_FONTTYPE = RASTER_FONTTYPE then
  begin
    Size := inttostr(LogFont.elfLogFont.lfHeight * 72 div LOGPIXELSY);
    if TStrings(LParam).IndexOf(Size) = -1 then
      TStrings(LParam).Add(Size);
  end
  else
  begin
    fUseDefaults := TRUE;
    result := 0;
  end;
end;

procedure TEditorOptForm.LoadFontSize;
var
  idx, idx2: integer;
  DC: HDC;
  Items: TStrings;
  FontName: string;
begin
{$IFDEF SCINTILLA}
{$ELSE}
  fUseDefaults := FALSE;
  DC := GetDC(0);
  Items := TStringList.Create;
  try
    if fGutter then
      FontName := cboGutterFont.Text
    else
      FontName := cboEditorFont.Text;

    EnumFontFamilies(DC, PChar(FontName), @EnumFontSizeProc, integer(Items));
    if fUseDefaults then
    begin
      Items.Clear;
      for idx:= 7 to 30 do Items.Append(inttostr(idx));
    end
    else // sort the returned sizes
      for idx := 1 to 3 do
        for idx2 := pred(Items.Count) downto 1 do
          if strtoint(Items[idx2]) < strtoint(Items[idx2 - 1]) then
            Items.Exchange(idx2, idx2 - 1);
    if fGutter then
    begin
      cboGutterSize.Clear;
      cboGutterSize.Items.AddStrings(Items);
    end
    else
    begin
      cboEditorSize.Clear;
      cboEditorSize.Items.AddStrings(Items);
    end;
  finally
    Items.Free;
    ReleaseDC(0, DC);
  end;
{$ENDIF}
end;

{$IFDEF SCINTILLA}
{$ELSE}
procedure TEditorOptForm.FontSizeChange(Sender: TObject);
  procedure UpdateSynEdits(ASynEdit: TSynEdit);
  begin
    if Sender = cboEditorSize then begin
      pnlEditorPreview.Font.Size := strtoint(cboEditorsize.Text);
      ASynEdit.Font.Size := strtoint(cboEditorSize.Text);
      ASynEdit.Refresh;
    end
    else
    begin
      pnlGutterPreview.Font.Size := strtoint(cboGutterSize.Text);
      CppEdit.Gutter.Font.Name := cboGutterFont.Text;
      ASynEdit.Gutter.Font.Size := strtoint(cboGutterSize.Text);
      ASynEdit.Gutter.Width := strtoint(edGutterWidth.Text);
      ASynEdit.Refresh;
    end;
  end;

begin
  try
    UpdateSynEdits(CppEdit);
    UpdateSynEdits(Self.seDefault);
    UpdateSynEdits(Self.CodeIns);
  except
    if Sender = cboEditorSize then begin
      cboEditorSize.Text := '10';
      pnlEditorPreview.Font.Size := 10;
      CppEdit.Font.Size := 10;
      CppEdit.Refresh;
    end
    else begin
      pnlGutterPreview.Font.Size := 10;
      cboGutterSize.Text := '10';
    end;
  end;
end;
{$ENDIF}

procedure TEditorOptForm.FontChange(Sender: TObject);
var
  Size: string;
begin
{$IFDEF SCINTILLA}
{$ELSE}
  fGutter := Sender = cboGutterFont;
  if fGutter then
  begin
    pnlGutterPreview.Font.Name := cboGutterFont.Text;
    CppEdit.Gutter.Font.Name := cboGutterFont.Text;
    Size := cboGutterSize.Text;
    LoadFontSize;
    cboGutterSize.Text := Size;

    CppEdit.Gutter.Font.Name := cboGutterFont.Text;
    CppEdit.Gutter.Font.Size := strtoint(cboGutterSize.Text);
    CppEdit.Gutter.Width := strtoint(edGutterWidth.Text);
    CppEdit.Refresh;
  end
  else
  begin
    pnlEditorPreview.Font.Name := cboEditorFont.Text;
    Size := cboEditorSize.Text;
    LoadFontSize;
    cboEditorSize.Text := Size;

    CppEdit.Font.Name := cboEditorFont.Text;
    CppEdit.Font.Size := strtoint(cboEditorSize.Text);
    CppEdit.Refresh;
  end;
{$ENDIF}
end;


procedure TEditorOptForm.cbGutterFntClick(Sender: TObject);
begin
{$IFDEF SCINTILLA}
{$ELSE}
  cboGutterFont.Enabled := cbGutterFnt.Checked;
  cboGutterSize.Enabled := cbGutterfnt.Checked;
{$ENDIF}
end;



{ ---------- Form Init/Done Methods ----------}

procedure TEditorOptForm.LoadText;
begin
  DesktopFont                   := True;
  XPMenu.Active                 := devData.XPTheme;
  btnOk.Caption                 := Lang[ID_BTN_OK];
  btnCancel.Caption             := Lang[ID_BTN_CANCEL];
  btnHelp.Caption               := Lang[ID_BTN_HELP];

  Caption                       := Lang[ID_EOPT];
  tabGeneral.Caption            := Lang[ID_EOPT_GENTAB];
{$IFDEF SCINTILLA}
{$ELSE}
  tabDisplay.Caption            := Lang[ID_EOPT_DISPLAYTAB];
{$ENDIF}
  tabSyntax.Caption             := Lang[ID_EOPT_SYNTAXTAB];
  tabCode.Caption               := Lang[ID_EOPT_CODETAB];
  tabClassBrowsing.Caption      := Lang[ID_EOPT_BROWSERTAB];
  tabCBBrowser.Caption          := Lang[ID_EOPT_BROWSERTAB];
  tabCBCompletion.Caption       := Lang[ID_EOPT_COMPLETIONTAB];

  // sub tabs
  tabCPInserts.Caption          := Lang[ID_EOPT_CPINSERTS];
  tabCPDefault.Caption          := Lang[ID_EOPT_CPDEFAULT];

  // General Tab
  lblEditorOpts.Caption         := Lang[ID_EOPT_EDOPTIONS];
  cbInsertMode.Caption          := Lang[ID_EOPT_INSERTMODE];
  cbTabtoSpaces.Caption         := Lang[ID_EOPT_TAB2SPC];
  cbSmartTabs.Caption           := Lang[ID_EOPT_SMARTTABS];
  cbTrailingBlanks.Caption      := Lang[ID_EOPT_TRAILBLANKS];
  cbGroupUndo.Caption           := Lang[ID_EOPT_GROUPUNDO];
  cbDropFiles.Caption           := Lang[ID_EOPT_DROPFILES];
  cbSpecialChars.Caption        := Lang[ID_EOPT_SPECIALCHARS];
  cbAppendNewline.Caption       := Lang[ID_EOPT_APPENDNEWLINE];
  cbEHomeKey.Caption            := Lang[ID_EOPT_EHOMEKEY];
  cbPastEOF.Caption             := Lang[ID_EOPT_PASTEOF];
  cbPastEOL.Caption             := Lang[ID_EOPT_PASTEOL];
  cbDoubleLine.Caption          := Lang[ID_EOPT_DBLCLKLINE];
  cbFindText.Caption            := Lang[ID_EOPT_FINDTEXT];
  cbSmartScroll.Caption         := Lang[ID_EOPT_SMARTSCROLL];
  cbHalfPage.Caption            := Lang[ID_EOPT_HALFPAGE];
  cbScrollHint.Caption          := Lang[ID_EOPT_SCROLLHINT];
  cbParserHints.Caption         := Lang[ID_EOPT_PARSERHINTS];

  // Syntax tab
  lblSpeed.Caption              := Lang[ID_EOPT_SPEED];
  btnSaveSyntax.Hint            := Lang[ID_EOPT_SAVESYNTAX];

  // Code Tab
  lblCode.Caption               := Lang[ID_EOPT_CICODE];
  lvCodeIns.Columns[0].Caption  := Lang[ID_EOPT_CIMENU];
  lvCodeIns.Columns[1].Caption  := Lang[ID_EOPT_CISECTION];
  lvCodeIns.Columns[2].Caption  := Lang[ID_EOPT_CIDESC];
  cbDefaultintoprj.Caption      := Lang[ID_EOPT_DEFCODEPRJ];

  // Completion Tab
  chkEnableCompletion.Caption   := Lang[ID_EOPT_COMPLETIONENABLE];
  lblCompletionDelay.Caption    := Lang[ID_EOPT_COMPLETIONDELAY];
  lblCompletionColor.Caption    := Lang[ID_EOPT_COMPLETIONCOLOR];

  // Class browsing Tab
  gbCBEngine.Caption            := Lang[ID_EOPT_BROWSERENGINE];
  gbCBView.Caption              := Lang[ID_EOPT_BROWSERVIEW];
  chkEnableClassBrowser.Caption := Lang[ID_EOPT_BROWSERENABLE];
  lblClassBrowserSample.Caption := Lang[ID_EOPT_BROWSERSAMPLE];
  chkCBParseLocalH.Caption      := Lang[ID_EOPT_BROWSERLOCAL];
  chkCBParseGlobalH.Caption     := Lang[ID_EOPT_BROWSERGLOBAL];
  chkCBUseColors.Caption        := Lang[ID_POP_USECOLORS];
  chkCCCache.Caption            := Lang[ID_EOPT_CCCACHECHECK];
  lblCCCache.Caption            := Lang[ID_EOPT_CCCACHELABEL];
  btnCCCnew.Caption             := Lang[ID_BTN_ADD];
  btnCCCdelete.Caption          := Lang[ID_BTN_CLEAR];

  btnAdd.Caption                := Lang[ID_BTN_ADD];
  btnEdit.Caption               := Lang[ID_BTN_EDIT];
  btnRemove.Caption             := Lang[ID_BTN_REMOVE];
end;

procedure TEditorOptForm.LoadSampleText;
begin
  with cppEdit.Lines do
  begin
    append('// Syntax Preview');
    append('#include <iostream>');
    append('#include <cstdio>');
    append('#include <conio.h>');
    append('');
    append('int main(int argc, char **argv)');
    append('{');
    append(#9'int numbers[20];');
    append(#9'float average, total; //breakpoint');
    append(#9'for (int i = 0; i <= 19; i++)');
    append(#9'{ // active breakpoint');
    append(#9#9'numbers[i] = i;');
    append(#9#9'Total += i; // error line');
    append(#9'}');
    append(#9'_asm {');
    append(#9#9'mov dword ptr [numbers], 3 ;This is a comment in Assembly');
    append(#9#9'push eax');
    append(#9#9'push ebx');
    append(#9#9'mov eax, 0');
    append(#9#9'mov ebx, 0');
    append(#9#9'call _main');
    append(#9'}');
    append(#9'average = total / 20;');
    append(#9'cout << numbers[0] << "\n" << numbers[19] << "\n";');
    append(#9'cout << "total: " << total << "\nAverage: " << average;');
    append(#9'printf("\n\nPress any key...");');
    append(#9'getch();');
    append('}');
  end;
end;

procedure TEditorOptForm.GetOptions;
var
  aName: string;
{$IFDEF SCINTILLA}
{$ELSE}
  attr: TSynHighlighterAttributes;
{$ENDIF}
  a,
    idx: integer;
begin
  with devEditor do
  begin
{$IFDEF SCINTILLA}
{$ELSE}
    cboEditorFont.ItemIndex := cboEditorFont.Items.IndexOf(Font.Name);
    cboEditorSize.Text := inttostr(Font.Size);
    FontSizeChange(cboEditorSize);
    FontChange(cboEditorFont);

    cbGutterFnt.Checked := Gutterfnt;
    cboGutterFont.ItemIndex := cboGutterFont.Items.IndexOf(Gutterfont.Name);
    cboGutterSize.Text := inttostr(GutterFont.Size);
    FontSizeChange(cboGutterSize);
    FontChange(cboGutterFont);

    cbGutterAuto.Checked := GutterAuto;
    cbGutterVis.Checked := GutterVis;
    edGutterWidth.Value := GutterSize;
    cbGutterGradient.Checked := GutterGradient;
    cbLineNum.Checked := LineNumbers;
    cbLeadZero.Checked := LeadZero;
    cbFirstZero.Checked := FirstLineZero;

{$ENDIF}
    cbInsertMode.Checked := InsertMode;
    cbTabtoSpaces.Checked := not TabToSpaces;
    cbSmartTabs.Checked := SmartTabs;
    cbTrailingBlanks.Checked := not TrailBlank;
    cbGroupUndo.Checked := GroupUndo;
    cbEHomeKey.Checked := EHomeKey;
    cbPastEOF.Checked := PastEOF;
    cbPastEOL.Checked := PastEOL;
    cbDoubleLine.Checked := DblClkLine;
    cbFindText.Checked := FindText;
    cbSmartScroll.Checked := Scrollbars;
    cbHalfPage.Checked := HalfPageScroll;
    cbScrollHint.Checked := ScrollHint;
    cbSpecialChars.Checked := SpecialChars;
    cbAppendNewline.Checked:= AppendNewline;

    cbDropFiles.Checked := InsDropFiles;

{$IFDEF SCINTILLA}

    //Language Manager
    cppEdit.LanguageManager.SelectedLanguage :='C++/C';

{$ELSE}
{$ENDIF}
    cbParserHints.Checked := ParserHints;
    cbDefaultintoprj.Checked := DefaulttoPrj;

    StrtoPoint(fGutColor, Syntax.Values[cGut]);
    StrtoPoint(fbpColor, Syntax.Values[cBP]);
    StrtoPoint(fErrColor, Syntax.Values[cErr]);
    StrtoPoint(fABPColor, Syntax.Values[cABP]);
    StrtoPoint(fSelColor, Syntax.Values[cSel]);
  end;

  CheckAssoc;


{$IFDEF SCINTILLA}
{$ELSE}
  for idx := 0 to pred(cpp.AttrCount) do
  begin
    aName := cpp.Attribute[idx].Name;
    a := devEditor.Syntax.IndexOfName(aName);
    if a <> -1 then
    begin
      Attr := TSynHighlighterAttributes.Create(aName);
      try
        StrtoAttr(Attr, devEditor.Syntax.Values[aName]);
        cpp.Attribute[idx].Assign(attr);
      finally
        Attr.Free;
      end;
    end
    else
      devEditor.Syntax.Append(aName);
  end;
  ElementList.Clear;
  for idx := 0 to pred(cpp.AttrCount) do
    ElementList.Items.Append(cpp.Attribute[idx].Name);

  // selection color
  if devEditor.Syntax.IndexofName(cSel) = -1 then
    devEditor.Syntax.Append(cSel);
  ElementList.Items.Append(cSel);

  // right margin

 // gutter colors
  if devEditor.Syntax.IndexofName(cGut) = -1 then
    devEditor.Syntax.Append(cGut);
  ElementList.Items.Append(cGut);

  // breakpoint
  if devEditor.Syntax.IndexOfName(cBP) = -1 then
    devEditor.Syntax.Append(cBP);
  ElementList.Items.Append(cBP);

  // error line
  if devEditor.Syntax.IndexOfName(cErr) = -1 then
    devEditor.Syntax.Append(cErr);
  ElementList.Items.Append(cErr);

  // active breakpoint
  if devEditor.Syntax.IndexOfName(cABP) = -1 then
    devEditor.Syntax.Append(cABP);
  ElementList.Items.Append(cABP);

  ffgColor := cpp.WhitespaceAttribute.Foreground;
  fbgColor := cpp.WhitespaceAttribute.Background;

  if ElementList.Items.Count > 0 then
  begin
    ElementList.ItemIndex := 0;
    ElementListClick(nil);
  end;

  // init gutter colors
  SetGutter;
  if FileExists(devDirs.Config + DEV_DEFAULTCODE_FILE) then
    seDefault.Lines.LoadFromFile(devDirs.Config + DEV_DEFAULTCODE_FILE);
{$ENDIF}
  // CODE_COMPLETION //
  chkEnableCompletion.OnClick := nil;
  chkEnableCompletion.Checked := devCodeCompletion.Enabled;
  chkEnableCompletion.OnClick := chkEnableCompletionClick;
  edCompletionDelay.Value := devCodeCompletion.Delay;
  cpCompletionBackground.SelectionColor := devCodeCompletion.BackColor;
  edCompletionDelay.Enabled := chkEnableCompletion.Checked;
  cpCompletionBackground.Enabled := chkEnableCompletion.Checked;
  chkCCCache.Checked := devCodeCompletion.UseCacheFiles;
  chkCCCache.Tag := 0; // mark un-modified
  chkCCCache.Enabled := chkEnableCompletion.Checked;
  lbCCC.Enabled := chkCCCache.Checked and chkEnableCompletion.Checked;
  btnCCCnew.Enabled := chkCCCache.Checked and chkEnableCompletion.Checked;
  btnCCCdelete.Enabled := chkCCCache.Checked and chkEnableCompletion.Checked;

  // CLASS_BROWSING //
  chkEnableClassBrowser.Checked := devClassBrowsing.Enabled;
  ClassBrowser1.Enabled := chkEnableClassBrowser.Checked;
  ClassBrowser1.UseColors := devClassBrowsing.UseColors;
  ClassBrowser1.ShowInheritedMembers := devClassBrowsing.ShowInheritedMembers;
  ClassBrowser1.ShowSampleData;
  chkCBParseLocalH.Checked := devClassBrowsing.ParseLocalHeaders;
  chkCBParseGlobalH.Checked := devClassBrowsing.ParseGlobalHeaders;
  chkCBParseLocalH.Enabled := chkEnableClassBrowser.Checked;
  chkCBParseGlobalH.Enabled := chkEnableClassBrowser.Checked;
  chkCBUseColors.Checked := devClassBrowsing.UseColors;
  chkCBShowInherited.Checked := devClassBrowsing.ShowInheritedMembers;
  chkCBUseColors.Enabled := chkEnableClassBrowser.Checked;
  chkEnableCompletion.Enabled := chkEnableClassBrowser.Checked;
  edCompletionDelay.Enabled := chkEnableClassBrowser.Checked;
  cpCompletionBackground.Enabled := chkEnableClassBrowser.Checked;
end;

//check file associations

procedure TEditorOptForm.CheckAssoc;
begin
end;

procedure TEditorOptForm.btnOkClick(Sender: TObject);
var
{$IFDEF SCINTILLA}
  InitialStylesFile: String;
  Attrs: integer;
{$ENDIF}
  s, aName: string;
  a, idx: integer;
  e: TEditor;
begin
  with devEditor do
  begin
{$IFDEF SCINTILLA}
{$ELSE}

    AutoIndent := cbAutoIndent.Checked;
    InsertMode := cbInsertMode.Checked;
    TabToSpaces := not cbTabtoSpaces.Checked;
    SmartTabs := cbSmartTabs.Checked;
    SmartUnindent := cbSmartUnindent.Checked;
    TrailBlank := not cbTrailingBlanks.Checked;
    GroupUndo := cbGroupUndo.Checked;
    EHomeKey := cbEHomeKey.Checked;
    PastEOF := cbPastEOF.Checked;
    PastEOL := cbPastEOL.Checked;
    DblClkLine := cbDoubleLine.Checked;
    FindText := cbFindText.Checked;
    Scrollbars := cbSmartScroll.Checked;
    HalfPageScroll := cbHalfPage.Checked;
    ScrollHint := cbScrollHint.Checked;
    SpecialChars := cbSpecialChars.Checked;
    AppendNewline:= cbAppendNewline.Checked;

    MarginVis := cbMarginVis.Checked;
    MarginSize := edMarginWidth.Value;
    MarginColor := cpMarginColor.SelectionColor;
    InsertCaret := cboInsertCaret.ItemIndex;
    OverwriteCaret := cboOverwriteCaret.ItemIndex;
    Match := cbMatch.Checked;

    HighCurrLine := cbHighCurrLine.Checked;
    HighColor := cpHighColor.SelectionColor;

    UseSyntax := cbSyntaxHighlight.Checked;
    SyntaxExt := edSyntaxExt.Text;
    TabSize := seTabSize.Value;

    Font.Name := cboEditorFont.Text;
    Font.Size := strtoint(cboEditorSize.Text);

    Gutterfont.Name := cboGutterFont.Text;
    GutterFont.Size := strtoint(cboGutterSize.Text);

    Gutterfnt := cbGutterFnt.Checked;
    GutterAuto := cbGutterAuto.Checked;
    GutterGradient := cbGutterGradient.Checked;
    GutterVis := cbGutterVis.Checked;
    GutterSize := edGutterWidth.Value;
    LineNumbers := cbLineNum.Checked;
    LeadZero := cbLeadZero.Checked;
    FirstLineZero := cbFirstZero.Checked;

{$ENDIF}
    InsDropFiles := cbDropFiles.Checked;
    ParserHints := cbParserHints.Checked;

{$IFDEF SCINTILLA}
    // load in attributes
  InitialStylesFile := devDirs.Styles + 'devcpp' + STYLES_EXT;

    if FileIsReadOnly(InitialStylesFile)then //we are going to delete the file so remove read only if there
    begin
      Attrs := FileGetAttr(InitialStylesFile);
      FileSetAttr(InitialStylesFile, Attrs - faReadOnly);
    end;
    pLoadEdit.Save;
//    pLoadEdit.SaveStyles(InitialStylesFile);
{$ELSE}
    for idx := 0 to pred(cpp.AttrCount) do
    begin
      aName := cpp.Attribute[idx].Name;
      a := Syntax.IndexOfName(aName);
      if a = -1 then
        Syntax.Append(format('%s=%s',
          [aName, AttrtoStr(cpp.Attribute[idx])]))
      else
        Syntax.Values[aName] := AttrtoStr(cpp.Attribute[idx]);
    end;
    // additional attributes
{$ENDIF}

    //gutter
    if fgutColor.x = clNone then
      fgutColor.x := clBlack;
    if fgutColor.y = clNone then
      fgutColor.Y := clBtnFace;

    s := PointtoStr(fgutColor);
    a := Syntax.IndexofName(cGut);
    if a = -1 then
      Syntax.Append(format('%s=%s', [cGut, s]))
    else
      Syntax.Values[cGut] := s;

    // selected text
    s := PointtoStr(fSelColor);
    a := Syntax.IndexofName(cSel);
    if a = -1 then
      Syntax.Append(format('%s=%s', [cSel, s]))
    else
      Syntax.Values[cSel] := s;

    // breakpoints
    s := PointtoStr(fbpColor);
    a := Syntax.IndexofName(cBP);
    if a = -1 then
      Syntax.Append(format('%s=%s', [cBP, s]))
    else
      Syntax.Values[cBP] := s;

    // active breakpoint
    s := PointtoStr(fAbpColor);
    a := Syntax.IndexofName(cABP);
    if a = -1 then
      Syntax.Append(format('%s=%s', [cABP, s]))
    else
      Syntax.Values[cABP] := s;

    // error line
    s := PointtoStr(fErrColor);
    a := Syntax.IndexofName(cErr);
    if a = -1 then
      Syntax.Append(format('%s=%s', [cErr, s]))
    else
      Syntax.Values[cErr] := s;

    // Insert default code in Empty project files
    DefaulttoPrj := cbDefaultintoprj.Checked;
  end;

  seDefault.Lines.SavetoFile(devDirs.Config + DEV_DEFAULTCODE_FILE);

  SaveCodeIns;

  // CODE_COMPLETION //
  devCodeCompletion.Enabled := chkEnableCompletion.Checked;
  devCodeCompletion.Delay := edCompletionDelay.Value;
  devCodeCompletion.BackColor := cpCompletionBackground.SelectionColor;
  devCodeCompletion.UseCacheFiles := chkCCCache.Checked;
  if chkCCCache.Tag = 1 then
    CppParser1.Save(devDirs.Config + DEV_COMPLETION_CACHE);

  // CLASS_BROWSING //
  devClassBrowsing.Enabled := chkEnableClassBrowser.Checked;
  devClassBrowsing.ParseLocalHeaders := chkCBParseLocalH.Checked;
  devClassBrowsing.ParseGlobalHeaders := chkCBParseGlobalH.Checked;
  devClassBrowsing.UseColors := chkCBUseColors.Checked;
  devClassBrowsing.ShowInheritedMembers := chkCBShowInherited.Checked;

  SaveOptions;
  dmMain.LoadDataMod;
  if not devEditor.Match then begin
    e := MainForm.GetEditor;
{$IFDEF SCINTILLA}
{$ELSE}
    if assigned(e) then
      e.PaintMatchingBrackets(ttBefore);
{$ENDIF}
  end;

  e := MainForm.GetEditor;
  if Assigned(e) then
{$IFDEF SCINTILLA}
{
    if cbHighCurrLine.Checked then
      e.Text.Caret.LineBackColor := cpHighColor.SelectionColor
    else
        e.Text.Caret.LineBackColor := clNone;
}
{$ELSE}
    if cbHighCurrLine.Checked then
      e.Text.ActiveLineColor := cpHighColor.SelectionColor
    else
      e.Text.ActiveLineColor := clNone;
{$ENDIF}
end;

procedure TEditorOptForm.btnHelpClick(Sender: TObject);
begin
  HelpFile := devDirs.Help + DEV_MAINHELP_FILE;
  // ** temporary removal ** Application.HelpJump(HelpKeyword);
  Application.HelpJump('ID_EDITORSETTINGS');
end;

procedure TEditorOptForm.PagesMainChange(Sender: TObject);
begin
  HelpKeyword := Help_Topic[PagesMain.ActivePageIndex];
end;

procedure TEditorOptForm.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TEditorOptForm.cboDblClick(Sender: TObject);
var
  idx: integer;
begin
  with Sender as TComboBox do
  begin
    idx := ItemIndex + 1;
     if idx>= Items.Count then idx:= 0;
    ItemIndex := idx;
  end;
{$IFDEF SCINTILLA}
{$ELSE}
  if (Sender = cboGutterFont) or (Sender = cboEditorFont) then
    FontChange(Sender)
  else
   if (Sender =  cboEditorSize) or (Sender = cboGutterSize) then
    FontSizeChange(Sender);
{$ENDIF}
end;

{ ---------- Syntax Style Methods ---------- }

procedure TEditorOptForm.SetGutter;
begin
  // if gutter background = clnone set to button face
  if fgutcolor.x = clnone then
    fgutcolor.x := clBtnFace;

  // if gutter foreground = clnone set to black
  if fgutcolor.y = clnone then
    fgutcolor.y := clBlack;

  // update preview
{$IFDEF SCINTILLA}
{$ELSE}
  cppedit.Gutter.Color := fgutColor.x;
  cppedit.Gutter.Font.Color := fgutColor.y;
{$ENDIF}
end;

{$IFDEF SCINTILLA}
{$ELSE}
procedure TEditorOptForm.ElementListClick(Sender: TObject);
var
  pt: TPoint;
begin
  if ElementList.ItemIndex > pred(cpp.AttrCount) then
  begin
    fUpdate := FALSE;
    if AnsiCompareText(ElementList.Items[ElementList.ItemIndex], cSel) = 0 then
      pt := fSelColor
     else
     if AnsiCompareText(ElementList.Items[ElementList.ItemIndex], cBP) = 0 then
      pt := fBPColor
     else
     if AnsiCompareText(ElementList.Items[ElementList.ItemIndex], cErr) = 0 then
      pt := fErrColor
     else
     if AnsiCompareText(ElementList.Items[ElementList.ItemIndex], cABP) = 0 then
      pt := fABPColor
     else
     if AnsiCompareText(ElementList.Items[ElementList.ItemIndex], cGut) = 0 then
      pt := fGutColor;

    cpBackground.SelectionColor := pt.x;
    cpForeground.SelectionColor := pt.y;

     cbBold.Checked:= False;
     cbItalic.Checked:= False;
     cbUnderlined.Checked:= False;

     cbBold.Enabled := False;
     cbItalic.Enabled:= False;
     cbUnderlined.Enabled:= False;

    fUpdate := TRUE;
  end
  else if ElementList.ItemIndex > -1 then
    with Cpp.Attribute[ElementList.ItemIndex] do
    begin
      fUpdate := FALSE;
      if Foreground = clNone then
        cpForeground.SelectionColor := clWindowText //clNone
      else
        cpForeground.SelectionColor := Foreground;
      if Background = clNone then
        cpBackground.SelectionColor := clWindow //clNone
      else
        cpBackground.SelectionColor := Background;

      cbBold.Enabled := True;
      cbItalic.Enabled:= True;
      cbUnderlined.Enabled:= True;

      cbBold.Checked := fsBold in Style;
      cbItalic.Checked := fsItalic in Style;
      cbUnderlined.Checked := fsUnderline in Style;
      fUpdate := TRUE;
    end;
end;
{$ENDIF}

procedure TEditorOptForm.DefaultSelect(Sender: TObject);
begin
  with (Sender as TColorPickerButton) do
    SelectionColor := clNone;
end;

procedure TEditorOptForm.PickerHint(Sender: TObject; Cell: integer; var Hint: string);
begin
  if Cell = DEFAULTCELL then
   Hint:= Lang[ID_EOPT_HINTWHITESPACE];
end;

procedure TEditorOptForm.StyleChange(Sender: TObject);
var
{$IFDEF SCINTILLA}
{$ELSE}
  attr: TSynHighlighterAttributes;
{$ENDIF}
  s: string;
  pt: TPoint;
begin
{$IFDEF SCINTILLA}
{$ELSE}
  if (not fUpdate) or (ElementList.ItemIndex < 0) then
    Exit;

  if ElementList.ItemIndex > pred(cpp.AttrCount) then
  begin
    pt.x := cpBackground.SelectionColor;
    pt.y := cpForeground.SelectionColor;
    // check for gutter before changing default colors
    if AnsiCompareText(ElementList.Items[ElementList.ItemIndex], cGut) = 0 then
    begin
      fGutColor := pt;
      SetGutter;
    end
    else
    begin
      // use local string just to ease readability
      s := ElementList.Items[ElementList.ItemIndex];

      // if either value is clnone set to Whitespace color values
      if pt.x = clNone then
        pt.x:= fbgColor;
      if pt.y = clNone then
        pt.y:= ffgColor;

      if AnsiCompareText(s, cSel) = 0 then
        fSelColor := pt
      else if AnsiCompareText(s, cBP) = 0 then
        fBPColor := pt
      else if AnsiCompareText(s, cABP) = 0 then
        fABPColor := pt
      else if AnsiCompareText(s, cerr) = 0 then
        fErrColor := pt;
    end
  end
  else
  begin
    Attr := TSynHighlighterAttributes.Create(ElementList.Items[ElementList.ItemIndex]);
    Attr.Assign(cpp.Attribute[ElementList.ItemIndex]);
    with Attr do
    try
      Foreground := cpForeground.SelectionColor;
      if Sender = cpBackground then
        Background := cpBackground.SelectionColor;
      if AnsiCompareText(Name, 'WhiteSpace') = 0 then
      begin
        ffgColor := Foreground;
        fbgColor := Background;
      end;

      Style := [];
      if cbBold.checked then
        Style:= Style + [fsBold];
      if cbItalic.Checked then
        Style:= Style +[fsItalic];
      if cbUnderlined.Checked then
        Style:= Style +[fsUnderline];
      cpp.Attribute[ElementList.ItemIndex].Assign(Attr);
    finally
      Free;
    end;
  end;

  // invalidate special lines
  cppEdit.InvalidateLine(cSelection);
  cppEdit.InvalidateLine(cBreakLine);
  cppEdit.InvalidateLine(cABreakLine);
  cppEdit.InvalidateLine(cErrorLine);
  cppEdit.Highlighter := cpp;
  cboQuickColor.ItemIndex := -1;
{$ENDIF}
end;


{$IFDEF SCINTILLA}
procedure TEditorOptForm.cppEditStatusChange(Sender: TObject);
{$ELSE}
procedure TEditorOptForm.cppEditStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
{$ENDIF}
var
  Token: string;
{$IFDEF SCINTILLA}
{$ELSE}
  attr: TSynHighlighterAttributes;
{$ENDIF}
begin
{$IFDEF SCINTILLA}
{$ELSE}


  if assigned(cppEdit.Highlighter) and
    (Changes * [scAll, scCaretX, scCaretY] <> []) then
    case cppEdit.CaretY of
      cSelection:
        begin
          ElementList.ItemIndex := ElementList.Items.Indexof(cSel);
          ElementListClick(Self);
        end;
      cBreakLine:
        begin
          ElementList.ItemIndex := ElementList.Items.Indexof(cBP);
          ElementListClick(Self);
        end;
      cABreakLine:
        begin
          ElementList.ItemIndex := ElementList.Items.Indexof(cABP);
          ElementListClick(Self);
        end;
      cErrorLine:
        begin
          ElementList.ItemIndex := ElementList.Items.Indexof(cErr);
          ElementListClick(Self);
        end;
    else
      begin
       if not cppEdit.GetHighlighterAttriAtRowCol(cppEdit.CaretXY, Token, Attr) then
          Attr := cppEdit.Highlighter.WhiteSpaceAttribute;
        if assigned(Attr) then
        begin
          ElementList.ItemIndex := ElementList.Items.Indexof(Attr.Name);
          ElementListClick(Self);
        end;
      end;
    end;
{$ENDIF}
end;

procedure TEditorOptForm.CppEditSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
begin
  case Line of
    cSelection:
      begin
        if fSelColor.x <> clNone then
          BG := fSelColor.x;
        if fSelColor.y <> clNone then
          FG := fSelColor.y;
        Special := TRUE;
      end;
    cBreakLine:
      begin
        if fBPColor.x <> clNone then
          BG := fBPColor.x;
        if fBPColor.y <> clNone then
          FG := fBPColor.y;
        Special := TRUE;
      end;
    cABreakLine:
      begin
        if fABPColor.x <> clNone then
          BG := fABPColor.X;
        if fABPColor.y <> clNone then
          FG := fABPColor.y;
        Special := TRUE;
      end;
    cErrorLine:
      begin
        if fErrColor.x <> clNone then
          BG := fErrColor.x;
        if fErrColor.y <> clNone then
          FG := fErrColor.y;
        Special := TRUE;
      end;
  end;
end;

procedure TEditorOptForm.cpMarginColorHint(Sender: TObject; Cell: Integer;
  var Hint: String);
begin
  if Cell = DEFAULTCELL then
   Hint:= Lang[ID_EOPT_HINTHIGHLIGHT];
end;

procedure TEditorOptForm.cpMarginColorDefaultSelect(Sender: TObject);
begin
{$IFDEF SCINTILLA}
{$ELSE}
  cpMarginColor.SelectionColor := clHighlightText;

{$ENDIF}
end;

procedure TEditorOptForm.cbLineNumClick(Sender: TObject);
begin
{$IFDEF SCINTILLA}
{$ELSE}

  cbLeadZero.Enabled := cbLineNum.Checked;
  cbFirstZero.Enabled := cbLineNum.Checked;
{$ENDIF}
end;

procedure TEditorOptForm.cbSyntaxHighlightClick(Sender: TObject);
begin
{$IFDEF SCINTILLA}
{$ELSE}
  edSyntaxExt.Enabled := cbSyntaxHighlight.Checked;
{$ENDIF}
end;

procedure TEditorOptForm.cboQuickColorSelect(Sender: TObject);
var
{$IFDEF SCINTILLA}
  StylesFile: String;
{$ELSE}
  offset: integer;
  i: integer;
  attr: TSynHighlighterAttributes;
{$ENDIF}
begin
{$IFDEF SCINTILLA}
  StylesFile := devDirs.Styles + cboQuickColor.Items[cboQuickColor.ItemIndex] + STYLES_EXT;
  if not FileExists(StylesFile)        //has the user deleted the styles file?
  then
      MessageDlg('Style file does not exist...', mtError, [mbOk], 0)  //UpdateOutputStyles;
  else
    if not (pLoadEdit.LoadStyles(StylesFile)) then
      MessageDlg('Cannot load style file...', mtError, [mbOk], 0);//UpdateOutputStyles;
{$ELSE}
  if cboQuickColor.ItemIndex > 5 then begin
    // custom style; load from disk
    LoadSyntax(cboQuickColor.Items[cboQuickColor.ItemIndex]);
    Exit;
  end;

  offset := cboQuickColor.ItemIndex * 1000;
  for i := 0 to pred(cpp.AttrCount) do
  begin
    attr := TSynHighlighterAttributes.Create(cpp.Attribute[i].Name);
    try
      StrtoAttr(Attr, LoadStr(i + offset + 1));
      cpp.Attribute[i].Assign(Attr);
    finally
      Attr.Free;
    end;
  end;

  StrtoPoint(fBPColor, LoadStr(offset + 17)); // breakpoints
  StrtoPoint(fErrColor, LoadStr(offset + 18)); // error line
  StrtoPoint(fABPColor, LoadStr(offset + 19)); // active breakpoint
  StrtoPoint(fgutColor, LoadStr(offset + 20)); // gutter
  StrtoPoint(fSelColor, LoadStr(offset + 21)); // selected text

  cppEdit.InvalidateLine(cSelection);
  cppEdit.InvalidateLine(cBreakLine);
  cppEdit.InvalidateLine(cABreakLine);
  cppEdit.InvalidateLine(cErrorLine);

  //update gutter
  setgutter;
{$ENDIF}
end;

{ ---------- Code insert's methods ---------- }

procedure TEditorOptForm.btnAddClick(Sender: TObject);
var
  NewItem: PCodeIns;
  Item: TListItem;
begin
  with TfrmCodeEdit.Create(Self) do
  try
    CodeIns.ClearAll;
    Edit := FALSE;
    New(NewItem);
    NewItem^.Sep := 0;
    Entry := NewItem;
    if ShowModal = mrOk then
    begin
      Item := lvCodeIns.Items.Add;
      Item.Caption := edMenuText.Text;
      Item.SubItems.Add(inttostr(seSection.Value));
      Item.SubItems.Add(edDesc.Text);
      Item.SubItems.Add('');
      lvCodeIns.Selected := Item;
    end
    else
      dispose(NewItem);
  finally
    Free;
    UpdateCIButtons;
  end;
end;

procedure TEditorOptForm.btnEditClick(Sender: TObject);
begin
  with TfrmCodeEdit.Create(Self) do
  try
    Edit := TRUE;
    edMenuText.Text := lvCodeIns.Selected.Caption;
    seSection.Value := strtoint(lvCodeIns.Selected.SubItems[0]);
    edDesc.Text := lvCodeIns.Selected.SubItems[1];
    if ShowModal = mrOk then
    begin
      lvCodeIns.Selected.Caption := edMenuText.Text;
      lvCodeIns.Selected.SubItems[0] := inttostr(seSection.Value);
      lvCodeIns.Selected.SubItems[1] := edDesc.Text;
    end;
  finally
    Free;
    UpdateCIButtons;
  end;
end;

procedure TEditorOptForm.btnRemoveClick(Sender: TObject);
begin
  dmMain.CodeInserts.Delete(lvCodeIns.Selected.Index);
  lvCodeIns.Selected.Delete;
  CodeIns.ClearAll;
  UpdateCIButtons;
end;

procedure TEditorOptForm.UpdateCIButtons;
begin
  btnAdd.Enabled := TRUE;
  btnEdit.Enabled := assigned(lvCodeIns.Selected);
  btnRemove.Enabled := assigned(lvCodeIns.Selected);
end;

procedure TEditorOptForm.lvCodeinsColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  lvCodeIns.AlphaSort;
end;

procedure TEditorOptForm.lvCodeinsCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  i1, i2: integer;
begin
  i1 := strtoint(Item1.SubItems[0]);
  i2 := strtoint(Item2.SubItems[0]);
  if i1 > i2 then
    Compare := 1
  else
   if i1 = i2 then
    Compare := 0
  else
    Compare := -1;
end;

procedure TEditorOptForm.lvCodeinsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  Codeins.ClearAll;
{$IFDEF SCINTILLA}
  CodeIns.Lines.Text := StrtoCodeIns(Item.SubItems[2]);
{$ELSE}
  CodeIns.Text := StrtoCodeIns(Item.SubItems[2]);
{$ENDIF}
  UpdateCIButtons;
end;

{$IFDEF SCINTILLA}
{$ELSE}
procedure TEditorOptForm.CodeInsStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if assigned(lvCodeIns.Selected) then
    if (Changes * [scModified] <> []) then
    begin
      lvCodeIns.Selected.SubItems[2] := CodeInstoStr(CodeIns.Text);
      CodeIns.Modified := false;
    end;
end;
{$ENDIF}

procedure TEditorOptForm.LoadCodeIns;
var
  idx: integer;
  Item: TListItem;
  Ins: PCodeIns;
begin
  for idx := 0 to pred(dmMain.CodeInserts.Count) do
  begin
    Item := lvCodeIns.Items.Add;
    ins := dmMain.CodeInserts[idx];
    Item.Caption := ins.Caption;
    Item.SubItems.Add(inttostr(ins.Sep));
    Item.SubItems.Add(ins.Desc);
    Item.SubItems.Add(ins.Line);
  end;
  if lvCodeIns.Items.Count > 0 then
    lvCodeIns.ItemIndex := 0;
end;

procedure TEditorOptForm.SaveCodeIns;
var
  idx: integer;
  Item: PCodeIns;
begin
  lvCodeIns.AlphaSort;
  for idx := 0 to dmMain.CodeInserts.Count - 1 do
    Dispose(dmMain.CodeInserts.Items[idx]);
  dmMain.CodeInserts.Clear;
  for idx := 0 to pred(lvCodeIns.Items.Count) do
  begin
    new(Item);
    Item.Caption := lvCodeIns.Items[idx].Caption;
    Item.Sep := strtoint(lvCodeIns.Items[idx].SubItems[0]);
    Item.Desc := lvcodeIns.Items[idx].SubItems[1];
    Item.Line := lvCodeIns.Items[idx].SubItems[2];
    dmMain.CodeInserts.AddItem(Item);
  end;
  dmMain.Codeinserts.SaveCode;
end;

procedure TEditorOptForm.chkEnableCompletionClick(Sender: TObject);
begin
  with chkEnableCompletion do
  begin
    edCompletionDelay.Enabled := Checked;
    cpCompletionBackground.Enabled := Checked;
    chkCCCache.Checked := chkCCCache.Checked and Checked;
    chkCCCache.Enabled := Checked;
    chkCCCacheClick(Self);
  end;
end;

procedure TEditorOptForm.chkEnableClassBrowserClick(Sender: TObject);
begin
  // browser
  ClassBrowser1.Enabled := chkEnableClassBrowser.Checked;
  chkCBParseLocalH.Enabled := chkEnableClassBrowser.Checked;
  chkCBParseGlobalH.Enabled := chkEnableClassBrowser.Checked;
  chkCBUseColors.Enabled := chkEnableClassBrowser.Checked;
  // completion
  chkEnableCompletion.Enabled := chkEnableClassBrowser.Checked;
  edCompletionDelay.Enabled := chkEnableClassBrowser.Checked;
  cpCompletionBackground.Enabled := chkEnableClassBrowser.Checked;
end;

procedure TEditorOptForm.btnSaveSyntaxClick(Sender: TObject);
var
{$IFDEF SCINTILLA}
  StylesFile: String;
{$ELSE}
  idx: integer;
  fINI: TIniFile;
  pt: TPoint;
{$ENDIF}
  S: string;
begin
  s := 'New syntax';
  if not InputQuery(Lang[ID_EOPT_SAVESYNTAX], Lang[ID_EOPT_SAVESYNTAXQUESTION], s) or (s='') then
    Exit;
                                      
{$IFDEF SCINTILLA}
  StylesFile := devDirs.Styles + s + STYLES_EXT;
  if FileExists(StylesFile)
  then  //is there a rogue devcpp.Styles file hanging around?
  begin
    if not (pLoadEdit.SaveStyles(StylesFile)) then
      MessageDlg('Cannot Save style file...', mtError, [mbOk], 0);//UpdateOutputStyles;
  end
  else
      MessageDlg('Style file does not exist...', mtError, [mbOk], 0);//UpdateOutputStyles;

{$ELSE}
  fINI := TIniFile.Create(devDirs.Config + s + SYNTAX_EXT);
  try
    for idx := 0 to pred(Cpp.AttrCount) do
      fINI.WriteString('Editor.Custom', Cpp.Attribute[idx].Name, AttrtoStr(Cpp.Attribute[idx]));

    for idx:= Cpp.AttrCount to pred(ElementList.Items.Count) do begin
      if AnsiCompareText(ElementList.Items[idx], cSel) = 0 then
        pt := fSelColor
      else if AnsiCompareText(ElementList.Items[idx], cBP) = 0 then
        pt := fBPColor
      else if AnsiCompareText(ElementList.Items[idx], cErr) = 0 then
        pt := fErrColor
      else if AnsiCompareText(ElementList.Items[idx], cABP) = 0 then
        pt := fABPColor
      else if AnsiCompareText(ElementList.Items[idx], cGut) = 0 then
        pt := fGutColor;
      fINI.WriteString('Editor.Custom', ElementList.Items[idx], PointtoStr(pt));
    end;
  finally
    fINI.Free;
  end;
{$ENDIF}
  if cboQuickColor.Items.IndexOf(S) = -1 then
    cboQuickColor.Items.Add(S);
  cboQuickColor.ItemIndex := cboQuickColor.Items.IndexOf(S);
end;

procedure TEditorOptForm.LoadSyntax(Value: string);
var
  idx: integer;
  fINI: TIniFile;
{$IFDEF SCINTILLA}
  filename : String;
{$ELSE}
  Attr: TSynHighlighterAttributes;
{$ENDIF}
  pt: TPoint;
begin
{$IFDEF SCINTILLA}
{$ELSE}
  fINI := TIniFile.Create(devDirs.Config + Value + SYNTAX_EXT);
  try
    for idx:= 0 to pred(Cpp.AttrCount) do begin
      Attr := TSynHighlighterAttributes.Create(Cpp.Attribute[idx].Name);
      try
        StrToAttr(Attr, fINI.ReadString('Editor.Custom', Cpp.Attribute[idx].Name, devEditor.Syntax.Values[Cpp.Attribute[idx].Name]));
        Cpp.Attribute[idx].Assign(Attr);
      finally
        Attr.Free;
      end;
    end;

    for idx:= Cpp.AttrCount to pred(ElementList.Items.Count) do begin
      StrToPoint(pt, fINI.ReadString('Editor.Custom', ElementList.Items[idx], PointToStr(Point(clNone, clNone))));
      if AnsiCompareText(ElementList.Items[idx], cSel) = 0 then
        fSelColor := pt
      else if AnsiCompareText(ElementList.Items[idx], cBP) = 0 then
        fBPColor := pt
      else if AnsiCompareText(ElementList.Items[idx], cErr) = 0 then
        fErrColor := pt
      else if AnsiCompareText(ElementList.Items[idx], cABP) = 0 then
        fABPColor := pt
      else if AnsiCompareText(ElementList.Items[idx], cGut) = 0 then begin
        fGutColor := pt;
        SetGutter;
      end;
    end;
  finally
    fINI.Free;
  end;
  ElementListClick(nil);
{$ENDIF}
end;

procedure TEditorOptForm.FillSyntaxSets;
var
  SR: TSearchRec;
begin
  if FindFirst(devDirs.Config + '*' + SYNTAX_EXT, faAnyFile, SR) = 0 then
    repeat
      cboQuickColor.Items.Add(StringReplace(SR.Name, SYNTAX_EXT, '', [rfIgnoreCase]));
    until FindNext(SR) <> 0;
end;

procedure TEditorOptForm.chkCBUseColorsClick(Sender: TObject);
begin
  ClassBrowser1.UseColors := chkCBUseColors.Checked;
  ClassBrowser1.Refresh;
end;

procedure TEditorOptForm.btnCCCnewClick(Sender: TObject);
var
  I, I1: integer;
  Hits: integer;
  MaxHits, MaxIndex: integer;
  sl: TStrings;
  flt: string;
begin
  // the following piece of code is a quick'n'dirty way to find the base
  // compiler's include dir (if we 're lucky).
  // we search through devDirs.C and try to locate the base dir that is
  // most common between the others(!).
  // if no most-common dir is found, we select the first in list.
  // for a default installation, it should work.
  //
  // will be replaced by a dialog ( when it's ready ;) to let the user
  // select, so that he gets the blame if the thing does not work ;)))
  //
  // PS: is there a better way to do it???
  sl := TStringList.Create;
  try
    sl.Delimiter := ';';
    sl.DelimitedText := devDirs.C;
    if sl.Count>1 then begin
      MaxHits := 0;
      MaxIndex := 0;
      for I1:=0 to sl.Count-1 do begin
        Hits := 0;
        for I := 0 to sl.Count - 1 do
          if AnsiStartsText(sl[I1], sl[I]) then
            Inc(Hits);
        if Hits>MaxHits then begin
          MaxHits := Hits;
          MaxIndex := I1;
        end;
      end;
      CppParser1.ProjectDir := IncludeTrailingPathDelimiter(sl[MaxIndex]);
    end
    else
      CppParser1.ProjectDir := IncludeTrailingPathDelimiter(devDirs.C);
  finally
    sl.Free;
  end;

  with dmMain do begin
    BuildFilter(flt, [FLT_HEADS]);
    OpenDialog.Filter := flt;
    if OpenDialog.Execute then begin
      Application.ProcessMessages;
      Screen.Cursor := crHourglass;

      //Track the cache parse progress
      HasProgressStarted := false;
      CppParser1.OnStartParsing := CppParser1StartParsing;
      CppParser1.OnEndParsing := CppParser1EndParsing;
      CppParser1.OnTotalProgress := CppParser1TotalProgress;

      //Add the files to scan and then parse the list
      for I := 0 to OpenDialog.Files.Count - 1 do
        CppParser1.AddFileToScan(OpenDialog.Files[I]);
      CppParser1.ParseList;
      Screen.Cursor := crDefault;
      chkCCCache.Tag := 1; // mark modified

      //Finally append the new items unto the listbox
      for I := 0 to OpenDialog.Files.Count - 1 do
        lbCCC.Items.Add(CompactFilename(OpenDialog.Files[I]));
    end;
  end;
end;

procedure TEditorOptForm.btnCCCdeleteClick(Sender: TObject);
begin
  if lbCCC.Items.Count = 0 then
    Exit;
  if MessageDlg('Are you sure you want to clear the cache?', mtConfirmation, [mbYes, mbNo], 0)=mrYes then begin
    DeleteFile(devDirs.Config + DEV_COMPLETION_CACHE);
    FreeAndNil(CppParser1);
    CppParser1 := TCppParser.Create(Self);
    CppParser1.Tokenizer := CppTokenizer1;
    CppParser1.ParseLocalHeaders := True;
    CppParser1.ParseGlobalHeaders := True;
    CppParser1.OnStartParsing := CppParser1StartParsing;
    CppParser1.OnEndParsing := CppParser1EndParsing;
    CppParser1.OnTotalProgress := CppParser1TotalProgress;
    lbCCC.Items.Clear;
    chkCCCache.Tag := 1; // mark modified
  end;
end;

procedure TEditorOptForm.FillCCC;
var
  I: Integer;
begin
  Screen.Cursor := crHourglass;
  CppParser1.OnEndParsing := nil;
  CppParser1.OnCacheProgress := CppParser1CacheProgress;
  CppParser1.Load(devDirs.Config + DEV_COMPLETION_CACHE);
  for I := 0 to CppParser1.CacheContents.Count - 1 do
    lbCCC.Items.Add(CompactFilename(CppParser1.CacheContents[I]));

  CppParser1.OnEndParsing := CppParser1EndParsing;
  pbCCCache.Visible := False;
  Screen.Cursor := crDefault;
end;

procedure TEditorOptForm.chkCCCacheClick(Sender: TObject);
begin
  chkCCCache.Tag := 1; // mark modified
  lbCCC.Enabled := chkCCCache.Checked;
  btnCCCnew.Enabled := chkCCCache.Checked;
  btnCCCdelete.Enabled := chkCCCache.Checked;
end;

function TEditorOptForm.CompactFilename(filename: string): string;
var
  DC: HDC;
begin
  //Get a handle to the DC
  DC := lbCCC.Canvas.Handle;
  PathCompactPath(DC, PChar(filename), lbCCC.ClientWidth);
  Result := filename;
end;

procedure TEditorOptForm.CppParser1StartParsing(Sender: TObject);
begin
  pbCCCache.Visible := True;
end;

procedure TEditorOptForm.CppParser1EndParsing(Sender: TObject);
begin
  pbCCCache.Visible := False;
end;

procedure TEditorOptForm.CppParser1TotalProgress(Sender: TObject;
  FileName: String; Total, Current: Integer);
  begin
  if not HasProgressStarted then begin
    pbCCCache.Max := Total;
    HasProgressStarted := true;
  end;
  pbCCCache.Position := pbCCCache.Position + Current;
  Application.ProcessMessages;
end;

procedure TEditorOptForm.CppParser1CacheProgress(Sender: TObject; FileName: String;
      Total, Current: Integer);
begin
  pbCCCache.Max := Total;
  pbCCCache.Position := Current;
  pbCCCache.Update;
end;

procedure TEditorOptForm.devPages1Change(Sender: TObject);
begin
  if (devPages1.ActivePage=tabCBCompletion) and (CppParser1.Statements.Count=0) then
    FillCCC;
end;

procedure TEditorOptForm.chkCBShowInheritedClick(Sender: TObject);
begin
  ClassBrowser1.ShowInheritedMembers := chkCBShowInherited.Checked;
  ClassBrowser1.Refresh;
end;

{$IFDEF SCINTILLA}
{$ELSE}
procedure TEditorOptForm.OnGutterClick(Sender: TObject;
  Button: TMouseButton; X, Y, Line: Integer; Mark: TSynEditMark);
var
 idx: integer;
begin
  idx:= ElementList.Items.IndexOf(cGut);
  if idx <> -1 then
   begin
     ElementList.ItemIndex:= idx;
     ElementListClick(Self);
   end;
end;
{$ENDIF}



procedure TEditorOptForm.cbHighCurrLineClick(Sender: TObject);
begin
{$IFDEF SCINTILLA}
{$ELSE}
  cpHighColor.Enabled := cbHighCurrLine.Checked;
{$ENDIF}
end;

procedure TEditorOptForm.seTabSizeChange(Sender: TObject);
begin
{$IFDEF SCINTILLA}
{$ELSE}
  CppEdit.TabWidth := seTabSize.Value;
{$ENDIF}
end;

procedure TEditorOptForm.btnScintillaOptionsClick(Sender: TObject);
begin
   ScintillaOptionsDlg1.Execute;
end;

end.
