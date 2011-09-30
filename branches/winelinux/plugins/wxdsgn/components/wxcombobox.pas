 { ****************************************************************** }
 {                                                                    }
{ $Id: wxcombobox.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

unit WxComboBox;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxSizerPanel, wxAuiToolBar, WxAuiNotebookPage, WxToolBar, UValidator;

type
  TWxComboBox = class(TComboBox, IWxComponentInterface, IWxToolBarInsertableInterface,
    IWxToolBarNonInsertableInterface,IWxVariableAssignmentInterface, IWxValidatorInterface)
  private
    { Private fields of TWxComboBox }
    { Storage for property EVT_COMBOBOX }
    FEVT_COMBOBOX: string;
    { Storage for property EVT_TEXT }
    FEVT_TEXT: string;
    { Storage for property EVT_UPDATE_UI }
    FEVT_UPDATE_UI: string;
    FEVT_TEXT_ENTER: string;
    { Storage for property Wx_BGColor }
    FWx_BGColor: TColor;
    { Storage for property Wx_Border }
    FWx_Border: integer;
    { Storage for property Wx_Class }
    FWx_Class: string;
    { Storage for property Wx_ComboboxStyle }
    FWx_ComboboxStyle: TWxCmbStyleSet;
    { Storage for property Wx_EditStyle }
    FWx_EditStyle: TWxEdtGeneralStyleSet;
    { Storage for property Wx_ControlOrientation }
    FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_DefaultItem }
    FWx_DefaultItem: integer;
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
    FWx_Validator: string;
    FWx_ProxyValidatorString : TWxValidatorString;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;
    FWx_LHSValue : String;
    FWx_RHSValue : String;

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

    { Private methods of TWxComboBox }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;

    { Read method for property Wx_EditStyle }
    function GetWx_EditStyle: TWxEdtGeneralStyleSet;
    { Write method for property Wx_EditStyle }
    procedure SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);

  protected
    { Protected fields of TWxComboBox }

    { Protected methods of TWxComboBox }
    procedure Change; override;
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxComboBox }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxComboBox }
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
    procedure DummyToolBarInsertableInterfaceProcedure;
    function GetLHSVariableAssignment:String;
    function GetRHSVariableAssignment:String;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);
    
  published
    { Published properties of TWxComboBox }
    property OnChange;
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
    property EVT_COMBOBOX: string Read FEVT_COMBOBOX Write FEVT_COMBOBOX;
    property EVT_TEXT: string Read FEVT_TEXT Write FEVT_TEXT;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property EVT_TEXT_ENTER: string Read FEVT_TEXT_ENTER Write FEVT_TEXT_ENTER;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ComboboxStyle: TWxCmbStyleSet
      Read FWx_ComboboxStyle Write FWx_ComboboxStyle;
    property Wx_EditStyle: TWxEdtGeneralStyleSet
        Read GetWx_EditStyle Write SetWx_EditStyle;
     // Read FWx_EditStyle Write FWx_EditStyle;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_DefaultItem: integer Read FWx_DefaultItem
      Write FWx_DefaultItem default -1;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: integer Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_ProxyValidatorString : TWxValidatorString Read GetValidatorString Write SetValidatorString;
    
    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;
    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;

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
     { Register TWxComboBox with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxComboBox]);
end;

{ Method to set variable and property values and create objects }
procedure TWxComboBox.AutoInitialize;
begin
  FWx_EventList          := TStringList.Create;
  FWx_PropertyList       := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxComboBox';
  FWx_DefaultItem        := -1;
  FWx_Enabled            := True;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;
  FWx_Comments           := TStringList.Create;
  FWx_ProxyValidatorString := TwxValidatorString.Create(self);

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxComboBox.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_ProxyValidatorString.Destroy;

end; { of AutoDestroy }

{ Override OnChange handler from TComboBox,IWxComponentInterface }
procedure TWxComboBox.Change;
begin
  inherited Change;
end;

{ Override OnClick handler from TComboBox,IWxComponentInterface }
procedure TWxComboBox.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TComboBox,IWxComponentInterface }
procedure TWxComboBox.KeyPress(var Key: char);
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

constructor TWxComboBox.Create(AOwner: TComponent);
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

  FWx_PropertyList.add('Wx_ComboboxStyle:Combobox Style');
  FWx_PropertyList.add('wxCB_SIMPLE:wxCB_SIMPLE');
  FWx_PropertyList.add('wxCB_DROPDOWN:wxCB_DROPDOWN');
  FWx_PropertyList.add('wxCB_READONLY:wxCB_READONLY');
  FWx_PropertyList.add('wxCB_SORT:wxCB_SORT');

  FWx_PropertyList.Add('Wx_EditStyle:Edit Style');
  FWx_PropertyList.Add('wxTE_PROCESS_ENTER:wxTE_PROCESS_ENTER');
  FWx_PropertyList.Add('wxTE_PROCESS_TAB:wxTE_PROCESS_TAB');
  FWx_PropertyList.Add('wxTE_PASSWORD:wxTE_PASSWORD');
  FWx_PropertyList.Add('wxTE_READONLY:wxTE_READONLY');
  FWx_PropertyList.Add('wxTE_MULTILINE:wxTE_MULTILINE');
  FWx_PropertyList.Add('wxTE_RICH:wxTE_RICH');
  FWx_PropertyList.Add('wxTE_RICH2:wxTE_RICH2');
  FWx_PropertyList.Add('wxTE_AUTO_URL:wxTE_AUTO_URL');
  FWx_PropertyList.Add('wxTE_NOHIDESEL:wxTE_NOHIDESEL');
  FWx_PropertyList.Add('wxTE_LEFT:wxTE_LEFT');
  FWx_PropertyList.Add('wxTE_CENTRE:wxTE_CENTRE');
  FWx_PropertyList.Add('wxTE_RIGHT:wxTE_RIGHT');
  FWx_PropertyList.Add('wxTE_LINEWRAP:wxTE_LINEWRAP');
  FWx_PropertyList.Add('wxTE_DONTWRAP:wxTE_DONTWRAP');
  FWx_PropertyList.Add('wxTE_CHARWRAP:wxTE_CHARWRAP');
  FWx_PropertyList.Add('wxTE_BESTWRAP:wxTE_BESTWRAP');
  FWx_PropertyList.Add('wxTE_CAPITALIZE:wxTE_CAPITALIZE');

  FWx_PropertyList.add('Items:Items');
  FWx_PropertyList.add('Text:Text');
  FWx_PropertyList.add('Wx_LHSValue   : LHS Variable');
  FWx_PropertyList.add('Wx_RHSValue   : RHS Variable');

  FWx_EventList.add('EVT_COMBOBOX:OnSelected');
  FWx_EventList.add('EVT_TEXT:OnUpdated');
  FWx_EventList.add('EVT_TEXT_ENTER:OnTextEnter');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
end;

destructor TWxComboBox.Destroy;
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


function TWxComboBox.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TWxComboBox.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;



function TWxComboBox.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

if (XRCGEN) then
 begin
  if trim(EVT_COMBOBOX) <> '' then
    Result := Format('EVT_COMBOBOX(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_COMBOBOX]) + '';

  if trim(EVT_TEXT) <> '' then
    Result := Result + #13 + Format('EVT_TEXT(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TEXT]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
  
  if trim(EVT_TEXT_ENTER) <> '' then
    Result := Result + #13 + Format('EVT_TEXT_ENTER(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TEXT_ENTER]) + '';
 end
 else
 begin
  if trim(EVT_COMBOBOX) <> '' then
    Result := Format('EVT_COMBOBOX(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_COMBOBOX]) + '';

  if trim(EVT_TEXT) <> '' then
    Result := Result + #13 + Format('EVT_TEXT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_TEXT_ENTER) <> '' then
    Result := Result + #13 + Format('EVT_TEXT_ENTER(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT_ENTER]) + '';
 end;

end;

function TWxComboBox.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  i: integer;
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
      [GetcomboBoxSpecificStyle(Wx_GeneralStyle, Wx_ComboboxStyle, Wx_EditStyle)]));

    Result.Add('  <content>');
    for i := 0 to self.Items.Count - 1 do
      Result.Add(IndentString + '    <item checked="0">' + self.Items[i] + '</item>');

    Result.Add('  </content>');
    Result.Add(IndentString + '</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxComboBox.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  i: integer;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';

    if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);
  strStyle   := GetcomboBoxSpecificStyle(Wx_GeneralStyle, Wx_ComboboxStyle, Wx_EditStyle);

  if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle;

  Result := GetCommentString(self.FWx_Comments.Text) +
    'wxArrayString arrayStringFor_' + self.Name + ';';

  for i := 0 to self.Items.Count - 1 do
    Result := Result + #13 + Format(
      '%s.Add(%s);', ['arrayStringFor_' + self.Name, GetCppString(self.Items[i])]);

  //Last comma is removed because it depends on the user selection of the properties.
  if trim(Wx_ProxyValidatorString.strValidatorValue) <> '' then
  begin
    if trim(strStyle) <> '' then
      strStyle := strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue
    else
      strStyle := ', 0, ' + Wx_ProxyValidatorString.strValidatorValue;

    strStyle := strStyle + ', ' + GetCppString(Name);

  end
  else if trim(strStyle) <> '' then
    strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
  else
    strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);

if (XRCGEN) then
 begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]); 
 end
 else
 begin
  Result := Result + #13 + Format(
    '%s = new %s(%s, %s, %s, %s, %s, %s%s);',
    [self.Name, self.Wx_Class, ParentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    GetCppString(self.Caption), GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height),
    'arrayStringFor_' + self.Name, strStyle]);
 end;

  if trim(self.Wx_ToolTip) <> '' then
    Result := Result + #13 + Format('%s->SetToolTip(%s);',
      [self.Name, GetCppString(self.Wx_ToolTip)]);

  if self.Wx_Hidden then
    Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

  if not Wx_Enabled then
    Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

  if trim(self.Wx_HelpText) <> '' then
    Result := Result + #13 + Format('%s->SetHelpText(%s);',
      [self.Name, GetCppString(self.Wx_HelpText)]);

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

      if (self.Parent is TWxAuiToolBar) or (self.Parent is TWxToolBar) then
    Result := Result + #13 + Format('%s->AddControl(%s);',
      [self.Parent.Name, self.Name]);
    end;
  end;

end;

function TWxComboBox.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxComboBox.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/combobox.h>';
end;

function TWxComboBox.GenerateImageInclude: string;
begin

end;

function TWxComboBox.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxComboBox.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxComboBox.GetIDValue: integer;
begin
  Result := wx_IDValue;
end;

function TWxComboBox.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_COMBOBOX' then
    Result := 'wxCommandEvent& event '
  else if EventName = 'EVT_TEXT' then
    Result := 'wxCommandEvent& event '
  else if EventName = 'EVT_TEXT_ENTER' then
    Result := 'wxCommandEvent& event'
  else if EventName = 'EVT_UPDATE_UI' then
    Result := 'wxUpdateUIEvent& event';
end;

function TWxComboBox.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxComboBox.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxComboBox.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxComboBox.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxComboBox.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxComboBox.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxComboBox.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxComboBox.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxComboBox';
  Result := wx_Class;
end;

procedure TWxComboBox.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxComboBox.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxComboBox.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxComboBox.SetIDValue(IDValue: integer);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxComboBox.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxComboBox.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxComboBox.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxComboBox.SetGenericColor(strVariableName,strValue: string);
begin

end;


function TWxComboBox.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxComboBox.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxComboBox.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxComboBox.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxComboBox.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxComboBox.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

procedure TWxComboBox.DummyToolBarInsertableInterfaceProcedure;
begin

end;

function TWxComboBox.GetLHSVariableAssignment:String;
var
    nPos:Integer;
begin
    Result:='';
    if trim(Wx_LHSValue) = '' then
        exit;
    nPos := pos('|',Wx_LHSValue);
    if UpperCase(copy(Wx_LHSValue,0,2)) = 'I:' then
        Result:= Format('%s = %s->GetSelection();',[copy(Wx_LHSValue,3,length(Wx_LHSValue)),self.Name])
    else if (UpperCase(copy(Wx_LHSValue,0,3)) = 'IF:') and (nPos <> -1) then
    begin
        Result:= Format('%s = %s(%s->GetSelection());',[copy(Wx_LHSValue,4,nPos-4),copy(Wx_LHSValue,nPos+1,length(Wx_LHSValue)),self.Name])
    end
    else if (UpperCase(copy(Wx_LHSValue,0,2)) = 'F:') and (nPos <> -1) then
    begin
        Result:= Format('%s = %s(%s->GetValue());',[copy(Wx_LHSValue,3,nPos-3),copy(Wx_LHSValue,nPos+1,length(Wx_LHSValue)),self.Name])
    end
    else
        Result:= Format('%s = %s->GetValue();',[Wx_LHSValue,self.Name]);
end;

function TWxComboBox.GetRHSVariableAssignment:String;
begin
    Result:='';
    if trim(Wx_RHSValue) = '' then
        exit;
    if UpperCase(copy(Wx_RHSValue,0,2)) = 'I:' then
        Result:= Format('%s->SetSelection(%s);',[self.Name,copy(Wx_RHSValue,3,length(Wx_RHSValue))])
    else
        Result:= Format('%s->SetValue(%s);',[self.Name,Wx_RHSValue]);

end;

function TWxComboBox.GetValidatorString:TWxValidatorString;
begin
  Result := FWx_ProxyValidatorString;
  Result.FstrValidatorValue := Wx_Validator;
end;

procedure TWxComboBox.SetValidatorString(Value:TWxValidatorString);
begin
  FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
  Wx_Validator := Value.FstrValidatorValue;
end;

function TWxComboBox.GetValidator:String;
begin
  Result := Wx_Validator;
end;

procedure TWxComboBox.SetValidator(value:String);
begin
  Wx_Validator := value;
end;

{ Read method for property Wx_EditStyle }
function TWxComboBox.GetWx_EditStyle: TWxEdtGeneralStyleSet;
begin
  Result := FWx_EditStyle;
end;

{ Write method for property Wx_EditStyle }
procedure TWxComboBox.SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);
begin
  FWx_EditStyle := GetRefinedWxEdtGeneralStyleValue(Value);
end;

end.