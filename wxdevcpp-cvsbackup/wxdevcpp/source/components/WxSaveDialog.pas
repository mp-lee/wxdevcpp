unit WxSaveDialog;

interface

uses
  Windows, Messages, SysUtils, Classes,wxUtils,WxNonVisibleBaseComponent;

type
  TWxSaveDialog = class(TWxNonVisibleBaseComponent,IWxComponentInterface)
  private
    { Private declarations }
        FWx_Class : String;
        FWx_Enabled : Boolean;
        FWx_Hidden : Boolean;
        FWx_IDName : String;
        FWx_IDValue : Longint;
        FWx_PropertyList : TStringList;
        FWx_Message: String;
        FWx_Extensions: String;
        FWx_DefaultFile: String;
        FWx_DefaultDir: String;

        procedure AutoInitialize;
        procedure AutoDestroy;

  protected

  public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        function GenerateControlIDs:String;
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
        property Wx_Enabled : Boolean read FWx_Enabled write FWx_Enabled default True;
        property Wx_Hidden : Boolean read FWx_Hidden write FWx_Hidden default False;
        property Wx_IDName : String read FWx_IDName write FWx_IDName;
        property Wx_IDValue : Longint read FWx_IDValue write FWx_IDValue;
        property Wx_Message: String read FWx_Message write FWx_Message;
        property Wx_Extensions: String read FWx_Extensions write FWx_Extensions;
        property Wx_DefaultFile: String read FWx_DefaultFile write FWx_DefaultFile;
        property Wx_DefaultDir: String read FWx_DefaultDir write FWx_DefaultDir;
    
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxSaveDialog]);
end;
{ Method to set variable and property values and create objects }
procedure TWxSaveDialog.AutoInitialize;
begin
     FWx_PropertyList := TStringList.Create;
     FWx_Class := 'wxFileDialog';
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxSaveDialog.AutoDestroy;
begin
     FWx_PropertyList.Free;
end; { of AutoDestroy }

constructor TWxSaveDialog.Create(AOwner: TComponent);
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
     FWx_PropertyList.add('wx_Class:Base Class');
     FWx_PropertyList.add('Wx_Hidden :Hidden');
     FWx_PropertyList.add('Wx_IDName : IDName ');
     FWx_PropertyList.add('Wx_IDValue : IDValue ');
     FWx_PropertyList.add('Name : Name');
     FWx_PropertyList.add('Wx_MenuItems: Menu Items');
     
end;

destructor TWxSaveDialog.Destroy;
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

function TWxSaveDialog.GenerateControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;

function TWxSaveDialog.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
end;

function TWxSaveDialog.GenerateGUIControlCreation:String;
var
     strColorStr:String;
     strStyle,parentName,strAlignment:String;
begin
     Result:='';
    parentName:=GetWxWidgetParent(self);

    //strStyle:=GetStdStyleString(self.Wx_GeneralStyle);
    if trim(strStyle) <> '' then
       strStyle:=',' +strStyle;
    Result:=Format('%s =  new %s(%s, %s,_("%s"),wxPoint(%d,%d),wxSize(%d,%d) %s );',[self.Name,self.Wx_Class,parentName,GetWxIDString(self.Wx_IDName,self.Wx_IDValue),self.Caption,self.Left,self.Top,self.width,self.Height,strStyle] );

    if self.Wx_Hidden then
        Result:=Result + #13+Format('%s->Show(false);',[self.Name]);

    if not Wx_Enabled then
        Result:=Result + #13+Format('%s->Enable(false);',[self.Name]);

end;

function TWxSaveDialog.GenerateGUIControlDeclaration:String;
begin
     Result:='';
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxSaveDialog.GenerateHeaderInclude:String;
begin
     Result:='';
     Result:='#include <wx/menu.h>';
end;

function TWxSaveDialog.GenerateImageInclude: string;
begin

end;

function TWxSaveDialog.GetEventList:TStringlist;
begin
Result:=nil;
end;

function TWxSaveDialog.GetIDName:String;
begin
     Result:=wx_IDName;
end;

function TWxSaveDialog.GetIDValue:LongInt;
begin
     Result:=wx_IDValue;
end;

function TWxSaveDialog.GetParameterFromEventName(EventName: string):String;
begin

end;

function TWxSaveDialog.GetStretchFactor:Integer;
begin
//
end;

function TWxSaveDialog.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxSaveDialog.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxSaveDialog.GetWxClassName:String;
begin
     Result:=wx_Class;
end;

procedure TWxSaveDialog.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
    //
end;

procedure TWxSaveDialog.SetIDName(IDName:String);
begin
     wx_IDName:=IDName;
end;

procedure TWxSaveDialog.SetIDValue(IDValue:longInt);
begin
     Wx_IDValue:=IDVAlue;
end;

procedure TWxSaveDialog.SetStretchFactor(intValue:Integer);
begin
end;

procedure TWxSaveDialog.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxSaveDialog.GetFGColor:string;
begin

end;

procedure TWxSaveDialog.SetFGColor(strValue:String);
begin
end;
    
function TWxSaveDialog.GetBGColor:string;
begin
end;

procedure TWxSaveDialog.SetBGColor(strValue:String);
begin
end;
procedure TWxSaveDialog.SetProxyFGColorString(value:String);
begin
end;

procedure TWxSaveDialog.SetProxyBGColorString(value:String);
begin
end;

end.
 