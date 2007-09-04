{
    $Id: ComponentPalette.pas 893 2007-02-20 00:36:21Z gururamnath $

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

unit ClassBrowser;

interface

uses
  U_IntList, Classes, SysUtils, CppParser,
{$IFDEF WIN32}
  Windows, Messages, Controls, ComCtrls, Forms, Graphics;
{$ENDIF}
{$IFDEF LINUX}
  QControls, QComCtrls, QForms, QGraphics;
{$ENDIF}

const
  MAX_CUSTOM_FOLDERS = 250;

type
  TMemberSelectEvent = procedure(Sender: TObject; Filename: TFilename; Line: integer) of object;

  PFolders = ^TFolders;
  TFolders = record
    Index: Char;
    Name: string[32];
    Under: string[164];
    Node: TTreeNode;
  end;

  PFolderAssocs = ^TFolderAssocs;
  TFolderAssocs = record
    FolderID: integer;
    Folder: string[32];
    Command: string[164];
  end;

  TImagesRecord = class(TPersistent)
  private
    fGlobalsImg: integer;
    fClassesImg: integer;
    fVariablePrivateImg: integer;
    fVariableProtectedImg: integer;
    fVariablePublicImg: Integer;
    fMethodPrivateImg: integer;
    fMethodProtectedImg: integer;
    fMethodPublicImg: Integer;
    fInhMethodProtectedImg: integer;
    fInhMethodPublicImg: integer;
    fInhVariableProtectedImg: integer;
    fInhVariablePublicImg: integer;
  published
    property Globals: integer read fGlobalsImg write fGlobalsImg;
    property Classes: integer read fClassesImg write fClassesImg;
    property VariablePrivate: integer read fVariablePrivateImg write fVariablePrivateImg;
    property VariableProtected: integer read fVariableProtectedImg write fVariableProtectedImg;
    property VariablePublic: integer read fVariablePublicImg write fVariablePublicImg;
    property MethodPrivate: integer read fMethodPrivateImg write fMethodPrivateImg;
    property MethodProtected: integer read fMethodProtectedImg write fMethodProtectedImg;
    property MethodPublic: integer read fMethodPublicImg write fMethodPublicImg;
    property InheritedMethodProtected: integer read fInhMethodProtectedImg write fInhMethodProtectedImg;
    property InheritedMethodPublic: integer read fInhMethodPublicImg write fInhMethodPublicImg;
    property InheritedVariableProtected: integer read fInhVariableProtectedImg write fInhVariableProtectedImg;
    property InheritedVariablePublic: integer read fInhVariablePublicImg write fInhVariablePublicImg;
  end;

  TShowFilter = (sfAll, sfProject, sfCurrent);

  TClassBrowser = class(TCustomTreeView)
  private
    fParser: TCppParser;
    fCanvas: TControlCanvas;
    fCurrentFile: string;
    fImagesRecord: TImagesRecord;

    fShowFilter: TShowFilter;

    {fOnSelect: TMemberSelectEvent;
    fCurrentFileHeader: string;
    fCurrentFileImpl: string;
    fProjectDir: TFileName;
    fClassFoldersFile: TFileName;
    fFolders: array of TFolders;
    fFolderAssocs: array of TFolderAssocs;
    fLastSelection: string;
    fCnv: TControlCanvas;
    fUseColors: boolean;
    fParserBusy: boolean;
    fShowInheritedMembers: boolean;
    fShowingSampleData: Boolean;}

    procedure OnPaint(var Msg: TMessage); message WM_PAINT;
    procedure OnExpand(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);

    procedure SetParser(Value: TCppParser);
    procedure SetNodeImages(Node: TTreeNode);
    procedure SetCurrentFile(Value: string);
    procedure SetShowFilter(const Value: TShowFilter);
    
    procedure AddMembers(Parent: TTreeNode; const Identifiers: TIntList);
    procedure AddBaseClasses(Parent: TTreeNode; const Identifiers: TIntList);

    {procedure OnNodeChange(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnNodeChanging(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure myDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure myDragDrop(Sender, Source: TObject; X, Y: Integer);

    procedure OnParserUpdate(Sender: TObject);
    procedure OnParserBusy(Sender: TObject);
    procedure SetNodeImages(Node: TTreeNode);
    procedure Sort;

    procedure ReadClassFolders; // read folders from disk
    procedure WriteClassFolders; // write folders to disk
    function HasSubFolder(Cmd: string): boolean; // if Command has subfolders, returns true
    procedure CreateFolders(Cmd: string; Node: TTreeNode); // creates folders under Command
    function BelongsToFolder(Cmd: string): integer; // returns the index to fFolders it belongs or -1 if does not
    function GetNodeOfFolder(Index: integer): TTreeNode; overload;
    function GetNodeOfFolder(Folder: string): TTreeNode; overload;
    procedure AddFolderAssociation(Fld, Cmd: string);
    procedure RemoveFolderAssociation(Fld, Cmd: string);
    function IndexOfFolder(Fld: string): integer;
    procedure ReSelect;
    procedure SetUseColors(const Value: boolean);
    procedure SetShowInheritedMembers(const Value: boolean);}

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    procedure UpdateView;
    {procedure ShowSampleData;
    procedure Clear;
    procedure AddFolder(S: string; Node: TTreeNode);
    procedure RemoveFolder(S: string);
    procedure RenameFolder(Old, New: string);
    function IsNodeAFolder(FolderNode: TTreeNode): Boolean;
    function FolderCount: integer;
    procedure SetUpdateOn;
    procedure SetUpdateOff;}
  published
    property Parser: TCppParser read fParser write SetParser;
    property CurrentFile: string read fCurrentFile write SetCurrentFile;
    property ShowFilter: TShowFilter read fShowFilter write SetShowFilter;

    property Align;
    property Font;
    property Color;
    property Images;
    property ReadOnly;
    property Indent;
    property TabOrder;
    property PopupMenu;
    {
    property OnSelect: TMemberSelectEvent read fOnSelect write fOnSelect;
    property ItemImages: TImagesRecord read fImagesRecord write fImagesRecord;
    property CurrentFile: string read fCurrentFile write SetCurrentFile;
    property ProjectDir: TFileName read fProjectDir write fProjectDir;
    property ClassFoldersFile: TFileName read fClassFoldersFile write fClassFoldersFile;
    property UseColors: boolean read fUseColors write SetUseColors;
    property ShowInheritedMembers: boolean read fShowInheritedMembers write SetShowInheritedMembers;}
  end;

const
  CLASS_FOLDERS_MAGIC = 'DEVCF_1_0';

implementation
uses
  DBugintf;
{ TClassBrowser }

constructor TClassBrowser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  OnExpanding := OnExpand;
  {OnMouseUp := OnNodeChange;
  OnMouseDown := OnNodeChanging;
  DragMode := dmAutomatic;
  OnDragOver := myDragOver;
  OnDragDrop := myDragDrop;
  fCurrentFile := '';
  fCurrentFileHeader := '';
  fCurrentFileImpl := '';
  fShowFilter := sfAll;
  fProjectDir := '';
  RightClickSelect := True;
  fShowingSampleData := False;}

  Self.RowSelect := True;
  Self.ShowHint := True;
  Self.ReadOnly := True;
  Self.HideSelection := False;
  Self.DoubleBuffered := True;

  fImagesRecord := TImagesRecord.Create;
  with fImagesRecord do
  begin
    fGlobalsImg := 0;
    fClassesImg := 1;
    fVariablePrivateImg := 2;
    fVariableProtectedImg := 3;
    fVariablePublicImg := 4;
    fMethodPrivateImg := 5;
    fMethodProtectedImg := 6;
    fMethodPublicImg := 7;
    fInhMethodProtectedImg := 8;
    fInhMethodPublicImg := 10;
    fInhVariableProtectedImg := 9;
    fInhVariablePublicImg := 11;

    //TODO: lowjoel: How did the original version get all their image list indices?
  end;

  fCanvas := TControlCanvas.Create;
  fCanvas.Control := Self;
  fCanvas.Font.Assign(Self.Font);
  fCanvas.Brush.Style := bsClear;
end;

destructor TClassBrowser.Destroy;
begin
  inherited Destroy;
end;

//---------------------------Event Handlers-----------------------------------------------------------------------------

procedure TClassBrowser.OnPaint(var Msg: TMessage);
var
  NodeRect, tmp: TRect;

  I: Integer;
  currItem: TTreeNode;
  currId: TParseIdentifier;
  currTextColor, currBrushColor: TColor;
begin
  inherited;
  for I := 0 to Items.Count - 1 do
  begin
    currItem := Items[I];
    NodeRect := currItem.DisplayRect(True);

    //See if the current node is visible to begin with
    if (not currItem.IsVisible) or (NodeRect.Top > Height) or
       (NodeRect.Bottom < 0) then
      Continue;

    currId := TParseIdentifier(currItem.Data);
    if currID <> nil then //Valid class data
    begin
      fCanvas.Font.Assign(Self.Font);
      fCanvas.Brush.Color := Self.Color;
      fCanvas.FillRect(NodeRect);

      if Selected = currItem then
      begin
        //Draw the selection rectangle
        tmp := NodeRect;

        //Calculate the selection rectangle
        if currId is TParseFunctionIdentifier then
          tmp.Right := fCanvas.TextWidth(TParseFunctionIdentifier(currId).ReturnsStr)
        else
          tmp.Right := 0;

        //Then take into account the identifier name
        fCanvas.Font.Style := fCanvas.Font.Style + [fsBold];
        tmp.Right := tmp.Left + tmp.Right + fCanvas.TextWidth(currId.Name) + 5;
        fCanvas.Font.Assign(Font);

        fCanvas.Brush.Color := clHighlight;
        fCanvas.FillRect(tmp);

        //Then set the colours to draw with
        fCanvas.Font.Color := clHighlightText;
      end;

      //Store the default colours
      currTextColor := fCanvas.Font.Color;
      currBrushColor := fCanvas.Brush.Color;

      //For functions, draw the return type in grey.
      if currId is TParseFunctionIdentifier then
      begin
        fCanvas.TextOut(NodeRect.Left + 2, NodeRect.Top + 1,
                        TParseFunctionIdentifier(currId).ReturnsStr);
        fCanvas.Brush.Color := Color;
        fCanvas.Font.Color := clGray;

        NodeRect.Left := NodeRect.Left + fCanvas.TextWidth(TParseFunctionIdentifier(currId).ReturnsStr) + 2;
      end;

      //Then draw the identifier name in bold
      fCanvas.Font.Style := [fsBold];
      fCanvas.Font.Color := currTextColor;
      fCanvas.Brush.Color := currBrushColor;
      fCanvas.TextOut(NodeRect.Left + 2, NodeRect.Top + 1, currId.Name);

      NodeRect.Left := NodeRect.Left + fCanvas.TextWidth(currId.Name) + 2;

      //And for functions draw the prototype in maroon
      fCanvas.Font.Style := [];
      fCanvas.Brush.Color := Color;
      fCanvas.Font.Color := clMaroon;

      if currId is TParseFunctionIdentifier then
      begin
        fCanvas.TextOut(NodeRect.Left + 2, NodeRect.Top + 1, TParseFunctionIdentifier(currId).Prototype)
      end
      else if currId is TParseVariableIdentifier then
        fCanvas.TextOut(NodeRect.Left + 2, NodeRect.Top + 1,
                        fParser.FindIdentifierName(TParseVariableIdentifier(currId).DataType));
    end;
  end;
end;

procedure TClassBrowser.OnExpand(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
var
  NodeData: Pointer;
  Children: TIntList;
begin
  //Show that we are busy (good for large classes)
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  //Delete the Expanding message
  Node.DeleteChildren;

  //If the current node's item data is nil, then look for the parent.
  if Node.Data = nil then
  begin
    NodeData := Node.Parent.Data;
    AddMembers(Node, TParseClassStructIdentifier(NodeData).Inherits);
  end
  else
  begin
    NodeData := Node.Data;

    //Show the inherited classes
    if (TParseIdentifier(NodeData) is TParseClassStructIdentifier) and
       (TParseClassStructIdentifier(NodeData).Inherits.Count <> 0) then
      AddBaseClasses(Node, TParseClassStructIdentifier(NodeData).Inherits);

    //Find all the identifiers in the current scope
    Children := fParser.GetIdentifiersInScope(TParseIdentifier(NodeData).ID, False);
    AddMembers(Node, Children);
    Children.Free;
  end;

  //Then reset the cursor
  Screen.Cursor := crDefault;
end;

//---------------------------Property Handlers--------------------------------------------------------------------------

procedure TClassBrowser.SetParser(Value: TCppParser);
begin
  if Value <> fParser then
  begin
    fParser := Value;
    UpdateView;
  end;
end;

procedure TClassBrowser.SetCurrentFile(Value: string);
begin
  fCurrentFile := Value;
//  if ShowFilter = sfCurrent then
    UpdateView;
end;

procedure TClassBrowser.SetShowFilter(const Value: TShowFilter);
begin
  fShowFilter := Value;
end;

//---------------------------Actions------------------------------------------------------------------------------------

procedure TClassBrowser.UpdateView;
var
  ClassIDs: TIntList;
begin
  if fParser = nil then
    Exit;

  Items.BeginUpdate;
  Items.Clear;

  ClassIDs := fParser.GetIdentifiersInScope(-1, False, False, '', [itClass, itStructure, itUnion]);
  AddMembers(nil, ClassIDs);
  ClassIDs.Free;

  Items.EndUpdate;
  Repaint;
end;

procedure TClassBrowser.AddMembers(Parent: TTreeNode; const Identifiers: TIntList);
var
  I: Integer;
  NewNode: TTreeNode;
  Identifier: TParseIdentifier;
begin
  for I := 0 to Identifiers.Count - 1 do
  begin
    Identifier := fParser.GetIdentifierDetails(Identifiers[I]);
    NewNode := Self.Items.AddChild(Parent, Identifier.Summary);
    NewNode.Data := Identifier;
    Self.Items.AddChild(NewNode, 'Expanding...');
    SetNodeImages(NewNode);
  end;
end;

procedure TClassBrowser.AddBaseClasses(Parent: TTreeNode; const Identifiers: TIntList);
var
  I: Integer;
  NewNode, ParentNode: TTreeNode;
  Identifier: TParseClassStructIdentifier;
begin
  //Create the inherited folder
  ParentNode := Self.Items.AddChild(Parent, 'Inherits');
  for I := 0 to Identifiers.Count - 1 do
  begin
    Identifier := TParseClassStructIdentifier(fParser.GetIdentifierDetails(Identifiers[I]));

    //Skip if the identifier is invalid
    if Identifier = nil then
      Continue;

    NewNode := Self.Items.AddChild(ParentNode, Identifier.Name);
    NewNode.Data := Identifier;
    Self.Items.AddChild(NewNode, 'Expanding...');
    SetNodeImages(NewNode);
  end;
end;

procedure TClassBrowser.SetNodeImages(Node: TTreeNode);
var
  Identifier: TParseIdentifier;
begin
  Identifier := TParseIdentifier(Node.Data);
  Node.ImageIndex := fImagesRecord.fGlobalsImg;

  if Identifier is TParseFunctionIdentifier then
  begin
    if Identifier.Scope <> -1 then
      case Identifier.AccessSpec of
        iaPublic:    Node.ImageIndex := fImagesRecord.MethodPublic;
        iaProtected: Node.ImageIndex := fImagesRecord.MethodProtected;
        iaPrivate:   Node.ImageIndex := fImagesRecord.MethodPrivate;
      end
    else
      Node.ImageIndex := fImagesRecord.fClassesImg;
  end
  else if Identifier is TParseVariableIdentifier then
    case Identifier.AccessSpec of
      iaPublic:    Node.ImageIndex := fImagesRecord.VariablePublic;
      iaProtected: Node.ImageIndex := fImagesRecord.VariableProtected;
      iaPrivate:   Node.ImageIndex := fImagesRecord.VariablePrivate;
    end
  else if Identifier is TParseClassStructIdentifier then
    Node.ImageIndex := fImagesRecord.fClassesImg;

  //Then apply the same image to the other states
  Node.SelectedIndex := Node.ImageIndex;
  Node.StateIndex := Node.ImageIndex;
end;

(*procedure TClassBrowser.OnNodeChanging(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Node: TTreeNode;
begin
  if htOnItem in GetHitTestInfoAt(X, Y) then
    Node := GetNodeAt(X, Y)
  else
    Node := nil;
  Selected := Node;
end;

procedure TClassBrowser.OnNodeChange(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Node: TTreeNode;
begin
  inherited;

  if htOnItem in GetHitTestInfoAt(X, Y) then
    Node := GetNodeAt(X, Y)
  else
    Node := nil;

  if not Assigned(Node) then
  begin
    fLastSelection := '';
    Exit;
  end
  else if not Assigned(Node.Data) then
  begin
    fLastSelection := '';
    Exit;
  end
  else if not fShowingSampleData and (fParser = nil) then
  begin
    Node.Data := nil;
    fLastSelection := '';
    Exit;
  end
{  else if not fShowingSampleData and (fParser.Statements.IndexOf(Node.Data) = -1) then
  begin
    Node.Data := nil;
    fLastSelection := '';
    Exit;
  end};

  if Node.ImageIndex = fImagesRecord.fGlobalsImg then begin
    fLastSelection := PFolders(Node.Data)^.Under;
    Exit;
  end;

{  with PStatement(Node.Data)^ do
  begin
    fLastSelection := ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText;

    if Assigned(fOnSelect) then
      if (Button = mbLeft) and not (ssShift in Shift) then // need implementation
        if _IsDeclaration then
          fOnSelect(Self, _DeclImplFileName, _DeclImplLine)
        else
          fOnSelect(Self, _FileName, _Line)
      else if (Button = mbLeft) and (ssShift in Shift) then // // need declaration
        if _IsDeclaration then
          fOnSelect(Self, _FileName, _Line)
        else
          fOnSelect(Self, _DeclImplFileName, _DeclImplLine);
  end;    }
end;

procedure TClassBrowser.ShowSampleData;
{  function CreateTempStatement(Full, Typ, Cmd, Args: string; K: TStatementKind; S: TStatementClassScope): PStatement;
  begin
    Result := New(PStatement);
    with Result^ do begin
      _FullText := Full;
      _Type := Typ;
      _ScopelessCmd := Cmd;
      _Command := _ScopelessCmd;
      _Args := Args;
      _Visible := True;
      _Valid := True;
      _Kind := K;
      _ClassScope := S;
    end;
  end;
var
  Node, SubNode: TTreeNode;
  Statement: PStatement;
begin
  fShowingSampleData := True;
  Items.Clear;
  with Items do begin
    Statement := CreateTempStatement('class Class1', 'class', 'Class1', '', skClass, scsNone);
    Node := AddChildObject(nil, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(Node, Statement);

    Statement := CreateTempStatement('Class1()', '', 'Class1', '', skConstructor, scsPublic);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);

    Statement := CreateTempStatement('~Class1()', '', '~Class1', '', skDestructor, scsPublic);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);

    Statement := CreateTempStatement('int private_Var1', 'int', 'private_Var1', '', skVariable, scsPrivate);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);

    Statement := CreateTempStatement('int private_Var2', 'int', 'private_Var2', '', skVariable, scsPrivate);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);

    Statement := CreateTempStatement('void protected_Func1(int x, int y)', 'void', 'protected_Func1', '(int x, int y)', skFunction, scsProtected);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);

    Statement := CreateTempStatement('double public_Var1', 'double', 'public_Var1', '', skVariable, scsPublic);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);

    Statement := CreateTempStatement('bool published_Func1(char* temp)', 'bool', 'published_Func1', '(char* temp)', skFunction, scsPublished);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);
    Expand(Node);

    Statement := CreateTempStatement('class Class2', 'class', 'Class2', '', skClass, scsNone);
    Node := AddChildObject(nil, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(Node, Statement);

    Statement := CreateTempStatement('Class2()', '', 'Class2', '', skConstructor, scsPublic);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);

    Statement := CreateTempStatement('~Class2()', '', '~Class2', '', skDestructor, scsPublic);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);

    Statement := CreateTempStatement('int private_Var1', 'int', 'private_Var1', '', skVariable, scsPrivate);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);

    Statement := CreateTempStatement('int private_Var2', 'int', 'private_Var2', '', skVariable, scsPrivate);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);

    Statement := CreateTempStatement('void protected_Func1(int x, int y)', 'void', 'protected_Func1', '(int x, int y)', skFunction, scsProtected);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);

    Statement := CreateTempStatement('double public_Var1', 'double', 'public_Var1', '', skVariable, scsPublic);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);

    Statement := CreateTempStatement('bool published_Func1(char* temp)', 'bool', 'published_Func1', '(char* temp)', skFunction, scsPublished);
    SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
    SetNodeImages(SubNode, Statement);
    Expand(Node);
  end;}begin
end;

procedure TClassBrowser.SetCurrentFile(Value: string);
begin
  if fShowFilter <> sfCurrent then
    Exit;
  fCurrentFile := Value;
  fCurrentFileHeader := ChangeFileExt(fCurrentFile, '.h');
  if not FileExists(fCurrentFileHeader) then
    fCurrentFileHeader := ChangeFileExt(fCurrentFile, '.hpp');
  if not FileExists(fCurrentFileHeader) then
    fCurrentFileHeader := ChangeFileExt(fCurrentFile, '.hh');
  fCurrentFileImpl := ChangeFileExt(fCurrentFile, '.c');
  if not FileExists(fCurrentFileImpl) then
    fCurrentFileImpl := ChangeFileExt(fCurrentFile, '.cpp');
  if not FileExists(fCurrentFileImpl) then
    fCurrentFileImpl := ChangeFileExt(fCurrentFile, '.cc');
  fCurrentFileHeader := LowerCase(fCurrentFileHeader);
  fCurrentFileImpl := LowerCase(fCurrentFileImpl);
  UpdateView;
end;

procedure TClassBrowser.SetShowFilter(const Value: TShowFilter);
begin
  if fShowFilter <> Value then begin
    fShowFilter := Value;
    UpdateView;
  end;
end;

procedure TClassBrowser.myDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Node: TTreeNode;
begin
  if htOnItem in GetHitTestInfoAt(X, Y) then
    Node := GetNodeAt(X, Y)
  else
    Node := nil;

  // if drag node is a folder
  if Selected.ImageIndex = fImagesRecord.fGlobalsImg then begin
    if Assigned(Selected.Data) then
      if Assigned(Node) then begin
        if Selected.ImageIndex <> fImagesRecord.fGlobalsImg then
{          with PStatement(Node.Data)^ do
            PFolders(Selected.Data)^.Under := ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText}
        else
          PFolders(Selected.Data)^.Under := #01#02 + Char(PFolders(Node.Data)^.Index);
      end
      else
        PFolders(Selected.Data)^.Under := '';
  end
  // drag node is statement
{  else with PStatement(Selected.Data)^ do begin // dragged node is Statement, so Node is folder
      RemoveFolderAssociation('', ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText);
      if Assigned(Node) then
        AddFolderAssociation(Node.Text, ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText);
    end};

  if Assigned(Selected) then
    Selected.MoveTo(Node, naAddChildFirst);

  Items.BeginUpdate;
  Sort;
  Items.EndUpdate;
  WriteClassFolders;
  Refresh;
end;

procedure TClassBrowser.myDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  Node: TTreeNode;
begin
  if htOnItem in GetHitTestInfoAt(X, Y) then
    Node := GetNodeAt(X, Y)
  else
    Node := nil;
  Accept := (Source is TClassBrowser) and
    (
    (
    // drag node is folder, drop node is not and drop node has children
    Assigned(Node) and (Selected.ImageIndex = fImagesRecord.fGlobalsImg) {and (Node.ImageIndex <> fImagesRecord.fGlobalsImg)} and Node.HasChildren
    ) or
    (
    // drag node is folder and drop node is folder
    Assigned(Node) and (Selected.ImageIndex = fImagesRecord.fGlobalsImg) and (Node.ImageIndex = fImagesRecord.fGlobalsImg)
    ) or
    (
    // drag node is not folder, drop node is folder
    Assigned(Node) and (Selected.ImageIndex <> fImagesRecord.fGlobalsImg) and (Node.ImageIndex = fImagesRecord.fGlobalsImg)
    ) or
    // not drop node
    not Assigned(Node)
    ) and
    (Node <> Selected);
end;*)

end.

