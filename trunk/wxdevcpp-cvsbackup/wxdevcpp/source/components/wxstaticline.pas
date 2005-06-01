{ ****************************************************************** }
{                                                                    }
{ $Id$                                                               }
{                                                                    }
{   VCL component TWxStaticLine                                      }
{                                                                    }
{   Code generated by Component Create for Delphi                    }
{                                                                    }
{   Generated from source file wxstaticbox.cd }
{   on 10 Oct 2004 at 0:51                                           }
{                                                                    }
{   Copyright � 2003 by Guru Kathiresan                              }
{                                                                    }
{ ****************************************************************** }

unit wxstaticline;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, 
     Forms, Graphics, Stdctrls, Wxutils, ExtCtrls, WxSizerPanel;

type
  TWxStaticLine = class(TRadioGroup,IWxComponentInterface)
    private
      { Private fields of TWxStaticLine }
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
        FWx_Length : Integer;

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
        FWx_PropertyList : TStringList;
        FInvisibleBGColorString : String;
        FInvisibleFGColorString : String;
        FWx_LIOrientation : TWx_LIOrientation;
        FWx_Comments : TStrings;
      { Private methods of TWxStaticLine }
        { Method to set variable and property values and create objects }
        procedure AutoInitialize;
        { Method to free any objects created by AutoInitialize }
        procedure AutoDestroy;

    protected
      { Protected fields of TWxStaticLine }

      { Protected methods of TWxStaticLine }
        procedure Click; override;
        procedure KeyPress(var Key : Char); override;
        procedure Loaded; override;
        procedure Paint; override;

    public
      { Public fields and properties of TWxStaticLine }
       defaultBGColor:TColor;	
       defaultFGColor:TColor;
      { Public methods of TWxStaticLine }
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

   function GetLineOrientation(value : TWx_LIOrientation) : string;

        procedure WMSizeX(var Message: TWMSize); message WM_PAINT;
    published
      { Published properties of TWxStaticLine }
        property OnClick;
        property OnDblClick;
        property OnDragDrop;
        property OnEnter;
        property OnExit;
        property OnKeyDown;
        property OnKeyPress;
        property OnKeyUp;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property Wx_BGColor : TColor read FWx_BGColor write FWx_BGColor;
        property Wx_Border : Integer
             read FWx_Border write FWx_Border
             default 5;
        property Wx_Class : String read FWx_Class write FWx_Class;
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
        property Wx_Comments : TStrings read FWx_Comments write FWx_Comments;
        property Wx_HorizontalAlignment : TWxSizerHorizontalAlignment
             read FWx_HorizontalAlignment write FWx_HorizontalAlignment
             default wxSZALIGN_CENTER_HORIZONTAL;
        property Wx_IDName : String read FWx_IDName write FWx_IDName;
        property Wx_IDValue : Longint read FWx_IDValue write FWx_IDValue;
        property Wx_ProxyBGColorString : TWxColorString
             read FWx_ProxyBGColorString write FWx_ProxyBGColorString;
        property Wx_ProxyFGColorString : TWxColorString
             read FWx_ProxyFGColorString write FWx_ProxyFGColorString;

	property Wx_StrechFactor : Integer
		read FWx_StretchFactor write FWx_StretchFactor;
		
	property Wx_StretchFactor : Integer
             read FWx_StretchFactor write FWx_StretchFactor
             default 0;
        property Wx_ToolTip : String read FWx_ToolTip write FWx_ToolTip;
        property Wx_VerticalAlignment : TWxSizerVerticalAlignment
             read FWx_VerticalAlignment write FWx_VerticalAlignment
             default wxSZALIGN_CENTER_VERTICAL;
        property InvisibleBGColorString:String read FInvisibleBGColorString write FInvisibleBGColorString;
        property InvisibleFGColorString:String read FInvisibleFGColorString write FInvisibleFGColorString;
        property Wx_LIOrientation : TWx_LIOrientation read FWx_LIOrientation write FWx_LIOrientation;

        property Wx_Length : Integer read FWx_Length write FWx_Length;
  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxStaticLine with wxWidgets as its
       default page on the Delphi component palette }
     RegisterComponents('wxWidgets', [TWxStaticLine]);
end;

{ Method to set variable and property values and create objects }
procedure TWxStaticLine.AutoInitialize;
begin
     FWx_Length := 150;
     FWx_PropertyList := TStringList.Create;
     FWx_Border := 5;
     FWx_Class := 'wxStaticLine';
     FWx_Enabled := True;
     FWx_Hidden := False;
     FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
     FWx_StretchFactor := 0;
      FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
     FWx_ProxyBGColorString := TWxColorString.Create;
     FWx_ProxyFGColorString := TWxColorString.Create;
     defaultBGColor:=clBtnFace;
     defaultFGColor:=self.font.color;
     FWx_Comments := TStringList.Create;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxStaticLine.AutoDestroy;
begin
     FWx_PropertyList.Free;
end; { of AutoDestroy }

{ Override OnClick handler from TRadioGroup,IWxComponentInterface }
procedure TWxStaticLine.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

     { Activate click behavior of parent }
     inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TRadioGroup,IWxComponentInterface }
procedure TWxStaticLine.KeyPress(var Key : Char);
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

constructor TWxStaticLine.Create(AOwner: TComponent);
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
    // FWx_PropertyList.add('Width:Width');
    // FWx_PropertyList.add('Height:Height');
      FWx_PropertyList.add('Wx_Length:Length');

     FWx_PropertyList.add('Wx_Comments:Comments');

     FWx_PropertyList.add('Wx_ProxyBGColorString:Background Color');
     FWx_PropertyList.add('Wx_ProxyFGColorString:Foreground Color');

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

     FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
     FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');

     FWx_PropertyList.add('Wx_LIOrientation:Orientation');
     FWx_PropertyList.add('Font : Font');
     FWx_PropertyList.add('Wx_StretchFactor   : StretchFactor');
     self.Caption:='';

end;

destructor TWxStaticLine.Destroy;
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


function TWxStaticLine.GenerateEnumControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('%s = %d, ',[Wx_IDName,Wx_IDValue]);
end;

function TWxStaticLine.GenerateControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;

function TWxStaticLine.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
end;

function TWxStaticLine.GenerateGUIControlCreation:String;


     var
     strColorStr:String;
     strStyle,parentName,strAlignment:String;
begin
     Result:='';

//    if (self.Parent is TForm) or (self.Parent is TWxSizerPanel) then
//       parentName:=GetWxWidgetParent(self)
//    else
//       parentName:=self.Parent.name;

    parentName:=GetWxWidgetParent(self);

    strStyle:= GetStdStyleString(self.Wx_GeneralStyle);

    if (strStyle <> '') then
        strStyle := GetLineOrientation(FWx_LIOrientation) + ' | ' + strStyle
    else
         strStyle :=  GetLineOrientation(FWx_LIOrientation);

  if (FWx_LIOrientation = wxLI_HORIZONTAL) then
        Result:= GetCommentString(self.FWx_Comments.Text) + Format('%s = new %s(%s, %s, wxPoint(%d,%d), wxSize(%d,%d)%s);',[self.Name,self.wx_Class,parentName,GetWxIDString(self.Wx_IDName,self.Wx_IDValue),self.Left,self.Top,FWx_Length,0,strStyle])
  else
     Result:= GetCommentString(self.FWx_Comments.Text) + Format('%s = new %s(%s, %s, wxPoint(%d,%d), wxSize(%d,%d)%s);',[self.Name,self.wx_Class,parentName,GetWxIDString(self.Wx_IDName,self.Wx_IDValue),self.Left,self.Top,0,FWx_Length,strStyle] );

    if trim(self.Wx_ToolTip) <> '' then
        Result:=Result + #13+Format('%s->SetToolTip(%s);',[self.Name,GetCppString(self.Wx_ToolTip)]);

    if self.Wx_Hidden then
        Result:=Result + #13+Format('%s->Show(false);',[self.Name]);

    if not Wx_Enabled then
        Result:=Result + #13+Format('%s->Enable(false);',[self.Name]);

    if trim(self.Wx_HelpText) <> '' then
        Result:=Result +#13+Format('%s->SetHelpText(%s);',[self.Name,GetCppString(self.Wx_HelpText)]);

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

end;

function TWxStaticLine.GenerateGUIControlDeclaration:String;
begin
     Result:='';
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxStaticLine.GenerateHeaderInclude:String;
begin
     Result:='';
     Result:='#include <wx/statline.h>';
end;

function TWxStaticLine.GenerateImageInclude: string;
begin

end;

function TWxStaticLine.GetEventList:TStringlist;
begin
Result:=nil;
end;

function TWxStaticLine.GetIDName:String;
begin
     Result:=wx_IDName;
end;

function TWxStaticLine.GetIDValue:LongInt;
begin
     Result:=wx_IDValue;
end;

function TWxStaticLine.GetParameterFromEventName(EventName: string):String;
begin

end;

function TWxStaticLine.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxStaticLine.GetStretchFactor:Integer;
begin
    result:=Wx_StretchFactor;
end;

function TWxStaticLine.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxStaticLine.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='wxStaticLine';
     Result:=wx_Class;
end;

procedure TWxStaticLine.Loaded;
begin
     inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxStaticLine.Paint;
begin
     { Make this component look like its parent component by calling
       its parent's Paint method. }
     inherited Paint;

     { To change the appearance of the component, use the methods
       supplied by the component's Canvas property (which is of
       type TCanvas).  For example, }

     { Canvas.Rectangle(0, 0, Width, Height); }
end;

procedure TWxStaticLine.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
     wx_ControlOrientation:=ControlOrientation;
end;

procedure TWxStaticLine.SetIDName(IDName:String);
begin
     wx_IDName:=IDName;
end;

procedure TWxStaticLine.SetIDValue(IDValue:longInt);
begin
     Wx_IDValue:=IDVAlue;
end;

procedure TWxStaticLine.SetStretchFactor(intValue:Integer);
begin
    Wx_StretchFactor:=intValue;
end;

procedure TWxStaticLine.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

procedure TWxStaticLine.WMSizeX(var Message: TWMSize);
var
     W, H: Integer;
begin
     inherited;
     Caption:='';

     if (FWx_LIOrientation = wxLI_HORIZONTAL) then
      begin
        { Copy the new width and height of the component
        so we can use SetBounds to change both at once }
        W := Width;
        FWx_Length := Width;
        { Code to check and adjust W and H }
        H := 7;
      end
     else
        begin
          W := 3;
          H := Height;
          FWx_Length := Height;
        end;

     { Update the component size if we adjusted W or H }
     if (W <> Width) or (H <> Height) then
         inherited SetBounds(Left, Top, W, H);

     { Code to update dimensions of any owned sub-components
       by reading their Height and Width properties and updating
       via their SetBounds methods }

     Message.Result := 0;
end;
function TWxStaticLine.GetFGColor:string;
begin
   Result:=FInvisibleFGColorString;
end;

procedure TWxStaticLine.SetFGColor(strValue:String);
begin
    FInvisibleFGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Font.Color:=defaultFGColor
   else
	self.Font.Color:=GetColorFromString(strValue);
end;

function TWxStaticLine.GetBGColor:string;
begin
   Result:=FInvisibleBGColorString;
end;

procedure TWxStaticLine.SetBGColor(strValue:String);
begin
    FInvisibleBGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Color:=defaultBGColor
   else
	self.Color:=GetColorFromString(strValue);
end;
procedure TWxStaticLine.SetProxyFGColorString(value:String);
begin
    FInvisibleFGColorString:=value;
    self.Color:=GetColorFromString(value);
end;

procedure TWxStaticLine.SetProxyBGColorString(value:String);
begin
   FInvisibleBGColorString:=value;
   self.Font.Color:=GetColorFromString(value);
end;

function TWxStaticLine.GetLineOrientation(value : TWx_LIOrientation) : string;
begin
Result:='';
    if  value = wxLI_VERTICAL then
      begin
        Result:= ', wxLI_VERTICAL';
      end;
    if  value = wxLI_HORIZONTAL then
      begin
        Result:= ', wxLI_HORIZONTAL';
      end;

end;

end.
