{ ****************************************************************** }
{                                                                    }
{   VCL component TWxListBox                                         }
{                                                                    }
{   Code generated by Component Create for Delphi                    }
{                                                                    }
{   Generated from source file e:\backup\delphi\demo\wxdevcpp\source\compon~1\compcode\wxlist~1.cd }
{   on 13 Oct 2004 at 23:12                                          }
{                                                                    }
{   Copyright � 2003 by Guru Kathiresan                              }
{                                                                    }
{ ****************************************************************** }

unit WxCheckListBox;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, 
     Forms, Graphics, Stdctrls, WxUtils, CheckLst,ExtCtrls, WxSizerPanel;

type
  TWxCheckListBox = class(TCheckListBox,IWxComponentInterface)
    private
      { Private fields of TWxListBox }
        FEVT_CHECKLISTBOX : String;
        FEVT_LISTBOX : String;
        FEVT_LISTBOX_DCLICK : String;
        FEVT_UPDATE_UI : String;
        FWx_BGColor : TColor;
        FWx_Border : Integer;
        FWx_Class : String;
        FWx_ControlOrientation : TWxControlOrientation;
        FWx_Enabled : Boolean;
        FWx_FGColor : TColor;
        FWx_GeneralStyle : TWxStdStyleSet;
        FWx_HelpText : String;
        FWx_Hidden : Boolean;
        FWx_HorizontalAlignment : TWxSizerHorizontalAlignment;
        FWx_IDName : String;
        FWx_IDValue : Longint;
        FWx_ListboxStyle : TWxLBxStyleSet;
        FWx_ProxyBGColorString : TWxColorString;
        FWx_ProxyFGColorString : TWxColorString;
        FWx_StrechFactor : Integer;
        FWx_StretchFactor : Integer;
        FWx_ToolTip : String;
        FWx_VerticalAlignment : TWxSizerVerticalAlignment;
        FWx_EventList : TStringList;
        FWx_PropertyList : TStringList;

        FInvisibleBGColorString : String;
        FInvisibleFGColorString : String;

      { Private methods of TWxListBox }
        procedure AutoInitialize;
        procedure AutoDestroy;

    protected
      { Protected fields of TWxListBox }

      { Protected methods of TWxListBox }
        procedure Click; override;
        procedure KeyPress(var Key : Char); override;
        procedure Loaded; override;

    public
      { Public fields and properties of TWxListBox }
       defaultBGColor:TColor;	
       defaultFGColor:TColor;
       
      { Public methods of TWxListBox }
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
      { Published properties of TWxListBox }
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
        property EVT_LISTBOX : String read FEVT_LISTBOX write FEVT_LISTBOX;
        property EVT_CHECKLISTBOX : String read FEVT_CHECKLISTBOX write FEVT_CHECKLISTBOX;
        property EVT_LISTBOX_DCLICK : String read FEVT_LISTBOX_DCLICK write FEVT_LISTBOX_DCLICK;
        property EVT_UPDATE_UI : String read FEVT_UPDATE_UI write FEVT_UPDATE_UI;
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
        property Wx_Hidden : Boolean read FWx_Hidden write FWx_Hidden;
        property Wx_HorizontalAlignment : TWxSizerHorizontalAlignment
             read FWx_HorizontalAlignment write FWx_HorizontalAlignment
             default wxSZALIGN_CENTER_HORIZONTAL;
        property Wx_IDName : String read FWx_IDName write FWx_IDName;
        property Wx_IDValue : Longint
             read FWx_IDValue write FWx_IDValue
             default -1;
        property Wx_ListboxStyle : TWxLBxStyleSet
             read FWx_ListboxStyle write FWx_ListboxStyle;
        property Wx_ProxyBGColorString : TWxColorString
             read FWx_ProxyBGColorString write FWx_ProxyBGColorString;
        property Wx_ProxyFGColorString : TWxColorString
             read FWx_ProxyFGColorString write FWx_ProxyFGColorString;
        property Wx_StrechFactor : Integer
             read FWx_StrechFactor write FWx_StrechFactor;
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
     { Register TWxListBox with wxWidgets as its
       default page on the Delphi component palette }
     RegisterComponents('wxWidgets', [TWxCheckListBox]);
end;

{ Method to set variable and property values and create objects }
procedure TWxCheckListBox.AutoInitialize;
begin
     FWx_EventList := TStringList.Create;
     FWx_PropertyList := TStringList.Create;
     FWx_Border := 5;
     FWx_Class := 'wxCheckListBox';
     FWx_Enabled := True;
     FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
     FWx_IDValue := -1;
     FWx_StretchFactor := 0;
     FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxCheckListBox.AutoDestroy;
begin
     FWx_EventList.Free;
     FWx_PropertyList.Free;
end; { of AutoDestroy }

{ Override OnClick handler from TListBox,IWxComponentInterface }
procedure TWxCheckListBox.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

     { Activate click behavior of parent }
     inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TListBox,IWxComponentInterface }
procedure TWxCheckListBox.KeyPress(var Key : Char);
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

constructor TWxCheckListBox.Create(AOwner: TComponent);
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
     FWx_PropertyList.add('Items :Strings');
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

     FWx_PropertyList.add('Font : Font');
     FWx_PropertyList.add('Checked : Checked');

     FWx_PropertyList.add('Wx_ListboxStyle:Listbox Style');
     FWx_PropertyList.add('wxLB_SINGLE:wxLB_SINGLE');
     FWx_PropertyList.add('wxLB_MULTIPLE:wxLB_MULTIPLE');
     FWx_PropertyList.add('wxLB_EXTENDED:wxLB_EXTENDED');
     FWx_PropertyList.add('wxLB_HSCROLL:wxLB_HSCROLL');
     FWx_PropertyList.add('wxLB_ALWAYS_SB:wxLB_ALWAYS_SB');
     FWx_PropertyList.add('wxLB_NEEDED_SB:wxLB_NEEDED_SB');
     FWx_PropertyList.add('wxLB_SORT:wxLB_SORT');


     FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
     FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');


     FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

     FWx_EventList.add('EVT_CHECKLISTBOX:OnCheckListBox');
     FWx_EventList.add('EVT_LISTBOX:OnEnter');
     FWx_EventList.add('EVT_TEXT:OnSelected');
     FWx_EventList.add('EVT_LISTBOX_DCLICK:OnDoubleClicked');

end;

destructor TWxCheckListBox.Destroy;
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


function TWxCheckListBox.GenerateEnumControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('%s = %d , ',[Wx_IDName,Wx_IDValue]);
end;

function TWxCheckListBox.GenerateControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;


function TWxCheckListBox.GenerateEventTableEntries(CurrClassName:String):String;
begin

     Result:='';

     if trim(EVT_CHECKLISTBOX) <> '' then
     begin
          Result:=Format('EVT_CHECKLISTBOX(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_CHECKLISTBOX]) +'';
     end;


     if trim(EVT_LISTBOX) <> '' then
     begin
          Result:=Format('EVT_LISTBOX(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_LISTBOX]) +'';
     end;

     if trim(EVT_UPDATE_UI) <> '' then
     begin
          Result:=Result+#13+Format('EVT_UPDATE_UI(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_UPDATE_UI]) +'';
     end;

     if trim(EVT_LISTBOX_DCLICK) <> '' then
     begin
          Result:=Result+#13+Format('EVT_LISTBOX_DCLICK(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_LISTBOX_DCLICK]) +'';
     end;

end;

function TWxCheckListBox.GenerateGUIControlCreation:String;
var
    i:Integer;
    strStyle,parentName,strAlignment:String;
    strColorStr:String;
begin
     Result:='';

    parentName:=GetWxWidgetParent(self);

    strStyle:=GetListBoxSpecificStyle(self.Wx_GeneralStyle,Wx_ListboxStyle);

    Result:=Format('%s =  new %s(%s, %s ,wxPoint(%d,%d),wxSize(%d,%d), (wxArrayString)NULL %s );',[self.Name,self.Wx_Class,parentName,GetWxIDString(self.Wx_IDName,self.Wx_IDValue),self.Left,self.Top,self.width,self.Height,strStyle] );

    if trim(self.Wx_ToolTip) <> '' then
        Result:=Result + #13+Format('%s->SetToolTip(wxT(_("%s")));',[self.Name,GetCppString(self.Wx_ToolTip)]);

    if self.Wx_Hidden then
        Result:=Result + #13+Format('%s->Show(false);',[self.Name]);

    if not Wx_Enabled then
        Result:=Result + #13+Format('%s->Enable(false);',[self.Name]);

    if trim(self.Wx_HelpText) <> '' then
        Result:=Result +#13+Format('%s->SetHelpText(_("%s"));',[self.Name,GetCppString(self.Wx_HelpText)]);

    for i:= 0 to self.Items.count -1 Do
        Result:=Result +#13+Format('%s->Append(_("%s"));',[self.Name,GetCppString(self.Items[i])]);

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


         Result:=Result +#13+Format('%s->Add(%s,%d,%s,%d);',[self.Parent.Name,self.Name,self.Wx_StrechFactor,strAlignment,self.Wx_Border]);
    end;

end;

function TWxCheckListBox.GenerateGUIControlDeclaration:String;
begin
     Result:='';
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxCheckListBox.GenerateHeaderInclude:String;
begin
     Result:='';
Result:='#include <wx/checklst.h>';

end;

function TWxCheckListBox.GenerateImageInclude: string;
begin

end;

function TWxCheckListBox.GetEventList:TStringlist;
begin
     Result:=FWx_EventList;
end;

function TWxCheckListBox.GetIDName:String;
begin
     Result:=wx_IDName;
end;

function TWxCheckListBox.GetIDValue:LongInt;
begin
     Result:=wx_IDValue;
end;

function TWxCheckListBox.GetParameterFromEventName(EventName: string):String;
begin
     if EventName = 'EVT_CHECKLISTBOX' then
     begin
          Result:='wxCommandEvent& event';
          exit;
     end;

     if EventName = 'EVT_LISTBOX' then
     begin
          Result:='wxCommandEvent& event';
          exit;
     end;

     if EventName = 'EVT_UPDATE_UI' then
     begin
        Result:='wxUpdateUIEvent& event';
        exit;
     end;

     if EventName = 'EVT_LISTBOX_DCLICK' then
     begin
          Result:='wxCommandEvent& event';
          exit;
     end;

end;

function TWxCheckListBox.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxCheckListBox.GetStretchFactor:Integer;
begin

end;

function TWxCheckListBox.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxCheckListBox.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='wxCheckListBox';
     Result:=wx_Class;
end;

procedure TWxCheckListBox.Loaded;
begin
     inherited Loaded;
     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxCheckListBox.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
wx_ControlOrientation:=ControlOrientation;
end;

procedure TWxCheckListBox.SetIDName(IDName:String);
begin
     wx_IDName:=IDName;
end;

procedure TWxCheckListBox.SetIDValue(IDValue:longInt);
begin
     Wx_IDValue:=IDVAlue;
end;

procedure TWxCheckListBox.SetStretchFactor(intValue:Integer);
begin

end;

procedure TWxCheckListBox.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxCheckListBox.GetFGColor:string;
begin
   Result:=FInvisibleFGColorString;
end;

procedure TWxCheckListBox.SetFGColor(strValue:String);
begin
    FInvisibleFGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Font.Color:=defaultFGColor
   else
	self.Font.Color:=GetColorFromString(strValue);
end;

function TWxCheckListBox.GetBGColor:string;
begin
   Result:=FInvisibleBGColorString;
end;

procedure TWxCheckListBox.SetBGColor(strValue:String);
begin
    FInvisibleBGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Color:=defaultBGColor
   else
	self.Color:=GetColorFromString(strValue);
end;
procedure TWxCheckListBox.SetProxyFGColorString(value:String);
begin
    FInvisibleFGColorString:=value;
    self.Color:=GetColorFromString(value);
end;

procedure TWxCheckListBox.SetProxyBGColorString(value:String);
begin
   FInvisibleBGColorString:=value;
   self.Font.Color:=GetColorFromString(value);
end;

end.
