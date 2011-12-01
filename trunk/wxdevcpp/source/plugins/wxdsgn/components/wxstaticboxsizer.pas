 { ****************************************************************** }
 {                                                                    }
{ $Id: wxstaticboxsizer.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

unit WxStaticBoxSizer;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ExtCtrls, WxUtils, WxSizerPanel, wxAuiManager;

type
  TWxStaticBoxSizer = class(TWxSizerPanel, IWxComponentInterface,
    IWxContainerAndSizerInterface)
  private
    { Private fields of TWxStaticBoxSizer }
    { Storage for property Orientation }
    FOrientation: TWxSizerOrientation;
    { Storage for property Wx_Border }
    FWx_Border: integer;
    { Storage for property Wx_Caption }
    FWx_Caption: string;
    { Storage for property Wx_Class }
    FWx_Class: string;
    { Storage for property Wx_ControlOrientation }
    FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_EventList }
    FWx_EventList: TStringList;
    { Storage for property Wx_IDName }
    FWx_IDName: string;
    { Storage for property Wx_IDValue }
    FWx_IDValue: integer;
    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor: integer;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    RdGrp: TRadioGroup;

    { Private methods of TWxStaticBoxSizer }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;
    { Write method for property Wx_Caption }
    procedure SetWx_Caption(Value: string);
    { Write method for property Wx_EventList }
    procedure SetWx_EventList(Value: TStringList);

  protected
    { Protected fields of TWxStaticBoxSizer }

    { Protected methods of TWxStaticBoxSizer }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Resize; override;
    procedure Loaded; override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

  public
    { Public fields and properties of TWxStaticBoxSizer }

    { Public methods of TWxStaticBoxSizer }
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
    function GetIDValue: integer;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: integer);
    procedure SetWxClassName(wxClassName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    function GenerateLastCreationCode: string;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

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
    property Orientation: TWxSizerOrientation
      Read FOrientation Write FOrientation default wxHorizontal;
    property Wx_Caption: string Read FWx_Caption Write SetWx_Caption;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_EventList: TStringList Read FWx_EventList Write SetWx_EventList;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: integer Read FWx_IDValue Write FWx_IDValue default -1;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;
    
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
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
  FWx_PropertyList    := TStringList.Create;
  RdGrp               := TRadioGroup.Create(Self);
  RdGrp.Parent        := Self;
  FOrientation        := wxHorizontal;
  FWx_Border          := 5;
  FWx_Class           := 'wxStaticBoxSizer';
  FWx_EventList       := TStringList.Create;
  FWx_BorderAlignment := [wxAll];
  FWx_Alignment       := [wxALIGN_CENTER];
  FWx_IDValue         := -1;
  FWx_StretchFactor   := 0;
  FWx_Comments        := TStringList.Create;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxStaticBoxSizer.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  RdGrp.Destroy;
  FWx_EventList.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

{ Write method for property Wx_Caption }
procedure TWxStaticBoxSizer.SetWx_Caption(Value: string);
begin
  FWx_Caption := Value;

     { If changing this property affects the appearance of
       the component, call Invalidate here so the image will be
       updated. }
  { Invalidate; }
  self.rdGrp.Caption := Value;
end;

{ Write method for property Wx_EventList }
procedure TWxStaticBoxSizer.SetWx_EventList(Value: TStringList);
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
procedure TWxStaticBoxSizer.KeyPress(var Key: char);
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

  rdGrp.Align   := alClient;
  rdGrp.Caption := '';

  { Code to perform other tasks when the container is created    }
  FWx_PropertyList.add('Wx_StretchFactor:Stretch Factor');
  FWx_PropertyList.add('Wx_Alignment:Alignment');
  FWx_PropertyList.Add('wxALIGN_LEFT:wxALIGN_LEFT');
  FWx_PropertyList.Add('wxALIGN_RIGHT:wxALIGN_RIGHT');
  FWx_PropertyList.Add('wxALIGN_TOP:wxALIGN_TOP');
  FWx_PropertyList.Add('wxALIGN_BOTTOM:wxALIGN_BOTTOM');
  FWx_PropertyList.Add('wxALIGN_CENTER:wxALIGN_CENTER');
  FWx_PropertyList.Add('wxALIGN_CENTER_HORIZONTAL:wxALIGN_CENTER_HORIZONTAL');
  FWx_PropertyList.Add('wxALIGN_CENTER_VERTICAL:wxALIGN_CENTER_VERTICAL');
  FWx_PropertyList.Add('wxEXPAND:wxEXPAND');
  FWx_PropertyList.add('Wx_Border:Border');
  FWx_PropertyList.add('Wx_BorderAlignment:Borders');
  FWx_PropertyList.add('wxALL:wxALL');
  FWx_PropertyList.add('wxTOP:wxTOP');
  FWx_PropertyList.add('wxLEFT:wxLEFT');
  FWx_PropertyList.add('wxRIGHT:wxRIGHT');
  FWx_PropertyList.add('wxBOTTOM:wxBOTTOM');

  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Orientation:Orientation');
  FWx_PropertyList.add('wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Caption:Caption');
  FWx_PropertyList.add('Wx_Comments:Comments');
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

function TWxStaticBoxSizer.GenerateEnumControlIDs: string;
begin
  Result := '';
  //     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
  //        Result:=Format('%s = %d , ',[Wx_IDName,Wx_IDValue]);
end;

function TWxStaticBoxSizer.GenerateControlIDs: string;
begin
  Result := '';
  //     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
  //        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;

function TWxStaticBoxSizer.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TWxStaticBoxSizer.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  strOrientation: string;
  i: integer;
  wxcompInterface: IWxComponentInterface;
  tempstring: TStringList;
begin

  Result := TStringList.Create;

  try
 if (self.Parent is TForm) then //NUKLEAR ZELPH
 begin
     Result.Add(IndentString + Format('<!--object class="%s" name="%s"-->',
      [self.Wx_Class, self.Name]));

    if Orientation = wxVertical then
      strOrientation := 'wxVERTICAL'
    else
      strOrientation := 'wxHORIZONTAL';

    Result.Add(IndentString + Format('  <!--orient>%s</orient-->', [strOrientation]));
    Result.Add(IndentString + Format('  <!--label>%s</label-->', [self.Wx_Caption]));
 end
 else
 begin
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));

    if Orientation = wxVertical then
      strOrientation := 'wxVERTICAL'
    else
      strOrientation := 'wxHORIZONTAL';

    Result.Add(IndentString + Format('  <orient>%s</orient>', [strOrientation]));
    Result.Add(IndentString + Format('  <label>%s</label>', [self.Wx_Caption]));
end;//NUKLEAR ZELPH
    
    for i := 0 to self.ControlCount - 1 do // Iterate
      if self.Controls[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
        // Only add the XRC control if it is a child of the top-most parent (the form)
        //  If it is a child of a sizer, panel, or other object, then it's XRC code
        //  is created in GenerateXRCControlCreation of that control.
        if (self.Controls[i].GetParentComponent.Name = self.Name) then
        begin
	   tempstring  := TStringList.Create;
	   if (self.Parent is TForm) then
           begin
	    tempstring.Add('    ' + IndentString + '<!--sizeritem-->' );
	    tempstring.Add('      ' + IndentString + '<!--option>' + IntToStr(wxcompInterface.GetStretchFactor) + '</option-->');
	    tempstring.Add('      ' + IndentString + '<!--border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border-->');
	    tempstring.Add('      ' + IndentString + '<!--flag>' + BorderAlignmentToStr(wxcompInterface.GetBorderAlignment) + '</flag-->');
	  end
	  else
	  begin
	    tempstring.Add('    ' + IndentString + '<sizeritem>' );
	    tempstring.Add('      ' + IndentString + '<option>' + IntToStr(wxcompInterface.GetStretchFactor) + '</option>');
	    tempstring.Add('      ' + IndentString + '<border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
	    tempstring.Add('      ' + IndentString + '<flag>' + BorderAlignmentToStr(wxcompInterface.GetBorderAlignment) + '</flag>');
	  end;
	  tempstring.AddStrings(wxcompInterface.GenerateXRCControlCreation('        ' + IndentString));  
	  if (self.Parent is TForm) then
	    tempstring.Add('    ' + IndentString + '<!--/sizeritem-->')
	  else
	    tempstring.Add('    ' + IndentString + '</sizeritem>');
	
          try
            Result.AddStrings(tempstring)
          finally
            tempstring.Free
          end
        end; // for
	  
if (self.Parent is TForm) then //NUKLEAR ZELPH
    Result.Add(IndentString + '<!--/object-->')
 else
    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxStaticBoxSizer.GenerateGUIControlCreation: string;

  function HasAuiManagedForm: Boolean;
  var
    I: Integer;
    isAuimanagerAvailable: Boolean;
  wxAuimanagerInterface: IWxAuiManagerInterface;
  begin
    isAuimanagerAvailable := False;
    if self.Parent.Parent is TForm then
    begin
      //MN detect whether there is a wxAuiManager component
      for I := self.Parent.Parent.ComponentCount - 1 downto 0 do // Iterate
      begin
          if self.Parent.Parent.Components[i].ClassName = 'TWxAuiManager' then
        //if self.Parent.Parent.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface) then
          isAuimanagerAvailable := True;
        break;
      end; // for
    end;
    Result :=  isAuimanagerAvailable;
  end;

var
  strOrientation, strAlignment, staticBoxName: string;
  parentName:  string;
begin
Result := '';
if not (XRCGEN) or ((XRCGEN) and (self.Parent is TForm)) then //NUKLEAR ZELPH
begin
  if Orientation = wxVertical then
    strOrientation := 'wxVERTICAL'
  else
    strOrientation := 'wxHORIZONTAL';

  staticBoxName := self.Name + '_StaticBoxObj';

  parentName := GetWxWidgetParent(self, False);

  Result     := GetCommentString(self.FWx_Comments.Text) +
    Format('wxStaticBox* %s = new wxStaticBox(%s, wxID_ANY, %s);',
    [staticBoxName, parentName, GetCppString(self.Wx_Caption)]);
  Result     := Result + #13 +
    Format('%s = new wxStaticBoxSizer(%s, %s);',
    [self.Name, staticBoxName, strOrientation]);
  parentName := self.Parent.Name;

  if ((self.Parent is TForm) or (IsControlWxContainer(self.Parent))) then
  begin
    if (self.Parent is TForm) then
      parentName := 'this'
    else if (self.Parent.ClassName = 'TWxPanel') then
        if self.Parent.Parent is TForm and not HasAuiManagedForm then
	parentName := self.Parent.Name  //'this'
      else if (self.Parent.Parent.ClassName <> 'TWxNotebook') then
	parentName := self.Parent.Name
      else
	parentName := self.Parent.Parent.Name
    else
      parentName := self.Parent.Name;

      if parentName = '' then
        parentName := self.Parent.Name;
        
    Result := Result + #13 + Format('%s->SetSizer(%s);', [parentName, self.Name]);
    Result := Result + #13 + Format('%s->SetAutoLayout(true);', [parentName]);
  end
  else begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
      [parent.Name, self.Name, self.Wx_StretchFactor, strAlignment, self.Wx_Border]);

  end;
 end;//NUKLEAR ZELPH
end;

function TWxStaticBoxSizer.GenerateGUIControlDeclaration: string;
begin
Result := '';
if not (XRCGEN) or ((XRCGEN) and (self.Parent is TForm)) then //NUKLEAR ZELPH
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxStaticBoxSizer.GenerateHeaderInclude: string;
begin
  Result:='#include <wx/sizer.h>';
end;

function TWxStaticBoxSizer.GenerateImageInclude: string;
begin

end;

function TWxStaticBoxSizer.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxStaticBoxSizer.GetIDName: string;
begin
  //Result:=wx_IDName;
end;

function TWxStaticBoxSizer.GetIDValue: integer;
begin
  Result := wx_IDValue;
end;

function TWxStaticBoxSizer.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_BUTTON' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;

end;

function TWxStaticBoxSizer.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxStaticBoxSizer.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxStaticBoxSizer.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxStaticBoxSizer.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxStaticBoxSizer.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxStaticBoxSizer.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxStaticBoxSizer.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxStaticBoxSizer.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxStaticBoxSizer';
  Result := wx_Class;
end;

procedure TWxStaticBoxSizer.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxStaticBoxSizer.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxStaticBoxSizer.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxStaticBoxSizer.SetIDValue(IDValue: integer);
begin
  Wx_IDValue := IDValue;
end;

procedure TWxStaticBoxSizer.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxStaticBoxSizer.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

procedure TWxStaticBoxSizer.WMPaint(var Message: TWMPaint);
var
  maxWidth, maxHt: integer;
  totalmaxWidth, totalmaxHt: integer;
  controlWidth, controlHeight, controlBorder: integer;
  startX, startY: integer;
  coordTop, coordLeft: integer;
  i:      integer;
  wxcompInterface: IWxComponentInterface;
  cntIntf: IWxContainerInterface;
  splitIntf: IWxSplitterInterface; 

begin
  maxHt         := 0;
  maxWidth      := 0;
  totalmaxWidth := 10;
  totalmaxHt    := 20;
  self.Caption  := '';

  for i := 0 to self.ControlCount - 1 do
  begin
    //Is this child a non-visible component?
    if IsControlWxNonVisible(Controls[i]) or (self.Controls[i] is TRadioGroup) then
      continue;
    
    //Calculate how much space this child component needs
    totalmaxWidth := totalmaxWidth + Controls[i].Width;
    totalmaxHt    := totalmaxHt + Controls[i].Height;
    controlWidth  := Controls[i].Width;
    controlHeight := Controls[i].Height;

    //Add the child's borders
    if Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) and
       (not (Controls[i] is TWxSizerPanel)) then
    begin
      if (wxLEFT in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
      begin
        totalmaxWidth := totalMaxWidth + wxCompInterface.GetBorderWidth;
        controlWidth := controlWidth + wxCompInterface.GetBorderWidth;
      end;
      if (wxRIGHT in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
      begin
        totalmaxWidth := totalMaxWidth + wxCompInterface.GetBorderWidth;
        controlWidth := controlWidth + wxCompInterface.GetBorderWidth;
      end;
      if (wxTOP in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
      begin
        totalmaxHt := totalmaxHt + wxCompInterface.GetBorderWidth;
        controlHeight := controlHeight + wxCompInterface.GetBorderWidth;
      end;
      if (wxBOTTOM in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
      begin
        totalmaxHt := totalmaxHt + wxCompInterface.GetBorderWidth;
        controlHeight := controlHeight + wxCompInterface.GetBorderWidth;
      end;
    end;

    //Determine the maximum height/width
    if controlWidth > maxWidth then
      maxWidth := controlWidth;

    if controlHeight > maxHt then
      maxHt := controlHeight;
  end;

  if self.Parent is TForm then
  begin
    self.Align := alClient;
  end
  else
  begin
    if self.parent.GetInterface(IDD_IWxContainerInterface, cntIntf) then
    begin
      if self.parent.GetInterface(IID_IWxSplitterInterface, splitIntf) then
      begin
        self.Align := alNone;
      end
      else
        self.Align := alClient;
    end
    else
      self.Align := alNone;

    if self.Orientation = wxHorizontal then
    begin
      if totalmaxWidth = 0 then
        self.Width := 20
      else
        self.Width := totalmaxWidth;
      self.Height := maxHt + 20;
    end
    else
    begin
      if totalmaxHt = 0 then
        self.Width := 20
      else
        self.Height := totalmaxHt;
      self.Width := maxWidth + 10;
    end;
  end;

  //Initialize the starting coordinates
  startY := 15;
  startX := 5;

  if Orientation = wxHorizontal then
    for i := 0 to self.ControlCount - 1 do
    begin
      if IsControlWxNonVisible(Controls[i]) or (self.Controls[i] = RdGrp) then
        continue;

      //Set the raw available width
      coordTop := maxHt - self.Controls[i].Height;
      controlBorder := 0;

      //Subtract the top and bottom borders
      if Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) and
         (not (Controls[i] is TWxSizerPanel)) then
      begin
        if (not (Controls[i] is TWxSizerPanel)) and ((wxTOP in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment)) then
        begin
          controlBorder := wxCompInterface.GetBorderWidth;
          coordTop := coordTop - wxCompInterface.GetBorderWidth;
        end;
        if (not (Controls[i] is TWxSizerPanel)) and ((wxBOTTOM in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment)) then
          coordTop := coordTop - wxCompInterface.GetBorderWidth;
        if (wxLEFT in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
          startX := startX + wxCompInterface.GetBorderWidth;
      end;

      //Shift the controls
      self.Controls[i].Top := startY + controlBorder + coordTop div 2;
      self.Controls[i].left := startX;

      //Add the width to the total width
      startX  := startX + self.Controls[i].Width;

      //See if this object implements the object interfaces: add the right border
      if Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) and
         (not (Controls[i] is TWxSizerPanel)) then
      begin
        if (wxRIGHT in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
          startX := startX + wxCompInterface.GetBorderWidth;
      end;
    end
  else
  begin
    for i := 0 to self.ControlCount - 1 do
    begin
      if IsControlWxNonVisible(Controls[i]) or (self.Controls[i] = RdGrp) then
        continue;

      //Get the raw space left
      controlBorder := 0;
      coordLeft := maxWidth - self.Controls[i].Width;

      //Add the top border and add the left and right borders
      if Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) and
         (not (Controls[i] is TWxSizerPanel)) then
      begin
        if (not (Controls[i] is TWxSizerPanel)) and ((wxLEFT in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment)) then
        begin
          controlBorder := wxCompInterface.GetBorderWidth;
          coordLeft := coordLeft - wxCompInterface.GetBorderWidth;
        end;
        if (not (Controls[i] is TWxSizerPanel)) and ((wxRIGHT in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment)) then
          coordLeft := coordLeft - wxCompInterface.GetBorderWidth;
        if (wxTOP in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
          startY := startY + wxCompInterface.GetBorderWidth;
      end;

      //Set the positions of the control
      self.Controls[i].left := startX + controlBorder + (coordLeft div 2);
      self.Controls[i].Top := startY;

      //Add the height of the last control laid out
      startY := startY + self.Controls[i].Height;

      //Add the bottom border
      if Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) and
         (not (Controls[i] is TWxSizerPanel)) then
      begin
        if (wxBOTTOM in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
          startY := startY + wxCompInterface.GetBorderWidth;
      end;
    end;
  end;

  inherited;

end;

function TWxStaticBoxSizer.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxStaticBoxSizer.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxStaticBoxSizer.GetFGColor: string;
begin
end;

procedure TWxStaticBoxSizer.SetFGColor(strValue: string);
begin
end;

function TWxStaticBoxSizer.GetBGColor: string;
begin
end;

procedure TWxStaticBoxSizer.SetBGColor(strValue: string);
begin
end;

function TWxStaticBoxSizer.GenerateLastCreationCode: string;
begin
  Result := '';
end;


end.
