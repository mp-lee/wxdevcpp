 { ****************************************************************** }
 {                                                                    }
{ $Id$                                                               }
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

unit wxRichTextStyleListBox;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, WxUtils, ExtCtrls, WxAuiToolBar, WxSizerPanel, WxAuiNotebookPage, UValidator;

type
  TwxRichTextStyleListBox = class(TListBox, IWxComponentInterface, IWxValidatorInterface)
  private
    { Private fields of TwxRichTextStyleListBox }
    FEVT_LEFT_DOWN: string;
    FEVT_LEFT_DCLICK: string;
    FEVT_IDLE: string;
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
//    FWx_ListboxStyle: TWxLBxStyleSet;
//    FWx_ListboxSubStyle: TWxLBxStyleSubItem;
    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;
    FWx_StretchFactor: integer;
    FWx_ToolTip: string;
    FWx_Validator: string;
    FWx_ProxyValidatorString : TWxValidatorString;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    FWx_Comments: TStrings;
    
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;

    
    FWx_RichTextCtrl : String;
    FWx_StyleSheet : String;


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

    { Private methods of TwxRichTextStyleListBox }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected
    { Protected fields of TwxRichTextStyleListBox }

    { Protected methods of TwxRichTextStyleListBox }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TwxRichTextStyleListBox }
    { Public fields and properties of TWxGrid }
    defaultBGColor: TColor;
    defaultFGColor: TColor;

    { Public methods of TwxRichTextStyleListBox }
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

    function GetValidator:String;
    procedure SetValidator(value:String);
    function GetValidatorString:TWxValidatorString;
    procedure SetValidatorString(Value:TWxValidatorString);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
{    function GetListBoxSelectorStyle(Wx_ListboxSubStyle: TWxLBxStyleSubItem)
      : string;   }

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published properties of TwxRichTextStyleListBox }
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

    property EVT_LEFT_DOWN: string Read FEVT_LEFT_DOWN  Write FEVT_LEFT_DOWN;
    property EVT_LEFT_DCLICK: string Read FEVT_LEFT_DCLICK  Write FEVT_LEFT_DCLICK;
    property EVT_IDLE: string Read FEVT_IDLE  Write FEVT_IDLE;
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
{    property Wx_ListboxStyle: TWxLBxStyleSet
      Read FWx_ListboxStyle Write FWx_ListboxStyle;
    property Wx_ListboxSubStyle: TWxLBxStyleSubItem
      Read FWx_ListboxSubStyle Write FWx_ListboxSubStyle;             }
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
    property Wx_RichTextCtrl: string Read FWx_RichTextCtrl Write FWx_RichTextCtrl;
    property Wx_StyleSheet: string Read FWx_StyleSheet Write FWx_StyleSheet;

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
     { Register TwxRichTextStyleListBox with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TwxRichTextStyleListBox]);
end;

{ Method to set variable and property values and create objects }
procedure TwxRichTextStyleListBox.AutoInitialize;
begin
  FWx_EventList       := TStringList.Create;
  FWx_PropertyList    := TStringList.Create;
  FWx_Border          := 5;
  FWx_Class           := 'wxRichTextStyleListBox';
  FWx_Enabled         := True;
  FWx_BorderAlignment := [wxAll];
  FWx_Alignment       := [wxALIGN_CENTER];
  FWx_IDValue         := -1;
  FWx_StretchFactor   := 0;
  FWx_Comments        := TStringList.Create;
  FWx_ProxyValidatorString := TwxValidatorString.Create(self);


end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TwxRichTextStyleListBox.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyValidatorString.Destroy;
end; { of AutoDestroy }

{ Override OnClick handler from TListBox,IWxComponentInterface }
procedure TwxRichTextStyleListBox.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TListBox,IWxComponentInterface }
procedure TwxRichTextStyleListBox.KeyPress(var Key: char);
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

constructor TwxRichTextStyleListBox.Create(AOwner: TComponent);
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

  FWx_PropertyList.add('Checked:Checked');
  FWx_PropertyList.add('Items:Strings');

{  FWx_PropertyList.add('Wx_ListboxSubStyle:Selection Mode');
  FWx_PropertyList.add('wxLB_SINGLE:wxLB_SINGLE');
  FWx_PropertyList.add('wxLB_MULTIPLE:wxLB_MULTIPLE');
  FWx_PropertyList.add('wxLB_EXTENDED:wxLB_EXTENDED');
  FWx_PropertyList.add('Wx_ListboxStyle:Listbox Style');
  FWx_PropertyList.add('wxLB_HSCROLL:wxLB_HSCROLL');
  FWx_PropertyList.add('wxLB_ALWAYS_SB:wxLB_ALWAYS_SB');
  FWx_PropertyList.add('wxLB_NEEDED_SB:wxLB_NEEDED_SB');
  FWx_PropertyList.add('wxLB_SORT:wxLB_SORT');
}
  FWx_PropertyList.add('Wx_RichTextCtrl:RichTextCtrl');
  FWx_PropertyList.add('Wx_StyleSheet:WStyleSheet');


  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
  FWx_EventList.add('EVT_LEFT_DOWN:OnLeftDown');
  FWx_EventList.add('EVT_LEFT_DCLICK:OnLeftDClick');
  FWx_EventList.add('EVT_IDLE:OnIdle');

end;

destructor TwxRichTextStyleListBox.Destroy;
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


function TwxRichTextStyleListBox.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TwxRichTextStyleListBox.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;


function TwxRichTextStyleListBox.GenerateEventTableEntries(CurrClassName: string): string;
  { Internal declarations for method }

  { var }
  { . . . }
begin

  Result := '';

if (XRCGEN) then
 begin
  if trim(EVT_LEFT_DOWN) <> '' then
    Result := Format('EVT_LEFT_DOWN(XRCID(%s("%s")),%s::%s)',
    [StringFormat, self.Name, CurrClassName, EVT_LEFT_DOWN]) + '';

  if trim(EVT_LEFT_DCLICK) <> '' then
    Result := Format('EVT_LEFT_DCLICK(XRCID(%s("%s")),%s::%s)',
    [StringFormat, self.Name, CurrClassName, EVT_LEFT_DCLICK]) + '';

  if trim(EVT_IDLE) <> '' then
    Result := Result + #13 + Format('EVT_IDLE(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_IDLE]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
 end
 else
 begin
  if trim(EVT_LEFT_DOWN) <> '' then
    Result := Format('EVT_LEFT_DOWN(%s,%s::%s)', [WX_IDName, CurrClassName, EVT_LEFT_DOWN]) + '';

  if trim(EVT_LEFT_DCLICK) <> '' then
    Result := Format('EVT_LEFT_DCLICK(%s,%s::%s)', [WX_IDName, CurrClassName, EVT_LEFT_DCLICK]) + '';

  if trim(EVT_IDLE) <> '' then
    Result := Result + #13 + Format('EVT_IDLE(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_IDLE]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
 end;

end;

function TwxRichTextStyleListBox.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  stylestring: string;
  i: integer;
begin

  Result := TStringList.Create;
  Result.Add(IndentString + Format('<object class="%s" name="%s">',
    [self.Wx_Class, self.Name]));
  Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
  Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

    if not(UseDefaultSize)then
      Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    if not(UseDefaultPos) then
      Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));
  stylestring :=  GetStdStyleString(self.Wx_GeneralStyle);//GetListBoxSelectorStyle(Wx_ListboxSubStyle);
  Result.Add(IndentString + Format('  <style>%s</style>', [stylestring]));

{  stylestring := GetListBoxSpecificStyle(self.Wx_GeneralStyle, Wx_ListboxStyle);
  if Trim(stylestring) <> '' then 
    stylestring := GetListBoxSelectorStyle(Wx_ListboxSubStyle) + ' | ' +
                   GetListBoxSpecificStyle(self.Wx_GeneralStyle, Wx_ListboxStyle)
  else
    stylestring := GetListBoxSelectorStyle(Wx_ListboxSubStyle);
  Result.Add(IndentString + Format('  <style>%s</style>', [stylestring]));

  Result.Add(IndentString + '  <content>');
  for i := 0 to self.Items.Count - 1 do
    Result.Add(IndentString + '    <item>' + Items[i] + '</item>');
}
  Result.Add(IndentString + '  </content>');

  Result.Add(IndentString + '</object>');

end;

function TwxRichTextStyleListBox.GenerateGUIControlCreation: string;
var
  i: integer;
  strStyle, parentName, strAlignment: string;
  strColorStr: string;
begin
  Result := '';
    if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);
  strStyle := GetStdStyleString(self.Wx_GeneralStyle);//GetListBoxSelectorStyle(Wx_ListboxSubStyle);

  if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle;
{  if GetListBoxSpecificStyle(self.Wx_GeneralStyle, Wx_ListboxStyle) <> '' then
    strStyle := strStyle + ' | ' + GetListBoxSpecificStyle(self.Wx_GeneralStyle, Wx_ListboxStyle);

  if trim(Wx_ProxyValidatorString.strValidatorValue) <> '' then
    if trim(strStyle) <> '' then
      strStyle := strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue
    else
      strStyle := ', 0, ' + Wx_ProxyValidatorString.strValidatorValue;
}
  if (XRCGEN) then
 begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);   
 end
 else
 begin
  Result := Format('wxArrayString arrayStringFor_%s;', [self.Name]);
  Result := GetCommentString(self.FWx_Comments.Text) + Result + #13 + 
  Format('%s = new %s(%s, %s, %s, %s%s);',
    [self.Name, self.Wx_Class, parentName, GetWxIDString(self.Wx_IDName, self.Wx_IDValue), 
    GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
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
    Result := Result + #13 + Format('%s->SetForegroundColour(%s);', [self.Name, strColorStr]);

  strColorStr := trim(GetwxColorFromString(InvisibleBGColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetBackgroundColour(%s);', [self.Name, strColorStr]);


  strColorStr := GetWxFontDeclaration(self.Font);
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetFont(%s);', [self.Name, strColorStr]);

  if Self.Wx_RichTextCtrl <> '' then
    Result := Result + #13 + Format('%s->SetRichTextCtrl(%s);', [self.Name, Self.Wx_RichTextCtrl]);

  if Self.Wx_StyleSheet <> '' then
    Result := Result + #13 + Format('%s->SetStyleSheet(%s);', [self.Name, Self.Wx_StyleSheet]);


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

end;

function TwxRichTextStyleListBox.GenerateGUIControlDeclaration: string;
  { Internal declarations for method }

  { var }
  { . . . }
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TwxRichTextStyleListBox.GenerateHeaderInclude: string;
  { Internal declarations for method }

  { var }
  { . . . }
begin
  Result := '';
  Result := '#include <wx/richtext/richtextstyles.h>';

end;

function TwxRichTextStyleListBox.GenerateImageInclude: string;
  { Internal declarations for method }

  { var }
  { . . . }
begin

end;

function TwxRichTextStyleListBox.GetEventList: TStringList;
  { Internal declarations for method }

  { var }
  { . . . }
begin
  Result := FWx_EventList;
end;

function TwxRichTextStyleListBox.GetIDName: string;
  { Internal declarations for method }

  { var }
  { . . . }
begin
  Result := wx_IDName;
end;

function TwxRichTextStyleListBox.GetIDValue: longint;
  { Internal declarations for method }

  { var }
  { . . . }
begin
  Result := wx_IDValue;
end;

function TwxRichTextStyleListBox.GetParameterFromEventName(EventName: string): string;
  { Internal declarations for method }

  { var }
  { . . . }
begin
   if EventName = 'EVT_LEFT_DOWN' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

   if EventName = 'EVT_LEFT_DCLICK' then
  begin
    Result := 'wxMouseEvent& event';
    exit;
  end;

   if EventName = 'EVT_IDLE' then
  begin
    Result := 'wxIdleEvent& event';
    exit;
  end;

  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TwxRichTextStyleListBox.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TwxRichTextStyleListBox.GetStretchFactor: integer;
begin
   Result := FWx_StretchFactor;
end;

function TwxRichTextStyleListBox.GetTypeFromEventName(EventName: string): string;
begin
   Result := 'void';
end;

function TwxRichTextStyleListBox.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TwxRichTextStyleListBox.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TwxRichTextStyleListBox.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TwxRichTextStyleListBox.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TwxRichTextStyleListBox.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxRichTextStyleListBox';
  Result := wx_Class;
end;

procedure TwxRichTextStyleListBox.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TwxRichTextStyleListBox.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TwxRichTextStyleListBox.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TwxRichTextStyleListBox.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TwxRichTextStyleListBox.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TwxRichTextStyleListBox.SetWxClassName(wxClassName: string);
begin
  Wx_Class := wxClassName;
end;

function TwxRichTextStyleListBox.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TwxRichTextStyleListBox.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TwxRichTextStyleListBox.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TwxRichTextStyleListBox.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TwxRichTextStyleListBox.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TwxRichTextStyleListBox.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TwxRichTextStyleListBox.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TwxRichTextStyleListBox.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

{
function TwxRichTextStyleListBox.GetListBoxSelectorStyle(Wx_ListboxSubStyle: TWxLBxStyleSubItem)
: string;
begin
  Result := '';
  if Wx_ListboxSubStyle = wxLB_SINGLE then
  begin
    Result := 'wxLB_SINGLE';
    exit;
  end;
  if Wx_ListboxSubStyle = wxLB_MULTIPLE then
  begin
    Result := 'wxLB_MULTIPLE';
    exit;
  end;
  if Wx_ListboxSubStyle = wxLB_EXTENDED then
  begin
    Result := 'wxLB_EXTENDED';
    exit;
  end;
end;
}

function TwxRichTextStyleListBox.GetValidatorString:TWxValidatorString;
begin
  Result := FWx_ProxyValidatorString;
  Result.FstrValidatorValue := Wx_Validator;
end;

procedure TwxRichTextStyleListBox.SetValidatorString(Value:TWxValidatorString);
begin
  FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
  Wx_Validator := Value.FstrValidatorValue;
end;

function TwxRichTextStyleListBox.GetValidator:String;
begin
  Result := Wx_Validator;
end;

procedure TwxRichTextStyleListBox.SetValidator(value:String);
begin
  Wx_Validator := value;
end;

end.
