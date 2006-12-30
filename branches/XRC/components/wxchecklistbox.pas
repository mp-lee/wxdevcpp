 { ****************************************************************** }
 { $Id$ }
 {                                                                    }
 {   VCL component TWxListBox                                         }
 {                                                                    }
 {   Code generated by Component Create for Delphi                    }
 {                                                                    }
 {   Generated from source file e:\backup\delphi\...\wxlist~1.cd      }
 {   on 13 Oct 2004 at 23:12                                          }
 {                                                                    }
 {   Copyright � 2003 by Guru Kathiresan                              }
 {                                                                    }
 { ****************************************************************** }

unit WxCheckListBox;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, WxUtils, CheckLst, ExtCtrls, WxSizerPanel;

type
  TWxCheckListBox = class(TCheckListBox, IWxComponentInterface)
  private
    { Private fields of TWxListBox }
    FEVT_CHECKLISTBOX: string;
    FEVT_LISTBOX: string;
    FEVT_LISTBOX_DCLICK: string;
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
    FWx_IDName: string;
    FWx_IDValue: longint;
    FWx_ListboxStyle: TWxLBxStyleSet;
    FWx_ListboxSubStyle: TWxLBxStyleSubItem;
    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;
    FWx_StretchFactor: integer;
    FWx_ToolTip: string;
    FWx_Validator: string;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;

    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignment;
    FWx_BorderAlignment: TWxBorderAlignment;

    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;

    { Private methods of TWxListBox }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected
    { Protected fields of TWxListBox }

    { Protected methods of TWxListBox }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxListBox }
    defaultBGColor: TColor;
    defaultFGColor: TColor;

    { Public methods of TWxListBox }
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
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
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
    function GetCheckListBoxSelectorStyle(Value: TWxLBxStyleSubItem): string;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published properties of TWxListBox }
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
    property EVT_LISTBOX: string Read FEVT_LISTBOX Write FEVT_LISTBOX;
    property EVT_CHECKLISTBOX: string Read FEVT_CHECKLISTBOX Write FEVT_CHECKLISTBOX;
    property EVT_LISTBOX_DCLICK: string Read FEVT_LISTBOX_DCLICK
      Write FEVT_LISTBOX_DCLICK;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_ListboxStyle: TWxLBxStyleSet
      Read FWx_ListboxStyle Write FWx_ListboxStyle;
    property Wx_ListboxSubStyle: TWxLBxStyleSubItem
      Read FWx_ListboxSubStyle Write FWx_ListboxSubStyle;
    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignment Read FWx_Alignment Write FWx_Alignment default wxALIGN_CENTER;
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxListBox with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxCheckListBox]);
end;

{ Method to set variable and property values and create objects }
procedure TWxCheckListBox.AutoInitialize;
begin
  FWx_EventList       := TStringList.Create;
  FWx_PropertyList    := TStringList.Create;
  FWx_Border          := 5;
  FWx_Class           := 'wxCheckListBox';
  FWx_Enabled         := True;
  FWx_Alignment       := wxALIGN_CENTER;
  FWx_BorderAlignment := [wxAll];
  FWx_IDValue         := -1;
  FWx_StretchFactor   := 0;
  FWx_Comments        := TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxCheckListBox.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

{ Override OnClick handler from TListBox,IWxComponentInterface }
procedure TWxCheckListBox.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TListBox,IWxComponentInterface }
procedure TWxCheckListBox.KeyPress(var Key: char);
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

constructor TWxCheckListBox.Create(AOwner: TComponent);
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

  FWx_PropertyList.add('Wx_Enabled:Enabled');
  FWx_PropertyList.add('Wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Hidden:Hidden');
  FWx_PropertyList.add('Wx_Default:Default');
  FWx_PropertyList.add('Wx_HelpText:Help Text');
  FWx_PropertyList.add('Wx_IDName:ID Name');
  FWx_PropertyList.add('Wx_IDValue:ID Value');
  FWx_PropertyList.add('Wx_ToolTip:Tooltip');
  FWx_PropertyList.add('Wx_Comments:Comments');
  FWx_PropertyList.Add('Wx_Validator:Validator code');
  FWx_PropertyList.add('Wx_ProxyBGColorString:Background Color');
  FWx_PropertyList.add('Wx_ProxyFGColorString:Foreground Color');

  FWx_PropertyList.add('Wx_StretchFactor:Stretch Factor');
  FWx_PropertyList.add('Wx_Alignment:Alignment');
  FWx_PropertyList.add('Wx_Border: Border');
  FWx_PropertyList.add('Wx_BorderAlignment:Borders');
  FWx_PropertyList.add('wxALL:wxALL');
  FWx_PropertyList.add('wxTOP:wxTOP');
  FWx_PropertyList.add('wxLEFT:wxLEFT');
  FWx_PropertyList.add('wxRIGHT:wxRIGHT');
  FWx_PropertyList.add('wxBOTTOM:wxBOTTOM');

  FWx_PropertyList.add('Wx_GeneralStyle:General Styles');
  FWx_PropertyList.Add('wxNO_3D:wxNO_3D');
  FWx_PropertyList.Add('wxNO_BORDER:wxNO_BORDER');
  FWx_PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
  FWx_PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');
  FWx_PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
  FWx_PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
  FWx_PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
  FWx_PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
  FWx_PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
  FWx_PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
  FWx_PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
  FWx_PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
  FWx_PropertyList.Add('wxVSCROLL:wxVSCROLL');
  FWx_PropertyList.Add('wxHSCROLL:wxHSCROLL');

  FWx_PropertyList.add('Wx_ListboxSubStyle:Selection Mode');
  FWx_PropertyList.add('wxLB_SINGLE:wxLB_SINGLE');
  FWx_PropertyList.add('wxLB_MULTIPLE:wxLB_MULTIPLE');
  FWx_PropertyList.add('wxLB_EXTENDED:wxLB_EXTENDED');
  FWx_PropertyList.add('Wx_ListboxStyle:Listbox Style');
  FWx_PropertyList.add('wxLB_HSCROLL:wxLB_HSCROLL');
  FWx_PropertyList.add('wxLB_ALWAYS_SB:wxLB_ALWAYS_SB');
  FWx_PropertyList.add('wxLB_NEEDED_SB:wxLB_NEEDED_SB');
  FWx_PropertyList.add('wxLB_SORT:wxLB_SORT');
  
  FWx_PropertyList.add('Items:Items');
  FWx_PropertyList.add('Text:Text');
  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Left:Left');
  FWx_PropertyList.add('Font:Font');
  FWx_PropertyList.add('Top:Top');
  FWx_PropertyList.add('Width:Width');
  FWx_PropertyList.add('Height:Height');

  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
  FWx_EventList.add('EVT_CHECKLISTBOX:OnCheckListBox');
  FWx_EventList.add('EVT_LISTBOX:OnEnter');
  FWx_EventList.add('EVT_TEXT:OnSelected');
  FWx_EventList.add('EVT_LISTBOX_DCLICK:OnDoubleClicked');

end;

destructor TWxCheckListBox.Destroy;
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


function TWxCheckListBox.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxCheckListBox.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;


function TWxCheckListBox.GenerateEventTableEntries(CurrClassName: string): string;
begin

  Result := '';

if (XRCGEN) then
 begin
  if trim(EVT_CHECKLISTBOX) <> '' then
    Result := Format('EVT_CHECKLISTBOX(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_CHECKLISTBOX]) + '';


  if trim(EVT_LISTBOX) <> '' then
    Result := Result + #13 + Format('EVT_LISTBOX(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LISTBOX]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_LISTBOX_DCLICK) <> '' then
    Result := Result + #13 + Format('EVT_LISTBOX_DCLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LISTBOX_DCLICK]) + '';
 end
 else
 begin
  if trim(EVT_CHECKLISTBOX) <> '' then
    Result := Format('EVT_CHECKLISTBOX(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_CHECKLISTBOX]) + '';


  if trim(EVT_LISTBOX) <> '' then
    Result := Result + #13 + Format('EVT_LISTBOX(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LISTBOX]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_LISTBOX_DCLICK) <> '' then
    Result := Result + #13 + Format('EVT_LISTBOX_DCLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LISTBOX_DCLICK]) + '';
 end;

end;

function TWxCheckListBox.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  i: integer;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('<IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('<ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('<size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('<pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + '<content>');

    // 9 Aug 2005 Tony Reina - Looks like we don't have a way to set checked status
    for i := 0 to self.Items.Count - 1 do
      Result.Add(IndentString + '  <item checked="0">' + self.Items[i] + '</item>');

    Result.Add(IndentString + '</content>');

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxCheckListBox.GenerateGUIControlCreation: string;
var
  i: integer;
  strStyle, parentName, strAlignment: string;
  strColorStr: string;
begin
  Result := '';

  parentName := GetWxWidgetParent(self);

  strStyle := GetListBoxSpecificStyle(self.Wx_GeneralStyle, Wx_ListboxStyle);

  if (trim(strStyle) <> '') then
    strStyle := GetCheckListBoxSelectorStyle(Wx_ListboxSubStyle) + ' | ' +
      strStyle
  else
    strStyle := GetCheckListBoxSelectorStyle(Wx_ListboxSubStyle);

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

 if (XRCGEN) then
 begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]); 
 end
 else
 begin
  Result := Format('wxArrayString arrayStringFor_%s;', [self.Name]);
  Result := GetCommentString(self.FWx_Comments.Text) +
    Result + #13 + Format('%s = new %s(%s, %s, wxPoint(%d,%d), wxSize(%d,%d), arrayStringFor_%s%s);',
    [self.Name, self.Wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    self.Left, self.Top, self.Width, self.Height, self.Name, strStyle]);
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

  for i := 0 to self.Items.Count - 1 do
    Result := Result + #13 + Format('%s->Append(%s);',
      [self.Name, GetCppString(self.Items[i])]);

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
  if (self.Parent is TWxSizerPanel) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

end;

function TWxCheckListBox.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxCheckListBox.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/checklst.h>';

end;

function TWxCheckListBox.GenerateImageInclude: string;
begin

end;

function TWxCheckListBox.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxCheckListBox.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxCheckListBox.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxCheckListBox.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_CHECKLISTBOX' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;

  if EventName = 'EVT_LISTBOX' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;

  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;

  if EventName = 'EVT_LISTBOX_DCLICK' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;

end;

function TWxCheckListBox.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxCheckListBox.GetStretchFactor: integer;
begin
   Result := 1;
end;

function TWxCheckListBox.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxCheckListBox.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxCheckListBox.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxCheckListBox.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxCheckListBox.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxCheckListBox.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxCheckListBox';
  Result := wx_Class;
end;

procedure TWxCheckListBox.Loaded;
begin
  inherited Loaded;
     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxCheckListBox.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxCheckListBox.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxCheckListBox.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxCheckListBox.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxCheckListBox.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxCheckListBox.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxCheckListBox.SetGenericColor(strVariableName,strValue: string);
begin

end;


function TWxCheckListBox.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxCheckListBox.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxCheckListBox.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxCheckListBox.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxCheckListBox.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxCheckListBox.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxCheckListBox.GetCheckListBoxSelectorStyle(Value: TWxLBxStyleSubItem): string;
begin
  Result := '';
  if Value = wxLB_SINGLE then
  begin
    Result := ', wxLB_SINGLE';
    exit;
  end;
  if Value = wxLB_MULTIPLE then
  begin
    Result := ', wxLB_MULTIPLE';
    exit;
  end;
  if Value = wxLB_EXTENDED then
  begin
    Result := ', wxLB_EXTENDED';
    exit;
  end;
end;

end.
