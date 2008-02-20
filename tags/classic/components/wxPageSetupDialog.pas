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


unit wxPageSetupDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxPageSetupDialog = class(TWxNonVisibleBaseComponent, IWxComponentInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FMarginTopLeftX: integer;
    FMarginTopLeftY: integer;

    FMarginBottomRightX: integer;
    FMarginBottomRightY: integer;

    FMinMarginTopLeftX: integer;
    FMinMarginTopLeftY: integer;

    FMinMarginBottomRightX: integer;
    FMinMarginBottomRightY: integer;

    FPaperId: TWxPaperSizeItem;


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

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);
    
  published
    { Published declarations }
    property Wx_Class: string Read FWx_Class Write FWx_Class;

    property Wx_MarginTopLeftX: integer Read FMarginTopLeftX Write FMarginTopLeftX;
    property Wx_MarginBottomRightX: integer
      Read FMarginBottomRightX Write FMarginBottomRightX;
    property Wx_MinMarginTopLeftX: integer Read FMinMarginTopLeftX
      Write FMinMarginTopLeftX;
    property Wx_MinMarginBottomRightX: integer
      Read FMinMarginBottomRightX Write FMinMarginBottomRightX;

    property Wx_MarginTopLeftY: integer Read FMarginTopLeftY Write FMarginTopLeftY;
    property Wx_MarginBottomRightY: integer
      Read FMarginBottomRightY Write FMarginBottomRightY;
    property Wx_MinMarginTopLeftY: integer Read FMinMarginTopLeftY
      Write FMinMarginTopLeftY;
    property Wx_MinMarginBottomRightY: integer
      Read FMinMarginBottomRightY Write FMinMarginBottomRightY;


    property Wx_PaperId: TWxPaperSizeItem Read FPaperId Write FPaperId;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxPageSetupDialog]);
end;

{ Method to set variable and property values and create objects }
procedure TWxPageSetupDialog.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class    := 'wxPageSetupDialog';
  Glyph.Handle := LoadBitmap(hInstance, 'TWxPageSetupDialog');

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxPageSetupDialog.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxPageSetupDialog.Create(AOwner: TComponent);
begin
  { Call the Create method of the container's parent class       }
  inherited Create(AOwner);

  { AutoInitialize method is generated by Component Create.      }
  AutoInitialize;

  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');

  FWx_PropertyList.add('Wx_MarginTopLeftX:MarginTopLeftX');
  FWx_PropertyList.add('Wx_MarginBottomRightX:MarginBottomRightX');
  FWx_PropertyList.add('Wx_MinMarginTopLeftX: MinMarginTopLeftX');
  FWx_PropertyList.add('Wx_MinMarginBottomRightX:MinMarginBottomRightX');

  FWx_PropertyList.add('Wx_MarginTopLeftY:MarginTopLeftY');
  FWx_PropertyList.add('Wx_MarginBottomRightY:MarginBottomRightY');
  FWx_PropertyList.add('Wx_MinMarginTopLeftY: MinMarginTopLeftY');
  FWx_PropertyList.add('Wx_MinMarginBottomRightY:MinMarginBottomRightY');

  FWx_PropertyList.add('Wx_PaperId:PaperId');
end;

destructor TWxPageSetupDialog.Destroy;
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

function TWxPageSetupDialog.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxPageSetupDialog.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxPageSetupDialog.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TWxPageSetupDialog.GenerateXRCControlCreation(IndentString: string):
TStringList;
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

function TWxPageSetupDialog.GenerateGUIControlCreation: string;
begin
  Result := '';
  Result := self.Name + '_Data = new wxPageSetupDialogData();';
  Result := Result + #13 + self.Name + '_Data->SetMarginTopLeft(wxPoint(' +
    Format('%d,%d', [Wx_MarginTopLeftX, Wx_MarginTopLeftY]) + '));';
  Result := Result + #13 + self.Name + '_Data->SetMarginBottomRight(wxPoint(' +
    Format('%d,%d', [Wx_MarginBottomRightX, Wx_MarginBottomRightY]) + '));';
  Result := Result + #13 + self.Name + '_Data->SetMinMarginTopLeft(wxPoint(' +
    Format('%d,%d', [Wx_MinMarginTopLeftX, Wx_MinMarginTopLeftY]) + '));';
  Result := Result + #13 + self.Name + '_Data->SetMinMarginBottomRight(wxPoint(' +
    Format('%d,%d', [Wx_MinMarginBottomRightX, Wx_MinMarginBottomRightY]) + '));';
  Result := Result + #13 + self.Name + '_Data->SetPaperId(' +
    PaperIDToString(Wx_PaperId) + ');';
  Result := Result + #13 + Format('%s =  new %s(this, %s);',
    [self.Name, self.wx_Class, self.Name + '_Data']);

end;

function TWxPageSetupDialog.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
  Result := Result + #13 + Format('wxPageSetupDialogData *%s_Data;', [trim(Self.Name)]);
end;

function TWxPageSetupDialog.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/printdlg.h>';
  Result := Result + #13 + '#include <wx/cmndata.h>';
end;

function TWxPageSetupDialog.GenerateImageInclude: string;
begin

end;

function TWxPageSetupDialog.GetEventList: TStringList;
begin
  Result := nil;
end;

function TWxPageSetupDialog.GetIDName: string;
begin

end;

function TWxPageSetupDialog.GetIDValue: longint;
begin
  Result := 0;
end;

function TWxPageSetupDialog.GetParameterFromEventName(EventName: string): string;
begin

end;

function TWxPageSetupDialog.GetStretchFactor: integer;
begin
   Result := 1;
end;

function TWxPageSetupDialog.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxPageSetupDialog.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxPageSetupDialog.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxPageSetupDialog.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxPageSetupDialog.SetBorderWidth(width: integer);
begin
end;

function TWxPageSetupDialog.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxPageSetupDialog.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxFindReplaceDialog';
  Result := wx_Class;
end;

procedure TWxPageSetupDialog.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxPageSetupDialog.SetIDName(IDName: string);
begin

end;

procedure TWxPageSetupDialog.SetIDValue(IDValue: longint);
begin

end;

procedure TWxPageSetupDialog.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxPageSetupDialog.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxPageSetupDialog.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxPageSetupDialog.SetGenericColor(strVariableName,strValue: string);
begin

end;


function TWxPageSetupDialog.GetFGColor: string;
begin

end;

procedure TWxPageSetupDialog.SetFGColor(strValue: string);
begin
end;

function TWxPageSetupDialog.GetBGColor: string;
begin
end;

procedure TWxPageSetupDialog.SetBGColor(strValue: string);
begin
end;

procedure TWxPageSetupDialog.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxPageSetupDialog.SetProxyBGColorString(Value: string);
begin
end;

end.
 