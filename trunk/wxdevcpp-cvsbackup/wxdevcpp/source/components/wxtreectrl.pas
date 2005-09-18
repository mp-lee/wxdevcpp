 { ****************************************************************** }
 {                                                                    }
{ $Id$                                                               }
 {                                                                    }
 {   VCL component TWxTreeCtrl                                        }
 {                                                                    }
 {   Code generated by Component Create for Delphi                    }
 {                                                                    }
 {   Generated from source file wxtreectrl.cd }
 {   on 10 Oct 2004 at 0:51                                           }
 {                                                                    }
 {   Copyright � 2003 by ...                                          }
 {                                                                    }
 { ****************************************************************** }

unit WxTreeCtrl;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ComCtrls, WxUtils, ExtCtrls, WxSizerPanel;

type
  TWxTreeCtrl = class(TTreeView, IWxComponentInterface)
  private
    { Private fields of TWxTreeCtrl }
    FEVT_TREE_BEGIN_DRAG: string;
    FEVT_TREE_BEGIN_LABEL_EDIT: string;
    FEVT_TREE_BEGIN_RDRAG: string;
    FEVT_TREE_DELETE_ITEM: string;
    FEVT_TREE_END_LABEL_EDIT: string;
    FEVT_TREE_GET_INFO: string;
    FEVT_TREE_ITEM_ACTIVATED: string;
    FEVT_TREE_ITEM_COLLAPSED: string;
    FEVT_TREE_ITEM_COLLAPSING: string;
    FEVT_TREE_ITEM_EXPANDED: string;
    FEVT_TREE_ITEM_EXPANDING: string;
    FEVT_TREE_KEY_DOWN: string;
    FEVT_TREE_SEL_CHANGED: string;
    FEVT_TREE_SEL_CHANGING: string;
    FEVT_TREE_SET_INFO: string;
    FEVT_UPDATE_UI: string;
    FWx_BGColor: TColor;
    FWx_Border: integer;
    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_Enabled: boolean;
    FWx_FGColor: TColor;
    FWx_GeneralStyle: TWxStdStyleSet;
    FWx_HelpText: string;
    FWx_Hidden: boolean;
    FWx_HorizontalAlignment: TWxSizerHorizontalAlignment;
    FWx_IDName: string;
    FWx_IDValue: longint;
    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;
    FWx_StretchFactor: integer;
    FWx_ToolTip: string;
    FWx_TreeviewStyle: TWxTVStyleSet;
    FWx_VerticalAlignment: TWxSizerVerticalAlignment;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Comments: TStrings;
    { Private methods of TWxTreeCtrl }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected
    { Protected fields of TWxTreeCtrl }

    { Protected methods of TWxTreeCtrl }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxTreeCtrl }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxTreeCtrl }
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
    function GetIDValue: longint;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetStretchFactor: integer;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: longint);
    procedure SetStretchFactor(intValue: integer);
    procedure SetWxClassName(wxClassName: string);

    function GetFGColor: string;
    procedure SetFGColor(strValue: string);

    function GetBGColor: string;
    procedure SetBGColor(strValue: string);
    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

  published
    { Published properties of TWxTreeCtrl }
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
    property EVT_TREE_BEGIN_DRAG: string Read FEVT_TREE_BEGIN_DRAG
      Write FEVT_TREE_BEGIN_DRAG;
    property EVT_TREE_BEGIN_LABEL_EDIT: string
      Read FEVT_TREE_BEGIN_LABEL_EDIT Write FEVT_TREE_BEGIN_LABEL_EDIT;
    property EVT_TREE_BEGIN_RDRAG: string Read FEVT_TREE_BEGIN_RDRAG
      Write FEVT_TREE_BEGIN_RDRAG;
    property EVT_TREE_DELETE_ITEM: string Read FEVT_TREE_DELETE_ITEM
      Write FEVT_TREE_DELETE_ITEM;
    property EVT_TREE_END_LABEL_EDIT: string
      Read FEVT_TREE_END_LABEL_EDIT Write FEVT_TREE_END_LABEL_EDIT;
    property EVT_TREE_GET_INFO: string Read FEVT_TREE_GET_INFO Write FEVT_TREE_GET_INFO;
    property EVT_TREE_ITEM_ACTIVATED: string
      Read FEVT_TREE_ITEM_ACTIVATED Write FEVT_TREE_ITEM_ACTIVATED;
    property EVT_TREE_ITEM_COLLAPSED: string
      Read FEVT_TREE_ITEM_COLLAPSED Write FEVT_TREE_ITEM_COLLAPSED;
    property EVT_TREE_ITEM_COLLAPSING: string
      Read FEVT_TREE_ITEM_COLLAPSING Write FEVT_TREE_ITEM_COLLAPSING;
    property EVT_TREE_ITEM_EXPANDED: string
      Read FEVT_TREE_ITEM_EXPANDED Write FEVT_TREE_ITEM_EXPANDED;
    property EVT_TREE_ITEM_EXPANDING: string
      Read FEVT_TREE_ITEM_EXPANDING Write FEVT_TREE_ITEM_EXPANDING;
    property EVT_TREE_KEY_DOWN: string Read FEVT_TREE_KEY_DOWN Write FEVT_TREE_KEY_DOWN;
    property EVT_TREE_SEL_CHANGED: string Read FEVT_TREE_SEL_CHANGED
      Write FEVT_TREE_SEL_CHANGED;
    property EVT_TREE_SEL_CHANGING: string
      Read FEVT_TREE_SEL_CHANGING Write FEVT_TREE_SEL_CHANGING;
    property EVT_TREE_SET_INFO: string Read FEVT_TREE_SET_INFO Write FEVT_TREE_SET_INFO;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Border: integer Read FWx_Border Write FWx_Border default 5;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;

    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_HorizontalAlignment: TWxSizerHorizontalAlignment
      Read FWx_HorizontalAlignment Write FWx_HorizontalAlignment default
      wxSZALIGN_CENTER_HORIZONTAL;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

    property Wx_ProxyBGColorString: TWxColorString
      Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString
      Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;


    property Wx_StrechFactor: integer Read FWx_StretchFactor Write FWx_StretchFactor;
    property Wx_StretchFactor: integer Read FWx_StretchFactor
      Write FWx_StretchFactor default 0;

    property Wx_TreeviewStyle: TWxTVStyleSet
      Read FWx_TreeviewStyle Write FWx_TreeviewStyle;
    property Wx_VerticalAlignment: TWxSizerVerticalAlignment
      Read FWx_VerticalAlignment Write FWx_VerticalAlignment default
      wxSZALIGN_CENTER_VERTICAL;

    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property InvisibleBGColorString: string
      Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string
      Read FInvisibleFGColorString Write FInvisibleFGColorString;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;

  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxTreeCtrl with Win95 as its
       default page on the Delphi component palette }
  RegisterComponents('Win95', [TWxTreeCtrl]);
end;

{ Method to set variable and property values and create objects }
procedure TWxTreeCtrl.AutoInitialize;
begin
  FWx_EventList  := TStringList.Create;
  FWx_PropertyList := TStringList.Create;
  FWx_Border     := 5;
  FWx_Class      := 'wxTreeCtrl';
  FWx_Enabled    := True;
  FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
  FWx_IDValue    := -1;
  FWx_StretchFactor := 0;
  FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor := self.color;
  defaultFGColor := self.font.color;
  FWx_TreeviewStyle := [wxTR_HAS_BUTTONS];
  FWx_Comments   := TStringList.Create;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxTreeCtrl.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

{ Override OnClick handler from TTreeView,IWxComponentInterface }
procedure TWxTreeCtrl.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TTreeView,IWxComponentInterface }
procedure TWxTreeCtrl.KeyPress(var Key: char);
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

constructor TWxTreeCtrl.Create(AOwner: TComponent);
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
  FWx_PropertyList.add('Wx_TreeviewStyle :Treeview Style');
  FWx_PropertyList.add('Wx_Hidden :Hidden');
  FWx_PropertyList.add('Items :Items');
  FWx_PropertyList.add('Columns :Columns');
  FWx_PropertyList.add('Wx_Border : Border ');
  FWx_PropertyList.add('Wx_Default :WxDefault ');
  FWx_PropertyList.add('Wx_HelpText :HelpText ');
  FWx_PropertyList.add('Wx_IDName : IDName ');
  FWx_PropertyList.add('Wx_IDValue : IDValue ');
  FWx_PropertyList.add('Wx_ToolTip :ToolTip ');
  FWx_PropertyList.add('Text:Text');
  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Enabled:Enabled');
  FWx_PropertyList.add('Left:Left');
  FWx_PropertyList.add('Top:Top');
  FWx_PropertyList.add('Width:Width');
  FWx_PropertyList.add('Height:Height');

  FWx_PropertyList.add('Wx_ProxyBGColorString:Background Color');
  FWx_PropertyList.add('Wx_ProxyFGColorString:Foreground Color');

  FWx_PropertyList.add('Wx_Comments:Comments');

  FWx_PropertyList.add('Wx_GeneralStyle : General Styles');
  FWx_PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
  FWx_PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
  FWx_PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
  FWx_PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
  FWx_PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
  FWx_PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
  FWx_PropertyList.Add('wxNO_3D:wxNO_3D');
  FWx_PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
  FWx_PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
  FWx_PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
  FWx_PropertyList.Add('wxVSCROLL:wxVSCROLL');
  FWx_PropertyList.Add('wxHSCROLL:wxHSCROLL');
  FWx_PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');

  FWx_PropertyList.add('Wx_TreeViewStyle : TreeView Styles');
  FWx_PropertyList.Add('wxTR_EDIT_LABELS:wxTR_EDIT_LABELS');
  FWx_PropertyList.Add('wxTR_NO_BUTTONS:wxTR_NO_BUTTONS');
  FWx_PropertyList.Add('wxTR_HAS_BUTTONS:wxTR_HAS_BUTTONS');
  FWx_PropertyList.Add('wxTR_TWIST_BUTTONS:wxTR_TWIST_BUTTONS');
  FWx_PropertyList.Add('wxTR_NO_LINES:wxTR_NO_LINES');
  FWx_PropertyList.Add('wxTR_FULL_ROW_HIGHLIGHT:wxTR_FULL_ROW_HIGHLIGHT');
  FWx_PropertyList.Add('wxTR_LINES_AT_ROOT:wxTR_LINES_AT_ROOT');
  FWx_PropertyList.Add('wxTR_HIDE_ROOT:wxTR_HIDE_ROOT');
  FWx_PropertyList.Add('wxTR_ROW_LINES:wxTR_ROW_LINES');
  FWx_PropertyList.Add('wxTR_HAS_VARIABLE_ROW_HEIGHT:wxTR_HAS_VARIABLE_ROW_HEIGHT');
  FWx_PropertyList.Add('wxTR_SINGLE:wxTR_SINGLE');
  FWx_PropertyList.Add('wxTR_MULTIPLE:wxTR_MULTIPLE');
  FWx_PropertyList.Add('wxTR_EXTENDED:wxTR_EXTENDED');
  FWx_PropertyList.Add('wxTR_DEFAULT_STYLE:wxTR_DEFAULT_STYLE');

  FWx_PropertyList.add('Font : Font');

  FWx_PropertyList.add('Checked : Checked');
  FWx_PropertyList.add('Wx_RadioButtonStyle:Radio Button Style');

  FWx_PropertyList.add('wxRB_GROUP:wxRB_GROUP');
  FWx_PropertyList.add('wxRB_SINGLE:wxRB_SINGLE');

  FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
  FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');
  FWx_PropertyList.add('Wx_StretchFactor   : StretchFactor');

  FWx_EventList.add('EVT_TREE_SEL_CHANGED   :  OnSelChanged ');
  FWx_EventList.add('EVT_TREE_SEL_CHANGING   :  OnSelChanging ');
  FWx_EventList.add('EVT_TREE_BEGIN_DRAG   :  OnBeginDrag ');
  FWx_EventList.add('EVT_TREE_BEGIN_RDRAG   :  OnBeginRDrag ');
  FWx_EventList.add('EVT_TREE_BEGIN_LABEL_EDIT   :  OnBeginLabelEdit ');
  FWx_EventList.add('EVT_TREE_END_LABEL_EDIT   :  OnEndLabelEdit');
  FWx_EventList.add('EVT_TREE_DELETE_ITEM   :  OnDeleteItem ');
  FWx_EventList.add('EVT_TREE_GET_INFO   :  OnGetInfo');
  FWx_EventList.add('EVT_TREE_SET_INFO   :  OnSetInfo ');
  FWx_EventList.add('EVT_TREE_ITEM_ACTIVATED   :  OnItemActivated');
  FWx_EventList.add('EVT_TREE_ITEM_COLLAPSED   :  OnItemCollapsed');
  FWx_EventList.add('EVT_TREE_ITEM_COLLAPSING   :  OnItemCollapsing');
  FWx_EventList.add('EVT_TREE_ITEM_EXPANDED   :  OnItemExpanded');
  FWx_EventList.add('EVT_TREE_ITEM_EXPANDING   :  OnItemExpanding');
  FWx_EventList.add('EVT_TREE_KEY_DOWN   :  OnKeyDown');
  FWx_EventList.add('EVT_UPDATE_UI   :  OnUpdate');

end;

destructor TWxTreeCtrl.Destroy;
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

function TWxTreeCtrl.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxTreeCtrl.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s  %d ', [Wx_IDName, Wx_IDValue]);
end;


function TWxTreeCtrl.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

  if trim(EVT_TREE_SEL_CHANGED) <> '' then
    Result := Format('EVT_TREE_SEL_CHANGED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_SEL_CHANGED]) + '';

  if trim(EVT_TREE_SEL_CHANGING) <> '' then
    Result := Result + #13 + Format('EVT_TREE_SEL_CHANGING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_SEL_CHANGING]) + '';
  if trim(EVT_TREE_BEGIN_DRAG) <> '' then
    Result := Result + #13 + Format('EVT_TREE_BEGIN_DRAG(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_BEGIN_DRAG]) + '';

  if trim(EVT_TREE_BEGIN_RDRAG) <> '' then
    Result := Result + #13 + Format('EVT_TREE_BEGIN_RDRAG(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_BEGIN_RDRAG]) + '';
  if trim(EVT_TREE_BEGIN_LABEL_EDIT) <> '' then
    Result := Result + #13 + Format('EVT_TREE_BEGIN_LABEL_EDIT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_BEGIN_LABEL_EDIT]) + '';

  if trim(EVT_TREE_END_LABEL_EDIT) <> '' then
    Result := Result + #13 + Format('EVT_TREE_END_LABEL_EDIT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_END_LABEL_EDIT]) + '';
  if trim(EVT_TREE_DELETE_ITEM) <> '' then
    Result := Result + #13 + Format('EVT_TREE_DELETE_ITEM(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_DELETE_ITEM]) + '';

  if trim(EVT_TREE_GET_INFO) <> '' then
    Result := Result + #13 + Format('EVT_TREE_GET_INFO(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_GET_INFO]) + '';
  if trim(EVT_TREE_SET_INFO) <> '' then
    Result := Result + #13 + Format('EVT_TREE_SET_INFO(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_SET_INFO]) + '';

  if trim(EVT_TREE_ITEM_ACTIVATED) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_ACTIVATED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_ACTIVATED]) + '';
  if trim(EVT_TREE_ITEM_COLLAPSED) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_COLLAPSED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_COLLAPSED]) + '';

  if trim(EVT_TREE_ITEM_COLLAPSING) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_COLLAPSING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_COLLAPSING]) + '';
  if trim(EVT_TREE_ITEM_EXPANDED) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_EXPANDED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_EXPANDED]) + '';

  if trim(EVT_TREE_ITEM_EXPANDING) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_EXPANDING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_EXPANDING]) + '';
  if trim(EVT_TREE_KEY_DOWN) <> '' then
    Result := Result + #13 + Format('EVT_TREE_KEY_DOWN(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_KEY_DOWN]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

end;

function TWxTreeCtrl.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetTreeViewSpecificStyle(self.Wx_GeneralStyle, Wx_TreeviewStyle)]));
    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxTreeCtrl.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';

  //    if (self.Parent is TForm) or (self.Parent is TWxSizerPanel) then
  //       parentName:=GetWxWidgetParent(self)
  //    else
  //       parentName:=self.Parent.name;

  parentName := GetWxWidgetParent(self);

  strStyle := GetTreeViewSpecificStyle(self.Wx_GeneralStyle, Wx_TreeviewStyle);

  if (trim(strStyle) <> '') then
    strStyle := ', ' + strStyle;

  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, wxPoint(%d,%d), wxSize(%d,%d)%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    self.Left, self.Top, self.Width, self.Height, strStyle]);

  if trim(self.Wx_ToolTip) <> '' then
    Result := Result + #13 + Format('%s->SetToolTip(%s);',
      [self.Name, GetCppString(Wx_ToolTip)]);

  if self.Wx_Hidden then
    Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

  if not Wx_Enabled then
    Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

  if trim(self.Wx_HelpText) <> '' then
    Result := Result + #13 + Format('%s->SetHelpText(%s);',
      [self.Name, GetCppString(Wx_HelpText)]);

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

  if (self.Parent is TWxSizerPanel) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_HorizontalAlignment) +
      ' | ' + SizerAlignmentToStr(Wx_VerticalAlignment) + ' | wxALL';
    if wx_ControlOrientation = wxControlVertical then
      strAlignment := SizerAlignmentToStr(Wx_HorizontalAlignment) + ' | wxALL';

    if wx_ControlOrientation = wxControlHorizontal then
      strAlignment := SizerAlignmentToStr(Wx_VerticalAlignment) + ' | wxALL';


    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

end;

function TWxTreeCtrl.GenerateGUIControlDeclaration: string;
begin
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxTreeCtrl.GenerateHeaderInclude: string;
begin
  Result := '#include <wx/treectrl.h>';
end;

function TWxTreeCtrl.GenerateImageInclude: string;
begin

end;

function TWxTreeCtrl.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxTreeCtrl.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxTreeCtrl.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxTreeCtrl.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_TREE_SEL_CHANGED' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_SEL_CHANGING' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_BEGIN_DRAG' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_BEGIN_RDRAG' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_BEGIN_LABEL_EDIT' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_END_LABEL_EDIT' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_DELETE_ITEM' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_GET_INFO' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_SET_INFO' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_ACTIVATED' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_COLLAPSED' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_COLLAPSING' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_EXPANDED' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_EXPANDING' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_KEY_DOWN' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxTreeCtrl.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxTreeCtrl.GetStretchFactor: integer;
begin
  Result := Wx_StretchFactor;
end;

function TWxTreeCtrl.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxTreeCtrl.GetWxClassName: string;
begin
  if wx_Class = '' then
    wx_Class := 'wxTreeCtrl';
  Result := wx_Class;
end;

procedure TWxTreeCtrl.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxTreeCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxTreeCtrl.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxTreeCtrl.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxTreeCtrl.SetStretchFactor(intValue: integer);
begin
  Wx_StretchFactor := intValue;
end;

procedure TWxTreeCtrl.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxTreeCtrl.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxTreeCtrl.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxTreeCtrl.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxTreeCtrl.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxTreeCtrl.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxTreeCtrl.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

end.
