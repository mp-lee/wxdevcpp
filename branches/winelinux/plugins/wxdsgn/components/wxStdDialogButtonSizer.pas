//******************************************************************
//
// Name:        components/wxStdDialogButtonSizer.pas
// Author:      Joel Low
// Modified:    19th November 2006, 4:33 PM
// Description: wxStdDialogButtonSizer implementation
//
//******************************************************************

unit wxStdDialogButtonSizer;

interface

uses Classes, WinProcs, Messages, WinTypes, SysUtils, StdCtrls, Forms, Controls,
  wxUtils, WxSizerPanel;

type
  TWxStdDialogButtonSizer = class(TWxSizerPanel, IWxComponentInterface)
  private
    FWx_Border: integer;
    FWx_Class: string;
    FWx_EventList: TStringList;
    FWx_IDName: string;
    FWx_IDValue: integer;
    FWx_StretchFactor: integer;
    FWx_PropertyList: TStringList;
    FWx_Buttons: TWxStdDialogButtons;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;

    FEVT_OK_BUTTON: string;
    FEVT_OK_UPDATE_UI: string;
    FEVT_YES_BUTTON: string;
    FEVT_YES_UPDATE_UI: string;
    FEVT_SAVE_BUTTON: string;
    FEVT_SAVE_UPDATE_UI: string;
    FEVT_APPLY_BUTTON: string;
    FEVT_APPLY_UPDATE_UI: string;
    FEVT_NO_BUTTON: string;
    FEVT_NO_UPDATE_UI: string;
    FEVT_CANCEL_BUTTON: string;
    FEVT_CANCEL_UPDATE_UI: string;
    FEVT_HELP_BUTTON: string;
    FEVT_HELP_UPDATE_UI: string;
    FEVT_CONTEXT_HELP_BUTTON: string;
    FEVT_CONTEXT_HELP_UPDATE_UI: string;

    { Private methods of TWxStdDialogButtonSizer }
    procedure AutoInitialize;
    procedure AutoDestroy;
    procedure SetWx_EventList(Value: TStringList);
    procedure SetWx_Buttons(Buttons: TWxStdDialogButtons);

  protected
    { Protected methods of TWxStdDialogButtonSizer }
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

  public
    { Public methods of TWxStdDialogButtonSizer }
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
    function GetGenericColor(strVariableName: string): string;
    procedure SetGenericColor(strVariableName, strValue: string);

    function GenerateLastCreationCode: string;
    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);
    
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
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_EventList: TStringList Read FWx_EventList Write SetWx_EventList;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: integer Read FWx_IDValue Write FWx_IDValue default -1;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_Buttons: TWxStdDialogButtons Read FWx_Buttons Write SetWx_Buttons;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;
    
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property EVT_OK_BUTTON: string read FEVT_OK_BUTTON write FEVT_OK_BUTTON;
    property EVT_OK_UPDATE_UI: string read FEVT_OK_UPDATE_UI write FEVT_OK_UPDATE_UI;
    property EVT_YES_BUTTON: string read FEVT_YES_BUTTON write FEVT_YES_BUTTON;
    property EVT_YES_UPDATE_UI: string read FEVT_YES_UPDATE_UI write FEVT_YES_UPDATE_UI;
    property EVT_SAVE_BUTTON: string read FEVT_SAVE_BUTTON write FEVT_SAVE_BUTTON;
    property EVT_SAVE_UPDATE_UI: string read FEVT_SAVE_UPDATE_UI write FEVT_SAVE_UPDATE_UI;
    property EVT_APPLY_BUTTON: string read FEVT_APPLY_BUTTON write FEVT_APPLY_BUTTON;
    property EVT_APPLY_UPDATE_UI: string read FEVT_APPLY_UPDATE_UI write FEVT_APPLY_UPDATE_UI;
    property EVT_NO_BUTTON: string read FEVT_NO_BUTTON write FEVT_NO_BUTTON;
    property EVT_NO_UPDATE_UI: string read FEVT_NO_UPDATE_UI write FEVT_NO_UPDATE_UI;
    property EVT_CANCEL_BUTTON: string read FEVT_CANCEL_BUTTON write FEVT_CANCEL_BUTTON;
    property EVT_CANCEL_UPDATE_UI: string read FEVT_CANCEL_UPDATE_UI write FEVT_CANCEL_UPDATE_UI;
    property EVT_HELP_BUTTON: string read FEVT_HELP_BUTTON write FEVT_HELP_BUTTON;
    property EVT_HELP_UPDATE_UI: string read FEVT_HELP_UPDATE_UI write FEVT_HELP_UPDATE_UI;
    property EVT_CONTEXT_HELP_BUTTON: string read FEVT_CONTEXT_HELP_BUTTON write FEVT_CONTEXT_HELP_BUTTON;
    property EVT_CONTEXT_HELP_UPDATE_UI: string read FEVT_CONTEXT_HELP_UPDATE_UI write FEVT_CONTEXT_HELP_UPDATE_UI;

  end;

implementation

procedure TWxStdDialogButtonSizer.AutoInitialize;
begin
  FWx_PropertyList    := TStringList.Create;
  FWx_Border          := 5;
  FWx_Class           := 'wxStdDialogButtonSizer';
  FWx_EventList       := TStringList.Create;
  FWx_BorderAlignment := [wxAll];
  FWx_Alignment       := [wxALIGN_CENTER];
  Wx_Buttons          := [wxID_OK, wxID_CANCEL];
  FWx_IDValue         := -1;
  ControlStyle        := [];
end;

procedure TWxStdDialogButtonSizer.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
end;

procedure TWxStdDialogButtonSizer.SetWx_EventList(Value: TStringList);
begin
  FWx_EventList.Assign(Value);
end;

constructor TWxStdDialogButtonSizer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoInitialize;

  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Orientation:Orientation');

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

  FWx_PropertyList.add('Wx_Buttons:Buttons');
  FWx_PropertyList.add('wxID_OK:wxID_OK');
  FWx_PropertyList.add('wxID_YES:wxID_YES');
  FWx_PropertyList.add('wxID_SAVE:wxID_SAVE');
  FWx_PropertyList.add('wxID_APPLY:wxID_APPLY');
  FWx_PropertyList.add('wxID_NO:wxID_NO');
  FWx_PropertyList.add('wxID_CANCEL:wxID_CANCEL');
  FWx_PropertyList.add('wxID_HELP:wxID_HELP');
  FWx_PropertyList.add('wxID_CONTEXT_HELP:wxID_CONTEXT_HELP');

  FWx_EventList.add('EVT_OK_BUTTON:OnOkClick');
  FWx_EventList.add('EVT_OK_UPDATE_UI:OnOkUpdateUI');
  FWx_EventList.add('EVT_YES_BUTTON:OnYesClick');
  FWx_EventList.add('EVT_YES_UPDATE_UI:OnYesUpdateUI');
  FWx_EventList.add('EVT_SAVE_BUTTON:OnSaveClick');
  FWx_EventList.add('EVT_SAVE_UPDATE_UI:OnSaveUpdateUI');
  FWx_EventList.add('EVT_APPLY_BUTTON:OnApplyClick');
  FWx_EventList.add('EVT_APPLY_UPDATE_UI:OnApplyUpdateUI');
  FWx_EventList.add('EVT_NO_BUTTON:OnNoClick');
  FWx_EventList.add('EVT_NO_UPDATE_UI:OnNoUpdateUI');
  FWx_EventList.add('EVT_CANCEL_BUTTON:OnCancelClick');
  FWx_EventList.add('EVT_CANCEL_UPDATE_UI:OnCancelUpdateUI');
  FWx_EventList.add('EVT_HELP_BUTTON:OnHelpClick');
  FWx_EventList.add('EVT_HELP_UPDATE_UI:OnHelpUpdateUI');
  FWx_EventList.add('EVT_CONTEXT_HELP_BUTTON:OnContextHelpClick');
  FWx_EventList.add('EVT_CONTEXT_HELP_UPDATE_UI:OnContextHelpUpdateUI');

end;

destructor TWxStdDialogButtonSizer.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

function TWxStdDialogButtonSizer.GenerateXRCControlCreation(IndentString: string): TStringList;
 var
  i: integer;
  wxcompInterface: IWxComponentInterface;
  tempstring: TStringList;
begin
  Result := TStringList.Create;
  //NUKLEAR ZELPH no creation without sizer parent, check unneded
  Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
   
  if wxID_OK in Wx_Buttons then
  begin
    Result.Add(IndentString + '  <object class="button">');
    Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment)  + '</flag>');
    Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
    Result.Add(IndentString + '    <object class="wxButton" name="wxID_OK">');
    Result.Add(IndentString + '    <label>&amp;Ok</label>');
    Result.Add(IndentString + '    </object>');
    Result.Add(IndentString + '  </object>');
          end
	  
  else if wxID_YES in Wx_Buttons then
  begin
    Result.Add(IndentString + '  <object class="button">');
    Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment)  + '</flag>');
    Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
    Result.Add(IndentString + '    <object class="wxButton" name="wxID_YES">');
    Result.Add(IndentString + '    <label>&amp;Yes</label>');
    Result.Add(IndentString + '    </object>');
    Result.Add(IndentString + '  </object>');
  end

  else if wxID_SAVE in Wx_Buttons then
  begin
    Result.Add(IndentString + '  <object class="button">');
    Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment)  + '</flag>');
    Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
    Result.Add(IndentString + '    <object class="wxButton" name="wxID_SAVE">');
    Result.Add(IndentString + '    <label>&amp;Save</label>');
    Result.Add(IndentString + '    </object>');
    Result.Add(IndentString + '  </object>');
  end;

  if wxID_APPLY in Wx_Buttons then
  begin
    Result.Add(IndentString + '  <object class="button">');
    Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment)  + '</flag>');
    Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
    Result.Add(IndentString + '    <object class="wxButton" name="wxID_APPLY">');
    Result.Add(IndentString + '    <label>&amp;Apply</label>');
    Result.Add(IndentString + '    </object>');
    Result.Add(IndentString + '  </object>');
  end;

  if wxID_NO in Wx_Buttons then
  begin
    Result.Add(IndentString + '  <object class="button">');
    Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment)  + '</flag>');
    Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
    Result.Add(IndentString + '    <object class="wxButton" name="wxID_NO">');
    Result.Add(IndentString + '    <label>&amp;No</label>');
    Result.Add(IndentString + '    </object>');
    Result.Add(IndentString + '  </object>');
  end;

  if wxID_CANCEL in Wx_Buttons then
  begin
    Result.Add(IndentString + '  <object class="button">');
    Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment)  + '</flag>');
    Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
    Result.Add(IndentString + '    <object class="wxButton" name="wxID_CANCEL">');
    Result.Add(IndentString + '    <label>&amp;Cancel</label>');
    Result.Add(IndentString + '    </object>');
    Result.Add(IndentString + '  </object>');
  end;

  if wxID_HELP in Wx_Buttons then
  begin
    Result.Add(IndentString + '  <object class="button">');
    Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment)  + '</flag>');
    Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
    Result.Add(IndentString + '    <object class="wxButton" name="wxID_HELP">');
    Result.Add(IndentString + '    <label>&amp;Help</label>');
    Result.Add(IndentString + '    </object>');
    Result.Add(IndentString + '  </object>');
  end

  else if wxID_CONTEXT_HELP in Wx_Buttons then
  begin
    Result.Add(IndentString + '  <object class="button">');
    Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment)  + '</flag>');
    Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
    Result.Add(IndentString + '    <object class="wxButton" name="wxID_CONTEXT_HELP">');
    Result.Add(IndentString + '    <label>?</label>');
    Result.Add(IndentString + '    </object>');
    Result.Add(IndentString + '  </object>');
  end;
 
   //NUKLEAR ZELPH no creation without sizer parent, check unneeded
    Result.Add(IndentString + '</object>')
end;

function TWxStdDialogButtonSizer.GenerateGUIControlCreation: string;
var
  strAlignment: string;
begin

  if trim(Result) <> '' then
          Result := Result + #13;

  if not (XRCGEN) then //Nuklear Zelph
  begin
  //Create the sizer
  Result := Format('%s = new %s;', [self.Name, self.wx_Class]);
    if wxID_OK in FWx_Buttons then
    begin
      Result := Result + #13 + 'btnOK = new wxButton( this, wxID_OK );';
      Result := Result + #13 + Format('%s->AddButton( btnOK );',[self.Name]);
    end
    else if wxID_YES in FWx_Buttons then
    begin
      Result := Result + #13 + 'btnYES = new wxButton( this, wxID_YES );';
      Result := Result + #13 + Format('%s->AddButton( btnYES );',[self.Name]);
    end
    else if wxID_SAVE in FWx_Buttons then
    begin
      Result := Result + #13 + 'btnSAVE = new wxButton( this, wxID_SAVE );';
      Result := Result + #13 + Format('%s->AddButton( btnSAVE );',[self.Name]);
    end;

    if wxID_APPLY in FWx_Buttons then
    begin
      Result := Result + #13 + 'btnAPPLY = new wxButton( this, wxID_APPLY );';
      Result := Result + #13 + Format('%s->AddButton( btnAPPLY );',[self.Name]);
    end;

    if wxID_NO in FWx_Buttons then
    begin
      Result := Result + #13 + 'btnNO = new wxButton( this, wxID_NO );';
      Result := Result + #13 + Format('%s->AddButton( btnNO );',[self.Name]);
    end;

    if wxID_CANCEL in FWx_Buttons then
    begin
      Result := Result + #13 + 'btnCANCEL = new wxButton( this, wxID_CANCEL );';
      Result := Result + #13 + Format('%s->AddButton( btnCANCEL );',[self.Name]);
    end;

    if wxID_HELP in FWx_Buttons then
    begin
      Result := Result + #13 + 'btnHELP = new wxButton( this, wxID_HELP );';
      Result := Result + #13 + Format('%s->AddButton( btnHELP );',[self.Name]);
    end

    else if wxID_CONTEXT_HELP in FWx_Buttons then
    begin
      Result := Result + #13 + 'btnCtxHELP = new wxButton( this, wxID_CONTEXT_HELP );';
      Result := Result + #13 + Format('%s->AddButton( btnCtxHELP );',[self.Name]);
  end;
  Result := Result + #13 + Format('%s->Realize();',[self.Name]);

  //Add the sizer unto our global sizer
  strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
  Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
    [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
    self.Wx_Border]);
  end;//Nuklear Zelph
end;

procedure TWxStdDialogButtonSizer.SetWx_Buttons(Buttons: TWxStdDialogButtons);
  procedure CreateButton(capt: string);
  var
    Button: TButton;
  begin
    Button := TButton.Create(Self);
    Button.Parent := Self;
    Button.Caption := capt;
    Button.Height := 23;
    Button.Show;
  end;
begin
  //Set the buttons
  FWx_Buttons := Buttons;

  //Clear the current buttons that we have
  while ControlCount > 0 do
    Controls[0].Destroy;

  //Then add the buttons. Buttons are always added affirmative, negative, cancel,
  //apply the help under Windows.
  if wxID_OK in Buttons then
    CreateButton('OK')
  else
  begin
  if wxID_YES in Buttons then
      CreateButton('Yes')
    else if wxID_SAVE in Buttons then
      CreateButton('Save');
  end;

  if wxID_NO in Buttons then
    CreateButton('No');
  if wxID_CANCEL in Buttons then
    CreateButton('Cancel');
  if wxID_APPLY in Buttons then
    CreateButton('Apply');

  if wxID_HELP in Buttons then
    CreateButton('Help')
  else if wxID_CONTEXT_HELP in Buttons then
    CreateButton('?');

  //Force a redraw
  Refresh;
  Update;
end;

function TWxStdDialogButtonSizer.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxStdDialogButtonSizer.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxStdDialogButtonSizer.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

    if wxID_OK in FWx_Buttons then
    begin
      if trim(EVT_OK_BUTTON) <> '' then
        Result := Format('EVT_BUTTON(%s, %s::%s)', ['wxID_OK', CurrClassName,
          EVT_OK_BUTTON]) + '';

      if trim(EVT_OK_UPDATE_UI) <> '' then
        Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
          ['wxID_OK', CurrClassName, EVT_OK_UPDATE_UI]) + '';
    end
    else if wxID_YES in FWx_Buttons then
    begin
      if trim(EVT_YES_BUTTON) <> '' then
      begin
      if trim(Result) <> '' then
          Result := Result + #13;

        Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_YES', CurrClassName,
          EVT_YES_BUTTON]) + '';
      end;

      if trim(EVT_YES_UPDATE_UI) <> '' then
        Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
          ['wxID_YES', CurrClassName, EVT_YES_UPDATE_UI]) + '';
    end
    else if wxID_SAVE in FWx_Buttons then
    begin
      if trim(EVT_SAVE_BUTTON) <> '' then
      begin
      if trim(Result) <> '' then
          Result := Result + #13;

        Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_SAVE', CurrClassName,
          EVT_SAVE_BUTTON]) + '';
      end;

      if trim(EVT_YES_UPDATE_UI) <> '' then
        Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
          ['wxID_SAVE', CurrClassName, EVT_SAVE_UPDATE_UI]) + '';
    end;

    if wxID_APPLY in FWx_Buttons then
    begin
      if trim(EVT_APPLY_BUTTON) <> '' then
      begin
        if trim(Result) <> '' then
          Result := Result + #13;

        Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_APPLY', CurrClassName,
          EVT_APPLY_BUTTON]) + '';
      end;

      if trim(EVT_APPLY_UPDATE_UI) <> '' then
        Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
          ['wxID_APPLY', CurrClassName, EVT_APPLY_UPDATE_UI]) + '';
    end;

    if wxID_NO in FWx_Buttons then
    begin
      if trim(EVT_NO_BUTTON) <> '' then
      begin
        if trim(Result) <> '' then
          Result := Result + #13;

        Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_NO', CurrClassName,
          EVT_NO_BUTTON]) + '';
      end;

      if trim(EVT_NO_UPDATE_UI) <> '' then
        Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
          ['wxID_NO', CurrClassName, EVT_NO_UPDATE_UI]) + '';
    end;

    if wxID_CANCEL in FWx_Buttons then
    begin
      if trim(EVT_CANCEL_BUTTON) <> '' then
      begin
        if trim(Result) <> '' then
          Result := Result + #13;

        Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_CANCEL', CurrClassName,
          EVT_CANCEL_BUTTON]) + '';
      end;

      if trim(EVT_CANCEL_UPDATE_UI) <> '' then
        Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
          ['wxID_CANCEL', CurrClassName, EVT_CANCEL_UPDATE_UI]) + '';
    end;

    if wxID_HELP in FWx_Buttons then
    begin
      if trim(EVT_HELP_BUTTON) <> '' then
      begin
        if trim(Result) <> '' then
          Result := Result + #13;

        Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_HELP', CurrClassName,
          EVT_HELP_BUTTON]) + '';
      end;
      if trim(EVT_HELP_UPDATE_UI) <> '' then
        Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
          ['wxID_HELP', CurrClassName, EVT_HELP_UPDATE_UI]) + '';
    end
    
    else if wxID_CONTEXT_HELP in FWx_Buttons then
    begin
      if trim(EVT_CONTEXT_HELP_BUTTON) <> '' then
      begin
        if trim(Result) <> '' then
          Result := Result + #13;

        Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_CONTEXT_HELP', CurrClassName,
          EVT_HELP_BUTTON]) + '';
      end;
      if trim(EVT_HELP_UPDATE_UI) <> '' then
        Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
          ['wxID_CONTEXT_HELP', CurrClassName, EVT_HELP_UPDATE_UI]) + '';
  end;

end;

function TWxStdDialogButtonSizer.GenerateGUIControlDeclaration: string;
begin
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
      if wxID_OK in FWx_Buttons then
    begin
      Result := Result + #13 + 'wxButton *btnOK;';
    end
    else if wxID_YES in FWx_Buttons then
    begin
      Result := Result + #13 + 'wxButton *btnYES;';
    end
    else if wxID_SAVE in FWx_Buttons then
    begin
      Result := Result + #13 + 'wxButton *btnSAVE;';
    end;

    if wxID_APPLY in FWx_Buttons then
    begin
      Result := Result + #13 + 'wxButton *btnAPPLY;';
    end;

    if wxID_NO in FWx_Buttons then
    begin
      Result := Result + #13 + 'wxButton *btnNO;';
    end;

    if wxID_CANCEL in FWx_Buttons then
    begin
      Result := Result + #13 + 'wxButton *btnCANCEL;';
    end;

    if wxID_HELP in FWx_Buttons then
    begin
      Result := Result + #13 + 'wxButton *btnHELP;';
    end

    else if wxID_CONTEXT_HELP in FWx_Buttons then
    begin
      Result := Result + #13 + 'wxButton *btnCtxHELP;';
  end;

end;

function TWxStdDialogButtonSizer.GenerateHeaderInclude: string;
begin
  Result := '#include <wx/sizer.h>';
end;

function TWxStdDialogButtonSizer.GenerateImageInclude: string;
begin
end;

function TWxStdDialogButtonSizer.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxStdDialogButtonSizer.GetIDName: string;
begin
  Result := '';
end;

function TWxStdDialogButtonSizer.GetIDValue: integer;
begin
  Result := wx_IDValue;
end;

function TWxStdDialogButtonSizer.GetParameterFromEventName(EventName: string): string;
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

function TWxStdDialogButtonSizer.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxStdDialogButtonSizer.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxStdDialogButtonSizer.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxStdDialogButtonSizer.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxStdDialogButtonSizer.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxStdDialogButtonSizer.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxStdDialogButtonSizer.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxStdDialogButtonSizer.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxStdDialogButtonSizer';
  Result := wx_Class;
end;

procedure TWxStdDialogButtonSizer.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
end;

procedure TWxStdDialogButtonSizer.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxStdDialogButtonSizer.SetIDValue(IDValue: integer);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxStdDialogButtonSizer.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxStdDialogButtonSizer.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

procedure TWxStdDialogButtonSizer.WMPaint(var Message: TWMPaint);
var
  maxHeight: integer;
  totalmaxWidth: integer;
  startX: integer;
  i: integer;
  coordTop: integer;
  cntIntf: IWxContainerInterface;
  splitIntf: IWxSplitterInterface;  
begin
  totalmaxWidth := 0;
  maxHeight     := 0;
  self.Caption  := '';

  for i := 0 to self.ControlCount - 1 do
  begin
    //Calculate how much space this child component needs
    totalmaxWidth := totalmaxWidth + Controls[i].Width + 5;
    if Controls[i].Height > maxHeight then
      maxHeight := Controls[i].Height;
  end;

  //Remove the extra 5 pixels at the end
  if totalmaxWidth > 0 then
    totalmaxWidth := totalmaxWidth - 5;

  if self.parent.GetInterface(IDD_IWxContainerInterface, cntIntf) then
  begin
    if self.parent.GetInterface(IID_IWxSplitterInterface, splitIntf) then
      self.Align := alNone
    else
      self.Align := alClient;
  end
  else
    self.Align := alNone;

  if totalmaxWidth = 0 then
    self.Width := 20
  else
    self.Width := totalmaxWidth;

  if maxHeight = 0 then
    self.Height := 20
  else
    self.Height := maxHeight;

  //Initialize the starting coordinates
  startX := 0;

  for i := 0 to self.ControlCount - 1 do
  begin
    if IsControlWxNonVisible(Controls[i]) then
      continue;

    //Set the raw available width
    coordTop := maxHeight - self.Controls[i].Height;

    //Shift the controls
    self.Controls[i].Top := coordTop div 2;
    self.Controls[i].left := startX;

    //Add the width to the total width
    startX := startX + self.Controls[i].Width + 5;
  end;

  //Fix the parent's height and width
  if Self.Height > parent.Height then
    parent.Height := Self.Height;

  if Self.Width > parent.Width then
    parent.Width := Self.Width;

  //Call the base class' paint handler
  inherited;
end;

function TWxStdDialogButtonSizer.GetGenericColor(strVariableName:String): string;
begin
end;

procedure TWxStdDialogButtonSizer.SetGenericColor(strVariableName,strValue: string);
begin
end;

function TWxStdDialogButtonSizer.GetFGColor: string;
begin
end;

procedure TWxStdDialogButtonSizer.SetFGColor(strValue: string);
begin
end;

function TWxStdDialogButtonSizer.GetBGColor: string;
begin
end;

procedure TWxStdDialogButtonSizer.SetBGColor(strValue: string);
begin
end;

function TWxStdDialogButtonSizer.GenerateLastCreationCode: string;
begin
end;

end.
