// $Id: WxSaveFileDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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


unit WxSaveFileDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxSaveFileDialog = class(TWxNonVisibleBaseComponent, IWxComponentInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FWx_Message: string;
    FWx_Extensions: string;
    FWx_DefaultFile: string;
    FWx_DefaultDir: string;
    FWx_DialogStyle: TWxFileDialogStyleSet;
    FWx_Comments: TStrings;

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
    property Wx_Extensions: string Read FWx_Extensions Write FWx_Extensions;
    property Wx_DefaultFile: string Read FWx_DefaultFile Write FWx_DefaultFile;
    property Wx_DefaultDir: string Read FWx_DefaultDir Write FWx_DefaultDir;
    property Wx_DialogStyle: TWxFileDialogStyleSet
      Read FWx_DialogStyle Write FWx_DialogStyle;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxSaveFileDialog]);
end;

{ Method to set variable and property values and create objects }
procedure TWxSaveFileDialog.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class    := 'wxFileDialog';
  Glyph.Handle := LoadBitmap(hInstance, 'TWxSaveFileDialog');
  self.FWx_Extensions := '*.*';
  self.wx_Message := 'Choose a file';
  FWx_Comments := TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxSaveFileDialog.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxSaveFileDialog.Create(AOwner: TComponent);
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
  FWx_PropertyList.add('Wx_DialogStyle:File Dialog Style');

  FWx_PropertyList.add('wxHIDE_READONLY:wxHIDE_READONLY');
  FWx_PropertyList.add('wxOVERWRITE_PROMPT:wxOVERWRITE_PROMPT');
  FWx_PropertyList.add('wxCHANGE_DIR:wxCHANGE_DIR');

  FWx_PropertyList.add('Wx_DefaultDir:Default Dir');
  FWx_PropertyList.add('Wx_DefaultFile:Default File');
  FWx_PropertyList.add('Wx_Extensions:Extensions');
  FWx_PropertyList.add('Wx_Message:Message');
  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Comments:Comments');

end;

destructor TWxSaveFileDialog.Destroy;
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

function TWxSaveFileDialog.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxSaveFileDialog.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxSaveFileDialog.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TWxSaveFileDialog.GenerateXRCControlCreation(IndentString: string): TStringList;
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

function TWxSaveFileDialog.GenerateGUIControlCreation: string;
var
  strType, strStyle: string;
begin
  Result   := '';
  strType  := 'wxSAVE';
  strStyle := GetFileDialogStyleString(self.Wx_DialogStyle);

  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s =  new %s(this, %s, %s, %s, %s, %s);',
    [self.Name, self.wx_Class, GetCppString(wx_Message), GetCppString(
    wx_DefaultDir), GetCppString(wx_DefaultFile), GetCppString(wx_Extensions), strType + strStyle]);
end;

function TWxSaveFileDialog.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxSaveFileDialog.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/filedlg.h>';
end;

function TWxSaveFileDialog.GenerateImageInclude: string;
begin

end;

function TWxSaveFileDialog.GetEventList: TStringList;
begin
  Result := nil;
end;

function TWxSaveFileDialog.GetIDName: string;
begin

end;

function TWxSaveFileDialog.GetIDValue: longint;
begin
  Result := 0;
end;

function TWxSaveFileDialog.GetParameterFromEventName(EventName: string): string;
begin

end;

function TWxSaveFileDialog.GetStretchFactor: integer;
begin
    Result := 1;
end;

function TWxSaveFileDialog.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxSaveFileDialog.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxSaveFileDialog.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxSaveFileDialog.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxSaveFileDialog.SetBorderWidth(width: integer);
begin
end;

function TWxSaveFileDialog.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxSaveFileDialog.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxFileDialog';
  Result := wx_Class;
end;

procedure TWxSaveFileDialog.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxSaveFileDialog.SetIDName(IDName: string);
begin

end;

procedure TWxSaveFileDialog.SetIDValue(IDValue: longint);
begin

end;

procedure TWxSaveFileDialog.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxSaveFileDialog.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxSaveFileDialog.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxSaveFileDialog.SetGenericColor(strVariableName,strValue: string);
begin

end;


function TWxSaveFileDialog.GetFGColor: string;
begin

end;

procedure TWxSaveFileDialog.SetFGColor(strValue: string);
begin
end;

function TWxSaveFileDialog.GetBGColor: string;
begin
end;

procedure TWxSaveFileDialog.SetBGColor(strValue: string);
begin
end;

procedure TWxSaveFileDialog.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxSaveFileDialog.SetProxyBGColorString(Value: string);
begin
end;

end.
 