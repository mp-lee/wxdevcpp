 { ****************************************************************** }
 {                                                                    }
{ $Id: wxCalendarCtrl.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

unit wxCalendarCtrl;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ExtCtrls, WxUtils, wxCalendarBase, WxSizerPanel;

type
  TWxCalendarCtrl = class(TrmCustomCalendar, IWxComponentInterface,IWxControlPanelInterface)
  private
    { Private fields of TWxCalendarCtrl }
    {Property Listing}
    FWx_BKColor: TColor;
    FWx_Border: integer;
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
    FWx_IDValue: longint;
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
    FWx_Calctrlstyle: TWxcalctrlStyleSet;
    FWx_SelectedDate:TDateTime;
    {Event Lisiting}
    FEVT_UPDATE_UI: string;
    FEVT_CALENDAR_SEL_CHANGED: string;
    FEVT_CALENDAR_DAY: string;
    FEVT_CALENDAR_MONTH: string;
    FEVT_CALENDAR_YEAR: string;
    FEVT_CALENDAR_WEEKDAY_CLICKED: string;

    { Private methods of TWxCalendarCtrl }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected
    { Protected fields of TWxCalendarCtrl }

    { Protected methods of TWxCalendarCtrl }


  public
    { Public fields and properties of TWxCalendarCtrl }
    defaultBGColor: TColor;
    defaultFGColor: TColor;

    { Public methods of TWxCalendarCtrl }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
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
    function GenerateLastCreationCode: string;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    function GetSelectedDate:TDateTime;
    procedure SetSelectedDate(Value:TDateTime);

  published
    { Published properties of TWxCalendarCtrl }
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property EVT_CALENDAR_SEL_CHANGED: string Read FEVT_CALENDAR_SEL_CHANGED Write FEVT_CALENDAR_SEL_CHANGED;
    property EVT_CALENDAR_DAY: string Read FEVT_CALENDAR_DAY Write FEVT_CALENDAR_DAY;
    property EVT_CALENDAR_MONTH: string Read FEVT_CALENDAR_MONTH Write FEVT_CALENDAR_MONTH;
    property EVT_CALENDAR_YEAR: string Read FEVT_CALENDAR_YEAR Write FEVT_CALENDAR_YEAR;
    property EVT_CALENDAR_WEEKDAY_CLICKED: string Read FEVT_CALENDAR_WEEKDAY_CLICKED Write FEVT_CALENDAR_WEEKDAY_CLICKED;

    property WxCalCtrlstyle: TWxcalctrlStyleSet Read FWx_Calctrlstyle Write FWx_Calctrlstyle;
    property WxSelectedDate: TDateTime Read GetSelectedDate Write SetSelectedDate;

    property Wx_BKColor: TColor Read FWx_BKColor Write FWx_BKColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Default: boolean Read FWx_Default Write FWx_Default;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxCalendarCtrl]);
end;


procedure TWxCalendarCtrl.AutoInitialize;
begin
  Caption                := '';
  FWx_PropertyList       := TStringList.Create;
  FWx_EventList          := TStringList.Create;
  FWx_Comments           := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxCalendarCtrl';
  FWx_Enabled            := True;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;
  ShowGridLines          := false;
  ShowWeekends           := false;
  FWx_SelectedDate       := Now;
  SelectedDate           := FWx_SelectedDate;
  FWx_Calctrlstyle       := [wxCAL_SUNDAY_FIRST , wxCAL_SHOW_HOLIDAYS , wxCAL_NO_MONTH_CHANGE , wxCAL_SHOW_SURROUNDING_WEEKS , wxCAL_SEQUENTIAL_MONTH_SELECTION];
  //CalendarColors.


end; { of AutoInitialize }


procedure TWxCalendarCtrl.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

constructor TWxCalendarCtrl.Create(AOwner: TComponent);
begin
  { Call the Create method of the container's parent class       }
  inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables          }
  { (including subcomponent variables) and properties;           }
  { also, it creates objects for properties of standard          }
  { Delphi object types (e.g., TFont, TTimer, TPicture)          }
  { and for any variables marked as objects.                     }
  { AutoInitialize method is generated by Component Create.      }
  AutoInitialize;

  { Code to perform other tasks when the container is created    }
  PopulateGenericProperties(FWx_PropertyList);

  FWx_PropertyList.Add('WxSelectedDate:Selected Date');
  FWx_PropertyList.Add('WxCalCtrlstyle:Calendar Style');
  FWx_PropertyList.Add('wxCAL_SUNDAY_FIRST:wxCAL_SUNDAY_FIRST');
  FWx_PropertyList.Add('wxCAL_MONDAY_FIRST:wxCAL_MONDAY_FIRST');
  FWx_PropertyList.Add('wxCAL_SHOW_HOLIDAYS:wxCAL_SHOW_HOLIDAYS');
  FWx_PropertyList.Add('wxCAL_NO_YEAR_CHANGE:wxCAL_NO_YEAR_CHANGE');
  FWx_PropertyList.Add('wxCAL_NO_MONTH_CHANGE:wxCAL_NO_MONTH_CHANGE');
  FWx_PropertyList.Add('wxCAL_SHOW_SURROUNDING_WEEKS:wxCAL_SHOW_SURROUNDING_WEEKS');
  FWx_PropertyList.Add('wxCAL_SEQUENTIAL_MONTH_SELECTION:wxCAL_SEQUENTIAL_MONTH_SELECTION');

  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
  FWx_EventList.add('EVT_CALENDAR_SEL_CHANGED:OnSelChanged ');
  FWx_EventList.add('EVT_CALENDAR_DAY:OnDay ');
  FWx_EventList.add('EVT_CALENDAR_MONTH:OnMonth ');
  FWx_EventList.add('EVT_CALENDAR_YEAR:OnYear ');
  FWx_EventList.add('EVT_CALENDAR_WEEKDAY_CLICKED:OnWeekDayClicked');

end;

destructor TWxCalendarCtrl.Destroy;
begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
  AutoDestroy;

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
  inherited Destroy;
end;

procedure TWxCalendarCtrl.Paint;
begin
  self.Caption := '';
     { Make this component look like its parent component by calling
       its parent's Paint method. }
  inherited Paint;
end;


function TWxCalendarCtrl.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxCalendarCtrl.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxCalendarCtrl.GenerateEventTableEntries(CurrClassName: string): string;
begin

  Result := '';
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_CALENDAR_SEL_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_CALENDAR_SEL_CHANGED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_CALENDAR_SEL_CHANGED]) + '';

  if trim(EVT_CALENDAR_DAY) <> '' then
    Result := Result + #13 + Format('EVT_CALENDAR_DAY(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_CALENDAR_DAY]) + '';

  if trim(EVT_CALENDAR_MONTH) <> '' then
    Result := Result + #13 + Format('EVT_CALENDAR_MONTH(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_CALENDAR_MONTH]) + '';

  if trim(EVT_CALENDAR_YEAR) <> '' then
    Result := Result + #13 + Format('EVT_CALENDAR_YEAR(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_CALENDAR_YEAR]) + '';

  if trim(EVT_CALENDAR_WEEKDAY_CLICKED) <> '' then
    Result := Result + #13 + Format('EVT_CALENDAR_WEEKDAY_CLICKED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_CALENDAR_WEEKDAY_CLICKED]) + '';
end;

function TWxCalendarCtrl.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try

    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <label>%s</label>', [self.Caption]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetStdStyleString(self.Wx_GeneralStyle)]));

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxCalendarCtrl.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
  strDateString:String;
begin
  Result := '';

  //    if (self.Parent is TForm) or (self.Parent is TWxSizerPanel) then
  //       parentName:=GetWxWidgetParent(self)
  //    else
  //       parentName:=self.Parent.name;

  parentName := GetWxWidgetParent(self);
  strDateString := GetDateVariableExpansion(WxSelectedDate);
  strStyle := GetCalendarCtrlSpecificStyle(self.Wx_GeneralStyle,self.WxCalctrlstyle);
  if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle;


  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s,wxPoint(%d,%d), wxSize(%d,%d)%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),strDateString,
    self.Left, self.Top, self.Width, self.Height, strStyle]);

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

  if (self.Parent is TWxSizerPanel) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

end;

function TWxCalendarCtrl.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxCalendarCtrl.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/calctrl.h>';
end;

function TWxCalendarCtrl.GenerateImageInclude: string;
begin

end;

function TWxCalendarCtrl.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxCalendarCtrl.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxCalendarCtrl.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxCalendarCtrl.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;

  if EventName = 'EVT_CALENDAR_SEL_CHANGED' then
  begin
    Result := 'wxCalendarEvent& event';
    exit;
  end;

  if EventName = 'EVT_CALENDAR_DAY' then
  begin
    Result := 'wxCalendarEvent& event';
    exit;
  end;

  if EventName = 'EVT_CALENDAR_MONTH' then
  begin
    Result := 'wxCalendarEvent& event';
    exit;
  end;

  if EventName = 'EVT_CALENDAR_YEAR' then
  begin
    Result := 'wxCalendarEvent& event';
    exit;
  end;

  if EventName = 'EVT_CALENDAR_WEEKDAY_CLICKED' then
  begin
    Result := 'wxCalendarEvent& event';
    exit;
  end;
end;

function TWxCalendarCtrl.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxCalendarCtrl.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxCalendarCtrl.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxCalendarCtrl.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxCalendarCtrl.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxCalendarCtrl.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxCalendarCtrl.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxCalendarCtrl.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxCalendarCtrl';
  Result := wx_Class;
end;

procedure TWxCalendarCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxCalendarCtrl.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxCalendarCtrl.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxCalendarCtrl.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

function TWxCalendarCtrl.GetSelectedDate:TDateTime;
begin
  Result:=FWx_SelectedDate;
end;

procedure TWxCalendarCtrl.SetSelectedDate(Value:TDateTime);
begin
  SelectedDate:=Value;
  FWx_SelectedDate:=Value;
end;

procedure TWxCalendarCtrl.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxCalendarCtrl.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxCalendarCtrl.SetGenericColor(strVariableName,strValue: string);
begin

end;


function TWxCalendarCtrl.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxCalendarCtrl.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxCalendarCtrl.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxCalendarCtrl.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxCalendarCtrl.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxCalendarCtrl.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxCalendarCtrl.GenerateLastCreationCode: string;
begin
  Result := '';
end;


end. 
