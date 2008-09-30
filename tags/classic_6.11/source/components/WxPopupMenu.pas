// $Id$
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


unit WxPopupMenu;

interface

uses
  Windows, Controls,Messages, SysUtils, Classes, WxNonVisibleBaseComponent,
  Wxutils, WxSizerPanel, Menus, WxCustomMenuItem, dbugintf, StrUtils, dialogs,
  Graphics;

type
  TWxPopupMenu = class(TWxNonVisibleBaseComponent, IWxComponentInterface,IWxMenuBarInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_Caption: string;
    FWx_PropertyList: TStringList;
    FWx_MenuItems: TWxCustomMenuItem;
    FWx_Comments: TStrings;

    procedure AutoInitialize;
    procedure AutoDestroy;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GenerateControlIDs: string;
    function GenerateEnumControlIDs: string;
    function GenerateEventTableEntries(CurrClassName: string): string;
    function GenerateGUIControlCreation: string;
    function GenerateXRCControlCreation(IndentString: string): TStringList;
    function GenerateGUIControlDeclaration: string;
    function GetMenuItemCode: string;
    function GetCodeForOneMenuItem(parentName: string; item: TWxCustomMenuItem): string;
    function GenerateHeaderInclude: string;
    function GenerateImageInclude: string;
    function GenerateImageList(var strLst:TStringList;var imgLst:TImageList;var strNameLst:TStringList): boolean;
    function GetEventList: TStringList;
    function GetIDName: string;
    function GetIDValue: longint;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    function GetMaxID: integer;
    procedure SetIDValue(IDValue: longint);
    procedure SetWxClassName(wxClassName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);
    function GenerateXPM(strFileName:String):boolean;
    
  published
    { Published declarations }
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_Caption: string Read FWx_Caption Write FWx_Caption;
    property Wx_MenuItems: TWxCustomMenuItem Read FWx_MenuItems Write FWx_MenuItems;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

  end;

procedure Register;

implementation

uses main;

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxPopupMenu]);
end;

procedure TWxPopupMenu.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class     := 'wxMenu';
  FWx_MenuItems := TWxCustomMenuItem.Create(self.Parent);
  FWx_Comments  := TStringList.Create;

  Glyph.Handle := LoadBitmap(hInstance, 'TWxPopupMenu');
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxPopupMenu.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_MenuItems.Destroy;
  FWx_Comments.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxPopupMenu.Create(AOwner: TComponent);
begin
  { Call the Create method of the container's parent class       }
  inherited Create(AOwner);
  { AutoInitialize method is generated by Component Create.      }
  AutoInitialize;
  { Code to perform other tasks when the component is created }
  FWx_PropertyList.add('wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Caption:Caption');
  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_MenuItems:Menu Items');
  FWx_PropertyList.add('Wx_Comments:Comments');
end;

destructor TWxPopupMenu.Destroy;
begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
  AutoDestroy;
  inherited Destroy;
end;

function TWxPopupMenu.GenerateEnumControlIDs: string;
var
  I:      integer;
  strF:   string;
  strLst: TStringList;

  procedure GetEnumControlIDFromSubMenu(idstrList: TStringList;
    submnu: TWxCustomMenuItem);
  var
    J: integer;
    strData: string;
  begin
    for J := 0 to submnu.Count - 1 do    // Iterate
    begin
      if not AnsiStartsStr('wxID', submnu.Items[J].Wx_IDName) then
      begin
        strData := submnu.Items[J].Wx_IDName;

        //Do we want to specify an ID?
        if submnu.Items[J].wx_IDValue <> -1 then
          strData := strData + ' = ' + IntToStr(submnu.Items[J].wx_IDValue);

        //Add the string
        idstrList.add(strData + ',');
      end;

      //Sub-sub menus
      if submnu.items[J].Count > 0 then
        GetEnumControlIDFromSubMenu(idstrList, submnu.items[J]);
    end;
  end;

begin
  Result := '';
  strLst := TStringList.Create;

  for I := 0 to Wx_MenuItems.Count - 1 do    // Iterate
  begin
    if not AnsiStartsStr('wxID', Wx_MenuItems.Items[i].Wx_IDName) then
    begin
      strF := Wx_MenuItems.Items[i].Wx_IDName;

      //Do we want to specify an ID?
      if Wx_MenuItems.Items[i].wx_IDValue <> -1 then
        strF := strF + ' = ' + IntToStr(Wx_MenuItems.Items[i].wx_IDValue);

      //Do we add?
      if trim(strF) <> '' then
        strLst.add(strF + ',');
    end;
    
    //Add the subitems
    if Wx_MenuItems.items[i].Count > 0 then
      GetEnumControlIDFromSubMenu(strLst, Wx_MenuItems.items[i]);
  end;
  Result := strLst.Text;
  strLst.Destroy;

end;

function TWxPopupMenu.GenerateControlIDs: string;
var
  I:      integer;
  strF:   string;
  strLst: TStringList;

  procedure GetControlIDFromSubMenu(idstrList: TStringList; submnu: TWxCustomMenuItem);
  var
    J: integer;
    strData: string;
  begin
    for J := 0 to submnu.Count - 1 do    // Iterate
    begin
      strData := '#define ' + submnu.Items[J].Wx_IDName + ' ' + IntToStr(
        submnu.Items[J].wx_IDValue) + ' ';
      idstrList.add(strData);

      if submnu.items[J].Count > 0 then
        GetControlIDFromSubMenu(idstrList, submnu.items[J]);
    end;    // for
  end;

begin

  Result := '';
  strLst := TStringList.Create;

  for I := 0 to Wx_MenuItems.Count - 1 do    // Iterate
  begin
    strF := '#define ' + Wx_MenuItems.Items[i].Wx_IDName + '  ' + IntToStr(
      Wx_MenuItems.Items[i].wx_IDValue) + ' ';
    if trim(strF) <> '' then
      strLst.add(strF);

    if Wx_MenuItems.items[i].Count > 0 then
      GetControlIDFromSubMenu(strLst, Wx_MenuItems.items[i])
  end;    // for
  Result := strLst.Text;
  strLst.Destroy;

end;

function TWxPopupMenu.GenerateEventTableEntries(CurrClassName: string): string;
var
  I:      integer;
  strLst: TStringList;

  procedure GenerateEventTableEntriesFromSubMenu(idstrList: TStringList;
    submnu: TWxCustomMenuItem);
  var
     J: integer;
  begin
    for J := 0 to submnu.Count - 1 do    // Iterate
      if submnu.items[J].Count > 0 then
        GenerateEventTableEntriesFromSubMenu(idstrList, submnu.items[J])
      else begin
        if trim(submnu.Items[j].EVT_Menu) <> '' then
          strLst.add('EVT_MENU(' + submnu.Items[j].Wx_IDName +
            ' , ' + CurrClassName + '::' + submnu.Items[j].EVT_Menu + ')');

        if trim(submnu.Items[j].EVT_UPDATE_UI) <> '' then
          strLst.add('EVT_UPDATE_UI(' + submnu.Items[j].Wx_IDName +
            ' , ' + CurrClassName + '::' + submnu.Items[j].EVT_UPDATE_UI + ')');
      end;    // for
  end;

begin

  Result := '';
  strLst := TStringList.Create;

  for I := 0 to Wx_MenuItems.Count - 1 do    // Iterate
    if Wx_MenuItems.items[i].Count > 0 then
      GenerateEventTableEntriesFromSubMenu(strLst, Wx_MenuItems.items[i])
    else begin
      if trim(Wx_MenuItems.Items[i].EVT_Menu) <> '' then
        strLst.add('EVT_MENU(' + Wx_MenuItems.Items[i].Wx_IDName +
          ' , ' + CurrClassName + '::' + Wx_MenuItems.Items[i].EVT_Menu + ')');

      if trim(Wx_MenuItems.Items[i].EVT_UPDATE_UI) <> '' then
        strLst.add('EVT_UPDATE_UI(' + Wx_MenuItems.Items[i].Wx_IDName +
          ' , ' + CurrClassName + '::' + Wx_MenuItems.Items[i].EVT_UPDATE_UI + ')');

    end;    // for
  Result := strLst.Text;
  strLst.Destroy;
end;

function TWxPopupMenu.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + '</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxPopupMenu.GenerateGUIControlCreation: string;
begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s);', [self.Name, self.Wx_Class, GetCppString(Wx_Caption)]);
  Result := Result + GetMenuItemCode;
end;

function TWxPopupMenu.GetCodeForOneMenuItem(parentName: string;
  item: TWxCustomMenuItem): string;
begin
  Result := '';
  if item.Count < 1 then
    if item.Wx_MenuItemStyle = wxMnuItm_Separator then
      Result := parentName + '->AppendSeparator();'
    else begin
      if item.WX_BITMAP.Bitmap.Handle <> 0 then
      begin
        Result := ' wxMenuItem * ' + item.Wx_IDName +
          '_mnuItem_obj = new wxMenuItem (' + Format('%s, %s, %s, %s, %s',
          [parentName, item.Wx_IDName, GetCppString(item.Wx_Caption), GetCppString(
          item.Wx_HelpText), GetMenuKindAsText(item.Wx_MenuItemStyle)]) + ');';
        Result := Result + #13 + #10 + 'wxBitmap ' + item.Wx_IDName +
          '_mnuItem_obj_BMP(' +
          item.Wx_IDName + '_XPM);';
        Result := Result + #13 + #10 + item.Wx_IDName + '_mnuItem_obj->SetBitmap(' +
          item.Wx_IDName + '_mnuItem_obj_BMP);';
        Result := Result + #13 + #10 + parentName + '->Append(' +
          item.Wx_IDName + '_mnuItem_obj);';
      end
      else
        Result := parentName + '->Append(' +
          Format('%s, %s, %s, %s', [item.Wx_IDName, GetCppString(item.Wx_Caption),
          GetCppString(item.Wx_HelpText),
          GetMenuKindAsText(item.Wx_MenuItemStyle)]) + ');';

    if ((item.Wx_MenuItemStyle = wxMnuItm_Radio) or (item.Wx_MenuItemStyle = wxMnuItm_Check)) then
    begin
      if item.Wx_Checked then
        Result := Result + #13 + #10 + parentName + '->Check(' + item.Wx_IDName + ',true);' 
      else
        Result := Result + #13 + #10 + parentName + '->Check(' + item.Wx_IDName + ',false);';
    end;

      if not item.Wx_Enabled then
        Result := Result + #13 + #10 + parentName + '->Enable(' +
          item.Wx_IDName + ',false);';
    end;
end;

function TWxPopupMenu.GetMenuItemCode: string;
var
  I:      integer;
  strF:   string;
  strLst: TStringList;

  procedure GetCodeFromSubMenu(submnustrlst: TStringList; submnu: TWxCustomMenuItem);
  var
    J: integer;
    parentItemName, strV: string;
  begin
    strV   := 'wxMenu *' + submnu.wx_IDName + '_Obj = new wxMenu();';
    parentItemName := submnu.wx_IDName + '_Obj';
    submnustrlst.add(strV);

    for J := 0 to submnu.Count - 1 do    // Iterate
      if submnu.items[J].Count > 0 then
      begin
        submnustrlst.Add('');
        GetCodeFromSubMenu(submnustrlst, submnu.items[J]);
        strV := parentItemName + '->Append(' + format(
          '%s, %s, %s', [submnu.items[J].Wx_IDNAME,
          GetCppString(submnu.items[J].Wx_Caption),
          submnu.items[J].Wx_IDName + '_Obj']) + ');';
        strLst.add(strV);
      end
      else begin
        strV := GetCodeForOneMenuItem(parentItemName, submnu.items[J]);
        if trim(strV) <> '' then
        begin
          strLst.add(strV);
        end;
      end;    // for
  end;

begin
  strLst := TStringList.Create;
  for I := 0 to Wx_MenuItems.Count - 1 do    // Iterate
    if Wx_MenuItems.items[i].Count > 0 then
    begin
      GetCodeFromSubMenu(strLst, Wx_MenuItems.items[i]);
      strLst.add(self.Name + '->Append(' + Wx_MenuItems.items[i].Wx_IDName +
        ', ' + GetCppString(Wx_MenuItems.items[i].Wx_Caption) + ', ' +
        Wx_MenuItems.items[i].Wx_IDName + '_Obj' + ');');
    end
    else begin
      strF := GetCodeForOneMenuItem(self.Name, Wx_MenuItems.Items[i]);
      if trim(strF) <> '' then
      begin
        strLst.add(strF);
      end;
    end;    // for

  //Send the result back
  Result := trim(strLst.Text); //remove the trailing newline
  strLst.Destroy;
end;

function TWxPopupMenu.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxPopupMenu.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/menu.h>';
end;


function TWxPopupMenu.GenerateImageInclude: string;
var
    strLst,strNameList: TStringList;
    imgLst:TImageList;
    i:Integer;
begin
  Result:='';
  strLst:= TStringList.Create;
  strNameList:= TStringList.Create;
  imgLst:=TImageList.Create(nil);
  GenerateImageList(strLst,imgLst,strNameList);

  for i:= 0 to strLst.Count -1 do
  begin
    strLst[i] :=  '#include "'+ strLst[i] + '"';
  end;

  Result:=strLst.Text;
  strLst.destroy;
  strNameList.destroy;
  imgLst.destroy;
end;

function TWxPopupMenu.GenerateImageList(var strLst:TStringList;var imgLst:TImageList;var strNameLst:TStringList): boolean;
var
  I:      integer;
  strF:   string;
  procedure GetImageIncludeFromSubMenu(idstrList: TStringList;imgLstX:TImageList;strNameLstX:TStringList;
    submnu: TWxCustomMenuItem);
  var
    J: integer;
    strData: string;
  begin
    for J := 0 to submnu.Count - 1 do    // Iterate
    begin
      if submnu.Items[J].WX_BITMAP.Bitmap.Handle <> 0 then
        strData := 'Images/' + GetDesignerFormName(self)+'_'+submnu.Items[J].Wx_IDName + '_XPM.xpm'
      else
        strData := '';
      if strData <> '' then
      begin
        idstrList.add(strData);
        strNameLstX.Add(submnu.Items[J].Wx_IDName);
        imgLstX.Add(submnu.Items[J].WX_BITMAP.Bitmap,nil);
      end;

      if submnu.items[J].Count > 0 then
        GetImageIncludeFromSubMenu(idstrList, imgLstX,strNameLstX,submnu.items[J]);
    end;    // for
  end;

begin

  Result := true;

  for I := 0 to Wx_MenuItems.Count - 1 do    // Iterate
  begin
    if Wx_MenuItems.Items[i].wx_Bitmap.Bitmap.Handle <> 0 then
      strF := 'Images/' + GetDesignerFormName(self)+'_'+Wx_MenuItems.Items[i].Wx_IDName + '_XPM.xpm'
    else
      strF := '';
    if trim(strF) <> '' then
    begin
      strLst.add(strF);
      imgLst.Add(Wx_MenuItems.Items[i].wx_Bitmap.Bitmap,nil);
      strNameLst.Add(Wx_MenuItems.Items[i].Wx_IDName);
    end;

    if Wx_MenuItems.items[i].Count > 0 then
      GetImageIncludeFromSubMenu(strLst, imgLst,strNameLst,Wx_MenuItems.items[i])
  end;    // for

end;

function TWxPopupMenu.GetEventList: TStringList;
begin
  Result := nil;
end;

function TWxPopupMenu.GetIDName: string;
begin
  Result := '';
end;

function TWxPopupMenu.GetIDValue: longint;
begin
  Result := GetMaxID;
end;

function TWxPopupMenu.GetParameterFromEventName(EventName: string): string;
begin

end;

function TWxPopupMenu.GetStretchFactor: integer;
begin
   Result := 1;
end;

function TWxPopupMenu.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxPopupMenu.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxPopupMenu.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxPopupMenu.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxPopupMenu.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxPopupMenu.SetBorderWidth(width: integer);
begin
end;

function TWxPopupMenu.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxMenu';
  Result := wx_Class;
end;

procedure TWxPopupMenu.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin

end;

function TWxPopupMenu.GetMaxID: integer;
var
  I: integer;
  retValue: integer;

  function GetMaxIDFromSubMenu(submnu: TWxCustomMenuItem): integer;
  var
    myretValue: integer;
    J: integer;
  begin
    Result := submnu.Wx_IDValue;
    for J := 0 to submnu.Count - 1 do    // Iterate
    begin
      if submnu.items[J].Wx_IDValue > Result then
        Result := submnu.items[J].Wx_IDValue;
      if submnu.items[J].Count > 0 then
      begin
        myretValue := GetMaxIDFromSubMenu(submnu.items[J]);
        if myretValue > Result then
          Result := myretValue;
      end;
    end;    // for
  end;

begin
  Result := Wx_MenuItems.Wx_IDValue;
  for I := 0 to Wx_MenuItems.Count - 1 do    // Iterate
  begin
    if Wx_MenuItems.items[i].Wx_IDValue > Result then
      Result := Wx_MenuItems.items[i].Wx_IDValue;
    if Wx_MenuItems.items[i].Count > 0 then
    begin
      retValue := GetMaxIDFromSubMenu(Wx_MenuItems.items[i]);
      if retValue > Result then
        Result := retValue;
    end;
  end;    // for
end;


procedure TWxPopupMenu.SetIDName(IDName: string);
begin

end;

procedure TWxPopupMenu.SetIDValue(IDValue: longint);
begin

end;

procedure TWxPopupMenu.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxPopupMenu.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxPopupMenu.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxPopupMenu.SetGenericColor(strVariableName,strValue: string);
begin

end;


function TWxPopupMenu.GetFGColor: string;
begin

end;

procedure TWxPopupMenu.SetFGColor(strValue: string);
begin
end;

function TWxPopupMenu.GetBGColor: string;
begin
end;

procedure TWxPopupMenu.SetBGColor(strValue: string);
begin
end;

procedure TWxPopupMenu.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxPopupMenu.SetProxyBGColorString(Value: string);
begin
end;

function TWxPopupMenu.GenerateXPM(strFileName:String):boolean;
var
    strLst,strNameList: TStringList;
    imgLst:TImageList;
    strXPMFileName,strFormName:String;
    bmpX:TBitmap;
    i:Integer;
begin
  Result:=false;
  strLst:= TStringList.Create;
  strNameList:= TStringList.Create;
  imgLst:=TImageList.Create(nil);

  GenerateImageList(strLst,imgLst,strNameList);
  strFormName:=GetDesignerFormName(self);

  for i:= 0 to strLst.Count -1 do
  begin
      strXPMFileName:=UnixPathToDosPath(IncludeTrailingPathDelimiter(ExtractFilePath(strFileName))+strLst[i]);
      if FileExists(strXPMFileName) then
        continue;
      bmpX := TBitmap.Create;
      imgLst.GetBitmap(i,bmpX);
      if bmpX.handle  <> 0 then
        GenerateXPMDirectly(bmpX,strNameList[i],strFormName,strFileName);
      bmpX.Destroy;
  end;
  strLst.destroy;
  strNameList.destroy;
end;

end.