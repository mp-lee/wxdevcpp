// $Id$
//

unit wxMessageDialog;

interface

uses
  Windows, Messages, SysUtils, Classes,wxUtils,WxNonVisibleBaseComponent;

type
  TWxMessageDialog = class(TWxNonVisibleBaseComponent,IWxComponentInterface)
  private
    { Private declarations }
        FWx_Class : String;
        FWx_PropertyList : TStringList;
        FWx_Message: String;
        FWx_Caption: String;
        FWx_DialogStyle : TWxMessageDialogStyleSet;
        procedure AutoInitialize;
        procedure AutoDestroy;

  protected

  public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        function GenerateControlIDs:String;
        function GenerateEnumControlIDs:String;
        function GenerateEventTableEntries(CurrClassName:String):String;
        function GenerateGUIControlCreation:String;
        function GenerateGUIControlDeclaration:String;
        function GenerateHeaderInclude:String;
        function GenerateImageInclude: string;
        function GetEventList:TStringlist;
        function GetIDName:String;
        function GetIDValue:LongInt;
        function GetParameterFromEventName(EventName: string):String;
        function GetPropertyList:TStringList;
        function GetStretchFactor:Integer;
        function GetTypeFromEventName(EventName: string):string;
        function GetWxClassName:String;
        procedure SaveControlOrientation(ControlOrientation:TWxControlOrientation);
        procedure SetIDName(IDName:String);
        procedure SetIDValue(IDValue:longInt);
        procedure SetStretchFactor(intValue:Integer);
        procedure SetWxClassName(wxClassName:String);
        function GetFGColor:string;
        procedure SetFGColor(strValue:String);
        function GetBGColor:string;
        procedure SetBGColor(strValue:String);
        procedure SetProxyFGColorString(value:String);
        procedure SetProxyBGColorString(value:String);
  published
    { Published declarations }
        property Wx_Class : String read FWx_Class write FWx_Class;
        property Wx_Message: String read FWx_Message write FWx_Message;
        property Wx_Caption: String read FWx_Caption write FWx_Caption;
        property Wx_DialogStyle:TWxMessageDialogStyleSet read FWx_DialogStyle write FWx_DialogStyle;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxMessageDialog]);
end;

{ Method to set variable and property values and create objects }
procedure TWxMessageDialog.AutoInitialize;
begin
     FWx_PropertyList := TStringList.Create;
     FWx_Class := 'wxMessageDialog';
     Glyph.Handle:=LoadBitmap(hInstance, 'TWxMessageDialog');
     FWx_Caption:='Message box';
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxMessageDialog.AutoDestroy;
begin
     FWx_PropertyList.Free;
end; { of AutoDestroy }

constructor TWxMessageDialog.Create(AOwner: TComponent);
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
     FWx_PropertyList.add('wxCANCEL:wxCANCEL');
     FWx_PropertyList.add('wxYES_NO:wxYES_NO');
     FWx_PropertyList.add('wxYES_DEFAULT:wxYES_DEFAULT');
     FWx_PropertyList.add('wxNO_DEFAULT:wxNO_DEFAULT');
     FWx_PropertyList.add('wxICON_EXCLAMATION:wxICON_EXCLAMATION');
     FWx_PropertyList.add('wxICON_HAND:wxICON_HAND');
     FWx_PropertyList.add('wxICON_ERROR:wxICON_ERROR');
     FWx_PropertyList.add('wxICON_QUESTION:wxICON_QUESTION');
     FWx_PropertyList.add('wxICON_INFORMATION:wxICON_INFORMATION');
     FWx_PropertyList.add('wxSTAY_ON_TOP:wxSTAY_ON_TOP');

     FWx_PropertyList.add('Wx_Message:Message');
     FWx_PropertyList.add('Wx_Caption:Caption');
     FWx_PropertyList.add('Name:Name');
     FWx_PropertyList.add('Wx_Class:Base Class');
end;

destructor TWxMessageDialog.Destroy;
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

function TWxMessageDialog.GenerateControlIDs:String;
begin
     Result:='';
end;


function TWxMessageDialog.GenerateEnumControlIDs:String;
begin
     Result:='';
end;

function TWxMessageDialog.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
end;

function TWxMessageDialog.GenerateGUIControlCreation:String;
var
     strStyle:String;
begin
    Result:='';
    strStyle:=GetMessageDialogStyleString(self.Wx_DialogStyle);
    Result:=Format('%s =  new %s(this, %s, %s%s);',[self.Name,self.wx_Class,GetCppString(wx_Message),GetCppString(wx_Caption),strStyle] );
end;

function TWxMessageDialog.GenerateGUIControlDeclaration:String;
begin
     Result:='';
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxMessageDialog.GenerateHeaderInclude:String;
begin
     Result:='';
     Result:='#include <wx/msgdlg.h>';
end;

function TWxMessageDialog.GenerateImageInclude: string;
begin

end;

function TWxMessageDialog.GetEventList:TStringlist;
begin
Result:=nil;
end;

function TWxMessageDialog.GetIDName:String;
begin

end;

function TWxMessageDialog.GetIDValue:LongInt;
begin
result:=0;
end;

function TWxMessageDialog.GetParameterFromEventName(EventName: string):String;
begin

end;

function TWxMessageDialog.GetStretchFactor:Integer;
begin
//
end;

function TWxMessageDialog.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxMessageDialog.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxMessageDialog.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='wxMessageDialog';
     Result:=wx_Class;
end;

procedure TWxMessageDialog.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
    //
end;

procedure TWxMessageDialog.SetIDName(IDName:String);
begin

end;

procedure TWxMessageDialog.SetIDValue(IDValue:longInt);
begin

end;

procedure TWxMessageDialog.SetStretchFactor(intValue:Integer);
begin
end;

procedure TWxMessageDialog.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxMessageDialog.GetFGColor:string;
begin

end;

procedure TWxMessageDialog.SetFGColor(strValue:String);
begin
end;
    
function TWxMessageDialog.GetBGColor:string;
begin
end;

procedure TWxMessageDialog.SetBGColor(strValue:String);
begin
end;
procedure TWxMessageDialog.SetProxyFGColorString(value:String);
begin
end;

procedure TWxMessageDialog.SetProxyBGColorString(value:String);
begin

end;

end.
 
