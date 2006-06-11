// $Id$
//

unit wxProgressDialog;

interface

uses
  Windows, Messages, SysUtils, Classes,wxUtils,WxNonVisibleBaseComponent;

type
  TWxProgressDialog = class(TWxNonVisibleBaseComponent,IWxComponentInterface)
  private
    { Private declarations }
        FWx_Class : String;
        FWx_PropertyList : TStringList;
        FWx_ProgressDialogStyle:TWxProgressDialogStyleSet;
        FWx_Title: String;
        FWX_MAXValue:Integer;
        FWX_AutoShow:Boolean;
        FWx_Message: String;
        
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
        property Wx_Title: String read FWx_Title write FWx_Title;
        property WX_MAXValue: integer read FWX_MAXValue write FWX_MAXValue default 100;
        property WX_AutoShow: boolean read FWX_AutoShow write FWX_AutoShow default false;        
        property Wx_ProgressDialogStyle:TWxProgressDialogStyleSet read FWx_ProgressDialogStyle write FWx_ProgressDialogStyle;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxProgressDialog]);
end;

procedure TWxProgressDialog.AutoInitialize;
begin
     FWx_PropertyList := TStringList.Create;
     FWx_Class := 'wxProgressDialog';
     Glyph.Handle:=LoadBitmap(hInstance, 'TWxProgressDialog');
     FWX_MAXValue:=100;
     FWX_AutoShow:=false;
     FWx_ProgressDialogStyle :=[wxPD_AUTO_HIDE,wxPD_APP_MODAL];
end; { of AutoInitialize }

procedure TWxProgressDialog.AutoDestroy;
begin
     FWx_PropertyList.Free;
end; { of AutoDestroy }

constructor TWxProgressDialog.Create(AOwner: TComponent);
begin
     { Call the Create method of the container's parent class       }
     inherited Create(AOwner);

     AutoInitialize;
     { Code to perform other tasks when the component is created }
     FWx_PropertyList.add('Wx_ProgressDialogStyle:Progress Dialog Style');
     FWx_PropertyList.add('wxPD_APP_MODAL:wxPD_APP_MODAL');
     FWx_PropertyList.add('wxPD_AUTO_HIDE:wxPD_AUTO_HIDE');
     FWx_PropertyList.add('wxPD_CAN_ABORT:wxPD_CAN_ABORT');
     FWx_PropertyList.add('wxPD_ELAPSED_TIME:wxPD_ELAPSED_TIME');
     FWx_PropertyList.add('wxPD_ESTIMATED_TIME:wxPD_ESTIMATED_TIME');
     FWx_PropertyList.add('wxPD_REMAINING_TIME:wxPD_REMAINING_TIME');
     FWx_PropertyList.add('Wx_Message:Message');
     FWx_PropertyList.add('Wx_Title:Title');
     FWx_PropertyList.add('WX_MAXValue:MAX Value');
     FWx_PropertyList.add('WX_AutoShow:Auto Show');
     FWx_PropertyList.add('Name:Name');
     FWx_PropertyList.add('Wx_Class:Base Class');
end;

destructor TWxProgressDialog.Destroy;
begin
     AutoDestroy;
     inherited Destroy;
end;

function TWxProgressDialog.GenerateControlIDs:String;
begin
     Result:='';
end;

function TWxProgressDialog.GenerateEnumControlIDs:String;
begin
     Result:='';
end;

function TWxProgressDialog.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
end;

function TWxProgressDialog.GenerateGUIControlCreation:String;
begin
    Result:='';
    Result:=Format('%s =  new %s(_("%s") , _("%s") , %d , this  %s);',[self.Name,self.wx_Class,GetCppString(self.Wx_Title),self.Wx_Message,Wx_MaxValue,GetProgressDialogStyleString(Wx_ProgressDialogStyle)] );

    if not WX_AutoShow then
        Result:=Result+#13+self.Name+'->Show(false);'
end;

function TWxProgressDialog.GenerateGUIControlDeclaration:String;
begin
     Result:='';
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxProgressDialog.GenerateHeaderInclude:String;
begin
     Result:='';
     Result:='#include <wx/progdlg.h>';
end;

function TWxProgressDialog.GenerateImageInclude: string;
begin

end;

function TWxProgressDialog.GetEventList:TStringlist;
begin
Result:=nil;
end;

function TWxProgressDialog.GetIDName:String;
begin

end;

function TWxProgressDialog.GetIDValue:LongInt;
begin
Result:=0;
end;

function TWxProgressDialog.GetParameterFromEventName(EventName: string):String;
begin

end;

function TWxProgressDialog.GetStretchFactor:Integer;
begin
//
end;

function TWxProgressDialog.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxProgressDialog.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxProgressDialog.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='wxProgressDialog';
     Result:=wx_Class;
end;

procedure TWxProgressDialog.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
    //
end;

procedure TWxProgressDialog.SetIDName(IDName:String);
begin

end;

procedure TWxProgressDialog.SetIDValue(IDValue:longInt);
begin

end;

procedure TWxProgressDialog.SetStretchFactor(intValue:Integer);
begin
end;

procedure TWxProgressDialog.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxProgressDialog.GetFGColor:string;
begin

end;

procedure TWxProgressDialog.SetFGColor(strValue:String);
begin
end;
    
function TWxProgressDialog.GetBGColor:string;
begin
end;

procedure TWxProgressDialog.SetBGColor(strValue:String);
begin
end;
procedure TWxProgressDialog.SetProxyFGColorString(value:String);
begin
end;

procedure TWxProgressDialog.SetProxyBGColorString(value:String);
begin
end;

end.
 