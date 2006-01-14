 { ****************************************************************** }
 {                                                                    }
{ $Id$                                                               }
 {                                                                    }
 {   VCL component TWxEdit                                            }
 {                                                                    }
 {   Code generated by Component Create for Delphi                    }
 {                                                                    }
 {   Generated from source file wxedit.cd }
 {   on 10 Oct 2004 at 0:50                                           }
 {                                                                    }
 {   Copyright � 2003 by Guru Kathiresan                              }
 {                                                                    }
 { ****************************************************************** }

unit WxEdit;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, WxUtils, ExtCtrls, WxSizerPanel, WxToolBar, JvEdit;

type
  TWxEdit = class(TJvEdit, IWxComponentInterface, IWxToolBarInsertableInterface,
    IWxToolBarNonInsertableInterface)
  private
    { Private fields of TWxEdit }
    { Storage for property EVT_TEXT }
    FEVT_TEXT: string;
    { Storage for property EVT_TEXT_ENTER }
    FEVT_TEXT_ENTER: string;
    { Storage for property EVT_TEXT_MAXLEN }
    FEVT_TEXT_MAXLEN: string;
    { Storage for property EVT_TEXT_URL }
    FEVT_TEXT_URL: string;
    { Storage for property EVT_UPDATE_UI }
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
    FWx_EditStyle: TWxEdtGeneralStyleSet;
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
    { Storage for property Wx_HorizontalAlignment }
    FWx_HorizontalAlignment: TWxSizerHorizontalAlignment;
    { Storage for property Wx_IDName }
    FWx_IDName: string;
    { Storage for property Wx_IDValue }
    FWx_IDValue: longint;
    { Storage for property Wx_ProxyBGColorString }
    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor: integer;
    { Storage for property Wx_ToolTip }
    FWx_ToolTip: string;
    FWx_Validator: string;
    { Storage for property Wx_VerticalAlignment }
    FWx_VerticalAlignment: TWxSizerVerticalAlignment;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_MaxLength: integer;
    FWx_Comments: TStrings;

    { Private methods of TWxEdit }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;
    { Read method for property Wx_EditStyle }
    function GetWx_EditStyle: TWxEdtGeneralStyleSet;
    { Write method for property Wx_EditStyle }
    procedure SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);

  protected
    { Protected fields of TWxEdit }

    { Protected methods of TWxEdit }
    procedure Change; override;
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxEdit }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxEdit }
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
    procedure DummyToolBarInsertableInterfaceProcedure;

  published
    { Published properties of TWxEdit }
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
    property EVT_TEXT: string Read FEVT_TEXT Write FEVT_TEXT;
    property EVT_TEXT_ENTER: string Read FEVT_TEXT_ENTER Write FEVT_TEXT_ENTER;
    property EVT_TEXT_MAXLEN: string Read FEVT_TEXT_MAXLEN Write FEVT_TEXT_MAXLEN;
    property EVT_TEXT_URL: string Read FEVT_TEXT_URL Write FEVT_TEXT_URL;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Border: integer Read FWx_Border Write FWx_Border default 5;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    { TWxEdtGeneralStyleSet }
    property Wx_EditStyle: TWxEdtGeneralStyleSet
      Read GetWx_EditStyle Write SetWx_EditStyle;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
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
    property Wx_ProxyBGColorString: TWxColorString
      Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString
      Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property Wx_StrechFactor: integer Read FWx_StretchFactor Write FWx_StretchFactor;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_StretchFactor: integer Read FWx_StretchFactor
      Write FWx_StretchFactor default 0;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

    property Wx_MaxLength: integer Read FWx_MaxLength Write FWx_MaxLength;

    property Wx_VerticalAlignment: TWxSizerVerticalAlignment
      Read FWx_VerticalAlignment Write FWx_VerticalAlignment default
      wxSZALIGN_CENTER_VERTICAL;
    property InvisibleBGColorString: string
      Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string
      Read FInvisibleFGColorString Write FInvisibleFGColorString;

  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxEdit with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxEdit]);
end;

{ Method to set variable and property values and create objects }
procedure TWxEdit.AutoInitialize;
begin
  FWx_EventList  := TStringList.Create;
  FWx_PropertyList := TStringList.Create;
  FWx_Border     := 5;
  FWx_Class      := 'wxTextCtrl';
  FWx_Enabled    := True;
  FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
  FWx_IDValue    := -1;
  FWx_StretchFactor := 0;
  FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor := self.color;
  defaultFGColor := self.font.color;
  BorderStyle    := bsSingle;
  FWx_Comments   := TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxEdit.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

{ Read method for property Wx_EditStyle }
function TWxEdit.GetWx_EditStyle: TWxEdtGeneralStyleSet;
begin
  Result := FWx_EditStyle;
end;

{ Write method for property Wx_EditStyle }
procedure TWxEdit.SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);
begin
  FWx_EditStyle := Value;
  if wxTE_PASSWORD in FWx_EditStyle then
    PasswordChar := '*'
  else
    PasswordChar := #0;

  // Change the text justification in the form designer
  if wxTE_CENTRE in Value then
    self.Alignment := taCenter
  else if wxTE_RIGHT in Value then
    self.Alignment := taRightJustify
  else
    self.Alignment := taLeftJustify;

end;

{ Override OnChange handler from TEdit,IWxComponentInterface }
procedure TWxEdit.Change;
begin
  inherited Change;
end;

{ Override OnClick handler from TEdit,IWxComponentInterface }
procedure TWxEdit.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TEdit,IWxComponentInterface }
procedure TWxEdit.KeyPress(var Key: char);
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

constructor TWxEdit.Create(AOwner: TComponent);
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
  FWx_PropertyList.add('Wx_Enabled :Enabled');
  FWx_PropertyList.add('Wx_Class :Base Class');
  FWx_PropertyList.add('Wx_Hidden :Hidden');
  FWx_PropertyList.add('Wx_Border : Border ');
  FWx_PropertyList.add('Wx_HelpText :HelpText ');
  FWx_PropertyList.add('Wx_IDName : IDName ');
  FWx_PropertyList.add('Wx_IDValue : IDValue ');
  FWx_PropertyList.add('Wx_ToolTip :ToolTip ');
  FWx_PropertyList.add('Wx_MaxLength :MaxLength ');

  FWx_PropertyList.add('Wx_Enable :Enabled');
  FWx_PropertyList.add('Wx_Visible :Visible');
  FWx_PropertyList.add('Name : Name');
  FWx_PropertyList.add('Left : Left');
  FWx_PropertyList.add('Top : Top');
  FWx_PropertyList.add('Width : Width');
  FWx_PropertyList.add('Height:Height');
  FWx_PropertyList.add('Text:Text');

  FWx_PropertyList.add('Wx_Comments:Comments');
  FWx_PropertyList.add('Wx_Validator : Validator code');

  FWx_PropertyList.add('Wx_ProxyBGColorString:Background Color');
  FWx_PropertyList.add('Wx_ProxyFGColorString:Foreground Color');

  FWx_PropertyList.add('Wx_GeneralStyle: General Styles');
  FWx_PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
  FWx_PropertyList.Add('wxNO_BORDER:wxNO_BORDER');
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
  FWx_PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');

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

  FWx_PropertyList.add('Font : Font');

  FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
  FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');

  FWx_PropertyList.add('Wx_StretchFactor   : StretchFactor');

  FWx_EventList.add('EVT_TEXT_ENTER:OnEnter');
  FWx_EventList.add('EVT_TEXT:OnUpdated');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
  FWx_EventList.add('EVT_TEXT_MAXLEN:OnMaxLen');
  FWx_EventList.add('EVT_TEXT_URL:OnClickUrl');

end;

destructor TWxEdit.Destroy;
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


function TWxEdit.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxEdit.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxEdit.GenerateEventTableEntries(CurrClassName: string): string;
begin

  Result := '';

  if trim(EVT_TEXT_ENTER) <> '' then
    Result := Format('EVT_TEXT_ENTER(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT_ENTER]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_TEXT) <> '' then
    Result := Result + #13 + Format('EVT_TEXT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT]) + '';

  if trim(EVT_TEXT_MAXLEN) <> '' then
    Result := Result + #13 + Format('EVT_TEXT_MAXLEN(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT_MAXLEN]) + '';

  if trim(EVT_TEXT_URL) <> '' then
    Result := Result + #13 + Format('EVT_TEXT_URL(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT_URL]) + '';

end;

function TWxEdit.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('<IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('<ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('<size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('<pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('<style>%s</style>',
      [GetEditSpecificStyle(self.Wx_GeneralStyle, self.Wx_EditStyle)]));
    Result.Add(IndentString + Format('<value>%s</value>', [XML_Label(self.Caption)]));
    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxEdit.GenerateGUIControlCreation: string;
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

  strStyle := GetEditSpecificStyle(self.Wx_GeneralStyle, self.Wx_EditStyle);

  if trim(self.FWx_Validator) <> '' then
  begin
    if trim(strStyle) <> '' then
      strStyle := ', ' + strStyle + ', ' + self.Wx_Validator
    else
      strStyle := ', 0, ' + self.Wx_Validator;

    strStyle := strStyle + ', ' + GetCppString(Name);

  end
  else if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
  else
    strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);


  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s, wxPoint(%d,%d), wxSize(%d,%d)%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    GetCppString(self.Text), self.Left, self.Top, self.Width, self.Height, strStyle]);

  if trim(self.Wx_ToolTip) <> '' then
    Result := Result + #13 + Format('%s->SetToolTip(%s);',
      [self.Name, GetCppString(self.Wx_ToolTip)]);

  if self.Wx_MaxLength <> 0 then
    Result := Result + #13 + Format('%s->SetMaxLength(%d);',
      [self.Name, self.Wx_MaxLength]);

  if self.Wx_Hidden then
    Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

  if not Wx_Enabled then
    Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

  if (trim(self.Wx_HelpText) <> '') then
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
  if (self.Parent is TWxToolBar) then
    Result := Result + #13 + Format('%s->AddControl(%s);',
      [self.Parent.Name, self.Name]);

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

end;

function TWxEdit.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxEdit.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/textctrl.h>';
end;

function TWxEdit.GenerateImageInclude: string;
begin

end;

function TWxEdit.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxEdit.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxEdit.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxEdit.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_TEXT' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_TEXT_MAXLEN' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_TEXT_URL' then
  begin
    Result := 'wxTextUrlEvent& event';
    exit;
  end;
  if EventName = 'EVT_TEXT_ENTER' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxEdit.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxEdit.GetStretchFactor: integer;
begin
  Result := Wx_StretchFactor;
end;

function TWxEdit.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxEdit.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxTextCtrl';

  Result := wx_Class;
end;

procedure TWxEdit.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxEdit.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxEdit.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxEdit.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxEdit.SetStretchFactor(intValue: integer);
begin
  Wx_StretchFactor := intValue;
end;

procedure TWxEdit.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxEdit.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxEdit.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxEdit.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxEdit.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxEdit.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxEdit.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

procedure TWxEdit.DummyToolBarInsertableInterfaceProcedure;
begin

end;

end.
