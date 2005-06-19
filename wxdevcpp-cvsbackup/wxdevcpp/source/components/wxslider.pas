{ ****************************************************************** }
{                                                                    }
{ $Id$                                                               }
{                                                                    }
{   VCL component TWxSlider                                          }
{                                                                    }
{   Code generated by Component Create for Delphi                    }
{                                                                    }
{   Generated from source file wxslider.cd }
{   on 10 Oct 2004 at 0:51                                           }
{                                                                    }
{   Copyright � 2003 by Guru Kathiresan                              }
{                                                                    }
{ ****************************************************************** }

unit WxSlider;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, 
     Forms, Graphics, Comctrls, Wxutils, ExtCtrls, WxSizerPanel,WxToolBar;

type
  TWxSlider = class(TTrackBar,IWxComponentInterface,IWxToolBarInsertableInterface,IWxToolBarNonInsertableInterface)
    private
      { Private fields of TWxSlider }
        { Storage for property EVT_COMMAND_SCROLL }
        FEVT_COMMAND_SCROLL : String;
        { Storage for property EVT_COMMAND_SCROLL_BOTTOM }
        FEVT_COMMAND_SCROLL_BOTTOM : String;
        { Storage for property EVT_COMMAND_SCROLL_ENDSCROLL }
        FEVT_COMMAND_SCROLL_ENDSCROLL : String;
        { Storage for property EVT_COMMAND_SCROLL_LINEDOWN }
        FEVT_COMMAND_SCROLL_LINEDOWN : String;
        { Storage for property EVT_COMMAND_SCROLL_LINEUP }
        FEVT_COMMAND_SCROLL_LINEUP : String;
        { Storage for property EVT_COMMAND_SCROLL_PAGEDOWN }
        FEVT_COMMAND_SCROLL_PAGEDOWN : String;
        { Storage for property EVT_COMMAND_SCROLL_PAGEUP }
        FEVT_COMMAND_SCROLL_PAGEUP : String;
        { Storage for property EVT_COMMAND_SCROLL_THUMBRELEASE }
        FEVT_COMMAND_SCROLL_THUMBRELEASE : String;
        { Storage for property EVT_COMMAND_SCROLL_THUMBTRACK }
        FEVT_COMMAND_SCROLL_THUMBTRACK : String;
        { Storage for property EVT_COMMAND_SCROLL_TOP }
        FEVT_COMMAND_SCROLL_TOP : String;
        { Storage for property EVT_SLIDER }
        FEVT_SLIDER : String;
        { Storage for property EVT_UPDATE_UI }
        FEVT_UPDATE_UI : String;
        { Storage for property Wx_BGColor }
        FWx_BGColor : TColor;
        { Storage for property Wx_Border }
        FWx_Border : Integer;
        { Storage for property Wx_Class }
        FWx_Class : String;
        { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation : TWxControlOrientation;
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
        FWx_Validator : String;
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
        { Storage for property Wx_SliderStyle }
        FWx_SliderStyle : TWxsldrStyleSet;
         { Storage for property Wx_SliderOrientation }
        FWx_SliderOrientation : TWx_SliderOrientation;
         { Storage for property TWx_SliderRange }
        FWx_SliderRange : TWx_SliderRange;
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
        FWx_Comments : TStrings;

      { Private methods of TWxSlider }
        { Method to set variable and property values and create objects }
        procedure AutoInitialize;
        { Method to free any objects created by AutoInitialize }
        procedure AutoDestroy;

    protected
      { Protected fields of TWxSlider }

      { Protected methods of TWxSlider }
        procedure KeyPress(var Key : Char); override;
        procedure Loaded; override;

    public
      { Public fields and properties of TWxSlider }
       defaultBGColor:TColor;	
       defaultFGColor:TColor;
      { Public methods of TWxSlider }
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
        function GetStretchFactor:integer;
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

    function GetSliderOrientation(value : TWx_SliderOrientation) : string;
    function GetSliderRange(value : TWx_SliderRange) : string;

    published
      { Published properties of TWxSlider }
        property OnKeyDown;
        property OnKeyPress;
        property OnKeyUp;
        property EVT_COMMAND_SCROLL : String
             read FEVT_COMMAND_SCROLL write FEVT_COMMAND_SCROLL;
        property EVT_COMMAND_SCROLL_BOTTOM : String
             read FEVT_COMMAND_SCROLL_BOTTOM write FEVT_COMMAND_SCROLL_BOTTOM;
        property EVT_COMMAND_SCROLL_ENDSCROLL : String
             read FEVT_COMMAND_SCROLL_ENDSCROLL write FEVT_COMMAND_SCROLL_ENDSCROLL;
        property EVT_COMMAND_SCROLL_LINEDOWN : String
             read FEVT_COMMAND_SCROLL_LINEDOWN write FEVT_COMMAND_SCROLL_LINEDOWN;
        property EVT_COMMAND_SCROLL_LINEUP : String
             read FEVT_COMMAND_SCROLL_LINEUP write FEVT_COMMAND_SCROLL_LINEUP;
        property EVT_COMMAND_SCROLL_PAGEDOWN : String
             read FEVT_COMMAND_SCROLL_PAGEDOWN write FEVT_COMMAND_SCROLL_PAGEDOWN;
        property EVT_COMMAND_SCROLL_PAGEUP : String
             read FEVT_COMMAND_SCROLL_PAGEUP write FEVT_COMMAND_SCROLL_PAGEUP;
        property EVT_COMMAND_SCROLL_THUMBRELEASE : String
             read FEVT_COMMAND_SCROLL_THUMBRELEASE write FEVT_COMMAND_SCROLL_THUMBRELEASE;
        property EVT_COMMAND_SCROLL_THUMBTRACK : String
             read FEVT_COMMAND_SCROLL_THUMBTRACK write FEVT_COMMAND_SCROLL_THUMBTRACK;
        property EVT_COMMAND_SCROLL_TOP : String
             read FEVT_COMMAND_SCROLL_TOP write FEVT_COMMAND_SCROLL_TOP;
        property EVT_SLIDER : String read FEVT_SLIDER write FEVT_SLIDER;
        property EVT_UPDATE_UI : String
             read FEVT_UPDATE_UI write FEVT_UPDATE_UI;
        property Wx_BGColor : TColor read FWx_BGColor write FWx_BGColor;
        property Wx_Border : Integer
             read FWx_Border write FWx_Border
             default 5;
        property Wx_Class : String read FWx_Class write FWx_Class;
        property Wx_Validator : String read FWx_Validator write FWx_Validator;
        property Wx_ControlOrientation : TWxControlOrientation
             read FWx_ControlOrientation write FWx_ControlOrientation;
        property Wx_Enabled : Boolean
             read FWx_Enabled write FWx_Enabled
             default True;
        property Wx_FGColor : TColor read FWx_FGColor write FWx_FGColor;
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
        property Wx_IDValue : Longint read FWx_IDValue write FWx_IDValue;
        property Wx_ProxyBGColorString : TWxColorString
             read FWx_ProxyBGColorString write FWx_ProxyBGColorString;
        property Wx_ProxyFGColorString : TWxColorString
             read FWx_ProxyFGColorString write FWx_ProxyFGColorString;
        property Wx_SliderStyle : TWxsldrStyleSet
             read FWx_SliderStyle write FWx_SliderStyle;
        property Wx_SliderOrientation : TWx_SliderOrientation
             read FWx_SliderOrientation  write FWx_SliderOrientation;
        property Wx_SliderRange : TWx_SliderRange
             read FWx_SliderRange  write FWx_SliderRange;
	property Wx_StrechFactor : Integer
		read FWx_StretchFactor write FWx_StretchFactor;

        property Wx_Comments : TStrings read FWx_Comments write FWx_Comments;

	property Wx_StretchFactor : Integer
             read FWx_StretchFactor write FWx_StretchFactor
             default 0;
        property Wx_ToolTip : String read FWx_ToolTip write FWx_ToolTip;
        property Wx_VerticalAlignment : TWxSizerVerticalAlignment
             read FWx_VerticalAlignment write FWx_VerticalAlignment
             default wxSZALIGN_CENTER_VERTICAL;
        property InvisibleBGColorString:String read FInvisibleBGColorString write FInvisibleBGColorString;
        property InvisibleFGColorString:String read FInvisibleFGColorString write FInvisibleFGColorString;

  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxSlider with wxWidgets as its
       default page on the Delphi component palette }
     RegisterComponents('wxWidgets', [TWxSlider]);
end;

{ Method to set variable and property values and create objects }
procedure TWxSlider.AutoInitialize;
begin
     FWx_EventList := TStringList.Create;
     FWx_PropertyList := TStringList.Create;
     FWx_Border := 5;
     FWx_Class := 'wxSlider';
     FWx_Enabled := True;
     FWx_Hidden := False;
     FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
     FWx_StretchFactor := 0;
     FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
     FWx_ProxyBGColorString := TWxColorString.Create;
     FWx_ProxyFGColorString := TWxColorString.Create;
     defaultBGColor:=self.color;
     defaultFGColor:=self.font.color;
     FWx_Comments := TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxSlider.AutoDestroy;
begin
     FWx_EventList.Free;
     FWx_PropertyList.Free;
end; { of AutoDestroy }

{ Override OnKeyPress handler from TTrackBar,IWxComponentInterface }
procedure TWxSlider.KeyPress(var Key : Char);
const
     TabKey = Char(VK_TAB);
     EnterKey = Char(VK_RETURN);
begin
     { Key contains the character produced by the keypress.
       It can be tested or assigned a new value before the
       call to the inherited KeyPress method.  Setting Key
       to #0 before call to the inherited KeyPress method
       terminates any further processing of the character. }

     { Activate KeyPress behavior of parent }
     inherited KeyPress(Key);

     { Code to execute after KeyPress behavior of parent }

end;

constructor TWxSlider.Create(AOwner: TComponent);
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
     FWx_PropertyList.add('Wx_SliderStyle:Slider Style');
     FWx_PropertyList.add('Min:Min');
     FWx_PropertyList.add('Max:Max');
     FWx_PropertyList.add('wx_Class:Base Class');
     FWx_PropertyList.add('Wx_Hidden :Hidden');
     FWx_PropertyList.add('Wx_Border : Border ');
     FWx_PropertyList.add('Wx_HelpText :HelpText ');
     FWx_PropertyList.add('Wx_IDName : IDName ');
     FWx_PropertyList.add('Wx_IDValue : IDValue ');
     FWx_PropertyList.add('Wx_ToolTip :ToolTip ');
     FWx_PropertyList.add('Caption : Caption ');
     FWx_PropertyList.add('Name : Name');
     FWx_PropertyList.add('Left : Left');
     FWx_PropertyList.add('Top : Top');
     FWx_PropertyList.add('Width : Width');
     FWx_PropertyList.add('Height:Height');

     FWx_PropertyList.Add('Wx_Validator : Validator code');
     FWx_PropertyList.add('Wx_ProxyBGColorString:Background Color');
     FWx_PropertyList.add('Wx_ProxyFGColorString:Foreground Color');

     FWx_PropertyList.add('Wx_GeneralStyle: General Styles');
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

     FWx_PropertyList.add('Wx_GeneralStyle: General Styles');
     FWx_PropertyList.Add('wxSL_AUTOTICKS:wxSL_AUTOTICKS');
     FWx_PropertyList.Add('wxSL_LABELS:wxSL_LABELS');
     FWx_PropertyList.Add('wxSL_LEFT:wxSL_LEFT');
     FWx_PropertyList.Add('wxSL_RIGHT:wxSL_RIGHT');
     FWx_PropertyList.Add('wxSL_TOP:wxSL_TOP');

     FWx_PropertyList.Add('Wx_SliderRange : Slider Style');

     FWx_PropertyList.add('Font : Font');

     FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
     FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');
     FWx_PropertyList.add('Wx_StretchFactor   : StretchFactor');
     FWx_PropertyList.add('Wx_SliderOrientation  : Orientation');

     FWx_PropertyList.add('Wx_Comments:Comments');

    FWx_EventList.add('EVT_COMMAND_SCROLL:OnScroll ');
    FWx_EventList.add('EVT_COMMAND_SCROLL_TOP:OnScrollTop ');
    FWx_EventList.add('EVT_COMMAND_SCROLL_BOTTOM:OnBottom ');
    FWx_EventList.add('EVT_COMMAND_SCROLL_LINEUP:OnLineUp ');
    FWx_EventList.add('EVT_COMMAND_SCROLL_LINEDOWN:OnLineDown ');
    FWx_EventList.add('EVT_COMMAND_SCROLL_PAGEUP:OnPageUp ');
    FWx_EventList.add('EVT_COMMAND_SCROLL_PAGEDOWN:OnPageDown ');
    FWx_EventList.add('EVT_COMMAND_SCROLL_THUMBTRACK:OnThumbtrack ');
    FWx_EventList.add('EVT_COMMAND_SCROLL_THUMBRELEASE:OnThumbRelease ');
    FWx_EventList.add('EVT_COMMAND_SCROLL_ENDSCROLL:OnEndScroll ');
    FWx_EventList.add('EVT_UPDATE_UI:OnUpdate ');

end;

destructor TWxSlider.Destroy;
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

function TWxSlider.GenerateEnumControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('%s = %d, ',[Wx_IDName,Wx_IDValue]);
end;

function TWxSlider.GenerateControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;

function TWxSlider.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';

     if trim(EVT_COMMAND_SCROLL) <> '' then
     begin
          Result:=Format('EVT_COMMAND_SCROLL(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_COMMAND_SCROLL]) +'';
     end;

     if trim(EVT_COMMAND_SCROLL_TOP) <> '' then
     begin
          Result:=Result+#13+Format('EVT_COMMAND_SCROLL_TOP(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_COMMAND_SCROLL_TOP]) +'';
     end;
     if trim(EVT_COMMAND_SCROLL_BOTTOM) <> '' then
     begin
          Result:=Result+#13+Format('EVT_COMMAND_SCROLL_BOTTOM(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_COMMAND_SCROLL_BOTTOM]) +'';
     end;

     if trim(EVT_COMMAND_SCROLL_LINEUP) <> '' then
     begin
          Result:=Result+#13+Format('EVT_COMMAND_SCROLL_LINEUP(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_COMMAND_SCROLL_LINEUP]) +'';
     end;
     if trim(EVT_COMMAND_SCROLL_LINEDOWN) <> '' then
     begin
          Result:=Result+#13+Format('EVT_COMMAND_SCROLL_LINEDOWN(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_COMMAND_SCROLL_LINEDOWN]) +'';
     end;

     if trim(EVT_COMMAND_SCROLL_PAGEUP) <> '' then
     begin
          Result:=Result+#13+Format('EVT_COMMAND_SCROLL_PAGEUP(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_COMMAND_SCROLL_PAGEUP]) +'';
     end;
     if trim(EVT_COMMAND_SCROLL_PAGEDOWN) <> '' then
     begin
          Result:=Result+#13+Format('EVT_COMMAND_SCROLL_PAGEDOWN(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_COMMAND_SCROLL_PAGEDOWN]) +'';
     end;

     if trim(EVT_COMMAND_SCROLL_THUMBTRACK) <> '' then
     begin
          Result:=Result+#13+Format('EVT_COMMAND_SCROLL_THUMBTRACK(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_COMMAND_SCROLL_THUMBTRACK]) +'';
     end;
     if trim(EVT_COMMAND_SCROLL_THUMBRELEASE) <> '' then
     begin
          Result:=Result+#13+Format('EVT_COMMAND_SCROLL_THUMBRELEASE(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_COMMAND_SCROLL_THUMBRELEASE]) +'';
     end;

     if trim(EVT_COMMAND_SCROLL_ENDSCROLL) <> '' then
     begin
          Result:=Result+#13+Format('EVT_COMMAND_SCROLL_ENDSCROLL(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_COMMAND_SCROLL_ENDSCROLL]) +'';
     end;

     if trim(EVT_UPDATE_UI) <> '' then
     begin
          Result:=Result+#13+Format('EVT_UPDATE_UI(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_UPDATE_UI]) +'';
     end;

end;


function TWxSlider.GenerateGUIControlCreation:String;


     var
     strColorStr:String;
     strStyle,parentName,strAlignment:String;
begin
     Result:='';

//    if (self.Parent is TForm) or (self.Parent is TWxSizerPanel) then
//       parentName:=GetWxWidgetParent(self)
//    else
//       parentName:=self.Parent.name;
 {   if self.Orientation = trHorizontal then
        Wx_SliderStyle:=Wx_SliderStyle + [wxSL_HORIZONTAL] - [wxSL_VERTICAL]
    else
        Wx_SliderStyle:=Wx_SliderStyle + [wxSL_VERTICAL] - [wxSL_HORIZONTAL];
  }

    parentName:=GetWxWidgetParent(self);

    strStyle := GetSliderSpecificStyle(self.Wx_GeneralStyle,Wx_SliderStyle);
    if (strStyle <> '') then
        strStyle:=GetSliderOrientation(Wx_SliderOrientation) +
            ' | ' + strStyle
    else
        strStyle:=GetSliderOrientation(Wx_SliderOrientation);

    strStyle := strStyle + GetSliderRange(Wx_SliderRange);

      if trim(self.FWx_Validator) <> '' then
      begin
       if trim(strStyle) <> '' then
           strStyle := strStyle + ', ' + self.Wx_Validator
       else
           strStyle := ', wxSL_HORIZONTAL, ' + self.Wx_Validator;
         strStyle := strStyle + ', ' + GetCppString(Name);

    end
    else
      if trim(strStyle) <> '' then
           strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
      else
           strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);

    Result:= GetCommentString(self.FWx_Comments.Text) + Format('%s = new %s(%s, %s, %d, %d, %d, wxPoint(%d,%d), wxSize(%d,%d)%s);',[self.Name,self.wx_Class,parentName,GetWxIDString(self.Wx_IDName,self.Wx_IDValue),self.position,self.Min,self.Max,self.Left,self.Top,self.width,self.Height,strStyle] );

    if trim(self.Wx_ToolTip) <> '' then
        Result:=Result + #13+Format('%s->SetToolTip(%s);',[self.Name,GetCppString(self.Wx_ToolTip)]);

    if self.Wx_Hidden then
        Result:=Result + #13+Format('%s->Show(false);',[self.Name]);

    if not Wx_Enabled then
        Result:=Result + #13+Format('%s->Enable(false);',[self.Name]);

    if trim(self.Wx_HelpText) <> '' then
        Result:=Result +#13+Format('%s->SetHelpText(%s);',[self.Name,GetCppString(self.Wx_HelpText)]);

   Result:=Result +#13+Format('%s->SetRange(%d,%d);',[self.Name,self.Min,self.Max]);
   Result:=Result +#13+Format('%s->SetValue(%d);',[self.Name,self.Position]);

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

function TWxSlider.GenerateGUIControlDeclaration:String;
begin
     Result:='';
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxSlider.GenerateHeaderInclude:String;
begin
     Result:='';
Result:='#include <wx/slider.h>';
end;

function TWxSlider.GenerateImageInclude: string;
begin

end;

function TWxSlider.GetEventList:TStringlist;
begin
     Result:=FWx_EventList;
end;

function TWxSlider.GetIDName:String;
begin
     Result:=wx_IDName;
end;

function TWxSlider.GetIDValue:LongInt;
begin
     Result:=wx_IDValue;
end;

function TWxSlider.GetParameterFromEventName(EventName: string):String;
begin
if EventName = 'EVT_SLIDER' then
begin
 Result:='wxScrollEvent& event';
 exit;
end;

if EventName = 'EVT_COMMAND_SCROLL' then
begin
 Result:='wxScrollEvent& event';
 exit;
end;

if EventName = 'EVT_COMMAND_SCROLL_TOP' then
begin
 Result:='wxScrollEvent& event';
 exit;
end;
if EventName = 'EVT_COMMAND_SCROLL_BOTTOM' then
begin
 Result:='wxScrollEvent& event';
 exit;
end;
if EventName = 'EVT_COMMAND_SCROLL_LINEUP' then
begin
 Result:='wxScrollEvent& event';
 exit;
end;
if EventName = 'EVT_COMMAND_SCROLL_LINEDOWN' then
begin
 Result:='wxScrollEvent& event';
 exit;
end;
if EventName = 'EVT_COMMAND_SCROLL_PAGEUP' then
begin
 Result:='wxScrollEvent& event';
 exit;
end;
if EventName = 'EVT_COMMAND_SCROLL_PAGEDOWN' then
begin
 Result:='wxScrollEvent& event';
 exit;
end;
if EventName = 'EVT_COMMAND_SCROLL_THUMBTRACK' then
begin
 Result:='wxScrollEvent& event';
 exit;
end;
if EventName = 'EVT_COMMAND_SCROLL_THUMBRELEASE' then
begin
 Result:='wxScrollEvent& event';
 exit;
end;
if EventName = 'EVT_COMMAND_SCROLL_ENDSCROLL' then
begin
 Result:='wxScrollEvent& event';
 exit;
end;
if EventName = 'EVT_UPDATE_UI' then
begin
 Result:='wxUpdateUIEvent& event';
 exit;
end;
end;

function TWxSlider.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxSlider.GetStretchFactor:integer;
begin
    result:=Wx_StretchFactor;
end;

function TWxSlider.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxSlider.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='wxSlider';
     Result:=wx_Class;
end;

procedure TWxSlider.Loaded;
begin
     inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxSlider.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
     wx_ControlOrientation:=ControlOrientation;
end;

procedure TWxSlider.SetIDName(IDName:String);
begin
     wx_IDName:=IDName;
end;

procedure TWxSlider.SetIDValue(IDValue:longInt);
begin
     Wx_IDValue:=IDVAlue;
end;

procedure TWxSlider.SetStretchFactor(intValue:Integer);
begin
    Wx_StretchFactor:=intValue;
end;

procedure TWxSlider.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxSlider.GetFGColor:string;
begin
   Result:=FInvisibleFGColorString;
end;

procedure TWxSlider.SetFGColor(strValue:String);
begin
    FInvisibleFGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Font.Color:=defaultFGColor
   else
	self.Font.Color:=GetColorFromString(strValue);
end;
    
function TWxSlider.GetBGColor:string;
begin
   Result:=FInvisibleBGColorString;
end;

procedure TWxSlider.SetBGColor(strValue:String);
begin
    FInvisibleBGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Color:=defaultBGColor
   else
	self.Color:=GetColorFromString(strValue);
end;
procedure TWxSlider.SetProxyFGColorString(value:String);
begin
    FInvisibleFGColorString:=value;
    self.Color:=GetColorFromString(value);
end;

procedure TWxSlider.SetProxyBGColorString(value:String);
begin
   FInvisibleBGColorString:=value;
   self.Font.Color:=GetColorFromString(value);
end;

function TWxSlider.GetSliderOrientation(value : TWx_SliderOrientation) : string;
begin
Result:='';
    if  value = wxSL_VERTICAL then
    begin
        Result:= ', wxSL_VERTICAL';
        self.Orientation := trVertical;
        exit;
    end;
     if  value = wxSL_HORIZONTAL then
    begin
        Result:= ', wxSL_HORIZONTAL';
        self.Orientation := trHorizontal;
        exit;
    end;

end;

function TWxSlider.GetSliderRange(value : TWx_SliderRange) : string;
begin
Result:='';
    if  value = wxSL_SELRANGE then
    begin
      Result := ' | wxSL_SELRANGE ';
      exit;
    end;

    if  value = wxSL_INVERSE then
    begin
      Result := ' | wxSL_INVERSE ';
      exit;
      end;
end;

end.
