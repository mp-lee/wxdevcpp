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

unit WxCustomButton;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxAuiToolBar, WxSizerPanel, Buttons, WxAuiNotebookPage,
  UValidator;

type

  TWxCustomButton = class(TBitBtn, IWxComponentInterface,IWxImageContainerInterface,
     IWxValidatorInterface)
  private
    FEVT_BUTTON: string;
    FEVT_TOGGLEBUTTON: string;
    FEVT_UPDATE_UI: string;
    FWx_BKColor: TColor;
    FWx_Border: integer;
    FWx_ButtonStyle: TWxCBtnStyleSubItem;
    FWx_ButtonPosStyle: TWxCBtnPosStyleSubItem;
    FWx_ButtonDwgStyle: TWxCBtnDwgStyleSubSet;
    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_Default: boolean;
    FWx_Enabled: boolean;
    FWx_EventList: TStringList;
    FWx_FGColor: TColor;
    FWx_GeneralStyle: TWxStdStyleSet;
    FWx_HelpText: string;
    FWx_Hidden: boolean;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;
    FWx_IDName: string;
    FWx_IDValue: longint;
    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;
    FWx_StretchFactor: integer;
    FWx_ToolTip: string;
    FWx_Bitmap: TPicture;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Validator: string;
    FWx_ProxyValidatorString : TWxValidatorString;
    FWx_Comments: TStrings;

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

    { Private methods of TWxCustomButton }

    procedure AutoInitialize;
    procedure AutoDestroy;
    procedure SetWx_EventList(Value: TStringList);

    function GetBitmapCount:Integer;
    function GetBitmap(Idx:Integer;var bmp:TBitmap; var PropertyName:string):boolean;
    function GetPropertyName(Idx:Integer):String;
  protected
    { Protected fields of TWxButton }

    { Protected methods of TWxButton }

  public
    { Public fields and properties of TWxButton }
    defaultBGColor: TColor;
    defaultFGColor: TColor;

    { Public methods of TWxCustomButton }
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

    function GetValidator:String;
    procedure SetValidator(value:String);
    function GetValidatorString:TWxValidatorString;
    procedure SetValidatorString(Value:TWxValidatorString);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
    procedure SetButtonBitmap(Value: TPicture);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    function GetCustomButtonStyle(Wx_ButtonStyle: TWxCBtnStyleSubItem): string;
    function GetCustomButtonDwgStyle(Wx_ButtonDwgStyle: TWxCBtnDwgStyleSubSet): string;
    function GetCustomButtonPosStyle(Wx_ButtonPosStyle: TWxCBtnPosStyleSubItem): string;
    function GetCustomButtonSpecificStyle: string;

  published
    property Color;
    property OnClick;
//    property OnToggleClick;
    property OnDblClick;
    property OnDragDrop;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property EVT_BUTTON: string Read FEVT_BUTTON Write FEVT_BUTTON;
    property EVT_TOGGLEBUTTON: string Read FEVT_TOGGLEBUTTON Write FEVT_TOGGLEBUTTON;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BKColor: TColor Read FWx_BKColor Write FWx_BKColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Default: boolean Read FWx_Default Write FWx_Default;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_EventList: TStringList Read FWx_EventList Write SetWx_EventList;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_BITMAP: TPicture Read FWx_BITMAP Write SetButtonBitmap;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_ProxyValidatorString : TWxValidatorString Read GetValidatorString Write SetValidatorString;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;
    
    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string  Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

    property Wx_ButtonStyle: TWxCBtnStyleSubItem Read FWx_ButtonStyle Write FWx_ButtonStyle;
    property Wx_ButtonPosStyle: TWxCBtnPosStyleSubItem Read FWx_ButtonPosStyle Write FWx_ButtonPosStyle;
    property Wx_ButtonDwgStyle: TWxCBtnDwgStyleSubSet Read FWx_ButtonDwgStyle Write FWx_ButtonDwgStyle;

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
  RegisterComponents('wxWidgets', [TWxCustomButton]);
end;

procedure TWxCustomButton.AutoInitialize;
begin
  FWx_PropertyList       := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxCustomButton';
  FWx_Enabled            := True;
  FWx_EventList          := TStringList.Create;
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_ButtonDwgStyle     := [];
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;
  FWx_Bitmap             := TPicture.Create;
  FWx_ProxyValidatorString := TwxValidatorString.Create(self);
  FWx_Comments           := TStringList.Create;

end; { of AutoInitialize }


procedure TWxCustomButton.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Bitmap.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyValidatorString.Destroy;

end; { of AutoDestroy }


procedure TWxCustomButton.SetWx_EventList(Value: TStringList);
begin
  FWx_EventList.Assign(Value);
end;

constructor TWxCustomButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoInitialize;

  PopulateGenericProperties(FWx_PropertyList);
  PopulateAuiGenericProperties(FWx_PropertyList);

  FWx_PropertyList.add('Caption:Label');
  FWx_PropertyList.add('Wx_Bitmap:Bitmap');
  FWx_PropertyList.add('Wx_ButtonStyle:Button Type');
  FWx_PropertyList.add('wxCUSTBUT_NOTOGGLE:wxCUSTBUT_NOTOGGLE');
  FWx_PropertyList.add('wxCUSTBUT_BUTTON:wxCUSTBUT_BUTTON');
  FWx_PropertyList.add('wxCUSTBUT_TOGGLE:wxCUSTBUT_TOGGLE');
  FWx_PropertyList.add('wxCUSTBUT_BUT_DCLICK_TOG:wxCUSTBUT_BUT_DCLICK_TOG');
  FWx_PropertyList.add('wxCUSTBUT_TOG_DCLICK_BUT:wxCUSTBUT_TOG_DCLICK_BUT');
  FWx_PropertyList.add('Wx_ButtonPosStyle:Label Position');
  FWx_PropertyList.add('wxCUSTBUT_LEFT:wxCUSTBUT_LEFT');
  FWx_PropertyList.add('wxCUSTBUT_RIGHT:wxCUSTBUT_RIGHT');
  FWx_PropertyList.add('wxCUSTBUT_TOP:wxCUSTBUT_TOP');
  FWx_PropertyList.add('wxCUSTBUT_BOTTOM:wxCUSTBUT_BOTTOM');
  FWx_PropertyList.add('Wx_ButtonDwgStyle:Button Drawing Style');
  FWx_PropertyList.Add('wxCUSTBUT_FLAT:wxCUSTBUT_FLAT');

  FWx_EventList.add('EVT_BUTTON:OnClick');
  FWx_EventList.add('EVT_TOGGLEBUTTON:OnToggleClick ');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

  FWx_ButtonStyle :=  wxCUSTBUT_BUTTON;
  FWx_ButtonPosStyle := wxCUSTBUT_RIGHT;
  FWx_ButtonDwgStyle := [];

end;

destructor TWxCustomButton.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;


function TWxCustomButton.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TWxCustomButton.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d', [Wx_IDName, Wx_IDValue]);
end;

function TWxCustomButton.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

  if (XRCGEN) then
 begin
  if trim(EVT_BUTTON) <> '' then
    Result := Format('EVT_BUTTON(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_BUTTON]) + '';

  if not(Wx_ButtonStyle = wxCUSTBUT_BUTTON) then
  begin
  if trim(EVT_TOGGLEBUTTON) <> '' then
    Result := Result + #13 + Format('EVT_TOGGLEBUTTON(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_TOGGLEBUTTON]) + '';
  end;

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
 end
 else
 begin
  if trim(EVT_BUTTON) <> '' then
    Result := Format('EVT_BUTTON(%s,%s::%s)', [WX_IDName, CurrClassName,
      EVT_BUTTON]) + '';

  if not(Wx_ButtonStyle = wxCUSTBUT_BUTTON) then
  begin
  if trim(EVT_TOGGLEBUTTON) <> '' then
    Result := Result + #13 + Format('EVT_TOGGLEBUTTON(%s,%s::%s)', [WX_IDName, CurrClassName,
      EVT_TOGGLEBUTTON]) + '';
  end;

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
 end;

end;

function TWxCustomButton.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  stylestring: string;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <label>%s</label>', [XML_Label(self.Caption)]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

    if not(UseDefaultSize)then
      Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    if not(UseDefaultPos) then
      Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

  stylestring := GetCustomButtonSpecificStyle();
  Result.Add(IndentString + Format('  <style>%s</style>', [stylestring]));

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxCustomButton.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle:    string;
  parentName, strAlignment: string;
begin
  Result   := '';
  strStyle := GetCustomButtonSpecificStyle();

  if trim(Wx_ProxyValidatorString.strValidatorValue) <> '' then
  begin
    strStyle := ', ' + strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue;

    strStyle := strStyle + ', ' + GetCppString(Name);

  end
  else
    strStyle := ', ' + strStyle + ', wxDefaultValidator, ' + GetCppString(Name);

    if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);

  Result := GetCommentString(self.FWx_Comments.Text) +
    'wxBitmap ' + self.Name + '_BITMAP' + ' (wxNullBitmap);';

  if assigned(Wx_Bitmap) then
    if Wx_Bitmap.Bitmap.Handle <> 0 then
      Result := 'wxBitmap ' + self.Name + '_BITMAP' + ' (' + GetDesignerFormName(self)+'_'+self.Name + '_XPM' + ');';

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
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue), GetCppString(self.Text),
    self.Name + '_BITMAP', GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
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

    Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
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

function TWxCustomButton.GenerateGUIControlDeclaration: string;
begin
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxCustomButton.GenerateHeaderInclude: string;
begin
  Result := '';
  if not(Wx_ButtonStyle = wxCUSTBUT_BUTTON) then
  begin
        Result := '#include <wx/tglbtn.h>';
        Result := Result + #13;
  end;

  Result := Result + '#include <wx\things\toggle.h>';
end;

function TWxCustomButton.GenerateImageInclude: string;
begin
  if assigned(Wx_Bitmap) then
    if Wx_Bitmap.Bitmap.Handle <> 0 then
      Result := '#include "Images/'+ GetDesignerFormName(self)+'_'+ self.Name + '_XPM.xpm"';
end;

function TWxCustomButton.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxCustomButton.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxCustomButton.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxCustomButton.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_BUTTON' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_TOGGLEBUTTON' then
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

function TWxCustomButton.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxCustomButton.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxCustomButton.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxCustomButton.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxCustomButton.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxCustomButton.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxCustomButton.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxCustomButton.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxCustomButton';
  Result := wx_Class;
end;

procedure TWxCustomButton.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxCustomButton.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxCustomButton.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDValue;
end;

procedure TWxCustomButton.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxCustomButton.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxCustomButton.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxCustomButton.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxCustomButton.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxCustomButton.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxCustomButton.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxCustomButton.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxCustomButton.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxCustomButton.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

procedure TWxCustomButton.SetButtonBitmap(Value: TPicture);
begin
  if not assigned(Value) then
    exit;
  self.Glyph.Assign(Value.Bitmap);
end;

function TWxCustomButton.GetBitmapCount:Integer;
begin
  Result:=1;
end;

function TWxCustomButton.GetBitmap(Idx:Integer;var bmp:TBitmap; var PropertyName:string):boolean;
begin
  bmp:= Wx_Bitmap.Bitmap;
  PropertyName:=Name;
  Result:=true;
end;

function TWxCustomButton.GetPropertyName(Idx:Integer):String;
begin
  Result:=Name;
end;


function TWxCustomButton.GetValidatorString:TWxValidatorString;
begin
  Result := FWx_ProxyValidatorString;
  Result.FstrValidatorValue := Wx_Validator;
end;

procedure TWxCustomButton.SetValidatorString(Value:TWxValidatorString);
begin
  FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
  Wx_Validator := Value.FstrValidatorValue;
end;

function TWxCustomButton.GetValidator:String;
begin
  Result := Wx_Validator;
end;

procedure TWxCustomButton.SetValidator(value:String);
begin
  Wx_Validator := value;
end;


function TWxCustomButton.GetCustomButtonStyle(Wx_ButtonStyle: TWxCBtnStyleSubItem): string;
begin
  Result := '';
  if Wx_ButtonStyle = wxCUSTBUT_NOTOGGLE then
  begin
    Result := 'wxCUSTBUT_NOTOGGLE';
    exit;
  end;
  if Wx_ButtonStyle = wxCUSTBUT_BUTTON then
  begin
    Result := 'wxCUSTBUT_BUTTON';
    exit;
  end;
  if Wx_ButtonStyle = wxCUSTBUT_TOGGLE then
  begin
    Result := 'wxCUSTBUT_TOGGLE';
    exit;
  end;
  if Wx_ButtonStyle = wxCUSTBUT_BUT_DCLICK_TOG then
  begin
    Result := 'wxCUSTBUT_BUT_DCLICK_TOG';
    exit;
  end;
  if Wx_ButtonStyle = wxCUSTBUT_TOG_DCLICK_BUT then
  begin
    Result := 'wxCUSTBUT_TOG_DCLICK_BUT';
    exit;
  end;
end;

function TWxCustomButton.GetCustomButtonDwgStyle(Wx_ButtonDwgStyle: TWxCBtnDwgStyleSubSet): string;
begin
  Result := '';

  if wxCUSTBUT_FLAT in Wx_ButtonDwgStyle then
      Result := 'wxCUSTBUT_FLAT';

end;

function TWxCustomButton.GetCustomButtonPosStyle(Wx_ButtonPosStyle: TWxCBtnPosStyleSubItem): string;
begin
  Result := '';
  if Wx_ButtonPosStyle = wxCUSTBUT_LEFT then
  begin
    Result := 'wxCUSTBUT_LEFT';
    Self.Layout := blGlyphRight;
    exit;
  end;
  if Wx_ButtonPosStyle = wxCUSTBUT_RIGHT then
  begin
    Result := 'wxCUSTBUT_RIGHT';
    Self.Layout := blGlyphLeft;
    exit;
  end;
  if Wx_ButtonPosStyle = wxCUSTBUT_TOP then
  begin
    Result := 'wxCUSTBUT_TOP';
    Self.Layout := blGlyphBottom;
    exit;
  end;
  if Wx_ButtonPosStyle = wxCUSTBUT_BOTTOM then
  begin
    Result := 'wxCUSTBUT_BOTTOM';
    Self.Layout := blGlyphTop;
    exit;
  end;

end;

function TWxCustomButton.GetCustomButtonSpecificStyle(): string;
var
  strA: string;
begin
  Result := GetCustomButtonStyle(self.Wx_ButtonStyle) + ' | ' + GetCustomButtonPosStyle(self.Wx_ButtonPosStyle);
  strA := trim(GetCustomButtonDwgStyle(self.Wx_ButtonDwgStyle));
  if strA <> '' then
      Result := Result + ' | ' + strA;

end;



end.