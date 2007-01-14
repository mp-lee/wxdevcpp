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

unit Search_Center;

interface

uses
{$IFDEF WIN32}
 Classes, Types, Project, Editor, utils,  SciLexer, SciLexerMemo, SciLexerMod, sciPrint, sciAbbrevationManager, SciActions,
  SciActionsRes, sciAddLanguageFormUnit, SciAutoComplete, SciCallTips, SciConfirmReplaceDlg,
  SciControllerHandler, SciDetectUtils, SciDocuments, SciFileExtensionsManager, SciKeyBindings,
  SciKeyEditForm, SciLexerOptionsDlg, SciMacroRecording, ScintillaLanguageManager,
  SciPropertyMgr, SciReplaceTextDlg, SciResLang, SciResLangDcl, SciSearchReplace,
  SciSearchReplaceBase, SciSearchTextDlg, SciStreamDefault, SciStyleLoader, SciSupport,
  sciUtils, SciWhatToFillUnit,
 ComCtrls;
{$ENDIF}
{$IFDEF LINUX}
 Classes, Types, Project, Editor, utils, QSynEdit, QComCtrls,
 QSynEditSearch, QSynEditRegexSearch, QSynEditMiscClasses, QSynEditTypes;
{$ENDIF}

type
  TLookIn = (liSelected, liFile, liProject, liOpen);
  TdevSearchProc = procedure(const SR: TdevSearchResult) of object;

  TdevSearchCenter = class(TObject)
  public
    function ExecuteSearch: boolean;
    procedure AssignSearchEngine(Regex: Boolean = false);
  private
    fSingleFile: boolean;
{$IFDEF SCINTILLA}
    fReplaceFlags : TReplaceConfirmType;
{$ELSE}
{$ENDIF}
    fReplace: boolean;
    fFindText: string;
    fReplaceText: string;
    fSearchProc: TdevSearchProc;
    fEditor: TEditor;
    fProject: TProject;
{$IFDEF SCINTILLA}
    fOptions: integer;   //mn scintilla search options
{$ELSE}
    fOptions: TSynSearchOptions;
{$ENDIF}
{$IFDEF SCINTILLA}
    fScintilla: TScintilla;
{$ELSE}
    fSynEdit: TSynEdit;
{$ENDIF}
    fCurFile: string;
    fPC: TPageControl;
{$IFDEF SCINTILLA}
    fSearchEngine: TSciSearchReplace;
{$ELSE}
    fSearchEngine: TSynEditSearchCustom;
{$ENDIF}
    function RunSingleFile: boolean;
    function RunAllFiles: boolean;
{$IFDEF SCINTILLA}
{$ELSE}
    procedure EditorReplaceText(Sender: TObject; const aSearch,
      aReplace: string; Line, Column: integer; var Action: TSynReplaceAction);
{$ENDIF}
    function RunProject: boolean;
    function RunOpenFiles: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property SingleFile: boolean read fSingleFile write fSingleFile;
    property Replace: boolean read fReplace write fReplace;
    property FindText: string read fFindText write fFindText;
    property ReplaceText: string read fReplaceText write fReplaceText;
    property SearchProc: TdevSearchProc read fSearchProc write fSearchProc;
    property Editor: TEditor read fEditor write fEditor;
    property Project: TProject read fProject write fProject;
{$IFDEF SCINTILLA}
    property Options: integer read fOptions write fOptions;   //mn scintilla search options
{$ELSE}
    property Options: TSynSearchOptions read fOptions write fOptions;
{$ENDIF}
    property PageControl: TPageControl read fPC write fPC;
  end;

var
  SearchCenter: TdevSearchCenter;

implementation

uses
{$IFDEF WIN32}
  Forms, SysUtils, Controls, Dialogs, Findfrm, Replacefrm, version, MultiLangSupport;
{$ENDIF}
{$IFDEF LINUX}
  QForms, SysUtils, QControls, QDialogs, Findfrm, Replacefrm, version, MultiLangSupport;
{$ENDIF}

{ TdevSearchCenter }

procedure TdevSearchCenter.AssignSearchEngine(Regex: Boolean);
begin
  //Get the search engine right
  if Regex then
  begin
{$IFDEF SCINTILLA}
    if Assigned(fSearchEngine) and not (fSearchEngine is TSciSearchReplace) then
{$ELSE}
    if Assigned(fSearchEngine) and not (fSearchEngine is TSynEditRegexSearch) then
{$ENDIF}
      FreeAndNil(fSearchEngine);
    if not Assigned(fSearchEngine) then
{$IFDEF SCINTILLA}
      fSearchEngine := TSciSearchReplace.Create(nil);
{$ELSE}
      fSearchEngine := TSynEditRegexSearch.Create(nil);
{$ENDIF}
  end
  else
  begin
{$IFDEF SCINTILLA}
    if Assigned(fSearchEngine) and not (fSearchEngine is TSciSearchReplace) then
{$ELSE}
    if Assigned(fSearchEngine) and not (fSearchEngine is TSynEditSearch) then
{$ENDIF}
      FreeAndNil(fSearchEngine);
    if not Assigned(fSearchEngine) then
{$IFDEF SCINTILLA}
      fSearchEngine := TSciSearchReplace.Create(nil);
{$ELSE}
      fSearchEngine := TSynEditSearch.Create(nil);
{$ENDIF}
  end;

  if Assigned(fEditor) then
{$IFDEF SCINTILLA}
{$ELSE}
    fEditor.Text.SearchEngine := fSearchEngine;
  fSynEdit.SearchEngine := fSearchEngine;
{$ENDIF}
end;
{$IFDEF SCINTILLA}
{$ELSE}
{$ENDIF}
function TdevSearchCenter.ExecuteSearch: boolean;
var
  return: integer;
begin
  if fReplace then
  begin
    frmReplace.cboFindText.Text:= fFindText;
    return := frmReplace.ShowModal;
    if (return = mrOk) or (return = mrAll) then
    begin
{$IFDEF SCINTILLA}
{$ELSE}
      AssignSearchEngine(frmReplace.Regex);
{$ENDIF}
      fFindText:= frmReplace.cboFindText.Text;
      fReplaceText:= frmReplace.cboReplaceText.Text;
      fOptions:= frmReplace.SearchOptions;
    end;
  end
  else
  begin
    frmFind.FindAll := not fSingleFile;
    frmFind.cboFindText.Text := fFindText;
    return := frmFind.ShowModal;
    fSingleFile := not frmFind.FindAll;
    if return = mrOk then
    begin
{$IFDEF SCINTILLA}
{$ELSE}
      AssignSearchEngine(frmFind.Regex);
{$ENDIF}
      fFindText:= frmFind.cboFindText.Text;
      fReplaceText:= '';
      fOptions:= frmFind.SearchOptions;
    end;
  end;

  if not (return in [mrOk, mrAll]) then
    result:= FALSE
  else if fReplace or (frmFind.FindWhat in [liSelected, liFile]) then
    result:= RunSingleFile
  else
    result:= RunAllFiles;
end;

function TdevSearchCenter.RunSingleFile: boolean;
begin
  if not assigned(fEditor) then
  begin
    Result:= False;
    Exit;
  end
  else 
{$IFDEF SCINTILLA}
    begin
      fSearchEngine.SearchText := fFindText;
      fSearchEngine.ReplaceText := fReplaceText;
      fSearchEngine.DoSearchReplaceText(False,False, fReplaceFlags);
      end;
{$ELSE}
  if fEditor.Text.SearchReplace(fFindText, fReplaceText, fOptions) = 0 then
    MessageDlg(Format(Lang[ID_MSG_TEXTNOTFOUND], [SearchCenter.FindText]),
       mtInformation, [mbOk], 0);
{$ENDIF}
  Result:= True;
end;

function TdevSearchCenter.RunAllFiles: boolean;
begin
  fReplaceText:= DEV_SEARCHLOOP;
  if frmFind.FindWhat = liProject then
    Result:= RunProject
  else
    Result:= RunOpenFiles;
{$IFDEF SCINTILLA}
  fScintilla.ClearAll;
{$ELSE}
  fSynEdit.ClearAll;
{$ENDIF}
end;

function TdevSearchCenter.RunProject: boolean;
var
  idx: integer;
begin
  for idx := 0 to pred(fProject.Units.Count) do
  begin
    fCurFile:= fProject.Units[idx].FileName;
    if ExtractFilePath(fCurFile) = '' then
      fCurFile:= ExpandFileto(fCurFile, fProject.Directory);

    if assigned(fProject.Units[idx].Editor) then
{$IFDEF SCINTILLA}
      fScintilla.Lines:= fProject.Units[idx].Editor.Text.Lines
{$ELSE}
      fSynEdit.Lines:= fProject.Units[idx].Editor.Text.Lines
{$ENDIF}
    else
{$IFDEF SCINTILLA}
      fScintilla.Lines.LoadFromfile(fCurFile);
{$ELSE}
      fSynEdit.Lines.LoadFromfile(fCurFile);
{$ENDIF}

{$IFDEF SCINTILLA}
    fSearchEngine.SearchText := fFindText;
    fSearchEngine.ReplaceText := fReplaceText;
    fSearchEngine.DoSearchReplaceText(False,False, fReplaceFlags);
{$ELSE}
    fSynEdit.SearchReplace(fFindText, fReplaceText, fOptions);
{$ENDIF}
    Application.ProcessMessages;
  end;
  result:= True;
end;

function TdevSearchCenter.RunOpenFiles: boolean;
var
  idx: integer;
begin
  for idx := 0 to pred(fPC.PageCount) do
  begin
    fCurFile:= TEditor(fPC.Pages[idx].Tag).FileName;
{$IFDEF SCINTILLA}
     fScintilla.Lines:= TEditor(fPC.Pages[idx].Tag).Text.Lines;
 //   fScintilla.SearchReplace(fFindText, fReplaceText, fOptions);
      fSearchEngine.SearchText := fFindText;
      fSearchEngine.ReplaceText := fReplaceText;
//mn need to change this      fSearchEngine.fReplaceFlags := rctConfirm;
      fSearchEngine.DoSearchReplaceText(False,False, fReplaceFlags);
{$ELSE}
    fSynEdit.Lines:= TEditor(fPC.Pages[idx].Tag).Text.Lines;
    fSynEdit.SearchReplace(fFindText, fReplaceText, fOptions);
{$ENDIF}
    Application.ProcessMessages;
  end;
  result:= TRUE;
end;
{$IFDEF SCINTILLA}
{$ELSE}
procedure TdevSearchCenter.EditorReplaceText(Sender: TObject;
  const aSearch, aReplace: string; Line, Column: integer;
  var Action: TSynReplaceAction);
var
  SR: TdevSearchResult;
begin
  if fReplaceText = DEV_SEARCHLOOP then
  begin
    SR.pt:= point(Line, Column);
    SR.InFile:= fCurFile;
    SR.msg:= fSynEdit.Lines[Line -1];
{$IFDEF SCINTILLA}
    SR.msg:= fScintilla.Lines[Line -1];
{$ELSE}
    fSearchProc(SR);
{$ENDIF}
  end;
  Action:= raSkip;
end;
{$ENDIF}
constructor TdevSearchCenter.Create;
begin
  fSingleFile := true;
{$IFDEF SCINTILLA}
  fScintilla := TScintilla.Create(PageControl);
{$ELSE}
  fSynEdit:= TSynEdit.Create(nil);
  fSynEdit.OnReplaceText:= EditorReplaceText;

  fSearchEngine:=TSynEditSearch.Create(nil);
{$ENDIF}
end;

destructor TdevSearchCenter.Destroy;
begin
{$IFDEF SCINTILLA}
  fScintilla.Free;
{$ELSE}
  fSearchEngine.Free;
  fSynEdit.Free;
{$ENDIF}
  inherited;
end;

initialization
 SearchCenter:= TdevSearchCenter.Create;
finalization
 SearchCenter.Free;

end.
