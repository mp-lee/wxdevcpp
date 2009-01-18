 { ****************************************************************** }
 {                                                                    }
{ $Id: wxgrid.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
 {                                                                    }
{                                                                    }
{   Copyright � 2003-2007 by Guru Kathiresan                         }
{                                                                    }
{License :                                                           }
{=========                                                           }
{The wx-devC++ Components, Form Designer, Utils classes              }
{are exclusive properties of Guru Kathiresan.                        }
{The code is available in dual Licenses:                             }
{                               1)GPL Compatible  License            }
{                               2)Commercial License                 }
{                                                                    }
{1)GPL License :                                                     }
{ Code can be used in any project as long as the project's sourcecode}
{ is published under GPL license.                                    }
{                                                                    }
{2)Commercial License:                                               }
{Use of code in this file or the one that bear this license text     }
{can be used in Non-GPL projects as long as you get the permission   }
{from the Author - Guru Kathiresan.                                  }
{Use of the Code in any non-gpl projects without the permission of   }
{the author is illegal.                                              }
{Contact gururamnath@yahoo.com for details                           }
{ ****************************************************************** }

unit WxGrid;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, Grids, wxUtils, WxSizerPanel, WxAuiNotebookPage, wxAuiToolBar;

type
  TWxGrid = class(TStringGrid, IWxComponentInterface, IWxWindowInterface)
  private
    { Private fields of TWxGrid }
    FEVT_GRID_CELL_LEFT_CLICK: string;
    FEVT_GRID_CELL_RIGHT_CLICK: string;
    FEVT_GRID_CELL_LEFT_DCLICK: string;
    FEVT_GRID_CELL_RIGHT_DCLICK: string;
    FEVT_GRID_LABEL_LEFT_CLICK: string;
    FEVT_GRID_LABEL_RIGHT_CLICK: string;
    FEVT_GRID_LABEL_LEFT_DCLICK: string;
    FEVT_GRID_LABEL_RIGHT_DCLICK: string;
    FEVT_GRID_CELL_CHANGE: string;
    FEVT_GRID_SELECT_CELL: string;
    FEVT_GRID_EDITOR_HIDDEN: string;
    FEVT_GRID_EDITOR_SHOWN: string;
    FEVT_GRID_COL_SIZE: string;
    FEVT_GRID_ROW_SIZE: string;
    FEVT_GRID_RANGE_SELECT: string;
    FEVT_GRID_EDITOR_CREATED: string;
    FEVT_UPDATE_UI: string;

    { Storage for property Wx_BGColor }
    FWx_BGColor: TColor;
    FWx_LabelColSize: integer;
    FWx_LabelRowSize: integer;
    { Storage for property Wx_Border }
    FWx_Border: integer;
    { Storage for property Wx_Class }
    FWx_Class: string;
    { Storage for property Wx_ControlOrientation }
    FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_EditStyle }
    FWx_EditStyle: TWxEdtGeneralStyleSet;
    { Storage for property Wx_Enabled }
    FWx_Enabled: boolean;
    { Storage for property Wx_FGColor }
    FWx_FGColor: TColor;
    { Storage for property Wx_GeneralStyle }
    FWx_GeneralStyle: TWxStdStyleSet;
    { Storage for property Wx_HelpText }
    FWx_HelpText: string;
    { Storage for property Wx_Hidden }
    FWx_Hidden: boolean;
    { Storage for property Wx_IDName }
    FWx_IDName: string;
    { Storage for property Wx_IDValue }
    FWx_IDValue: longint;
    { Storage for property Wx_ProxyBGColorString }
    FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
    FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor: integer;
    { Storage for property Wx_ToolTip }
    FWx_ToolTip: string;
    FWx_Comments: TStrings;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    FGridSelection: TWxGridSelection;

    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;


//Aui Properties
    FWx_AuiManaged: Boolean;
    FWx_PaneCaption: string;
    FWx_PaneName: string;
    FWx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem;
    FWx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet;
    FWx_Aui_Pane_Style: TwxAuiPaneStyleSet;
    FWx_Aui_Pane_Buttons: TwxAuiPaneButtonSet;
    FWx_BestSize_Height: Integer;
    FWx_BestSize_Width: Integer;
    FWx_MinSize_Height: Integer;
    FWx_MinSize_Width: Integer;
    FWx_MaxSize_Height: Integer;
    FWx_MaxSize_Width: Integer;
    FWx_Floating_Height: Integer;
    FWx_Floating_Width: Integer;
    FWx_Floating_X_Pos: Integer;
    FWx_Floating_Y_Pos: Integer;
    FWx_Layer: Integer;
    FWx_Row: Integer;
    FWx_Position: Integer;

    { Private methods of TWxGrid }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;

    { Read method for property Wx_EditStyle }
    function GetWx_EditStyle: TWxEdtGeneralStyleSet;
    { Write method for property Wx_EditStyle }
    procedure SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);

    function GetVirtualColCount: integer;
    procedure SetVirtualColCount(Value: integer);

    function GetVirtualRowCount: integer;
    procedure SetVirtualRowCount(Value: integer);

    function GetVirtualLabelColSize: integer;
    procedure SetVirtualLabelColSize(Value: integer);
    function GetVirtualLabelRowSize: integer;
    procedure SetVirtualLabelRowSize(Value: integer);

  protected
    { Protected fields of TWxGrid }

    { Protected methods of TWxGrid }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;
    procedure Paint; override;

  public
    { Public fields and properties of TWxGrid }
    defaultBGColor: TColor;
    defaultFGColor: TColor;

    { Public methods of TWxGrid }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GenerateControlIDs: string;
    function GenerateEnumControlIDs: string;
    function GenerateEventTableEntries(CurrClassName: string): string;
    function GenerateGUIControlCreation: string;
    function GenerateXRCControlCreation(IndentString: string): TStringList;
    function GenerateGUIControlDeclaration: string;
    function GenerateHeaderInclude: string;
    function GenerateImageInclude: string;
    function GetEventList: TStringList;
    function GetIDName: string;
    function GetIDValue: longint;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: longint);
    procedure SetWxClassName(wxClassName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published properties of TWxGrid }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDrawCell;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property EVT_GRID_CELL_LEFT_CLICK: string
      Read FEVT_GRID_CELL_LEFT_CLICK Write FEVT_GRID_CELL_LEFT_CLICK;
    property EVT_GRID_CELL_RIGHT_CLICK: string
      Read FEVT_GRID_CELL_RIGHT_CLICK Write FEVT_GRID_CELL_RIGHT_CLICK;
    property EVT_GRID_CELL_LEFT_DCLICK: string
      Read FEVT_GRID_CELL_LEFT_DCLICK Write FEVT_GRID_CELL_LEFT_DCLICK;
    property EVT_GRID_CELL_RIGHT_DCLICK: string
      Read FEVT_GRID_CELL_RIGHT_DCLICK Write FEVT_GRID_CELL_RIGHT_DCLICK;
    property EVT_GRID_LABEL_LEFT_CLICK: string
      Read FEVT_GRID_LABEL_LEFT_CLICK Write FEVT_GRID_LABEL_LEFT_CLICK;
    property EVT_GRID_LABEL_RIGHT_CLICK: string
      Read FEVT_GRID_LABEL_RIGHT_CLICK Write FEVT_GRID_LABEL_RIGHT_CLICK;
    property EVT_GRID_LABEL_LEFT_DCLICK: string
      Read FEVT_GRID_LABEL_LEFT_DCLICK Write FEVT_GRID_LABEL_LEFT_DCLICK;
    property EVT_GRID_LABEL_RIGHT_DCLICK: string
      Read FEVT_GRID_LABEL_RIGHT_DCLICK Write FEVT_GRID_LABEL_RIGHT_DCLICK;
    property EVT_GRID_CELL_CHANGE: string Read FEVT_GRID_CELL_CHANGE
      Write FEVT_GRID_CELL_CHANGE;
    property EVT_GRID_SELECT_CELL: string Read FEVT_GRID_SELECT_CELL
      Write FEVT_GRID_SELECT_CELL;
    property EVT_GRID_EDITOR_HIDDEN: string
      Read FEVT_GRID_EDITOR_HIDDEN Write FEVT_GRID_EDITOR_HIDDEN;
    property EVT_GRID_EDITOR_SHOWN: string
      Read FEVT_GRID_EDITOR_SHOWN Write FEVT_GRID_EDITOR_SHOWN;
    property EVT_GRID_COL_SIZE: string Read FEVT_GRID_COL_SIZE Write FEVT_GRID_COL_SIZE;
    property EVT_GRID_ROW_SIZE: string Read FEVT_GRID_ROW_SIZE Write FEVT_GRID_ROW_SIZE;
    property EVT_GRID_RANGE_SELECT: string
      Read FEVT_GRID_RANGE_SELECT Write FEVT_GRID_RANGE_SELECT;
    property EVT_GRID_EDITOR_CREATED: string
      Read FEVT_GRID_EDITOR_CREATED Write FEVT_GRID_EDITOR_CREATED;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;

    property Wx_ColCount: integer Read GetVirtualColCount
      Write SetVirtualColCount default 5;
    property Wx_RowCount: integer Read GetVirtualRowCount
      Write SetVirtualRowCount default 5;

    property Wx_LabelColSize: integer Read GetVirtualLabelColSize
      Write SetVirtualLabelColSize default 5;
    property Wx_LabelRowSize: integer Read GetVirtualLabelRowSize
      Write SetVirtualLabelRowSize default 5;

    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_EditStyle: TWxEdtGeneralStyleSet
      Read GetWx_EditStyle Write SetWx_EditStyle;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_GridSelection: TWxGridSelection
      Read FGridSelection Write FGridSelection default wxGridSelectCells;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

//Aui Properties
    property Wx_AuiManaged: boolean read FWx_AuiManaged write FWx_AuiManaged default False;
    property Wx_PaneCaption: string read FWx_PaneCaption write FWx_PaneCaption;
    property Wx_PaneName: string read FWx_PaneName write FWx_PaneName;
    property Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem read FWx_Aui_Dock_Direction write FWx_Aui_Dock_Direction;
    property Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet read FWx_Aui_Dockable_Direction write FWx_Aui_Dockable_Direction;
    property Wx_Aui_Pane_Style: TwxAuiPaneStyleSet read FWx_Aui_Pane_Style write FWx_Aui_Pane_Style;
    property Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet read FWx_Aui_Pane_Buttons write FWx_Aui_Pane_Buttons;
    property Wx_BestSize_Height: integer read FWx_BestSize_Height write FWx_BestSize_Height default -1;
    property Wx_BestSize_Width: integer read FWx_BestSize_Width write FWx_BestSize_Width default -1;
    property Wx_MinSize_Height: integer read FWx_MinSize_Height write FWx_MinSize_Height default -1;
    property Wx_MinSize_Width: integer read FWx_MinSize_Width write FWx_MinSize_Width default -1;
    property Wx_MaxSize_Height: integer read FWx_MaxSize_Height write FWx_MaxSize_Height default -1;
    property Wx_MaxSize_Width: integer read FWx_MaxSize_Width write FWx_MaxSize_Width default -1;
    property Wx_Floating_Height: integer read FWx_Floating_Height write FWx_Floating_Height default -1;
    property Wx_Floating_Width: integer read FWx_Floating_Width write FWx_Floating_Width default -1;
    property Wx_Floating_X_Pos: integer read FWx_Floating_X_Pos write FWx_Floating_X_Pos default -1;
    property Wx_Floating_Y_Pos: integer read FWx_Floating_Y_Pos write FWx_Floating_Y_Pos default -1;
    property Wx_Layer: integer read FWx_Layer write FWx_Layer default 0;
    property Wx_Row: integer read FWx_Row write FWx_Row default 0;
    property Wx_Position: integer read FWx_Position write FWx_Position default 0;

  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxGrid with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxGrid]);
end;

{ Method to set variable and property values and create objects }
procedure TWxGrid.AutoInitialize;
begin
  FWx_EventList          := TStringList.Create;
  FWx_PropertyList       := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxGrid';
  FWx_Enabled            := True;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;
  FWx_Comments           := TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxGrid.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;

end; { of AutoDestroy }

{ Read method for property Wx_EditStyle }
function TWxGrid.GetWx_EditStyle: TWxEdtGeneralStyleSet;
begin
  Result := FWx_EditStyle;
end;

{ Write method for property Wx_EditStyle }
procedure TWxGrid.SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);
begin

end;

function TWxGrid.GetVirtualColCount: integer;
begin
  Result := ColCount - 1;
end;

procedure TWxGrid.SetVirtualColCount(Value: integer);
var
  I: integer;
begin
  if Value < 1 then
    Value := 1;

  ColCount := Value + 1;
  for I := 1 to ColCount - 1 do    // Iterate
    self.Cols[0].Strings[i] := IntToStr(i);    // for
end;

function TWxGrid.GetVirtualRowCount: integer;
begin
  Result := RowCount - 1;
end;

procedure TWxGrid.SetVirtualRowCount(Value: integer);
var
  i: integer;
  IncChar: char;
begin
  if Value < 1 then
    Value := 1;
  RowCount := Value + 1;
  IncChar := 'A';
  for I := 1 to RowCount - 1 do    // Iterate
  begin
    if IncChar = 'Z' then
      IncChar := 'A';
    self.Rows[0].Strings[i] := IncChar;
    Inc(IncChar);
  end;    // for
end;

function TWxGrid.GetVirtualLabelColSize: integer;
begin
  Result := FWx_LabelColSize;
end;

procedure TWxGrid.SetVirtualLabelColSize(Value: integer);
begin
  ColWidths[0]     := Value;
  FWx_LabelColSize := Value;
end;

function TWxGrid.GetVirtualLabelRowSize: integer;
begin
  Result := FWx_LabelRowSize;
end;

procedure TWxGrid.SetVirtualLabelRowSize(Value: integer);
begin
  RowHeights[0]    := Value;
  FWx_LabelRowSize := Value;
end;

{ Override OnClick handler from TStringGrid }
procedure TWxGrid.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TStringGrid }
procedure TWxGrid.KeyPress(var Key: char);
const
  TabKey   = char(VK_TAB);
  EnterKey = char(VK_RETURN);
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

constructor TWxGrid.Create(AOwner: TComponent);
begin
  { Call the Create method of the parent class }
  inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables and      }
  { properties; also, it creates objects for properties of       }
  { standard Delphi object types (e.g., TFont, TTimer,           }
  { TPicture) and for any variables marked as objects.           }
  { AutoInitialize method is generated by Component Create.      }
  AutoInitialize;

  self.DefaultColWidth  := 50;
  self.DefaultRowHeight := 25;

  self.Wx_LabelColSize := 50;
  self.Wx_LabelRowSize := 25;

  self.RowCount := 5;
  self.ColCount := 5;

  SetVirtualRowCount(self.RowCount);
  SetVirtualColCount(self.ColCount);

  { Code to perform other tasks when the component is created }
  PopulateGenericProperties(FWx_PropertyList);
  PopulateAuiGenericProperties(FWx_PropertyList);

  FWx_PropertyList.Add('Wx_RowCount:Row Count');
  FWx_PropertyList.Add('Wx_ColCount:Column Count');
  FWx_PropertyList.Add('DefaultColWidth:Column Width');
  FWx_PropertyList.Add('DefaultRowHeight:Row Height');
  FWx_PropertyList.Add('Wx_LabelColSize:Label Column Width');
  FWx_PropertyList.Add('Wx_LabelRowSize:Label Row Height');
  FWx_PropertyList.Add('Wx_GridSelection:Grid Selection');

  FWx_EventList.add('EVT_GRID_CELL_LEFT_CLICK:OnCellLeftClick');
  FWx_EventList.add('EVT_GRID_CELL_RIGHT_CLICK:OnCellRightClick');
  FWx_EventList.add('EVT_GRID_CELL_LEFT_DCLICK:OnCellLeftDoubleClick');
  FWx_EventList.add('EVT_GRID_CELL_RIGHT_DCLICK:OnCellRightDoubleClick');
  FWx_EventList.add('EVT_GRID_LABEL_LEFT_CLICK:OnLabelLeftClick');
  FWx_EventList.add('EVT_GRID_LABEL_RIGHT_CLICK:OnLabelRightClick');
  FWx_EventList.add('EVT_GRID_LABEL_LEFT_DCLICK:OnLabelLeftDoubleClick');
  FWx_EventList.add('EVT_GRID_LABEL_RIGHT_DCLICK:OnLabelRightDoubleClick');
  FWx_EventList.add('EVT_GRID_CELL_CHANGE:OnCellChange');
  FWx_EventList.add('EVT_GRID_SELECT_CELL:OnSelectCell');
  FWx_EventList.add('EVT_GRID_EDITOR_HIDDEN:OnEditorHidden');
  FWx_EventList.add('EVT_GRID_EDITOR_SHOWN:OnEditorShown');
  FWx_EventList.add('EVT_GRID_COL_SIZE:OnColumnSize');
  FWx_EventList.add('EVT_GRID_ROW_SIZE:OnRowSize');
  FWx_EventList.add('EVT_GRID_RANGE_SELECT:OnRangeSelect');
  FWx_EventList.add('EVT_GRID_EDITOR_CREATED:OnEditorCreated');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxGrid.Destroy;
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

procedure TWxGrid.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxGrid.Paint;
begin
     { Make this component look like its parent component by calling
       its parent's Paint method. }
  inherited Paint;

     { To change the appearance of the component, use the methods 
       supplied by the component's Canvas property (which is of 
       type TCanvas).  For example, }

  { Canvas.Rectangle(0, 0, Width, Height); }
end;


function TWxGrid.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxGrid.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxGrid.GenerateEventTableEntries(CurrClassName: string): string;
begin

  Result := '';

  if trim(EVT_GRID_CELL_LEFT_CLICK) <> '' then
    Result := Format('EVT_GRID_CELL_LEFT_CLICK(%s::%s)',
      [CurrClassName, EVT_GRID_CELL_LEFT_CLICK]) + '';

  if trim(EVT_GRID_CELL_RIGHT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_GRID_CELL_RIGHT_CLICK(%s::%s)',
      [CurrClassName, EVT_GRID_CELL_RIGHT_CLICK]) + '';

  if trim(EVT_GRID_CELL_LEFT_DCLICK) <> '' then
    Result := Result + #13 + Format('EVT_GRID_CELL_LEFT_DCLICK(%s::%s)',
      [CurrClassName, EVT_GRID_CELL_LEFT_DCLICK]) + '';

  if trim(EVT_GRID_CELL_RIGHT_DCLICK) <> '' then
    Result := Result + #13 + Format('EVT_GRID_CELL_RIGHT_DCLICK(%s::%s)',
      [CurrClassName, EVT_GRID_CELL_RIGHT_DCLICK]) + '';

  if trim(EVT_GRID_LABEL_LEFT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_GRID_LABEL_LEFT_CLICK(%s::%s)',
      [CurrClassName, EVT_GRID_LABEL_LEFT_CLICK]) + '';
  
  if trim(EVT_GRID_LABEL_RIGHT_CLICK) <> '' then
    Result := Format('EVT_GRID_LABEL_RIGHT_CLICK(%s::%s)',
      [CurrClassName, EVT_GRID_LABEL_RIGHT_CLICK]) + '';

  if trim(EVT_GRID_LABEL_LEFT_DCLICK) <> '' then
    Result := Result + #13 + Format('EVT_GRID_LABEL_LEFT_DCLICK(%s::%s)',
      [CurrClassName, EVT_GRID_LABEL_LEFT_DCLICK]) + '';

  if trim(EVT_GRID_LABEL_RIGHT_DCLICK) <> '' then
    Result := Result + #13 + Format('EVT_GRID_LABEL_RIGHT_DCLICK(%s::%s)',
      [CurrClassName, EVT_GRID_LABEL_RIGHT_DCLICK]) + '';

  if trim(EVT_GRID_CELL_CHANGE) <> '' then
    Result := Result + #13 + Format('EVT_GRID_CELL_CHANGE(%s::%s)',
      [CurrClassName, EVT_GRID_CELL_CHANGE]) + '';

  if trim(EVT_GRID_SELECT_CELL) <> '' then
    Result := Result + #13 + Format('EVT_GRID_SELECT_CELL(%s::%s)',
      [CurrClassName, EVT_GRID_SELECT_CELL]) + '';
  
  if trim(EVT_GRID_EDITOR_HIDDEN) <> '' then
    Result := Result + #13 + Format('EVT_GRID_EDITOR_HIDDEN(%s::%s)',
      [CurrClassName, EVT_GRID_EDITOR_HIDDEN]) + '';

  if trim(EVT_GRID_EDITOR_SHOWN) <> '' then
    Result := Result + #13 + Format('EVT_GRID_EDITOR_SHOWN(%s::%s)',
      [CurrClassName, EVT_GRID_EDITOR_SHOWN]) + '';

  if trim(EVT_GRID_COL_SIZE) <> '' then
    Result := Result + #13 + Format('EVT_GRID_COL_SIZE(%s::%s)',
      [CurrClassName, EVT_GRID_COL_SIZE]) + '';
  
  if trim(EVT_GRID_ROW_SIZE) <> '' then
    Result := Result + #13 + Format('EVT_GRID_ROW_SIZE(%s::%s)',
      [CurrClassName, EVT_GRID_ROW_SIZE]) + '';

  if trim(EVT_GRID_RANGE_SELECT) <> '' then
    Result := Result + #13 + Format('EVT_GRID_RANGE_SELECT(%s::%s)',
      [CurrClassName, EVT_GRID_RANGE_SELECT]) + '';
  
  if trim(EVT_GRID_EDITOR_CREATED) <> '' then
    Result := Result + #13 + Format('EVT_GRID_EDITOR_CREATED(%s::%s)',
      [CurrClassName, EVT_GRID_EDITOR_CREATED]) + '';
end;

function TWxGrid.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

    if not(UseDefaultSize)then
      Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    if not(UseDefaultPos) then
      Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetEditSpecificStyle(self.Wx_GeneralStyle, self.Wx_EditStyle)]));
    Result.Add(IndentString + '</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxGrid.GenerateGUIControlCreation: string;
var
  strColorStr, strSelectionStr: string;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);

  strStyle := GetEditSpecificStyle(self.Wx_GeneralStyle, self.Wx_EditStyle);

  if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle;

    if (XRCGEN) then
 begin
   Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]); 
  end
 else
 begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s, %s%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
end;

  if trim(self.Wx_ToolTip) <> '' then
    Result := Result + #13 + Format('%s->SetToolTip(%s);',
      [self.Name, GetCppString(self.Wx_ToolTip)]);

  if self.Wx_Hidden then
    Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

  if not Wx_Enabled then
    Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

  if trim(self.Wx_HelpText) <> '' then
    Result := Result + #13 + Format('%s->SetHelpText(%s);',
      [self.Name, GetCppString(self.Wx_HelpText)]);

  strColorStr := trim(GetwxColorFromString(InvisibleFGColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetForegroundColour(%s);',
      [self.Name, strColorStr]);

  strColorStr := trim(GetwxColorFromString(InvisibleBGColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetBackgroundColour(%s);',
      [self.Name, strColorStr]);


  strColorStr := GetWxFontDeclaration(self.Font);
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetFont(%s);', [self.Name, strColorStr]);

  strSelectionStr := GetGridSelectionToString(self.Wx_GridSelection);
  strSelectionStr := 'wxGrid::' + strSelectionStr;

  Result := Result + #13 + Format('%s->SetDefaultColSize(%d);',
    [self.Name, DefaultColWidth]);
  Result := Result + #13 + Format('%s->SetDefaultRowSize(%d);',
    [self.Name, DefaultRowHeight]);

  // I think these are reversed
  // Result:=Result+#13+Format('%s->SetColLabelSize(%d);',[self.Name,Wx_LabelColSize]);
  // Result:=Result+#13+Format('%s->SetRowLabelSize(%d);',[self.Name,Wx_LabelRowSize]);

  // I reversed these to make the grid on the designer look like the grid produced on execution
  Result := Result + #13 + Format('%s->SetRowLabelSize(%d);',
    [self.Name, Wx_LabelColSize]);
  Result := Result + #13 + Format('%s->SetColLabelSize(%d);',
    [self.Name, Wx_LabelRowSize]);

  Result := Result + #13 + Format('%s->CreateGrid(%d,%d,%s);',
    [self.Name, wx_RowCount, wx_ColCount, strSelectionStr]);

if not (XRCGEN) then //NUKLEAR ZELPH
  begin
    if (Wx_AuiManaged and FormHasAuiManager(self)) and not (self.Parent is TWxSizerPanel) then
    begin
      if HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) then
      begin
        Self.Wx_Aui_Pane_Style := Self.Wx_Aui_Pane_Style + [ToolbarPane]; //always make sure we are a toolbar
        Self.Wx_Layer := 10;
      end;

      if not HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) then
      begin
        if (self.Parent.ClassName = 'TWxPanel') then
          if not (self.Parent.Parent is TForm) then
            Result := Result + #13 + Format('%s->Reparent(this);', [parentName]);
      end;

      if (self.Parent is TWxAuiToolBar) then
        Result := Result + #13 + Format('%s->AddControl(%s);',
          [self.Parent.Name, self.Name])
      else
        Result := Result + #13 + Format('%s->AddPane(%s, wxAuiPaneInfo()%s%s%s%s%s%s%s%s%s%s%s%s);',
          [GetAuiManagerName(self), self.Name,
          GetAuiPaneName(Self.Wx_PaneName),
            GetAuiPaneCaption(Self.Wx_PaneCaption),
            GetAuiDockDirection(Self.Wx_Aui_Dock_Direction),
            GetAuiDockableDirections(self.Wx_Aui_Dockable_Direction),
            GetAui_Pane_Style(Self.Wx_Aui_Pane_Style),
            GetAui_Pane_Buttons(Self.Wx_Aui_Pane_Buttons),
            GetAuiRow(Self.Wx_Row),
            GetAuiPosition(Self.Wx_Position),
            GetAuiLayer(Self.Wx_Layer),
            GetAuiPaneBestSize(Self.Wx_BestSize_Width, Self.Wx_BestSize_Height),
            GetAuiPaneMinSize(Self.Wx_MinSize_Width, Self.Wx_MinSize_Height),
            GetAuiPaneMaxSize(Self.Wx_MaxSize_Width, Self.Wx_MaxSize_Height)]);

    end
    else
    begin
  if (self.Parent is TWxSizerPanel) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

      if (self.Parent is TWxAuiNotebookPage) then
      begin
        //        strParentLabel := TWxAuiNoteBookPage(Self.Parent).Caption;
        Result := Result + #13 + Format('%s->AddPage(%s, %s);',
          //          [self.Parent.Parent.Name, self.Name, GetCppString(strParentLabel)]);
          [self.Parent.Parent.Name, self.Name, GetCppString(TWxAuiNoteBookPage(Self.Parent).Caption)]);
      end;

      if (self.Parent is TWxAuiToolBar) then
        Result := Result + #13 + Format('%s->AddControl(%s);',
          [self.Parent.Name, self.Name]);
    end;
  end;

end;

function TWxGrid.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxGrid.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/grid.h>';
end;

function TWxGrid.GenerateImageInclude: string;
begin

end;

function TWxGrid.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxGrid.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxGrid.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxGrid.GetParameterFromEventName(EventName: string): string;
begin
  Result := '';

  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
  
  if trim(EVT_GRID_CELL_LEFT_CLICK) <> '' then
  begin
    Result := 'wxGridEvent& event';
    exit;
  end;

  if trim(EVT_GRID_CELL_RIGHT_CLICK) <> '' then
  begin
    Result := 'wxGridEvent& event';
    exit;
  end;

  if trim(EVT_GRID_CELL_LEFT_DCLICK) <> '' then
  begin
    Result := 'wxGridEvent& event';
    exit;
  end;

  if trim(EVT_GRID_CELL_RIGHT_DCLICK) <> '' then
  begin
    Result := 'wxGridEvent& event';
    exit;
  end;

  if trim(EVT_GRID_LABEL_LEFT_CLICK) <> '' then
  begin
    Result := 'wxGridEvent& event';
    exit;
  end;
  if trim(EVT_GRID_LABEL_RIGHT_CLICK) <> '' then
  begin
    Result := 'wxGridEvent& event';
    exit;
  end;

  if trim(EVT_GRID_LABEL_LEFT_DCLICK) <> '' then
  begin
    Result := 'wxGridEvent& event';
    exit;
  end;

  if trim(EVT_GRID_LABEL_RIGHT_DCLICK) <> '' then
  begin
    Result := 'wxGridEvent& event';
    exit;
  end;

  if trim(EVT_GRID_CELL_CHANGE) <> '' then
  begin
    Result := 'wxGridEvent& event';
    exit;
  end;

  if trim(EVT_GRID_SELECT_CELL) <> '' then
  begin
    Result := 'wxGridEvent& event';
    exit;
  end;
  if trim(EVT_GRID_EDITOR_HIDDEN) <> '' then
  begin
    Result := 'wxGridEvent& event';
    exit;
  end;

  if trim(EVT_GRID_EDITOR_SHOWN) <> '' then
  begin
    Result := 'wxGridEvent& event';
    exit;
  end;

  if trim(EVT_GRID_COL_SIZE) <> '' then
  begin
    Result := 'wxGridSizeEvent& event';
    exit;
  end;
  if trim(EVT_GRID_ROW_SIZE) <> '' then
  begin
    Result := 'wxGridSizeEvent& event';
    exit;
  end;

  if trim(EVT_GRID_RANGE_SELECT) <> '' then
  begin
    Result := 'wxGridRangeSelectEvent& event';
    exit;
  end;
  if trim(EVT_GRID_EDITOR_CREATED) <> '' then
  begin
    Result := 'wxGridEditorCreatedEvent& event';
    exit;
  end;


end;

function TWxGrid.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxGrid.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxGrid.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxGrid.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxGrid.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxGrid.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxGrid.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxGrid.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxGrid';
  Result := wx_Class;
end;

procedure TWxGrid.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxGrid.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxGrid.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxGrid.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxGrid.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxGrid.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxGrid.SetGenericColor(strVariableName,strValue: string);
begin

end;


function TWxGrid.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxGrid.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxGrid.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxGrid.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxGrid.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxGrid.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;


end.
