 { ****************************************************************** }
 {                                                                    }
{ $Id$                                                               }
 {                                                                    }
 {   VCL component TWxRadioButton                                     }
 {                                                                    }
 {   Code generated by Component Create for Delphi                    }
 {                                                                    }
 {   Generated from source file wxradiobutton.cd }
 {   on 10 Oct 2004 at 0:50                                           }
 {                                                                    }
 {   Copyright � 2003 by Guru Kathiresan                              }
 {                                                                    }
 { ****************************************************************** }

unit WxRadioButton;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxSizerPanel, WxToolBar;

type
  TWxRadioButton = class(TRadioButton, IWxComponentInterface,
    IWxToolBarInsertableInterface, IWxToolBarNonInsertableInterface)
  private
    { Private fields of TWxRadioButton }
    FEVT_CHECKBOX: string;
    FEVT_TEXT: string;
    FEVT_RADIOBUTTON: string;
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
    FWx_RadioButtonStyle: TWxRBStyleSet;
    FWx_StretchFactor: integer;
    FWx_ToolTip: string;
    FWx_VerticalAlignment: TWxSizerVerticalAlignment;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Validator: string;
    FWx_Comments: TStrings;

    { Private methods of TWxRadioButton }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected
    { Protected fields of TWxRadioButton }

    { Protected methods of TWxRadioButton }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxRadioButton }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxRadioButton }
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
    { Published properties of TWxRadioButton }
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
    property EVT_CHECKBOX: string Read FEVT_CHECKBOX Write FEVT_RADIOBUTTON;
    property EVT_TEXT: string Read FEVT_TEXT Write FEVT_TEXT;
    property EVT_RADIOBUTTON: string Read FEVT_RADIOBUTTON Write FEVT_RADIOBUTTON;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Border: integer Read FWx_Border Write FWx_Border default 5;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden default False;
    property Wx_HorizontalAlignment: TWxSizerHorizontalAlignment
      Read FWx_HorizontalAlignment Write FWx_HorizontalAlignment default
      wxSZALIGN_CENTER_HORIZONTAL;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_ProxyBGColorString: TWxColorString
      Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString
      Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property Wx_RadioButtonStyle: TWxRBStyleSet
      Read FWx_RadioButtonStyle Write FWx_RadioButtonStyle;
    property Wx_StrechFactor: integer Read FWx_StretchFactor Write FWx_StretchFactor;
    property Wx_StretchFactor: integer Read FWx_StretchFactor
      Write FWx_StretchFactor default 0;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_VerticalAlignment: TWxSizerVerticalAlignment
      Read FWx_VerticalAlignment Write FWx_VerticalAlignment default wxSZALIGN_CENTER_VERTICAL;
    property InvisibleBGColorString: string
      Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string
      Read FInvisibleFGColorString Write FInvisibleFGColorString;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxRadioButton]);
end;

{ Method to set variable and property values and create objects }
procedure TWxRadioButton.AutoInitialize;
begin
  FWx_EventList  := TStringList.Create;
  FWx_PropertyList := TStringList.Create;
  FWx_Border     := 5;
  FWx_Class      := 'wxRadioButton';
  FWx_Enabled    := True;
  FWx_Hidden     := False;
  FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
  FWx_IDValue    := -1;
  FWx_StretchFactor := 0;
  FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor := clBtnFace;
  defaultFGColor := self.font.color;
  FWx_Comments   := TStringList.Create;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxRadioButton.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

procedure TWxRadioButton.Click;
begin
  inherited Click;
end;

procedure TWxRadioButton.KeyPress(var Key: char);
const
  TabKey   = char(VK_TAB);
  EnterKey = char(VK_RETURN);
begin
  inherited KeyPress(Key);
end;

constructor TWxRadioButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoInitialize;

  FWx_PropertyList.add('Wx_RadioButtonStyle:Radiobutton Style');
  FWx_PropertyList.add('Wx_Hidden :Hidden');
  FWx_PropertyList.add('Wx_Border : Border ');
  FWx_PropertyList.add('Wx_Default :WxDefault ');
  FWx_PropertyList.add('Wx_HelpText :HelpText ');
  FWx_PropertyList.add('Wx_IDName : IDName ');
  FWx_PropertyList.add('Wx_IDValue : IDValue ');
  FWx_PropertyList.add('Wx_ToolTip :ToolTip ');
  FWx_PropertyList.add('Caption:Caption');
  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Enabled:Enabled');
  FWx_PropertyList.add('Left:Left');
  FWx_PropertyList.add('Top:Top');
  FWx_PropertyList.add('Width:Width');
  FWx_PropertyList.add('Height:Height');
  FWx_PropertyList.add('Wx_ProxyBGColorString:Background Color');
  FWx_PropertyList.add('Wx_ProxyFGColorString:Foreground Color');
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
  FWx_PropertyList.add('Font : Font');
  FWx_PropertyList.add('Checked : Checked');
  FWx_PropertyList.add('Wx_RadioButtonStyle:Radio Button Style');
  FWx_PropertyList.add('wxRB_GROUP:wxRB_GROUP');
  FWx_PropertyList.add('wxRB_SINGLE:wxRB_SINGLE');
  FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
  FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');
  FWx_PropertyList.add('Wx_StretchFactor   : StretchFactor');
  FWx_PropertyList.add('Wx_Validator : Validator code');
  FWx_PropertyList.add('Wx_Comments:Comments');

  FWx_EventList.add('EVT_RADIOBUTTON:OnClick');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxRadioButton.Destroy;
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


function TWxRadioButton.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxRadioButton.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxRadioButton.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
  if trim(EVT_RADIOBUTTON) <> '' then
    Result := Format('EVT_RADIOBUTTON(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_RADIOBUTTON]) + '';
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
end;

function TWxRadioButton.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <label>%s</label>', [XML_Label(self.Caption)]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetRadioButtonSpecificStyle(self.Wx_GeneralStyle, Wx_RadioButtonStyle)]));

    if self.Checked then
      Result.Add(IndentString + '  <value>1</value>')
    else
      Result.Add(IndentString + '  <value>0</value>');

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxRadioButton.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';

  parentName := GetWxWidgetParent(self);

  strStyle := GetRadioButtonSpecificStyle(self.Wx_GeneralStyle, Wx_RadioButtonStyle);

  if (trim(strStyle) <> '') then
    strStyle := ', ' + strStyle;

  if trim(self.FWx_Validator) <> '' then
  begin
    if trim(strStyle) <> '' then
      strStyle := strStyle + ', ' + self.Wx_Validator
    else
      strStyle := ', 0, ' + self.Wx_Validator;

    strStyle := strStyle + ', ' + GetCppString(Name);

  end
  else if trim(strStyle) <> '' then
    strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
  else
    strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);

  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s, wxPoint(%d,%d), wxSize(%d,%d)%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(Wx_IDName, self.Wx_IDValue),
    GetCppString(self.Caption), self.Left, self.Top, self.Width, self.Height, strStyle]);

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

  if self.Checked then
    Result := Result + #13 + Format('%s->SetValue(true);', [self.Name]);

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

end;

function TWxRadioButton.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxRadioButton.GenerateHeaderInclude: string;
begin
  Result := '#include <wx/radiobut.h>';
end;

function TWxRadioButton.GenerateImageInclude: string;
begin

end;

function TWxRadioButton.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxRadioButton.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxRadioButton.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxRadioButton.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_RADIOBUTTON' then
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

function TWxRadioButton.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxRadioButton.GetStretchFactor: integer;
begin
  Result := Wx_StretchFactor;
end;

function TWxRadioButton.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxRadioButton.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxRadioButton';
  Result := Wx_Class;
end;

procedure TWxRadioButton.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxRadioButton.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxRadioButton.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxRadioButton.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDValue;
end;

procedure TWxRadioButton.SetStretchFactor(intValue: integer);
begin
  Wx_StretchFactor := intValue;
end;

procedure TWxRadioButton.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxRadioButton.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxRadioButton.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxRadioButton.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxRadioButton.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxRadioButton.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxRadioButton.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

end.