{ ****************************************************************** }
{                                                                    }
{ $Id$                                                               }
{                                                                    }
{   VCL component TWxSplitterWindow                                  }
{                                                                    }
{   Code generated by Component Create for Delphi                    }
{                                                                    }
{   Generated from source file wxsplitterWindow.cd }
{   on 10 Oct 2004 at 0:49                                           }
{                                                                    }
{   Copyright � 2004 by Guru Kathiresan                              }
{                                                                    }
{ ****************************************************************** }

unit WxSplitterWindow;

interface

uses WinTypes, WinProcs, Messages, Classes, Controls, 
     Forms, Graphics, Extctrls, WxUtils, WxSizerPanel,dbugIntf;

type
  TWxSplitterWindow = class(TPanel,IWxComponentInterface,IWxWindowInterface,IWxContainerInterface,IWxContainerAndSizerInterface)
    private
        FOrientation : TWxSizerOrientation;
        FSpaceValue : Integer;
        FWx_Class : String;
        FWx_ControlOrientation : TWxControlOrientation;
        FWx_EventList : TStringList;
        FWx_HorizontalAlignment : TWxSizerHorizontalAlignment;
        FWx_IDName : String;
        FWx_IDValue : Integer;
        FWx_StretchFactor : Integer;
        FWx_Border:Integer;
        FWx_VerticalAlignment : TWxSizerVerticalAlignment;
        FWx_PropertyList : TStringList;
        FInvisibleBGColorString : String;
        FInvisibleFGColorString : String;
        FWx_GeneralStyle : TWxStdStyleSet;
        FWx_SplitterStyle:TWxSplitterWinStyleSet;

        FEVT_SPLITTER_SASH_POS_CHANGING : string;
        FEVT_SPLITTER_SASH_POS_CHANGED : string;
        FEVT_SPLITTER_UNSPLIT :string;
        FEVT_SPLITTER_DCLICK :string;
        FEVT_UPDATE_UI :string;
        FWx_SashPosition:Integer;


        procedure AutoInitialize;
        procedure AutoDestroy;
        procedure SetWx_EventList(Value : TStringList);

    protected
        procedure Click; override;
        procedure KeyPress(var Key : Char); override;
        procedure Resize; override;
        procedure Loaded; override;
        procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

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
        function GenerateLastCreationCode:String;
                
    published
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
        property Orientation : TWxSizerOrientation read FOrientation write FOrientation default wxHorizontal;
        property SpaceValue : Integer read FSpaceValue write FSpaceValue default 5;
        property Wx_Class : String read FWx_Class write FWx_Class;
        property Wx_ControlOrientation : TWxControlOrientation read FWx_ControlOrientation write FWx_ControlOrientation;
        property Wx_EventList : TStringList read FWx_EventList write FWx_EventList;
        property Wx_HorizontalAlignment : TWxSizerHorizontalAlignment read FWx_HorizontalAlignment write FWx_HorizontalAlignment default wxSZALIGN_CENTER_HORIZONTAL;
        property Wx_IDName : String read FWx_IDName write FWx_IDName;
        property Wx_IDValue : Integer read FWx_IDValue write FWx_IDValue default -1;
        property Wx_StretchFactor : Integer read FWx_StretchFactor write FWx_StretchFactor;
    	property Wx_StrechFactor : Integer read FWx_StretchFactor write FWx_StretchFactor;
    	property Wx_Border : Integer read FWx_Border write FWx_Border;
    	property Wx_SashPosition : Integer read FWx_SashPosition write FWx_SashPosition;
        property Wx_VerticalAlignment : TWxSizerVerticalAlignment read FWx_VerticalAlignment write FWx_VerticalAlignment default wxSZALIGN_CENTER_VERTICAL;
        property InvisibleBGColorString:String read FInvisibleBGColorString write FInvisibleBGColorString;
        property InvisibleFGColorString:String read FInvisibleFGColorString write FInvisibleFGColorString;
        property Wx_GeneralStyle : TWxStdStyleSet read FWx_GeneralStyle write FWx_GeneralStyle;
        property Wx_SplitterStyle : TWxSplitterWinStyleSet read FWx_SplitterStyle write FWx_SplitterStyle;

        property EVT_SPLITTER_SASH_POS_CHANGING : string read FEVT_SPLITTER_SASH_POS_CHANGING write FEVT_SPLITTER_SASH_POS_CHANGING ;
        property EVT_SPLITTER_SASH_POS_CHANGED : string read FEVT_SPLITTER_SASH_POS_CHANGED write FEVT_SPLITTER_SASH_POS_CHANGED;
        property EVT_SPLITTER_UNSPLIT :string read FEVT_SPLITTER_UNSPLIT write FEVT_SPLITTER_UNSPLIT;
        property EVT_SPLITTER_DCLICK :string read FEVT_SPLITTER_DCLICK write FEVT_SPLITTER_DCLICK;
        property EVT_UPDATE_UI :string read FEVT_UPDATE_UI write FEVT_UPDATE_UI;

  end;

procedure Register;

implementation

uses sysutils;

procedure Register;
begin
     RegisterComponents('wxTest', [TWxSplitterWindow]);
end;

procedure TWxSplitterWindow.AutoInitialize;
begin	
     FWx_PropertyList := TStringList.Create;
     FOrientation := wxHorizontal;
     FSpaceValue := 5;
     FWx_Border := 0;
     FWx_Class := 'wxSplitterWindow';
     FWx_EventList := TStringList.Create;
     FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
     FWx_IDValue := -1;
     FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
end; { of AutoInitialize }

procedure TWxSplitterWindow.AutoDestroy;
begin
     FWx_PropertyList.Free;
     FWx_EventList.Free;
end; { of AutoDestroy }

procedure TWxSplitterWindow.SetWx_EventList(Value : TStringList);
begin
     FWx_EventList.Assign(Value);
end;

procedure TWxSplitterWindow.Click;
begin
     inherited Click;
end;

procedure TWxSplitterWindow.KeyPress(var Key : Char);
const
     TabKey = Char(VK_TAB);
     EnterKey = Char(VK_RETURN);
begin
     inherited KeyPress(Key);
end;

procedure TWxSplitterWindow.Resize;
begin
     inherited Resize;
end;

constructor TWxSplitterWindow.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);

     AutoInitialize;
     FWx_PropertyList.add('wx_Class:Base Class');
     FWx_PropertyList.add('Name : Name');
     FWx_PropertyList.add('Wx_Border : Border');
     FWx_PropertyList.add('Orientation : Orientation');
     FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
     FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');
     FWx_PropertyList.add('Wx_StretchFactor   : StretchFactor');

     FWx_PropertyList.add('Wx_GeneralStyle : General Styles');
     FWx_PropertyList.add('Wx_SplitterStyle : Splitter Window Styles');

     FWx_PropertyList.add('wxSP_3D : wxSP_3D');
     FWx_PropertyList.add('wxSP_3DSASH : wxSP_3DSASH');
     FWx_PropertyList.add('wxSP_3DBORDER : wxSP_3DBORDER');
     FWx_PropertyList.add('wxSP_BORDER : wxSP_BORDER');
     FWx_PropertyList.add('wxSP_NOBORDER : wxSP_NOBORDER');
     FWx_PropertyList.add('wxSP_NO_XP_THEME : wxSP_NO_XP_THEME');
     FWx_PropertyList.add('wxSP_PERMIT_UNSPLIT : wxSP_PERMIT_UNSPLIT');
     FWx_PropertyList.add('wxSP_LIVE_UPDATE : wxSP_LIVE_UPDATE');
  
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

     FWx_EventList.Add('EVT_SPLITTER_SASH_POS_CHANGING : OnSashPosChanging');
     FWx_EventList.Add('EVT_SPLITTER_SASH_POS_CHANGED : OnSashPosChanged');
     FWx_EventList.Add('EVT_SPLITTER_UNSPLIT : OnUnSplit');
     FWx_EventList.Add('EVT_SPLITTER_DCLICK : OnDoubleClick');
     FWx_EventList.Add('EVT_UPDATE_UI : OnUpdateUI');
          
end;

destructor TWxSplitterWindow.Destroy;
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


function TWxSplitterWindow.GenerateEnumControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('%s = %d , ',[Wx_IDName,Wx_IDValue]);
end;

function TWxSplitterWindow.GenerateControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;

function TWxSplitterWindow.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
     if trim(EVT_SPLITTER_SASH_POS_CHANGING) <> '' then
     begin
          Result:=Format('EVT_SPLITTER_SASH_POS_CHANGING(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_SPLITTER_SASH_POS_CHANGING]) +'';
     end;
     if trim(EVT_SPLITTER_SASH_POS_CHANGED) <> '' then
     begin
          Result:=Format('EVT_SPLITTER_SASH_POS_CHANGED(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_SPLITTER_SASH_POS_CHANGED]) +'';
     end;
     if trim(EVT_SPLITTER_DCLICK) <> '' then
     begin
          Result:=Format('EVT_SPLITTER_DCLICK(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_SPLITTER_DCLICK]) +'';
     end;
     if trim(EVT_SPLITTER_UNSPLIT) <> '' then
     begin
          Result:=Format('EVT_SPLITTER_UNSPLIT(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_SPLITTER_UNSPLIT]) +'';
     end;

     if trim(EVT_UPDATE_UI) <> '' then
     begin
          Result:=Result+#13+Format('EVT_UPDATE_UI(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_UPDATE_UI]) +'';
     end;
end;

function TWxSplitterWindow.GenerateGUIControlCreation:String;
var
     strColorStr:String;
     strAlignment:String;
     parentName:String;
     strStyle:String;
begin
    parentName:=GetWxWidgetParent(self);
    strStyle:=GetSplitterWindowSpecificStyle(self.Wx_GeneralStyle,self.Wx_SplitterStyle);

    Result:=Format('%s =  new %s(%s, %s, wxPoint(%d,%d),wxSize(%d,%d) %s);',[self.Name,self.wx_Class,parentName,GetWxIDString(self.Wx_IDName,self.Wx_IDValue),self.Left,self.Top,self.width,self.Height,strStyle] );

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
         Result:=Result+#13+Format('%s->Add(%s,%d,%s,%d);',[self.Parent.Name,self.Name,self.Wx_StretchFactor,strAlignment,self.wx_Border]);
    end;

end;

function TWxSplitterWindow.GenerateGUIControlDeclaration:String;
begin
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxSplitterWindow.GenerateHeaderInclude:String;
begin
    Result:='#include <wx/splitter.h>';
end;

function TWxSplitterWindow.GenerateImageInclude: string;
begin

end;

function TWxSplitterWindow.GetEventList:TStringlist;
begin
    Result:=Wx_EventList;
end;

function TWxSplitterWindow.GetIDName:String;
begin
    Result:=wx_IDName;
end;

function TWxSplitterWindow.GetIDValue:LongInt;
begin
    Result:=wx_IDValue;
end;

function TWxSplitterWindow.GetParameterFromEventName(EventName: string):String;
begin
    if (EventName = 'EVT_SPLITTER_SASH_POS_CHANGING') or (EventName = 'EVT_SPLITTER_SASH_POS_CHANGED')
     or (EventName = 'EVT_SPLITTER_UNSPLIT')  or (EventName = 'EVT_SPLITTER_DCLICK') then
    begin
        Result:='wxSplitterEvent& event';
        exit;
    end;
    
    if EventName = 'EVT_UPDATE_UI' then
    begin
        Result:='wxUpdateUIEvent& event';
        exit;
    end;
end;

function TWxSplitterWindow.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxSplitterWindow.GetStretchFactor:Integer;
begin
    result:=Wx_StretchFactor;
end;

function TWxSplitterWindow.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxSplitterWindow.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='wxSplitterWindow';
Result:=wx_Class;
end;

procedure TWxSplitterWindow.Loaded;
begin
     inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxSplitterWindow.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
     wx_ControlOrientation:=ControlOrientation;
end;

procedure TWxSplitterWindow.SetIDName(IDName:String);
begin
wx_IDName:=IDName;
end;

procedure TWxSplitterWindow.SetIDValue(IDValue:longInt);
begin
Wx_IDValue:=IDVAlue;
end;

procedure TWxSplitterWindow.SetStretchFactor(intValue:Integer);
begin
    Wx_StretchFactor:=intValue;
end;

procedure TWxSplitterWindow.SetWxClassName(wxClassName:String);
begin
wx_Class:=wxClassName;
end;

procedure TWxSplitterWindow.WMPaint(var Message: TWMPaint);
var
    maxWidth,maxHt:Integer;
    totalmaxWidth,totalmaxHt:Integer;
    startX,nextX:Integer;
    i:Integer;
    TotalControlCount:Integer;
    coordTop,coordLeft:Integer;
    intAlignment:Integer;
    wxcompInterface: IWxComponentInterface;
    cntIntf:IWxContainerInterface;
begin
    intAlignment:=1;
     { Make this component look like its parent component by calling
       its parent's Paint method. }

    self.Caption:='';
    if self.ControlCount < 1 then
    begin
        inherited;
        exit;
    end;
    
    if ControlCount > 0 then
        Wx_SashPosition:=self.Controls[0].Width;

     maxWidth:=0;

     totalmaxWidth:=0;
     totalmaxHt:=0;

     maxHt:=2*self.FSpaceValue;

    for i := 0 to self.ControlCount - 1 do
    begin
        //Calculate the total size for all childens
        if IsControlWxNonVisible(Controls[i]) then
            continue;

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
            if self.Orientation = wxVertical then
                self.Parent.ClientWidth:=totalmaxWidth
            else
                self.Parent.ClientWidth:=maxWidth+2* self.FSpaceValue;
        end;

        if (totalmaxht < 45)then
            self.Parent.ClientHeight:=35
        else
        begin
            if self.Orientation = wxVertical then
            begin
                if maxht+2*self.FSpaceValue < 35 then
                    self.Parent.ClientHeight:=35
                else
                    self.Parent.ClientHeight:=maxht+self.FSpaceValue+self.FSpaceValue;
            end
            else
                self.Parent.ClientHeight:=totalmaxht;
        end;
        self.Align:=alClient;
    end
    else
    begin

        if self.parent.GetInterface(IDD_IWxContainerInterface,cntIntf) then
            self.Align:=alClient
        else
            self.Align:=alNone;

        if self.Orientation = wxVertical then
        begin

            if maxWidth*self.ControlCount+self.ControlCount*2*self.FSpaceValue = 0 then
                self.Width:=4*self.FSpaceValue
            else
                self.Width:=totalmaxWidth;
            self.Height:=maxHt+2*self.FSpaceValue;
        end
        else
        begin
            if maxWidth = 0 then
                self.Width:=4*self.FSpaceValue
            else
            self.Width:=maxWidth+ 2*self.FSpaceValue;

            if maxHt*self.ControlCount+self.ControlCount* 2 *self.FSpaceValue = 0 then
                self.Height:=4*self.FSpaceValue
            else
                self.Height:=totalmaxHt;
        end;
    end;

 startX:=FSpaceValue;

 if Orientation = wxVertical then
 begin
    for i := 0 to self.ControlCount - 1 do
    begin
        if IsControlWxNonVisible(Controls[i]) then
            continue;

        //Top
        if intAlignment = 0 then
        begin
            self.Controls[i].Top:=FSpaceValue;
            self.Controls[i].left:=startX;
            startX:=startX+self.Controls[i].Width+FSpaceValue +self.FSpaceValue;
        end;
        //Center
        if intAlignment = 1 then
        begin
            coordTop:=maxHt+ 2*FSpaceValue - self.Controls[i].Height;
            self.Controls[i].Top:=coordTop div 2;
            self.Controls[i].left:=startX;
            startX:=startX+self.Controls[i].Width+FSpaceValue +self.FSpaceValue;
        end;

    end;
end
else
begin
    for i := 0 to self.ControlCount - 1 do
    begin
        if IsControlWxNonVisible(Controls[i]) then
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
            self.Controls[i].left:=coordLeft div 2;
            self.Controls[i].Top:=startX;
            startX:=startX+self.Controls[i].Height+FSpaceValue+ self.FSpaceValue;
        end;
    end;
end;


    //if self.parent.GetInterface(IDD_IWxContainerInterface,cntIntf) then
    begin
        if Self.Height > parent.Height then
            parent.Height:=Self.Height;

        if Self.Width > parent.Width then
            parent.Width:=Self.Width  ;
    end;
    
    inherited;

end;

function TWxSplitterWindow.GetFGColor:string;
begin
end;

procedure TWxSplitterWindow.SetFGColor(strValue:String);
begin
end;

function TWxSplitterWindow.GetBGColor:string;
begin
end;

procedure TWxSplitterWindow.SetBGColor(strValue:String);
begin
end;

function TWxSplitterWindow.GenerateLastCreationCode:String;
var
    strFirstControl,strSecondControl,strOrientation:String;

function GenerateParentSizerCode:String;
var
    strAlignment:String;
begin

end;

begin
    Result:=GenerateParentSizerCode;
    if self.ControlCount = 0 then
        exit;

    if self.ControlCount > 0 then
        strFirstControl:= self.Controls[0].Name;

    if self.ControlCount > 1 then
        strSecondControl:= self.Controls[1].Name;

    strOrientation:='SplitHorizontally';
    if self.Wx_ControlOrientation = wxControlVertical then
        strOrientation:='SplitVertically'
    else
        strOrientation:='SplitHorizontally';

    if self.ControlCount = 1 then
    begin
        if Result = '' then
            Result:= Format('%s->Initialize(%s);',[self.Name,strFirstControl])
        else
            Result:= Result + #13+#10 + Format('%s->Initialize(%s);',[self.Name,strFirstControl]);
        exit;
    end;

    if self.ControlCount > 1 then
    begin
        if Result = '' then
            Result:= Format('%s->%s(%s,%s,%d);',[self.Name,strOrientation,strFirstControl,strSecondControl,self.Wx_SashPosition])
        else
            Result:= Result + #13+#10 +Format('%s->%s(%s,%s,%d);',[self.Name,strOrientation,strFirstControl,strSecondControl,self.Wx_SashPosition]);
        exit;
    end;
end;

end.
