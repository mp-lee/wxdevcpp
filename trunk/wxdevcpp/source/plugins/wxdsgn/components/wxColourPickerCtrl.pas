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

unit wxColourPickerCtrl;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, Dialogs,
  Forms, Graphics, ComCtrls, ExtCtrls, StdCtrls, WxUtils, WxSizerPanel, Buttons, janButtonEdit {SsButtonEd} {ColourPickerControl};

type

  TWxColourPickerCtrl = class(TjanButtonEdit {TButtonEdit} {TColourPickerControl}, IWxComponentInterface, IWxValidatorInterface)
  private
    FEVT_COLOURPICKER_CHANGED: string;
    FEVT_UPDATE_UI: string;
    FWx_BKColor: TColor;
    FWx_Border: integer;
    FWx_ClrPickStyles: TWxClrPickCtrlStyleSet;
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
    FWx_ProxyValidatorString : TWxValidatorString;



    { Private methods of TWxColourPickerCtrl }
    procedure AutoInitialize;
    procedure AutoDestroy;


  protected

  public
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxColourPickerCtrl }
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

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    function GetValidator:String;
    procedure SetValidator(value:String);
    function GetValidatorString:TWxValidatorString;
    procedure SetValidatorString(Value:TWxValidatorString);

    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

function GetColourPickerCtrlStyleString(stdStyle: TWxClrPickCtrlStyleSet): string;
function GetColourPickerCtrlSpecificStyle(stdstyle: TWxStdStyleSet; dlgstyle: TWxClrPickCtrlStyleSet): string;
//function GetWXColorFromString(strColorValue: string): string;

  published
    property Color;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property EVT_COLOURPICKER_CHANGED: string read FEVT_COLOURPICKER_CHANGED write FEVT_COLOURPICKER_CHANGED;
    property EVT_UPDATE_UI: string read FEVT_UPDATE_UI write FEVT_UPDATE_UI;
    property Wx_BKColor: TColor Read FWx_BKColor Write FWx_BKColor;
    property Wx_ClrPickStyles: TWxClrPickCtrlStyleSet Read FWx_ClrPickStyles Write FWx_ClrPickStyles;
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
    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_ProxyValidatorString : TWxValidatorString Read GetValidatorString Write SetValidatorString;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;
    
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string  Read FInvisibleFGColorString Write FInvisibleFGColorString;
    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleColorString: string Read FInvisibleColorString Write FInvisibleColorString;
    property Wx_Color: TWxColorString Read FWx_Color Write FWx_Color;



  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxColourPickerCtrl]);
end;

procedure TWxColourPickerCtrl.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class := 'wxColourPickerCtrl';
  FWx_Enabled            := True;
  FWx_EventList := TStringList.Create;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue := -1;
  FWx_StretchFactor := 0;
  FWx_Comments           := TStringList.Create;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  FWx_ProxyValidatorString := TwxValidatorString.Create(self);
  FWx_Color := TWxColorString.Create;
  defaultBGColor := self.color;
  defaultFGColor := self.font.color;
  FWx_ClrPickStyles := [wxCLRP_DEFAULT_STYLE];
  Self.ButtonColor := GetColorFromString(FInvisibleColorString);
//  Self.Edit.Visible := False;

end; { of AutoInitialize }

procedure TWxColourPickerCtrl.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Color.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyValidatorString.Destroy;
end; { of AutoDestroy }


constructor TWxColourPickerCtrl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoInitialize;

  PopulateGenericProperties(FWx_PropertyList);

  FWx_PropertyList.add('Wx_Color:Button Colour');
  FWx_PropertyList.add('Wx_ClrPickStyles:ColourPickerStyles');
  FWx_PropertyList.add('wxCLRP_DEFAULT_STYLE:wxCLRP_DEFAULT_STYLE');
  FWx_PropertyList.add('wxCLRP_USE_TEXTCTRL:wxCLRP_USE_TEXTCTRL');
  FWx_PropertyList.add('wxCLRP_SHOW_LABEL:wxCLRP_SHOW_LABEL');

  FWx_EventList.add('EVT_COLOURPICKER_CHANGED:OnColourChanged');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

  end;

destructor TWxColourPickerCtrl.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

function TWxColourPickerCtrl.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxColourPickerCtrl.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d', [Wx_IDName, Wx_IDValue]);
end;

function TWxColourPickerCtrl.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

  if (XRCGEN) then
 begin
  if trim(EVT_COLOURPICKER_CHANGED) <> '' then
    Result := Format('EVT_COLOURPICKER_CHANGED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_COLOURPICKER_CHANGED]) + '';

    if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
   end
 else
 begin
  if trim(EVT_COLOURPICKER_CHANGED) <> '' then
    Result := Format('EVT_COLOURPICKER_CHANGED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_COLOURPICKER_CHANGED]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
 end;

end;

function TWxColourPickerCtrl.GenerateXRCControlCreation(IndentString: string): TStringList;
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

    if not(UseDefaultSize)then
      Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    if not(UseDefaultPos) then
      Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

      Result.Add(IndentString + Format('  <style>%s</style>',
      [GetColourPickerCtrlSpecificStyle(self.Wx_GeneralStyle, Wx_ClrPickStyles)]));
    Result.Add(IndentString + '</object>');

  except

    Result.Free;
    raise;

  end;

end;

function TWxColourPickerCtrl.GenerateGUIControlCreation: string;
var
  strChoice, strColorStr: string;
  strStyle, parentName, strAlignment, strAlign: string;
begin
  Result := '';

  strStyle   := GetColourPickerCtrlSpecificStyle(self.Wx_GeneralStyle, Wx_ClrPickStyles);
  parentName := GetWxWidgetParent(self);
  strColorStr := GetwxColorFromString(FInvisibleColorString);

  if (strColorStr =  '') then
        strColorStr := '*wxBLACK';

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
 begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s, %s, %s%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
      self.Wx_IDValue), strColorStr, GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle, GetCppString(self.Text)]);
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
  if (self.Parent is TWxSizerPanel) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

end;

function TWxColourPickerCtrl.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxColourPickerCtrl.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/clrpicker.h>';
end;

function TWxColourPickerCtrl.GenerateImageInclude: string;
begin

end;

function TWxColourPickerCtrl.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxColourPickerCtrl.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxColourPickerCtrl.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxColourPickerCtrl.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_COLOURPICKER_CHANGED' then
  begin
    Result := 'wxColourPickerEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxColourPickerCtrl.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxColourPickerCtrl.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxColourPickerCtrl.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxColourPickerCtrl.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxColourPickerCtrl.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxColourPickerCtrl.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxColourPickerCtrl.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxColourPickerCtrl.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxColourPickerCtrl';
  Result := wx_Class;
end;

procedure TWxColourPickerCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxColourPickerCtrl.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxColourPickerCtrl.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDValue;
end;

procedure TWxColourPickerCtrl.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxColourPickerCtrl.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxColourPickerCtrl.GetGenericColor(strVariableName: string): string;
begin

  Result := FInvisibleColorString;

end;

procedure TWxColourPickerCtrl.SetGenericColor(strVariableName, strValue: string);
begin
  FInvisibleColorString := strValue;
  Self.ButtonColor := GetColorFromString(FInvisibleColorString);
end;

function TWxColourPickerCtrl.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxColourPickerCtrl.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxColourPickerCtrl.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxColourPickerCtrl.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxColourPickerCtrl.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxColourPickerCtrl.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxColourPickerCtrl.GetValidatorString:TWxValidatorString;
begin
  Result := FWx_ProxyValidatorString;
  Result.FstrValidatorValue := Wx_Validator;
end;

procedure TWxColourPickerCtrl.SetValidatorString(Value:TWxValidatorString);
begin
  FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
  Wx_Validator := Value.FstrValidatorValue;
end;

function TWxColourPickerCtrl.GetValidator:String;
begin
  Result := Wx_Validator;
end;

procedure TWxColourPickerCtrl.SetValidator(value:String);
begin
  Wx_Validator := value;
end;

function TWxColourPickerCtrl.GetPropertyName(Idx:Integer):String;
begin
  Result:=Name;
end;



var
  I: integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxCLRP_DEFAULT_STYLE in stdStyle then
      strLst.add('wxCLRP_DEFAULT_STYLE');

    if wxCLRP_USE_TEXTCTRL in stdStyle then
    begin
      strLst.add('wxCLRP_USE_TEXTCTRL');
      Self.ShowEdit := True;
    end
    else
    begin
      Self.ShowEdit := False;
    end;

    if wxCLRP_SHOW_LABEL in stdStyle then
    begin
      strLst.add('wxCLRP_SHOW_LABEL');
//      Self.ButtonCaption := FInvisibleColorString;
      //mn need to do the caption stuff here
      Self.ButtonCaption := '#XXXXXX';
    end
    else
      Self.ButtonCaption := '';

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

function TWxColourPickerCtrl.GetColourPickerCtrlSpecificStyle(stdstyle: TWxStdStyleSet; dlgstyle: TWxClrPickCtrlStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA := trim(GetColourPickerCtrlStyleString(dlgstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

{function TWxColourPickerCtrl.GetWXColorFromString(strColorValue: string): string;
var
  strChoice, strCmd: string;
begin
  strChoice := copy(strColorValue, 5, length(strColorValue));
  strCmd := copy(strColorValue, 0, 4);
  if AnsiSameText(strCmd, 'CUS:') then
  begin
    Result := 'wxColour(' + strChoice + ')';
    exit;
  end;
  Result := strChoice;
end; }

end.
