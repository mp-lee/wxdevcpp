{ ****************************************************************** }
{                                                                    }
{   VCL component TWxSpinCtrl                                        }
{                                                                    }
{   Code generated by Component Create for Delphi                    }
{                                                                    }
{   Generated from source file e:\backup\delphi\demo\wxdevcpp\source\components\compcode\wxspinctl.cd }
{   on 18 July 2004 at 0:00                                          }
{                                                                    }
{   Copyright � 2003 by Guru Kathiresan                              }
{                                                                    }
{ ****************************************************************** }

unit wxspinctrl;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
     Forms, Graphics, Comctrls, WxUtils, ExtCtrls,Spin,WxToolBar;

type
  TWxSpinCtrl = class(TSpinEdit,IWxComponentInterface,IWxToolBarInsertableInterface,IWxToolBarNonInsertableInterface)
    private
      { Private fields of TWxSpinCtrl }
        { Storage for property ControlOrientation }
        FControlOrientation : TWxControlOrientation;
        { Storage for property EVT_SPINCTRL }
        FEVT_SPINCTRL : String;
        { Storage for property EVT_SPIN_DOWN }
        FEVT_SPIN_DOWN : String;
        { Storage for property EVT_SPIN_UP }
        FEVT_SPIN_UP : String;
        { Storage for property EVT_TEXT }
        FEVT_TEXT : String;
        { Storage for property EVT_UPDATE_UI }
        FEVT_UPDATE_UI : String;

        { Storage for property Wx_BGColor }
        FWx_BGColor : TColor;
        { Storage for property Wx_Border }
        FWx_Border : Integer;
        { Storage for property Wx_Class }
        FWx_Class : String;
        FWx_SpinButtonStyle : TWxsbtnStyleSet;
        { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation : TWxControlOrientation;
        { Storage for property Wx_DefaultItem }
        FWx_DefaultItem : Integer;
        { Storage for property Wx_Enabled }
        FWx_Enabled : Boolean;
        { Storage for property Wx_FGColor }
        FWx_FGColor : TColor;
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
        { Storage for property Wx_ProxyBGColorString }
        FWx_ProxyBGColorString : TWxColorString;
        { Storage for property Wx_ProxyFGColorString }
        FWx_ProxyFGColorString : TWxColorString;
        { Storage for property Wx_StretchFactor }
        FWx_StretchFactor : Integer;
        { Storage for property Wx_ToolTip }
        FWx_ToolTip : String;
        { Storage for property Wx_VerticalAlignment }
        FWx_VerticalAlignment : TWxSizerVerticalAlignment;
        FWx_EventList : TStringList;
        FWx_PropertyList : TStringList;
        FInvisibleBGColorString : String;
        FInvisibleFGColorString : String;
      { Private methods of TWxSpinCtrl }
        { Method to set variable and property values and create objects }
        procedure AutoInitialize;
        { Method to free any objects created by AutoInitialize }
        procedure AutoDestroy;

    protected
      { Protected fields of TWxSpinCtrl }

      { Protected methods of TWxSpinCtrl }
        procedure Loaded; override;

    public
      { Public fields and properties of TWxSpinCtrl }
      { Public fields and properties of TWxComboBox }
       defaultBGColor:TColor;	
       defaultFGColor:TColor;
      { Public methods of TWxComboBox }
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
      { Published properties of TWxSpinCtrl }
        property EVT_SPINCTRL : String read FEVT_SPINCTRL write FEVT_SPINCTRL;
        property EVT_SPIN_DOWN : String read FEVT_SPIN_DOWN write FEVT_SPIN_DOWN;
        property EVT_SPIN_UP : String read FEVT_SPIN_UP write FEVT_SPIN_UP;
        property EVT_TEXT : String read FEVT_TEXT write FEVT_TEXT;
        property EVT_UPDATE_UI : String read FEVT_UPDATE_UI write FEVT_UPDATE_UI;
        
        property Wx_BGColor : TColor read FWx_BGColor write FWx_BGColor;
        property Wx_Border : Integer read FWx_Border write FWx_Border default 5;
        property Wx_Class : String read FWx_Class write FWx_Class;
        property Wx_SpinButtonStyle : TWxsbtnStyleSet read FWx_SpinButtonStyle write FWx_SpinButtonStyle;
        property Wx_ControlOrientation : TWxControlOrientation read FWx_ControlOrientation write FWx_ControlOrientation;
        property Wx_DefaultItem : Integer read FWx_DefaultItem write FWx_DefaultItem default -1;
        property Wx_Enabled : Boolean read FWx_Enabled write FWx_Enabled default True;
        property Wx_FGColor : TColor read FWx_FGColor write FWx_FGColor;
        property Wx_GeneralStyle : TWxStdStyleSet read FWx_GeneralStyle write FWx_GeneralStyle;
        property Wx_HelpText : String read FWx_HelpText write FWx_HelpText;
        property Wx_Hidden : Boolean read FWx_Hidden write FWx_Hidden;
        property Wx_HorizontalAlignment : TWxSizerHorizontalAlignment read FWx_HorizontalAlignment write FWx_HorizontalAlignment default wxSZALIGN_CENTER_HORIZONTAL;
        property Wx_IDName : String read FWx_IDName write FWx_IDName;
        property Wx_IDValue : Longint read FWx_IDValue write FWx_IDValue default -1;
        property Wx_ProxyBGColorString : TWxColorString read FWx_ProxyBGColorString write FWx_ProxyBGColorString;
        property Wx_ProxyFGColorString : TWxColorString  read FWx_ProxyFGColorString write FWx_ProxyFGColorString;
	    property Wx_StrechFactor : Integer read FWx_StretchFactor write FWx_StretchFactor;
	    property Wx_StretchFactor : Integer read FWx_StretchFactor write FWx_StretchFactor default 0;
        property Wx_ToolTip : String read FWx_ToolTip write FWx_ToolTip;
        property Wx_VerticalAlignment : TWxSizerVerticalAlignment read FWx_VerticalAlignment write FWx_VerticalAlignment default wxSZALIGN_CENTER_VERTICAL;
        property InvisibleBGColorString:String read FInvisibleBGColorString write FInvisibleBGColorString;
        property InvisibleFGColorString:String read FInvisibleFGColorString write FInvisibleFGColorString;
        property MaxValue default 100;
  end;

procedure Register;

implementation

uses wxSizerPanel;

procedure Register;
begin
     { Register TWxSpinCtrl with wxWidgets as its
       default page on the Delphi component palette }
     RegisterComponents('wxWidgets', [TWxSpinCtrl]);
end;

{ Method to set variable and property values and create objects }
procedure TWxSpinCtrl.AutoInitialize;
begin
     FWx_EventList := TStringList.Create;
     FWx_PropertyList := TStringList.Create;
     FWx_Border := 5;
     FWx_Class := 'wxSpinCtrl';
     FWx_DefaultItem := -1;
     FWx_Enabled := True;
     FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
     FWx_IDValue := -1;
     FWx_StretchFactor := 0;
     FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
     FWx_ProxyBGColorString := TWxColorString.Create;
     FWx_ProxyFGColorString := TWxColorString.Create;
     defaultBGColor:=self.color;
     defaultFGColor:=self.font.color;
     MaxValue:=100;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxSpinCtrl.AutoDestroy;
begin
     FWx_EventList.Free;
     FWx_PropertyList.Free;
end; { of AutoDestroy }

constructor TWxSpinCtrl.Create(AOwner: TComponent);
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
     { Code to perform other tasks when the component is created }
     FWx_PropertyList.add('Wx_SpinButtonStyle:Spin Control Style');
     FWx_PropertyList.add('Items :Items');
     FWx_PropertyList.add('wx_Class:Base Class');
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

     FWx_PropertyList.add('Font : Font');

     FWx_PropertyList.add('MinValue:MinValue');
     FWx_PropertyList.add('MaxValue:MaxValue');
     FWx_PropertyList.add('Value:Value');

     FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
     FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');

     FWx_PropertyList.add('wxSP_ARROW_KEYS:wxSP_ARROW_KEYS');
     FWx_PropertyList.add('wxSP_WRAP:wxSP_WRAP');

     FWx_PropertyList.add('Wx_StretchFactor   : StretchFactor');

     FWx_EventList.add('EVT_SPINCTRL:OnSelected');
     FWx_EventList.add('EVT_TEXT:OnUpdated');
     FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

     FWx_EventList.add('EVT_SPIN_DOWN:OnSpinDown');
     FWx_EventList.add('EVT_SPIN_UP:OnSpinUp');

end;

destructor TWxSpinCtrl.Destroy;
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

procedure TWxSpinCtrl.Loaded;
begin
     inherited Loaded;
     { Perform any component setup that depends on the property
       values having been set }
end;


function TWxSpinCtrl.GenerateEnumControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('%s = %d , ',[Wx_IDName,Wx_IDValue]);
end;

function TWxSpinCtrl.GenerateControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;

function TWxSpinCtrl.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
     if trim(EVT_SPINCTRL) <> '' then
     begin
          Result:=Format('EVT_SPINCTRL(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_SPINCTRL]) +'';
     end;

     if trim(EVT_TEXT) <> '' then
     begin
          Result:=Result+#13+Format('EVT_TEXT(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_TEXT]) +'';
     end;

     if trim(EVT_UPDATE_UI) <> '' then
     begin
          Result:=Result+#13+Format('EVT_UPDATE_UI(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_UPDATE_UI]) +'';
     end;

     if trim(EVT_SPIN_DOWN) <> '' then
     begin
          Result:=Result+#13+Format('EVT_SPIN_DOWN(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_SPIN_DOWN]) +'';
     end;

     if trim(EVT_SPIN_UP) <> '' then
     begin
          Result:=Result+#13+Format('EVT_SPIN_UP(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_SPIN_UP]) +'';
     end;
end;

function TWxSpinCtrl.GenerateGUIControlCreation:String;
var
     strColorStr:String;
     i:Integer;
     strStyle,parentName,strAlignment:String;
begin

    parentName:=GetWxWidgetParent(self);

     Result:='';
    strStyle:=GetSpinButtonSpecificStyle(self.Wx_GeneralStyle,Wx_SpinButtonStyle);
    if strStyle = '' then
    begin
        strStyle:=', wxSP_ARROW_KEYS ';
    end;

    //Last comma is removed because it depends on the user selection of the properties.
    Result:=Format('%s =  new %s(%s, %s ,"%s" ,wxPoint(%d,%d),wxSize(%d,%d) %s ,%d,%d,%d);',[self.Name,self.Wx_Class,ParentName,GetWxIDString(self.Wx_IDName,self.Wx_IDValue),GetCppString(self.Caption),self.Left,self.Top,self.width,self.Height,strStyle,self.MinValue,Self.MaxValue,Value] );

    if trim(self.Wx_ToolTip) <> '' then
        Result:=Result + #13+Format('%s->SetToolTip(wxT(_("%s")));',[self.Name,GetCppString(self.Wx_ToolTip)]);

    if self.Wx_Hidden then
        Result:=Result + #13+Format('%s->Show(false);',[self.Name]);

    if not Wx_Enabled then
        Result:=Result + #13+Format('%s->Enable(false);',[self.Name]);

    if trim(self.Wx_HelpText) <> '' then
        Result:=Result +#13+Format('%s->SetHelpText(_("%s"));',[self.Name,GetCppString(self.Wx_HelpText)]);

    strColorStr:=trim(GetwxColorFromString(InvisibleFGColorString));
    if strColorStr <> '' then
	Result:=Result+#13+Format('%s->SetForegroundColour(%s);',[self.Name,strColorStr]);

    strColorStr:=trim(GetwxColorFromString(InvisibleBGColorString));
    if strColorStr <> '' then
	Result:=Result+#13+Format('%s->SetBackgroundColour(%s);',[self.Name,strColorStr]);


    strColorStr:=GetWxFontDeclaration(self.Font);
    if strColorStr <> '' then
	Result:=Result+#13+Format('%s->SetFont(%s);',[self.Name,strColorStr]);

    if(self.Parent is TWxSizerPanel) then
    begin
        strAlignment:=SizerAlignmentToStr(Wx_HorizontalAlignment) + ' | '+ SizerAlignmentToStr(Wx_VerticalAlignment) +' | wxALL';
        if wx_ControlOrientation = wxControlVertical then
            strAlignment:=SizerAlignmentToStr(Wx_HorizontalAlignment)+ ' | wxALL';

         if wx_ControlOrientation = wxControlHorizontal then
             strAlignment:=SizerAlignmentToStr(Wx_VerticalAlignment)+ ' | wxALL';


         Result:=Result +#13+Format('%s->Add(%s,%d,%s,%d);',[self.Parent.Name,self.Name,self.Wx_StretchFactor,strAlignment,self.Wx_Border]);
    end;
    if(self.Parent is TWxToolBar) then
    begin
        Result:=Result +#13+Format('%s->AddControl(%s);',[self.Parent.Name,self.Name]);
    end;
    
end;

function TWxSpinCtrl.GenerateGUIControlDeclaration:String;
begin
     Result:='';
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxSpinCtrl.GenerateHeaderInclude:String;
begin
     Result:='';
Result:='#include <wx/spinctrl.h>';
end;

function TWxSpinCtrl.GenerateImageInclude: string;
begin

end;

function TWxSpinCtrl.GetEventList:TStringlist;
begin
     Result:=FWx_EventList;
end;

function TWxSpinCtrl.GetIDName:String;
begin
     Result:='';
     Result:=wx_IDName;
end;

function TWxSpinCtrl.GetIDValue:LongInt;
begin
     Result:=wx_IDValue;
end;

function TWxSpinCtrl.GetParameterFromEventName(EventName: string):String;
begin
    if EventName = 'EVT_SPINCTRL' then
    begin
         Result:='wxSpinEvent& event ';
         exit;
    end;
    if EventName = 'EVT_TEXT' then
    begin
        Result:='wxCommandEvent& event ';
        exit;
    end;
    
    if EventName = 'EVT_UPDATE_UI' then
    begin
        Result:='wxUpdateUIEvent& event';
        exit;
    end;
    if EventName = 'EVT_SPIN_DOWN' then
    begin
        Result:='wxSpinEvent& event ';
        exit;
    end;
    if EventName = 'EVT_SPIN_UP' then
    begin
        Result:='wxSpinEvent& event';
        exit;
    end;
end;

function TWxSpinCtrl.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxSpinCtrl.GetStretchFactor:Integer;
begin
    result:=Wx_StretchFactor;
end;

function TWxSpinCtrl.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxSpinCtrl.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='wxSpinCtrl';
     Result:=wx_Class;
end;

procedure TWxSpinCtrl.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
    wx_ControlOrientation:=ControlOrientation;
end;

procedure TWxSpinCtrl.SetIDName(IDName:String);
begin
     wx_IDName:=IDName;
end;

procedure TWxSpinCtrl.SetIDValue(IDValue:longInt);
begin
     Wx_IDValue:=IDVAlue;
end;

procedure TWxSpinCtrl.SetStretchFactor(intValue:Integer);
begin
    Wx_StretchFactor:=intValue;
end;

procedure TWxSpinCtrl.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxSpinCtrl.GetFGColor:string;
begin
   Result:=FInvisibleFGColorString;
end;

procedure TWxSpinCtrl.SetFGColor(strValue:String);
begin
    FInvisibleFGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Font.Color:=defaultFGColor
   else
	self.Font.Color:=GetColorFromString(strValue);
end;

function TWxSpinCtrl.GetBGColor:string;
begin
   Result:=FInvisibleBGColorString;
end;

procedure TWxSpinCtrl.SetBGColor(strValue:String);
begin
    FInvisibleBGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Color:=defaultBGColor
   else
	self.Color:=GetColorFromString(strValue);
end;
procedure TWxSpinCtrl.SetProxyFGColorString(value:String);
begin
    FInvisibleFGColorString:=value;
    self.Color:=GetColorFromString(value);
end;

procedure TWxSpinCtrl.SetProxyBGColorString(value:String);
begin
   FInvisibleBGColorString:=value;
   self.Font.Color:=GetColorFromString(value);
end;



end.
