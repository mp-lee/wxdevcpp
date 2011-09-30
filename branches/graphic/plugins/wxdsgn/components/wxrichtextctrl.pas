 { ****************************************************************** }
 {                                                                    }
 { $Id: wxrichtextctrl.pas 936 2007-05-15 03:47:39Z gururamnath $           }
 {                                                                    }
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

unit WxRichTextCtrl;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxAuiToolBar, WxAuiNotebookPage, WxSizerPanel, Dialogs,
  xprocs,ComCtrls, UValidator;

type
  TWxRichTextCtrl = class(TRichEdit, IWxComponentInterface,IWxVariableAssignmentInterface,
         IWxValidatorInterface)
  private
    { Private fields of TWxRichTextCtrl }
    FEVT_RICHTEXT_LEFT_CLICK: string;
    FEVT_RICHTEXT_RIGHT_CLICK: string;
    FEVT_RICHTEXT_MIDDLE_CLICK: string;
    FEVT_RICHTEXT_LEFT_DCLICK: string;
    FEVT_RICHTEXT_RETURN: string;
    FEVT_RICHTEXT_CHARACTER: string;
    FEVT_RICHTEXT_DELETE: string;

    FEVT_RICHTEXT_STYLESHEET_CHANGING: string;
    FEVT_RICHTEXT_STYLESHEET_CHANGED: string;
    FEVT_RICHTEXT_STYLESHEET_REPLACING: string;
    FEVT_RICHTEXT_STYLESHEET_REPLACED: string;

    FEVT_RICHTEXT_CONTENT_INSERTED: string;
    FEVT_RICHTEXT_CONTENT_DELETED: string;
    FEVT_RICHTEXT_STYLE_CHANGED: string;
    FEVT_RICHTEXT_SELECTION_CHANGED: string;
    FEVT_RICHTEXT_BUFFER_RESET: string;

    FEVT_TEXT: string;
    FEVT_TEXT_ENTER: string;
    FEVT_TEXT_URL: string;
    FEVT_UPDATE_UI: string;

    { Storage for property Wx_BGColor }
    FWx_BGColor: TColor;
    { Storage for property Wx_Border }
    FWx_Border: integer;
    { Storage for property Wx_Class }
    FWx_Class: string;
    { Storage for property Wx_ControlOrientation }
    FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_EditStyle }
    FWx_RichTextStyle: TWxRichTextStyleSet;
    { Storage for property Wx_Enabled }
    FWx_Enabled: boolean;
    { Storage for property Wx_FGColor }
    FWx_FGColor: TColor;
    { Storage for property Wx_GeneralStyle }
    FWx_GeneralStyle: TWxStdStyleSet;
    { Storage for property Wx_HelpText }
    FWx_HelpText: string;
    { Storage for property Wx_Hidden }
    FWx_Hidden: boolean;
    { Storage for property Wx_IDName }
    FWx_IDName: string;
    { Storage for property Wx_IDValue }
    FWx_IDValue: integer;
    { Storage for property Wx_ProxyBGColorString }
    FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
    FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor: integer;
    { Storage for property Wx_ToolTip }
    FWx_ToolTip: string;
    FWx_MaxLength: integer;
    FWx_Comments: TStrings;
    FWx_LoadFromFile: TWxFileNameString;
    FWx_FiletoLoad: string;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;
    FWx_LHSValue : String;
    FWx_RHSValue : String;

    FWx_Validator: string;
    FWx_ProxyValidatorString : TWxValidatorString;

//Aui Properties
    FWx_AuiManaged: Boolean;
    FWx_PaneCaption: string;
    FWx_PaneName: string;
    FWx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem;
    FWx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet;
    FWx_Aui_Pane_Style: TwxAuiPaneStyleSet;
    FWx_Aui_Pane_Buttons: TwxAuiPaneButtonSet;
    FWx_BestSize_Height: Integer;
    FWx_BestSize_Width: Integer;
    FWx_MinSize_Height: Integer;
    FWx_MinSize_Width: Integer;
    FWx_MaxSize_Height: Integer;
    FWx_MaxSize_Width: Integer;
    FWx_Floating_Height: Integer;
    FWx_Floating_Width: Integer;
    FWx_Floating_X_Pos: Integer;
    FWx_Floating_Y_Pos: Integer;
    FWx_Layer: Integer;
    FWx_Row: Integer;
    FWx_Position: Integer;

    { Private methods of TWxRichTextCtrl }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;
    { Write method for property Wx_ToolTip }
    procedure SetWx_ToolTip(Value: string);

  protected
    { Protected fields of TWxRichTextCtrl }

    { Protected methods of TWxRichTextCtrl }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxRichTextCtrl }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxRichTextCtrl }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GenerateControlIDs: string;
    function GenerateEnumControlIDs: string;
    function GenerateEventTableEntries(CurrClassName: string): string;
    function GenerateGUIControlCreation: string;
    function GenerateXRCControlCreation(IndentString: string): TStringList;
    function GenerateGUIControlDeclaration: string;
    function GenerateHeaderInclude: string;
    function GenerateImageInclude: string;
    function GetEventList: TStringList;
    function GetIDName: string;
    function GetIDValue: integer;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: integer);
    procedure SetWxClassName(wxClassName: string);
    procedure SetWxFileName(wxFileName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);

    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    function GetValidator:String;
    procedure SetValidator(value:String);
    function GetValidatorString:TWxValidatorString;
    procedure SetValidatorString(Value:TWxValidatorString);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
    function GetLHSVariableAssignment:String;
    function GetRHSVariableAssignment:String;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);
    
  published
    { Published properties of TWxRichTextCtrl }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property EVT_RICHTEXT_LEFT_CLICK: string Read FEVT_RICHTEXT_LEFT_CLICK Write FEVT_RICHTEXT_LEFT_CLICK;
    property EVT_RICHTEXT_MIDDLE_CLICK: string Read FEVT_RICHTEXT_MIDDLE_CLICK Write FEVT_RICHTEXT_MIDDLE_CLICK;
    property EVT_RICHTEXT_RIGHT_CLICK: string Read FEVT_RICHTEXT_RIGHT_CLICK Write FEVT_RICHTEXT_RIGHT_CLICK;
    property EVT_RICHTEXT_LEFT_DCLICK: string Read FEVT_RICHTEXT_LEFT_DCLICK Write FEVT_RICHTEXT_LEFT_DCLICK;
    property EVT_RICHTEXT_RETURN: string Read FEVT_RICHTEXT_RETURN Write FEVT_RICHTEXT_RETURN;
    property EVT_RICHTEXT_CHARACTER: string Read FEVT_RICHTEXT_CHARACTER Write FEVT_RICHTEXT_CHARACTER;
    property EVT_RICHTEXT_DELETE: string Read FEVT_RICHTEXT_DELETE Write FEVT_RICHTEXT_DELETE;

    property EVT_RICHTEXT_STYLESHEET_CHANGING: string Read FEVT_RICHTEXT_STYLESHEET_CHANGING Write FEVT_RICHTEXT_STYLESHEET_CHANGING;
    property EVT_RICHTEXT_STYLESHEET_CHANGED: string Read FEVT_RICHTEXT_STYLESHEET_CHANGED Write FEVT_RICHTEXT_STYLESHEET_CHANGED;
    property EVT_RICHTEXT_STYLESHEET_REPLACING: string Read FEVT_RICHTEXT_STYLESHEET_REPLACING Write FEVT_RICHTEXT_STYLESHEET_REPLACING;
    property EVT_RICHTEXT_STYLESHEET_REPLACED: string Read FEVT_RICHTEXT_STYLESHEET_REPLACED Write FEVT_RICHTEXT_STYLESHEET_REPLACED;

    property EVT_RICHTEXT_CONTENT_INSERTED: string Read FEVT_RICHTEXT_CONTENT_INSERTED Write FEVT_RICHTEXT_CONTENT_INSERTED;
    property EVT_RICHTEXT_CONTENT_DELETED: string Read FEVT_RICHTEXT_CONTENT_DELETED Write FEVT_RICHTEXT_CONTENT_DELETED;
    property EVT_RICHTEXT_STYLE_CHANGED: string Read FEVT_RICHTEXT_STYLE_CHANGED Write FEVT_RICHTEXT_STYLE_CHANGED;
    property EVT_RICHTEXT_SELECTION_CHANGED: string Read FEVT_RICHTEXT_SELECTION_CHANGED Write FEVT_RICHTEXT_SELECTION_CHANGED;
    property EVT_RICHTEXT_BUFFER_RESET: string Read FEVT_RICHTEXT_BUFFER_RESET Write FEVT_RICHTEXT_BUFFER_RESET;


    property EVT_TEXT: string read FEVT_TEXT write FEVT_TEXT;
    property EVT_TEXT_ENTER: string read FEVT_TEXT_ENTER write FEVT_TEXT_ENTER;
    property EVT_TEXT_URL: string read FEVT_TEXT_URL write FEVT_TEXT_URL;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_RichTextStyle: TWxRichTextStyleSet Read FWx_RichTextStyle Write FWx_RichTextStyle;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden default False;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: integer Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_ToolTip: string Read FWx_ToolTip Write SetWx_ToolTip;
    property Wx_MaxLength: integer Read FWx_MaxLength Write FWx_MaxLength;
    property Wx_LoadFromFile: TWxFileNameString Read FWx_LoadFromFile Write FWx_LoadFromFile;
    property Wx_FiletoLoad: string Read FWx_FiletoLoad Write FWx_FiletoLoad;

    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_ProxyValidatorString : TWxValidatorString Read GetValidatorString Write SetValidatorString;

    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    property Wx_LHSValue: string Read FWx_LHSValue Write FWx_LHSValue;
    property Wx_RHSValue: string Read FWx_RHSValue Write FWx_RHSValue;

//Aui Properties
    property Wx_AuiManaged: boolean read FWx_AuiManaged write FWx_AuiManaged default False;
    property Wx_PaneCaption: string read FWx_PaneCaption write FWx_PaneCaption;
    property Wx_PaneName: string read FWx_PaneName write FWx_PaneName;
    property Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem read FWx_Aui_Dock_Direction write FWx_Aui_Dock_Direction;
    property Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet read FWx_Aui_Dockable_Direction write FWx_Aui_Dockable_Direction;
    property Wx_Aui_Pane_Style: TwxAuiPaneStyleSet read FWx_Aui_Pane_Style write FWx_Aui_Pane_Style;
    property Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet read FWx_Aui_Pane_Buttons write FWx_Aui_Pane_Buttons;
    property Wx_BestSize_Height: integer read FWx_BestSize_Height write FWx_BestSize_Height default -1;
    property Wx_BestSize_Width: integer read FWx_BestSize_Width write FWx_BestSize_Width default -1;
    property Wx_MinSize_Height: integer read FWx_MinSize_Height write FWx_MinSize_Height default -1;
    property Wx_MinSize_Width: integer read FWx_MinSize_Width write FWx_MinSize_Width default -1;
    property Wx_MaxSize_Height: integer read FWx_MaxSize_Height write FWx_MaxSize_Height default -1;
    property Wx_MaxSize_Width: integer read FWx_MaxSize_Width write FWx_MaxSize_Width default -1;
    property Wx_Floating_Height: integer read FWx_Floating_Height write FWx_Floating_Height default -1;
    property Wx_Floating_Width: integer read FWx_Floating_Width write FWx_Floating_Width default -1;
    property Wx_Floating_X_Pos: integer read FWx_Floating_X_Pos write FWx_Floating_X_Pos default -1;
    property Wx_Floating_Y_Pos: integer read FWx_Floating_Y_Pos write FWx_Floating_Y_Pos default -1;
    property Wx_Layer: integer read FWx_Layer write FWx_Layer default 0;
    property Wx_Row: integer read FWx_Row write FWx_Row default 0;
    property Wx_Position: integer read FWx_Position write FWx_Position default 0;

  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxRichTextCtrl with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxRichTextCtrl]);
end;

{ Method to set variable and property values and create objects }
procedure TWxRichTextCtrl.AutoInitialize;
begin
  FWx_EventList          := TStringList.Create;
  FWx_PropertyList       := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxRichTextCtrl';
  FWx_Enabled            := True;
  FWx_Hidden             := False;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;
  FWx_LoadFromFile       := TWxFileNameString.Create;
  FWx_Comments           := TStringList.Create;
  FWx_ProxyValidatorString := TwxValidatorString.Create(self);

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxRichTextCtrl.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_LoadFromFile.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyValidatorString.Destroy;
end; { of AutoDestroy }

{ Write method for property Wx_ToolTip }
procedure TWxRichTextCtrl.SetWx_ToolTip(Value: string);
begin
  FWx_ToolTip := Value;
end;

{ Override OnClick handler from TMemo,IWxComponentInterface }
procedure TWxRichTextCtrl.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TMemo,IWxComponentInterface }
procedure TWxRichTextCtrl.KeyPress(var Key: char);
const
  TabKey   = char(VK_TAB);
  EnterKey = char(VK_RETURN);
begin
     { Key contains the character produced by the keypress.
       It can be tested or assigned a new value before the
       call to the inherited KeyPress method.  Setting Key
       to #0 before call to the inherited KeyPress method
       terminates any further processing of the character. }

  { Activate KeyPress behavior of parent }
  inherited KeyPress(Key);

  { Code to execute after KeyPress behavior of parent }

end;

constructor TWxRichTextCtrl.Create(AOwner: TComponent);
begin
  { Call the Create method of the parent class }
  inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables and      }
  { properties; also, it creates objects for properties of       }
  { standard Delphi object types (e.g., TFont, TTimer,           }
  { TPicture) and for any variables marked as objects.           }
  { AutoInitialize method is generated by Component Create.      }
  AutoInitialize;

  { Code to perform other tasks when the component is created }
  PopulateGenericProperties(FWx_PropertyList);
  PopulateAuiGenericProperties(FWx_PropertyList);

  FWx_PropertyList.Add('Wx_RichTextStyle:RichText Style');
  FWx_PropertyList.Add('wxHSCROLL2:wxHSCROLL');
  FWx_PropertyList.Add('wxRE_READONLY:wxRE_READONLY');
  FWx_PropertyList.Add('wxRE_MULTILINE:wxRE_MULTILINE');

  FWx_PropertyList.add('Lines:Strings');
  FWx_PropertyList.add('Wx_MaxLength:Maximum Length');
  FWx_PropertyList.add('Text:Text');
  FWx_PropertyList.Add('Wx_LoadFromFile:Load From File');

  FWx_PropertyList.add('Wx_LHSValue:LHS Variable');
  FWx_PropertyList.add('Wx_RHSValue:RHS Variable');

  FWx_EventList.add('EVT_TEXT:OnUpdated');
  FWx_EventList.add('EVT_TEXT_ENTER:OnEnter');
  FWx_EventList.add('EVT_TEXT_URL:OnClickUrl');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');


  FWx_EventList.add('EVT_RICHTEXT_LEFT_CLICK:OnClick');
  FWx_EventList.add('EVT_RICHTEXT_MIDDLE_CLICK:OnMiddleClick');
  FWx_EventList.add('EVT_RICHTEXT_RIGHT_CLICK:OnRightClick');
  FWx_EventList.add('EVT_RICHTEXT_LEFT_DCLICK:OnDoubleClick');
  FWx_EventList.add('EVT_RICHTEXT_RETURN:OnReturn');
  FWx_EventList.add('EVT_RICHTEXT_CHARACTER:OnCharacter');
  FWx_EventList.add('EVT_RICHTEXT_DELETE:OnDelete');

  FWx_EventList.add('EVT_RICHTEXT_STYLESHEET_CHANGING:OnStylesheetChanging');
  FWx_EventList.add('EVT_RICHTEXT_STYLESHEET_CHANGED:OnStylesheetChanged');
  FWx_EventList.add('EVT_RICHTEXT_STYLESHEET_REPLACING:OnStylesheetReplacinging');
  FWx_EventList.add('EVT_RICHTEXT_STYLESHEET_REPLACED:OnStylesheetReplaced');

  FWx_EventList.add('EVT_RICHTEXT_CONTENT_INSERTED:OnContentInserted');
  FWx_EventList.add('EVT_RICHTEXT_CONTENT_DELETED:OnContentDeleted');
  FWx_EventList.add('EVT_RICHTEXT_STYLE_CHANGED:OnStyleChanged');
  FWx_EventList.add('EVT_RICHTEXT_SELECTION_CHANGED:OnSelectionChanged');
  FWx_EventList.add('EVT_RICHTEXT_BUFFER_RESET:OnBufferReset');



end;

destructor TWxRichTextCtrl.Destroy;
begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
  AutoDestroy;

  { Here, free any other dynamic objects that the component methods  }
  { created but have not yet freed.  Also perform any other clean-up }
  { operations needed before the component is destroyed.             }

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
  inherited Destroy;
end;


function TWxRichTextCtrl.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TWxRichTextCtrl.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;


function TWxRichTextCtrl.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

   if (XRCGEN) then
 begin//generate xrc loading code  needs to be edited

  if trim(EVT_RICHTEXT_LEFT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_LEFT_CLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_LEFT_CLICK]) + '';

  if trim(EVT_RICHTEXT_RIGHT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_RIGHT_CLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_RIGHT_CLICK]) + '';

  if trim(EVT_RICHTEXT_MIDDLE_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_MIDDLE_CLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_MIDDLE_CLICK]) + '';

  if trim(EVT_RICHTEXT_LEFT_DCLICK) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_LEFT_DCLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_LEFT_DCLICK]) + '';

  if trim(EVT_RICHTEXT_RETURN) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_RETURN(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_RETURN]) + '';

  if trim(EVT_RICHTEXT_CHARACTER) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_CHARACTER(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_CHARACTER]) + '';

  if trim(EVT_RICHTEXT_DELETE) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_DELETE(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_DELETE]) + '';

  if trim(EVT_RICHTEXT_STYLESHEET_CHANGING) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_STYLESHEET_CHANGING(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_STYLESHEET_CHANGING]) + '';

  if trim(EVT_RICHTEXT_STYLESHEET_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_STYLESHEET_CHANGED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_STYLESHEET_CHANGED]) + '';

  if trim(EVT_RICHTEXT_STYLESHEET_REPLACING) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_STYLESHEET_REPLACING(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_STYLESHEET_REPLACING]) + '';

  if trim(EVT_RICHTEXT_STYLESHEET_REPLACED) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_STYLESHEET_REPLACED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_STYLESHEET_REPLACED]) + '';

  if trim(EVT_RICHTEXT_CONTENT_INSERTED) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_CONTENT_INSERTED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_CONTENT_INSERTED]) + '';

  if trim(EVT_RICHTEXT_CONTENT_DELETED) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_CONTENT_DELETED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_CONTENT_DELETED]) + '';

  if trim(EVT_RICHTEXT_STYLE_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_STYLE_CHANGED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_STYLE_CHANGED]) + '';

  if trim(EVT_RICHTEXT_SELECTION_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_SELECTION_CHANGED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_SELECTION_CHANGED]) + '';

  if trim(EVT_RICHTEXT_BUFFER_RESET) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_BUFFER_RESET(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_RICHTEXT_BUFFER_RESET]) + '';


  if trim(EVT_TEXT) <> '' then
    Result := Result + #13 + Format('EVT_TEXT(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TEXT]) + '';

  if trim(EVT_TEXT_ENTER) <> '' then
    Result := Format('EVT_TEXT_ENTER(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TEXT_ENTER]) + '';

  if trim(EVT_TEXT_URL) <> '' then
    Result := Result + #13 + Format('EVT_TEXT_URL(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TEXT_URL]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

 end
 else
 begin//generate the cpp code
  if trim(EVT_RICHTEXT_LEFT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_LEFT_CLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_LEFT_CLICK]) + '';

  if trim(EVT_RICHTEXT_RIGHT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_RIGHT_CLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_RIGHT_CLICK]) + '';

  if trim(EVT_RICHTEXT_MIDDLE_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_MIDDLE_CLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_MIDDLE_CLICK]) + '';

  if trim(EVT_RICHTEXT_LEFT_DCLICK) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_LEFT_DCLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_LEFT_DCLICK]) + '';

  if trim(EVT_RICHTEXT_RETURN) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_RETURN(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_RETURN]) + '';

  if trim(EVT_RICHTEXT_CHARACTER) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_CHARACTER(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_CHARACTER]) + '';

  if trim(EVT_RICHTEXT_DELETE) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_DELETE(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_DELETE]) + '';

  if trim(EVT_RICHTEXT_STYLESHEET_CHANGING) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_STYLESHEET_CHANGING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_STYLESHEET_CHANGING]) + '';

  if trim(EVT_RICHTEXT_STYLESHEET_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_STYLESHEET_CHANGED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_STYLESHEET_CHANGED]) + '';

  if trim(EVT_RICHTEXT_STYLESHEET_REPLACING) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_STYLESHEET_REPLACING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_STYLESHEET_REPLACING]) + '';

  if trim(EVT_RICHTEXT_STYLESHEET_REPLACED) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_STYLESHEET_REPLACED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_STYLESHEET_REPLACED]) + '';

  if trim(EVT_RICHTEXT_CONTENT_INSERTED) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_CONTENT_INSERTED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_CONTENT_INSERTED]) + '';

  if trim(EVT_RICHTEXT_CONTENT_DELETED) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_CONTENT_DELETED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_CONTENT_DELETED]) + '';

  if trim(EVT_RICHTEXT_STYLE_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_STYLE_CHANGED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_STYLE_CHANGED]) + '';

  if trim(EVT_RICHTEXT_SELECTION_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_SELECTION_CHANGED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_SELECTION_CHANGED]) + '';

  if trim(EVT_RICHTEXT_BUFFER_RESET) <> '' then
    Result := Result + #13 + Format('EVT_RICHTEXT_BUFFER_RESET(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RICHTEXT_BUFFER_RESET]) + '';


  if trim(EVT_TEXT) <> '' then
    Result := Result + #13 + Format('EVT_TEXT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT]) + '';

  if trim(EVT_TEXT_ENTER) <> '' then
    Result := Format('EVT_TEXT_ENTER(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT_ENTER]) + '';

  if trim(EVT_TEXT_URL) <> '' then
    Result := Result + #13 + Format('EVT_TEXT_URL(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT_URL]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
 end;


(*  if trim(EVT_TEXT_MAXLEN) <> '' then
    Result := Result + #13 + Format('EVT_TEXT_MAXLEN(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT_MAXLEN]) + '';
*)

end;

function TWxRichTextCtrl.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

    if not(UseDefaultSize)then
      Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    if not(UseDefaultPos) then
      Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetRichTextSpecificStyle(self.Wx_GeneralStyle, self.Wx_RichTextStyle)]));

    Result.Add(IndentString + Format('  <value>%s</value>', [XML_Label(self.Caption)]));

    Result.Add(IndentString + '</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxRichTextCtrl.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
  i: integer;
begin
  Result := '';

    if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);

  strStyle := GetRichTextSpecificStyle(self.Wx_GeneralStyle, self.Wx_RichTextStyle);

   if trim(Wx_ProxyValidatorString.strValidatorValue) <> '' then
  begin
    if trim(strStyle) <> '' then
      strStyle := ', ' + strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue
    else
      strStyle := ', 0, ' + Wx_ProxyValidatorString.strValidatorValue;

    strStyle := strStyle + ', ' + GetCppString(Name);

  end
  else if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
  else
    strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);

   if (XRCGEN) then
 begin//generate xrc loading code
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);   
 end
 else
 begin//generate the cpp code    
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s, %s, %s%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    GetCppString(''), GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
 end;//end of if xrc
  SetWxFileName(self.FWx_LoadFromFile.FstrFileNameValue);
  if FWx_FiletoLoad <> '' then
  begin
    Result := Result + #13 + Format('%s->LoadFile("%s");',
      [self.Name, FWx_FiletoLoad]);
    self.Lines.LoadFromFile(FWx_FiletoLoad);

  end;

  if trim(self.Wx_ToolTip) <> '' then
    Result := Result + #13 + Format('%s->SetToolTip(%s);',
      [self.Name, GetCppString(self.Wx_ToolTip)]);

  Result := Result + #13 + Format('%s->SetMaxLength(%d);',
    [self.Name, self.Wx_MaxLength]);

  if self.Wx_Hidden then
    Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

  if not Wx_Enabled then
    Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

  if trim(self.Wx_HelpText) <> '' then
    Result := Result + #13 + Format('%s->SetHelpText(%s);',
      [self.Name, GetCppString(self.Wx_HelpText)]);

   if not (XRCGEN) then
 begin
  if FWx_FiletoLoad = '' then
    begin
    for i := 0 to self.Lines.Count - 1 do
      if i = self.Lines.Count - 1 then
        Result :=
          Result + #13 + Format('%s->AppendText(%s);',
          [self.Name, GetCppString(self.Lines[i])])
      else
        Result := Result + #13 + Format('%s->AppendText(%s);',
          [self.Name, GetCppString(self.Lines[i])]);

        Result := Result + #13 + self.Name + '->SetFocus();';
        Result := Result + #13 + self.Name + '->SetInsertionPointEnd();';
    end;
 end;

  strColorStr := trim(GetwxColorFromString(InvisibleFGColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetForegroundColour(%s);',
      [self.Name, strColorStr]);

  strColorStr := trim(GetwxColorFromString(InvisibleBGColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetBackgroundColour(%s);',
      [self.Name, strColorStr]);


  strColorStr := GetWxFontDeclaration(self.Font);
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetFont(%s);', [self.Name, strColorStr]);

  if not (XRCGEN) then //NUKLEAR ZELPH
  begin
    if (Wx_AuiManaged and FormHasAuiManager(self)) and not (self.Parent is TWxSizerPanel) then
    begin
      if HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) then
      begin
        Self.Wx_Aui_Pane_Style := Self.Wx_Aui_Pane_Style + [ToolbarPane]; //always make sure we are a toolbar
        Self.Wx_Layer := 10;
      end;

      if not HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) then
      begin
        if (self.Parent.ClassName = 'TWxPanel') then
          if not (self.Parent.Parent is TForm) then
            Result := Result + #13 + Format('%s->Reparent(this);', [parentName]);
      end;

      if (self.Parent is TWxAuiToolBar) then
        Result := Result + #13 + Format('%s->AddControl(%s);',
          [self.Parent.Name, self.Name])
      else
        Result := Result + #13 + Format('%s->AddPane(%s, wxAuiPaneInfo()%s%s%s%s%s%s%s%s%s%s%s%s);',
          [GetAuiManagerName(self), self.Name,
          GetAuiPaneName(Self.Wx_PaneName),
            GetAuiPaneCaption(Self.Wx_PaneCaption),
            GetAuiDockDirection(Self.Wx_Aui_Dock_Direction),
            GetAuiDockableDirections(self.Wx_Aui_Dockable_Direction),
            GetAui_Pane_Style(Self.Wx_Aui_Pane_Style),
            GetAui_Pane_Buttons(Self.Wx_Aui_Pane_Buttons),
            GetAuiRow(Self.Wx_Row),
            GetAuiPosition(Self.Wx_Position),
            GetAuiLayer(Self.Wx_Layer),
            GetAuiPaneBestSize(Self.Wx_BestSize_Width, Self.Wx_BestSize_Height),
            GetAuiPaneMinSize(Self.Wx_MinSize_Width, Self.Wx_MinSize_Height),
            GetAuiPaneMaxSize(Self.Wx_MaxSize_Width, Self.Wx_MaxSize_Height)]);

    end
    else
    begin
      if (self.Parent is TWxSizerPanel) then
      begin
        strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
        Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
          [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
          self.Wx_Border]);
      end;

      if (self.Parent is TWxAuiNotebookPage) then
      begin
        //        strParentLabel := TWxAuiNoteBookPage(Self.Parent).Caption;
        Result := Result + #13 + Format('%s->AddPage(%s, %s);',
          //          [self.Parent.Parent.Name, self.Name, GetCppString(strParentLabel)]);
          [self.Parent.Parent.Name, self.Name, GetCppString(TWxAuiNoteBookPage(Self.Parent).Caption)]);
      end;

      if (self.Parent is TWxAuiToolBar) then
        Result := Result + #13 + Format('%s->AddControl(%s);',
          [self.Parent.Name, self.Name]);
    end;
  end;


  // Set border style
  if wxSUNKEN_BORDER in self.Wx_GeneralStyle then
  begin
    self.BevelInner := bvLowered;
    self.BevelOuter := bvLowered;
    self.BevelKind  := bkSoft;
  end
  else if wxRAISED_BORDER in self.Wx_GeneralStyle then
  begin
    self.BevelInner := bvRaised;
    self.BevelOuter := bvRaised;
    self.BevelKind  := bkSoft;
  end
  else if wxNO_BORDER in self.Wx_GeneralStyle then
  begin
    self.BevelInner := bvNone;
    self.BevelOuter := bvNone;
    self.BevelKind  := bkNone;
  end
  else if wxDOUBLE_BORDER in self.Wx_GeneralStyle then
  begin
    self.BevelInner := bvSpace;
    self.BevelOuter := bvSpace;
    self.BevelKind  := bkTile;
  end
  else begin
    self.BevelInner := bvNone;
    self.BevelOuter := bvNone;
    self.BevelKind  := bkNone;
  end;

  if wxHSCROLL in self.Wx_GeneralStyle then
    self.ScrollBars := ssHorizontal;

  if wxVSCROLL in self.Wx_GeneralStyle then
    self.ScrollBars := ssVertical;

  if not (wxHSCROLL in self.Wx_GeneralStyle) and not
    (wxVSCROLL in self.Wx_GeneralStyle) then
    self.ScrollBars := ssNone;

  if (wxHSCROLL in self.Wx_GeneralStyle) and (wxVSCROLL in self.Wx_GeneralStyle) then
    self.ScrollBars := ssBoth;

end;

function TWxRichTextCtrl.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxRichTextCtrl.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/richtext/richtextctrl.h>';
  if (XRCGEN) then
    Result := Result + #13 + '#include <wx/xrc/xh_richtext.h>';
end;

function TWxRichTextCtrl.GenerateImageInclude: string;
begin

end;

function TWxRichTextCtrl.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxRichTextCtrl.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxRichTextCtrl.GetIDValue: integer;
begin
  Result := wx_IDValue;
end;

function TWxRichTextCtrl.GetParameterFromEventName(EventName: string): string;
begin
  if (EventName = 'EVT_RICHTEXT_LEFT_CLICK') or
     (EventName = 'EVT_RICHTEXT_RIGHT_CLICK') or
     (EventName = 'EVT_RICHTEXT_MIDDLE_CLICK') or
     (EventName = 'EVT_RICHTEXT_LEFT_DCLICK') or
     (EventName = 'EVT_RICHTEXT_RETURN') or
     (EventName = 'EVT_RICHTEXT_CHARACTER') or
     (EventName = 'EVT_RICHTEXT_DELETE') or
     (EventName = 'EVT_RICHTEXT_STYLESHEET_CHANGING') or
     (EventName = 'EVT_RICHTEXT_STYLESHEET_REPLACING') or
     (EventName = 'EVT_RICHTEXT_STYLESHEET_REPLACED') or
     (EventName = 'EVT_RICHTEXT_CONTENT_INSERTED') or
     (EventName = 'EVT_RICHTEXT_CONTENT_DELETED') or
     (EventName = 'EVT_RICHTEXT_STYLE_CHANGED') or
     (EventName = 'EVT_RICHTEXT_SELECTION_CHANGED') or
     (EventName = 'EVT_RICHTEXT_BUFFER_RESET') then
  begin
    Result := 'wxRichTextEvent& event';
    exit;
  end;


  if (EventName = 'EVT_TEXT') or
     (EventName = 'EVT_TEXT_ENTER') then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if (EventName = 'EVT_TEXT_URL') then
  begin
    Result := 'wxTextUrlEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then                                            
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;

end;

function TWxRichTextCtrl.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxRichTextCtrl.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxRichTextCtrl.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxRichTextCtrl.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxRichTextCtrl.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxRichTextCtrl.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxRichTextCtrl.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxRichTextCtrl.GetWxClassName: string;
begin
  if wx_Class = '' then
    wx_Class := 'wxRichTextCtrl';
  Result := wx_Class;
end;

procedure TWxRichTextCtrl.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }
  self.ScrollBars := ssVertical;
  self.FWx_LoadFromFile.FstrFileNameValue := FWx_FiletoLoad;

end;

procedure TWxRichTextCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxRichTextCtrl.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxRichTextCtrl.SetIDValue(IDValue: integer);
begin
  Wx_IDValue := IDValue;
end;

procedure TWxRichTextCtrl.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxRichTextCtrl.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxRichTextCtrl.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxRichTextCtrl.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxRichTextCtrl.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxRichTextCtrl.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxRichTextCtrl.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxRichTextCtrl.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxRichTextCtrl.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxRichTextCtrl.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

procedure TWxRichTextCtrl.SetWxFileName(wxFileName: string);
begin
  FWx_FiletoLoad := trim(wxFileName);
  strSearchReplace(FWx_FiletoLoad, '\', '/', [srAll]);
  Wx_LoadFromFile.FstrFileNameValue := FWx_FiletoLoad;
end;

function TWxRichTextCtrl.GetLHSVariableAssignment:String;
var
    nPos:Integer;
begin
    Result:='';
    if trim(Wx_LHSValue) = '' then
        exit;
        nPos := pos('|',Wx_LHSValue);
    if (UpperCase(copy(Wx_LHSValue,0,2)) = 'F:')  and (nPos <> -1) then
    begin
        Result:= Format('%s = %s(%s->GetValue());',[copy(Wx_LHSValue,3,nPos-3),copy(Wx_LHSValue,nPos+1,length(Wx_LHSValue)),self.Name])
    end
    else
        Result:= Format('%s = %s->GetValue();',[Wx_LHSValue,self.Name]);
end;

function TWxRichTextCtrl.GetRHSVariableAssignment:String;
begin
    Result:='';
    if trim(Wx_RHSValue) = '' then
        exit;
    Result:= Format('%s->SetValue(%s);',[self.Name,Wx_RHSValue]);
end;

function TWxRichTextCtrl.GetValidatorString:TWxValidatorString;
begin
  Result := FWx_ProxyValidatorString;
  Result.FstrValidatorValue := Wx_Validator;
end;

procedure TWxRichTextCtrl.SetValidatorString(Value:TWxValidatorString);
begin
  FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
  Wx_Validator := Value.FstrValidatorValue;
end;

function TWxRichTextCtrl.GetValidator:String;
begin
  Result := Wx_Validator;
end;

procedure TWxRichTextCtrl.SetValidator(value:String);
begin
  Wx_Validator := value;
end;

end.