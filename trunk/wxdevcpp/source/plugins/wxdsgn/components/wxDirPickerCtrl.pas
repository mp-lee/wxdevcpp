{ ****************************************************************** }
{                                                                    }
{ $Id$                                                            }
{                                                                    }                                                                                            
{                                                                    }
{   Copyright � 2008 by Malcolm Nealon                   }
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

unit wxDirPickerCtrl;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, Dialogs,
  Forms, Graphics, ComCtrls, ExtCtrls, StdCtrls, WxUtils, WxAuiToolBar, WxAuiNotebookPage, WxSizerPanel, Buttons, janButtonEdit;

type

  TWxDirPickerCtrl = class(TjanButtonEdit, IWxComponentInterface, IWxValidatorInterface)
  private
    FEVT_DIRPICKER_CHANGED: string;
    FEVT_UPDATE_UI: string;
    FWx_BKColor: TColor;
    FWx_Border: integer;
    FWx_DirPickStyles: TWxDirPickCtrlStyleSet;
    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_Default: boolean;
    FWx_Enabled: boolean;
    FWx_EventList: TStringList;
    FWx_FGColor: TColor;
    FWx_GeneralStyle: TWxStdStyleSet;
    FWx_HelpText: string;
    FWx_Hidden: boolean;
    FWx_IDName: string;
    FWx_IDValue: integer;
    FWx_Validator: string;
    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;
    FWx_StretchFactor: integer;
    FWx_ToolTip: string;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;
    FWx_ProxyValidatorString: TWxValidatorString;

    FInvisibleColorString: string;

    FWx_Path: string;
    FWx_Message: string;

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

    { Private methods of TWxDirPickerCtrl }
    procedure AutoInitialize;
    procedure AutoDestroy;

    function GetPropertyName(Idx: Integer): string;
  protected

  public
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxDirPickerCtrl }
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

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    function GetValidator: string;
    procedure SetValidator(value: string);
    function GetValidatorString: TWxValidatorString;
    procedure SetValidatorString(Value: TWxValidatorString);

    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName: string): string;
    procedure SetGenericColor(strVariableName, strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

    function GetDirPickerCtrlStyleString(stdStyle: TWxDirPickCtrlStyleSet): string;
    function GetDirPickerCtrlSpecificStyle(stdstyle: TWxStdStyleSet; dlgstyle: TWxDirPickCtrlStyleSet): string;

  published
    property Color;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property EVT_DIRPICKER_CHANGED: string read FEVT_DIRPICKER_CHANGED write FEVT_DIRPICKER_CHANGED;
    property EVT_UPDATE_UI: string read FEVT_UPDATE_UI write FEVT_UPDATE_UI;
    property Wx_BKColor: TColor read FWx_BKColor write FWx_BKColor;
    property Wx_DirPickStyles: TWxDirPickCtrlStyleSet read FWx_DirPickStyles write FWx_DirPickStyles;
    property Wx_Class: string read FWx_Class write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      read FWx_ControlOrientation write FWx_ControlOrientation;
    property Wx_Default: boolean read FWx_Default write FWx_Default;
    property Wx_Enabled: boolean read FWx_Enabled write FWx_Enabled default True;
    property Wx_EventList: TStringList read FWx_EventList write FWx_EventList;
    property Wx_FGColor: TColor read FWx_FGColor write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      read FWx_GeneralStyle write FWx_GeneralStyle;
    property Wx_HelpText: string read FWx_HelpText write FWx_HelpText;
    property Wx_Hidden: boolean read FWx_Hidden write FWx_Hidden;
    property Wx_IDName: string read FWx_IDName write FWx_IDName;
    property Wx_IDValue: integer read FWx_IDValue write FWx_IDValue default -1;
    property Wx_Validator: string read FWx_Validator write FWx_Validator;
    property Wx_ProxyValidatorString: TWxValidatorString read GetValidatorString write SetValidatorString;
    property Wx_ToolTip: string read FWx_ToolTip write FWx_ToolTip;
    property Wx_Comments: TStrings read FWx_Comments write FWx_Comments;

    property Wx_Border: integer read GetBorderWidth write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment read GetBorderAlignment write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet read FWx_Alignment write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer read GetStretchFactor write SetStretchFactor default 0;

    property InvisibleBGColorString: string read FInvisibleBGColorString write FInvisibleBGColorString;
    property InvisibleFGColorString: string read FInvisibleFGColorString write FInvisibleFGColorString;
    property Wx_ProxyBGColorString: TWxColorString read FWx_ProxyBGColorString write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString read FWx_ProxyFGColorString write FWx_ProxyFGColorString;
    property InvisibleColorString: string read FInvisibleColorString write FInvisibleColorString;
    property Wx_Path: string read FWx_Path write FWx_Path;
    property Wx_Message: string read FWx_Message write FWx_Message;

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
  RegisterComponents('wxWidgets', [TWxDirPickerCtrl]);
end;

procedure TWxDirPickerCtrl.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Border := 5;
  FWx_Class := 'wxDirPickerCtrl';
  FWx_Enabled := True;
  FWx_EventList := TStringList.Create;
  FWx_BorderAlignment := [wxAll];
  FWx_Alignment := [wxALIGN_CENTER];
  FWx_IDValue := -1;
  FWx_StretchFactor := 0;
  FWx_Comments := TStringList.Create;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  FWx_ProxyValidatorString := TwxValidatorString.Create(self);
  defaultBGColor := self.color;
  defaultFGColor := self.font.color;
  FWx_DirPickStyles := [wxDIRP_DEFAULT_STYLE];
      Self.ShowEdit := True;
    FWx_Path := '';
    FWx_Message := 'Select a folder';
  Self.Width := 185;

end; { of AutoInitialize }

procedure TWxDirPickerCtrl.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyValidatorString.Destroy;
end; { of AutoDestroy }

constructor TWxDirPickerCtrl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoInitialize;

  PopulateGenericProperties(FWx_PropertyList);
  PopulateAuiGenericProperties(FWx_PropertyList);

  FWx_PropertyList.add('Wx_Path:Path');
  FWx_PropertyList.add('Wx_Message:Message');
  FWx_PropertyList.add('Wx_DirPickStyles:DirPickerStyles');
  FWx_PropertyList.add('wxDIRP_DEFAULT_STYLE:wxDIRP_DEFAULT_STYLE');
  FWx_PropertyList.add('wxDIRP_USE_TEXTCTRL:wxDIRP_USE_TEXTCTRL');
  FWx_PropertyList.add('wxDIRP_DIR_MUST_EXIST:wxDIRP_DIR_MUST_EXIST');
  FWx_PropertyList.add('wxDIRP_CHANGE_DIR:wxDIRP_CHANGE_DIR');

  FWx_EventList.add('EVT_DIRPICKER_CHANGED:OnDirChanged');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxDirPickerCtrl.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

function TWxDirPickerCtrl.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TWxDirPickerCtrl.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d', [Wx_IDName, Wx_IDValue]);
end;

function TWxDirPickerCtrl.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

  if (XRCGEN) then
  begin
    if trim(EVT_DIRPICKER_CHANGED) <> '' then
      Result := Format('EVT_DIRPICKER_CHANGED(XRCID(%s("%s")),%s::%s)',
        [StringFormat, self.Name, CurrClassName, EVT_DIRPICKER_CHANGED]) + '';

    if trim(EVT_UPDATE_UI) <> '' then
      Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
        [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
  end
  else
  begin
    if trim(EVT_DIRPICKER_CHANGED) <> '' then
      Result := Format('EVT_DIRPICKER_CHANGED(%s,%s::%s)',
        [WX_IDName, CurrClassName, EVT_DIRPICKER_CHANGED]) + '';

    if trim(EVT_UPDATE_UI) <> '' then
      Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
        [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
  end;

end;

function TWxDirPickerCtrl.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  i: integer;
  wxcompInterface: IWxComponentInterface;
  tempstring: TStringList;
  stylstr: string;
begin

  Result := TStringList.Create;

  try

    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

    if not (UseDefaultSize) then
      Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    if not (UseDefaultPos) then
      Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetDirPickerCtrlSpecificStyle(self.Wx_GeneralStyle, Wx_DirPickStyles)]));
    Result.Add(IndentString + '</object>');

  except

    Result.Free;
    raise;

  end;

end;

function TWxDirPickerCtrl.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment, strAlign: string;
begin
  Result := '';

  strStyle := GetDirPickerCtrlSpecificStyle(self.Wx_GeneralStyle, Wx_DirPickStyles);
  if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);

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
  begin //generate xrc loading code
    Result := GetCommentString(self.FWx_Comments.Text) +
      Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
      [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
  end
  else
  begin
    Result := GetCommentString(self.FWx_Comments.Text) +
      Format('%s = new %s(%s, %s, %s, %s, %s, %s%s);',
      [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
        self.Wx_IDValue), GetCppString(self.Wx_Path), GetCppString(self.Wx_Message), GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height),
         strStyle]);
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

      if (self.Parent is TWxAuiToolBar) then
        Result := Result + #13 + Format('%s->AddControl(%s);',
          [self.Parent.Name, self.Name]);
    end;
  end;

end;

function TWxDirPickerCtrl.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxDirPickerCtrl.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/filepicker.h>';
end;

function TWxDirPickerCtrl.GenerateImageInclude: string;
begin

end;

function TWxDirPickerCtrl.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxDirPickerCtrl.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxDirPickerCtrl.GetIDValue: integer;
begin
  Result := wx_IDValue;
end;

function TWxDirPickerCtrl.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_DIRPICKER_CHANGED' then
  begin
    Result := 'wxDirPickerEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxDirPickerCtrl.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxDirPickerCtrl.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxDirPickerCtrl.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxDirPickerCtrl.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxDirPickerCtrl.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxDirPickerCtrl.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxDirPickerCtrl.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxDirPickerCtrl.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'WxDirPickerCtrl';
  Result := wx_Class;
end;

procedure TWxDirPickerCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxDirPickerCtrl.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxDirPickerCtrl.SetIDValue(IDValue: integer);
begin
  Wx_IDValue := IDValue;
end;

procedure TWxDirPickerCtrl.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxDirPickerCtrl.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxDirPickerCtrl.GetGenericColor(strVariableName: string): string;
begin

  Result := FInvisibleColorString;

end;

procedure TWxDirPickerCtrl.SetGenericColor(strVariableName, strValue: string);
begin
  FInvisibleColorString := strValue;
end;

function TWxDirPickerCtrl.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxDirPickerCtrl.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxDirPickerCtrl.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxDirPickerCtrl.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxDirPickerCtrl.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxDirPickerCtrl.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxDirPickerCtrl.GetValidatorString: TWxValidatorString;
begin
  Result := FWx_ProxyValidatorString;
  Result.FstrValidatorValue := Wx_Validator;
end;

procedure TWxDirPickerCtrl.SetValidatorString(Value: TWxValidatorString);
begin
  FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
  Wx_Validator := Value.FstrValidatorValue;
end;

function TWxDirPickerCtrl.GetValidator: string;
begin
  Result := Wx_Validator;
end;

procedure TWxDirPickerCtrl.SetValidator(value: string);
begin
  Wx_Validator := value;
end;

function TWxDirPickerCtrl.GetPropertyName(Idx: Integer): string;
begin
  Result := Name;
end;

function TWxDirPickerCtrl.GetDirPickerCtrlStyleString(stdStyle: TWxDirPickCtrlStyleSet): string;
var
  I: integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxDIRP_DEFAULT_STYLE in stdStyle then
      strLst.add('wxDIRP_DEFAULT_STYLE');

    if wxDIRP_USE_TEXTCTRL in stdStyle then
    begin
      strLst.add('wxDIRP_USE_TEXTCTRL');
      Self.ShowEdit := True;
    end
    else
    begin
      Self.ShowEdit := False;
    end;

    if wxDIRP_DIR_MUST_EXIST in stdStyle then
      strLst.add('wxDIRP_DIR_MUST_EXIST');

    if wxDIRP_CHANGE_DIR in stdStyle then
      strLst.add('wxDIRP_CHANGE_DIR');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i] // for
          ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;
end;

function TWxDirPickerCtrl.GetDirPickerCtrlSpecificStyle(stdstyle: TWxStdStyleSet; dlgstyle: TWxDirPickCtrlStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA := trim(GetDirPickerCtrlStyleString(dlgstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

end.

