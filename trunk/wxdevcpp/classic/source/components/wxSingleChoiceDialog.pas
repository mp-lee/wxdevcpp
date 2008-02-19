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


unit wxSingleChoiceDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxSingleChoiceDialog = class(TWxNonVisibleBaseComponent, IWxComponentInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FWx_Message: string;
    FWx_Caption: string;
    FWx_Comments: TStrings;
    FWx_ValueList:TStrings;

    FWx_DialogStyle: TWxMessageDialogStyleSet;
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
    property Wx_Message: string Read FWx_Message Write FWx_Message;
    property Wx_Caption: string Read FWx_Caption Write FWx_Caption;
    property Wx_DialogStyle: TWxMessageDialogStyleSet
      Read FWx_DialogStyle Write FWx_DialogStyle;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    property Wx_ValueList: TStrings Read FWx_ValueList Write FWx_ValueList;   

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxSingleChoiceDialog]);
end;

{ Method to set variable and property values and create objects }
procedure TWxSingleChoiceDialog.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class    := 'wxSingleChoiceDialog';
  Glyph.Handle := LoadBitmap(hInstance, 'TwxSingleChoiceDialog');
  FWx_Caption  := 'Single Choice List';
  FWx_Comments := TStringList.Create;
  FWx_ValueList:= TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxSingleChoiceDialog.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  FWx_ValueList.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxSingleChoiceDialog.Create(AOwner: TComponent);
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

  { Code to perform other tasks when the component is created }
  { Code to perform other tasks when the component is created }
  FWx_PropertyList.add('Wx_DialogStyle:Message Dialog Style');

  FWx_PropertyList.add('wxOK:wxOK');
  FWx_PropertyList.add('wxCENTRE:wxCENTRE');
  FWx_PropertyList.add('wxCANCEL:wxCANCEL');
  FWx_PropertyList.add('wxYES_NO:wxYES_NO');
  FWx_PropertyList.add('wxYES_DEFAULT:wxYES_DEFAULT');
  FWx_PropertyList.add('wxNO_DEFAULT:wxNO_DEFAULT');

  FWx_PropertyList.add('Wx_ValueList:Items');

  FWx_PropertyList.add('Wx_Message:Message');
  FWx_PropertyList.add('Wx_Caption:Caption');
  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Comments:Comments');

end;

destructor TWxSingleChoiceDialog.Destroy;
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

function TWxSingleChoiceDialog.GenerateControlIDs: string;
begin
  Result := '';
end;


function TWxSingleChoiceDialog.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxSingleChoiceDialog.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TWxSingleChoiceDialog.GenerateXRCControlCreation(IndentString: string): TStringList;
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

function TWxSingleChoiceDialog.GenerateGUIControlCreation: string;
var
  strStyle: string;
  i:Integer;
begin
  Result   := '';
  strStyle := GetMessageDialogStyleString(self.Wx_DialogStyle,false);
  
    Result := GetCommentString(self.FWx_Comments.Text) +
    'wxArrayString arrayStringFor_' + self.Name + ';';

  for i := 0 to self.Wx_ValueList.Count - 1 do
    Result := Result + #13 + Format(
      '%s.Add(%s);', ['arrayStringFor_' + self.Name, GetCppString(self.Wx_ValueList[i])]);
      
    Result := Result + #13 +Format('%s =  new %s(this, %s, %s, %s,NULL%s);', [self.Name, self.wx_Class,
    GetCppString(wx_Message), GetCppString(wx_Caption), 'arrayStringFor_' + self.Name,strStyle]);

end;

function TWxSingleChoiceDialog.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxSingleChoiceDialog.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/choicdlg.h>';
end;

function TWxSingleChoiceDialog.GenerateImageInclude: string;
begin

end;

function TWxSingleChoiceDialog.GetEventList: TStringList;
begin
  Result := nil;
end;

function TWxSingleChoiceDialog.GetIDName: string;
begin

end;

function TWxSingleChoiceDialog.GetIDValue: longint;
begin
  Result := 0;
end;

function TWxSingleChoiceDialog.GetParameterFromEventName(EventName: string): string;
begin

end;

function TWxSingleChoiceDialog.GetStretchFactor: integer;
begin
   Result := 1;
end;

function TWxSingleChoiceDialog.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxSingleChoiceDialog.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxSingleChoiceDialog.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxSingleChoiceDialog.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxSingleChoiceDialog.SetBorderWidth(width: integer);
begin
end;

function TWxSingleChoiceDialog.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxSingleChoiceDialog.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxMessageDialog';
  Result := wx_Class;
end;

procedure TWxSingleChoiceDialog.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxSingleChoiceDialog.SetIDName(IDName: string);
begin

end;

procedure TWxSingleChoiceDialog.SetIDValue(IDValue: longint);
begin

end;

procedure TWxSingleChoiceDialog.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxSingleChoiceDialog.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxSingleChoiceDialog.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxSingleChoiceDialog.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxSingleChoiceDialog.GetFGColor: string;
begin

end;

procedure TWxSingleChoiceDialog.SetFGColor(strValue: string);
begin
end;

function TWxSingleChoiceDialog.GetBGColor: string;
begin
end;

procedure TWxSingleChoiceDialog.SetBGColor(strValue: string);
begin
end;

procedure TWxSingleChoiceDialog.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxSingleChoiceDialog.SetProxyBGColorString(Value: string);
begin

end;

end.
 