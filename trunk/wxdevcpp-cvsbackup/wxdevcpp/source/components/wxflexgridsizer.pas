{ ****************************************************************** }
{                                                                    }
{   VCL component TWxFlexGridSizer                                   }
{                                                                    }
{   Code generated by Component Create for Delphi                    }
{                                                                    }
{   Generated from source file e:\backup\delphi\demo\wxdevcpp\source\components\compcode\wxflexgridsizer.cd }
{   on 22 July 2004 at 14:31                                         }
{                                                                    }
{   Copyright � 2004 by Guru Kathiresan                              }
{                                                                    }
{ ****************************************************************** }

unit WXFlexGridSizer;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, 
     Forms, Graphics, Extctrls, WxUtils, WxSizerPanel;

{ Unit-wide declarations }
{ type }
     { . . . }
{ var }
     { . . . }

type
  TWxFlexGridSizer = class(TWxSizerPanel,IWxComponentInterface)
    private
      { Private fields of TWxFlexGridSizer }
        { Storage for property ColumnSpacing }
        FColumnSpacing : Integer;
        { Storage for property Columns }
        FColumns : Integer;
        { Storage for property RowSpacing }
        FRowSpacing : Integer;
        { Storage for property Rows }
        FRows : Integer;
        { Storage for property SpaceValue }
        FSpaceValue : Integer;
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
        { Storage for property Wx_VerticalAlignment }
        FWx_VerticalAlignment : TWxSizerVerticalAlignment;
        FWx_PropertyList : TStringList;

      { Private methods of TWxFlexGridSizer }
        { Method to set variable and property values and create objects }
        procedure AutoInitialize;
        { Method to free any objects created by AutoInitialize }
        procedure AutoDestroy;
        { Write method for property Wx_EventList }
        procedure SetWx_EventList(Value : TStringList);

    protected
      { Protected fields of TWxFlexGridSizer }

      { Protected methods of TWxFlexGridSizer }
        procedure Click; override;
        procedure KeyPress(var Key : Char); override;
        procedure Resize; override;
        procedure Loaded; override;

    public
      { Public fields and properties of TWxFlexGridSizer }

      { Public methods of TWxFlexGridSizer }
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
        procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
        function maxHeightOfRow(rowIndex:Integer):Integer;
        function maxWidthOfColumn(colIndex,totalRows:Integer):Integer;

    published
      { Published properties of TWxFlexGridSizer }
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
        property ColumnSpacing : Integer
             read FColumnSpacing write FColumnSpacing
             default 0;
        property Columns : Integer read FColumns write FColumns default 2;
        property RowSpacing : Integer
             read FRowSpacing write FRowSpacing
             default 0;
        property Rows : Integer read FRows write FRows default 2;
        property SpaceValue : Integer
             read FSpaceValue write FSpaceValue
             default 5;
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
        property Wx_VerticalAlignment : TWxSizerVerticalAlignment
             read FWx_VerticalAlignment write FWx_VerticalAlignment
             default wxSZALIGN_CENTER_VERTICAL;

  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxFlexGridSizer with Standard as its
       default page on the Delphi component palette }
     RegisterComponents('Standard', [TWxFlexGridSizer]);
end;

{ Method to set variable and property values and create objects }
procedure TWxFlexGridSizer.AutoInitialize;
begin
     FWx_PropertyList := TStringList.Create;
     FColumnSpacing := 0;
     FColumns := 2;
     FRowSpacing := 0;
     FRows := 2;
     FSpaceValue := 5;
     FWx_Class := 'wxFlexGridSizer';
     FWx_EventList := TStringList.Create;
     FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
     FWx_IDValue := -1;
     FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxFlexGridSizer.AutoDestroy;
begin
     FWx_PropertyList.Free;
     FWx_EventList.Free;
end; { of AutoDestroy }

{ Write method for property Wx_EventList }
procedure TWxFlexGridSizer.SetWx_EventList(Value : TStringList);
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
procedure TWxFlexGridSizer.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

     { Activate click behavior of parent }
     inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TWxSizerPanel,IWxComponentInterface }
procedure TWxFlexGridSizer.KeyPress(var Key : Char);
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
procedure TWxFlexGridSizer.Resize;
begin
     { Parent's Resize method }
     inherited Resize;

     { Code to perform other actions (e.g., resizing any sub-
       components) needed in response to change in size of this
       component }
end;

constructor TWxFlexGridSizer.Create(AOwner: TComponent);
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

     { Code to perform other tasks when the container is created    }
     FWx_PropertyList.add('wx_Class:Base Class');
     FWx_PropertyList.add('Wx_IDName : IDName ');
     FWx_PropertyList.add('Wx_IDValue : IDValue ');
     FWx_PropertyList.add('Name : Name');
     FWx_PropertyList.add('Left : Left');
     FWx_PropertyList.add('Top : Top');
     FWx_PropertyList.add('Width : Width');
     FWx_PropertyList.add('Height:Height');
     FWx_PropertyList.add('Orientation : Orientation');
     FWx_PropertyList.add('SpaceValue : Border');
     FWx_PropertyList.add('Rows : Rows');
     FWx_PropertyList.add('Columns : Columns');
     FWx_PropertyList.add('RowSpacing : RowSpacing');
     FWx_PropertyList.add('ColumnSpacing : ColumnSpacing');

     FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
     FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');

end;

destructor TWxFlexGridSizer.Destroy;
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

function TWxFlexGridSizer.GenerateControlIDs:String;
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

function TWxFlexGridSizer.GenerateEventTableEntries(CurrClassName:String):String;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     Result:='';
end;

function TWxFlexGridSizer.GenerateGUIControlCreation:String;
     { Internal declarations for method }
     { type }
     { . . . }
var
     strStyle,strAlignment:String;
begin

    Result:=Format('wxFlexGridSizer* %s = new wxFlexGridSizer(%d,%d,%d,%d);',[self.Name,self.rows,self.columns,self.rowSpacing,self.columnSpacing]);
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

         Result:=Result +#13+Format('%s->Add(%s,%d,%s,%d);',[self.Parent.Name,self.Name,0,strAlignment,self.SpaceValue]);
    end;
end;

function TWxFlexGridSizer.GenerateGUIControlDeclaration:String;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxFlexGridSizer.GenerateHeaderInclude:String;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
Result:='#include<wx/button.h>';
end;

function TWxFlexGridSizer.GenerateImageInclude: string;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin

end;

function TWxFlexGridSizer.GetEventList:TStringlist;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
Result:=Wx_EventList;
end;

function TWxFlexGridSizer.GetIDName:String;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
Result:=wx_IDName;
end;

function TWxFlexGridSizer.GetIDValue:LongInt;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
Result:=wx_IDValue;
end;

function TWxFlexGridSizer.GetParameterFromEventName(EventName: string):String;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
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

function TWxFlexGridSizer.GetPropertyList:TStringList;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
     Result:=FWx_PropertyList;
end;

function TWxFlexGridSizer.GetTypeFromEventName(EventName: string):string;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin

end;

function TWxFlexGridSizer.GetWxClassName:String;
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
Result:=wx_Class;
end;

procedure TWxFlexGridSizer.Loaded;
begin
     inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxFlexGridSizer.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
wx_ControlOrientation:=ControlOrientation;
end;

procedure TWxFlexGridSizer.SetIDName(IDName:String);
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
wx_IDName:=IDName;
end;

procedure TWxFlexGridSizer.SetIDValue(IDValue:longInt);
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
Wx_IDValue:=IDVAlue;
end;

procedure TWxFlexGridSizer.SetWxClassName(wxClassName:String);
     { Internal declarations for method }
     { type }
     { . . . }
     { var }
     { . . . }
begin
wx_Class:=wxClassName;
end;

procedure TWxFlexGridSizer.WMPaint(var Message: TWMPaint);
var
    maxWidth,maxHt:Integer;
    totalmaxWidth,totalmaxHt,tmpHtofRow,tmpTotalWt,tmpWtofCol:Integer;
    orimaxWidth,orimaxHt:Integer;
    startX,nextX:Integer;
    i,j,k:Integer;
    TotalControlCount:Integer;
    coordTop,coordLeft:Integer;
    intAlignment:Integer;
    oriRows:Integer;
    rowCount,colCount:Integer;
    intTemp:Integer;
    wxcompInterface: IWxComponentInterface;
begin
    intAlignment:=1;
     { Make this component look like its parent component by calling
       its parent's Paint method. }


     self.Caption:='';

     maxWidth:=-1;
     maxHt:=-1;

     totalmaxWidth:=0;
     totalmaxHt:=0;

     maxHt:=2*self.FSpaceValue;

    oriRows:=self.ControlCount div self.Columns;
    if oriRows * self.Columns < self.ControlCount then
        oriRows:=oriRows+1;


    for i := 0 to self.ControlCount - 1 do
    begin
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
      if self.Controls[i].GetInterface(IID_IWxComponentInterface,wxcompInterface) then
        wxcompInterface.SaveControlOrientation(wxControlNone);

    end;

    intTemp:=totalmaxHt;
    totalmaxHt:=0;
    for i := 0 to oriRows - 1 do
    begin
        tmpHtofRow:=maxHeightOfRow(i);
        totalmaxHt:=totalmaxHt+tmpHtofRow+(2* self.FSpaceValue);
    end;

    tmpTotalWt:=0;
    for i := 0 to columns - 1 do
    begin
        tmpWtofCol:=maxWidthOfColumn(i,oriRows);
        tmpTotalWt:=tmpTotalWt+tmpWtofCol+(2* self.FSpaceValue);
    end;

    if self.Parent is TForm then
    begin
        if (totalmaxWidth < 100) then
            self.Parent.ClientWidth:=100
        else
            self.Parent.ClientWidth:=tmpTotalWt;//self.Columns * (maxWidth+2* self.FSpaceValue);

        if (totalmaxht < 45)then
            self.Parent.ClientHeight:=35
        else
            self.Parent.ClientHeight:=totalmaxHt;//OriRows * (maxHt+2* self.FSpaceValue);

        self.Align:=alClient;
    end
    else
    begin
        self.Align:=alNone;

        if (totalmaxWidth < 4*self.FSpaceValue) then
            self.Width:=4*self.FSpaceValue
        else
            self.Width:=tmpTotalWt;//self.Columns * (maxWidth+2* self.FSpaceValue);

        if (totalmaxht < 4*self.FSpaceValue)then
            self.Height:=4*self.FSpaceValue
        else
            self.Height:=totalmaxHt; //OriRows * (maxHt+2* self.FSpaceValue);

    end;

 startX:=FSpaceValue;
 rowCount:=0;
 colCount:=0;

    for i := 0 to self.ControlCount - 1 do
    begin
        maxHt:=maxHeightOfRow(RowCount);
        maxWidth:=maxWidthOfColumn(colCount,oriRows);

        intTemp:=0;
        for k := 0 to rowCount - 1 do
        begin
            intTemp:=intTemp+maxHeightOfRow(k);
        end;

        tmpWtofCol:=0;
        for k := 0 to ColCount - 1 do
        begin
            tmpWtofCol:=tmpWtofCol+maxWidthOfColumn(k,oriRows);
        end;

        //sendDebug('Ht = '+IntToStr(maxHt));

        if intAlignment =0 then
        begin
            self.Controls[i].Top:=(FSpaceValue * (2*(rowCount+1) -1) ) + maxHt * rowCount;
            self.Controls[i].left:=(FSpaceValue* (2*(colCount+1) -1) ) + maxWidth *  colCount;
        end;

        if intAlignment =1 then
        begin
            coordLeft:=(maxWidth - self.Controls[i].Width) div 2;
            coordTop:=(maxHt - self.Controls[i].Height) div 2;

            self.Controls[i].Top:= (FSpaceValue * (2*(rowCount+1) -1) ) +  intTemp + coordTop;
            self.Controls[i].left:= (FSpaceValue* (2*(colCount+1) -1) ) +  tmpWtofCol + coordLeft;
        end;

        inc(ColCount);
        if ColCount+1 > Columns then
        begin
            ColCount:=0;
            inc(RowCount);
        end;
    end;
    
    inherited;
         
end;

function TWxFlexGridSizer.maxHeightOfRow(rowIndex:Integer):Integer;
     { Internal declarations for method }
     { type }
     { . . . }
var
    startItem,endItem,i:Integer;
begin
    startItem:=rowIndex * columns;
    endItem:=rowIndex *columns + columns -1;
    result:=0;
    for i := 0 to self.ControlCount - 1 do
    begin
         //sendDebug('name = '+ self.Controls[i].name +' ht = '+IntToStr(self.Controls[i].Height)+' i = '+IntToStr(i) + ' Start = '+IntToStr(startItem) + '  End = '+IntToStr(endItem));
         if (i >= startItem) and (i <= endItem) then
         begin
              if result < self.Controls[i].Height then
                 result := self.Controls[i].Height;
         end;

    end;
end;

function TWxFlexGridSizer.maxWidthOfColumn(colIndex,totalRows:Integer):Integer;
var
    startItem,i:Integer;
begin
    result:=0;
    for i := 0 to self.ControlCount - 1 do
    begin
        startItem:=(i mod columns);
        //if not((colIndex = 0) and (i = 0) ) then
            //startItem:=1;

         if startItem = colIndex then
         begin
              if result < self.Controls[i].Width then
                 result := self.Controls[i].Width;
         end;

    end;
end;



end.
