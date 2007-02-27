 { ****************************************************************** }
 {                                                                    }
{ $Id$                                                               }
 {                                                                    }
 {   VCL component TWxPanel                                           }
 {                                                                    }
 {   Code generated by Component Create for Delphi                    }
 {                                                                    }
 {   Generated from source file wxpanel.cd }
 {   on 22 Oct 2004 at 18:10                                          }
 {                                                                    }
 {   Copyright � 2004 by ...                                          }
 {                                                                    }
 { ****************************************************************** }

unit WxPanel;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ExtCtrls, WxUtils, WxSizerPanel;

type
  TWxPanel = class(TPanel, IWxComponentInterface, IWxWindowInterface,
    IWxContainerInterface, IWxContainerAndSizerInterface)
  private
    { Private fields of TWxPanel }
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

    {Event Lisiting}
    FEVT_UPDATE_UI: string;

    { Private methods of TWxPanel }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected
    { Protected fields of TWxPanel }

    { Protected methods of TWxPanel }


  public
    { Public fields and properties of TWxPanel }
    defaultBGColor: TColor;
    defaultFGColor: TColor;

    { Public methods of TWxPanel }
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

  published
    { Published properties of TWxPanel }
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
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
  RegisterComponents('wxWidgets', [TWxPanel]);
end;


procedure TWxPanel.AutoInitialize;
begin
  Caption                := '';
  FWx_PropertyList       := TStringList.Create;
  FWx_EventList          := TStringList.Create;
  FWx_Comments           := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxPanel';
  FWx_Enabled            := True;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;

{$IFDEF COMPILER_7_UP}
  //Set the background colour for Delphi to draw
  Self.ParentColor := False;
  Self.ParentBackground := False;
{$ENDIF}

end; { of AutoInitialize }


procedure TWxPanel.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

constructor TWxPanel.Create(AOwner: TComponent);
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

  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
end;

destructor TWxPanel.Destroy;
begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
  AutoDestroy;

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
  inherited Destroy;
end;

procedure TWxPanel.Paint;
begin
  self.Caption := '';
     { Make this component look like its parent component by calling
       its parent's Paint method. }
  inherited Paint;
end;


function TWxPanel.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxPanel.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxPanel.GenerateEventTableEntries(CurrClassName: string): string;
begin

 if (XRCGEN) then
 begin//generate xrc loading code
  Result := '';
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
 end
 else
 begin
  Result := '';
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
 end; 

end;

function TWxPanel.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  wxcompInterface: IWxComponentInterface;
  i: integer;
  tempstring: TStringList;
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

    for i := 0 to self.ControlCount - 1 do // Iterate
      if self.Controls[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
        // Only add the XRC control if it is a child of the top-most parent (the form)
        //  If it is a child of a sizer, panel, or other object, then it's XRC code
        //  is created in GenerateXRCControlCreation of that control.
        if (self.Controls[i].GetParentComponent.Name = self.Name) then
        begin
          tempstring := wxcompInterface.GenerateXRCControlCreation('    ' + IndentString);
          try
            Result.AddStrings(tempstring)
          finally
            tempstring.Free
          end
        end; // for

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxPanel.GenerateGUIControlCreation: string;
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

  strStyle := GetStdStyleString(self.Wx_GeneralStyle);
  if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle;

 if (XRCGEN) then
 begin//generate xrc loading code
   Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = wxXmlResource::Get()->LoadPanel(%s,%s("%s"));',
    [self.Name, parentName, StringFormat, self.Name])
 end
 else
 begin//generate the cpp code
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, wxPoint(%d,%d), wxSize(%d,%d)%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    self.Left, self.Top, self.Width, self.Height, strStyle]);
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

    if ((not (XRCGEN)) and (self.Parent is TWxSizerPanel)) or ((self.Parent is TWxSizerPanel) and (self.Parent.Parent is TForm) and (XRCGEN)) then
    begin
      strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
      Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
        [self.parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
        self.Wx_Border]);
    end

end;

function TWxPanel.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxPanel.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/panel.h>';
end;

function TWxPanel.GenerateImageInclude: string;
begin

end;

function TWxPanel.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxPanel.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxPanel.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxPanel.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxPanel.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxPanel.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxPanel.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxPanel.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxPanel.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxPanel.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxPanel.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxPanel.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxPanel';
  Result := wx_Class;
end;

procedure TWxPanel.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxPanel.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxPanel.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxPanel.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxPanel.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxPanel.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxPanel.SetGenericColor(strVariableName,strValue: string);
begin

end;


function TWxPanel.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxPanel.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxPanel.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxPanel.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxPanel.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxPanel.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxPanel.GenerateLastCreationCode: string;
begin
  Result := '';
end;


end.
