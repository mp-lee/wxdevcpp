{
    $Id$

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

unit datamod;

interface

uses
{$IFDEF WX_BUILD}
    ScintillaLanguageManager,
{$ENDIF}
{$IFDEF WIN32}
  SysUtils, Classes, Menus, Dialogs, ImgList, Controls,
  SciPropertyMgr, sciPrint,
  oysUtils, CodeIns, SynCompletionProposal, SynEditHighlighter,
  SynHighlighterRC;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QMenus, QDialogs, QImgList, QControls,
  QSynEditExport, QSynExportHTML, QSynExportRTF,
  QSynEditHighlighter, QSynHighlighterCpp, QSynEditPrint,
  oysUtils, CodeIns, QSynHighlighterRC, QSynCompletionProposal,
  QSynEditMiscClasses, QSynEditSearch;
{$ENDIF}

type
  TdmMain = class(TDataModule)
    PrinterSetupDialog: TPrinterSetupDialog;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ProjectImage_Gnome: TImageList;
    MenuImages_Gnome: TImageList;
    HelpImages_Gnome: TImageList;
    MenuImages_NewLook: TImageList;
    ProjectImage_NewLook: TImageList;
    HelpImages_NewLook: TImageList;
    SpecialImages_Gnome: TImageList;
    SpecialImages_NewLook: TImageList;
    GutterImages: TImageList;
    MenuImages_Blue: TImageList;
    HelpImages_Blue: TImageList;
    ProjectImage_Blue: TImageList;
    Specialimages_Blue: TImageList;
    ResourceDialog: TOpenDialog;
    ClassImages: TImageList;
    SciPrinter: TSciPrinter;

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    fUnitCount: integer;
    { Code Inserts }
  private
    fCodeList: TCodeInsList;
    fCodeMenu: TMenuItem;
    fCodePop: TMenuItem;
    fCodeEvent: TNotifyEvent;
    fCodeOffset: byte;
    procedure LoadCodeIns;
  public
    function InsertList: TStrings;
    property CodeMenu: TMenuItem read fCodeMenu write fCodeMenu;
    property CodePop: TMenuItem read fCodePop write fCodePop;
    property CodeClick: TNotifyEvent read fCodeEvent write fCodeEvent;
    property CodeInserts: TCodeInsList read fCodeList write fCodeList;
    property CodeOffset: byte read fCodeOffset write fCodeOffset;

    { MRU List }
  private
    fMRU: ToysStringList;
    fMRUMenu: TMenuItem;
    fMRUMax: byte;
    fMRUOffset: integer;
    fMRUClick: TNotifyEvent;
    procedure LoadHistory;
    procedure SaveHistory;
    procedure RebuildMRU;
    function GetMRU(index: integer): string;
  public
    fProjectCount: integer;
    procedure AddtoHistory(s: string);
    procedure RemoveFromHistory(s: string);
    procedure ClearHistory;
    property MRU[index: integer]: string read GetMRU;
    property MRUMenu: TMenuItem read fMRUMenu write fMRUMenu;
    property MRUOffset: integer read fMRUOffset write fMRUOffset;
    property MRUMax: byte read fMRUMax write fMRUMax;
    property MRUClick: TNotifyEvent read fMRUClick write fMRUClick;

  public
    procedure LoadDataMod;
    function GetNumber: integer;
    function GetNum: integer;
    procedure InitHighlighterFirstTime;
    procedure UpdateHighlighter;
    function GetHighlighter(const FileName: string): string;

    procedure ExportToHtml(FileLines: TStrings; ExportFilename: string);
    procedure ExportToRtf(FileLines: TStrings; ExportFilename: string);
  end;

var
  dmMain: TdmMain;

implementation

uses
  devcfg, IniFiles, utils, version, main, MultiLangSupport, windows;

{$R *.dfm}

{ TdmMain }

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  fMRU := ToysStringList.Create;
  fCodeList := TCodeInsList.Create;


end;

procedure TdmMain.DataModuleDestroy(Sender: TObject);
begin
  SaveHistory;
  fMRU.Free;
  fCodeList.Free;
end;

procedure TdmMain.InitHighlighterFirstTime;
  procedure AddSpecial(AttrName: string; Offset: integer);
  var
    a: integer;
  begin
    a := devEditor.Syntax.IndexofName(AttrName);
    if a = -1 then
      devEditor.Syntax.Append(format('%s=%s', [AttrName, LoadStr(offset)]))
    else
      devEditor.Syntax.Values[AttrName] := LoadStr(offset);
  end;
var
  i, a, offset: integer;
  InitialStylesFile: String;
  Attrs: integer;
begin
  offset := 0 * 1000; // default to style-set '0'
  InitialStylesFile := devDirs.Styles + 'devcpp' + STYLES_EXT;

  if FileExists(InitialStylesFile) then  //is there a rogue devcpp.Styles file hanging around?

  begin
    if FileIsReadOnly(InitialStylesFile)then //we are going to delete the file so remove read only if there
  begin
      Attrs := FileGetAttr(InitialStylesFile);
      FileSetAttr(InitialStylesFile, Attrs - faReadOnly);
  end;
    DeleteFile(PChar(InitialStylesFile));// delete the file so that we can create a new one
  end;

  // we create a new devcpp.Styles file here, totally from scratch just in case
  // we do this so that we can quickly get the scintilla component up and running
  //have to find a better method later

  //first create the Styles Folder
  if not DirectoryExists(devDirs.Styles) then
    if not CreateDir(devDirs.Styles) then
      raise Exception.Create('Cannot create Styles folder');

    if not (MainForm.pLoader.SaveStyles(InitialStylesFile)) then
      MessageDlg('Cannot create default style file...', mtError, [mbOk], 0);//UpdateOutputStyles;

end;

procedure TdmMain.UpdateHighlighter;
var
{$IFDEF SCINTILLA}
  InitialStylesFile : string;
{$ELSE}
  aName: string;
  a,
    idx: integer;
{$ENDIF}
begin
{$IFDEF SCINTILLA}
  InitialStylesFile := devDirs.Styles + 'devcpp' + STYLES_EXT;

//   MainForm.pLoader.FileName:=ExtractFileDir( ParamStr(0) )+'\sci.properties';
   MainForm.pLoader.FileName:=InitialStylesFile;
   if not FileExists(MainForm.pLoader.FileName) then //exit;
//     if not FileExists(InitialStylesFile) then
       MessageDlg('Cannot load default style file. Please go to Tools | Editor Options | Syntax and create a new set of editor options', mtError, [mbOk], 0)
     else
begin
       MainForm.pLoader.Load;
       MainForm.pLoader.LoadStyles(InitialStylesFile);
     end;
{$ELSE}
  for idx := 0 to pred(cpp.AttrCount) do
  begin
    aName := cpp.Attribute[idx].Name;
    a := devEditor.Syntax.IndexOfName(aName);
    if a <> -1 then
    begin
      Attr := TSynHighlighterAttributes.Create(aName);
      try
        StrtoAttr(Attr, devEditor.Syntax.Values[aname]);
        cpp.Attribute[idx].Assign(attr);
      finally
        Attr.Free;
      end;
    end;
  end;
  // update res highlighter
  with Res do
  begin
    CommentAttri.Assign(cpp.CommentAttri);
    DirecAttri.Assign(cpp.DirecAttri);
    IdentifierAttri.Assign(cpp.IdentifierAttri);
    KeyAttri.Assign(cpp.KeyAttri);
    NumberAttri.Assign(cpp.NumberAttri);
    SpaceAttri.Assign(cpp.SpaceAttri);
    StringAttri.Assign(cpp.StringAttri);
    SymbolAttri.Assign(cpp.SymbolAttri);
  end;
  with Assembly do
  begin
    CommentAttri.Assign(cpp.CommentAttri);
    IdentifierAttri.Assign(cpp.IdentifierAttri);
    KeyAttri.Assign(cpp.KeyAttri);
    NumberAttri.Assign(cpp.NumberAttri);
    SpaceAttri.Assign(cpp.SpaceAttri);
    StringAttri.Assign(cpp.StringAttri);
    SymbolAttri.Assign(cpp.SymbolAttri);
  end;
{$ENDIF}
end;

function TdmMain.GetHighlighter(const FileName: string): string;
var
  ext: string;
  idx: integer;
  tmp: TStrings;
begin
  UpdateHighlighter;
  result := '';//nil;
  if devEditor.UseSyntax then
  begin
    if (FileName = '') or (AnsiPos(Lang[ID_UNTITLED], FileName) = 1) then
      result := 'C++/C'
    else
    begin
      ext := ExtractFileExt(FileName);
      if AnsiCompareText(ext, RC_EXT) = 0 then
        result := 'Resource'
      else if (AnsiCompareText(ext, '.s') = 0) or (AnsiCompareText(ext, '.asm') = 0) then
        result := 'ASM'
  
{$IFDEF WX_BUILD}
      else if (AnsiCompareText(ext, XRC_EXT) = 0) then
          result := 'XML'
{$ENDIF}
      else
      begin
        tmp := TStringList.Create;
        try
          delete(ext, 1, 1);
          tmp.Delimiter := ';';
          tmp.DelimitedText := devEditor.SyntaxExt;
          if tmp.Count > 0 then
            for idx := 0 to pred(tmp.Count) do
              if AnsiCompareText(Ext, tmp[idx]) = 0 then
              begin
                result := 'C++/C';
                Exit;
              end;
        finally
          tmp.Free;
        end;
      end;
    end;
  end;
end;

function TdmMain.GetNum: integer;
begin
  inc(fUnitCount);
  result := fUnitCount;
end;

function TdmMain.GetNumber: integer;
begin
  inc(fProjectCount);
  result := fProjectCount;
end;

procedure TdmMain.LoadDataMod;
begin
  LoadHistory;
  LoadCodeIns;
  UpdateHighlighter;
end;


{ ---------- MRU ---------- }

procedure TdmMain.AddtoHistory(s: string);
var
  idx: integer;
begin
  if (s = '') then exit;
  idx := fMRU.IndexofValue(s);
  if idx = -1 then
    // insert always first
    fMRU.Insert(0, Format('%d=%s', [fMRU.Count, s]));
  RebuildMRU;
end;

procedure TdmMain.RemoveFromHistory(s: string);
var
  idx: integer;
begin
  idx := fMRU.IndexofValue(s);
  if idx > -1 then fMRU.Delete(idx);
  RebuildMRU;
end;

procedure TdmMain.ClearHistory;
begin
  fMRU.Clear;
  RebuildMRU;
end;

function TdmMain.GetMRU(index: integer): string;
begin
  result := fMRU.Values[index];
end;

procedure TdmMain.LoadHistory;
var
  ini: TINIFile;
  idx: integer;
begin
  ClearHistory;
  ini := TiniFile.Create(devData.iniFile);
  with ini do
  try
    if not SectionExists('History') then exit;
    ReadSectionValues('History', fMRU);
    if fMRU.Count = 0 then exit;
    for idx := pred(fMRU.Count) downto 0 do
      if not FileExists(fMRU.Values[idx]) then
        fMRU.Delete(idx);
  finally
    Free;
  end;
  RebuildMRU;
end;

procedure TdmMain.SaveHistory;
var
  ini: TINIFile;
  idx: integer;
begin
  if not assigned(fMRU) then exit;

  ini := TINIFile.Create(devData.INIFile);
  with ini do
  try
    EraseSection('History');
    if fMRU.Count = 0 then exit;
    for idx := 0 to pred(fMRU.Count) do
      WriteString('History', inttostr(idx), fMRU.Values[idx]);
  finally
    Free;
  end;
end;

procedure TdmMain.RebuildMRU;
  // this function sorts the MRU by bringing the .dev files to the top of the list.
  // It doesn't alter the order in other ways... The return value is the Index of
  // the first non .dev file
  function SortMRU: integer;
  var
    I, C: integer;
    swp: string;
    Done: boolean;
  begin
    C := 0;
    repeat
      Done := True;
      for I := 0 to fMRU.Count - 2 do
        if (LowerCase(ExtractFileExt(fMRU[I])) <> '.dev') and
           (LowerCase(ExtractFileExt(fMRU[I+1])) = '.dev') then begin
          swp := fMRU[I];
          fMRU[I] := fMRU[I + 1];
          fMRU[I + 1] := swp;
          Done := False;
        end;
    until Done;
    for I := 0 to fMRU.Count - 1 do
      if LowerCase(ExtractFileExt(fMRU[I])) <> '.dev' then begin
        C := I;
        Break;
      end;
    Result := C;
  end;
var
  Item: TMenuItem;
  NonDev: integer;
  UpdMRU: ToysStringList;
  Stop, Counter, idx: integer;
begin
  if not assigned(fMRUMenu) then exit;
  for idx := pred(fMRUMenu.Count) downto fMRUOffset do
    fMRUMenu[idx].Free;
  
  // Initialize a new MRU... We'll be adding in this *only* the entries that are
  // going to fMRUMenu. After that, we 'll replace the fMRU with UpdMRU. That
  // way the MRU is always up to date and does not contain excess elements.
  UpdMRU := ToysStringList.Create;
  Counter := 0;

  // Build the .dev recent files entries (*.dev)
  // TODO: Make the number of project files configurable?
  NonDev := SortMRU;
  if NonDev > 4 then
    Stop := 4
  else
    Stop := NonDev;

  for idx := 0 to pred(Stop) do
  begin
    UpdMRU.Add(Format('%d=%s', [UpdMRU.Count, fMRU.Values[idx]]));
    Item := TMenuItem.Create(fMRUMenu);
    Item.Caption := format('&%1x %s', [Counter, fMRU.Values[idx]]);
    Item.OnClick := fMRUClick;
    Item.Tag := UpdMRU.Count - 1;
    fMRUMenu.Add(Item);
    Inc(Counter);
  end;

  if (fMRUMenu.Count - fMRUOffset) > 0 then
    fMRUMenu.InsertNewLineAfter(fMRUMenu.Items[fMRUMenu.Count - 1]);

  // Now build the other recent files entries (*.cpp, *.h, etc)
  if (fMRU.Count - NonDev) > fMRUMax then
    Stop := NonDev + fMRUMax
  else
    Stop := fMRU.Count;

  for idx := NonDev to pred(Stop) do
  begin
    UpdMRU.Add(Format('%d=%s', [UpdMRU.Count, fMRU.Values[idx]]));
    Item := TMenuItem.Create(fMRUMenu);
    Item.Caption := format('&%1x %s', [Counter, fMRU.Values[idx]]);
    Item.OnClick := fMRUClick;
    Item.Tag := UpdMRU.Count - 1;
    fMRUMenu.Add(Item);
    Inc(Counter);
  end;
  fMRUMenu.Enabled := (fMRUMenu.Count - fMRUOffset) > 0;

  // update MRU
  fMRU.Assign(UpdMRU);
  UpdMRU.Free;

  // redraw the menu
  if Assigned(fMRUMenu) then
    MainForm.XPMenu.InitComponent(fMRUMenu);
end;

{ ---------- Code Insert Methods ---------- }

function TdmMain.InsertList: TStrings;
var
  idx: integer;
begin
  result := TStringList.Create;
  try
    for idx := 0 to pred(fCodeList.Count) do
      result.Append(fCodeList[idx].Caption);
  except
    FreeandNIL(Result);
  end;
end;

// Loads code inserts, when sep value changes a separator is
// insert only if sep is a higher value then previous sep value.
procedure TdmMain.LoadCodeIns;
var
  cdx,
    idx: integer;
  Item: TMenuItem;
begin
  if not assigned(fCodeMenu) then exit;
  fCodeList.LoadCode;

  for idx := pred(fCodeMenu.Count) downto fCodeOffset do
    fCodeMenu[idx].Free;

  if assigned(fCodePop) then
    fCodePop.Clear;

  cdx := 0;
  for idx := 0 to pred(fCodeList.Count) do
  begin
    Item := TMenuItem.Create(fCodeMenu);
    Item.Caption := fCodeList[idx]^.Caption;
    Item.OnClick := fCodeEvent;
    Item.Tag := idx;
    if fCodeList[idx]^.Sep <= cdx then
      fCodeMenu.Add(Item)
    else
    begin
      cdx := fCodeList[idx]^.Sep;
      fCodeMenu.NewBottomLine;
      fCodeMenu.Add(Item);
    end;
  end;
  fCodeMenu.Visible := fCodeMenu.Count > 0;
  if assigned(fCodePop) then
  begin
    CloneMenu(fCodeMenu, fCodePop);
    MainForm.XPMenu.InitComponent(fCodePop);
  end;
end;

procedure TdmMain.ExportToHtml(FileLines: TStrings; ExportFilename: string);
begin
  if (not Assigned(FileLines)) or (FileLines.Count=0) or (ExportFilename='') then
    Exit;
{$IFDEF SCINTILLA}
{$ELSE}
  SynExporterHTML.Title := ExtractFileName(ExportFileName);
  SynExporterHTML.CreateHTMLFragment := False;
  SynExporterHTML.ExportAsText := True;
  SynExporterHTML.Color := Cpp.SpaceAttri.Background;
  SynExporterHTML.ExportAll(FileLines);
  SynExporterHTML.SavetoFile(ExportFileName);
{$ENDIF}
end;

procedure TdmMain.ExportToRtf(FileLines: TStrings; ExportFilename: string);
begin
  if (not Assigned(FileLines)) or (FileLines.Count=0) or (ExportFilename='') then
    Exit;

{$IFDEF SCINTILLA}
{$ELSE}
  SynExporterRTF.ExportAll(FileLines);
  SynExporterRTF.SavetoFile(ExportFileName);
{$ENDIF}
end;

end.