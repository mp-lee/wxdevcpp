{ ****************************************************************** }
{                                                                    }
{   VCL component TWxSpinButton                                      }
{                                                                    }
{   Code generated by Component Create for Delphi                    }
{                                                                    }
{   Generated from source file e:\backup\delphi\demo\wxdevcpp\source\compon~1\compcode\wxspin~1.cd }
{   on 27 Sept 2004 at 0:01                                          }
{                                                                    }
{   Copyright � 2003 by Guru Kathiresan                              }
{                                                                    }
{ ****************************************************************** }

unit WxSpinButton;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, 
     Forms, Graphics, Comctrls, WxUtils, ExtCtrls, WxSizerPanel;

{
*************IMPORTANT*************
If you want to change any of the wxwidgets components,  you have to use comp screate by David Price.
You can download a copy from

http://torry.net/tools/components/compcreation/cc.zip

***IF YOU FOLLOW THIS YOUR UPDATES WONT BE INCLUDED IN THE DISTRIBUTION****
}

type
  TWxSpinButton = class(TUpDown,IWxComponentInterface)
    private
      { Private fields of TWxSpinButton }
        { Storage for property EVT_SPIN }
        FEVT_SPIN : String;
        { Storage for property EVT_SPIN_DOWN }
        FEVT_SPIN_DOWN : String;
        { Storage for property EVT_SPIN_UP }
        FEVT_SPIN_UP : String;
        { Storage for property EVT_UPDATE_UI }
        FEVT_UPDATE_UI : String;
        { Storage for property Wx_Border }
        FWx_Border : Integer;
        { Storage for property Wx_Class }
        FWx_Class : String;
        { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation : TWxControlOrientation;
        { Storage for property Wx_Enabled }
        FWx_Enabled : Boolean;
        { Storage for property Wx_GeneralStyle }
        FWx_GeneralStyle : TWxStdStyleSet;
        { Storage for property Wx_HelpText }
        FWx_HelpText : String;
        { Storage for property Wx_Hidden }
        FWx_Hidden : Boolean;
        { Storage for property Wx_HorizontalAlignment }
        FWx_HorizontalAlignment : TWxSizerHorizontalAlignment;
        { Storage for property Wx_IDName }
        FWx_IDName : String;
        { Storage for property Wx_IDValue }
        FWx_IDValue : Longint;
        { Storage for property Wx_Max }
        FWx_Max : Integer;
        { Storage for property Wx_Position }
        FWx_Position : Integer;
        { Storage for property Wx_SpinButtonStyle }
        FWx_SpinButtonStyle : TWxsbtnStyleSet;
        { Storage for property Wx_StrechFactor }
        FWx_StrechFactor : Integer;
        { Storage for property Wx_ToolTip }
        FWx_ToolTip : String;
        { Storage for property Wx_VerticalAlignment }
        FWx_VerticalAlignment : TWxSizerVerticalAlignment;
        FWx_EventList : TStringList;
        FWx_PropertyList : TStringList;

      { Private methods of TWxSpinButton }
        { Method to set variable and property values and create objects }
        procedure AutoInitialize;
        { Method to free any objects created by AutoInitialize }
        procedure AutoDestroy;

    protected
      { Protected fields of TWxSpinButton }

      { Protected methods of TWxSpinButton }
        procedure Loaded; override;

    public
      { Public fields and properties of TWxSpinButton }

      { Public methods of TWxSpinButton }
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
        function GetTypeFromEventName(EventName: string):string;
        function GetWxClassName:String;
        procedure SaveControlOrientation(ControlOrientation:TWxControlOrientation);
        procedure SetIDName(IDName:String);
        procedure SetIDValue(IDValue:longInt);
        procedure SetWxClassName(wxClassName:String);

    published
      { Published properties of TWxSpinButton }
        property EVT_SPIN : String read FEVT_SPIN write FEVT_SPIN;
        property EVT_SPIN_DOWN : String
             read FEVT_SPIN_DOWN write FEVT_SPIN_DOWN;
        property EVT_SPIN_UP : String read FEVT_SPIN_UP write FEVT_SPIN_UP;
        property EVT_UPDATE_UI : String
             read FEVT_UPDATE_UI write FEVT_UPDATE_UI;
        property Wx_Border : Integer
             read FWx_Border write FWx_Border
             default 5;
        property Wx_Class : String read FWx_Class write FWx_Class;
        property Wx_ControlOrientation : TWxControlOrientation
             read FWx_ControlOrientation write FWx_ControlOrientation;
        property Wx_Enabled : Boolean
             read FWx_Enabled write FWx_Enabled
             default True;
        property Wx_GeneralStyle : TWxStdStyleSet
             read FWx_GeneralStyle write FWx_GeneralStyle;
        property Wx_HelpText : String read FWx_HelpText write FWx_HelpText;
        property Wx_Hidden : Boolean
             read FWx_Hidden write FWx_Hidden
             default False;
        property Wx_HorizontalAlignment : TWxSizerHorizontalAlignment
             read FWx_HorizontalAlignment write FWx_HorizontalAlignment
             default wxSZALIGN_CENTER_HORIZONTAL;
        property Wx_IDName : String read FWx_IDName write FWx_IDName;
        property Wx_IDValue : Longint
             read FWx_IDValue write FWx_IDValue
             default -1;
        property Wx_Max : Integer read FWx_Max write FWx_Max;
        property Wx_Position : Integer read FWx_Position write FWx_Position;
        property Wx_SpinButtonStyle : TWxsbtnStyleSet
             read FWx_SpinButtonStyle write FWx_SpinButtonStyle;
        property Wx_StrechFactor : Integer
             read FWx_StrechFactor write FWx_StrechFactor;
        property Wx_ToolTip : String read FWx_ToolTip write FWx_ToolTip;
        property Wx_VerticalAlignment : TWxSizerVerticalAlignment
             read FWx_VerticalAlignment write FWx_VerticalAlignment
             default wxSZALIGN_CENTER_VERTICAL;

  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxSpinButton with wxWidgets as its
       default page on the Delphi component palette }
     RegisterComponents('wxWidgets', [TWxSpinButton]);
end;

{ Method to set variable and property values and create objects }
procedure TWxSpinButton.AutoInitialize;
begin
     FWx_EventList := TStringList.Create;
     FWx_PropertyList := TStringList.Create;
     FWx_Border := 5;
     FWx_Class := 'wxSpinButton';
     FWx_Enabled := True;
     FWx_Hidden := False;
     FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
     FWx_IDValue := -1;
     FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxSpinButton.AutoDestroy;
begin
     FWx_EventList.Free;
     FWx_PropertyList.Free;
end; { of AutoDestroy }

constructor TWxSpinButton.Create(AOwner: TComponent);
begin
     { Call the Create method of the parent class }
     inherited Create(AOwner);

     { AutoInitialize sets the initial values of variables and      }
     { properties; also, it creates objects for properties of       }
     { standard Delphi object types (e.g., TFont, TTimer,           }
     { TPicture) and for any variables marked as objects.           }
     { AutoInitialize method is generated by Component Create.      }
     AutoInitialize;

     { Code to perform other tasks when the component is created }

     FWx_PropertyList.add('Orientation :Orientation');
     FWx_PropertyList.add('Max :Max');
     FWx_PropertyList.add('Min :Min');
     FWx_PropertyList.add('Position :Value');
     FWx_PropertyList.add('Wx_Hidden :Hidden');
     FWx_PropertyList.add('Wx_Border : Border ');
     FWx_PropertyList.add('Wx_Default :WxDefault ');
     FWx_PropertyList.add('Wx_HelpText :HelpText ');
     FWx_PropertyList.add('Wx_IDName : IDName ');
     FWx_PropertyList.add('Wx_IDValue : IDValue ');
     FWx_PropertyList.add('Wx_ToolTip :ToolTip ');
     FWx_PropertyList.add('Text:Text');
     FWx_PropertyList.add('Name:Name');
     FWx_PropertyList.add('Wx_Class:Base Class');
     FWx_PropertyList.add('Wx_Enabled:Enabled');
     FWx_PropertyList.add('Left:Left');
     FWx_PropertyList.add('Top:Top');
     FWx_PropertyList.add('Width:Width');
     FWx_PropertyList.add('Height:Height');
     FWx_PropertyList.add('Wx_GeneralStyle : General Styles');
     FWx_PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
     FWx_PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
     FWx_PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
     FWx_PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
     FWx_PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
     FWx_PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
     FWx_PropertyList.Add('wxNO_3D:wxNO_3D');
     FWx_PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
     FWx_PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
     FWx_PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
     FWx_PropertyList.Add('wxVSCROLL:wxVSCROLL');
     FWx_PropertyList.Add('wxHSCROLL:wxHSCROLL');
     FWx_PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');


     FWx_PropertyList.add('Wx_SpinButtonStyle:Spin Button Style');
     FWx_PropertyList.Add('wxSP_ARROW_KEYS:wxSP_ARROW_KEYS');
     FWx_PropertyList.Add('wxSP_WRAP:wxSP_WRAP');



     FWx_PropertyList.add('Font : Font');
     FWx_PropertyList.add('Color : Color ');

     FWx_PropertyList.add('Checked : Checked');


     FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
     FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');


     FWx_EventList.add('EVT_SPIN : OnUpdated');
     FWx_EventList.add('EVT_SPIN_UP : OnUp' );
     FWx_EventList.add('EVT_SPIN_DOWN : OnDown' );
     FWx_EventList.add('EVT_UPDATE_UI : OnUpdate' );

end;

destructor TWxSpinButton.Destroy;
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

function TWxSpinButton.GenerateControlIDs:String;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;

function TWxSpinButton.GenerateEventTableEntries(CurrClassName:String):String;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     Result:='';

     if trim(EVT_SPIN) <> '' then
     begin
          Result:=Format('EVT_SPIN(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_SPIN]) +'';
     end;

     if trim(EVT_SPIN_UP) <> '' then
     begin
          Result:=Result+#13+Format('EVT_SPIN_UP(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_SPIN_UP]) +'';
     end;
     if trim(EVT_SPIN_DOWN ) <> '' then
     begin
          Result:=Result+#13+Format('EVT_SPIN_DOWN (%s,%s::%s)',[WX_IDName,CurrClassName,EVT_SPIN_DOWN ]) +'';
     end;

     if trim(EVT_UPDATE_UI) <> '' then
     begin
          Result:=Result+#13+Format('EVT_UPDATE_UI(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_UPDATE_UI]) +'';
     end;

end;

function TWxSpinButton.GenerateGUIControlCreation:String;
     { Internal declarations for method }
     { type }
     { . . . }
var
     strStyle,parentName,strAlignment:String;
begin
     Result:='';
    if (self.Parent is TForm) or (self.Parent is TWxSizerPanel) then
       parentName:='this'
    else
       parentName:=self.Parent.name;

    strStyle:=GetSpinButtonSpecificStyle(self.Wx_GeneralStyle,Wx_SpinButtonStyle);

    Result:=Format('%s =  new %s(%s, %s,wxPoint(%d,%d),wxSize(%d,%d) %s );',[self.Name,self.Wx_Class,parentName,GetWxIDString(self.Wx_IDName,self.Wx_IDValue),self.Left,self.Top,self.width,self.Height,strStyle] );

    if trim(self.Wx_ToolTip) <> '' then
        Result:=Result + #13+Format('%s->SetToolTip(wxT("%s"));',[self.Name,self.Wx_ToolTip]);

    if self.Wx_Hidden then
        Result:=Result + #13+Format('%s->Show(false);',[self.Name]);

    if not Wx_Enabled then
        Result:=Result + #13+Format('%s->Enable(false);',[self.Name]);

    if trim(self.Wx_HelpText) <> '' then
        Result:=Result +#13+Format('%s->SetHelpText(_("%s"));',[self.Name,self.Wx_HelpText]);

   Result:=Result +#13+Format('%s->SetRange(%d,%d);',[self.Name,self.Min,self.Max]);
   Result:=Result +#13+Format('%s->SetValue(%d);',[self.Name,self.Position]);

    if(self.Parent is TWxSizerPanel) then
    begin
        strAlignment:=SizerAlignmentToStr(Wx_HorizontalAlignment) + ' | '+ SizerAlignmentToStr(Wx_VerticalAlignment) +' | wxALL';
        if wx_ControlOrientation = wxControlVertical then
            strAlignment:=SizerAlignmentToStr(Wx_HorizontalAlignment)+ ' | wxALL';

         if wx_ControlOrientation = wxControlHorizontal then
             strAlignment:=SizerAlignmentToStr(Wx_VerticalAlignment)+ ' | wxALL';


         Result:=Result +#13+Format('%s->Add(%s,%d,%s,%d);',[self.Parent.Name,self.Name,self.Wx_StrechFactor,strAlignment,self.Wx_Border]);
    end;

end;

function TWxSpinButton.GenerateGUIControlDeclaration:String;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     Result:='';
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxSpinButton.GenerateHeaderInclude:String;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     Result:='';
     Result:='#include <wx/spinbutt.h>';
end;

function TWxSpinButton.GenerateImageInclude: string;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin

end;

function TWxSpinButton.GetEventList:TStringlist;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
result:=FWx_EventList;
end;

function TWxSpinButton.GetIDName:String;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     Result:=wx_IDName;
end;

function TWxSpinButton.GetIDValue:LongInt;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     Result:=wx_IDValue;
end;

function TWxSpinButton.GetParameterFromEventName(EventName: string):String;
begin
if EventName = 'EVT_SPIN' then
begin
 Result:='wxSpinEvent& event';
 exit;
end;

if EventName = 'EVT_SPIN_UP' then
begin
 Result:='wxSpinEvent& event';
 exit;
end;

if EventName = 'EVT_SPIN_DOWN' then
begin
 Result:='wxSpinEvent& event';
 exit;
end;

if EventName = 'EVT_UPDATE_UI' then
begin
 Result:='wxUpdateUIEvent& event';
 exit;
end;
end;

function TWxSpinButton.GetPropertyList:TStringList;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     Result:=FWx_PropertyList;
end;

function TWxSpinButton.GetTypeFromEventName(EventName: string):string;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin

end;

function TWxSpinButton.GetWxClassName:String;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     if trim(wx_Class) = '' then
        wx_Class:='wxSpinButton';
     Result:=wx_Class;
end;

procedure TWxSpinButton.Loaded;
begin
     inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxSpinButton.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     wx_ControlOrientation:=ControlOrientation;
end;

procedure TWxSpinButton.SetIDName(IDName:String);
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     wx_IDName:=IDName;
end;

procedure TWxSpinButton.SetIDValue(IDValue:longInt);
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     Wx_IDValue:=IDVAlue;
end;

procedure TWxSpinButton.SetWxClassName(wxClassName:String);
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     wx_Class:=wxClassName;
end;


end.
