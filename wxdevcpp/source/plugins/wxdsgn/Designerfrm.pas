{

$Id: Designerfrm.pas 938 2007-05-15 03:57:34Z gururamnath $
}
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


unit Designerfrm;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtCtrls, Buttons, StdCtrls, wxversion,
    WxEdit, WxStaticText, WxButton, wxUtils, WXRadioButton, WXCheckBox,
    Wxcombobox, WxToolButton, WxSeparator, wxChoice,
    WxListbox, WxGauge, wxListCtrl, wxTreeCtrl, WxMemo, wxScrollbar, wxSpinButton,
    WxSizerPanel, WxSplitterWindow, wxAuiManager,
    ComCtrls, SynEdit, Menus, xprocs, StrUtils;

type

    TfrmNewForm = class(TForm, IWxComponentInterface, IWxDesignerFormInterface, IWxImageContainerInterface)
        procedure CreateInitVars;
        procedure FormCreate(Sender: TObject);
        procedure FormResize(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
        procedure SetFrameProperties();
        procedure SetDialogProperties();

        function GetBitmapCount: integer;
        function GetBitmap(Idx: integer; var bmp: TBitmap; var PropertyName: string): boolean;
        function GetPropertyName(Idx: integer): string;
        function PreserveFormat: boolean;
        function GetGraphicFileName: string;
        function SetGraphicFileName(strFileName: string): boolean;

        procedure FormClick(Sender: TObject);
        procedure WMNCLButtonDown(var Msg: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
        procedure WMNCRButtonDown(var Msg: TWMNCRButtonDown); message WM_NCRBUTTONDOWN;

    private
    { Private declarations }
        FWxFrm_IDName: string;
        FWxFrm_IDValue: integer;
        FWxFrm_Class: string;
        FWxFrm_Center: boolean;
        FWxFrm_ToolTips: string;
        FWxFrm_Hidden: boolean;
        FWxFrm_GeneralStyle: TWxStdStyleSet;
        FWxFrm_DialogStyle: TWxDlgStyleSet;
        FWxFrm_SizeToContents: boolean;
        FisAuimanagerAvailable: boolean;
        fsynEdit: TSynEdit;

        FEVT_CHAR, FEVT_KEY_UP, FEVT_KEY_DOWN, FEVT_ERASE_BACKGROUND,
        FEVT_SIZE, FEVT_SET_FOCUS, FEVT_KILL_FOCUS, FEVT_ENTER_WINDOW,
        FEVT_LEAVE_WINDOW, FEVT_MOTION, FEVT_LEFT_DOWN, FEVT_LEFT_UP,
        FEVT_RIGHT_DOWN, FEVT_RIGHT_UP, FEVT_MIDDLE_DOWN, FEVT_MIDDLE_UP,
        FEVT_LEFT_DCLICK, FEVT_RIGHT_DCLICK, FEVT_MIDDLE_DCLICK, FEVT_PAINT,
        FEVT_INIT_DIALOG, FEVT_SCROLLWIN, FEVT_SCROLLWIN_TOP, FEVT_SCROLLWIN_BOTTOM,
        FEVT_SCROLLWIN_LINEUP, FEVT_SCROLLWIN_LINEDOWN, FEVT_SCROLLWIN_PAGEUP,
        FEVT_SCROLLWIN_PAGEDOWN, FEVT_SCROLLWIN_THUMBTRACK, FEVT_SCROLLWIN_THUMBRELEASE,
        FEVT_SYS_COLOUR_CHANGED, FEVT_UPDATE_UI, FEVT_CLOSE: string;
        FEVT_IDLE, FEVT_ACTIVATE, FEVT_ACTIVATE_APP, FEVT_QUERY_END_SESSION,
        FEVT_END_SESSION, FEVT_DROP_FILES, FEVT_SPLITTER_SASH_POS_CHANGED,
        FEVT_SPLITTER_UNSPLIT, FEVT_SPLITTER_DCLICK, FEVT_JOY_BUTTON_DOWN,
        FEVT_JOY_BUTTON_UP, FEVT_JOY_MOVE, FEVT_JOY_ZMOVE, FEVT_MENU_OPEN,
        FEVT_MENU_CLOSE, FEVT_MENU_HIGHLIGHT_ALL, FEVT_MOUSEWHEEL, FEVT_MOUSE_EVENTS: string;

        FWx_Name: string;
        FWx_ICON: TPicture;
        FWx_ProxyBGColorString: TWxColorString;
        FWx_ProxyFGColorString: TWxColorString;
        FWxDesignerType: TWxDesignerType;
        wx_PropertyList: TStringList;
        FWx_EventList: TStringList;

        FKeepFormat: boolean;
        FWx_Filename: string;

    { Read method for property Wx_EditStyle }
        function GetWx_DialogStyle: TWxDlgStyleSet;
    { Write method for property Wx_EditStyle }
        procedure SetWx_DialogStyle(Value: TWxDlgStyleSet);

    public
        fileName: string;
        function GenerateControlIDs: string;
        function GenerateEnumControlIDs: string;
        function GenerateEventTableEntries(CurrClassName: string): string;
        function GenerateGUIControlCreation: string;
        function GenerateXRCControlCreation(IndentString: string): TStringList;
        function GenerateGUIControlDeclaration: string;
        function GenerateHeaderInclude: string;
        function GenerateImageInclude: string;
        function GetIDName: string;
        function GetIDValue: integer;
        function GetPropertyList: TStringList;
        function GetWxClassName: string;
        procedure SetIDName(IDName: string);
        procedure SetIDValue(IDValue: integer);
        procedure SetWxClassName(wxClassName: string);
        procedure FormMove(var Msg: TWMMove); message WM_MOVE;
        function GetDialogStyleString: string;
        function GetEventList: TStringList;
        function GetParameterFromEventName(EventName: string): string;
        function GetTypeFromEventName(EventName: string): string;
        procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
        function GetFGColor: string;
        procedure SetFGColor(strValue: string);
        function GetBGColor: string;
        procedure SetBGColor(strValue: string);
        function GetGenericColor(strVariableName: string): string;
        procedure SetGenericColor(strVariableName, strValue: string);

        function GetBorderAlignment: TWxBorderAlignment;
        procedure SetBorderAlignment(border: TWxBorderAlignment);
        function GetBorderWidth: integer;
        procedure SetBorderWidth(width: integer);
        function GetStretchFactor: integer;
        procedure SetStretchFactor(intValue: integer);
        procedure SetDesignerType(Value: TWxDesignerType);
    //Form Interface functions
        function GetFormName: string;
        procedure SetFormName(StrValue: string);

        procedure CreateNewXPMs(strFileName: string);
        function HasAuiManager: boolean;

    published
        property EVT_INIT_DIALOG: string read FEVT_INIT_DIALOG write FEVT_INIT_DIALOG;
        property EVT_CHAR: string read FEVT_CHAR write FEVT_CHAR;
        property EVT_KEY_UP: string read FEVT_KEY_UP write FEVT_KEY_UP;
        property EVT_KEY_DOWN: string read FEVT_KEY_DOWN write FEVT_KEY_DOWN;
        property EVT_ERASE_BACKGROUND: string read FEVT_ERASE_BACKGROUND write FEVT_ERASE_BACKGROUND;
        property EVT_SIZE: string read FEVT_SIZE write FEVT_SIZE;
        property EVT_SET_FOCUS: string read FEVT_SET_FOCUS write FEVT_SET_FOCUS;
        property EVT_KILL_FOCUS: string read FEVT_KILL_FOCUS write FEVT_KILL_FOCUS;
        property EVT_ENTER_WINDOW: string read FEVT_ENTER_WINDOW write FEVT_ENTER_WINDOW;
        property EVT_LEAVE_WINDOW: string read FEVT_LEAVE_WINDOW write FEVT_LEAVE_WINDOW;
        property EVT_MOTION: string read FEVT_MOTION write FEVT_MOTION;
        property EVT_LEFT_DOWN: string read FEVT_LEFT_DOWN write FEVT_LEFT_DOWN;
        property EVT_LEFT_UP: string read FEVT_LEFT_UP write FEVT_LEFT_UP;
        property EVT_RIGHT_DOWN: string read FEVT_RIGHT_DOWN write FEVT_RIGHT_DOWN;
        property EVT_RIGHT_UP: string read FEVT_RIGHT_UP write FEVT_RIGHT_UP;
        property EVT_MIDDLE_DOWN: string read FEVT_MIDDLE_DOWN write FEVT_MIDDLE_DOWN;
        property EVT_MIDDLE_UP: string read FEVT_MIDDLE_UP write FEVT_MIDDLE_UP;
        property EVT_LEFT_DCLICK: string read FEVT_LEFT_DCLICK write FEVT_LEFT_DCLICK;
        property EVT_RIGHT_DCLICK: string read FEVT_RIGHT_DCLICK write FEVT_RIGHT_DCLICK;
        property EVT_MIDDLE_DCLICK: string read FEVT_MIDDLE_DCLICK write FEVT_MIDDLE_DCLICK;
        property EVT_PAINT: string read FEVT_PAINT write FEVT_PAINT;
        property EVT_SCROLLWIN: string read FEVT_SCROLLWIN write FEVT_SCROLLWIN;
        property EVT_SCROLLWIN_TOP: string read FEVT_SCROLLWIN_TOP write FEVT_SCROLLWIN_TOP;
        property EVT_SCROLLWIN_BOTTOM: string read FEVT_SCROLLWIN_BOTTOM write FEVT_SCROLLWIN_BOTTOM;
        property EVT_SCROLLWIN_LINEUP: string read FEVT_SCROLLWIN_LINEUP write FEVT_SCROLLWIN_LINEUP;
        property EVT_SCROLLWIN_LINEDOWN: string read FEVT_SCROLLWIN_LINEDOWN write FEVT_SCROLLWIN_LINEDOWN;
        property EVT_SCROLLWIN_PAGEUP: string read FEVT_SCROLLWIN_PAGEUP write FEVT_SCROLLWIN_PAGEUP;
        property EVT_SCROLLWIN_PAGEDOWN: string read FEVT_SCROLLWIN_PAGEDOWN write FEVT_SCROLLWIN_PAGEDOWN;
        property EVT_SCROLLWIN_THUMBTRACK: string read FEVT_SCROLLWIN_THUMBTRACK write FEVT_SCROLLWIN_THUMBTRACK;
        property EVT_SCROLLWIN_THUMBRELEASE: string read FEVT_SCROLLWIN_THUMBRELEASE write FEVT_SCROLLWIN_THUMBRELEASE;
        property EVT_SYS_COLOUR_CHANGED: string read FEVT_SYS_COLOUR_CHANGED write FEVT_SYS_COLOUR_CHANGED;
        property EVT_UPDATE_UI: string read FEVT_UPDATE_UI write FEVT_UPDATE_UI;
        property EVT_CLOSE: string read FEVT_CLOSE write FEVT_CLOSE;
        property EVT_IDLE: string read FEVT_IDLE write FEVT_IDLE;
        property EVT_ACTIVATE: string read FEVT_ACTIVATE write FEVT_ACTIVATE;
        property EVT_ACTIVATE_APP: string read FEVT_ACTIVATE_APP write FEVT_ACTIVATE_APP;
        property EVT_QUERY_END_SESSION: string read FEVT_QUERY_END_SESSION write FEVT_QUERY_END_SESSION;
        property EVT_END_SESSION: string read FEVT_END_SESSION write FEVT_END_SESSION;
        property EVT_DROP_FILES: string read FEVT_DROP_FILES write FEVT_DROP_FILES;
        property EVT_SPLITTER_SASH_POS_CHANGED: string read FEVT_SPLITTER_SASH_POS_CHANGED write FEVT_SPLITTER_SASH_POS_CHANGED;
        property EVT_SPLITTER_UNSPLIT: string read FEVT_SPLITTER_UNSPLIT write FEVT_SPLITTER_UNSPLIT;
        property EVT_SPLITTER_DCLICK: string read FEVT_SPLITTER_DCLICK write FEVT_SPLITTER_DCLICK;
        property EVT_JOY_BUTTON_DOWN: string read FEVT_JOY_BUTTON_DOWN write FEVT_JOY_BUTTON_DOWN;
        property EVT_JOY_BUTTON_UP: string read FEVT_JOY_BUTTON_UP write FEVT_JOY_BUTTON_UP;
        property EVT_JOY_MOVE: string read FEVT_JOY_MOVE write FEVT_JOY_MOVE;
        property EVT_JOY_ZMOVE: string read FEVT_JOY_ZMOVE write FEVT_JOY_ZMOVE;
        property EVT_MENU_OPEN: string read FEVT_MENU_OPEN write FEVT_MENU_OPEN;
        property EVT_MENU_CLOSE: string read FEVT_MENU_CLOSE write FEVT_MENU_CLOSE;
        property EVT_MENU_HIGHLIGHT_ALL: string read FEVT_MENU_HIGHLIGHT_ALL write FEVT_MENU_HIGHLIGHT_ALL;
        property EVT_MOUSEWHEEL: string read FEVT_MOUSEWHEEL write FEVT_MOUSEWHEEL;
        property EVT_MOUSE_EVENTS: string read FEVT_MOUSE_EVENTS write FEVT_MOUSE_EVENTS;

        property synEdit: TSynEdit read fsynEdit write fsynEdit;
        property Wx_ICON: TPicture read FWx_ICON write FWx_ICON;
        property Wx_Name: string read FWx_Name write FWx_Name;
        property Wx_IDName: string read FWxFrm_IDName write FWxFrm_IDName;
        property Wx_IDValue: integer read FWxFrm_IDValue write FWxFrm_IDValue;
        property Wx_Class: string read FWxFrm_Class write FWxFrm_Class;
        property Wx_Center: boolean read FWxFrm_Center write FWxFrm_Center;
        property Wx_Hidden: boolean read FWxFrm_Hidden write FWxFrm_Hidden;
        property Wx_ToolTips: string read FWxFrm_ToolTips write FWxFrm_ToolTips;
        property Wx_SizeToContents: boolean read FWxFrm_SizeToContents write FWxFrm_SizeToContents;

        property KeepFormat: boolean read FKeepFormat write FKeepFormat default FALSE;
        property Wx_Filename: string read FWx_Filename write FWx_Filename;

        property Wx_GeneralStyle: TWxStdStyleSet read FWxFrm_GeneralStyle write FWxFrm_GeneralStyle;
        property Wx_DialogStyle: TWxDlgStyleSet
            read GetWx_DialogStyle write SetWx_DialogStyle;
    //Read FWxFrm_DialogStyle Write FWxFrm_DialogStyle;
        property Wx_DesignerType: TWxDesignerType read FWxDesignerType write SetDesignerType default dtWxDialog;

        property Wx_Border: integer read GetBorderWidth write SetBorderWidth default 5;
        property Wx_BorderAlignment: TWxBorderAlignment read GetBorderAlignment write SetBorderAlignment default [wxALL];
        property Wx_StretchFactor: integer read GetStretchFactor write SetStretchFactor default 0;

        property Wx_ProxyBGColorString: TWxColorString read FWx_ProxyBGColorString write FWx_ProxyBGColorString;
        property Wx_ProxyFGColorString: TWxColorString read FWx_ProxyFGColorString write FWx_ProxyFGColorString;

        property isAuimanagerAvailable: boolean read FisAuimanagerAvailable write FisAuimanagerAvailable;

    end;

var
    frmNewFormX: TfrmNewForm;

procedure GenerateCpp(frmNewForm: TfrmNewForm; strClassName: string; synEdit: TSynEdit);
procedure GenerateHpp(frmNewForm: TfrmNewForm; strClassName: string; synEdit: TSynEdit);
procedure GenerateXPM(frmNewForm: TfrmNewForm; strFileName: string;
    onlyForForm: boolean = FALSE);
procedure GenerateXRC(frmNewForm: TfrmNewForm; strClassName: string;
    synEdit: TSynEdit; strFileName: string);

implementation

uses dmCodeGen, WxStaticBitmap, wxdesigner;

{$R *.DFM}

procedure GenerateCpp(frmNewForm: TfrmNewForm; strClassName: string;
    synEdit: TSynEdit);
var
    i: integer;
    intBlockStart, intBlockEnd: integer;
    intManualBlockStart, intManualBlockEnd: integer;
    wxcompInterface: IWxComponentInterface;
    varIntf: IWxVariableAssignmentInterface;
    wxAuimanagerInterface: IWxAuiManagerInterface;
  //  wxAuiPaneInfoInterface: IWxAuiPaneInfoInterface;
//  wxAuiPaneInterface: IWxAuiPaneInterface;
    strEntry, strEventTableStart, strEventTableEnd: string;
    isSizerAvailable: boolean;
    hasImage: boolean;
  //  isAuimanagerAvailable: boolean;
    strHdrValue: string;
    strStartStr, strEndStr: string;
    strLst, strlstManualCode: TStringList;
    CntIntf: IWxContainerAndSizerInterface;
    strTemp: string;
begin

    hasImage := FALSE;

    if GetBlockStartAndEndPos(synEdit, strClassName, btClassNameGUIItemsCreation, intBlockStart, intBlockEnd) then
    begin
    //Clear Declaration and Creation Field
        DeleteAllClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd);

        isSizerAvailable := FALSE;
        for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
        begin
            if frmNewForm.Components[i].GetInterface(IID_IWxContainerAndSizerInterface, CntIntf) then
            begin
                isSizerAvailable := TRUE;
                break;
            end;
        end;

        hasImage := FALSE;
        for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
        begin
            if frmNewForm.Components[i].GetInterface(IWxImageContainerInterface, CntIntf) then
            begin
                hasImage := TRUE;
                break;
            end;
        end;

        frmNewForm.isAuimanagerAvailable := FALSE;
    //MN detect whether there is a wxAuiManager component
        for I := frmNewForm.ComponentCount - 1 downto 0 do // Iterate
        begin
      //  if frmNewForm.Components[i].Name = UpperCase('TWxAuiManager') then
            if frmNewForm.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface) then
            begin
                frmNewForm.isAuimanagerAvailable := TRUE;
                break;
            end;
        end; // for

      //  ALWAYS do this first, it should then be last in the list
        strTemp := frmNewForm.GenerateGUIControlCreation;
        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);


        if isSizerAvailable then
        begin
{
      strTemp := frmNewForm.GenerateGUIControlCreation;
          AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);
}
      //Add the Code Generation Items that need to be added after the creation with new
            for I := frmNewForm.ComponentCount - 1 downto 0 do // Iterate
            begin
                if not frmNewForm.Components[i].GetInterface(IID_IWxContainerAndSizerInterface, CntIntf) then
                    continue;
                strTemp := CntIntf.GenerateLastCreationCode;
                if trim(strTemp) = '' then
                    continue;
                AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);
                AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, '');
            end; // for
        end;

        if not isSizerAvailable then
        begin
            for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
            begin
                if frmNewForm.Components[i].GetInterface(IID_IWxContainerAndSizerInterface, CntIntf) then
                    continue;
                if not frmNewForm.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface)
          {and not frmNewForm.Components[i].GetInterface(IID_IWxAuiPaneInfoInterface, wxAuiPaneInfoInterface)} then
                begin

                    if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
                    begin
                        strTemp := wxcompInterface.GenerateGUIControlCreation;
                        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);
                    end;
                    AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, '');
                end;
            end; // for

      //MN detect whether there is a wxAuiManager component and do the code for that last
      //it is then first in the generated code
            for I := frmNewForm.ComponentCount - 1 downto 0 do // Iterate
            begin
                if frmNewForm.Components[i].GetInterface(IID_IWxContainerAndSizerInterface, CntIntf) then
                    continue;
        //  if frmNewForm.Components[i].Name = UpperCase('TWxAuiManager') then
                if frmNewForm.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface) then
                begin
                    if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
                    begin
                        strTemp := wxcompInterface.GenerateGUIControlCreation;
                        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);
                    end;
                    AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, '');
                end;
            end; // for
        end
        else
        begin

            for I := frmNewForm.ComponentCount - 1 downto 0 do // Iterate
            begin

                if not frmNewForm.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface)
          {and not frmNewForm.Components[i].GetInterface(IID_IWxAuiPaneInfoInterface, wxAuiPaneInfoInterface)} then
                begin

                    if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
                    begin
                        strTemp := wxcompInterface.GenerateGUIControlCreation;
                        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);
                    end;
                    AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, '');
                end;
            end; // for

      //MN detect whether there is a wxAuiManager component and do the code for that last
      //it is then first in the generated code

            for I := frmNewForm.ComponentCount - 1 downto 0 do // Iterate
            begin
        //  if frmNewForm.Components[i].Name = UpperCase('TWxAuiManager') then
                if frmNewForm.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface) then
                begin
                    if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
                    begin
                        strTemp := wxcompInterface.GenerateGUIControlCreation;
                        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);
                    end;
                    AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, '');
                end;
            end; // for

        end;

    //Form data should come first, if not the child will be resized to
        if not isSizerAvailable then
//Already done above
//      AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, frmNewForm.GenerateGUIControlCreation);
            if (XRCGEN) then //NUKLEAR ZELPH
            begin
                AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd,
                    'wxInitAllImageHandlers();' + #13 + 'wxXmlResource::Get()->InitAllHandlers();' + #13 + 'wxXmlResource::Get()->Load(' + StringFormat + '("' + strClassName + '.xml"));' + #13 + 'wxXmlResource::Get()->AddHandler(new wxRichTextCtrlXmlHandler);');
            end;
    end;

    if (hasImage) then
        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd,
            'wxInitAllImageHandlers();   //Initialize graphic format handlers' + #13);

  // RHS Variable
    if GetBlockStartAndEndPos(synEdit, strClassName, btRHSVariables, intBlockStart, intBlockEnd) then
    begin
        DeleteAllRHSVariableList(synEdit, strClassName, intBlockStart, intBlockEnd);

        for I := frmNewForm.ComponentCount - 1 downto 0 do // Iterate
        begin
        //            if frmNewForm.Components[i] is TPanel then
        //                continue;
            if frmNewForm.Components[i].GetInterface(IID_IWxVariableAssignmentInterface, varIntf) then
            begin
                strTemp := varIntf.GetRHSVariableAssignment;
                if (strTemp) = '' then
                    continue;
                AddRHSVariableList(synEdit, strClassName, intBlockStart, intBlockEnd, varIntf.GetRHSVariableAssignment);
            end;
            AddRHSVariableList(synEdit, strClassName, intBlockStart, intBlockEnd, '');
        end;// for;

    end;

  // LHS Variable
    if GetBlockStartAndEndPos(synEdit, strClassName, btLHSVariables, intBlockStart, intBlockEnd) then
    begin
        DeleteAllLHSVariableList(synEdit, strClassName, intBlockStart, intBlockEnd);
        for I := frmNewForm.ComponentCount - 1 downto 0 do // Iterate
        begin
        //            if frmNewForm.Components[i] is TPanel then
        //                continue;
            if frmNewForm.Components[i].GetInterface(IID_IWxVariableAssignmentInterface, varIntf) then
            begin
                strTemp := varIntf.GetLHSVariableAssignment;
                if (strTemp) = '' then
                    continue;
                AddLHSVariableList(synEdit, strClassName, intBlockStart, intBlockEnd, varIntf.GetLHSVariableAssignment);
            end;
            AddLHSVariableList(synEdit, strClassName, intBlockStart, intBlockEnd, '');
        end;// for;
    end;

  // Event table
    if GetBlockStartAndEndPos(synEdit, strClassName, btClassNameEventTableEntries, intBlockStart, intBlockEnd) then
    begin
        GetStartAndEndBlockStrings('', btManualCode, strStartStr, strEndStr);

        if GetBlockStartAndEndPos(synEdit, strClassName, btManualCode, intManualBlockStart, intManualBlockEnd) then
            strlstManualCode := GetBlockCode(synEdit, strClassName, btManualCode, intManualBlockStart, intManualBlockEnd)
        else
            strlstManualCode := TStringList.Create;

        try

            DeleteAllClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd);

            strEventTableEnd := 'END_EVENT_TABLE()';
            AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd, strEventTableEnd, FALSE);


    //EVT_CLOSE(%CLASS_NAME%:: OnQuit )
            for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
            begin
                wxcompInterface := NIL;
                if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
                begin
                    strEntry := wxcompInterface.GenerateEventTableEntries(strClassName);
        //SendDebug(strEntry);
                    AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd, strEntry);
                end;
      //AddClassNameEventTableEntries(strCppSrc, strClassName, intBlockStart, intBlockEnd, '');
            end; // for
         //Form data should come first, if not the child will be resized to
            strEntry := frmNewForm.GenerateEventTableEntries(strClassName);
    //SendDebug(strEntry);
            AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd, strEntry);

     //Manual Code Clear Declaration and Creation Field

            AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd, strEndStr);
            for I := strlstManualCode.Count - 1 downto 0 do    // Iterate
                AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd,
                    strlstManualCode[i]);    // for

        finally
            strlstManualCode.Destroy;
        end;

        AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd, strStartStr);

        strEventTableStart := Format('BEGIN_EVENT_TABLE(%s,%s)', [frmNewForm.Wx_Name, frmNewForm.Wx_Class]);
        AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd, strEventTableStart, FALSE);
    end;

  //Adding XPM Header files
  //A stupid way to find
    if GetBlockStartAndEndPos(synEdit, strClassName, btHeaderIncludes, intBlockStart, intBlockEnd) then
    begin
    //Clear Declaration and Creation Field
        DeleteAllClassNameIncludeHeader(synEdit, strClassName, intBlockStart, intBlockEnd);
        strHdrValue := '';
        strLst := TStringList.Create;
        for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
            if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
            begin
                strHdrValue := wxcompInterface.GenerateImageInclude;
                if strLst.indexOf(strHdrValue) = -1 then
                begin
                    strLst.add(strHdrValue);
                    AddClassNameIncludeHeader(synEdit, strClassName,
                        intBlockStart, intBlockEnd, strHdrValue);
                end;
            end;

        strHdrValue := trim(frmNewForm.GenerateImageInclude);
        if strHdrValue <> '' then
            if strLst.indexOf(strHdrValue) = -1 then
            begin
                strLst.add(strHdrValue);
                AddClassNameIncludeHeader(synEdit, strClassName, intBlockStart, intBlockEnd, strHdrValue);
            end;

        strLst.Destroy;
    end;
end;

procedure GenerateXRC(frmNewForm: TfrmNewForm; strClassName: string;
    synEdit: TSynEdit; strFileName: string);
var
    i: integer;
    wxcompInterface: IWxComponentInterface;
    tempstring: TStringList;
begin

    synEdit.Clear;
    synEdit.Lines.Add('<?xml version="1.0" encoding="ISO-8859-1"?>');
    synEdit.Lines.Add('<resource version="2.3.0.1">');
    synEdit.Lines.Add('<!-- Created by ' + GetAppVersion + ' -->');

    synEdit.Lines.Add(Format('<!--object class="%s" name="%s"-->',
        [frmNewForm.Wx_class, frmNewForm.Wx_Name]));
    synEdit.Lines.Add(Format('<!--title>%s</title-->', [frmNewForm.Caption]));
    synEdit.Lines.Add(Format('<!--IDident>%s</IDident-->', [frmNewForm.Wx_IDName]));
    synEdit.Lines.Add(Format('<!--ID>%d</ID-->', [frmNewForm.Wx_IDValue]));
    synEdit.Lines.Add(Format('<!--pos>%d,%d</pos-->', [frmNewForm.Left, frmNewForm.Top]));
    synEdit.Lines.Add(Format('<!--size>%d,%d</size-->',
        [frmNewForm.Width, frmNewForm.Height]));

    if GetStdStyleString(frmNewForm.Wx_GeneralStyle) = '' then
        if strEqual(frmNewForm.Wx_class, 'WxFrame') then
            synEdit.Lines.Add('<!--style>wxDEFAULT_FRAME_STYLE</style-->')
        else
            synEdit.Lines.Add('<!--style>wxDEFAULT_DIALOG_STYLE</style-->')
    else
        synEdit.Lines.Add(Format('<!--style>%s</style-->',
            [GetStdStyleString(frmNewForm.Wx_GeneralStyle)]));

    for i := 0 to frmNewForm.ComponentCount - 1 do // Iterate
        if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,
            wxcompInterface) then
      // Only add the XRC control if it is a child of the top-most parent (the form)
      //  If it is a child of a sizer, panel, or other object, then it's XRC code
      //  is created in GenerateXRCControlCreation of that control.
            if (frmNewForm.Components[i].GetParentComponent.Name = 'frmNewForm') then
            begin
                tempstring := wxcompInterface.GenerateXRCControlCreation('  ');
                try
                    synEdit.Lines.AddStrings(tempstring);
                finally
                    tempstring.Free;
                end;
            end; // for

    synEdit.Lines.Add('<!--/object-->');

    synEdit.Lines.Add('</resource>');

end;

procedure GenerateHpp(frmNewForm: TfrmNewForm; strClassName: string; synEdit: TSynEdit);
var
    i: integer;
    intBlockStart, intBlockEnd: integer;
    wxcompInterface: IWxComponentInterface;
    strLst: TStringList;
    strHdrValue, strIDValue, strLine: string;
begin
    if GetBlockStartAndEndPos(synEdit, strClassName, btClassNameGUIItemsDeclaration,
        intBlockStart, intBlockEnd) then
    begin
    //Clear Declaration and Creation Field
        DeleteAllClassNameGUIItemsDeclaration(synEdit, strClassName, intBlockStart,
            intBlockEnd);
        for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
            if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,
                wxcompInterface) then
                AddClassNameGUIItemsDeclaration(synEdit, strClassName, intBlockStart,
                    intBlockEnd, wxcompInterface.GenerateGUIControlDeclaration());
    end;

  //For Old #define styled Control Ids
    if GetBlockStartAndEndPos(synEdit, strClassName, btClassNameControlIdentifiers,
        intBlockStart, intBlockEnd) then
    begin
    //Clear Declaration and Creation Field
        DeleteAllClassNameControlIndentifiers(synEdit, strClassName, intBlockStart,
            intBlockEnd);
        strLst := TStringList.Create;
        for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
            if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,
                wxcompInterface) then
            begin
        //If the user is using a predefined ID then we dont generate ids for them
                if IsIDPredefined(trim(wxcompInterface.GetIDName), wx_designer.strStdwxIDList) then
                    continue;
                strIDValue := wxcompInterface.GenerateControlIDs;
                if trim(strIDValue) <> '' then
                    if strLst.indexOf(strIDValue) = -1 then
                    begin
                        strLst.Add(strIDValue);
                        AddClassNameControlIndentifiers(synEdit, strClassName, intBlockStart,
                            intBlockEnd, strIDValue);
                    end;
            end;
        strLst.Destroy;
    end;
  //New Enum Based Control Ids
    if GetBlockStartAndEndPos(synEdit, strClassName, btClassNameEnumControlIdentifiers,
        intBlockStart, intBlockEnd) then
    begin
    //Clear Declaration and Creation Field
        DeleteAllClassNameEnumControlIndentifiers(synEdit, strClassName,
            intBlockStart, intBlockEnd);
        strLst := TStringList.Create;
        for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
            if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,
                wxcompInterface) then
            begin
        //If the user is using a predefined ID then we dont generate ids for them
                if IsIDPredefined(trim(wxcompInterface.GetIDName), wx_designer.strStdwxIDList) then
                    continue;
                strIDValue := wxcompInterface.GenerateEnumControlIDs;
                if trim(strIDValue) <> '' then
                    if strLst.indexOf(strIDValue) = -1 then
                    begin
                        strLst.Add(strIDValue);
                        AddClassNameEnumControlIndentifiers(synEdit,
                            strClassName, intBlockStart, intBlockEnd, strIDValue);
                    end;
            end;
        if not (UseIndividEnums) then
        begin
            strIDValue := 'ID_DUMMY_START = 1000,';
            strLst.Add(strIDValue);
            AddClassNameEnumControlIndentifiers(synEdit,
                strClassName, intBlockStart, intBlockEnd, strIDValue);

        end;
        strLst.Destroy;
    end;

    if GetBlockStartAndEndPos(synEdit, strClassName, btDialogStyle, intBlockStart,
        intBlockEnd) then
    begin
    //Clear Declaration and Creation Field

    // We want to parse the #define line and just extract the name of
    //    the constant. The name used to be hardcoded as THIS_DIALOG_STYLE
    //    Now we'll use a name based on the CLASSNAME, but for backwards
    //    compatibility we need to just change the options, not the name
    //    itself.
    // Get the #define line  (it should be just after the start of the block)
        for I := intBlockStart to intBlockEnd do // Iterate
            if (strContainsU('#define', synEdit.Lines[I])) then
                strLine := Trim(synEdit.Lines[I]);

    // Tokenize the line by spaces
        strLst := TStringList.Create;   // Create a string list
        strTokenToStrings(strLine, ' ', strLst);
    // Break up the line wherever there is a space
        strLine := '#undef ' + strLst.Strings[1] + #13#10;
        strLine := strLine + strLst.Strings[0] + ' ' + strLst.Strings[1] +
            ' ' + frmNewForm.GetDialogStyleString;   // Get the first and second strings

        strLst.Destroy; // Destroy the string list

        DeleteAllDialogStyleDeclaration(synEdit, strClassName, intBlockStart,
            intBlockEnd);
        AddDialogStyleDeclaration(synEdit, strClassName, intBlockStart, intBlockEnd,
            strLine);

    end;

    if GetBlockStartAndEndPos(synEdit, strClassName, btHeaderIncludes,
        intBlockStart, intBlockEnd) then
    begin
    //Clear Declaration and Creation Field
        DeleteAllClassNameIncludeHeader(synEdit, strClassName, intBlockStart,
            intBlockEnd);
        strLst := TStringList.Create;
        for I := 0 to frmNewForm.ComponentCount - 1 do // Iterate
            if frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,
                wxcompInterface) then
            begin
                strHdrValue := wxcompInterface.GenerateHeaderInclude;
                if strLst.indexOf(strHdrValue) = -1 then
                begin
                    strLst.add(strHdrValue);
                    AddClassNameIncludeHeader(synEdit, strClassName,
                        intBlockStart, intBlockEnd, strHdrValue);
                end;
            end;
        if (XRCGEN) then //NUKLEAR ZELPH
        begin
            AddClassNameIncludeHeader(synEdit, strClassName, intBlockStart, intBlockEnd,
                '#include <wx/xrc/xmlres.h>' + #13 + '#include <wx/xrc/xh_all.h>');
        end;
        strLst.Destroy;
    end;

end;


procedure GenerateXPM(frmNewForm: TfrmNewForm; strFileName: string; onlyForForm: boolean);
var
    I: integer;
    xpmFileDir: string;
    fileStrlst: TStringList;
    strXPMContent, frmName: string;

begin

    if (frmNewForm.KeepFormat) then
        Exit;

    xpmFileDir := CreateGraphicFileDir(strFileName) + 'Images' + pd;

    if frmNewForm.Wx_ICON.Bitmap.handle <> 0 then
    begin
        
        if onlyForForm then
            DeleteFile(xpmFileDir + frmNewForm.GetGraphicFileName); //xpmFileDir + 'Self_' + frmNewForm.Wx_Name + '_XPM.xpm');

        if not fileexists(xpmFileDir + frmNewForm.GetGraphicFileName) then // + 'Self_' + frmNewForm.Wx_Name + '_XPM.xpm') then
        begin
            fileStrlst := TStringList.Create;
            try
                strXPMContent := GetXPMFromTPicture(strFileName, frmNewForm.Wx_ICON.Bitmap); //'Self_' + frmNewForm.Wx_Name, frmNewForm.Wx_ICON.Bitmap);
                if trim(strXPMContent) <> '' then
                begin
                    fileStrlst.Add(strXPMContent);
                    fileStrlst.SaveToFile(xpmFileDir + frmNewForm.GetGraphicFileName); //+ 'Self_' + frmNewForm.Wx_Name + '_XPM.xpm');
                end;
            except
            end;
            fileStrlst.Destroy;
        end;
    end;

    if onlyForForm = TRUE then
        exit;

    frmName := frmNewForm.Wx_Name + '_';
    for I := 0 to frmNewForm.ComponentCount - 1 do    // Iterate
    begin
        if frmNewForm.Components[I] is TWxStaticBitmap then
        begin
            if TWxStaticBitmap(frmNewForm.Components[I]).Picture.Bitmap.handle = 0 then
                continue;
            if not fileexists(xpmFileDir + frmName + frmNewForm.Components[I].Name + '_XPM.xpm') then
            begin
                fileStrlst := TStringList.Create;
                try
                    strXPMContent := GetXPMFromTPicture(frmName + frmNewForm.Components[I].Name, TWxStaticBitmap(frmNewForm.Components[I]).Picture.Bitmap);
                    if trim(strXPMContent) = '' then
                        continue;
                    fileStrlst.Add(strXPMContent);
                    fileStrlst.SaveToFile(xpmFileDir + frmName + frmNewForm.Components[I].Name + '_XPM.xpm');
                except
                end;
                fileStrlst.Destroy;
            end;
        end;    // for

        if frmNewForm.Components[I] is TWxToolButton then
        begin
            if TWxToolButton(frmNewForm.Components[I]).Wx_Bitmap.Bitmap.handle = 0 then
                continue;
            if not fileexists(xpmFileDir + frmName + frmNewForm.Components[I].Name + '_XPM.xpm') then
            begin
                fileStrlst := TStringList.Create;
                try
                    strXPMContent :=
                        GetXPMFromTPicture(frmName + frmNewForm.Components[I].Name, TWxToolButton(frmNewForm.Components[I]).Wx_Bitmap.Bitmap);
                    if trim(strXPMContent) = '' then
                        continue;
                    fileStrlst.Add(strXPMContent);
                    fileStrlst.SaveToFile(xpmFileDir + frmName + frmNewForm.Components[I].Name + '_XPM.xpm');
                except
                end;
                fileStrlst.Destroy;
            end;
        end;    // for

    end;
end;

procedure TfrmNewForm.SetDialogProperties;
begin
  //Free the old property list
    if Assigned(wx_PropertyList) then
        wx_PropertyList.Free;

  //Create the new one
    wx_PropertyList := TStringList.Create;

    try
        wx_PropertyList.Add('Wx_IDName:ID Name');
        wx_PropertyList.Add('Wx_IDValue:ID Value');
        wx_PropertyList.Add('Wx_Class:Class');
        wx_PropertyList.Add('Wx_Center:Center');
        wx_PropertyList.Add('Wx_HelpText:Help Text');
        wx_PropertyList.Add('Wx_ToolTips:Tooltip');
        wx_PropertyList.Add('Wx_Hidden:Hidden');
        wx_PropertyList.Add('Caption:Title');
        wx_PropertyList.Add('Height:Height');
        wx_PropertyList.Add('Width:Width');
        wx_PropertyList.Add('Left:Left');
        wx_PropertyList.Add('Top:Top');
        wx_PropertyList.Add('Font:Font');
        wx_PropertyList.Add('Wx_SizeToContents:Size to Contents');

        wx_PropertyList.Add('Wx_GeneralStyle:General Style');
        wx_PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
        wx_PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
        wx_PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
        wx_PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
        wx_PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
        wx_PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
        wx_PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
        wx_PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
        wx_PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
        wx_PropertyList.Add('wxVSCROLL:wxVSCROLL');
        wx_PropertyList.Add('wxHSCROLL:wxHSCROLL');
        wx_PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');
        wx_PropertyList.Add('wxNO_BORDER:wxNO_BORDER');
        wx_PropertyList.Add('wxALWAYS_SHOW_SB:wxALWAYS_SHOW_SB');
        wx_PropertyList.Add('wxFULL_REPAINT_ON_RESIZE:wxFULL_REPAINT_ON_RESIZE');

        wx_PropertyList.Add('Wx_DialogStyle:Dialog Style');
        wx_PropertyList.Add('wxCAPTION:wxCAPTION');
        wx_PropertyList.Add('wxNO_3D:wxNO_3D');
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
    except
        wx_PropertyList.Free;
        raise;
    end;

end;

procedure TfrmNewForm.SetFrameProperties();
begin
  //Free the old property list
    if Assigned(wx_PropertyList) then
        wx_PropertyList.Free;

  //Create the new one
    wx_PropertyList := TStringList.Create;

    wx_PropertyList.Add('Wx_SizeToContents:Size to Contents');
    wx_PropertyList.Add('Wx_IDName:ID Name');
    wx_PropertyList.Add('Wx_IDValue:ID Value');
    wx_PropertyList.Add('Wx_Class:Class');
    wx_PropertyList.Add('Wx_Center:Center');
    wx_PropertyList.Add('Wx_HelpText:Help Text');
    wx_PropertyList.Add('Wx_ToolTips:Tooltip');
    wx_PropertyList.Add('Wx_Hidden:Hidden');
    wx_PropertyList.Add('Caption:Title');
    wx_PropertyList.Add('Height:Height');
    wx_PropertyList.Add('Width:Width');
    wx_PropertyList.Add('Left:Left');
    wx_PropertyList.Add('Top:Top');
    wx_PropertyList.Add('Font:Font');

    wx_PropertyList.Add('Wx_GeneralStyle:General Style');
    wx_PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
    wx_PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
    wx_PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
    wx_PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
    wx_PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
    wx_PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
    wx_PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
    wx_PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
    wx_PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
    wx_PropertyList.Add('wxVSCROLL:wxVSCROLL');
    wx_PropertyList.Add('wxHSCROLL:wxHSCROLL');
    wx_PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');
    wx_PropertyList.Add('wxNO_BORDER:wxNO_BORDER');
    wx_PropertyList.Add('wxALWAYS_SHOW_SB:wxALWAYS_SHOW_SB');
    wx_PropertyList.Add('wxFULL_REPAINT_ON_RESIZE:wxFULL_REPAINT_ON_RESIZE');

    wx_PropertyList.Add('Wx_DialogStyle:Frame Style');
    wx_PropertyList.Add('wxCAPTION:wxCAPTION');
    wx_PropertyList.Add('wxNO_3D:wxNO_3D');
    wx_PropertyList.Add('wxRESIZE_BORDER:wxRESIZE_BORDER');
    wx_PropertyList.Add('wxSYSTEM_MENU:wxSYSTEM_MENU');
    wx_PropertyList.Add('wxTHICK_FRAME:wxTHICK_FRAME');
    wx_PropertyList.Add('wxSTAY_ON_TOP:wxSTAY_ON_TOP');
    wx_PropertyList.Add('wxFRAME_NO_PARENT:wxFRAME_NO_PARENT');
    wx_PropertyList.Add('wxFRAME_EX_CONTEXTHELP:wxFRAME_EX_CONTEXTHELP');
    wx_PropertyList.Add('wxMINIMIZE_BOX:wxMINIMIZE_BOX');
    wx_PropertyList.Add('wxMAXIMIZE_BOX:wxMAXIMIZE_BOX');
    wx_PropertyList.Add('wxCLOSE_BOX:wxCLOSE_BOX');
    wx_PropertyList.Add('wxICONIZE:wxICONIZE');
    wx_PropertyList.Add('wxMINIMIZE:wxMINIMIZE');
    wx_PropertyList.Add('wxMAXIMIZE:wxMAXIMIZE');
    wx_PropertyList.Add('wxFRAME_TOOL_WINDOW:wxFRAME_TOOL_WINDOW');
    wx_PropertyList.Add('wxFRAME_NO_TASKBAR:wxFRAME_NO_TASKBAR');
    wx_PropertyList.Add('wxFRAME_FLOAT_ON_PARENT:wxFRAME_FLOAT_ON_PARENT');
    wx_PropertyList.Add('wxFRAME_SHAPED:wxFRAME_SHAPED');
    wx_PropertyList.Add('Wx_Name:Name');
    wx_PropertyList.Add('Wx_ICON:Icon');

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

procedure TfrmNewForm.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  //Result:=WxControlNone;
end;

function TfrmNewForm.GetStretchFactor: integer;
begin
    Result := 0;
end;

procedure TfrmNewForm.SetStretchFactor(intValue: integer);
begin
end;

function TfrmNewForm.GetEventList: TStringList;
begin
    Result := FWx_EventList;
end;

function TfrmNewForm.GetBorderAlignment: TWxBorderAlignment;
begin
    Result := [];
end;

procedure TfrmNewForm.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TfrmNewForm.GetBorderWidth: integer;
begin
    Result := 0;
end;

procedure TfrmNewForm.SetBorderWidth(width: integer);
begin
end;

procedure TfrmNewForm.FormMove(var Msg: TWMMove);
begin
    wx_designer.ELDesigner1Modified(wx_designer.ELDesigner1);
    inherited;
end;

function TfrmNewForm.GenerateControlIDs: string;
begin
    if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result := Format('#define %s %d', [Wx_IDName, Wx_IDValue]);
end;

function TfrmNewForm.GenerateEnumControlIDs: string;
begin
    if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result := Format('%s = %d,', [Wx_IDName, Wx_IDValue]);
end;


function TfrmNewForm.GenerateEventTableEntries(CurrClassName: string): string;
begin
    Result := '';
    if trim(EVT_UPDATE_UI) <> '' then
        Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
            [trim(Self.wx_IDName), CurrClassName, EVT_UPDATE_UI]) + '';


    if trim(EVT_CLOSE) <> '' then
        Result := Result + #13 + Format('EVT_CLOSE(%s::%s)',
            [CurrClassName, EVT_CLOSE]) + '';


    if trim(EVT_CHAR) <> '' then
        Result := Result + #13 + Format('EVT_CHAR(%s::%s)', [CurrClassName,
            EVT_CHAR]) + '';

    if trim(EVT_KEY_UP) <> '' then
        Result := Result + #13 + Format('EVT_KEY_UP(%s::%s)', [CurrClassName,
            EVT_KEY_UP]) + '';

    if trim(EVT_KEY_DOWN) <> '' then
        Result := Result + #13 + Format('EVT_KEY_DOWN(%s::%s)', [CurrClassName,
            EVT_KEY_DOWN]) + '';

    if trim(EVT_ERASE_BACKGROUND) <> '' then
        Result := Result + #13 + Format('EVT_ERASE_BACKGROUND(%s::%s)',
            [CurrClassName, EVT_ERASE_BACKGROUND]) + '';

    if trim(EVT_SIZE) <> '' then
        Result := Result + #13 + Format('EVT_SIZE(%s::%s)', [CurrClassName,
            EVT_SIZE]) + '';

    if trim(EVT_SET_FOCUS) <> '' then
        Result := Result + #13 + Format('EVT_SET_FOCUS(%s::%s)', [CurrClassName,
            EVT_SET_FOCUS]) + '';

    if trim(EVT_KILL_FOCUS) <> '' then
        Result := Result + #13 + Format('EVT_KILL_FOCUS(%s::%s)', [CurrClassName,
            EVT_KILL_FOCUS]) + '';

    if trim(EVT_ENTER_WINDOW) <> '' then
        Result := Result + #13 + Format('EVT_ENTER_WINDOW(%s::%s)', [CurrClassName,
            EVT_ENTER_WINDOW]) + '';

    if trim(EVT_LEAVE_WINDOW) <> '' then
        Result := Result + #13 + Format('EVT_LEAVE_WINDOW(%s::%s)', [CurrClassName,
            EVT_LEAVE_WINDOW]) + '';

    if trim(EVT_MOTION) <> '' then
        Result := Result + #13 + Format('EVT_MOTION(%s::%s)', [CurrClassName,
            EVT_MOTION]) + '';

    if trim(EVT_LEFT_DOWN) <> '' then
        Result := Result + #13 + Format('EVT_LEFT_DOWN(%s::%s)', [CurrClassName,
            EVT_LEFT_DOWN]) + '';

    if trim(EVT_LEFT_UP) <> '' then
        Result := Result + #13 + Format('EVT_LEFT_UP(%s::%s)', [CurrClassName,
            EVT_LEFT_UP]) + '';

    if trim(EVT_RIGHT_DOWN) <> '' then
        Result := Result + #13 + Format('EVT_RIGHT_DOWN(%s::%s)', [CurrClassName,
            EVT_RIGHT_DOWN]) + '';

    if trim(EVT_RIGHT_UP) <> '' then
        Result := Result + #13 + Format('EVT_RIGHT_UP(%s::%s)', [CurrClassName,
            EVT_RIGHT_UP]) + '';

    if trim(EVT_MIDDLE_UP) <> '' then
        Result := Result + #13 + Format('EVT_MIDDLE_UP(%s::%s)', [CurrClassName,
            EVT_MIDDLE_UP]) + '';

    if trim(EVT_LEFT_DCLICK) <> '' then
        Result := Result + #13 + Format('EVT_LEFT_DCLICK(%s::%s)', [CurrClassName,
            EVT_LEFT_DCLICK]) + '';

    if trim(EVT_RIGHT_DCLICK) <> '' then
        Result := Result + #13 + Format('EVT_RIGHT_DCLICK(%s::%s)', [CurrClassName,
            EVT_RIGHT_DCLICK]) + '';

    if trim(EVT_MIDDLE_DCLICK) <> '' then
        Result := Result + #13 + Format('EVT_MIDDLE_DCLICK(%s::%s)', [CurrClassName,
            EVT_MIDDLE_DCLICK]) + '';

    if trim(EVT_PAINT) <> '' then
        Result := Result + #13 + Format('EVT_PAINT(%s::%s)', [CurrClassName,
            EVT_PAINT]) + '';

    if trim(EVT_INIT_DIALOG) <> '' then
        Result := Result + #13 + Format('EVT_INIT_DIALOG(%s::%s)', [CurrClassName,
            EVT_INIT_DIALOG]) + '';

    if trim(EVT_SCROLLWIN) <> '' then
        Result := Result + #13 + Format('EVT_SCROLLWIN(%s::%s)', [CurrClassName,
            EVT_SCROLLWIN]) + '';

    if trim(EVT_SCROLLWIN_TOP) <> '' then
        Result := Result + #13 + Format('EVT_SCROLLWIN_TOP(%s::%s)', [CurrClassName,
            EVT_SCROLLWIN_TOP]) + '';

    if trim(EVT_SCROLLWIN_BOTTOM) <> '' then
        Result := Result + #13 + Format('EVT_SCROLLWIN_BOTTOM(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_BOTTOM]) + '';

    if trim(EVT_SCROLLWIN_LINEUP) <> '' then
        Result := Result + #13 + Format('EVT_SCROLLWIN_LINEUP(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_LINEUP]) + '';

    if trim(EVT_SCROLLWIN_LINEDOWN) <> '' then
        Result := Result + #13 + Format('EVT_SCROLLWIN_LINEDOWN(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_LINEDOWN]) + '';

    if trim(EVT_SCROLLWIN_PAGEUP) <> '' then
        Result := Result + #13 + Format('EVT_SCROLLWIN_PAGEUP(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_PAGEUP]) + '';

    if trim(EVT_SCROLLWIN_PAGEDOWN) <> '' then
        Result := Result + #13 + Format('EVT_SCROLLWIN_PAGEDOWN(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_PAGEDOWN]) + '';

    if trim(EVT_SCROLLWIN_THUMBTRACK) <> '' then
        Result := Result + #13 + Format('EVT_SCROLLWIN_THUMBTRACK(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_THUMBTRACK]) + '';

    if trim(EVT_SCROLLWIN_THUMBRELEASE) <> '' then
        Result := Result + #13 + Format('EVT_SCROLLWIN_THUMBRELEASE(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_THUMBRELEASE]) + '';

    if trim(EVT_SYS_COLOUR_CHANGED) <> '' then
        Result := Result + #13 + Format('EVT_SYS_COLOUR_CHANGED(%s::%s)',
            [CurrClassName, EVT_SYS_COLOUR_CHANGED]) + '';
    if trim(EVT_IDLE) <> '' then
        Result := Result + #13 + Format('EVT_IDLE(%s::%s)',
            [CurrClassName, EVT_IDLE]) + '';
    if trim(EVT_ACTIVATE) <> '' then
        Result := Result + #13 + Format('EVT_ACTIVATE(%s::%s)',
            [CurrClassName, EVT_ACTIVATE]) + '';
    if trim(EVT_ACTIVATE_APP) <> '' then
        Result := Result + #13 + Format('EVT_ACTIVATE_APP(%s::%s)',
            [CurrClassName, EVT_ACTIVATE_APP]) + '';
    if trim(EVT_QUERY_END_SESSION) <> '' then
        Result := Result + #13 + Format('EVT_QUERY_END_SESSION(%s::%s)',
            [CurrClassName, EVT_QUERY_END_SESSION]) + '';
    if trim(EVT_END_SESSION) <> '' then
        Result := Result + #13 + Format('EVT_END_SESSION(%s::%s)',
            [CurrClassName, EVT_END_SESSION]) + '';
    if trim(EVT_DROP_FILES) <> '' then
        Result := Result + #13 + Format('EVT_DROP_FILES(%s::%s)',
            [CurrClassName, EVT_DROP_FILES]) + '';
    if trim(EVT_SPLITTER_SASH_POS_CHANGED) <> '' then
        Result := Result + #13 + Format('EVT_SPLITTER_SASH_POS_CHANGED(%s::%s)',
            [CurrClassName, EVT_SPLITTER_SASH_POS_CHANGED]) + '';
    if trim(EVT_SPLITTER_UNSPLIT) <> '' then
        Result := Result + #13 + Format('EVT_SPLITTER_UNSPLIT(%s::%s)',
            [CurrClassName, EVT_SPLITTER_UNSPLIT]) + '';
    if trim(EVT_SPLITTER_DCLICK) <> '' then
        Result := Result + #13 + Format('EVT_SPLITTER_DCLICK(%s::%s)',
            [CurrClassName, EVT_SPLITTER_DCLICK]) + '';
    if trim(EVT_JOY_BUTTON_DOWN) <> '' then
        Result := Result + #13 + Format('EVT_JOY_BUTTON_DOWN(%s::%s)',
            [CurrClassName, EVT_JOY_BUTTON_DOWN]) + '';
    if trim(EVT_JOY_BUTTON_UP) <> '' then
        Result := Result + #13 + Format('EVT_JOY_BUTTON_UP(%s::%s)',
            [CurrClassName, EVT_JOY_BUTTON_UP]) + '';
    if trim(EVT_JOY_MOVE) <> '' then
        Result := Result + #13 + Format('EVT_JOY_MOVE(%s::%s)',
            [CurrClassName, EVT_JOY_MOVE]) + '';
    if trim(EVT_JOY_ZMOVE) <> '' then
        Result := Result + #13 + Format('EVT_JOY_ZMOVE(%s::%s)',
            [CurrClassName, EVT_JOY_ZMOVE]) + '';
    if trim(EVT_MENU_OPEN) <> '' then
        Result := Result + #13 + Format('EVT_MENU_OPEN(%s::%s)',
            [CurrClassName, EVT_MENU_OPEN]) + '';
    if trim(EVT_MENU_CLOSE) <> '' then
        Result := Result + #13 + Format('EVT_MENU_CLOSE(%s::%s)',
            [CurrClassName, EVT_MENU_CLOSE]) + '';
    if trim(EVT_MENU_HIGHLIGHT_ALL) <> '' then
        Result := Result + #13 + Format('EVT_MENU_HIGHLIGHT_ALL(%s::%s)',
            [CurrClassName, EVT_MENU_HIGHLIGHT_ALL]) + '';
    if trim(EVT_MOUSEWHEEL) <> '' then
        Result := Result + #13 + Format('EVT_MOUSEWHEEL(%s::%s)',
            [CurrClassName, EVT_MOUSEWHEEL]) + '';
    if trim(EVT_MOUSE_EVENTS) <> '' then
        Result := Result + #13 + Format('EVT_MOUSE_EVENTS(%s::%s)',
            [CurrClassName, EVT_MOUSE_EVENTS]) + '';

end;

function TfrmNewForm.GetDialogStyleString: string;
begin
  // This used to be hardcoded as THIS_DIALOG_STYLE
    if (self.Wx_DialogStyle <> []) or (self.Wx_GeneralStyle <> []) then
        Result := GetDialogSpecificStyle(self.Wx_GeneralStyle, self.Wx_DialogStyle,
            self.Wx_Class)
    else
    if (strEqual(self.Wx_Class, 'wxDialog')) then
        Result := 'wxDEFAULT_DIALOG_STYLE'
    else
    if (strEqual(self.Wx_Class, 'wxFrame')) then
        Result := 'wxDEFAULT_FRAME_STYLE';

end;

function TfrmNewForm.GenerateXRCControlCreation(IndentString: string): TStringList;
begin
    Result := TStringList.Create;
end;

function TfrmNewForm.GenerateGUIControlCreation: string;
var
    I, J, MaxToolWidth, MaxToolHt, MaxSepValue: integer;
    strLst: TStringList;
    isSizerAvailable: boolean;
  //  isAuimanagerAvailable: boolean;
    //WinRect: TRect;
    wxtoolbarintf: IWxToolBarInterface;
    strTemp: string;
    sizerParentName: string;
begin
    strLst := TStringList.Create;

    if self.Wx_DesignerType = dtWxFrame then
   // for I := self.ComponentCount - 1 downto 0 do    // Iterate
        for I := 0 to self.ComponentCount - 1 do    // Iterate
        begin
            if IsControlWxToolBar(TControl(Components[i])) then
            begin
                MaxToolWidth := 16;
                MaxToolHt := 15;
                MaxSepValue := 5;
                for J := 0 to TWinControl(Components[i]).ControlCount - 1 do
          // Iterate
                begin
                    if (TWinControl(Components[i]).Controls[J] is TWxSeparator) then
                        if TWinControl(Components[i]).Controls[J].Width > MaxSepValue then
                            MaxSepValue := TWinControl(Components[i]).Controls[J].Width;

                    if (TWinControl(Components[i]).Controls[J] is TWxToolButton) then
                        if TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap <> NIL then
                        begin
                            if TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap.Height > MaxToolHt then
                                MaxToolHt :=
                                    TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap.Height;

                            if TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap.Width > MaxToolWidth then
                                MaxToolWidth :=
                                    TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap.Width;
                        end;
                end;    // for

                if not (XRCGEN) then //NUKLEAR ZELPH
	               begin
                    if not ((MaxToolWidth = 16) and (MaxToolHt = 15)) then
                        strLst.add(Format('%s->SetToolBitmapSize(wxSize(%d,%d));',
                            [self.Components[i].Name, MaxToolWidth, MaxToolHt]));

                    if (MaxSepValue <> 5) then
                        strLst.add(Format('%s->SetToolSeparation(%d);',
                            [self.Components[i].Name, MaxSepValue]));

                    if Self.Components[i].GetInterface(IID_IWxToolBarInterface, wxtoolbarintf) then
                    begin
                        strTemp := wxtoolbarintf.GetRealizeString;
                        strLst.add(strTemp);
                    end;

          {          if not IsControlWxAuiToolBar(TControl(Components[i])) then
          begin
        strLst.add(Format('%s->Realize();', [self.Components[i].Name]));
        strLst.add(Format('SetToolBar(%s);', [self.Components[i].Name]));
          end;
          if IsControlWxAuiToolBar(TControl(Components[i])) then
          begin
            strLst.add(Format('%s->Realize();', [self.Components[i].Name]));
          end;
 }
                end; //not xrcgen
            end;

            if IsControlWxStatusBar(TControl(Components[i])) then
                strLst.add(Format('SetStatusBar(%s);', [self.Components[i].Name]));
        end;

    isSizerAvailable := FALSE;
    sizerParentName := '';
    isAuimanagerAvailable := FALSE;
    for I := 0 to self.ComponentCount - 1 do
    begin // Iterate
        if self.Components[i] is TWxSizerPanel then
        begin
            if not (isSizerAvailable) then
            begin
                isSizerAvailable := TRUE;

        // Bug fix for #2695519
        // Need to refer to parent name rather than always referring to 'this->'
                if (TControl(Components[i]).Parent is TForm) then
                    sizerParentName := '' //'this' + '->'
                else
                    sizerParentName := TControl(Components[i]).Parent.Name + '->';
            end;
      //      break;
        end;
        if self.Components[i] is TWxAuiManager then
        begin
            isAuimanagerAvailable := TRUE;
      //      break;
        end;
    end;
    strLst.add(Format('SetTitle(%s);', [GetCppString(self.Caption)]));

    if assigned(Wx_ICON) then
    begin
        if Wx_ICON.Bitmap.Handle = 0 then
            strLst.add('SetIcon(wxNullIcon);')
        else
        if (KeepFormat) then
        begin
            Wx_FileName := AnsiReplaceText(Wx_FileName, '\', '/');
            strLst.add('SetIcon(' + 'wxIcon("' + Wx_FileName + '", wxBITMAP_TYPE_' +
                GetExtension(Wx_FileName) + '));');
        end
        else
        begin
      //strLst.add('wxIcon ' + self.Wx_Name + '_ICON' + ' (' +Self_'+self.Wx_Name + '_XPM' + ');');
            strLst.add('SetIcon(' + GetDesignerFormName(self) + '_' + self.Name + '_XPM' + ');');
        end;
    end;

    if trim(self.Wx_ToolTips) <> '' then
        strLst.add(Format('SetToolTip(%s);', [GetCppString(self.Wx_ToolTips)]));

    if isSizerAvailable and not isAuiManagerAvailable then
    begin
        if strLst.Count <> 0 then
            strLst.add('');

        if (sizerParentName = '') then
        begin
            strLst.Add('Layout();');
            strLst.add('GetSizer()->Fit(this);');
            if Wx_SizeToContents then
                strLst.add('GetSizer()->SetSizeHints(this);');
        end;
    end
    else
    begin
        strLst.add(Format('SetSize(%d,%d,%d,%d);', [self.left, self.top, self.Width, self.Height]));
    end;

    if self.Wx_Center then
        strLst.add('Center();');

    if isAuiManagerAvailable then
    begin
        if self.Wx_DesignerType = dtWxFrame then
            for I := self.ComponentCount - 1 downto 0 do // Iterate
                if IsControlWxToolBar(TControl(Components[i])) and not IsControlWxAuiToolBar(TControl(Components[i])) then
                begin
                    strLst.add('SetToolBar(NULL);');
                    break;
                end;

        for I := self.ComponentCount - 1 downto 0 do // Iterate
        begin
            if self.Components[i] is TWxAuiManager then
            begin
                strLst.add(Format('%s->Update();', [self.Components[i].Name]));
            end;
        end;
    end;

    Result := strLst.Text;
    strLst.Destroy;

end;

function TfrmNewForm.GenerateGUIControlDeclaration: string;
begin
  //Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TfrmNewForm.GenerateHeaderInclude: string;
begin
    Result := '';
end;

function TfrmNewForm.GenerateImageInclude: string;
begin
    if assigned(Wx_ICON) then
        if Wx_ICON.Bitmap.Handle <> 0 then
            if (not KeepFormat) then
                Result := '#include "' + GetGraphicFileName + '"';

end;


function TfrmNewForm.GetIDName: string;
begin
    Result := wx_IDName;
end;

function TfrmNewForm.GetIDValue: integer;
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
            Wx_Class := 'wxDialog';

        if Wx_DesignerType = dtWxFrame then
            Wx_Class := 'wxFrame';

        if Wx_DesignerType = dtWxWizard then
            Wx_Class := 'wxWizard';

    end;
    Result := wx_Class;
end;

procedure TfrmNewForm.SetIDName(IDName: string);
begin
    wx_IDName := IDName;
end;

procedure TfrmNewForm.SetIDValue(IDValue: integer);
begin
    Wx_IDValue := IDValue;
end;

procedure TfrmNewForm.SetWxClassName(wxClassName: string);
begin
    wx_Class := wxClassName;
end;

procedure TfrmNewForm.CreateInitVars;
begin
    OldCreateOrder := TRUE;
    AutoScroll := FALSE;
    Caption := 'New Dialog';
    Wx_IDName := 'ID_DIALOG1';
    Wx_IDValue := 1000;
    Wx_Class := 'wxDialog';
    Wx_Center := FALSE;
    Wx_ToolTips := '';
    Wx_Hidden := FALSE;
    Wx_SizeToContents := TRUE;
    Wx_Icon := TPicture.Create;

    SetDialogProperties;
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
end;

procedure TfrmNewForm.FormCreate(Sender: TObject);
var
    hMenuHandle: HMENU;

begin
    DesktopFont := TRUE;
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
    wx_designer.ELDesigner1Modified(wx_designer.ELDesigner1);
end;

procedure TfrmNewForm.FormDestroy(Sender: TObject);
begin
    Wx_PropertyList.Destroy;
    FWx_EventList.Destroy;
    FWx_Icon.Destroy;
end;

function TfrmNewForm.GetGenericColor(strVariableName: string): string;
begin

end;
procedure TfrmNewForm.SetGenericColor(strVariableName, strValue: string);
begin

end;

function TfrmNewForm.GetFGColor: string;
begin
    Result := Wx_ProxyFGColorString.strColorValue;
end;

procedure TfrmNewForm.SetFGColor(strValue: string);
begin
    Wx_ProxyFGColorString.strColorValue := strValue;
    self.Color := GetColorFromString(strValue);
end;

function TfrmNewForm.GetBGColor: string;
begin
    Result := Wx_ProxyBGColorString.strColorValue;
end;

procedure TfrmNewForm.SetBGColor(strValue: string);
begin
    Wx_ProxyBGColorString.strColorValue := strValue;
    self.Font.Color := GetColorFromString(strValue);
end;

procedure TfrmNewForm.SetDesignerType(Value: TWxDesignerType);
begin

    Wx_Class := 'wxDialog';

    if Value = dtWxFrame then
    begin
        Wx_Class := 'wxFrame';
        self.Color := clAppWorkSpace;
    //self.BorderStyle:=bsSingle;
        SetFrameProperties();
    end;

    if Value = dtWxWizard then
        Wx_Class := 'wxWizard';
    FWxDesignerType := Value;

end;

function TfrmNewForm.GetFormName: string;
begin
    Result := FWx_Name;
end;

procedure TfrmNewForm.SetFormName(StrValue: string);
begin
    FWx_Name := strValue;
end;

procedure TfrmNewForm.CreateNewXPMs(strFileName: string);
var
    i, j: integer;
    imgCtrl: IWxImageContainerInterface;
    mnuCtrl: IWxMenuBarInterface;
    bmp: TBitmap;
    strPropertyName, strXPMFileName: string;
begin
    for i := 0 to self.ComponentCount - 1 do
    begin
        if self.Components[i].GetInterface(IID_IWxImageContainerInterface, imgCtrl) = FALSE then
        begin
            if self.Components[i].GetInterface(IDD_IWxMenuBarInterface, mnuCtrl) = TRUE then
                mnuCtrl.GenerateXPM(strFileName);
            continue;
        end;

        for j := 0 to imgCtrl.GetBitmapCount - 1 do
        begin
            if not imgCtrl.PreserveFormat then
            begin
                strXPMFileName := IncludeTrailingPathDelimiter(ExtractFilePath(strFileName)) + 'Images\' + Wx_Name + '_' + imgCtrl.GetPropertyName(j) + '.xpm';
                if FileExists(strXPMFileName) then
                    continue;
                bmp := NIL;
                imgCtrl.GetBitmap(j, bmp, strPropertyName);
                if bmp <> NIL then
                    GenerateXPMDirectly(bmp, strPropertyName, wx_Name, strFileName);
            end;
        end;
    end;
    

    strXPMFileName := GetGraphicFilename(); //'Images\Self_' + wx_Name + '.xpm';
    if FileExists(strXPMFileName) and (Wx_ICON.Bitmap <> NIL) then
    begin
        GenerateXPMDirectly(Wx_ICON.Bitmap, GetDesignerFormName(self), wx_Name, strFileName);
    end;
end;

function TfrmNewForm.GetBitmapCount: integer;
begin
    Result := 1;
end;

function TfrmNewForm.GetBitmap(Idx: integer; var bmp: TBitmap; var PropertyName: string): boolean;
begin
    bmp.Assign(Wx_ICON.Bitmap);
    Result := TRUE;
end;


function TfrmNewForm.GetPropertyName(Idx: integer): string;
begin
    Result := wx_Name;
end;

function TfrmNewForm.GetGraphicFileName: string;
begin
    Result := Wx_FileName;
end;

function TfrmNewForm.SetGraphicFileName(strFileName: string): boolean;
begin

  // If no filename passed, then auto-generate XPM filename
    if (strFileName = '') then
        strFileName := GetDesignerFormName(self) + '_' + self.Name + '_XPM.xpm';

    if not KeepFormat then
        strFileName := 'Images\' + strFileName;

    Wx_Filename := CreateGraphicFileName(strFileName);
    Result := TRUE;

end;

procedure TfrmNewForm.FormClick(Sender: TObject);
begin
    if (wx_designer.ELDesigner1.Floating) then
    begin
        wx_designer.main.SetPageControlActivePageEditor(ChangeFileExt(self.fileName, WXFORM_EXT));
        wx_designer.MainPageChanged(ChangeFileExt(self.fileName, WXFORM_EXT));
        self.Show;
    end;
end;

procedure TfrmNewForm.WMNCLButtonDown(var Msg: TWMNCLButtonDown);
begin
    if (Msg.HitTest = htCaption) and (wx_designer.ELDesigner1.Floating) then
    begin
        wx_designer.main.SetPageControlActivePageEditor(ChangeFileExt(self.fileName, WXFORM_EXT));
        wx_designer.MainPageChanged(ChangeFileExt(self.fileName, WXFORM_EXT));
        self.Show;
    end;
    inherited;
end;

procedure TfrmNewForm.WMNCRButtonDown(var Msg: TWMNCRButtonDown);
begin
    if (Msg.HitTest = htCaption) and (wx_designer.ELDesigner1.Floating) then
    begin
        wx_designer.main.SetPageControlActivePageEditor(ChangeFileExt(self.fileName, WXFORM_EXT));
        wx_designer.MainPageChanged(ChangeFileExt(self.fileName, WXFORM_EXT));
        self.Show;
    end;
    inherited;
end;

function TfrmNewForm.HasAuiManager: boolean;
begin
    Result := Self.isAuimanagerAvailable;
end;

{ Read method for property Wx_DialogStyle }
function TfrmNewForm.GetWx_DialogStyle: TWxDlgStyleSet;
begin
    Result := FWxFrm_DialogStyle;
end;

function GetRefinedWxDialogStyleValue(sValue: TWxDlgStyleSet): TWxDlgStyleSet;
begin
    Result := [];

    try

        if wxCAPTION in sValue then
            Result := Result + [wxCAPTION];

        if wxRESIZE_BORDER in sValue then
            Result := Result + [wxRESIZE_BORDER];

        if wxSYSTEM_MENU in sValue then
            Result := Result + [wxSYSTEM_MENU];

        if wxTHICK_FRAME in sValue then
            Result := Result + [wxTHICK_FRAME];

        if wxSTAY_ON_TOP in sValue then
            Result := Result + [wxSTAY_ON_TOP];

        if wxDIALOG_NO_PARENT in sValue then
            Result := Result + [wxDIALOG_NO_PARENT];

        if wxDIALOG_EX_CONTEXTHELP in sValue then
            Result := Result + [wxDIALOG_EX_CONTEXTHELP];

        if wxMINIMIZE_BOX in sValue then
            Result := Result + [wxMINIMIZE_BOX];

        if wxMAXIMIZE_BOX in sValue then
            Result := Result + [wxMAXIMIZE_BOX];

        if wxCLOSE_BOX in sValue then
            Result := Result + [wxCLOSE_BOX];

        if wxNO_3D in sValue then
            Result := Result + [wxNO_3D];

        if wxDEFAULT_DIALOG_STYLE in sValue then
            Result := Result + [wxDEFAULT_DIALOG_STYLE];

        if wxDEFAULT_FRAME_STYLE in sValue then
            Result := Result + [wxDEFAULT_FRAME_STYLE];

        if wxMINIMIZE in sValue then
            Result := Result + [wxMINIMIZE];

        if wxMAXIMIZE in sValue then
            Result := Result + [wxMAXIMIZE];

        if wxFRAME_TOOL_WINDOW in sValue then
            Result := Result + [wxFRAME_TOOL_WINDOW];

        if wxFRAME_NO_TASKBAR in sValue then
            Result := Result + [wxFRAME_NO_TASKBAR];

        if wxFRAME_FLOAT_ON_PARENT in sValue then
            Result := Result + [wxFRAME_FLOAT_ON_PARENT];

        if wxFRAME_EX_CONTEXTHELP in sValue then
            Result := Result + [wxFRAME_EX_CONTEXTHELP];

        if wxFRAME_SHAPED in sValue then
            Result := Result + [wxFRAME_SHAPED];

    finally
        sValue := [];
    end;

end;

{ Write method for property Wx_DialogStyle }
procedure TfrmNewForm.SetWx_DialogStyle(Value: TWxDlgStyleSet);
begin
    FWxFrm_DialogStyle := GetRefinedWxDialogStyleValue(Value);
end;

function TfrmNewForm.PreserveFormat: boolean;
begin
    Result := KeepFormat;
end;

end.
