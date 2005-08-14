// $Id$


unit WxColourDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxColourDialog = class(TWxNonVisibleBaseComponent, IWxComponentInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected

  public
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
    { Published declarations }
    property Wx_Class: string Read FWx_Class Write FWx_Class;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxColourDialog]);
end;

{ Method to set variable and property values and create objects }
procedure TWxColourDialog.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class    := 'wxColourDialog';
  Glyph.Handle := LoadBitmap(hInstance, 'TWxColourDialog');
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxColourDialog.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxColourDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoInitialize;
  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');
end;

destructor TWxColourDialog.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

function TWxColourDialog.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxColourDialog.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxColourDialog.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TWxColourDialog.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + '</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxColourDialog.GenerateGUIControlCreation: string;
begin
  Result := '';
  Result := Format('%s =  new %s(this);', [self.Name, self.wx_Class]);
end;

function TWxColourDialog.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxColourDialog.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/colordlg.h>';
end;

function TWxColourDialog.GenerateImageInclude: string;
begin

end;

function TWxColourDialog.GetEventList: TStringList;
begin
  Result := nil;
end;

function TWxColourDialog.GetIDName: string;
begin

end;

function TWxColourDialog.GetIDValue: longint;
begin
  Result := 0;
end;

function TWxColourDialog.GetParameterFromEventName(EventName: string): string;
begin

end;

function TWxColourDialog.GetStretchFactor: integer;
begin

end;

function TWxColourDialog.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxColourDialog.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxColourDialog.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxColourDialog';
  Result := wx_Class;
end;

procedure TWxColourDialog.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxColourDialog.SetIDName(IDName: string);
begin

end;

procedure TWxColourDialog.SetIDValue(IDValue: longint);
begin

end;

procedure TWxColourDialog.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxColourDialog.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxColourDialog.GetFGColor: string;
begin

end;

procedure TWxColourDialog.SetFGColor(strValue: string);
begin
end;

function TWxColourDialog.GetBGColor: string;
begin
end;

procedure TWxColourDialog.SetBGColor(strValue: string);
begin
end;

procedure TWxColourDialog.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxColourDialog.SetProxyBGColorString(Value: string);
begin
end;

end.
 