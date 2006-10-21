{
wxDialog Designer
Copyright (c) 2003 Guru Kathiresan grk4352@njit.edu
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. The name of the author may not be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}

unit Designerfrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, DbugIntf,
  WxEdit, WxStaticText, WxButton, wxUtils, WXRadioButton, WXCheckBox,
    Wxcombobox,WxToolButton,WxSeparator,
  WxListbox, WxGauge, wxListCtrl, wxTreeCtrl, WxMemo, wxScrollbar, wxSpinButton,
  WxSizerPanel,ComCtrls, SynEdit, Menus;

type

  TfrmNewForm = class(TForm, IWxComponentInterface)
    procedure CreateInitVars;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure NewFormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FWxFrm_IDName: string;
    FWxFrm_IDValue: LongInt;
    FWxFrm_Class: string;
    FWxFrm_Center: Boolean;
    FWxFrm_ToolTips: string;
    FWxFrm_Hidden: Boolean;
    FWxFrm_GeneralStyle: TWxStdStyleSet;
    FWxFrm_DialogStyle: TWxDlgStyleSet;
    fsynEdit: TSynEdit;

    FEVT_CHAR,
    FEVT_KEY_UP,
    FEVT_KEY_DOWN,
    FEVT_ERASE_BACKGROUND,
    FEVT_SIZE,
    FEVT_SET_FOCUS,
    FEVT_KILL_FOCUS,
    FEVT_ENTER_WINDOW,
    FEVT_LEAVE_WINDOW,
    FEVT_MOTION,
    FEVT_LEFT_DOWN,
    FEVT_LEFT_UP,
    FEVT_RIGHT_DOWN,
    FEVT_RIGHT_UP,
    FEVT_MIDDLE_DOWN,
    FEVT_MIDDLE_UP,
    FEVT_LEFT_DCLICK,
    FEVT_RIGHT_DCLICK,
    FEVT_MIDDLE_DCLICK,
    FEVT_PAINT,
    FEVT_INIT_DIALOG,
    FEVT_SCROLLWIN,
    FEVT_SCROLLWIN_TOP,
    FEVT_SCROLLWIN_BOTTOM,
    FEVT_SCROLLWIN_LINEUP,
    FEVT_SCROLLWIN_LINEDOWN,
    FEVT_SCROLLWIN_PAGEUP,
    FEVT_SCROLLWIN_PAGEDOWN,
    FEVT_SCROLLWIN_THUMBTRACK,
    FEVT_SCROLLWIN_THUMBRELEASE,
    FEVT_SYS_COLOUR_CHANGED,
    FEVT_UPDATE_UI,
    FEVT_CLOSE: string;
    FEVT_IDLE,
    FEVT_ACTIVATE,
    FEVT_ACTIVATE_APP,
    FEVT_QUERY_END_SESSION,
    FEVT_END_SESSION,
    FEVT_DROP_FILES,
    FEVT_SPLITTER_SASH_POS_CHANGED,
    FEVT_SPLITTER_UNSPLIT,
    FEVT_SPLITTER_DCLICK,
    FEVT_JOY_BUTTON_DOWN,
    FEVT_JOY_BUTTON_UP,
    FEVT_JOY_MOVE,
    FEVT_JOY_ZMOVE,
    FEVT_MENU_OPEN,
    FEVT_MENU_CLOSE,
    FEVT_MENU_HIGHLIGHT_ALL,
    FEVT_MOUSEWHEEL,
    FEVT_MOUSE_EVENTS: string;

    FWx_Name: string;
    FWx_ICON:TPicture;
    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor : Integer;
    { Storage for property Wx_ProxyBGColorString }
    FWx_ProxyBGColorString : TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
    FWx_ProxyFGColorString : TWxColorString;
    FWxDesignerType:TWxDesignerType;
    
    procedure SetDesignerType(value:TWxDesignerType);
    
  published
    property Wx_ICON: TPicture
      read FWx_ICON write FWx_ICON;

    property Wx_Name: string
      read FWx_Name write FWx_Name;

    property Wx_IDName: string
      read FWxFrm_IDName write FWxFrm_IDName;

    property Wx_IDValue: LongInt
      read FWxFrm_IDValue write FWxFrm_IDValue;

    property Wx_Class: string
      read FWxFrm_Class write FWxFrm_Class;

    property Wx_Center: Boolean
      read FWxFrm_Center write FWxFrm_Center;

    property Wx_Hidden: Boolean
      read FWxFrm_Hidden write FWxFrm_Hidden;

    property Wx_ToolTips: string
      read FWxFrm_ToolTips write FWxFrm_ToolTips;

    property Wx_GeneralStyle: TWxStdStyleSet
      read FWxFrm_GeneralStyle write FWxFrm_GeneralStyle;

    property Wx_DialogStyle: TWxDlgStyleSet
      read FWxFrm_DialogStyle write FWxFrm_DialogStyle;

    property Wx_StretchFactor : Integer
        read FWx_StretchFactor write FWx_StretchFactor
        default 0;

    property Wx_ProxyBGColorString : TWxColorString
        read FWx_ProxyBGColorString write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString : TWxColorString
        read FWx_ProxyFGColorString write FWx_ProxyFGColorString;

    property Wx_DesignerType : TWxDesignerType
        read FWxDesignerType write SetDesignerType default dtWxDialog;

    property EVT_CHAR: string
      read FEVT_CHAR write FEVT_CHAR;

    property EVT_KEY_UP: string
      read FEVT_KEY_UP write FEVT_KEY_UP;

    property EVT_KEY_DOWN: string
      read FEVT_KEY_DOWN write FEVT_KEY_DOWN;

    property EVT_ERASE_BACKGROUND: string
      read FEVT_ERASE_BACKGROUND write FEVT_ERASE_BACKGROUND;

    property EVT_SIZE: string
      read FEVT_SIZE write FEVT_SIZE;

    property EVT_SET_FOCUS: string
      read FEVT_SET_FOCUS write FEVT_SET_FOCUS;

    property EVT_KILL_FOCUS: string
      read FEVT_KILL_FOCUS write FEVT_KILL_FOCUS;

    property EVT_ENTER_WINDOW: string
      read FEVT_ENTER_WINDOW write FEVT_ENTER_WINDOW;

    property EVT_LEAVE_WINDOW: string
      read FEVT_LEAVE_WINDOW write FEVT_LEAVE_WINDOW;

    property EVT_MOTION: string
      read FEVT_MOTION write FEVT_MOTION;

    property EVT_LEFT_DOWN: string
      read FEVT_LEFT_DOWN write FEVT_LEFT_DOWN;

    property EVT_LEFT_UP: string
      read FEVT_LEFT_UP write FEVT_LEFT_UP;

    property EVT_RIGHT_DOWN: string
      read FEVT_RIGHT_DOWN write FEVT_RIGHT_DOWN;

    property EVT_RIGHT_UP: string
      read FEVT_RIGHT_UP write FEVT_RIGHT_UP;

    property EVT_MIDDLE_DOWN: string
      read FEVT_MIDDLE_DOWN write FEVT_MIDDLE_DOWN;

    property EVT_MIDDLE_UP: string
      read FEVT_MIDDLE_UP write FEVT_MIDDLE_UP;

    property EVT_LEFT_DCLICK: string
      read FEVT_LEFT_DCLICK write FEVT_LEFT_DCLICK;

    property EVT_RIGHT_DCLICK: string
      read FEVT_RIGHT_DCLICK write FEVT_RIGHT_DCLICK;

    property EVT_MIDDLE_DCLICK: string
      read FEVT_MIDDLE_DCLICK write FEVT_MIDDLE_DCLICK;

    property EVT_PAINT: string
      read FEVT_PAINT write FEVT_PAINT;

    property EVT_INIT_DIALOG: string
      read FEVT_INIT_DIALOG write FEVT_INIT_DIALOG;

    property EVT_SCROLLWIN: string
      read FEVT_SCROLLWIN write FEVT_SCROLLWIN;

    property EVT_SCROLLWIN_TOP: string
      read FEVT_SCROLLWIN_TOP write FEVT_SCROLLWIN_TOP;

    property EVT_SCROLLWIN_BOTTOM: string
      read FEVT_SCROLLWIN_BOTTOM write FEVT_SCROLLWIN_BOTTOM;

    property EVT_SCROLLWIN_LINEUP: string
      read FEVT_SCROLLWIN_LINEUP write FEVT_SCROLLWIN_LINEUP;

    property EVT_SCROLLWIN_LINEDOWN: string
      read FEVT_SCROLLWIN_LINEDOWN write FEVT_SCROLLWIN_LINEDOWN;

    property EVT_SCROLLWIN_PAGEUP: string
      read FEVT_SCROLLWIN_PAGEUP write FEVT_SCROLLWIN_PAGEUP;

    property EVT_SCROLLWIN_PAGEDOWN: string
      read FEVT_SCROLLWIN_PAGEDOWN write FEVT_SCROLLWIN_PAGEDOWN;

    property EVT_SCROLLWIN_THUMBTRACK: string
      read FEVT_SCROLLWIN_THUMBTRACK write FEVT_SCROLLWIN_THUMBTRACK;

    property EVT_SCROLLWIN_THUMBRELEASE: string
      read FEVT_SCROLLWIN_THUMBRELEASE write FEVT_SCROLLWIN_THUMBRELEASE;

    property EVT_SYS_COLOUR_CHANGED: string
      read FEVT_SYS_COLOUR_CHANGED write FEVT_SYS_COLOUR_CHANGED;

    property EVT_UPDATE_UI: string
      read FEVT_UPDATE_UI write FEVT_UPDATE_UI;

    property EVT_CLOSE: string
      read FEVT_CLOSE write FEVT_CLOSE;

    property EVT_IDLE :string read FEVT_IDLE write FEVT_IDLE;
    property EVT_ACTIVATE :string read FEVT_ACTIVATE write FEVT_ACTIVATE;
    property EVT_ACTIVATE_APP :string read FEVT_ACTIVATE_APP write FEVT_ACTIVATE_APP ;
    property EVT_QUERY_END_SESSION :string read FEVT_QUERY_END_SESSION write FEVT_QUERY_END_SESSION;
    property EVT_END_SESSION :string read FEVT_END_SESSION write FEVT_END_SESSION;
    property EVT_DROP_FILES :string read FEVT_DROP_FILES write FEVT_DROP_FILES;
    property EVT_SPLITTER_SASH_POS_CHANGED  :string read FEVT_SPLITTER_SASH_POS_CHANGED write FEVT_SPLITTER_SASH_POS_CHANGED;
    property EVT_SPLITTER_UNSPLIT :string read FEVT_SPLITTER_UNSPLIT write FEVT_SPLITTER_UNSPLIT;
    property EVT_SPLITTER_DCLICK :string read FEVT_SPLITTER_DCLICK write FEVT_SPLITTER_DCLICK ;
    property EVT_JOY_BUTTON_DOWN :string read FEVT_JOY_BUTTON_DOWN write FEVT_JOY_BUTTON_DOWN;
    property EVT_JOY_BUTTON_UP :string read FEVT_JOY_BUTTON_UP write FEVT_JOY_BUTTON_UP;
    property EVT_JOY_MOVE :string read FEVT_JOY_MOVE write FEVT_JOY_MOVE;
    property EVT_JOY_ZMOVE :string read FEVT_JOY_ZMOVE write FEVT_JOY_ZMOVE;
    property EVT_MENU_OPEN :string read FEVT_MENU_OPEN write FEVT_MENU_OPEN;
    property EVT_MENU_CLOSE :string read FEVT_MENU_CLOSE write FEVT_MENU_CLOSE;
    property EVT_MENU_HIGHLIGHT_ALL :string read FEVT_MENU_HIGHLIGHT_ALL write FEVT_MENU_HIGHLIGHT_ALL;
    property EVT_MOUSEWHEEL :string read FEVT_MOUSEWHEEL write FEVT_MOUSEWHEEL;
    property EVT_MOUSE_EVENTS :string read FEVT_MOUSE_EVENTS write FEVT_MOUSE_EVENTS;

  public
    { Public declarations }
        //intControlMaxValue:Integer;
    wx_PropertyList: TStringList;
    FWx_EventList: TStringList;
    function GenerateControlIDs: string;
    function GenerateEventTableEntries(CurrClassName: string): string;
    //function GenerateExtraCodeForFrame:string;
    function GenerateGUIControlCreation: string;
    function GenerateGUIControlDeclaration: string;
    function GenerateHeaderInclude: string;
    function GenerateImageInclude: string;
    function GetIDName: string;
    function GetIDValue: LongInt;
    function GetPropertyList: TStringList;
    function GetWxClassName: string;
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: longInt);
    procedure SetWxClassName(wxClassName: string);
    procedure FormMove(var Msg: TWMMove); message WM_MOVE;
    function GetDialogStyleString: string;
    function GetEventList: TStringlist;
    function GetParameterFromEventName(EventName: string): string;
    function GetTypeFromEventName(EventName: string): string;
    procedure SaveControlOrientation(ControlOrientation:TWxControlOrientation);
    function GetStretchFactor:Integer;
    procedure SetStretchFactor(intValue:Integer);
    function GetFGColor:string;
    procedure SetFGColor(strValue:String);
    function GetBGColor:string;
    procedure SetBGColor(strValue:String);

    property synEdit: TSynEdit read fsynEdit write fsynEdit;
    
  end;

var
  frmNewFormX: TfrmNewForm;

procedure GenerateCpp(frmNewForm: TfrmNewForm; strClassName: string; synEdit:TSynEdit;strFileName:String);
procedure GenerateHpp(frmNewForm: TfrmNewForm; strClassName: string; synEdit:TSynEdit);
procedure GenerateXPM(frmNewForm: TfrmNewForm; strFileName:String;onlyForForm:Boolean = false);

implementation

uses dmCodeGen, main,WxStaticBitmap;

{$R *.DFM}

procedure GenerateCpp(frmNewForm: TfrmNewForm; strClassName: string; synEdit:TSynEdit;strFileName:String);
var
  i: Integer;
  intBlockStart, intBlockEnd: Integer;
  intManualBlockStart, intManualBlockEnd: Integer;
  wxcompInterface: IWxComponentInterface;
  strEntry,strEventTableStart,strEventTableEnd: string;
  isSizerAvailable:Boolean;
  strHdrValue:String;
  strStartStr,strEndStr:String;
  strLst,strlstManualCode : TStringList;
  CntIntf:IWxContainerAndSizerInterface;
  strTemp:String;

begin
  if GetBlockStartAndEndPos(synEdit, strClassName, btClassNameGUIItemsCreation,intBlockStart, intBlockEnd) then
  begin
    //Clear Declaration and Creation Field
    DeleteAllClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart,intBlockEnd);

//    if frmNewForm.Wx_DesignerType = dtWxFrame then
//        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart,intBlockEnd, frmNewForm.GenerateExtraCodeForFrame);

    
    isSizerAvailable:=false;
    for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
    begin
        if frmNewForm.Components[i].GetInterface(IID_IWxContainerAndSizerInterface,CntIntf) then
        //if frmNewForm.Components[i] is TWxSizerPanel then
        begin
            isSizerAvailable:=true;
            break;
        end;
    end;

    if isSizerAvailable then
    begin
        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart,intBlockEnd, frmNewForm.GenerateGUIControlCreation);
    end;

    if not isSizerAvailable then
    begin
        for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
        begin
            if frmNewForm.Components[i].GetInterface(IID_IWxContainerAndSizerInterface,CntIntf) then
                continue;
            if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,wxcompInterface) then
            begin
                AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart,intBlockEnd, wxcompInterface.GenerateGUIControlCreation);
            end;
            AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart,intBlockEnd, '');
        end; // for
    End
    Else
    Begin
        for I :=  frmNewForm.ComponentCount - 1  downto 0 do // Iterate
        begin
//            if frmNewForm.Components[i] is TPanel then
//                continue;
            if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
            begin
                strTemp:=wxcompInterface.GenerateGUIControlCreation;
                AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, wxcompInterface.GenerateGUIControlCreation);
            end;
            AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart,intBlockEnd, '');
        end; // for
    End;

    //Form data should come first, if not the child will be resized to
    if not isSizerAvailable then
    begin
        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart,intBlockEnd, frmNewForm.GenerateGUIControlCreation);
    end;

  end;




  // Event
  if GetBlockStartAndEndPos(synEdit, strClassName, btClassNameEventTableEntries,intBlockStart, intBlockEnd) then
  begin
    GetStartAndEndBlockStrings('',btManualCode,strStartStr,strEndStr);
    strlstManualCode:=TStringList.Create;
    if GetBlockStartAndEndPos(synEdit, strClassName, btManualCode,intManualBlockStart, intManualBlockEnd) then
    begin
        strlstManualCode := GetBlockCode(synEdit, strClassName, btManualCode,intManualBlockStart,intManualBlockEnd);
    end;

    DeleteAllClassNameEventTableEntries(synEdit, strClassName, intBlockStart,intBlockEnd);

    strEventTableEnd:='END_EVENT_TABLE()';
    AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart,intBlockEnd, strEventTableEnd,false);


    //EVT_CLOSE(%CLASS_NAME%:: OnQuit )
    for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
    begin
      wxcompInterface := nil;
      if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
      begin
        strEntry := wxcompInterface.GenerateEventTableEntries(strClassName);
        //SendDebug(strEntry);
        AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart,intBlockEnd, strEntry);
      end;
      //AddClassNameEventTableEntries(strCppSrc, strClassName, intBlockStart, intBlockEnd, '');
    end; // for
    //Form data should come first, if not the child will be resized to
    strEntry := frmNewForm.GenerateEventTableEntries(strClassName);
    //SendDebug(strEntry);
    AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart,intBlockEnd, strEntry);

     //Manual Code Clear Declaration and Creation Field

    AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart,intBlockEnd, strEndStr);
    for I := strlstManualCode.Count - 1 downto 0 do    // Iterate
    begin
        AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart,intBlockEnd, strlstManualCode[i]);
    end;    // for
    strlstManualCode.destroy;
    AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart,intBlockEnd, strStartStr);


    strEventTableStart:=Format('BEGIN_EVENT_TABLE(%s,%s)',[frmNewForm.Wx_Name,frmNewForm.Wx_Class] );
    AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart,intBlockEnd, strEventTableStart,false);
  end;

  //Adding XPM Header files
  //A stupid way to find
  if GetBlockStartAndEndPos(synEdit, strClassName, btHeaderIncludes,intBlockStart, intBlockEnd) then
  begin
    //Clear Declaration and Creation Field
    DeleteAllClassNameIncludeHeader(synEdit, strClassName, intBlockStart,intBlockEnd);
    strHdrValue:='';
    strLst := TStringList.Create;
    for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
    begin
      if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,wxcompInterface) then
      begin
        strHdrValue := wxcompInterface.GenerateImageInclude;
        if strLst.indexOf(strHdrValue) = -1 then
        begin
          strLst.add(strHdrValue);
          AddClassNameIncludeHeader(synEdit, strClassName, intBlockStart,intBlockEnd, strHdrValue);
        end;
      end;
    end;

    strHdrValue := trim(frmNewForm.GenerateImageInclude);
    if strHdrValue <> '' then
    begin
        if strLst.indexOf(strHdrValue) = -1 then
        begin
            strLst.add(strHdrValue);
            AddClassNameIncludeHeader(synEdit, strClassName, intBlockStart,intBlockEnd, strHdrValue);
        end;
    end;
    
    strLst.destroy;
  end;


end;

procedure GenerateHpp(frmNewForm: TfrmNewForm; strClassName: string; synEdit:
  TSynEdit);
var
  i: Integer;
  intBlockStart, intBlockEnd: Integer;
  wxcompInterface: IWxComponentInterface;
  strLst: TStringList;
  strHdrValue, strIDValue: string;
begin
  if GetBlockStartAndEndPos(synEdit, strClassName,
    btClassNameGUIItemsDeclaration, intBlockStart, intBlockEnd) then
  begin
    //Clear Declaration and Creation Field
    DeleteAllClassNameGUIItemsDeclaration(synEdit, strClassName, intBlockStart,
      intBlockEnd);
    for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
    begin
      if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,
        wxcompInterface) then
      begin
        AddClassNameGUIItemsDeclaration(synEdit, strClassName, intBlockStart,
          intBlockEnd, wxcompInterface.GenerateGUIControlDeclaration());
      end;
    end;
  end;

  if GetBlockStartAndEndPos(synEdit, strClassName,
    btClassNameControlIdentifiers, intBlockStart, intBlockEnd) then
  begin
    //Clear Declaration and Creation Field
    DeleteAllClassNameControlIndentifiers(synEdit, strClassName, intBlockStart,
      intBlockEnd);
    strLst := TStringList.Create;
    for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
    begin
      if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,wxcompInterface) then
      begin
        strIDValue := wxcompInterface.GenerateControlIDs;
        if trim(strIDValue) <> '' then
        begin
          if strLst.indexOf(strIDValue) = -1 then
          begin
            strLst.Add(strIDValue);
            AddClassNameControlIndentifiers(synEdit, strClassName,
              intBlockStart, intBlockEnd, strIDValue);
          end;
        end;
      end;
    end;
    strLst.destroy;
  end;

  if GetBlockStartAndEndPos(synEdit, strClassName, btDialogStyle, intBlockStart,
    intBlockEnd) then
  begin
    //Clear Declaration and Creation Field
    DeleteAllDialogStyleDeclaration(synEdit, strClassName, intBlockStart,
      intBlockEnd);
    AddDialogStyleDeclaration(synEdit, strClassName, intBlockStart, intBlockEnd,
      frmNewForm.GetDialogStyleString);
  end;

  if GetBlockStartAndEndPos(synEdit, strClassName, btHeaderIncludes,
    intBlockStart, intBlockEnd) then
  begin
    //Clear Declaration and Creation Field
    DeleteAllClassNameIncludeHeader(synEdit, strClassName, intBlockStart,
      intBlockEnd);
    strLst := TStringList.Create;
    for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
    begin
      if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,wxcompInterface) then
      begin
        strHdrValue := wxcompInterface.GenerateHeaderInclude;
        if strLst.indexOf(strHdrValue) = -1 then
        begin
          strLst.add(strHdrValue);
          AddClassNameIncludeHeader(synEdit, strClassName, intBlockStart,intBlockEnd, strHdrValue);
        end;
      end;
    end;
    strLst.destroy;
  end;

end;


procedure GenerateXPM(frmNewForm: TfrmNewForm; strFileName:String;onlyForForm:Boolean);
var
  I: Integer;
  xpmFileDir:String;
  fileStrlst:TStringList;
  strXPMContent:String;

begin
    xpmFileDir:=IncludetrailingBackslash(ExtractFileDir(strFileName));

    if frmNewForm.Wx_ICON.Bitmap.handle <> 0 then
    begin
        if onlyForForm then
            DeleteFile(xpmFileDir+frmNewForm.Wx_Name+'_XPM.xpm');
            
        if not fileexists(xpmFileDir+frmNewForm.Wx_Name+'_XPM.xpm') then
        begin
            try
                fileStrlst:=TStringList.Create;
                strXPMContent:=GetXPMFromTPicture(frmNewForm.Wx_Name,frmNewForm.Wx_ICON.Bitmap);
                if trim(strXPMContent) <> '' then
                begin
                    fileStrlst.Add(strXPMContent);
                    fileStrlst.SaveToFile(xpmFileDir+frmNewForm.Wx_Name+'_XPM.xpm');
                end;
            except
            end;
            fileStrlst.destroy;
        end;
    end;

    if onlyForForm = true then
        exit;

    for I := 0 to frmNewForm.ComponentCount - 1 do    // Iterate
    begin
        if frmNewForm.Components[I] is TWxStaticBitmap then
        begin
            if TWxStaticBitmap(frmNewForm.Components[I]).Picture.Bitmap.handle = 0 then
                continue;
            if not fileexists(xpmFileDir+frmNewForm.Components[I].Name+'_XPM.xpm') then
            begin
                try
                    fileStrlst:=TStringList.Create;
                    strXPMContent:=GetXPMFromTPicture(frmNewForm.Components[I].Name,TWxStaticBitmap(frmNewForm.Components[I]).Picture.Bitmap);
                    if trim(strXPMContent) = '' then
                        continue;
                    fileStrlst.Add(strXPMContent);
                    fileStrlst.SaveToFile(xpmFileDir+frmNewForm.Components[I].Name+'_XPM.xpm');
                except
                end;
                fileStrlst.destroy;
            end;
        end;    // for

        if frmNewForm.Components[I] is TWxToolButton then
        begin
            if TWxToolButton(frmNewForm.Components[I]).Wx_Bitmap.Bitmap.handle = 0 then
                continue;
            if not fileexists(xpmFileDir+frmNewForm.Components[I].Name+'_XPM.xpm') then
            begin
                try
                    fileStrlst:=TStringList.Create;
                    strXPMContent:=GetXPMFromTPicture(frmNewForm.Components[I].Name,TWxToolButton(frmNewForm.Components[I]).Wx_Bitmap.Bitmap);
                    if trim(strXPMContent) = '' then
                        continue;
                    fileStrlst.Add(strXPMContent);
                    fileStrlst.SaveToFile(xpmFileDir+frmNewForm.Components[I].Name+'_XPM.xpm');
                except
                end;
                fileStrlst.destroy;
            end;
        end;    // for

    end;
end;

function TfrmNewForm.GetParameterFromEventName(EventName: string): string;
begin
  EventName := UpperCase(trim(EventName));

  if EventName = 'EVT_CHAR' then
  begin
    Result := 'wxKeyEvent& event';
    exit;
  end;

  if EventName = 'EVT_KEY_UP' then
  begin
    Result := 'wxKeyEvent& event';
    exit;
  end;

  if EventName = 'EVT_KEY_DOWN' then
  begin
    Result := 'wxKeyEvent& event';
    exit;
  end;

  if EventName = 'EVT_ERASE_BACKGROUND' then
  begin
    Result := 'wxEraseEvent& event';
    exit;
  end;

  if EventName = 'EVT_SIZE' then
  begin
    Result := 'wxSizeEvent& event';
    exit;
  end;

  if EventName = 'EVT_SET_FOCUS' then
  begin
    Result := 'wxFocusEvent& event';
    exit;
  end;

  if EventName = 'EVT_KILL_FOCUS' then
  begin
    Result := 'wxFocusEvent& event';
    exit;
  end;

  if EventName = 'EVT_ENTER_WINDOW' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  if EventName = 'EVT_LEAVE_WINDOW' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  if EventName = 'EVT_MOTION' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  if EventName = 'EVT_LEFT_DOWN' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  if EventName = 'EVT_LEFT_UP' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  if EventName = 'EVT_RIGHT_DOWN' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  if EventName = 'EVT_RIGHT_UP' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  if EventName = 'EVT_MIDDLE_DOWN' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  if EventName = 'EVT_MIDDLE_UP' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  if EventName = 'EVT_LEFT_DCLICK' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  if EventName = 'EVT_RIGHT_DCLICK' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  if EventName = 'EVT_MIDDLE_DCLICK' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  if EventName = 'EVT_PAINT' then
  begin
    Result := 'wxPaintEvent& event';
    exit;
  end;

  if EventName = 'EVT_INIT_DIALOG' then
  begin
    Result := 'wxInitDialogEvent& event';
    exit;
  end;

  if EventName = 'EVT_SCROLLWIN' then
  begin
    Result := 'wxScrollWinEvent& event';
    exit;
  end;

  if EventName = 'EVT_SCROLLWIN_TOP' then
  begin
    Result := 'wxScrollWinEvent& event';
    exit;
  end;

  if EventName = 'EVT_SCROLLWIN_BOTTOM' then
  begin
    Result := 'wxScrollWinEvent& event';
    exit;
  end;

  if EventName = 'EVT_SCROLLWIN_LINEUP' then
  begin
    Result := 'wxScrollWinEvent& event';
    exit;
  end;

  if EventName = 'EVT_SCROLLWIN_LINEDOWN' then
  begin
    Result := 'wxScrollWinEvent& event';
    exit;
  end;

  if EventName = 'EVT_SCROLLWIN_PAGEUP' then
  begin
    Result := 'wxScrollWinEvent& event';
    exit;
  end;

  if EventName = 'EVT_SCROLLWIN_PAGEDOWN' then
  begin
    Result := 'wxScrollWinEvent& event';
    exit;
  end;

  if EventName = 'EVT_SCROLLWIN_THUMBTRACK' then
  begin
    Result := 'wxScrollWinEvent& event';
    exit;
  end;

  if EventName = 'EVT_SCROLLWIN_THUMBRELEASE' then
  begin
    Result := 'wxScrollWinEvent& event';
    exit;
  end;

  if EventName = 'EVT_SYS_COLOUR_CHANGED' then
  begin
    Result := 'wxSysColourChangedEvent& event';
    exit;
  end;

  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;

  if EventName = 'EVT_CLOSE' then
  begin
    Result := 'wxCloseEvent& event';
    exit;
  end;

  if EventName = 'EVT_IDLE' then
  begin
    Result := 'wxIdleEvent& event';
    exit;
  end;
  if EventName = 'EVT_ACTIVATE' then
  begin
    Result := 'wxActivateEvent& event';
    exit;
  end;
  if EventName = 'EVT_ACTIVATE_APP' then
  begin
    Result := 'wxActivateEvent& event';
    exit;
  end;
  if EventName = 'EVT_QUERY_END_SESSION' then
  begin
    Result := 'wxCloseEvent& event';
    exit;
  end;
  if EventName = 'EVT_END_SESSION' then
  begin
    Result := 'wxCloseEvent& event';
    exit;
  end;
  if EventName = 'EVT_DROP_FILES' then
  begin
    Result := 'wxDropFilesEvent& event';
    exit;
  end;
  if EventName = 'EVT_SPLITTER_SASH_POS_CHANGED' then
  begin
    Result := 'wxSplitterEvent& event';
    exit;
  end;
  if EventName = 'EVT_SPLITTER_UNSPLIT' then
  begin
    Result := 'wxSplitterEvent& event';
    exit;
  end;
  if EventName = 'EVT_SPLITTER_DCLICK' then
  begin
    Result := 'wxSplitterEvent& event';
    exit;
  end;
  if EventName = 'EVT_JOY_BUTTON_DOWN' then
  begin
    Result := 'wxJoystickEvent& event';
    exit;
  end;
  if EventName = 'EVT_JOY_BUTTON_UP' then
  begin
    Result := 'wxJoystickEvent& event';
    exit;
  end;
  if EventName = 'EVT_JOY_MOVE' then
  begin
    Result := 'wxJoystickEvent& event';
    exit;
  end;
  if EventName = 'EVT_JOY_ZMOVE' then
  begin
    Result := 'wxJoystickEvent& event';
    exit;
  end;
  if EventName = 'EVT_MENU_OPEN' then
  begin
    Result := 'wxMenuEvent& event';
    exit;
  end;
  if EventName = 'EVT_MENU_CLOSE' then
  begin
    Result := 'wxMenuEvent& event';
    exit;
  end;
  if EventName = 'EVT_MENU_HIGHLIGHT_ALL' then
  begin
    Result := 'wxMenuEvent& event';
    exit;
  end;
  if EventName = 'EVT_MOUSEWHEEL' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;
  if EventName = 'EVT_MOUSE_EVENTS' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

  Result := 'void';
end;

function TfrmNewForm.GetTypeFromEventName(EventName: string): string;
begin
  Result := 'void';
end;

procedure TfrmNewForm.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
    //Result:=WxControlNone;
end;

function TfrmNewForm.GetStretchFactor:Integer;
begin
    result:=Wx_StretchFactor;
end;
procedure TfrmNewForm.SetStretchFactor(intValue:Integer);
begin
    Wx_StretchFactor:=intValue;
end;

function TfrmNewForm.GetEventList: TStringlist;
begin
  Result := FWx_EventList;
end;

procedure TfrmNewForm.FormMove(var Msg: TWMMove);
begin
  inherited;
  //    if MainForm.ELDesigner1.Active then
  //        SetModifiedFlag;

end;

function TfrmNewForm.GenerateControlIDs: string;
begin
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TfrmNewForm.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
  if trim(EVT_UPDATE_UI) <> '' then
  begin
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
      [trim(Self.wx_IDName), CurrClassName, EVT_UPDATE_UI]) + '';

  end;


  if trim(EVT_CLOSE) <> '' then
  begin
    Result := Result + #13 + Format('EVT_CLOSE(%s::%s)', [CurrClassName,EVT_CLOSE]) + '';
  end;


  if trim(EVT_CHAR) <> '' then
  begin
    Result := Result + #13 + Format('EVT_CHAR(%s::%s)', [CurrClassName,
      EVT_CHAR]) + '';

  end;

  if trim(EVT_KEY_UP) <> '' then
  begin
    Result := Result + #13 + Format('EVT_KEY_UP(%s::%s)', [CurrClassName,
      EVT_KEY_UP]) + '';

  end;

  if trim(EVT_KEY_DOWN) <> '' then
  begin
    Result := Result + #13 + Format('EVT_KEY_DOWN(%s::%s)', [CurrClassName,
      EVT_KEY_DOWN]) + '';

  end;

  if trim(EVT_ERASE_BACKGROUND) <> '' then
  begin
    Result := Result + #13 + Format('EVT_ERASE_BACKGROUND(%s::%s)',
      [CurrClassName, EVT_ERASE_BACKGROUND]) + '';

  end;

  if trim(EVT_SIZE) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SIZE(%s::%s)', [CurrClassName,
      EVT_SIZE]) + '';

  end;

  if trim(EVT_SET_FOCUS) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SET_FOCUS(%s::%s)', [CurrClassName,
      EVT_SET_FOCUS]) + '';

  end;

  if trim(EVT_KILL_FOCUS) <> '' then
  begin
    Result := Result + #13 + Format('EVT_KILL_FOCUS(%s::%s)', [CurrClassName,
      EVT_KILL_FOCUS]) + '';

  end;

  if trim(EVT_ENTER_WINDOW) <> '' then
  begin
    Result := Result + #13 + Format('EVT_ENTER_WINDOW(%s::%s)', [CurrClassName,
      EVT_ENTER_WINDOW]) + '';

  end;

  if trim(EVT_LEAVE_WINDOW) <> '' then
  begin
    Result := Result + #13 + Format('EVT_LEAVE_WINDOW(%s::%s)', [CurrClassName,
      EVT_LEAVE_WINDOW]) + '';

  end;

  if trim(EVT_MOTION) <> '' then
  begin
    Result := Result + #13 + Format('EVT_MOTION(%s::%s)', [CurrClassName,
      EVT_MOTION]) + '';

  end;

  if trim(EVT_LEFT_DOWN) <> '' then
  begin
    Result := Result + #13 + Format('EVT_LEFT_DOWN(%s::%s)', [CurrClassName,
      EVT_LEFT_DOWN]) + '';

  end;

  if trim(EVT_LEFT_UP) <> '' then
  begin
    Result := Result + #13 + Format('EVT_LEFT_UP(%s::%s)', [CurrClassName,
      EVT_LEFT_UP]) + '';

  end;

  if trim(EVT_RIGHT_DOWN) <> '' then
  begin
    Result := Result + #13 + Format('EVT_RIGHT_DOWN(%s::%s)', [CurrClassName,
      EVT_RIGHT_DOWN]) + '';

  end;

  if trim(EVT_RIGHT_UP) <> '' then
  begin
    Result := Result + #13 + Format('EVT_RIGHT_UP(%s::%s)', [CurrClassName,
      EVT_RIGHT_UP]) + '';

  end;

  if trim(EVT_MIDDLE_UP) <> '' then
  begin
    Result := Result + #13 + Format('EVT_MIDDLE_UP(%s::%s)', [CurrClassName,
      EVT_MIDDLE_UP]) + '';

  end;

  if trim(EVT_LEFT_DCLICK) <> '' then
  begin
    Result := Result + #13 + Format('EVT_LEFT_DCLICK(%s::%s)', [CurrClassName,
      EVT_LEFT_DCLICK]) + '';

  end;

  if trim(EVT_RIGHT_DCLICK) <> '' then
  begin
    Result := Result + #13 + Format('EVT_RIGHT_DCLICK(%s::%s)', [CurrClassName,
      EVT_RIGHT_DCLICK]) + '';

  end;

  if trim(EVT_MIDDLE_DCLICK) <> '' then
  begin
    Result := Result + #13 + Format('EVT_MIDDLE_DCLICK(%s::%s)', [CurrClassName,
      EVT_MIDDLE_DCLICK]) + '';

  end;

  if trim(EVT_PAINT) <> '' then
  begin
    Result := Result + #13 + Format('EVT_PAINT(%s::%s)', [CurrClassName,
      EVT_PAINT]) + '';

  end;

  if trim(EVT_INIT_DIALOG) <> '' then
  begin
    Result := Result + #13 + Format('EVT_INIT_DIALOG(%s::%s)', [CurrClassName,
      EVT_INIT_DIALOG]) + '';

  end;

  if trim(EVT_SCROLLWIN) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SCROLLWIN(%s::%s)', [CurrClassName,
      EVT_SCROLLWIN]) + '';

  end;

  if trim(EVT_SCROLLWIN_TOP) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SCROLLWIN_TOP(%s::%s)', [CurrClassName,
      EVT_SCROLLWIN_TOP]) + '';

  end;

  if trim(EVT_SCROLLWIN_BOTTOM) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SCROLLWIN_BOTTOM(%s::%s)',
      [CurrClassName, EVT_SCROLLWIN_BOTTOM]) + '';

  end;

  if trim(EVT_SCROLLWIN_LINEUP) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SCROLLWIN_LINEUP(%s::%s)',
      [CurrClassName, EVT_SCROLLWIN_LINEUP]) + '';

  end;

  if trim(EVT_SCROLLWIN_LINEDOWN) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SCROLLWIN_LINEDOWN(%s::%s)',
      [CurrClassName, EVT_SCROLLWIN_LINEDOWN]) + '';

  end;

  if trim(EVT_SCROLLWIN_PAGEUP) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SCROLLWIN_PAGEUP(%s::%s)',
      [CurrClassName, EVT_SCROLLWIN_PAGEUP]) + '';

  end;

  if trim(EVT_SCROLLWIN_PAGEDOWN) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SCROLLWIN_PAGEDOWN(%s::%s)',
      [CurrClassName, EVT_SCROLLWIN_PAGEDOWN]) + '';

  end;

  if trim(EVT_SCROLLWIN_THUMBTRACK) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SCROLLWIN_THUMBTRACK(%s::%s)',
      [CurrClassName, EVT_SCROLLWIN_THUMBTRACK]) + '';

  end;

  if trim(EVT_SCROLLWIN_THUMBRELEASE) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SCROLLWIN_THUMBRELEASE(%s::%s)',
      [CurrClassName, EVT_SCROLLWIN_THUMBRELEASE]) + '';

  end;

  if trim(EVT_SYS_COLOUR_CHANGED) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SYS_COLOUR_CHANGED(%s::%s)',
      [CurrClassName, EVT_SYS_COLOUR_CHANGED]) + '';

  end;
  if trim(EVT_IDLE) <> '' then
  begin
    Result := Result + #13 + Format('EVT_IDLE(%s::%s)',
      [CurrClassName, EVT_IDLE]) + '';

  end;
  if trim(EVT_ACTIVATE) <> '' then
  begin
    Result := Result + #13 + Format('EVT_ACTIVATE(%s::%s)',
      [CurrClassName, EVT_ACTIVATE]) + '';

  end;
  if trim(EVT_ACTIVATE_APP) <> '' then
  begin
    Result := Result + #13 + Format('EVT_ACTIVATE_APP(%s::%s)',
      [CurrClassName, EVT_ACTIVATE_APP]) + '';

  end;
  if trim(EVT_QUERY_END_SESSION) <> '' then
  begin
    Result := Result + #13 + Format('EVT_QUERY_END_SESSION(%s::%s)',
      [CurrClassName, EVT_QUERY_END_SESSION]) + '';

  end;
  if trim(EVT_END_SESSION) <> '' then
  begin
    Result := Result + #13 + Format('EVT_END_SESSION(%s::%s)',
      [CurrClassName, EVT_END_SESSION]) + '';

  end;
  if trim(EVT_DROP_FILES) <> '' then
  begin
    Result := Result + #13 + Format('EVT_DROP_FILES(%s::%s)',
      [CurrClassName, EVT_DROP_FILES]) + '';

  end;
  if trim(EVT_SPLITTER_SASH_POS_CHANGED) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SPLITTER_SASH_POS_CHANGED(%s::%s)',
      [CurrClassName, EVT_SPLITTER_SASH_POS_CHANGED]) + '';

  end;
  if trim(EVT_SPLITTER_UNSPLIT) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SPLITTER_UNSPLIT(%s::%s)',
      [CurrClassName, EVT_SPLITTER_UNSPLIT]) + '';

  end;
  if trim(EVT_SPLITTER_DCLICK) <> '' then
  begin
    Result := Result + #13 + Format('EVT_SPLITTER_DCLICK(%s::%s)',
      [CurrClassName, EVT_SPLITTER_DCLICK]) + '';

  end;
  if trim(EVT_JOY_BUTTON_DOWN) <> '' then
  begin
    Result := Result + #13 + Format('EVT_JOY_BUTTON_DOWN(%s::%s)',
      [CurrClassName, EVT_JOY_BUTTON_DOWN]) + '';

  end;
  if trim(EVT_JOY_BUTTON_UP) <> '' then
  begin
    Result := Result + #13 + Format('EVT_JOY_BUTTON_UP(%s::%s)',
      [CurrClassName, EVT_JOY_BUTTON_UP]) + '';

  end;
  if trim(EVT_JOY_MOVE) <> '' then
  begin
    Result := Result + #13 + Format('EVT_JOY_MOVE(%s::%s)',
      [CurrClassName, EVT_JOY_MOVE]) + '';

  end;
  if trim(EVT_JOY_ZMOVE) <> '' then
  begin
    Result := Result + #13 + Format('EVT_JOY_ZMOVE(%s::%s)',
      [CurrClassName, EVT_JOY_ZMOVE]) + '';

  end;
  if trim(EVT_MENU_OPEN) <> '' then
  begin
    Result := Result + #13 + Format('EVT_MENU_OPEN(%s::%s)',
      [CurrClassName, EVT_MENU_OPEN]) + '';

  end;
  if trim(EVT_MENU_CLOSE) <> '' then
  begin
    Result := Result + #13 + Format('EVT_MENU_CLOSE(%s::%s)',
      [CurrClassName, EVT_MENU_CLOSE]) + '';

  end;
  if trim(EVT_MENU_HIGHLIGHT_ALL) <> '' then
  begin
    Result := Result + #13 + Format('EVT_MENU_HIGHLIGHT_ALL(%s::%s)',
      [CurrClassName, EVT_MENU_HIGHLIGHT_ALL]) + '';

  end;
  if trim(EVT_MOUSEWHEEL) <> '' then
  begin
    Result := Result + #13 + Format('EVT_MOUSEWHEEL(%s::%s)',
      [CurrClassName, EVT_MOUSEWHEEL]) + '';

  end;
  if trim(EVT_MOUSE_EVENTS) <> '' then
  begin
    Result := Result + #13 + Format('EVT_MOUSE_EVENTS(%s::%s)',
      [CurrClassName, EVT_MOUSE_EVENTS]) + '';

  end;

end;

function TfrmNewForm.GetDialogStyleString: string;
begin
  if (self.Wx_DialogStyle <> []) or (self.Wx_GeneralStyle <> []) then
    Result := '#define THIS_DIALOG_STYLE ' +
      GetDialogSpecificStyle(self.Wx_GeneralStyle, self.Wx_DialogStyle)
  else
    Result := '#define THIS_DIALOG_STYLE 0';
end;

//function TfrmNewForm.GenerateExtraCodeForFrame:string;
//var
//      strLst: TStringList;
//      I:Integer;
//begin
//  strLst := TStringList.Create;
//    Result:=strLst.text;
//    strLst.destroy;
//end;

function TfrmNewForm.GenerateGUIControlCreation: string;
var
  I,J,MaxToolWidth,MaxToolHt,MaxSepValue: Integer;
  strLst: TStringList;
  isSizerAvailable:Boolean;

begin
  strLst := TStringList.Create;

    if self.Wx_DesignerType = dtWxFrame then
    begin
        for I := self.ComponentCount - 1 downto 0 do    // Iterate
        begin
            if IsControlWxToolBar(TControl(Components[i])) then
            begin
                MaxToolWidth:=16;
                MaxToolHt:=15;
                MaxSepValue:=5;
                for J := 0 to TWinControl(Components[i]).ControlCount - 1 do    // Iterate
                begin
                    if (TWinControl(Components[i]).Controls[J] is TWxSeparator) then
                    begin
                        if TWinControl(Components[i]).Controls[J].width > MaxSepValue then
                            MaxSepValue:=TWinControl(Components[i]).Controls[J].Width;
                    end;

                    if (TWinControl(Components[i]).Controls[J] is TWxToolButton) then
                    begin
                        if TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap <> nil then
                        begin
                            if TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap.Height > MaxToolHt then
                                MaxToolHt:=TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap.Height;

                            if TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap.Width > MaxToolWidth then
                                MaxToolWidth:=TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap.Width;
                        end;
                    end;
                end;    // for
                if not ( (MaxToolWidth = 16) and (MaxToolHt = 15) ) then
                begin
                    strLst.add(Format('%s->SetToolBitmapSize(wxSize(%d,%d));',[self.Components[i].Name,MaxToolWidth,MaxToolHt]));
                end;

                if (MaxSepValue <> 5) then
                begin
                    strLst.add(Format('%s->SetToolSeparation(%d);',[self.Components[i].Name,MaxSepValue]));
                end;
                strLst.add(Format('%s->Realize();',[self.Components[i].Name]));
                strLst.add(Format('this->SetToolBar(%s);',[self.Components[i].Name]));
            end;

            if IsControlWxStatusBar(TControl(Components[i])) then
            begin
                //strLst.add(Format('%s->SetFieldsCount(%d);',[self.Components[i].Name]));
                strLst.add(Format('this->SetStatusBar(%s);',[self.Components[i].Name]));
            end;
        end;    // for
    end;


  isSizerAvailable:=false;
    for I := 0 to self.ComponentCount - 1 do // Iterate
    begin
        if self.Components[i] is TWxSizerPanel then
        begin
            isSizerAvailable:=true;
            break;
        end;
    end;

    if isSizerAvailable then
    begin
        strLst.add('GetSizer()->Fit(this);');
        strLst.add('GetSizer()->SetSizeHints(this);');
    end
    else
    begin
        strLst.add(Format('this->SetSize(%d,%d,%d,%d);', [self.left, self.top,
            self.width, self.height]));
    end;

  strLst.add(Format('this->SetTitle(_("%s"));', [self.Caption]));
  
  if self.Wx_Center then
    strLst.add('this->Center();');
    
  if assigned(Wx_ICON) then
  begin
    if Wx_ICON.Bitmap.Handle =0 then
    begin
        strLst.add('this->SetIcon(wxNullIcon);');
    end
    else
    begin
        strLst.add('wxIcon '+self.Wx_Name+'_ICON'+' ('+self.Wx_Name+'_XPM'+');');
        strLst.add('this->SetIcon('+self.Wx_Name+'_XPM'+');');
    end;
  end;

  if trim(self.Wx_ToolTips) <> '' then
    strLst.add(Format('this->SetToolTip(wxT(_("%s")));',[self.Wx_ToolTips]));

  Result := strLst.text;
  strLst.destroy;
end;

function TfrmNewForm.GenerateGUIControlDeclaration: string;
begin
  //Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TfrmNewForm.GenerateHeaderInclude: string;
begin
  result:='';
end;

function TfrmNewForm.GenerateImageInclude: string;
begin
  result:='';
  if assigned(Wx_ICON) then
  begin
    if Wx_ICON.Bitmap.Handle <>0 then
    begin
        result :='#include "'+self.wx_Name+'_XPM.xpm"';
    end;
  end;
end;


function TfrmNewForm.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TfrmNewForm.GetIDValue: LongInt;
begin
  Result := wx_IDValue;
end;

function TfrmNewForm.GetPropertyList: TStringList;
begin
  Result := Wx_PropertyList;
end;

function TfrmNewForm.GetWxClassName: string;
begin
    if trim(Wx_Class) = '' then
    begin
        if Wx_DesignerType = dtWxDialog then
        begin
            Wx_Class:='wxDialog'
        end;
        
        if Wx_DesignerType = dtWxFrame then
        begin
            Wx_Class:='wxFrame'
        end;

        if Wx_DesignerType = dtWxWizard then
        begin
            Wx_Class:='wxWizard'
        end;

    end;
  Result := wx_Class;
end;

procedure TfrmNewForm.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TfrmNewForm.SetIDValue(IDValue: longInt);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TfrmNewForm.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

procedure TfrmNewForm.CreateInitVars;
begin
  //intControlMaxValue:=1001;
  Wx_IDName := 'ID_DIALOG1';
  Wx_IDValue := 1000;
  Wx_Class := 'wxDialog';
  Caption := 'New Project';
  Wx_Center := false;
  Wx_ToolTips := '';
  Wx_Hidden := false;

  self.OldCreateOrder:=true;

  FWx_ICON:=TPicture.Create;

  wx_PropertyList := TStringList.Create;
  wx_PropertyList.Add('Wx_IDName:IDName');
  wx_PropertyList.Add('Wx_IDValue:IDValue');
  wx_PropertyList.Add('Wx_Class:Class');
  wx_PropertyList.Add('Wx_Center:Center');
  wx_PropertyList.Add('Wx_HelpText:HelpText');
  wx_PropertyList.Add('Wx_ToolTips:ToolTips');
  wx_PropertyList.Add('Wx_Hidden:Hidden');
  wx_PropertyList.Add('Caption:Title');
  wx_PropertyList.Add('Height:Height');
  wx_PropertyList.Add('Width:Width');
  wx_PropertyList.Add('Left:Left');
  wx_PropertyList.Add('Top:Top');
  wx_PropertyList.Add('Font:Font');

  wx_PropertyList.Add('Wx_GeneralStyle:GeneralStyle');
  wx_PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
  wx_PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
  wx_PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
  wx_PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
  wx_PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
  wx_PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
  wx_PropertyList.Add('wxNO_3D:wxNO_3D');
  wx_PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
  wx_PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
  wx_PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
  wx_PropertyList.Add('wxVSCROLL:wxVSCROLL');
  wx_PropertyList.Add('wxHSCROLL:wxHSCROLL');
  wx_PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');

  wx_PropertyList.Add('Wx_DialogStyle:DialogStyle');
  wx_PropertyList.Add('wxCAPTION:wxCAPTION');
  wx_PropertyList.Add('wxRESIZE_BORDER:wxRESIZE_BORDER');
  wx_PropertyList.Add('wxSYSTEM_MENU:wxSYSTEM_MENU');
  wx_PropertyList.Add('wxTHICK_FRAME:wxTHICK_FRAME');
  wx_PropertyList.Add('wxSTAY_ON_TOP:wxSTAY_ON_TOP');
  wx_PropertyList.Add('wxDIALOG_NO_PARENT:wxDIALOG_NO_PARENT');
  wx_PropertyList.Add('wxDIALOG_EX_CONTEXTHELP:wxDIALOG_EX_CONTEXTHELP');
  wx_PropertyList.Add('wxMINIMIZE_BOX:wxMINIMIZE_BOX');
  wx_PropertyList.Add('wxMAXIMIZE_BOX:wxMAXIMIZE_BOX');
    wx_PropertyList.Add('wxCLOSE_BOX:wxCLOSE_BOX');
  wx_PropertyList.Add('Wx_Name:Name');
  wx_PropertyList.Add('Wx_ICON:Icon');


  FWx_EventList := TStringList.Create;
  FWx_EventList.add('  EVT_CLOSE: OnClose');
  FWx_EventList.add('  EVT_CHAR: OnChar');
  FWx_EventList.add('  EVT_KEY_UP: OnKeyUp');
  FWx_EventList.add('  EVT_KEY_DOWN: OnKeyDown');
  FWx_EventList.add('  EVT_ERASE_BACKGROUND: OnEraseBackground');
  FWx_EventList.add('  EVT_SIZE: OnSize');
  FWx_EventList.add('  EVT_SET_FOCUS: OnSetFocus');
  FWx_EventList.add('  EVT_KILL_FOCUS: OnKillFocus');
  FWx_EventList.add('  EVT_ENTER_WINDOW: OnEnterWindow');
  FWx_EventList.add('  EVT_LEAVE_WINDOW: OnLeaveWindow');
  FWx_EventList.add('  EVT_MOTION: OnMouseMotion');
  FWx_EventList.add('  EVT_LEFT_DOWN: OnLeftDown');
  FWx_EventList.add('  EVT_LEFT_UP: OnLeftUP');
  FWx_EventList.add('  EVT_RIGHT_DOWN: OnRightDown');
  FWx_EventList.add('  EVT_RIGHT_UP: OnRightUP');
  FWx_EventList.add('  EVT_MIDDLE_DOWN: OnMiddleDown');
  FWx_EventList.add('  EVT_MIDDLE_UP: OnMiddleUP');
  FWx_EventList.add('  EVT_LEFT_DCLICK: OnLeftDclick');
  FWx_EventList.add('  EVT_RIGHT_DCLICK: OnRightDclick');
  FWx_EventList.add('  EVT_MIDDLE_DCLICK: OnMiddleDclick');
  FWx_EventList.add('  EVT_PAINT: OnPaint');
  FWx_EventList.add('  EVT_INIT_DIALOG: OnInitDialog');
  FWx_EventList.add('  EVT_SCROLLWIN: OnScrollWin');
  FWx_EventList.add('  EVT_SCROLLWIN_TOP: OnScrollWinTop');
  FWx_EventList.add('  EVT_SCROLLWIN_BOTTOM: OnScrollWinBottom');
  FWx_EventList.add('  EVT_SCROLLWIN_LINEUP: OnScrollWinLineUp');
  FWx_EventList.add('  EVT_SCROLLWIN_LINEDOWN: OnScrollWinLineDown');
  FWx_EventList.add('  EVT_SCROLLWIN_PAGEUP: OnScrollWinPageUp');
  FWx_EventList.add('  EVT_SCROLLWIN_PAGEDOWN: OnScrollWinPageDown');
  FWx_EventList.add('  EVT_SCROLLWIN_THUMBTRACK: OnScrollWinThumbTrack');
  FWx_EventList.add('  EVT_SCROLLWIN_THUMBRELEASE: OnScrollWinThumbRelease');
  FWx_EventList.add('  EVT_SYS_COLOUR_CHANGED: OnColourChanged');
  FWx_EventList.add('  EVT_IDLE :OnIdle');
  FWx_EventList.add('  EVT_ACTIVATE :OnActivate');
  FWx_EventList.add('  EVT_ACTIVATE_APP :OnActivateApp');
  FWx_EventList.add('  EVT_QUERY_END_SESSION :OnQueryEndSession');
  FWx_EventList.add('  EVT_END_SESSION :OnEndSession');
  FWx_EventList.add('  EVT_DROP_FILES :OnDropFiles');
  FWx_EventList.add('  EVT_SPLITTER_SASH_POS_CHANGED  :OnSplitterSashPosChanged');
  FWx_EventList.add('  EVT_SPLITTER_UNSPLIT :OnSplitterUnSplit');
  FWx_EventList.add('  EVT_SPLITTER_DCLICK :OnSplitterDoubleClick');
  FWx_EventList.add('  EVT_JOY_BUTTON_DOWN :OnJoyButtonDown');
  FWx_EventList.add('  EVT_JOY_BUTTON_UP :OnJoyButtonUp');
  FWx_EventList.add('  EVT_JOY_MOVE :OnJoyMove');
  FWx_EventList.add('  EVT_JOY_ZMOVE :OnJoyZMove');
  FWx_EventList.add('  EVT_MENU_OPEN :OnMenuOpen');
  FWx_EventList.add('  EVT_MENU_CLOSE :OnMenuClose');
  FWx_EventList.add('  EVT_MENU_HIGHLIGHT_ALL :OnMenuHightLightAll');
  FWx_EventList.add('  EVT_MOUSEWHEEL :OnMouseWheel');
  FWx_EventList.add('  EVT_MOUSE_EVENTS :OnMouseEvents');

  //FWx_EventList.add('  EVT_UPDATE_UI:OnUpdateUI');

end;

procedure TfrmNewForm.FormCreate(Sender: TObject);
var
  hMenuHandle: HMENU;
Begin
  CreateInitVars;
  if (Self.Handle <> 0) then
  begin
    hMenuHandle := GetSystemMenu(Self.Handle, FALSE);
    if (hMenuHandle <> 0) then
    begin
      DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND);
      DeleteMenu(hMenuHandle, SC_MAXIMIZE, MF_BYCOMMAND);
    end;
  end;
end;

procedure TfrmNewForm.FormResize(Sender: TObject);
begin
    //MainForm.ELDesigner1Modified(MainForm.ELDesigner1);
end;

procedure TfrmNewForm.NewFormResize(Sender: TObject);
begin
{$IFDEF WX_BUILD}
    MainForm.ELDesigner1Modified(MainForm.ELDesigner1);
{$ENDIF}    
end;

procedure TfrmNewForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  //    if frmMainForm.ELDesigner1.Active then
  //    begin
  //        CanClose := false;
  //        self.visible := false;
  //    end;
end;

procedure TfrmNewForm.FormDestroy(Sender: TObject);
begin
  wx_PropertyList.destroy;
  FWx_EventList.destroy;
end;

procedure TfrmNewForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{$IFDEF WX_BUILD}
  MainForm.ELDesigner1KeyDown(Sender,Key, Shift);
{$ENDIF}
end;

function TfrmNewForm.GetFGColor:string;
begin
   Result:=Wx_ProxyFGColorString.strColorValue;
end;

procedure TfrmNewForm.SetFGColor(strValue:String);
begin
    Wx_ProxyFGColorString.strColorValue:=strValue;
    self.Color:=GetColorFromString(strValue);
end;

function TfrmNewForm.GetBGColor:string;
begin
   Result:=Wx_ProxyBGColorString.strColorValue;
end;

procedure TfrmNewForm.SetBGColor(strValue:String);
begin
   Wx_ProxyBGColorString.strColorValue:=strValue;
   self.Font.Color:=GetColorFromString(strValue);
end;

procedure TfrmNewForm.SetDesignerType(value:TWxDesignerType);
begin
    Wx_Class:='wxDialog';
    
    if value = dtWxFrame then
    begin
        Wx_Class:='wxFrame';
        self.Color:=clAppWorkSpace;
        //self.BorderStyle:=bsSingle;
    end;

    if value = dtWxWizard then
    begin
        Wx_Class:='wxWizard';
    end;
    FWxDesignerType:=value;
end;
end.