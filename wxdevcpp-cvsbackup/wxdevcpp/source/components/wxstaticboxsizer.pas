{ ****************************************************************** }
{                                                                    }
{   VCL component TWxStaticBoxSizer                                  }
{                                                                    }
{   Code generated by Component Create for Delphi                    }
{                                                                    }
{   Generated from source file e:\backup\delphi\demo\wxdevcpp\source\components\compcode\wxstaticboxsizer.cd }
{   on 10 Oct 2004 at 0:51                                           }
{                                                                    }
{   Copyright � 2004 by Guru Kathiresan                              }
{                                                                    }
{ ****************************************************************** }

unit WXStaticBoxSizer;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, 
     Forms, Graphics, Extctrls, WxUtils, WxSizerPanel;

type
  TWxStaticBoxSizer = class(TWxSizerPanel,IWxComponentInterface)
    private
      { Private fields of TWxStaticBoxSizer }
        { Storage for property Orientation }
        FOrientation : TWxSizerOrientation;
        { Storage for property SpaceValue }
        FSpaceValue : Integer;
        { Storage for property Wx_Caption }
        FWx_Caption : String;
        { Storage for property Wx_Class }
        FWx_Class : String;
        { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation : TWxControlOrientation;
        { Storage for property Wx_EventList }
        FWx_EventList : TStringList;
        { Storage for property Wx_HorizontalAlignment }
        FWx_HorizontalAlignment : TWxSizerHorizontalAlignment;
        { Storage for property Wx_IDName }
        FWx_IDName : String;
        { Storage for property Wx_IDValue }
        FWx_IDValue : Integer;
        { Storage for property Wx_StretchFactor }
        FWx_StretchFactor : Integer;
        { Storage for property Wx_VerticalAlignment }
        FWx_VerticalAlignment : TWxSizerVerticalAlignment;
        FWx_PropertyList : TStringList;
        FInvisibleBGColorString : String;
        FInvisibleFGColorString : String;        RdGrp : TRadioGroup;

      { Private methods of TWxStaticBoxSizer }
        { Method to set variable and property values and create objects }
        procedure AutoInitialize;
        { Method to free any objects created by AutoInitialize }
        procedure AutoDestroy;
        { Write method for property Wx_Caption }
        procedure SetWx_Caption(Value : String);
        { Write method for property Wx_EventList }
        procedure SetWx_EventList(Value : TStringList);

    protected
      { Protected fields of TWxStaticBoxSizer }

      { Protected methods of TWxStaticBoxSizer }
        procedure Click; override;
        procedure KeyPress(var Key : Char); override;
        procedure Resize; override;
        procedure Loaded; override;
        procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

    public
      { Public fields and properties of TWxStaticBoxSizer }

      { Public methods of TWxStaticBoxSizer }
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

    published
      { Published properties of TWxStaticBoxSizer }
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
        property OnResize;
        property Orientation : TWxSizerOrientation
             read FOrientation write FOrientation
             default wxHorizontal;
        property SpaceValue : Integer
             read FSpaceValue write FSpaceValue
             default 5;
        property Wx_Caption : String read FWx_Caption write SetWx_Caption;
        property Wx_Class : String read FWx_Class write FWx_Class;
        property Wx_ControlOrientation : TWxControlOrientation
             read FWx_ControlOrientation write FWx_ControlOrientation;
        property Wx_EventList : TStringList
             read FWx_EventList write SetWx_EventList;
        property Wx_HorizontalAlignment : TWxSizerHorizontalAlignment
             read FWx_HorizontalAlignment write FWx_HorizontalAlignment
             default wxSZALIGN_CENTER_HORIZONTAL;
        property Wx_IDName : String read FWx_IDName write FWx_IDName;
        property Wx_IDValue : Integer
             read FWx_IDValue write FWx_IDValue
             default -1;

	property Wx_StrechFactor : Integer
		read FWx_StretchFactor write FWx_StretchFactor;
		
	property Wx_StretchFactor : Integer
             read FWx_StretchFactor write FWx_StretchFactor
             default 0;
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
     { Register TWxStaticBoxSizer with wxTest as its
       default page on the Delphi component palette }
     RegisterComponents('wxTest', [TWxStaticBoxSizer]);
end;

{ Method to set variable and property values and create objects }
procedure TWxStaticBoxSizer.AutoInitialize;
begin
     FWx_PropertyList := TStringList.Create;
     RdGrp := TRadioGroup.Create(Self);
     RdGrp.Parent := Self;
     FOrientation := wxHorizontal;
     FSpaceValue := 5;
     FWx_Class := 'wxStaticBoxSizer';
     FWx_EventList := TStringList.Create;
     FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
     FWx_IDValue := -1;
     FWx_StretchFactor := 0;
     FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxStaticBoxSizer.AutoDestroy;
begin
     FWx_PropertyList.Free;
     RdGrp.Free;
     FWx_EventList.Free;
end; { of AutoDestroy }

{ Write method for property Wx_Caption }
procedure TWxStaticBoxSizer.SetWx_Caption(Value : String);
begin
     FWx_Caption := Value;

     { If changing this property affects the appearance of
       the component, call Invalidate here so the image will be
       updated. }
     { Invalidate; }
     self.rdGrp.caption:=value;
end;

{ Write method for property Wx_EventList }
procedure TWxStaticBoxSizer.SetWx_EventList(Value : TStringList);
begin
     { Use Assign method because TStringList is an object type
       and FWx_EventList has been created. }
     FWx_EventList.Assign(Value);

     { If changing this property affects the appearance of
       the component, call Invalidate here so the image will be
       updated. }
     { Invalidate; }
end;

{ Override OnClick handler from TWxSizerPanel,IWxComponentInterface }
procedure TWxStaticBoxSizer.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

     { Activate click behavior of parent }
     inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TWxSizerPanel,IWxComponentInterface }
procedure TWxStaticBoxSizer.KeyPress(var Key : Char);
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

{ Override OnResize handler from TWxSizerPanel,IWxComponentInterface }
procedure TWxStaticBoxSizer.Resize;
begin
     { Parent's Resize method }
     inherited Resize;

     { Code to perform other actions (e.g., resizing any sub-
       components) needed in response to change in size of this
       component }

end;

constructor TWxStaticBoxSizer.Create(AOwner: TComponent);
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

     rdGrp.Align:=alClient;
     rdGrp.caption:='';

     { Code to perform other tasks when the container is created    }
     FWx_PropertyList.add('wx_Class:Base Class');
     FWx_PropertyList.add('Name : Name');
     FWx_PropertyList.add('SpaceValue : Border');
     FWx_PropertyList.add('Orientation : Orientation');
     FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
     FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');
     FWx_PropertyList.add('Wx_Caption   : Caption');
     FWx_PropertyList.add('Wx_StretchFactor   : StretchFactor');
end;

destructor TWxStaticBoxSizer.Destroy;
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

function TWxStaticBoxSizer.GenerateControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;

function TWxStaticBoxSizer.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
end;

function TWxStaticBoxSizer.GenerateGUIControlCreation:String;

     { type }
     { . . . }
var
     strColorStr:String;
     strStyle:String;
     strOrientation,strAlignment,staticBoxName:String;
begin
    if Orientation = wxVertical then
       strOrientation:='wxVERTICAL'
    else
       strOrientation:='wxHORIZONTAL';

    staticBoxName:=self.Name+'_StaticBoxObj';

    result:=Format('wxStaticBox* %s = new wxStaticBox(this,wxID_ANY,_("%s"));',[staticBoxName,self.Wx_Caption]);
    Result:=Result+#13+Format('wxStaticBoxSizer* %s = new wxStaticBoxSizer(%s,%s);',[self.Name,staticBoxName,strOrientation]);
    if self.Parent is TForm then
    begin
         Result:=Result+#13+Format('this->SetSizer(%s);',[self.Name]);
         Result:=Result+#13+'this->SetAutoLayout(TRUE);';
    end
    else
    begin

        strAlignment:=SizerAlignmentToStr(Wx_HorizontalAlignment) + ' | '+ SizerAlignmentToStr(Wx_VerticalAlignment) +' | wxALL';
        if wx_ControlOrientation = wxControlVertical then
            strAlignment:=SizerAlignmentToStr(Wx_HorizontalAlignment)+ ' | wxALL';

         if wx_ControlOrientation = wxControlHorizontal then
             strAlignment:=SizerAlignmentToStr(Wx_VerticalAlignment)+ ' | wxALL';

         Result:=Result +#13+Format('%s->Add(%s,%d,%s,%d);',[self.Parent.Name,self.Name,self.Wx_StretchFactor,strAlignment,self.SpaceValue]);

    end;
end;

function TWxStaticBoxSizer.GenerateGUIControlDeclaration:String;
begin
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxStaticBoxSizer.GenerateHeaderInclude:String;
begin
Result:='#include<wx/button.h>';
end;

function TWxStaticBoxSizer.GenerateImageInclude: string;
begin

end;

function TWxStaticBoxSizer.GetEventList:TStringlist;
begin
Result:=Wx_EventList;
end;

function TWxStaticBoxSizer.GetIDName:String;
begin
Result:=wx_IDName;
end;

function TWxStaticBoxSizer.GetIDValue:LongInt;
begin
Result:=wx_IDValue;
end;

function TWxStaticBoxSizer.GetParameterFromEventName(EventName: string):String;
begin
if EventName = 'EVT_BUTTON' then
begin
 Result:='wxCommandEvent& event';
 exit;
end;
if EventName = 'EVT_UPDATE_UI' then
begin
 Result:='wxUpdateUIEvent& event';
 exit;
end;

end;

function TWxStaticBoxSizer.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxStaticBoxSizer.GetStretchFactor:Integer;
begin
    result:=Wx_StretchFactor;
end;

function TWxStaticBoxSizer.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxStaticBoxSizer.GetWxClassName:String;
begin
Result:=wx_Class;
end;

procedure TWxStaticBoxSizer.Loaded;
begin
     inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxStaticBoxSizer.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
     wx_ControlOrientation:=ControlOrientation;
end;

procedure TWxStaticBoxSizer.SetIDName(IDName:String);
begin
wx_IDName:=IDName;
end;

procedure TWxStaticBoxSizer.SetIDValue(IDValue:longInt);
begin
Wx_IDValue:=IDVAlue;
end;

procedure TWxStaticBoxSizer.SetStretchFactor(intValue:Integer);
begin
    Wx_StretchFactor:=intValue;
end;

procedure TWxStaticBoxSizer.SetWxClassName(wxClassName:String);
begin
wx_Class:=wxClassName;
end;

procedure TWxStaticBoxSizer.WMPaint(var Message: TWMPaint);
var
    maxWidth,maxHt:Integer;
    totalmaxWidth,totalmaxHt:Integer;
    orimaxWidth,orimaxHt:Integer;
    startX,nextX:Integer;
    i:Integer;
    TotalControlCount:Integer;
    coordTop,coordLeft:Integer;
    intAlignment:Integer;
    wxcompInterface: IWxComponentInterface;
begin
    intAlignment:=1;
     { Make this component look like its parent component by calling
       its parent's Paint method. }

     self.Caption:='';

     maxWidth:=0;
     maxHt:=0;

     totalmaxWidth:=2*self.FSpaceValue;
     totalmaxHt:=2*self.FSpaceValue;

     maxHt:=2*self.FSpaceValue;

    for i := 0 to self.ControlCount - 1 do
    begin
         if self.Controls[i] is TRadioGroup then
            continue;
        //Calculate the total size for all childens

        totalmaxWidth:=totalmaxWidth+self.Controls[i].Width+ 2* self.FSpaceValue;
        totalmaxHt:=totalmaxHt+self.Controls[i].Height+2* self.FSpaceValue;

        if self.Controls[i].Width > maxWidth then
        begin
            maxWidth:=self.Controls[i].Width;
        end;

        if self.Controls[i].Height > maxHt then
        begin
            maxHt:=self.Controls[i].Height;
        end;

        //Set the control orientation
      if self.Controls[i].GetInterface(IID_IWxComponentInterface,wxcompInterface) then
      begin
            if Orientation = wxVertical then
                wxcompInterface.SaveControlOrientation(wxControlVertical)
            else
                wxcompInterface.SaveControlOrientation(wxControlHorizontal);
      end;
    end;

    if self.Parent is TForm then
    begin
        if (totalmaxWidth < 100) then
            self.Parent.ClientWidth:=100
        else
        begin
            if self.Orientation = wxHorizontal then
                self.Parent.ClientWidth:=totalmaxWidth //
            else
                self.Parent.ClientWidth:=maxWidth+2* self.FSpaceValue;
        end;

        if (totalmaxht < 45)then
            self.Parent.ClientHeight:=45
        else
        begin
            if self.Orientation = wxHorizontal then
            begin
                if maxht+2*self.FSpaceValue < 45 then
                    self.Parent.ClientHeight:=45
                else
                    self.Parent.ClientHeight:=maxht+self.FSpaceValue+self.FSpaceValue+self.FSpaceValue+self.FSpaceValue+self.FSpaceValue; //add 3 sapces
            end
            else
                self.Parent.ClientHeight:=totalmaxht;
        end;
        self.Align:=alClient;
    end
    else
    begin

        self.Align:=alNone;
        if self.Orientation = wxHorizontal then
        begin

            if maxWidth*self.ControlCount+self.ControlCount*2*self.FSpaceValue = 0 then
                self.Width:=4*self.FSpaceValue
            else
                self.Width:=totalmaxWidth;
            self.Height:=maxHt+2*self.FSpaceValue+2*self.FSpaceValue+ 2*self.FSpaceValue;
        end
        else
        begin
            if maxWidth = 0 then
                self.Width:=4*self.FSpaceValue
            else
            self.Width:=maxWidth+ 2*self.FSpaceValue+2*self.FSpaceValue;//add 1

            if maxHt*self.ControlCount+self.ControlCount* 2 *self.FSpaceValue = 0 then
                self.Height:=4*self.FSpaceValue+2*self.FSpaceValue
            else
                self.Height:=totalmaxHt+2*self.FSpaceValue;
        end;
    end;

 startX:=FSpaceValue+FSpaceValue;//additional space for staticbox

 if Orientation = wxHorizontal then
 begin
    for i := 0 to self.ControlCount - 1 do
    begin
         if self.Controls[i] is TRadioGroup then
            continue;
        //Top
        if intAlignment = 0 then
        begin
            self.Controls[i].Top:=FSpaceValue+FSpaceValue;//added 1 here
            self.Controls[i].left:=startX;
            startX:=startX+self.Controls[i].Width+FSpaceValue +self.FSpaceValue;
        end;
        //Center
        if intAlignment = 1 then
        begin
            coordTop:=maxHt+ 2*FSpaceValue + 2*FSpaceValue - self.Controls[i].Height;
            self.Controls[i].Top:=(coordTop div 2) + FSpaceValue + FSpaceValue;//added 2
            self.Controls[i].left:=startX;
            startX:=startX+self.Controls[i].Width+FSpaceValue +self.FSpaceValue;
        end;

    end;
end
else
begin
     startX:=startX+FSpaceValue+FSpaceValue;
    for i := 0 to self.ControlCount - 1 do
    begin
        if self.Controls[i] is TRadioGroup then
          continue;
        //Top
        if intAlignment = 0 then
        begin
            self.Controls[i].left:=FSpaceValue;
            self.Controls[i].Top:=startX;
            startX:=startX+self.Controls[i].Height+FSpaceValue+ self.FSpaceValue;
        end;
        //Center
        if intAlignment = 1 then
        begin
            coordLeft:=maxWidth+ 2*FSpaceValue - self.Controls[i].width;
            self.Controls[i].left:=(coordLeft div 2 )+ FSpaceValue;
            self.Controls[i].Top:=startX;
            startX:=startX+self.Controls[i].Height+FSpaceValue+ self.FSpaceValue;
        end;
    end;
end;

     inherited;

end;

function TWxStaticBoxSizer.GetFGColor:string;
begin
end;

procedure TWxStaticBoxSizer.SetFGColor(strValue:String);
begin
end;
    
function TWxStaticBoxSizer.GetBGColor:string;
begin
end;

procedure TWxStaticBoxSizer.SetBGColor(strValue:String);
begin
end;

end.
