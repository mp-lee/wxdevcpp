{ ****************************************************************** }
{ $Id: wxUtils.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

{*
  todo:
  1) StaticText needs Style
  2)Scrollbar need to have the vertical and horizontal poperties

*}
unit WxUtils;

interface

uses
  WinTypes, WinProcs, Messages, SysUtils, StrUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, Dialogs, ComCtrls, ExtCtrls, dmListview,
  UPicEdit, UStrings, DbugIntf, TypInfo, Menus, UStatusbar, UValidator,
  JvInspector, wxversion, DateUtils, xprocs, ShellAPI;

const
  IID_IWxComponentInterface: TGUID            = '{624949E8-E46C-4EF9-BADA-BC85325165B3}';
  IID_IWxDesignerFormInterface: TGUID         = '{3e8e18a0-6515-11db-bd13-0800200c9a66}';
  IID_IWxDialogNonInsertableInterface: TGUID  = '{AED02C7A-E2E5-4BFD-AF42-080D4D07027C}';
  IID_IWxToolBarInsertableInterface: TGUID    = '{5B1BDAFE-76E9-4C84-A694-0D99C6D17BC4}';
  IID_IWxToolBarNonInsertableInterface: TGUID = '{6A81CF27-1269-4BD6-9C5D-16F88293B66B}';
  IID_IWxWindowInterface: TGUID               = '{3164E818-E7FA-423B-B342-C89D8AF23617}';
  IID_IWxContainerAndSizerInterface: TGUID    = '{2C8662AE-7C13-4C96-81F6-32B195ABE1C9}';
  IDD_IWxContainerInterface: TGUID            = '{1149F8B7-04D7-466F-96FA-74C7383F2EFD}';
  IID_IWxToolBarInterface: TGUID              = '{518BF32C-F961-4148-B506-F60A9D21AD15}';
  IDD_IWxStatusBarInterface: TGUID            = '{4E9800A3-D948-4F48-A109-7F81B69ECAD3}';
  IDD_IWxMenuBarInterface: TGUID              = '{b74eeaf0-7f08-11db-9fe1-0800200c9a66}';
  IDD_IWxCollectionInterface: TGUID           = '{DC147ECD-47A2-4334-A113-CD9B794CBCE1}';
  IID_IWxVariableAssignmentInterface: TGUID   = '{624949E8-E46C-4EF9-B4DA-BC8532617513}';
  IID_IWxValidatorInterface: TGUID            = '{782949E8-47A2-4BA9-E4CA-CA9B832ADCA1}';
  IID_IWxSplitterInterface: TGUID             = '{900F32A7-3864-4827-9039-85C053504BDB}';
  IID_IWxControlPanelInterface: TGUID         = '{077d51a0-6628-11db-bd13-0800200c9a66}';
  IID_IWxThirdPartyComponentInterface: TGUID  = '{ead81650-6903-11db-bd13-0800200c9a66}';
  IID_IWxImageContainerInterface: TGUID       = '{10619130-6bd4-11db-bd13-0800200c9a66}';

var
   StringFormat : string;

//type  
 
  //TEditorType = (etNone, etSource, etForm);
  {TExUnitType = (  // <-- EAB TODO: Research how to delete this
    //utwxform); // wxForm (.wxForm)}

function ExtractComponentPropertyName(const S: string): string;
function ExtractComponentPropertyCaption(const S: string): string;
function iswxForm(FileName: string): Boolean;
//function isRCExt(FileName: string): boolean;
function isXRCExt(FileName: string): boolean;
function SaveStringToFile(strContent, strFileName: string): Boolean;

type
  TWxPoint = class(TComponent)
  private
    FX: integer;
    FY: integer;
  published
    property X: integer Read FX Write FX default 0;
    property Y: integer Read FY Write FY default 0;
  end;

// Added by Tony Reina 20 June 2006
// We need a TButton class that will allow for the caption to be aligned
// I found this code at the Delphi Central website: http://www.delphi-central.com/tbut.aspx
type
  THorizAlign    = (halLeft, halRight, halCentre);
  TVerticalAlign = (valTop, valBottom, valCentre);

  TMultiLineBtn = class(TButton)
  private
    fMultiLine: boolean;
    fHorizAlign: THorizAlign;
    fVerticalAlign: TVerticalAlign;
    procedure SetMultiLine(Value: boolean);
    procedure SetHorizAlign(Value: THorizAlign);
    procedure SetVerticalAlign(Value: TVerticalAlign);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property HorizAlign: THorizAlign
      Read fHorizAlign Write setHorizAlign default halCentre;
    property VerticalAlign: TVerticalAlign Read fVerticalAlign
      Write setVerticalAlign default valCentre;
    property MultiLine: boolean Read fMultiLine Write SetMultiLine default True;
  end;
  // END: TMultiLineBtn

  TWxStdDialogButtons = set of (wxID_OK, wxID_YES, wxID_NO, wxID_CANCEL, wxID_HELP);
  TWxSizerAlignment = (wxALIGN_TOP, wxALIGN_LEFT, wxALIGN_RIGHT, wxALIGN_BOTTOM,
    wxALIGN_CENTER, wxALIGN_CENTER_VERTICAL, wxALIGN_CENTER_HORIZONTAL, wxEXPAND);
  TWxSizerAlignmentSet = set of TWxSizerAlignment;
  TWxBorderAlignment = set of(wxTOP, wxLEFT, wxRIGHT, wxBOTTOM, wxALL);
  TWxControlOrientation = (wxControlVertical, wxControlHorizontal, wxControlNone);
  TWxGridSelection = (wxGridSelectCells, wxGridSelectColumns, wxGridSelectRows);
  TWxDesignerType = (dtWxDialog, dtWxFrame, dtWxWizard);

  IWxComponentInterface = interface
    ['{624949E8-E46C-4EF9-BADA-BC85325165B3}']
    function GenerateEnumControlIDs: string;
    function GenerateControlIDs: string;

    function GenerateGUIControlCreation: string;
    function GenerateXRCControlCreation(IndentString: string): TStringList;
    function GenerateGUIControlDeclaration: string;
    function GenerateHeaderInclude: string;
    function GenerateImageInclude: string;
    function GetPropertyList: TStringList;

    function GetEventList: TStringList;
    function GenerateEventTableEntries(CurrClassName: string): string;
    function GetParameterFromEventName(EventName: string): string;
    function GetTypeFromEventName(EventName: string): string;

    function GetIDName: string;
    procedure SetIDName(IDName: string);
    function GetIDValue: longint;
    procedure SetIDValue(IDValue: longint);

    function GetWxClassName: string;
    procedure SetWxClassName(wxClassName: string);

    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);
    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);
  end;

  IWxDesignerFormInterface = interface
    ['{3e8e18a0-6515-11db-bd13-0800200c9a66}']
    function GetFormName: string;
    procedure SetFormName(StrValue: string);
  end;


  IWxDialogNonInsertableInterface = interface
    ['{AED02C7A-E2E5-4BFD-AF42-080D4D07027C}']
    //procedure DummySizerNonInsertableInterfaceProcedure;
  end;

  IWxToolBarInsertableInterface = interface
    ['{5B1BDAFE-76E9-4C84-A694-0D99C6D17BC4}']
    //procedure DummyToolBarInsertableInterfaceProcedure;
  end;

  IWxToolBarNonInsertableInterface = interface
    ['{6A81CF27-1269-4BD6-9C5D-16F88293B66B}']
    //procedure DummyToolBarNonInsertableInterfaceProcedure;
  end;

  IWxWindowInterface = interface
    ['{3164E818-E7FA-423B-B342-C89D8AF23617}']

  end;

  IWxContainerAndSizerInterface = interface
    ['{2C8662AE-7C13-4C96-81F6-32B195ABE1C9}']
    function GenerateLastCreationCode: string;
  end;

  IWxContainerInterface = interface
    ['{1149F8B7-04D7-466F-96FA-74C7383F2EFD}']
  end;

  IWxToolBarInterface = interface
    ['{518BF32C-F961-4148-B506-F60A9D21AD15}']
  end;

  IWxStatusBarInterface = interface
    ['{4E9800A3-D948-4F48-A109-7F81B69ECAD3}']
  end;

  IWxMenuBarInterface = interface
    ['{b74eeaf0-7f08-11db-9fe1-0800200c9a66}']
    function GenerateXPM(strFileName:String):boolean;
  end;

  IWxCollectionInterface = interface
    ['{DC147ECD-47A2-4334-A113-CD9B794CBCE1}']
    function GetMaxID: integer;
  end;

  IWxVariableAssignmentInterface = Interface
    ['{624949E8-E46C-4EF9-B4DA-BC8532617513}']
    function GetLHSVariableAssignment:String;
    function GetRHSVariableAssignment:String;
  end;

  IWxValidatorInterface = Interface
    ['{782949E8-47A2-4BA9-E4CA-CA9B832ADCA1}']
    function GetValidator:String;
    procedure SetValidator(value:String);
  end;

  IWxSplitterInterface = Interface
    ['{900F32A7-3864-4827-9039-85C053504BDB}']
  end;

  IWxControlPanelInterface = Interface
    ['{077d51a0-6628-11db-bd13-0800200c9a66}']
  end;

  IWxThirdPartyComponentInterface = Interface
    ['{ead81650-6903-11db-bd13-0800200c9a66}']
    function GetHeaderLocation:string;
    function GetLibName(CompilerTye:Integer):string;
    function IsLibAddedAtEnd(CompilerTye:Integer):boolean;
  end;

  IWxImageContainerInterface = Interface
    ['{10619130-6bd4-11db-bd13-0800200c9a66}']
    function GetBitmapCount:Integer;
    function GetBitmap(Idx:Integer;var bmp:TBitmap; var PropertyName:string):boolean;
    function GetPropertyName(Idx:Integer):String;
  end;

  TWxStdStyleItem = (wxSIMPLE_BORDER, wxDOUBLE_BORDER, wxSUNKEN_BORDER,
    wxRAISED_BORDER, wxSTATIC_BORDER, wxTRANSPARENT_WINDOW,
    wxTAB_TRAVERSAL, wxWANTS_CHARS,
    wxNO_FULL_REPAINT_ON_RESIZE, wxVSCROLL,
    wxHSCROLL, wxCLIP_CHILDREN, wxNO_BORDER,
    wxALWAYS_SHOW_SB, wxFULL_REPAINT_ON_RESIZE);
  TWxStdStyleSet  = set of TWxStdStyleItem;

  TWxBtnStyleItem = (wxBU_AUTODRAW, wxBU_LEFT, wxBU_TOP, wxBU_RIGHT, wxBU_BOTTOM,
    wxBU_EXACTFIT);
  TWxBtnStyleSet  = set of TWxBtnStyleItem;

  TWxLbStyleItem = (wxST_ALIGN_LEFT, wxST_ALIGN_RIGHT, wxST_ALIGN_CENTRE,
    wxST_NO_AUTORESIZE);
  TWxLbStyleSet  = set of TWxLbStyleItem;

  TWxEdtGeneralStyleItem = (wxTE_PROCESS_ENTER, wxTE_PROCESS_TAB, wxTE_PASSWORD,
    wxTE_READONLY, wxTE_RICH, wxTE_RICH2,
    wxTE_AUTO_URL, wxTE_NOHIDESEL,
    wxTE_DONTWRAP, wxTE_LINEWRAP, wxTE_WORDWRAP,
    wxTE_CHARWRAP, wxTE_BESTWRAP, wxTE_CAPITALIZE,
    wxTE_MULTILINE, wxTE_LEFT, wxTE_CENTRE, wxTE_RIGHT);
  TWxEdtGeneralStyleSet  = set of TWxEdtGeneralStyleItem;

  TWxRichTextStyleItem = (wxRE_READONLY,wxRE_MULTILINE);
  TWxRichTextStyleSet  = set of TWxRichTextStyleItem;

  //  TWxEdtAlignmentStyleItem = (wxTE_LEFT, wxTE_CENTRE, wxTE_RIGHT);
  // TWxEdtAlignmentStyleSet = set of TWxEdtAlignmentStyleItem;

  TWxDlgStyleItem = (wxCAPTION, wxRESIZE_BORDER, wxSYSTEM_MENU, wxTHICK_FRAME,
    wxSTAY_ON_TOP, wxDIALOG_NO_PARENT, wxDIALOG_EX_CONTEXTHELP,
    wxMINIMIZE_BOX,
    wxMAXIMIZE_BOX, wxCLOSE_BOX, wxNO_3D,
    wxDEFAULT_DIALOG_STYLE, wxDEFAULT_FRAME_STYLE,
    wxMINIMIZE, wxMAXIMIZE, wxFRAME_TOOL_WINDOW,
    wxFRAME_NO_TASKBAR, wxFRAME_FLOAT_ON_PARENT,
    wxFRAME_EX_CONTEXTHELP, wxFRAME_SHAPED);
  TWxDlgStyleSet  = set of TWxDlgStyleItem;

  //newly Added
  TWxCmbStyleItem = (wxCB_SIMPLE, wxCB_DROPDOWN, wxCB_READONLY, wxCB_SORT);
  TWxCmbStyleSet  = set of TWxCmbStyleItem;

  TWxOwnCmbStyleItem = (wxODCB_DCLICK_CYCLES, wxODCB_STD_CONTROL_PAINT);
  TWxOwnCmbStyleSet  = set of TWxOwnCmbStyleItem;

  TWxPickCalStyleItem = (wxDP_SPIN , wxDP_DROPDOWN , wxDP_DEFAULT , wxDP_ALLOWNONE , wxDP_SHOWCENTURY);
  TWxPickCalStyleSet  = set of TWxPickCalStyleItem;

  TWxLBxStyleSubItem = (wxLB_SINGLE, wxLB_MULTIPLE, wxLB_EXTENDED);
  TWxLBxStyleSubSet  = set of TWxLBxStyleSubItem;

  TWxLBxStyleItem = (wxLB_HSCROLL, wxLB_ALWAYS_SB, wxLB_NEEDED_SB, wxLB_SORT);
  TWxLBxStyleSet  = set of TWxLBxStyleItem;

  TWxCBxStyleItem = (wxCHK_2STATE, wxCHK_3STATE, wxCHK_ALLOW_3RD_STATE_FOR_USER,
    wxALIGN_RIGHT_CB);
  TWxCBxStyleSet  = set of TWxCBxStyleItem;

  TWxRBStyleItem = (wxRB_GROUP, wxRB_SINGLE);
  TWxRBStyleSet  = set of TWxRBStyleItem;

  TWxGagOrientation = (wxGA_HORIZONTAL, wxGA_VERTICAL);

  TWxgagStyleItem = (wxGA_SMOOTH, wxGA_MARQUEE);
  TWxgagStyleSet  = set of TWxgagStyleItem;

  TWxsbtnOrientation = (wxSP_HORIZONTAL, wxSP_VERTICAL);

  TWxsbtnStyleItem = (wxSP_ARROW_KEYS, wxSP_WRAP);
  TWxsbtnStyleSet  = set of TWxsbtnStyleItem;

  TWx_SBOrientation = (wxSB_HORIZONTAL, wxSB_VERTICAL);

  TWx_SliderOrientation = (wxSL_HORIZONTAL, wxSL_VERTICAL);
  TWx_SliderRange = (wxSL_SELRANGE, wxSL_INVERSE);

  TWxsldrStyleItem = (wxSL_AUTOTICKS, wxSL_LABELS, wxSL_LEFT, wxSL_RIGHT, wxSL_TOP, wxSL_BOTTOM);
  TWxsldrStyleSet  = set of TWxsldrStyleItem;

  TWxHyperLnkStyleItem = (wxHL_ALIGN_LEFT, wxHL_ALIGN_RIGHT, wxHL_ALIGN_CENTRE, wxHL_CONTEXTMENU, wxHL_DEFAULT_STYLE);
  TWxHyperLnkStyleSet  = set of TWxHyperLnkStyleItem;

  TWxcalctrlStyleItem = (wxCAL_SUNDAY_FIRST, wxCAL_MONDAY_FIRST, wxCAL_SHOW_HOLIDAYS,
    wxCAL_NO_YEAR_CHANGE, wxCAL_NO_MONTH_CHANGE,
    wxCAL_SHOW_SURROUNDING_WEEKS,
    wxCAL_SEQUENTIAL_MONTH_SELECTION);
  TWxcalctrlStyleSet  = set of TWxcalctrlStyleItem;

  TWxnbxStyleItem = (wxNB_LEFT, wxNB_RIGHT, wxNB_BOTTOM, wxNB_FIXEDWIDTH,
    wxNB_MULTILINE, wxNB_NOPAGETHEME);
  TWxnbxStyleSet  = set of TWxnbxStyleItem;

  TWxrbxStyleItem = (wxRA_SPECIFY_ROWS, wxRA_SPECIFY_COLS);
  TWxrbxStyleSet  = set of TWxrbxStyleItem;

  TWxsbrStyleItem = (wxST_SIZEGRIP);
  TWxsbrStyleSet  = set of TWxsbrStyleItem;

  TWxtbrStyleItem = (wxTB_FLAT, wxTB_DOCKABLE, wxTB_HORIZONTAL,
    wxTB_VERTICAL, wxTB_TEXT,
    wxTB_NOICONS, wxTB_NODIVIDER, wxTB_NOALIGN, wxTB_HORZ_LAYOUT,
    wxTB_HORZ_TEXT);
  TWxtbrStyleSet  = set of TWxtbrStyleItem;

  TWxLvView = (wxLC_ICON, wxLC_SMALL_ICON, wxLC_LIST, wxLC_REPORT, wxLC_VIRTUAL{$IFDEF PRIVATE_BUILD}, wxLC_TILE{$ENDIF});
  TWxLVStyleItem = (wxLC_ALIGN_TOP, wxLC_ALIGN_LEFT, wxLC_AUTOARRANGE,
    wxLC_EDIT_LABELS, wxLC_GROUPS, wxLC_NO_HEADER, wxLC_NO_SORT_HEADER,
    wxLC_SINGLE_SEL, wxLC_SORT_ASCENDING, wxLC_SORT_DESCENDING,
    wxLC_HRULES, wxLC_VRULES);
  TWxLVStyleSet  = set of TWxLVStyleItem;

  TWxTVStyleItem = (wxTR_EDIT_LABELS, wxTR_NO_BUTTONS, wxTR_HAS_BUTTONS,
    wxTR_TWIST_BUTTONS, wxTR_NO_LINES, wxTR_FULL_ROW_HIGHLIGHT,
    wxTR_LINES_AT_ROOT, wxTR_HIDE_ROOT, wxTR_ROW_LINES,wxTR_COLUMN_LINES,
    wxTR_HAS_VARIABLE_ROW_HEIGHT, wxTR_SINGLE,wxTR_SHOW_ROOT_LABEL_ONLY,
    wxTR_MULTIPLE, wxTR_EXTENDED,
    wxTR_DEFAULT_STYLE);
  TWxTVStyleSet  = set of TWxTVStyleItem;

  TWxScrWinStyleItem = (wxRETAINED);
  TWxScrWinStyleSet  = set of TWxScrWinStyleItem;

  TWxHtmlWinStyleItem = (wxHW_SCROLLBAR_NEVER, wxHW_SCROLLBAR_AUTO, wxHW_NO_SELECTION);
  TWxHtmlWinStyleSet  = set of TWxHtmlWinStyleItem;

  TWxSplitterWinStyleItem = (wxSP_3D, wxSP_3DSASH, wxSP_3DBORDER,
    wxSP_BORDER, wxSP_NOBORDER, wxSP_NO_XP_THEME, wxSP_PERMIT_UNSPLIT, wxSP_LIVE_UPDATE);
  TWxSplitterWinStyleSet  = set of TWxSplitterWinStyleItem;

  TWxMenuItemStyleItem = (wxMnuItm_Normal, wxMnuItm_Separator,
    wxMnuItm_Radio, wxMnuItm_Check, wxMnuItm_History);

  TWxToolbottonItemStyleItem = (wxITEM_NORMAL, wxITEM_RADIO, wxITEM_CHECK);

  TWxFindReplaceFlagItem = (wxFR_DOWN, wxFR_WHOLEWORD, wxFR_MATCHCASE);
  TWxFindReplaceFlagSet  = set of TWxFindReplaceFlagItem;

  TwxFindReplaceDialogStyleItem = (wxFR_REPLACEDIALOG, wxFR_NOUPDOWN,
    wxFR_NOMATCHCASE, wxFR_NOWHOLEWORD);
  TwxFindReplaceDialogStyleSet  = set of TwxFindReplaceDialogStyleItem;

  TWx_LIOrientation = (wxLI_HORIZONTAL, wxLI_VERTICAL);

  //End of Control Styles

  TWxFileDialogType = (wxOPEN, wxSAVE);

  TWxFileDialogStyleItem = (wxHIDE_READONLY, wxOVERWRITE_PROMPT, wxMULTIPLE,
    wxCHANGE_DIR, wxFILE_MUST_EXIST);
  TWxFileDialogStyleSet  = set of TWxFileDialogStyleItem;

  TWxDirDialogStyleItem = (wxDD_NEW_DIR_BUTTON);
  TWxDirDialogStyleSet  = set of TWxDirDialogStyleItem;

  TWxProgressDialogStyleItem =
    (wxPD_APP_MODAL, wxPD_AUTO_HIDE, wxPD_CAN_ABORT, wxPD_ELAPSED_TIME,
    wxPD_ESTIMATED_TIME, wxPD_REMAINING_TIME, wxPD_SMOOTH, wxPD_CAN_SKIP);
  TWxProgressDialogStyleSet  = set of TWxProgressDialogStyleItem;

  TWxMessageDialogStyleItem = (wxOK, wxCANCEL, wxYES_NO, wxYES_DEFAULT,
    wxNO_DEFAULT, wxICON_EXCLAMATION, wxICON_HAND, wxICON_ERROR, wxICON_QUESTION,
    wxICON_INFORMATION,wxCENTRE);
  TWxMessageDialogStyleSet  = set of TWxMessageDialogStyleItem;

  TWxPaperSizeItem = (wxPAPER_NONE, wxPAPER_LETTER, wxPAPER_LEGAL,
    wxPAPER_A4, wxPAPER_CSHEET, wxPAPER_DSHEET, wxPAPER_ESHEET,
    wxPAPER_LETTERSMALL, wxPAPER_TABLOID, wxPAPER_LEDGER,
    wxPAPER_STATEMENT, wxPAPER_EXECUTIVE, wxPAPER_A3,
    wxPAPER_A4SMALL, wxPAPER_A5, wxPAPER_B4, wxPAPER_B5,
    wxPAPER_FOLIO, wxPAPER_QUARTO, wxPAPER_10X14, wxPAPER_11X17,
    wxPAPER_NOTE, wxPAPER_ENV_9, wxPAPER_ENV_10,
    wxPAPER_ENV_11, wxPAPER_ENV_12, wxPAPER_ENV_14, wxPAPER_ENV_DL, wxPAPER_ENV_C5,
    wxPAPER_ENV_C3, wxPAPER_ENV_C4, wxPAPER_ENV_C6,
    wxPAPER_ENV_C65, wxPAPER_ENV_B4, wxPAPER_ENV_B5, wxPAPER_ENV_B6, wxPAPER_ENV_ITALY,
    wxPAPER_ENV_MONARCH, wxPAPER_ENV_PERSONAL,
    wxPAPER_FANFOLD_US, wxPAPER_FANFOLD_STD_GERMAN, wxPAPER_FANFOLD_LGL_GERMAN);


  //Sizer orientation
  TWxSizerOrientation = (wxVertical, wxHorizontal);

  TWxMediaCtrlControl = (wxMEDIACTRLPLAYERCONTROLS_NONE , wxMEDIACTRLPLAYERCONTROLS_STEP , wxMEDIACTRLPLAYERCONTROLS_VOLUME );
  TWxMediaCtrlControls = set of TWxMediaCtrlControl;

  TWxColorString = class
  public
    FstrColorValue: string;
  published
    property strColorValue: string Read FstrColorValue Write FstrColorValue;
  end;

  TWxValidatorString = class(TComponent)
  public
    FstrValidatorValue: string;
    FValidatorType: Integer;
    FFilterType: Integer;
    FValidatorVarName:String;
    constructor Create(Owner: TComponent); override;

  published
    property strValidatorValue: string Read FstrValidatorValue Write FstrValidatorValue;
  end;

  // Added 11 May 2005 - Tony
  TWxFileNameString = class
  public
    FstrFileNameValue: string;
  published
    property strFileNameValue: string Read FstrFileNameValue Write FstrFileNameValue;
  end;

  TWxJvInspectorTStringsItem = class(TJvCustomInspectorItem)
  protected
    procedure ContentsChanged(Sender: TObject);
    function GetDisplayValue: string; override;
    procedure Edit; override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  public
    constructor Create(const AParent: TJvCustomInspectorItem;
      const AData: TJvCustomInspectorData); override;
  public
    class procedure RegisterAsDefaultItem;
  end;

  TJvInspectorColorEditItem = class(TJvCustomInspectorItem)
  protected
    procedure Edit; override;

    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  public
    class procedure RegisterAsDefaultItem;
  end;

  // Added 11 May 2005 by Tony
  TJvInspectorFileNameEditItem = class(TJvCustomInspectorItem)
  protected
    procedure Edit; override;
    function GetDisplayValue: string; override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  public
    class procedure RegisterAsDefaultItem;
  end;

  TJvInspectorListItemsItem = class(TJvCustomInspectorItem)
  protected
    procedure Edit; override;

    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  public
    class procedure RegisterAsDefaultItem;
  end;

  TJvInspectorListColumnsItem = class(TJvCustomInspectorItem)
  protected
    procedure Edit; override;

    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  public
    class procedure RegisterAsDefaultItem;
  end;

  TJvInspectorStatusBarItem = class(TJvCustomInspectorItem)
  protected
    procedure Edit; override;

    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  public
    class procedure RegisterAsDefaultItem;
  end;

  TJvInspectorTreeNodesItem = class(TJvCustomInspectorItem)
  protected
    procedure Edit; override;

    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  public
    class procedure RegisterAsDefaultItem;
  end;

  TJvInspectorBitmapItem = class(TJvCustomInspectorItem)
  protected
    procedure Edit; override;

    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  public
    class procedure RegisterAsDefaultItem;
  end;

  TJvInspectorMyFontItem = class(TJvCustomInspectorItem)
  protected
    procedure Edit; override;

    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  public
    class procedure RegisterAsDefaultItem;
  end;

  TJvInspectorMenuItem = class(TJvCustomInspectorItem)
  protected
    procedure Edit; override;

    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  public
    class procedure RegisterAsDefaultItem;
  end;

  TJvInspectorValidatorItem = class(TJvCustomInspectorItem)
  protected
    procedure ContentsChanged(Sender: TObject);
    function GetDisplayValue: string; override;
    procedure Edit; override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
    procedure SetDisplayValue(const Value: string); override;

  public
    constructor Create(const AParent: TJvCustomInspectorItem;
    const AData: TJvCustomInspectorData); override;
    class procedure RegisterAsDefaultItem;
  end;

function UnixPathToDosPath(const Path: string): string;
function LocalConvertLibsToCurrentVersion(strValue:String):string;
function Convert25LibsToCurrentVersion(strValue:String):string;
function Convert26LibsToCurrentVersion(strValue:String):string;

function GetGridSelectionToString(grdsel: TWxGridSelection): string;
function GetStdStyleString(stdStyle: TWxStdStyleSet): string;
function GetComboxBoxStyleString(stdStyle: TWxCmbStyleSet): string;
function GetOwnComboxBoxStyleString(stdStyle: TWxOwnCmbStyleSet): string;
function GetCheckboxStyleString(stdStyle: TWxcbxStyleSet): string;
function GetTreeviewStyleString(stdStyle: TWxTVStyleSet): string;
function GetRadiobuttonStyleString(stdStyle: TWxrbStyleSet): string;
function GetListboxStyleString(stdStyle: TWxlbxStyleSet): string;
function GetGaugeStyleString(stdStyle: TWxgagStyleSet): string;
function GetScrollbarStyleString(stdStyle: TWxsbrStyleSet): string;
function GetSpinButtonStyleString(stdStyle: TWxsbtnStyleSet): string;
function GetSliderStyleString(stdStyle: TWxsldrStyleSet): string;
function GetHyperLnkStyleString(stdStyle: TWxHyperLnkStyleSet): string;
function GetPickCalStyleString(stdStyle: TWxPickCalStyleSet): string;
function GetCalendarCtrlStyleString(stdStyle: TWxcalctrlStyleSet): string;
function GetNotebookStyleString(stdStyle: TWxnbxStyleSet): string;
function GetRadioBoxStyleString(stdStyle: TWxrbxStyleSet): string;
function GetStatusBarStyleString(stdStyle: TWxsbrStyleSet): string;
function GetToolBarStyleString(stdStyle: TWxtbrStyleSet): string;
function GetScrolledWindowStyleString(stdStyle: TWxScrWinStyleSet): string;
function GetHtmlWindowStyleString(stdStyle: TWxHtmlWinStyleSet): string;
function GetSplitterWindowStyleString(stdStyle: TWxSplitterWinStyleSet): string;
function GetFileDialogStyleString(stdStyle: TWxFileDialogStyleSet): string;
function GetDirDialogStyleString(stdStyle: TWxDirDialogStyleSet): string;
function GetProgressDialogStyleString(stdStyle: TWxProgressDialogStyleSet): string;
function GetTextEntryDialogStyleString(stdStyle: TWxMessageDialogStyleSet; edtStyle:TWxEdtGeneralStyleSet): string;
function GetMediaCtrlStyle(mediaStyle:TWxMediaCtrlControl): string;
function GetMediaCtrlStyleString(mediaStyle:TWxMediaCtrlControls): string;
function GetMessageDialogStyleString(stdStyle: TWxMessageDialogStyleSet;NoEndComma:Boolean): string;
function GetFindReplaceFlagString(stdstyle: TWxFindReplaceFlagSet): string;
function GetFindReplaceDialogStyleString(stdstyle: TWxFindReplaceDialogStyleSet): string;

function GetCheckboxSpecificStyle(stdstyle: TWxStdStyleSet;
  cbxstyle: TWxcbxStyleSet): string;
function GetTreeviewSpecificStyle(stdstyle: TWxStdStyleSet;
  tvstyle: TWxTvStyleSet): string;
function GetRadiobuttonSpecificStyle(stdstyle: TWxStdStyleSet;
  rbstyle: TWxrbStyleSet): string;
function GetListboxSpecificStyle(stdstyle: TWxStdStyleSet;
  lbxstyle: TWxlbxStyleSet): string;
function GetGaugeSpecificStyle(stdstyle: TWxStdStyleSet;
  gagstyle: TWxgagStyleSet): string;
function GetScrollbarSpecificStyle(stdstyle: TWxStdStyleSet;
  scbrstyle: TWxsbrStyleSet): string;
function GetHyperLnkSpecificStyle(stdstyle: TWxStdStyleSet;
  edtstyle: TWxHyperLnkStyleSet): string;  
function GetSpinButtonSpecificStyle(stdstyle: TWxStdStyleSet;
  sbtnstyle: TWxsbtnStyleSet;
  edtstyle: TWxEdtGeneralStyleSet): string;
function GetSliderSpecificStyle(stdstyle: TWxStdStyleSet;
  sldrstyle: TWxsldrStyleSet): string;
function GetDateVariableExpansion(value:TDateTime):string;
function GetCalendarCtrlSpecificStyle(stdstyle: TWxStdStyleSet;
  calctrlstyle: TWxcalctrlStyleSet): string;
function GetPickCalSpecificStyle(stdstyle: TWxStdStyleSet;
  calctrlstyle: TWxPickCalStyleSet): string;
function GetNotebookSpecificStyle(stdstyle: TWxStdStyleSet;
  nbxstyle: TWxnbxStyleSet): string;
function GetRadioBoxSpecificStyle(stdstyle: TWxStdStyleSet;
  rbxstyle: TWxrbxStyleSet): string;
function GetStatusBarSpecificStyle(stdstyle: TWxStdStyleSet;
  sbrstyle: TWxsbrStyleSet): string;
function GetToolBarSpecificStyle(stdstyle: TWxStdStyleSet;
  tbrstyle: TWxtbrStyleSet): string;
function GetScrolledWindowSpecificStyle(stdstyle: TWxStdStyleSet;
  scrWinStyle: TWxScrWinStyleSet): string;
function GetHtmlWindowSpecificStyle(stdstyle: TWxStdStyleSet;
  htmlWinStyle: TWxHtmlWinStyleSet): string;
function GetSplitterWindowSpecificStyle(stdstyle: TWxStdStyleSet;
  splitterWinStyle: TWxSplitterWinStyleSet): string;
function GetRichTextSpecificStyle(stdstyle: TWxStdStyleSet;
  dlgstyle: TWxRichTextStyleSet): string;
function GetListViewSpecificStyle(stdstyle: TWxStdStyleSet;
  lstvwstyle: TWxLVStyleSet; view: TWxLvView): string;
function GetEditSpecificStyle(stdstyle: TWxStdStyleSet;
  dlgstyle: TWxEdtGeneralStyleSet): string;
function GetButtonSpecificStyle(stdstyle: TWxStdStyleSet;
  dlgstyle: TWxBtnStyleSet): string;
function GetLabelSpecificStyle(stdstyle: TWxStdStyleSet;
  dlgstyle: TWxLbStyleSet): string;
function GetcomboBoxSpecificStyle(stdstyle: TWxStdStyleSet;
  cmbstyle: TWxCmbStyleSet; edtstyle: TWxEdtGeneralStyleSet): string;
function GetOwncomboBoxSpecificStyle(stdstyle: TWxStdStyleSet;
  cmbstyle: TWxCmbStyleSet; edtstyle: TWxEdtGeneralStyleSet;
  owncmbstyle: TWxOwnCmbStyleSet): string;
function GetStdDialogButtonsSpecificStyle(btnstyle: TWxStdDialogButtons): string;
function GetDialogSpecificStyle(stdstyle: TWxStdStyleSet;
  dlgstyle: TWxDlgStyleSet; wxclassname: string): string;

procedure PopulateGenericProperties(var PropertyList: TStringList);
function SizerAlignmentToStr(SizerAlignment: TWxSizerAlignmentSet): string; overload;
function BorderAlignmentToStr(BorderAlignment: TWxBorderAlignment): string;
function RGBFormatStrToColor(strColorValue: string): TColor;
function GetColorFromString(strColorValue: string): TColor;
function GetGeneralColorFromString(strColorValue: string): TColor;
function IsDefaultColorStr(strvalue: string): boolean;
function GetwxColorFromString(strValue: string): string;
function PaperIDToString(sizeitem: TWxPaperSizeItem): string;

function IsControlWxSizer(ctrl: TControl): boolean;
function IsControlWxContainer(ctrl: TControl): boolean;
function IsControlWxWindow(ctrl: TControl): boolean;
function IsControlWxToolBar(ctrl: TControl): boolean;
function IsControlWxStatusBar(ctrl: TControl): boolean;
function IsControlWxNonVisible(ctrl: TControl): boolean;
function GetNonVisualComponentCount(frmMainObj: TForm): integer;

function GetWxIDString(strID: string; intID: longint): string;
function IsValidClass(comp: TComponent): boolean;
function GetEventNameFromDisplayName(strDisplayName: string;
  strlst: TStringList): string;
function AlignmentToStr(taPos: TAlignment): string;
procedure ChangeControlZOrder(Sender: TObject; MoveUp: boolean = True);
function GetXPMFromTPicture(XPMName: string; delphiBitmap: TBitmap): string;
function GetXPMFromTPictureXXX(XPMName: string; delphiBitmap: TBitmap): string;
function GenerateXPMDirectly(bmp: TBitmap; strCompName: string;strParentName:string;strFileName: string): boolean;
function OpenXPMImage(InpImage: TBitmap; strFname: string): boolean;
function GetCppString(str: string): string;
function GetCommentString(str: string): string;
function GetWxFontDeclaration(fnt: TFont): string;
function GetDesignerFormName(cntrl: TControl): string;
function GetWxWidgetParent(cntrl: TControl): string;
function GetWxWindowControls(wnCtrl: TWinControl): integer;
function GetAvailableControlCount(ParentControl: TWinControl;
  ControlToCheck: TComponent): integer; overload;
function GetAvailableControlCount(ParentControl: TWinControl;
  ControlToCheck: string): integer; overload;
function GetMaxIDofWxForm(ParentControl: TWinControl): integer;
function GetMenuKindAsText(menuStyle: TWxMenuItemStyleItem): string;
function GetToolButtonKindAsText(toolStyle: TWxToolbottonItemStyleItem): string;

function GetTotalHtOfAllToolBarAndStatusBar(ParentControl: TWinControl): Integer;
function GetPredefinedwxIds: TStringList;
function IsIDPredefined(str: string; strlst: TStringList): boolean;

function XML_Label(str: string): string;
function CreateBlankXRC: TStringList;
function GetWxMonthFromIndex(MonthIndex:Integer):String;
function GetDateToString(dt:TDateTime):string;

function GetLongName(const ShortPathName: string): String;  // EAB TODO: Copied from utils. Check if we can place it in a single common place.
function ValidateClassName(ClassName: String) :Integer;  // EAB TODO: Copied from utils. Check if we can place it in a single common place.
function CreateValidClassName(ClassName: String) :String; // EAB TODO: Copied from utils. Check if we can place it in a single common place.
function ValidateFileName(FileName: String): Integer;  // EAB TODO: Copied from utils. Check if we can place it in a single common place.
function CreateValidFileName(FileName: String): String; // EAB TODO: Copied from utils. Check if we can place it in a single common place.

implementation

uses DesignerFrm, wxlistCtrl, WxStaticBitmap, WxBitmapButton, WxSizerPanel, WxToolButton,
  UColorEdit, UMenuitem, WxCustomMenuItem, WxPopupMenu, WxMenuBar,
  WxNonVisibleBaseComponent, wxdesigner
{$IFDEF WIN32}
  , ShlObj, ActiveX
{$ENDIF}
 ;

function ExtractComponentPropertyName(const S: string): string;
var
  SepaPos: integer;
begin
  Result := '';
  SepaPos := Pos(':', S);
  if SepaPos > 1 then
    Result := Copy(S, 1, SepaPos - 1);
end;

function ExtractComponentPropertyCaption(const S: string): string;
var
  SepaPos: integer;
begin
  Result := '';
  if S = '' then
    Exit;
  SepaPos := Pos(':', S);
  if SepaPos > 1 then
    Result := Copy(S, SepaPos + 1, Length(S));
end;

function iswxForm(FileName: string): boolean;
begin
  if LowerCase(ExtractFileExt(FileName)) = LowerCase(WXFORM_EXT) then
    Result := true
  else
    result := False;
end;

{function isRCExt(FileName: string): boolean;
begin
  if LowerCase(ExtractFileExt(FileName)) = LowerCase(RC_EXT) then
    Result := true
  else
    result := False;
end;}

function isXRCExt(FileName: string): boolean;
begin
  if LowerCase(ExtractFileExt(FileName)) = LowerCase(XRC_EXT) then
    Result := true
  else
    result := False;
end;

function SaveStringToFile(strContent, strFileName: string): Boolean;
var
  strStringList: TStringList;
begin
  Result := true;
  strStringList := TStringList.Create;
  strStringList.Text := strContent;
  try
    strStringList.SaveToFile(strFileName);
  except
    Result := False;
  end;
  strStringList.Destroy;
end;

constructor TWxValidatorString.Create(Owner: TComponent);
begin
  inherited;
end;

function TranslateChar(const Str: string; FromChar, ToChar: Char): string;
var
  I: Integer;
begin
  Result := Str;
  for I := 1 to Length(Result) do
    if Result[I] = FromChar then
      Result[I] := ToChar;
end;

function UnixPathToDosPath(const Path: string): string;
begin
  Result := TranslateChar(Path, '/', '\');
end;

function LocalConvertLibsToCurrentVersion(strValue:String):string;
begin
  Result:=Convert25LibsToCurrentVersion(strValue);
  Result:=Convert26LibsToCurrentVersion(Result);
  //Auto -mwindows flag addition
  if AnsiContainsText(Result,'-lwxmsw') and (AnsiContainsText(Result,'-mwindows') = false) then
  begin
    Result:='-mwindows_@@_'+Result;
  end;
end;
function Convert25LibsToCurrentVersion(strValue:String):string;
begin
  Result:=StringReplace(strValue,'wxmsw25','wxmsw27',[rfReplaceAll]);
end;

function Convert26LibsToCurrentVersion(strValue:String):string;
begin
  Result:=StringReplace(strValue,'wxmsw26','wxmsw27',[rfReplaceAll]);
end;

function GetDateToString(dt:TDateTime):String;
var
    AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond:word;
begin
  DecodeDateTime(dt,AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
  Result:= Format('%d/%d/%d',[AMonth,ADay,AYear]);
end;

function GetWxMonthFromIndex(MonthIndex:Integer):String;
begin
    case MonthIndex of
        1: Result:= 'wxDateTime::Jan';
        2: Result:= 'wxDateTime::Feb';
        3: Result:= 'wxDateTime::Mar';
        4: Result:= 'wxDateTime::Apr';
        5: Result:= 'wxDateTime::May';
        6: Result:= 'wxDateTime::Jun';
        7: Result:= 'wxDateTime::Jul';
        8: Result:= 'wxDateTime::Aug';
        9: Result:= 'wxDateTime::Sep';
        10: Result:= 'wxDateTime::Oct';
        11: Result:= 'wxDateTime::Nov';
        12: Result:= 'wxDateTime::Dec';
    end;
end;

function XML_Label(str: string): string;
begin

  // Some string characters need to be changed for the XRC format
  // See http://cvs.wxwidgets.org/viewcvs.cgi/wxWidgets/docs/tech/tn0014.txt?rev=1.18&content-type=text/vnd.viewcvs-markup
  // Section 3. "Common attribute types", Subsection "String"
  strChange(str, '_', '__');
  strChange(str, '&', '_');
  strChange(str, '/', '//');
  Result := str;

end;

function GetTotalHtOfAllToolBarAndStatusBar(ParentControl: TWinControl): integer;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to ParentControl.ControlCount - 1 do    // Iterate
  begin
    if not (IsControlWxToolBar(ParentControl.Controls[i]) or
      IsControlWxStatusBar(ParentControl.Controls[i])) then
      continue;
    Result := Result + ParentControl.Controls[i].Height;
  end;    // for
end;

function IsIDPredefined(str: string; strlst: TStringList): boolean;
begin
  if strlst.IndexOf(str) <> -1 then
    Result := True
  else
    Result := False;
end;

function GetPredefinedwxIds: TStringList;
begin
  Result := TStringList.Create;
  Result.add('wxID_OPEN');
  Result.add('wxID_CLOSE');
  Result.add('wxID_NEW');
  Result.add('wxID_SAVE');
  Result.add('wxID_SAVEAS');
  Result.add('wxID_REVERT');
  Result.add('wxID_EXIT');
  Result.add('wxID_UNDO');
  Result.add('wxID_REDO');
  Result.add('wxID_HELP');
  Result.add('wxID_PRINT');
  Result.add('wxID_PRINT_SETUP');
  Result.add('wxID_PREVIEW');
  Result.add('wxID_ABOUT');
  Result.add('wxID_HELP_CONTENTS');
  Result.add('wxID_HELP_COMMANDS');
  Result.add('wxID_HELP_PROCEDURES');
  Result.add('wxID_HELP_CONTEXT');
  Result.add('wxID_CLOSE_ALL');
  Result.add('wxID_PREFERENCES');
  Result.add('wxID_CUT');
  Result.add('wxID_COPY');
  Result.add('wxID_PASTE');
  Result.add('wxID_CLEAR');
  Result.add('wxID_FIND');
  Result.add('wxID_DUPLICATE');
  Result.add('wxID_SELECTALL');
  Result.add('wxID_DELETE');
  Result.add('wxID_REPLACE');
  Result.add('wxID_REPLACE_ALL');
  Result.add('wxID_PROPERTIES');
  Result.add('wxID_VIEW_DETAILS');
  Result.add('wxID_VIEW_LARGEICONS');
  Result.add('wxID_VIEW_SMALLICONS');
  Result.add('wxID_VIEW_LIST');
  Result.add('wxID_VIEW_SORTDATE');
  Result.add('wxID_VIEW_SORTNAME');
  Result.add('wxID_VIEW_SORTSIZE');
  Result.add('wxID_VIEW_SORTTYPE');
  Result.add('wxID_FILE1');
  Result.add('wxID_FILE2');
  Result.add('wxID_FILE3');
  Result.add('wxID_FILE4');
  Result.add('wxID_FILE5');
  Result.add('wxID_FILE6');
  Result.add('wxID_FILE7');
  Result.add('wxID_FILE8');
  Result.add('wxID_FILE9');
  Result.add('wxID_OK');
  Result.add('wxID_CANCEL');
  Result.add('wxID_APPLY');
  Result.add('wxID_YES');
  Result.add('wxID_NO');
  Result.add('wxID_STATIC');
  Result.add('wxID_FORWARD');
  Result.add('wxID_BACKWARD');
  Result.add('wxID_DEFAULT');
  Result.add('wxID_MORE');
  Result.add('wxID_SETUP');
  Result.add('wxID_RESET');
  Result.add('wxID_CONTEXT_HELP');
  Result.add('wxID_YESTOALL');
  Result.add('wxID_NOTOALL');
  Result.add('wxID_ABORT');
  Result.add('wxID_RETRY');
  Result.add('wxID_IGNORE');
  Result.add('wxID_ADD');
  Result.add('wxID_REMOVE');
  Result.add('wxID_UP');
  Result.add('wxID_DOWN');
  Result.add('wxID_HOME');
  Result.add('wxID_REFRESH');
  Result.add('wxID_STOP');
  Result.add('wxID_INDEX');
  Result.add('wxID_BOLD');
  Result.add('wxID_ITALIC');
  Result.add('wxID_JUSTIFY_CENTER');
  Result.add('wxID_JUSTIFY_FILL');
  Result.add('wxID_JUSTIFY_RIGHT');
  Result.add('wxID_JUSTIFY_LEFT');
  Result.add('wxID_UNDERLINE');
  Result.add('wxID_INDENT');
  Result.add('wxID_UNINDENT');
  Result.add('wxID_ZOOM_100');
  Result.add('wxID_ZOOM_FIT');
  Result.add('wxID_ZOOM_IN');
  Result.add('wxID_ZOOM_OUT');
  Result.add('wxID_UNDELETE');
  Result.add('wxID_REVERT_TO_SAVED');
  Result.add('wxID_SYSTEM_MENU');
  Result.add('wxID_CLOSE_FRAME');
  Result.add('wxID_MOVE_FRAME');
  Result.add('wxID_RESIZE_FRAME');
  Result.add('wxID_MAXIMIZE_FRAME');
  Result.add('wxID_ICONIZE_FRAME');
  Result.add('wxID_RESTORE_FRAME');
  Result.add('wxID_FILEDLGG');
end;

function GetGridSelectionToString(grdsel: TWxGridSelection): string;
begin
  Result := 'wxGridSelectCells';
  if grdsel = wxGridSelectCells then
    Result := 'wxGridSelectCells';
  if grdsel = wxGridSelectColumns then
    Result := 'wxGridSelectColumns';
  if grdsel = wxGridSelectCells then
    Result := 'wxGridSelectCells';

end;

function GetWxFontDeclaration(fnt: TFont): string;
var
  strStyle, strWeight, strUnderline: string;
begin
  if (fnt.Name = Screen.HintFont.Name) and (fnt.Size = Screen.HintFont.Size) and
     (fnt.Style = Screen.HintFont.Style) then
     Result := ''
  else
  begin
    if fsItalic in fnt.Style then
      strStyle := 'wxITALIC'
    else
      strStyle := 'wxNORMAL';

    if fsBold in fnt.Style then
      strWeight := 'wxBOLD'
    else
      strWeight := 'wxNORMAL';

    if fsUnderline in fnt.Style then
      strUnderline := 'true'
    else
      strUnderline := 'false';

    if fnt.Name <> Screen.IconFont.Name then
      Result := Format('wxFont(%d, wxSWISS, %s, %s, %s, %s)', [fnt.Size, strStyle, strWeight, strUnderline, GetCppString(fnt.Name)])
    else
      Result := Format('wxFont(%d, wxSWISS, %s, %s, %s)', [fnt.Size, strStyle, strWeight, strUnderline]);
  end;
end;

function GetDesignerFormName(cntrl: TControl): string;
var
  ParentCtrl,PrevParentCtrl:TControl;

begin
  ParentCtrl:= cntrl.Parent;
  if ParentCtrl = nil then
  begin
    if cntrl is TfrmNewForm then
    begin
      Result:=TfrmNewForm(cntrl).Wx_Name;
      exit;
    end;
  end;
  
  while (ParentCtrl <> nil ) do
  begin
    PrevParentCtrl := ParentCtrl;
    ParentCtrl:=ParentCtrl.Parent;
    if ParentCtrl = nil then
    begin
      if PrevParentCtrl is TfrmNewForm then
        Result:= TfrmNewForm(PrevParentCtrl).Wx_Name
      else
        Result:='';
      exit;
    end;
  end;

end;

function GetWxWidgetParent(cntrl: TControl): string;
var
  TestCtrl: TControl;
begin
  Result := '';
  if cntrl = nil then
    exit;

  if cntrl.Parent = nil then
    exit;

  if cntrl.Parent is TForm then
  begin
    Result := 'this';
    exit;
  end;

  if not (cntrl.Parent is TwxSizerPanel) then
  begin
    Result := cntrl.Parent.Name;
    exit;
  end;

  if (cntrl.Parent is TWxSizerPanel) then
  begin
    TestCtrl := cntrl.Parent;
    Result   := TestCtrl.Name;
    while ((TestCtrl is TWxSizerPanel)) do
    begin
      if (TestCtrl is TWxSizerPanel) then
        TestCtrl := TestCtrl.Parent;

      if TestCtrl = nil then
      begin
        Result := 'this';
        break;
      end;
      if (TestCtrl is TForm) then
        Result := 'this'
      else
        Result := TestCtrl.Name;
    end;
  end;
end;

function GetWxWindowControls(wnCtrl: TWinControl): integer;
var
  I: integer;
  wndInterface: IWxWindowInterface;
begin
  Result := 0;
  for I := 0 to wnCtrl.ComponentCount - 1 do    // Iterate
    if wnCtrl.Components[i].GetInterface(IID_IWxWindowInterface, wndInterface) then
      Inc(Result);    // for
end;

function GetMaxIDofWxForm(ParentControl: TWinControl): integer;
var
  wxcompInterface: IWxComponentInterface;
  i: integer;
begin
  Result := 0;
  for I := 0 to ParentControl.ComponentCount - 1 do // Iterate
    if ParentControl.Components[i].GetInterface(IID_IWxComponentInterface,
      wxcompInterface) then
      if wxcompInterface.GetIDValue > Result then
        Result := wxcompInterface.GetIDValue//maxval := wxcompInterface.GetIDValue;
    //sendDeBug(IntToStr(maxval));
  ; // for

  if Result = 0 then
    Result := 1000;

end;

function GetMenuKindAsText(menuStyle: TWxMenuItemStyleItem): string;
begin
  Result := 'wxITEM_NORMAL';
  if menuStyle = wxMnuItm_Normal then
  begin
    Result := 'wxITEM_NORMAL';
    exit;
  end;

  if menuStyle = wxMnuItm_Separator then
  begin
    Result := 'wxITEM_SEPARATOR';
    exit;
  end;
  if menuStyle = wxMnuItm_Radio then
  begin
    Result := 'wxITEM_RADIO';
    exit;
  end;
  if menuStyle = wxMnuItm_Check then
  begin
    Result := 'wxITEM_CHECK';
    exit;
  end;

end;

function GetToolButtonKindAsText(toolStyle: TWxToolbottonItemStyleItem): string;
begin
  Result := 'wxITEM_NORMAL';
  if toolStyle = wxITEM_NORMAL then
  begin
    Result := 'wxITEM_NORMAL';
    exit;
  end;

  if toolStyle = wxITEM_RADIO then
  begin
    Result := 'wxITEM_RADIO';
    exit;
  end;

  if toolStyle = wxITEM_CHECK then
  begin
    Result := 'wxITEM_CHECK';
    exit;
  end;

end;

function GetAvailableControlCount(ParentControl: TWinControl;
  ControlToCheck: string): integer; overload;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to ParentControl.ComponentCount - 1 do    // Iterate
    if strContainsU(ParentControl.Components[i].ClassName, ControlToCheck) then
      Inc(Result);    // for
end;

function GetAvailableControlCount(ParentControl: TWinControl;
  ControlToCheck: TComponent): integer; overload;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to ParentControl.ComponentCount - 1 do    // Iterate
    if strContainsU(ParentControl.Components[i].ClassName, ControlToCheck.ClassName) then
      Inc(Result);    // for
end;

function GetEventNameFromDisplayName(strDisplayName: string;
  strlst: TStringList): string;
var
  I:      integer;
  strEventName, strEventCaption: string;
  intPos: integer;
begin
  Result := '';
  for i := 0 to strlst.Count - 1 do // Iterate
  begin
    intPos := Pos(':', strlst[i]);
    strEventName := Copy(strlst[i], 0, intPos - 1);
    strEventCaption := Trim(Copy(strlst[i], intPos + 1, Length(strlst[i])));
    if AnsiSameText(strEventCaption, strDisplayName) then
      Result := strEventName;
  end; // for
end;

function IsValidClass(comp: TComponent): boolean;
var
  intfObj: IWxComponentInterface;
begin
  Result := comp.GetInterface(IID_IWxComponentInterface, intfObj);
end;

//Here is the start
function GetCheckboxStyleString(stdStyle: TWxcbxStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin
  strLst := TStringList.Create;

  try

    if wxCHK_2STATE in stdStyle then
      strLst.add('wxCHK_2STATE ');

    if wxCHK_3STATE in stdStyle then
      strLst.add('wxCHK_3STATE ');

    if wxCHK_ALLOW_3RD_STATE_FOR_USER in stdStyle then
      strLst.add('wxCHK_ALLOW_3RD_STATE_FOR_USER');

    if wxALIGN_RIGHT_CB in stdStyle then
      strLst.add('wxALIGN_RIGHT');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;

function GetTreeviewStyleString(stdStyle: TWxtvStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin
  strLst := TStringList.Create;

  try
    if wxTR_EDIT_LABELS in stdStyle then
      strLst.add('wxTR_EDIT_LABELS');

    if wxTR_NO_BUTTONS in stdStyle then
      strLst.add('wxTR_NO_BUTTONS');

    if wxTR_HAS_BUTTONS in stdStyle then
      strLst.add('wxTR_HAS_BUTTONS');

    if wxTR_TWIST_BUTTONS in stdStyle then
      strLst.add('wxTR_TWIST_BUTTONS');

    if wxTR_NO_LINES in stdStyle then
      strLst.add('wxTR_NO_LINES');

    if wxTR_FULL_ROW_HIGHLIGHT in stdStyle then
      strLst.add('wxTR_FULL_ROW_HIGHLIGHT');

    if wxTR_LINES_AT_ROOT in stdStyle then
      strLst.add('wxTR_LINES_AT_ROOT');

    if wxTR_HIDE_ROOT in stdStyle then
      strLst.add('wxTR_HIDE_ROOT');

    if wxTR_ROW_LINES in stdStyle then
      strLst.add('wxTR_ROW_LINES');

    if wxTR_HAS_VARIABLE_ROW_HEIGHT in stdStyle then
      strLst.add('wxTR_HAS_VARIABLE_ROW_HEIGHT');

    if wxTR_SINGLE in stdStyle then
      strLst.add('wxTR_SINGLE');

    if wxTR_MULTIPLE in stdStyle then
      strLst.add('wxTR_MULTIPLE');

    if wxTR_EXTENDED in stdStyle then
      strLst.add('wxTR_EXTENDED');

    if wxTR_DEFAULT_STYLE in stdStyle then
      strLst.add('wxTR_DEFAULT_STYLE');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;

function GetRadiobuttonStyleString(stdStyle: TWxrbStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxRB_GROUP in stdStyle then
      strLst.add('wxRB_GROUP');

    if wxRB_SINGLE in stdStyle then
      strLst.add('wxRB_SINGLE');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;

function GetListboxStyleString(stdStyle: TWxlbxStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin
  strLst := TStringList.Create;

  try
    // if wxLB_SINGLE  in stdStyle then
    //   strLst.add('wxLB_SINGLE');

    // if wxLB_MULTIPLE  in stdStyle then
    //  strLst.add('wxLB_MULTIPLE');

    // if wxLB_EXTENDED   in stdStyle then
    //   strLst.add('wxLB_EXTENDED');

    if wxLB_HSCROLL in stdStyle then
      strLst.add('wxLB_HSCROLL');

    if wxLB_ALWAYS_SB in stdStyle then
      strLst.add('wxLB_ALWAYS_SB');

    if wxLB_NEEDED_SB in stdStyle then
      strLst.add('wxLB_NEEDED_SB');

    if wxLB_SORT in stdStyle then
      strLst.add('wxLB_SORT');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
  finally
    strLst.Destroy;
  end;
end;

function GetGaugeStyleString(stdStyle: TWxgagStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxGA_SMOOTH in stdStyle then
      strLst.add('wxGA_SMOOTH');

    if wxGA_MARQUEE in stdStyle then
      strLst.add('wxGA_MARQUEE');
    
    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;

function GetScrollbarStyleString(stdStyle: TWxsbrStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxST_SIZEGRIP in stdStyle then
      strLst.add('wxST_SIZEGRIP');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;

function GetSpinButtonStyleString(stdStyle: TWxsbtnStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxSP_ARROW_KEYS in stdStyle then
      strLst.add('wxSP_ARROW_KEYS');

    if wxSP_WRAP in stdStyle then
      strLst.add('wxSP_WRAP');

 { if wxSP_HORIZONTAL in stdStyle then
    strLst.add('wxSP_HORIZONTAL');

  if wxSP_VERTICAL in stdStyle then
    strLst.add('wxSP_VERTICAL');
  }
    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;

end;

function GetHyperLnkStyleString(stdStyle: TWxHyperLnkStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin
  strLst:= TStringList.Create;
  try
    if wxHL_ALIGN_LEFT in stdStyle then
      strLst.add('wxHL_ALIGN_LEFT');

    if wxHL_ALIGN_RIGHT in stdStyle then
      strLst.add('wxHL_ALIGN_RIGHT');

    if wxHL_ALIGN_CENTRE in stdStyle then
      strLst.add('wxHL_ALIGN_CENTRE');

    if wxHL_CONTEXTMENU in stdStyle then
      strLst.add('wxHL_CONTEXTMENU');

    if wxHL_DEFAULT_STYLE in stdStyle then
      strLst.add('wxHL_DEFAULT_STYLE');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;


function GetSliderStyleString(stdStyle: TWxsldrStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxSL_AUTOTICKS in stdStyle then
      strLst.add('wxSL_AUTOTICKS');

    if wxSL_LABELS in stdStyle then
      strLst.add('wxSL_LABELS');

    if wxSL_LEFT in stdStyle then
      strLst.add('wxSL_LEFT');

    if wxSL_RIGHT in stdStyle then
      strLst.add('wxSL_RIGHT');

    if wxSL_TOP in stdStyle then
      strLst.add('wxSL_TOP');

    if wxSL_BOTTOM in stdStyle then
      strLst.add('wxSL_BOTTOM');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;

function GetPickCalStyleString(stdStyle: TWxPickCalStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxDP_SPIN  in stdStyle then
      strLst.add('wxDP_SPIN');

    if wxDP_DROPDOWN in stdStyle then
      strLst.add('wxDP_DROPDOWN');

    if wxDP_DEFAULT in stdStyle then
      strLst.add('wxDP_DEFAULT');

    if wxDP_ALLOWNONE  in stdStyle then
      strLst.add('wxDP_ALLOWNONE');

    if wxDP_SHOWCENTURY in stdStyle then
      strLst.add('wxDP_SHOWCENTURY');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;

function GetCalendarCtrlStyleString(stdStyle: TWxcalctrlStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxCAL_SUNDAY_FIRST in stdStyle then
      strLst.add('wxCAL_SUNDAY_FIRST');

    if wxCAL_MONDAY_FIRST in stdStyle then
      strLst.add('wxCAL_MONDAY_FIRST');

    if wxCAL_SHOW_HOLIDAYS in stdStyle then
      strLst.add('wxCAL_SHOW_HOLIDAYS');

    if wxCAL_NO_YEAR_CHANGE in stdStyle then
      strLst.add('wxCAL_NO_YEAR_CHANGE');

    if wxCAL_NO_MONTH_CHANGE in stdStyle then
      strLst.add('wxCAL_NO_MONTH_CHANGE');

    if wxCAL_SHOW_SURROUNDING_WEEKS in stdStyle then
      strLst.add('wxCAL_SHOW_SURROUNDING_WEEKS');

    if wxCAL_SEQUENTIAL_MONTH_SELECTION in stdStyle then
      strLst.add('wxCAL_SEQUENTIAL_MONTH_SELECTION');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;

end;


function GetNotebookStyleString(stdStyle: TWxnbxStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxNB_LEFT in stdStyle then
      strLst.add('wxNB_LEFT');

    if wxNB_RIGHT in stdStyle then
      strLst.add('wxNB_RIGHT');

    if wxNB_BOTTOM in stdStyle then
      strLst.add('wxNB_BOTTOM');

    if wxNB_FIXEDWIDTH in stdStyle then
      strLst.add('wxNB_FIXEDWIDTH');

    if wxNB_MULTILINE in stdStyle then
      strLst.add('wxNB_MULTILINE');

    if wxNB_NOPAGETHEME in stdStyle then
      strLst.add('wxNB_NOPAGETHEME');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;

function GetRadioBoxStyleString(stdStyle: TWxrbxStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxRA_SPECIFY_ROWS in stdStyle then
      strLst.add('wxRA_SPECIFY_ROWS');

    if wxRA_SPECIFY_COLS in stdStyle then
      strLst.add('wxRA_SPECIFY_COLS');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;

function GetStatusBarStyleString(stdStyle: TWxsbrStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxST_SIZEGRIP in stdStyle then
      strLst.add('wxST_SIZEGRIP');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;


function GetToolBarStyleString(stdStyle: TWxtbrStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin
  strLst := TStringList.Create;

  try
    if wxTB_FLAT in stdStyle then
      strLst.add('wxTB_FLAT');

    if wxTB_DOCKABLE in stdStyle then
      strLst.add('wxTB_DOCKABLE');

    if wxTB_HORIZONTAL in stdStyle then
      strLst.add('wxTB_HORIZONTAL');

    if wxTB_VERTICAL in stdStyle then
      strLst.add('wxTB_VERTICAL');

    if wxTB_TEXT in stdStyle then
      strLst.add('wxTB_TEXT');

    if wxTB_NOICONS in stdStyle then
      strLst.add('wxTB_NOICONS');

    if wxTB_NODIVIDER in stdStyle then
      strLst.add('wxTB_NODIVIDER');

    if wxTB_NOALIGN in stdStyle then
      strLst.add('wxTB_NOALIGN');

    if wxTB_HORZ_LAYOUT in stdStyle then
      strLst.add('wxTB_HORZ_LAYOUT');

    if wxTB_HORZ_TEXT in stdStyle then
      strLst.add('wxTB_HORZ_TEXT');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;

function GetScrolledWindowStyleString(stdStyle: TWxScrWinStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin
  strLst := TStringList.Create;

  try
    if wxRETAINED in stdStyle then
      strLst.add('wxRETAINED');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;


function GetHtmlWindowStyleString(stdStyle: TWxHtmlWinStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxHW_SCROLLBAR_NEVER in stdStyle then
      strLst.add('wxHW_SCROLLBAR_NEVER');

    if wxHW_SCROLLBAR_AUTO in stdStyle then
      strLst.add('wxHW_SCROLLBAR_AUTO');

    if wxHW_NO_SELECTION in stdStyle then
      strLst.add('wxHW_NO_SELECTION ');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;

function GetSplitterWindowStyleString(stdStyle: TWxSplitterWinStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxSP_3D in stdStyle then
      strLst.add('wxSP_3D');

    if wxSP_3DSASH in stdStyle then
      strLst.add('wxSP_3DSASH');

    if wxSP_3DBORDER in stdStyle then
      strLst.add('wxSP_3DBORDER ');

    if wxSP_BORDER in stdStyle then
      strLst.add('wxSP_BORDER');

    if wxSP_NOBORDER in stdStyle then
      strLst.add('wxSP_NOBORDER');

    if wxSP_NO_XP_THEME in stdStyle then
      strLst.add('wxSP_NO_XP_THEME ');

    if wxSP_PERMIT_UNSPLIT in stdStyle then
      strLst.add('wxSP_PERMIT_UNSPLIT');

    if wxSP_LIVE_UPDATE in stdStyle then
      strLst.add('wxSP_LIVE_UPDATE');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;


function GetFileDialogStyleString(stdStyle: TWxFileDialogStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxHIDE_READONLY in stdStyle then
      strLst.add('wxHIDE_READONLY');

    if wxOVERWRITE_PROMPT in stdStyle then
      strLst.add('wxOVERWRITE_PROMPT');

    if wxFILE_MUST_EXIST in stdStyle then
      strLst.add('wxFILE_MUST_EXIST');

    if wxMULTIPLE in stdStyle then
      strLst.add('wxMULTIPLE');

    if wxCHANGE_DIR in stdStyle then
      strLst.add('wxCHANGE_DIR');

    if strLst.Count = 0 then
      Result := ''
    else begin
      Result := ' | ';
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]; // for
    end;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;

end;

function GetDirDialogStyleString(stdStyle: TWxDirDialogStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxDD_NEW_DIR_BUTTON in stdStyle then
      strLst.add('wxDD_NEW_DIR_BUTTON');


    if strLst.Count = 0 then
      Result := ''
    else begin
      Result := ', ';
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]; // for
    end;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;

end;


function GetProgressDialogStyleString(stdStyle: TWxProgressDialogStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxPD_APP_MODAL in stdStyle then
      strLst.add('wxPD_APP_MODAL');

    if wxPD_SMOOTH in stdStyle then
      strLst.add('wxPD_SMOOTH');

    if wxPD_CAN_SKIP in stdStyle then
      strLst.add('wxPD_CAN_SKIP');

    if wxPD_AUTO_HIDE in stdStyle then
      strLst.add('wxPD_AUTO_HIDE');

    if wxPD_CAN_ABORT in stdStyle then
      strLst.add('wxPD_CAN_ABORT ');

    if wxPD_ELAPSED_TIME in stdStyle then
      strLst.add('wxPD_ELAPSED_TIME ');

    if wxPD_ESTIMATED_TIME in stdStyle then
      strLst.add('wxPD_ESTIMATED_TIME');

    if wxPD_REMAINING_TIME in stdStyle then
      strLst.add('wxPD_REMAINING_TIME ');

    if strLst.Count = 0 then
      Result := ''
    else begin
      Result := ', ';
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]; // for
    end;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;

end;

function GetMediaCtrlStyle(mediaStyle:TWxMediaCtrlControl): string;
begin
    if wxMEDIACTRLPLAYERCONTROLS_NONE = mediaStyle then
      Result:='wxMEDIACTRLPLAYERCONTROLS_NONE';

    if wxMEDIACTRLPLAYERCONTROLS_STEP = mediaStyle then
      Result:='wxMEDIACTRLPLAYERCONTROLS_STEP';

    if wxMEDIACTRLPLAYERCONTROLS_VOLUME = mediaStyle then
      Result:='wxMEDIACTRLPLAYERCONTROLS_VOLUME';

end;

function GetMediaCtrlStyleString(mediaStyle:TWxMediaCtrlControls): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxMEDIACTRLPLAYERCONTROLS_NONE in mediaStyle then
      strLst.add('wxMEDIACTRLPLAYERCONTROLS_NONE');

    if wxMEDIACTRLPLAYERCONTROLS_STEP in mediaStyle then
      strLst.add('wxMEDIACTRLPLAYERCONTROLS_STEP');

    if wxMEDIACTRLPLAYERCONTROLS_VOLUME in mediaStyle then
      strLst.add('wxMEDIACTRLPLAYERCONTROLS_VOLUME');

    if strLst.Count = 0 then
      Result := ''
    else begin
      Result := ' ';
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]; // for
    end;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;

function GetMessageDialogStyleString(stdStyle: TWxMessageDialogStyleSet;NoEndComma:Boolean): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxOK in stdStyle then
      strLst.add('wxOK');

    if wxCANCEL in stdStyle then
      strLst.add('wxCANCEL');

    if wxYES_NO in stdStyle then
      strLst.add('wxYES_NO');

    if wxYES_DEFAULT in stdStyle then
      strLst.add('wxYES_DEFAULT');

    if wxNO_DEFAULT in stdStyle then
      strLst.add('wxNO_DEFAULT');

    if wxICON_EXCLAMATION in stdStyle then
      strLst.add('wxICON_EXCLAMATION');

    if wxICON_HAND in stdStyle then
      strLst.add('wxICON_HAND');

    if wxICON_ERROR in stdStyle then
      strLst.add('wxICON_ERROR');

    if wxICON_QUESTION in stdStyle then
      strLst.add('wxICON_QUESTION');

    if wxICON_INFORMATION in stdStyle then
      strLst.add('wxICON_INFORMATION');

    if wxCENTRE in stdStyle then
      strLst.add('wxCENTRE');

    if strLst.Count = 0 then
      Result := ''
    else begin
      Result := ' ';
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]; // for
    end;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

  if (Result <> '') AND (NoEndComma = false) then
  begin
    Result := ',' + Result;
  end;
end;

function GetFindReplaceFlagString(stdstyle: TWxFindReplaceFlagSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxFR_DOWN in stdStyle then
      strLst.add('wxFR_DOWN');

    if wxFR_WHOLEWORD in stdStyle then
      strLst.add('wxFR_WHOLEWORD');

    if wxFR_MATCHCASE in stdStyle then
      strLst.add('wxFR_MATCHCASE ');

    if strLst.Count = 0 then
      Result := ''
    else begin
      Result := '';
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]; // for
    end;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;


function GetFindReplaceDialogStyleString(stdstyle: TWxFindReplaceDialogStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxFR_REPLACEDIALOG in stdStyle then
      strLst.add('wxFR_REPLACEDIALOG');

    if wxFR_NOUPDOWN in stdStyle then
      strLst.add('wxFR_NOUPDOWN ');

    if wxFR_NOMATCHCASE in stdStyle then
      strLst.add('wxFR_NOMATCHCASE');

    if wxFR_NOWHOLEWORD in stdStyle then
      strLst.add('wxFR_NOWHOLEWORD');

    if strLst.Count = 0 then
      Result := ''
    else begin
      Result := ', ';
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]; // for
    end;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;

end;



//Here is the end;
function GetComboxBoxStyleString(stdStyle: TWxCmbStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxCB_SIMPLE in stdStyle then
      strLst.add('wxCB_SIMPLE');

    if wxCB_DROPDOWN in stdStyle then
      strLst.add('wxCB_DROPDOWN');

    if wxCB_READONLY in stdStyle then
      strLst.add('wxCB_READONLY');

    if wxCB_SORT in stdStyle then
      strLst.add('wxCB_SORT');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;

function GetOwnComboxBoxStyleString(stdStyle: TWxOwnCmbStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxODCB_DCLICK_CYCLES in stdStyle then
      strLst.add('wxODCB_DCLICK_CYCLES');

    if wxODCB_STD_CONTROL_PAINT in stdStyle then
      strLst.add('wxODCB_STD_CONTROL_PAINT');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;


function GetDlgStyleString(stdStyle: TWxDlgStyleSet; wxclassname: string): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxCAPTION in stdStyle then
      strLst.add('wxCAPTION');

    if wxRESIZE_BORDER in stdStyle then
      strLst.add('wxRESIZE_BORDER');

    if wxSYSTEM_MENU in stdStyle then
      strLst.add('wxSYSTEM_MENU');

    if wxTHICK_FRAME in stdStyle then
      strLst.add('wxTHICK_FRAME');

    if wxSTAY_ON_TOP in stdStyle then
      strLst.add('wxSTAY_ON_TOP');

    if strEqual(wxclassname, 'wxDialog') then
      if wxDIALOG_NO_PARENT in stdStyle then
        strLst.add('wxDIALOG_NO_PARENT');

    if wxDIALOG_EX_CONTEXTHELP in stdStyle then
      strLst.add('wxDIALOG_EX_CONTEXTHELP');

    if wxFRAME_EX_CONTEXTHELP in stdStyle then
      strLst.add('wxFRAME_EX_CONTEXTHELP');

    if wxMINIMIZE_BOX in stdStyle then
      strLst.add('wxMINIMIZE_BOX');

    if wxMAXIMIZE_BOX in stdStyle then
      strLst.add('wxMAXIMIZE_BOX');

    if wxCLOSE_BOX in stdStyle then
      strLst.add('wxCLOSE_BOX');

    if wxNO_3D in stdStyle then
      strLst.add('wxNO_3D');

    if wxMINIMIZE in stdStyle then
      strLst.add('wxMINIMIZE');

    if wxMAXIMIZE in stdStyle then
      strLst.add('wxMAXIMIZE');

    if wxFRAME_TOOL_WINDOW in stdStyle then
      strLst.add('wxFRAME_TOOL_WINDOW');

    if wxFRAME_NO_TASKBAR in stdStyle then
      strLst.add('wxFRAME_NO_TASKBAR');

    if wxFRAME_FLOAT_ON_PARENT in stdStyle then
      strLst.add('wxFRAME_FLOAT_ON_PARENT');

    if wxFRAME_SHAPED in stdStyle then
      strLst.add('wxFRAME_SHAPED');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;

function GetButtonStyleString(stdStyle: TWxBtnStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxBU_AUTODRAW in stdStyle then
      strLst.add('wxBU_AUTODRAW');

    if wxBU_LEFT in stdStyle then
      strLst.add('wxBU_LEFT');

    if wxBU_TOP in stdStyle then
      strLst.add('wxBU_TOP');

    if wxBU_RIGHT in stdStyle then
      strLst.add('wxBU_RIGHT');

    if wxBU_EXACTFIT in stdStyle then
      strLst.add('wxBU_EXACTFIT');

    if wxBU_BOTTOM in stdStyle then
      strLst.add('wxBU_BOTTOM');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;
end;

function GetLbStyleString(stdStyle: TWxLbStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxST_ALIGN_LEFT in stdStyle then
      strLst.add('wxALIGN_LEFT');

    if wxST_ALIGN_RIGHT in stdStyle then
      strLst.add('wxALIGN_RIGHT');

    if wxST_ALIGN_CENTRE in stdStyle then
      strLst.add('wxALIGN_CENTRE');

    if wxST_NO_AUTORESIZE in stdStyle then
      strLst.add('wxST_NO_AUTORESIZE');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;

end;

function GetRichTextStyleString(edtdStyle: TWxRichTextStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxRE_READONLY in edtdStyle then
      strLst.add('wxRE_READONLY');

    if wxRE_MULTILINE in edtdStyle then
      strLst.add('wxRE_MULTILINE');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;

end;

function GetEdtStyleString(edtdStyle: TWxEdtGeneralStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxTE_PROCESS_ENTER in edtdStyle then
      strLst.add('wxTE_PROCESS_ENTER');

    if wxTE_PROCESS_TAB in edtdStyle then
      strLst.add('wxTE_PROCESS_TAB');

    if wxTE_PASSWORD in edtdStyle then
      strLst.add('wxTE_PASSWORD');

    if wxTE_READONLY in edtdStyle then
      strLst.add('wxTE_READONLY');

    if wxTE_RICH in edtdStyle then
      strLst.add('wxTE_RICH');

    if wxTE_RICH2 in edtdStyle then
      strLst.add('wxTE_RICH2');

    if wxTE_AUTO_URL in edtdStyle then
      strLst.add('wxTE_AUTO_URL');

    if wxTE_NOHIDESEL in edtdStyle then
      strLst.add('wxTE_NOHIDESEL');

    if wxTE_LEFT in edtdStyle then
      strLst.add('wxTE_LEFT');

    if wxTE_CENTRE in edtdStyle then
      strLst.add('wxTE_CENTRE');

    if wxTE_RIGHT in edtdStyle then
      strLst.add('wxTE_RIGHT');

    if wxTE_DONTWRAP in edtdStyle then
      strLst.add('wxTE_DONTWRAP');

    if wxTE_BESTWRAP in edtdStyle then
      strLst.add('wxTE_BESTWRAP');

    if wxTE_CHARWRAP in edtdStyle then
      strLst.add('wxTE_CHARWRAP');

    if wxTE_LINEWRAP in edtdStyle then
      strLst.add('wxTE_LINEWRAP');

    if wxTE_WORDWRAP in edtdStyle then
      strLst.add('wxTE_WORDWRAP');

    if wxTE_CAPITALIZE in edtdStyle then
      strLst.add('wxTE_CAPITALIZE');

    if wxTE_MULTILINE in edtdStyle then
      strLst.add('wxTE_MULTILINE');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;

function GetTextEntryDialogStyleString(stdStyle: TWxMessageDialogStyleSet; edtStyle:TWxEdtGeneralStyleSet): string;
var
  strA,strB:String;
begin
  strA   := trim(GetMessageDialogStyleString(stdStyle,true));
  strB   := trim(GetEdtStyleString(edtStyle));

  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

  if strB <> '' then
    if trim(Result) = '' then
      Result := strB
    else
      Result := Result + ' | ' + strB;

    if Result <> '' then
    begin
      Result := ',' + Result;
    end;
end;


function GetEditSpecificStyle(stdstyle: TWxStdStyleSet;
  dlgstyle: TWxEdtGeneralStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetEdtStyleString(dlgstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetRichTextSpecificStyle(stdstyle: TWxStdStyleSet; dlgstyle: TWxRichTextStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetRichTextStyleString(dlgstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;
end;

function GetcomboBoxSpecificStyle(stdstyle: TWxStdStyleSet;
  cmbstyle: TWxCmbStyleSet; edtstyle: TWxEdtGeneralStyleSet): string;
var
  strA: string;
  strB: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetComboxBoxStyleString(cmbstyle));
  strB   := trim(GetEdtStyleString(edtstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;
  if strB <> '' then
    if trim(Result) = '' then
      Result := strB
    else
      Result := Result + ' | ' + strB;
end;

function GetOwncomboBoxSpecificStyle(stdstyle: TWxStdStyleSet;
  cmbstyle: TWxCmbStyleSet; edtstyle: TWxEdtGeneralStyleSet;owncmbstyle: TWxOwnCmbStyleSet): string;
var
  strA: string;
  strB: string;
  strC: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetComboxBoxStyleString(cmbstyle));
  strB   := trim(GetEdtStyleString(edtstyle));
  strC   := trim(GetOwnComboxBoxStyleString(Owncmbstyle));

  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

  if strB <> '' then
    if trim(Result) = '' then
      Result := strB
    else
      Result := Result + ' | ' + strB;

  if strC <> '' then
    if trim(Result) = '' then
      Result := strC
    else
      Result := Result + ' | ' + strC;
end;


function GetListViewStyleString(lstvwstyle: TWxLVStyleSet; view: TWxLvView): string;
var
  I:      integer;
  strLst: TStringList;
begin
  strLst := TStringList.Create;

  case view of
    wxLC_LIST:
      strLst.add('wxLC_LIST');
    wxLC_REPORT:
      strLst.add('wxLC_REPORT');
    wxLC_VIRTUAL:
    begin
      strLst.add('wxLC_VIRTUAL');
      strLst.add('wxLC_REPORT');
    end;
    wxLC_ICON:
      strLst.add('wxLC_ICON');
    wxLC_SMALL_ICON:
      strLst.add('wxLC_SMALL_ICON');
{$IFDEF PRIVATE_BUILD}
    wxLC_TILE:
      strLst.add('wxLC_TILE');
{$ENDIF}
  end;
  
  try
    if wxLC_ALIGN_TOP in lstvwstyle then
      strLst.add('wxLC_ALIGN_TOP');

    if wxLC_ALIGN_LEFT in lstvwstyle then
      strLst.add('wxLC_ALIGN_LEFT');

    if wxLC_AUTOARRANGE in lstvwstyle then
      strLst.add('wxLC_AUTOARRANGE');

    if wxLC_EDIT_LABELS in lstvwstyle then
      strLst.add('wxLC_EDIT_LABELS');

    if wxLC_NO_HEADER in lstvwstyle then
      strLst.add('wxLC_NO_HEADER');

    if wxLC_NO_SORT_HEADER in lstvwstyle then
      strLst.add('wxLC_NO_SORT_HEADER');

    if wxLC_SINGLE_SEL in lstvwstyle then
      strLst.add('wxLC_SINGLE_SEL');

    if wxLC_SORT_ASCENDING in lstvwstyle then
      strLst.add('wxLC_SORT_ASCENDING');

    if wxLC_SORT_DESCENDING in lstvwstyle then
      strLst.add('wxLC_SORT_DESCENDING');

    if wxLC_HRULES in lstvwstyle then
      strLst.add('wxLC_HRULES');

    if wxLC_VRULES in lstvwstyle then
      strLst.add('wxLC_VRULES');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i];
  finally
    strLst.Destroy;
  end;
end;

function GetListViewSpecificStyle(stdstyle: TWxStdStyleSet;
  lstvwstyle: TWxLVStyleSet; view: TWxLvView): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetListViewStyleString(lstvwstyle, view));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      if strA = '' then
        Result := Result
      else
        Result := Result + ' | ' + strA;

  if trim(Result) <> '' then
    Result := ', ' + Result;
end;

//Start here
function GetCheckboxSpecificStyle(stdstyle: TWxStdStyleSet;
  cbxstyle: TWxcbxStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetCheckBoxStyleString(cbxstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetTreeviewSpecificStyle(stdstyle: TWxStdStyleSet;
  tvstyle: TWxTVStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetTreeViewStyleString(tvstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetRadiobuttonSpecificStyle(stdstyle: TWxStdStyleSet;
  rbstyle: TWxrbStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetRadioButtonStyleString(rbstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetListboxSpecificStyle(stdstyle: TWxStdStyleSet;
  lbxstyle: TWxlbxStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetListBoxStyleString(lbxstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetGaugeSpecificStyle(stdstyle: TWxStdStyleSet;
  gagstyle: TWxgagStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetGaugeStyleString(gagstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetScrollbarSpecificStyle(stdstyle: TWxStdStyleSet;
  scbrstyle: TWxsbrStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetScrollbarStyleString(scbrstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetHyperLnkSpecificStyle(stdstyle: TWxStdStyleSet;edtstyle: TWxHyperLnkStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetHyperLnkStyleString(edtstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;


function GetSpinButtonSpecificStyle(stdstyle: TWxStdStyleSet;
  sbtnstyle: TWxsbtnStyleSet; edtstyle: TWxEdtGeneralStyleSet): string;
var
  strA: string;
  strB: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetSpinButtonStyleString(sbtnstyle));
  strB   := trim(GetEdtStyleString(edtstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;
  if strB <> '' then
    if trim(Result) = '' then
      Result := strB
    else
      Result := Result + ' | ' + strB;
end;

function GetSliderSpecificStyle(stdstyle: TWxStdStyleSet;
  sldrstyle: TWxsldrStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetSliderStyleString(sldrstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;



//function GetStaticBitmapSpecificStyle(stdstyle: TWxStdStyleSet;sbtmpstyle:TWxsbtmpStyleSet):String;
 //var
 //  strA: string;
 //begin
 //  Result := GetStdStyleString(stdstyle);
 //  strA := trim(GetStaticBitmapStyleString(sbtmpstyle));
 //  if strA <> '' then
 //  begin
 //    if trim(Result) = '' then
 //      Result := strA
 //    else
 //      Result := Result + ' | ' + strA
 //  end;

 //  if trim(Result) <> '' then
 //    Result := ', ' + Result;
 //end;
function GetDateVariableExpansion(value:TDateTime):string;
var
  Year, Month, Day: Word;
begin
  DecodeDate(value,Year, Month, Day);
  Result:= Format('wxDateTime(%d,(wxDateTime::Month)%d,%d)',[Day,Month,Year]);
end;

function GetCalendarCtrlSpecificStyle(stdstyle: TWxStdStyleSet;
  calctrlstyle: TWxcalctrlStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetCalendarCtrlStyleString(calctrlstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetPickCalSpecificStyle(stdstyle: TWxStdStyleSet;
  calctrlstyle: TWxPickCalStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetPickCalStyleString(calctrlstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

 //function GetChoiceSpecificStyle(stdstyle: TWxStdStyleSet;chstyle:TWxchStyleSet):String;
 //var
 //  strA: string;
 //begin
 //  Result := GetStdStyleString(stdstyle);
 //  strA := trim(GetChoiceStyleString(chstyle));
 //  if strA <> '' then
 //  begin
 //    if trim(Result) = '' then
 //      Result := strA
 //    else
 //      Result := Result + ' | ' + strA
 //  end;

 //  if trim(Result) <> '' then
 //    Result := ', ' + Result;
 //end;

function GetNotebookSpecificStyle(stdstyle: TWxStdStyleSet;
  nbxstyle: TWxnbxStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetNotebookStyleString(nbxstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetRadioBoxSpecificStyle(stdstyle: TWxStdStyleSet;
  rbxstyle: TWxrbxStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetRadioBoxStyleString(rbxstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetStatusBarSpecificStyle(stdstyle: TWxStdStyleSet;
  sbrstyle: TWxsbrStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetStatusBarStyleString(sbrstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

//function GetToggleButtonSpecificStyle(stdstyle: TWxStdStyleSet;tbtnstyle:TWxtbtnStyleSet):String;
 //var
 //  strA: string;
 //begin
 //  Result := GetStdStyleString(stdstyle);
 //  strA := trim(GetToggleButtonStyleString(tbtnstyle));
 //  if strA <> '' then
 //  begin
 //    if trim(Result) = '' then
 //      Result := strA
 //    else
 //      Result := Result + ' | ' + strA
 //  end;

 //  if trim(Result) <> '' then
 //    Result := ', ' + Result;
 //end;

function GetScrolledWindowSpecificStyle(stdstyle: TWxStdStyleSet;
  scrWinStyle: TWxScrWinStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetScrolledWindowStyleString(scrWinStyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetHtmlWindowSpecificStyle(stdstyle: TWxStdStyleSet;
  htmlWinStyle: TWxHtmlWinStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetHtmlWindowStyleString(htmlWinStyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetSplitterWindowSpecificStyle(stdstyle: TWxStdStyleSet;
  SplitterWinStyle: TWxSplitterWinStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetSplitterWindowStyleString(SplitterWinStyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetToolBarSpecificStyle(stdstyle: TWxStdStyleSet;
  tbrstyle: TWxtbrStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetToolBarStyleString(tbrstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

//End here
function RGBFormatStrToColor(strColorValue: string): TColor;
var
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    strTokenToStrings(strColorValue, ',', strLst);
    if strLst.Count > 2 then
      Result := RGB(StrToInt(strLst[0]), StrToInt(strLst[1]), StrToInt(strLst[2]))
    else
      Result := RGB(0, 0, 0);

  finally
    strLst.Destroy;
  end;
end;

function GetColorFromString(strColorValue: string): TColor;
var
  strChoice, strCmd: string;
begin
  strChoice := copy(strColorValue, 5, length(strColorValue));
  strCmd    := copy(strColorValue, 0, 4);
  if AnsiSameText(strCmd, 'CUS:') then
  begin
    Result := RGBFormatStrToColor(strChoice);
    exit;
  end;
  Result := GetGeneralColorFromString(strChoice);
end;

procedure PopulateGenericProperties(var PropertyList: TStringList);
begin
  PropertyList.Add('Wx_Enabled:Enabled');
  PropertyList.Add('Wx_Class:Base Class');
  PropertyList.Add('Wx_Hidden:Hidden');
  PropertyList.Add('Wx_Default:Default');
  PropertyList.Add('Wx_HelpText:Help Text');
  PropertyList.Add('Wx_IDName:ID Name');
  PropertyList.Add('Wx_IDValue:ID Value');
  PropertyList.Add('Wx_ToolTip:Tooltip');
  PropertyList.Add('Wx_Comments:Comments');
  PropertyList.Add('Wx_Validator:Validator Code');
  PropertyList.Add('Wx_ProxyBGColorString:Background Color');
  PropertyList.Add('Wx_ProxyFGColorString:Foreground Color');

  PropertyList.Add('Wx_StretchFactor:Stretch Factor');
  PropertyList.Add('Wx_Alignment:Alignment');
  PropertyList.Add('wxALIGN_LEFT:wxALIGN_LEFT');
  PropertyList.Add('wxALIGN_RIGHT:wxALIGN_RIGHT');
  PropertyList.Add('wxALIGN_TOP:wxALIGN_TOP');
  PropertyList.Add('wxALIGN_BOTTOM:wxALIGN_BOTTOM');
  PropertyList.Add('wxALIGN_CENTER:wxALIGN_CENTER');
  PropertyList.Add('wxALIGN_CENTER_HORIZONTAL:wxALIGN_CENTER_HORIZONTAL');
  PropertyList.Add('wxALIGN_CENTER_VERTICAL:wxALIGN_CENTER_VERTICAL');
  PropertyList.Add('wxEXPAND:wxEXPAND');

  PropertyList.Add('Wx_Border:Border');
  PropertyList.Add('Wx_BorderAlignment:Borders');
  PropertyList.Add('wxALL:wxALL');
  PropertyList.Add('wxTOP:wxTOP');
  PropertyList.Add('wxLEFT:wxLEFT');
  PropertyList.Add('wxRIGHT:wxRIGHT');
  PropertyList.Add('wxBOTTOM:wxBOTTOM');
  
  PropertyList.Add('Wx_GeneralStyle:General Styles');
  PropertyList.Add('wxNO_3D:wxNO_3D');
  PropertyList.Add('wxNO_BORDER:wxNO_BORDER');
  PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
  PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');
  PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
  PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
  PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
  PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
  PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
  PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
  PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
  PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
  PropertyList.Add('wxVSCROLL:wxVSCROLL');
  PropertyList.Add('wxHSCROLL:wxHSCROLL');

  PropertyList.Add('Font:Font');
  PropertyList.Add('Name:Name');
  PropertyList.Add('Width:Width');
  PropertyList.Add('Height:Height');
  PropertyList.Add('Left:Left');
  PropertyList.Add('Top:Top');
end;

function SizerAlignmentToStr(SizerAlignment: TWxSizerAlignmentSet): string;
var
  Styles: TStringList;
  I: Integer;
begin
  Styles := TStringList.Create;
  if wxALIGN_LEFT in SizerAlignment then
    Styles.Add('wxALIGN_LEFT');

  if wxALIGN_RIGHT in SizerAlignment then
    Styles.Add('wxALIGN_RIGHT');

  if wxALIGN_TOP in SizerAlignment then
    Styles.Add('wxALIGN_TOP');

  if wxALIGN_BOTTOM in SizerAlignment then
    Styles.Add('wxALIGN_BOTTOM');

  if wxALIGN_CENTER in SizerAlignment then
    Styles.Add('wxALIGN_CENTER');

  if wxALIGN_CENTER_HORIZONTAL in SizerAlignment then
    Styles.Add('wxALIGN_CENTER_HORIZONTAL');

  if wxALIGN_CENTER_VERTICAL in SizerAlignment then
    Styles.Add('wxALIGN_CENTER_VERTICAL');

  if wxEXPAND in SizerAlignment then
    Styles.Add('wxEXPAND');

  if Styles.Count = 0 then
    Result := '0'
  else
  begin
    Result := Styles[0];
    for I := 1 to Styles.Count - 1 do
      Result := Result + ' | ' + Styles[I];
  end;

  Styles.Free;
end;

function BorderAlignmentToStr(BorderAlignment: TWxBorderAlignment): string;
begin
  Result := '';
  if (wxALL in BorderAlignment) then
    Result := Result + ' | wxALL';
  if (wxLEFT in BorderAlignment) then
    Result := Result + ' | wxLEFT';
  if (wxRIGHT in BorderAlignment) then
    Result := Result + ' | wxRIGHT';
  if (wxTOP in BorderAlignment) then
    Result := Result + ' | wxTOP';
  if (wxBOTTOM in BorderAlignment) then
    Result := Result + ' | wxBOTTOM';

  if (Length(Result) = 0) then
    Result := '0'
  else
    Result := Copy(Result, 4, Length(Result));
end;

function GetStdStyleString(stdStyle: TWxStdStyleSet): string;
var
  I:      integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxSIMPLE_BORDER in stdStyle then
      strLst.add('wxSIMPLE_BORDER');

    if wxDOUBLE_BORDER in stdStyle then
      strLst.add('wxDOUBLE_BORDER');

    if wxSUNKEN_BORDER in stdStyle then
      strLst.add('wxSUNKEN_BORDER');

    if wxRAISED_BORDER in stdStyle then
      strLst.add('wxRAISED_BORDER');

    if wxSTATIC_BORDER in stdStyle then
      strLst.add('wxSTATIC_BORDER');

    if wxTRANSPARENT_WINDOW in stdStyle then
      strLst.add('wxTRANSPARENT_WINDOW');

    if wxTAB_TRAVERSAL in stdStyle then
      strLst.add('wxTAB_TRAVERSAL');

    if wxWANTS_CHARS in stdStyle then
      strLst.add('wxWANTS_CHARS');

    if wxNO_FULL_REPAINT_ON_RESIZE in stdStyle then
      strLst.add('wxNO_FULL_REPAINT_ON_RESIZE');

    if wxVSCROLL in stdStyle then
      strLst.add('wxVSCROLL');

    if wxHSCROLL in stdStyle then
      strLst.add('wxHSCROLL');

    if wxCLIP_CHILDREN in stdStyle then
      strLst.add('wxCLIP_CHILDREN');

    if wxNO_BORDER in stdStyle then
      strLst.add('wxNO_BORDER');

    if wxALWAYS_SHOW_SB in stdStyle then
      strLst.add('wxALWAYS_SHOW_SB');

    if wxFULL_REPAINT_ON_RESIZE in stdStyle then
      strLst.add('wxFULL_REPAINT_ON_RESIZE');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i]// for
    ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;

function GetButtonSpecificStyle(stdstyle: TWxStdStyleSet;
  dlgstyle: TWxBtnStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetButtonStyleString(dlgstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;


function GetLabelSpecificStyle(stdstyle: TWxStdStyleSet;
  dlgstyle: TWxLbStyleSet): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetLbStyleString(dlgstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;

end;

function GetStdDialogButtonsSpecificStyle(btnstyle: TWxStdDialogButtons): string;
begin
  if wxID_OK in btnstyle then
    Result := Result + ' | wxOK';
  if wxID_YES in btnstyle then
    Result := Result + ' | wxYES';
  if wxID_NO in btnstyle then
    Result := Result + ' | wxNO';
  if wxID_CANCEL in btnstyle then
    Result := Result + ' | wxCANCEL';
  if wxID_HELP in btnstyle then
    Result := Result + ' | wxHELP';

  if Result <> '' then
    Result := Copy(Result, 4, Length(Result))
  else
    Result := '0';
end;

function GetDialogSpecificStyle(stdstyle: TWxStdStyleSet;
  dlgstyle: TWxDlgStyleSet; wxclassname: string): string;
var
  strA: string;
begin
  Result := GetStdStyleString(stdstyle);
  strA   := trim(GetDlgStyleString(dlgstyle, wxclassname));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;
end;

function IsControlWxWindow(ctrl: TControl): boolean;
var
  cntIntf: IWxWindowInterface;
begin
  Result := False;
  if not assigned(ctrl) then
    Exit;
  Result := ctrl.GetInterface(IID_IWxWindowInterface, cntIntf);
end;

function IsControlWxSizer(ctrl: TControl): boolean;
var
  cntIntf: IWxContainerAndSizerInterface;
begin
  Result := False;
  if not assigned(ctrl) then
    Exit;
  Result := ctrl.GetInterface(IID_IWxContainerAndSizerInterface, cntIntf);
end;

function IsControlWxContainer(ctrl: TControl): boolean;
var
  cntIntf: IWxContainerInterface;
begin
  Result := False;
  if not assigned(ctrl) then
    Exit;
  Result := ctrl.GetInterface(IDD_IWxContainerInterface, cntIntf);
end;

function IsControlWxToolBar(ctrl: TControl): boolean;
var
  cntIntf: IWxToolBarInterface;
begin
  Result := False;
  if not assigned(ctrl) then
    Exit;
  Result := ctrl.GetInterface(IID_IWxToolBarInterface, cntIntf);
end;

function IsControlWxStatusBar(ctrl: TControl): boolean;
var
  cntIntf: IWxStatusBarInterface;
begin
  Result := False;
  if not assigned(ctrl) then
    Exit;
  Result := ctrl.GetInterface(IDD_IWxStatusBarInterface, cntIntf);
end;

function IsControlWxNonVisible(ctrl: TControl): boolean;
begin
  Result := ctrl is TWxNonVisibleBaseComponent;
end;

function GetWxIDString(strID: string; intID: longint): string;
begin
  if intID > 0 then
  begin
    if trim(strID) = '' then
      Result := '-1'
    else
      Result := strID;
  end
  else
    Result := '-1';

end;

function GetNonVisualComponentCount(frmMainObj: TForm): integer;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to frmMainObj.ComponentCount - 1 do    // Iterate
    if frmMainObj.Components[i] is TWxNonVisibleBaseComponent then
      Inc(Result);    // for
end;

function AlignmentToStr(taPos: TAlignment): string;
begin
  Result := '';
  case taPos of
    taLeftJustify: Result := 'wxLIST_FORMAT_LEFT';
    taRightJustify: Result := 'wxLIST_FORMAT_RIGHT';
    taCenter: Result := 'wxLIST_FORMAT_CENTER';
  end; // case
end;

procedure ChangeControlZOrder(Sender: TObject; MoveUp: boolean = True);
var
  I, Curr:      integer;
  Control:      TControl;
  List:         TList;
  NotebookPage: TTabSheet;
  Notebook:     TPageControl;
begin
  if GetTypeData(Sender.ClassInfo)^.ClassType.ClassName = 'TWxNoteBookPage' then
  begin
    NotebookPage := Sender as TTabSheet;
    Notebook := NotebookPage.PageControl;
    Curr := -1;

    //Determine the order of the notebook page
    for I := 0 to Pred(Notebook.PageCount) do
      if Notebook.Pages[I] = Sender then
      begin
        Curr := I;
        Break;
      end;

    //Make sure our position is valid
    if Curr < 0 then
      Exit
    else if (Curr = 0) and (MoveUp <> true) then
      Exit
    else if (Curr = Notebook.PageCount - 1) and (MoveUp = true) then
      Exit;

    //Do the move
    if (MoveUp = true) then
      NotebookPage.PageIndex := NotebookPage.PageIndex + 1
    else
      NotebookPage.PageIndex := NotebookPage.PageIndex - 1;

    List := TList.Create;
    try
      if MoveUp then
      begin
        for I := Curr + 1 to Pred(Notebook.PageCount) do
          // load other controls in group
          List.Add(Notebook.Pages[I]);
        NotebookPage.BringToFront;
        for I := 0 to Pred(List.Count) do
          // move other controls to front, too
          TTabSheet(List[I]).BringToFront;
      end
      else begin
        for I := 0 to Curr - 1 do
          // load other controls in group
          List.Add(Notebook.Pages[I]);
        NotebookPage.SendToBack;
        for I := Pred(List.Count) downto 0 do
          // move other controls to back, too
          TTabSheet(List[I]).SendToBack;
      end;
    finally
      List.Free;
    end;
  end
  else if Sender is TControl then
  begin
    // only components of type TControl and descendends
    // work
    Control := Sender as TControl;
    // has no parent, cannot move ;-)
    if Control.Parent = nil then
      // quit
      Exit;
    // determine position in z-order
    Curr := -1;
    for I := 0 to Pred(Control.Parent.ControlCount) do
      if Control.Parent.Controls[I] = Sender then
      begin
        Curr := I;
        Break;
      end;
    if Curr < 0 then
      // position not found, quit
      Exit;
    List := TList.Create;
    try
      if MoveUp then
      begin
        for I := Curr + 2 to Pred(Control.Parent.ControlCount) do
          // load other controls in group
          List.Add(Control.Parent.Controls[I]);
        Control.BringToFront;
        for I := 0 to Pred(List.Count) do
          // move other controls to front, too
          TControl(List[I]).BringToFront;
      end
      else begin
        for I := 0 to Curr - 2 do
          // load other controls in group
          List.Add(Control.Parent.Controls[I]);
        Control.SendToBack;
        for I := Pred(List.Count) downto 0 do
          // move other controls to back, too
          TControl(List[I]).SendToBack;
      end;
    finally
      List.Free;
    end;
  end;
end;

function GetXPMFromTPicture(XPMName: string; delphiBitmap: TBitmap): string;
var
  I:      integer;
  iWidth: integer;
  iHeight: integer;
  xpos, ypos, palindex, cindex, cpp: integer;
  cp:     PChar;
  pixc:   integer;
  outline: array[0..800] of char;
  usechrs: array[0..64] of char;
  rval:   real;
  ccol, tcol: TColor;
  lcol:   ^TColor;
  image:  ^integer;
  cpos:   ^integer;
  pal:    TList;
  found:  boolean;
  strlst: TStringList;
  strLine: string;
label
  Finish1;

  function pow(base: integer; index: integer): integer;
  var
    retval: integer;
    ittr:   integer;
  begin
    retval := 1;
    for ittr := 1 to index do
      retval := retval * base;
    pow := retval;
  end;

begin
  cindex := 0;
  Result := '';
  Result := GetXPMFromTPictureXXX(XPMName, delphiBitmap);
  exit;
  Result := '';
  begin
    //   Form1.Enabled:=False;
    //   Form2.Gauge1.Progress:=0;
    //   Form2.Show;
    StrPCopy(usechrs, ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ&#');
    pal     := TList.Create;                    { Create TList to form our palette }
    //  delphiBitmap.Transparent := True;
    iWidth  := delphiBitmap.Width;
    iHeight := delphiBitmap.Height;
    //  if iWidth > 180 then
    //    iWidth := 180;
    //  if iHeight > 180 then
    //    iHeight := 180;
    GetMem(image, SizeOf(integer) * iWidth * iHeight); { Allocate space for image }
    { Note: Maximum of 65,528 bytes - 2 bytes per pixel }
    cpos := @image^;     { This will be a pointer to current position in image }
    for ypos := 0 to iHeight - 1 do
      for xpos := 0 to iWidth - 1 do
      begin
        ccol  := delphiBitmap.Canvas.Pixels[xpos, ypos];
        found := False;
        for palindex := 0 to pal.Count - 1 do
        begin { Search palette for color }
          tcol := TColor(pal.Items[palindex]^);
          if tcol = ccol then
          begin                             { Found it! }
            found  := True;
            cindex := palindex;        { Remember it's position in palette }
            break;
          end;
        end;
        if not found then
        begin             { Add new color to our palette }
          New(lcol);
          lcol^ := ccol;
          pal.Add(lcol);
          cindex := pal.Count - 1;
        end;
        cpos^ := cindex;                { Store palette index for this pixel }
        Inc(cpos);                                 { Move on to next pixel }
      end//      Form2.Gauge1.Progress:=((ypos+1)*100) div iHeight;
    //      Application.ProcessMessages;
    //      If Form2.Cancelled then goto Finish1;     { We have been cancelled! }
    ;

    //AssignFile(F,SaveDialog1.Filename);
    //Rewrite(F);
    rval := ln(pal.Count) / ln(64);
    cpp  := trunc(rval);
    if (cpp <> rval) then
      Inc(cpp);
    //Writeln(F,'/* XPM */');
    Result := Result + '/* XPM */' + #13;
    StrFmt(outline, 'static char *%s', [XPMName]);
    strLine := outline;
    cp      := StrScan(outline, '.');
    if cp <> nil then
      cp[0] := #0;
    StrCat(outline, '_XPM[]={');
    strLine := outline;
    //Writeln(F,outline);
    Result  := Result + outline + #13;
    Result := Result + '/* ' + XPMName + ' */' + #13;

    StrFmt(outline, '"%d %d %d %d",', [iWidth, iHeight, pal.Count, cpp]);
    strLine := outline;
    //Writeln(F,outline);
    strLine := outline;
    Result  := Result + outline + #13;
    for palindex := 0 to pal.Count - 1 do
    begin
      ccol := TColor(pal.Items[palindex]^);
      ccol := ccol mod (256 * 256 * 256);
      StrFmt(outline, '"      c #%s%s%s",', [IntToHex(ccol mod 256, 2),
        IntToHex((ccol div 256) mod 256, 2), IntToHex(ccol div (256 * 256), 2)]);
      strLine := outline;
      cindex  := palindex;
      for pixc := 1 to cpp do
      begin
        outline[pixc] := usechrs[cindex div pow(64, cpp - pixc)];
        cindex  := cindex mod pow(64, cpp - pixc);
        strLine := outline;
      end;
      strLine := outline;
      //      if AnsiStartsText('"      c #',strLine) then
      //      begin
      //        strLine:='"      c #FFFFFF",';
      //        Result:=Result+strLine+#13;
      //      end
      //      else
      begin
        Result := Result + outline + #13;
      end;
    end;
    cpos := @image^;
    for ypos := 0 to iHeight - 1 do
    begin
      StrPCopy(outline, '"');
      for xpos := 0 to iWidth - 1 do
      begin
        cindex := cpos^;
        for pixc := 1 to cpp do
        begin
          outline[xpos * cpp + pixc] := usechrs[cindex div pow(64, cpp - pixc)];
          cindex := cindex mod pow(64, cpp - pixc);
        end;
        Inc(cpos);
      end;
      //outline[cpp * (xpos + 1) + 1] := #0;  // xpos is undefined after loop
      outline[cpp * (cpos^ + 1) + 1] := #0;
      // i think cpos is the intended variable instead

      if ypos < iHeight - 1 then
        StrCat(outline, '",')
      else
        StrCat(outline, '"};');
      //Writeln(F,outline);
      Result := Result + outline + #13;
    end;
    //Finish2:
    //CloseFile(F);

    Finish1:
      FreeMem(image, SizeOf(integer) * iWidth * iHeight);
    for palindex := 0 to pal.Count - 1 do
      Dispose(pal.Items[palindex]);
    pal.Free;
    //   Form2.Hide;
    //   Form1.Enabled:=True;
    strlst      := TStringList.Create;
    strlst.Text := Result;
    for I := 0 to strlst.Count - 1 do    // Iterate
    begin
      strLine := trim(strlst[i]);
      //sendDebug(IntToStr(i)+' Old # = '+IntToStr(Length(strlst[i])));

      if AnsiEndsText('","",', strLine) then
      begin
        //not tested
        strLine := copy(strLine, 0, length(strLine) - 5);
        if not AnsiEndsText('",', strLine) then
          strlst[i] := strLine + '",';
      end;

      strLine := trim(strlst[i]);

      if AnsiEndsText('"",', strLine) then
      begin
        //tested
        strLine := copy(strLine, 0, length(strLine) - 3);
        if not AnsiEndsText('",', strLine) then
          strlst[i] := strLine + '",';
      end;

      strLine := trim(strlst[i]);
      if AnsiEndsText('",",', strLine) then
      begin
        //tested
        strLine := copy(strLine, 0, length(strLine) - 4);
        if not AnsiEndsText('",', strLine) then
          strlst[i] := strLine + '",';
      end;

      strLine := trim(strlst[i]);

      if AnsiEndsText('",""};', strLine) then
      begin
        strLine := copy(strLine, 0, length(strLine) - 6);
        if not AnsiEndsText('"};', strLine) then
          strlst[i] := strLine + '"};';
      end;

      strLine := trim(strlst[i]);
      if AnsiEndsText('""};', strLine) then
      begin
        //not test
        strLine := copy(strLine, 0, length(strLine) - 4);
        if not AnsiEndsText('"};', strLine) then
          strlst[i] := strLine + '"};';
      end;

      strLine := trim(strlst[i]);
      if AnsiEndsText('","};', strLine) then
      begin
        //not test
        strLine := copy(strLine, 0, length(strLine) - 5);
        if not AnsiEndsText('"};', strLine) then
          strlst[i] := strLine + '"};';
      end;

      //sendDebug(IntToStr(i)+' New # = '+IntToStr(Length(strlst[i])));

    end;    // for

    Result := strlst.Text;

    strlst.Destroy;
  end;
end;

function GetXPMFromTPictureXXX(XPMName: string; delphiBitmap: TBitmap): string;
var
  I:      integer;
  iWidth: integer;
  iHeight: integer;
  xpos, ypos, palindex, cindex, cpp: integer;
  cp:     PChar;
  pixc:   integer;
  outline: array[0..800] of char;
  usechrs: array[0..64] of char;
  rval:   real;
  ccol, tcol: TColor;
  lcol:   ^TColor;
  image:  ^integer;
  cpos:   ^integer;
  pal:    TList;
  found:  boolean;
  strlst: TStringList;
  strLine: string;
label
  Finish1;

  function pow(base: integer; index: integer): integer;
  var
    retval: integer;
    ittr:   integer;
  begin
    retval := 1;
    for ittr := 1 to index do
      retval := retval * base;
    pow := retval;
  end;

begin

  cindex := 0;

  Result := '';
  begin
    //   Form1.Enabled:=False;
    //   Form2.Gauge1.Progress:=0;
    //   Form2.Show;
    StrPCopy(usechrs, ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ&#');
    pal     := TList.Create;                    { Create TList to form our palette }
  //  delphiBitmap.Transparent := True;
    iWidth  := delphiBitmap.Width;
    iHeight := delphiBitmap.Height;
 //   if iWidth > 180 then
 //     iWidth := 180;
 //   if iHeight > 180 then
 //     iHeight := 180;
    GetMem(image, SizeOf(integer) * iWidth * iHeight); { Allocate space for image }
    { Note: Maximum of 65,528 bytes - 2 bytes per pixel }
    cpos := @image^;     { This will be a pointer to current position in image }
    for ypos := 0 to iHeight - 1 do
      for xpos := 0 to iWidth - 1 do
      begin
        ccol  := delphiBitmap.Canvas.Pixels[xpos, ypos];
        found := False;
        for palindex := 0 to pal.Count - 1 do
        begin { Search palette for color }
          tcol := TColor(pal.Items[palindex]^);
          if tcol = ccol then
          begin                             { Found it! }
            found  := True;
            cindex := palindex;        { Remember it's position in palette }
            break;
          end;
        end;
        if not found then
        begin             { Add new color to our palette }
          New(lcol);
          lcol^ := ccol;
          pal.Add(lcol);
          cindex := pal.Count - 1;
        end;
        cpos^ := cindex;                { Store palette index for this pixel }
        Inc(cpos);                                 { Move on to next pixel }
      end//      Form2.Gauge1.Progress:=((ypos+1)*100) div iHeight;
    //      Application.ProcessMessages;
    //      If Form2.Cancelled then goto Finish1;     { We have been cancelled! }
    ;

    //AssignFile(F,SaveDialog1.Filename);
    //Rewrite(F);
    rval := ln(pal.Count) / ln(64);
    cpp  := trunc(rval);
    if (cpp <> rval) then
      Inc(cpp);
    //Writeln(F,'/* XPM */');
    Result := Result + '/* XPM */' + #13;
    StrFmt(outline, 'static char *%s', [XPMName]);
    strLine := outline;
    cp      := StrScan(outline, '.');
    if cp <> nil then
      cp[0] := #0;
    StrCat(outline, '_XPM[]={');
    strLine := outline;
    //Writeln(F,outline);
    Result  := Result + outline + #13;
    Result := Result + '/* ' + XPMName + ' */' + #13;
    StrFmt(outline, '"%d %d %d %d",', [iWidth, iHeight, pal.Count, cpp]);
    strLine := outline;
    //Writeln(F,outline);
    strLine := outline;
    Result  := Result + outline + #13;
    for palindex := 0 to pal.Count - 1 do
    begin
      ccol := TColor(pal.Items[palindex]^);
      ccol := ccol mod (256 * 256 * 256);
      if palindex = 0 then
        StrFmt(outline, '"      c None",', [''])
      else
        StrFmt(outline, '"      c #%s%s%s",', [IntToHex(ccol mod 256, 2),
          IntToHex((ccol div 256) mod 256, 2), IntToHex(ccol div (256 * 256), 2)]);

      strLine := outline;
      cindex  := palindex;
      for pixc := 1 to cpp do
      begin
        outline[pixc] := usechrs[cindex div pow(64, cpp - pixc)];
        cindex  := cindex mod pow(64, cpp - pixc);
        strLine := outline;
      end;
      strLine := outline;
      //      if AnsiStartsText('"      c #',strLine) then
      //      begin
      //        strLine:='"      c #FFFFFF",';
      //        Result:=Result+strLine+#13;
      //      end
      //      else
      begin
        Result := Result + outline + #13;
      end;
    end;
    cpos := @image^;
    for ypos := 0 to iHeight - 1 do
    begin
      StrPCopy(outline, '"');
      for xpos := 0 to iWidth - 1 do
      begin
        cindex := cpos^;
        for pixc := 1 to cpp do
        begin
          outline[xpos * cpp + pixc] := usechrs[cindex div pow(64, cpp - pixc)];
          cindex := cindex mod pow(64, cpp - pixc);
        end;
        Inc(cpos);
      end;
      outline[cpp * (iWidth) + 1] := #0; // xpos is undefined after loop
      //outline[cpp * (xpos + 1) + 1] := #0; // xpos is undefined after loop
      if ypos < iHeight - 1 then
        StrCat(outline, '",')
      else
        StrCat(outline, '"};');
      //Writeln(F,outline);
      Result := Result + outline + #13;
    end;
    //Finish2:
    //CloseFile(F);

    Finish1:
      FreeMem(image, SizeOf(integer) * iWidth * iHeight);
    for palindex := 0 to pal.Count - 1 do
      Dispose(pal.Items[palindex]);
    pal.Free;
    //   Form2.Hide;
    //   Form1.Enabled:=True;
    strlst      := TStringList.Create;
    strlst.Text := Result;
    for I := 0 to strlst.Count - 1 do    // Iterate
    begin
      strLine := trim(strlst[i]);
      //sendDebug(IntToStr(i)+' Old # = '+IntToStr(Length(strlst[i])));

      if AnsiEndsText('","",', strLine) then
      begin
        //not tested
        strLine := copy(strLine, 0, length(strLine) - 5);
        if not AnsiEndsText('",', strLine) then
          strlst[i] := strLine + '",';
      end;

      strLine := trim(strlst[i]);

      if AnsiEndsText('"",', strLine) then
      begin
        //tested
        strLine := copy(strLine, 0, length(strLine) - 3);
        if not AnsiEndsText('",', strLine) then
          strlst[i] := strLine + '",';
      end;

      strLine := trim(strlst[i]);
      if AnsiEndsText('",",', strLine) then
      begin
        //tested
        strLine := copy(strLine, 0, length(strLine) - 4);
        if not AnsiEndsText('",', strLine) then
          strlst[i] := strLine + '",';
      end;

      strLine := trim(strlst[i]);

      if AnsiEndsText('",""};', strLine) then
      begin
        strLine := copy(strLine, 0, length(strLine) - 6);
        if not AnsiEndsText('"};', strLine) then
          strlst[i] := strLine + '"};';
      end;

      strLine := trim(strlst[i]);
      if AnsiEndsText('""};', strLine) then
      begin
        //not test
        strLine := copy(strLine, 0, length(strLine) - 4);
        if not AnsiEndsText('"};', strLine) then
          strlst[i] := strLine + '"};';
      end;

      strLine := trim(strlst[i]);
      if AnsiEndsText('","};', strLine) then
      begin
        //not test
        strLine := copy(strLine, 0, length(strLine) - 5);
        if not AnsiEndsText('"};', strLine) then
          strlst[i] := strLine + '"};';
      end;

      //sendDebug(IntToStr(i)+' New # = '+IntToStr(Length(strlst[i])));

    end;    // for

    Result := strlst.Text;

    strlst.Destroy;
  end;
end;

function GetRawXPMFromTPicture(XPMName: string; delphiBitmap: TBitmap): string;
var
  iWidth:  integer;
  iHeight: integer;
  xpos, ypos, palindex, cindex, cpp: integer;
  cp:      PChar;
  pixc:    integer;
  outline: array[0..800] of char;
  usechrs: array[0..64] of char;
  rval:    real;
  ccol, tcol: TColor;
  lcol:    ^TColor;
  image:   ^integer;
  cpos:    ^integer;
  pal:     TList;
  found:   boolean;
  strLine: string;
label
  Finish1;

  function pow(base: integer; index: integer): integer;
  var
    retval: integer;
    ittr:   integer;
  begin
    retval := 1;
    for ittr := 1 to index do
      retval := retval * base;
    pow := retval;
  end;

begin

  cindex := 0;

  Result := '';
  begin
    //   Form1.Enabled:=False;
    //   Form2.Gauge1.Progress:=0;
    //   Form2.Show;
    StrPCopy(usechrs, ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ&#');
    pal     := TList.Create;                    { Create TList to form our palette }
    iWidth  := delphiBitmap.Width;
    iHeight := delphiBitmap.Height;
  //  if iWidth > 180 then
  //    iWidth := 180;
  //  if iHeight > 180 then
  //    iHeight := 180;
    GetMem(image, SizeOf(integer) * iWidth * iHeight); { Allocate space for image }
    { Note: Maximum of 65,528 bytes - 2 bytes per pixel }
    cpos := @image^;     { This will be a pointer to current position in image }
    for ypos := 0 to iHeight - 1 do
      for xpos := 0 to iWidth - 1 do
      begin
        ccol  := delphiBitmap.Canvas.Pixels[xpos, ypos];
        found := False;
        for palindex := 0 to pal.Count - 1 do
        begin { Search palette for color }
          tcol := TColor(pal.Items[palindex]^);
          if tcol = ccol then
          begin                             { Found it! }
            found  := True;
            cindex := palindex;        { Remember it's position in palette }
            break;
          end;
        end;
        if not found then
        begin             { Add new color to our palette }
          New(lcol);
          lcol^ := ccol;
          pal.Add(lcol);
          cindex := pal.Count - 1;
        end;
        cpos^ := cindex;                { Store palette index for this pixel }
        Inc(cpos);                                 { Move on to next pixel }
      end//      Form2.Gauge1.Progress:=((ypos+1)*100) div iHeight;
    //      Application.ProcessMessages;
    //      If Form2.Cancelled then goto Finish1;     { We have been cancelled! }
    ;

    //AssignFile(F,SaveDialog1.Filename);
    //Rewrite(F);
    rval := ln(pal.Count) / ln(64);
    cpp  := trunc(rval);
    if (cpp <> rval) then
      Inc(cpp);
    //Writeln(F,'/* XPM */');
    Result := Result + '/* XPM */' + #13;
    StrFmt(outline, 'static char *%s', [XPMName]);
    strLine := outline;
    cp      := StrScan(outline, '.');
    if cp <> nil then
      cp[0] := #0;
    StrCat(outline, '_XPM[]={');
    strLine := outline;
    //Writeln(F,outline);
    Result  := Result + outline + #13;
    Result := Result + '/* ' + XPMName + ' */' + #13;
    StrFmt(outline, '"%d %d %d %d",', [iWidth, iHeight, pal.Count, cpp]);
    strLine := outline;
    //Writeln(F,outline);
    strLine := outline;
    Result  := Result + outline + #13;
    for palindex := 0 to pal.Count - 1 do
    begin
      ccol := TColor(pal.Items[palindex]^);
      ccol := ccol mod (256 * 256 * 256);
      StrFmt(outline, '"      c #%s%s%s",', [IntToHex(ccol mod 256, 2),
        IntToHex((ccol div 256) mod 256, 2), IntToHex(ccol div (256 * 256), 2)]);
      strLine := outline;
      cindex  := palindex;
      for pixc := 1 to cpp do
      begin
        outline[pixc] := usechrs[cindex div pow(64, cpp - pixc)];
        cindex  := cindex mod pow(64, cpp - pixc);
        strLine := outline;
      end;
      strLine := outline;
      Result  := Result + outline + #13;
    end;
    cpos := @image^;
    for ypos := 0 to iHeight - 1 do
    begin
      StrPCopy(outline, '"');
      for xpos := 0 to iWidth - 1 do
      begin
        cindex := cpos^;
        for pixc := 1 to cpp do
        begin
          outline[xpos * cpp + pixc] := usechrs[cindex div pow(64, cpp - pixc)];
          cindex := cindex mod pow(64, cpp - pixc);
        end;
        Inc(cpos);
      end;

      //outline[cpp * (xpos + 1) + 1] := #0; // xpos is undefined after loop
      outline[cpp * (cpos^ + 1) + 1] := #0;
      // i think cpos is the intended variable instead
      if ypos < iHeight - 1 then
        StrCat(outline, '",')
      else
        StrCat(outline, '"};');
      //Writeln(F,outline);
      Result := Result + outline + #13;
    end;
    //Finish2:
    //CloseFile(F);

    Finish1:
      FreeMem(image, SizeOf(integer) * iWidth * iHeight);
    for palindex := 0 to pal.Count - 1 do
      Dispose(pal.Items[palindex]);
    pal.Free;
  end;
end;

function GenerateXPMDirectly(bmp: TBitmap; strCompName: string; strParentName:string;strFileName: string): boolean;
var
  xpmFileDir,xpmNewFileDir:    string;
  fileStrlst:    TStringList;
  strXPMContent: string;

begin
  Result := False;
  if bmp = nil then
    Exit;

  xpmFileDir := IncludetrailingPathDelimiter(ExtractFileDir(strFileName));
  xpmNewFileDir:=IncludeTrailingPathDelimiter(xpmFileDir)+'Images';
  if DirectoryExists(xpmNewFileDir) = false then
  begin
   if ForceDirectories(xpmNewFileDir) = true then
     xpmFileDir:=xpmNewFileDir;
  end
  else
    xpmFileDir:=xpmNewFileDir;

  xpmFileDir := IncludetrailingPathDelimiter(xpmFileDir);

  if bmp.handle <> 0 then
  begin
    fileStrlst := TStringList.Create;
    try
      strXPMContent := GetXPMFromTPicture(strParentName+'_'+strCompName, bmp);
      if trim(strXPMContent) <> '' then
      begin
        fileStrlst.Add(strXPMContent);
        fileStrlst.SaveToFile(xpmFileDir + strParentName+'_'+strCompName + '_XPM.xpm');
      end;
    except
    end;
    fileStrlst.Destroy;
  end;
  Result := True;
end;

function GetCommentString(str: string): string;
begin
  if (trim(str) <> '') then
    Result := '/* ' + str + ' */' + #13
  else
    Result := ' ';

end;

function GetCppString(str: string): string;
begin

  // If the first character in the text is a &, then
  //    the user wants this to be a literal variable name
  // Otherwise, the user wants this to be a text value
  if (AnsiPos('&&', str) = 1) then
  begin
    Delete(str, 1, 2);
    Result := str;
  end
  else
  begin
    strSearchReplace(str, '\', '\\', [srAll]);
    strSearchReplace(str, '"', '\\"', [srAll]);
    strSearchReplace(str, #10, '\\n', [srAll]);
    strSearchReplace(str, #13, '\\r', [srAll]);

    //Replace our escape codes back
    strSearchReplace(str, '\\n', '\n', [srAll]);
    strSearchReplace(str, '\\b', '\b', [srAll]);
    strSearchReplace(str, '\\f', '\f', [srAll]);
    strSearchReplace(str, '\\n', '\n', [srAll]);
    strSearchReplace(str, '\\r', '\r', [srAll]);
    strSearchReplace(str, '\\t', '\t', [srAll]);
    strSearchReplace(str, '\\"', '\"', [srAll]);
    strSearchReplace(str, '\\''', '\''', [srAll]);
    strSearchReplace(str, '\\v', '\v', [srAll]);
    strSearchReplace(str, '\\a', '\a', [srAll]);
    strSearchReplace(str, '\\?', '\?', [srAll]);
    Result := StringFormat + '("' + str + '")';
  end
end;

function OpenXPMImage(InpImage: TBitmap; strFname: string): boolean;
type
  TPalRec = record
    chrs: PChar;
    color: TColor;
  end;

  function HexVal(chr: char): integer;
  begin
    if (chr >= 'a') and (chr <= 'f') then
      HexVal := Ord(chr) - Ord('a') + 10
    else
      HexVal := Ord(chr) - Ord('0');
  end;

var
  iWidth: integer;
  iHeight: integer;
  cpp, colors, col, ypos, xpos, hexc, infield: integer;
  fieldstr: array[0..256] of char;
  fieldval: integer;
  rgb1, rgb2, rgb3: integer;
  inpline: array[0..800] of char;
  capline: array[0..256] of char;
  pal: TList;
  palitem: ^TPalRec;
  cp1, cp2: PChar;
  F: TextFile;
  ColorDialog1: TColorDialog;
label
  Finish1;
begin
  Result  := True;
  iHeight := 0;
  iWidth  := 0;
  colors  := 0;
  cpp     := 0;
  palitem := nil;

  begin
    AssignFile(F, strFname);
    Reset(F);
    inpline[0] := #0;
    while inpline[0] <> '"' do
      Readln(F, inpline);

    infield := 0;
    fieldstr[0] := #0;
    cp1 := inpline + 1;
    while cp1 <= StrScan(inpline + 1, '"') do
    begin
      if (cp1[0] = ' ') or (cp1[0] = '"') then
      begin
        if fieldstr[0] <> #0 then
        begin
          Inc(infield);
          fieldval    := StrToInt(StrPas(fieldstr));
          fieldstr[0] := #0;
          if infield = 1 then
            iWidth := fieldval;
          if infield = 2 then
            iHeight := fieldval;
          if infield = 3 then
            colors := fieldval;
          if infield = 4 then
            cpp := fieldval;
        end;
      end
      else begin
        fieldstr[StrLen(fieldstr) + 1] := #0;
        fieldstr[StrLen(fieldstr)]     := cp1[0];
      end;
      Inc(cp1);
    end;

    pal := TList.Create;
    for col := 0 to colors - 1 do
    begin
      inpline[0] := #0;
      while inpline[0] <> '"' do
        Readln(F, inpline);
      inpline[cpp + 1] := #0;
      New(palitem);
      palitem^.chrs := StrAlloc(cpp + 1);
      StrCopy(palitem^.chrs, inpline + 1);
      cp1 := StrScan(inpline + cpp + 2, 'c') + 1;
      cp1 := SysUtils.StrLower(cp1);
      if StrScan(cp1, '#') = nil then
      begin
        StrCopy(capline, 'What color does "');
        StrCat(capline, cp1);
        StrCat(capline, ' represent?');
        Application.MessageBox(capline, 'Select Color', mb_OK);
        ColorDialog1 := TColorDialog.Create(nil);
        ColorDialog1.Execute;
        palitem^.color := ColorDialog1.Color;
      end
      else begin
        cp1    := StrScan(cp1, '#') + 1;
        cp2    := StrScan(cp1, '"');
        cp2[0] := #0;
        hexc   := StrLen(cp1) div 3;
        rgb1   := HexVal(cp1[0]) * 16 + HexVal(cp1[1]);
        rgb2   := HexVal(cp1[hexc]) * 16 + HexVal(cp1[hexc + 1]);
        rgb3   := HexVal(cp1[2 * hexc]) * 16 + HexVal(cp1[2 * hexc + 1]);
        palitem^.color := longint(rgb1) + 256 * longint(rgb2) + 256 *
          256 * longint(rgb3);
      end;
      pal.Add(palitem);
    end;

    InpImage.Height := iHeight;
    InpImage.Width := iWidth;
    cp1 := StrAlloc(cpp + 1);
    for ypos := 0 to iHeight - 1 do
    begin
      inpline[0] := #0;
      while inpline[0] <> '"' do
        Readln(F, inpline);
      for xpos := 0 to iWidth - 1 do
      begin
        StrLCopy(cp1, inpline + xpos * cpp + 1, cpp);
        for col := 0 to colors - 1 do
        begin
          palitem := pal.Items[col];
          if SysUtils.StrComp(palitem^.chrs, cp1) = 0 then
            break;
        end;
        InpImage.Canvas.Pixels[xpos, ypos] := palitem^.color;
      end;
      //Form2.Gauge1.Progress:=((ypos+1)*100) div iHeight;
      Application.ProcessMessages;
    end;

    Finish1:
      StrDispose(cp1);

    for col := 0 to colors - 1 do
    begin
      palitem := pal.Items[col];
      StrDispose(palitem^.chrs);
      Dispose(palitem);
    end;
    pal.Free;

    CloseFile(F);
  end;

end;

function IcoToBmp(Icon: TIcon): TBitmap;
begin
  Result := TBitmap.Create;
  Result.Width := Icon.Width;
  Result.Height := Icon.Height;
  Result.Canvas.Draw(0, 0, Icon);
end;

function GetwxColorFromString(strValue: string): string;
var
  strColorValue, strChoice: string;
begin
  Result    := '';
  strColorValue := trim(strValue);
  strColorValue := copy(strColorValue, 5, length(strColorValue));
  strChoice := copy(trim(strValue), 0, 4);

  if AnsiSameText(strChoice, 'CUS:') then
  begin
    Result := 'wxColour(' + strColorValue + ')';
    exit;
  end;

  if AnsiSameText(strChoice, 'DEF:') then
  begin
    Result := '';
    exit;
  end;


  if AnsiSameText(strColorValue, 'wxBLACK') then
  begin
    Result := 'wxColour(*wxBLACK)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxWHITE') then
  begin
    Result := 'wxColour(*wxWHITE)';
    exit;
  end;

  if AnsiSameText(strColorValue, 'wxRED') then
  begin
    Result := '*wxRED';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxBLUE') then
  begin
    Result := '*wxBLUE';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxGREEN') then
  begin
    Result := '*wxGREEN';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxCYAN') then
  begin
    Result := '*wxCYAN';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxLIGHT_GREY') then
  begin
    Result := '*wxLIGHT_GREY';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_SCROLLBAR') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_SCROLLBAR)';
    exit;
  end;

  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_BACKGROUND') then
  begin
    Result := 'wxSystemSettings::GetColour()';
    exit;
  end;

  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_ACTIVECAPTION') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_ACTIVECAPTION)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVECAPTION') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INACTIVECAPTION)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_MENU') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_MENU)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOW') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_WINDOW)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOWFRAME') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_WINDOWFRAME)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_MENUTEXT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_MENUTEXT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOWTEXT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_WINDOWTEXT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_CAPTIONTEXT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_CAPTIONTEXT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_ACTIVEBORDER') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_ACTIVEBORDER)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVEBORDER') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INACTIVEBORDER)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_APPWORKSPACE') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_APPWORKSPACE)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_HIGHLIGHT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_HIGHLIGHT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_HIGHLIGHTTEXT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_HIGHLIGHTTEXT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNFACE') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNFACE)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNSHADOW') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNSHADOW)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_GRAYTEXT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_GRAYTEXT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNTEXT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNTEXT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVECAPTIONTEXT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INACTIVECAPTIONTEXT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNHIGHLIGHT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNHIGHLIGHT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DDKSHADOW') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DDKSHADOW)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DLIGHT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DLIGHT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_INFOTEXT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INFOTEXT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_INFOBK') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INFOBK)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_DESKTOP') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_DESKTOP)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DFACE') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DFACE)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DSHADOW') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DSHADOW)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DHIGHLIGHT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DHIGHLIGHT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DHILIGHT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DHILIGHT)';
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNHILIGHT') then
  begin
    Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNHILIGHT)';
    exit;
  end;

end;

function PaperIDToString(sizeitem: TWxPaperSizeItem): string;
begin
  Result := 'wxPAPER_NONE';

  if sizeitem = wxPAPER_NONE then
  begin
    Result := 'wxPAPER_NONE';
    Exit;
  end;


  if sizeitem = wxPAPER_LETTER then
  begin
    Result := 'wxPAPER_LETTER';
    Exit;
  end;
  if sizeitem = wxPAPER_LEGAL then
  begin
    Result := 'wxPAPER_LEGAL';
    Exit;
  end;
  if sizeitem = wxPAPER_A4 then
  begin
    Result := 'wxPAPER_A4';
    Exit;
  end;
  if sizeitem = wxPAPER_CSHEET then
  begin
    Result := 'wxPAPER_CSHEET';
    Exit;
  end;
  if sizeitem = wxPAPER_DSHEET then
  begin
    Result := 'wxPAPER_DSHEET';
    Exit;
  end;
  if sizeitem = wxPAPER_ESHEET then
  begin
    Result := 'wxPAPER_ESHEET';
    Exit;
  end;
  if sizeitem = wxPAPER_LETTERSMALL then
  begin
    Result := 'wxPAPER_LETTERSMALL';
    Exit;
  end;

  if sizeitem = wxPAPER_TABLOID then
  begin
    Result := 'wxPAPER_TABLOID';
    Exit;
  end;
  if sizeitem = wxPAPER_LEDGER then
  begin
    Result := 'wxPAPER_LEDGER';
    Exit;
  end;
  if sizeitem = wxPAPER_STATEMENT then
  begin
    Result := 'wxPAPER_STATEMENT';
    Exit;
  end;
  if sizeitem = wxPAPER_EXECUTIVE then
  begin
    Result := 'wxPAPER_EXECUTIVE';
    Exit;
  end;
  if sizeitem = wxPAPER_NOTE then
  begin
    Result := 'wxPAPER_NOTE';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_9 then
  begin
    Result := 'wxPAPER_ENV_9';
    Exit;
  end;
  if sizeitem = wxPAPER_A3 then
  begin
    Result := 'wxPAPER_A3';
    Exit;
  end;
  if sizeitem = wxPAPER_A4SMALL then
  begin
    Result := 'wxPAPER_A4SMALL';
    Exit;
  end;
  if sizeitem = wxPAPER_A5 then
  begin
    Result := 'wxPAPER_A5';
    Exit;
  end;
  if sizeitem = wxPAPER_B4 then
  begin
    Result := 'wxPAPER_B4';
    Exit;
  end;

  if sizeitem = wxPAPER_B5 then
  begin
    Result := 'wxPAPER_B5';
    Exit;
  end;
  if sizeitem = wxPAPER_FOLIO then
  begin
    Result := 'wxPAPER_FOLIO';
    Exit;
  end;
  if sizeitem = wxPAPER_QUARTO then
  begin
    Result := 'wxPAPER_QUARTO';
    Exit;
  end;
  if sizeitem = wxPAPER_10X14 then
  begin
    Result := 'wxPAPER_10X14';
    Exit;
  end;

  if sizeitem = wxPAPER_11X17 then
  begin
    Result := 'wxPAPER_11X17';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_10 then
  begin
    Result := 'wxPAPER_ENV_10';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_11 then
  begin
    Result := 'wxPAPER_ENV_11';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_12 then
  begin
    Result := 'wxPAPER_ENV_12';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_14 then
  begin
    Result := 'wxPAPER_ENV_14';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_DL then
  begin
    Result := 'wxPAPER_ENV_DL';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_C5 then
  begin
    Result := 'wxPAPER_ENV_C5';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_C3 then
  begin
    Result := 'wxPAPER_ENV_C3';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_C4 then
  begin
    Result := 'wxPAPER_ENV_C4';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_C6 then
  begin
    Result := 'wxPAPER_ENV_C6';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_C65 then
  begin
    Result := 'wxPAPER_ENV_C65';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_B4 then
  begin
    Result := 'wxPAPER_ENV_B4';
    Exit;
  end;

  if sizeitem = wxPAPER_ENV_B5 then
  begin
    Result := 'wxPAPER_ENV_B5';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_B6 then
  begin
    Result := 'wxPAPER_ENV_B6';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_ITALY then
  begin
    Result := 'wxPAPER_ENV_ITALY';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_MONARCH then
  begin
    Result := 'wxPAPER_ENV_MONARCH';
    Exit;
  end;
  if sizeitem = wxPAPER_ENV_PERSONAL then
  begin
    Result := 'wxPAPER_ENV_PERSONAL';
    Exit;
  end;
  if sizeitem = wxPAPER_FANFOLD_US then
  begin
    Result := 'wxPAPER_FANFOLD_US';
    Exit;
  end;
  if sizeitem = wxPAPER_FANFOLD_STD_GERMAN then
  begin
    Result := 'wxPAPER_FANFOLD_STD_GERMAN';
    Exit;
  end;
  if sizeitem = wxPAPER_FANFOLD_LGL_GERMAN then
  begin
    Result := 'wxPAPER_FANFOLD_LGL_GERMAN';
    Exit;
  end;

end;
//-------------------------------------------------------------------------------
function IsDefaultColorStr(strvalue: string): boolean;
begin
  strvalue := trim(strvalue);
  if strvalue = '' then
  begin
    Result := True;
    exit;
  end;

  if UpperCase(copy(strvalue, 0, 4)) = 'DEF:' then
    Result := True
  else
    Result := False
end;

function GetGeneralColorFromString(strColorValue: string): TColor;
begin
  strColorValue := trim(strColorValue);
  Result := 0 + clBlack;
  if AnsiSameText(strColorValue, 'wxBLACK') then
  begin
    Result := clBlack;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxWHITE') then
  begin
    Result := clWhite;
    exit;
  end;

  if AnsiSameText(strColorValue, 'wxRED') then
  begin
    Result := clred;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxBLUE') then
  begin
    Result := clBlue;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxGREEN') then
  begin
    Result := clGreen;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxCYAN') then
  begin
    Result := clAqua;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxLIGHT_GREY') then
  begin
    Result := clLtGray;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_SCROLLBAR') then
  begin
    Result := clScrollBar;
    exit;
  end;

  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_BACKGROUND') then
  begin
    Result := clBackground;
    exit;
  end;

  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_ACTIVECAPTION') then
  begin
    Result := clActiveCaption;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVECAPTION') then
  begin
    Result := clInactiveCaption;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_MENU') then
  begin
    Result := clMenu;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOW') then
  begin
    Result := clWindow;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOWFRAME') then
  begin
    Result := clWindowFrame;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_MENUTEXT') then
  begin
    Result := clMenuText;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOWTEXT') then
  begin
    Result := clWindowText;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_CAPTIONTEXT') then
  begin
    Result := clCaptionText;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_ACTIVEBORDER') then
  begin
    Result := clActiveBorder;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVEBORDER') then
  begin
    Result := clInactiveBorder;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_APPWORKSPACE') then
  begin
    Result := clAppWorkSpace;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_HIGHLIGHT') then
  begin
    Result := clHighlight;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_HIGHLIGHTTEXT') then
  begin
    Result := clHighlightText;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNFACE') then
  begin
    Result := clBtnFace;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNSHADOW') then
  begin
    Result := clBtnShadow;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_GRAYTEXT') then
  begin
    Result := clGrayText;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNTEXT') then
  begin
    Result := clBtnText;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVECAPTIONTEXT') then
  begin
    Result := clInactiveCaptionText;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNHIGHLIGHT') then
  begin
    Result := clBtnHighlight;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DDKSHADOW') then
  begin
    Result := cl3DDkShadow;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DLIGHT') then
  begin
    Result := cl3DLight;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_INFOTEXT') then
  begin
    Result := clInfoText;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_INFOBK') then
  begin
    Result := clInfoBk;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_DESKTOP') then
  begin
    Result := clBackground;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DFACE') then
  begin
    Result := clBtnFace;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DSHADOW') then
  begin
    Result := clBtnShadow;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DHIGHLIGHT') then
  begin
    Result := clBtnHighlight;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DHILIGHT') then
  begin
    Result := clBtnHighlight;
    exit;
  end;
  if AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNHILIGHT') then
  begin
    Result := clBtnHighlight;
    exit;
  end;
end;

//=== {TJvInspectorValidatorItem } ===========================================
constructor TJvInspectorValidatorItem.Create(const AParent: TJvCustomInspectorItem;
  const AData: TJvCustomInspectorData);
begin
  inherited Create(AParent, AData);
end;

procedure TJvInspectorValidatorItem.SetFlags(const Value:
TInspectorItemFlags); var
 NewValue: TInspectorItemFlags;
begin
 NewValue := Value + [iifEditButton];
 inherited SetFlags(NewValue);
end;

procedure TJvInspectorValidatorItem.ContentsChanged(Sender: TObject);
var
  Obj: TStrings;
begin
  Obj      := TStrings(Data.AsOrdinal);
  Obj.Text := TMemo(Sender).Lines.Text;
end;

function TJvInspectorValidatorItem.GetDisplayValue: string; begin
  Result := 'Edit Validator';
end;

procedure TJvInspectorValidatorItem.SetDisplayValue;
begin

end;


class procedure TJvInspectorValidatorItem.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
    if IndexOf(Self) = -1 then
      Add(TJvInspectorTypeInfoRegItem.Create(Self,
TypeInfo(TWxValidatorString))); end;

procedure TJvInspectorValidatorItem.Edit;
var
  ValidatorForm: TwxValidator;
  wxValidatorstring : TWxValidatorString;
    compIntf: IWxValidatorInterface;
begin

wxValidatorString := TWxValidatorString(Data.AsOrdinal);

  ValidatorForm := TwxValidator.Create(GetParentForm(Inspector));
  try


 ValidatorForm.SetValidatorString(wxValidatorString.strValidatorValue);

    if ValidatorForm.ShowModal <> mrOk then
      exit;

    wxValidatorString.FstrValidatorValue :=
 ValidatorForm.GetValidatorString;

    if (TJvInspectorPropData(Self.GetData()).Instance).GetInterface(
      IID_IWxValidatorInterface, compIntf) then
    begin
      if AnsiSameText(Data.Name, 'Wx_ProxyValidatorString') then
        compIntf.SetValidator(wxValidatorString.FstrValidatorValue);
    end;

    if assigned(TJvInspector(GetInspector).OnDataValueChanged) then
      TJvInspector(GetInspector).OnDataValueChanged(nil, Data);

  finally
    ValidatorForm.Destroy;
  end;

end;
//=== { TJvInspectorTStringsItem } ===========================================

constructor TWxJvInspectorTStringsItem.Create(const AParent: TJvCustomInspectorItem;
  const AData: TJvCustomInspectorData);
begin
  inherited Create(AParent, AData);
  RowSizing.MinHeight := irsItemHeight;
  Flags := Flags + [iifEditButton];
end;

procedure TWxJvInspectorTStringsItem.ContentsChanged(Sender: TObject);
var
  Obj: TStrings;
begin
  Obj      := TStrings(Data.AsOrdinal);
  Obj.Text := TMemo(Sender).Lines.Text;
end;

function TWxJvInspectorTStringsItem.GetDisplayValue: string;
begin
  Result := 'Edit Strings';
end;

procedure TWxJvInspectorTStringsItem.Edit;
var
  SL: TStrings;
  Form: TStringsForm;
begin
  //Create the form
  Form := TStringsForm.Create(GetParentForm(Inspector));

  try
    //Load the strings
    SL := TStrings(Data.AsOrdinal);
    Form.Memo.Lines.Assign(SL);
    if AutoUpdate then
      Form.OnContentsChanged := ContentsChanged;

    //Show the form
    if Form.ShowModal = mrOk then
    begin
      SL.Assign(Form.Memo.Lines);
      if assigned(TJvInspector(GetInspector).OnDataValueChanged) then
        TJvInspector(GetInspector).OnDataValueChanged(nil, Data);
    end;
  finally
    Form.Destroy;
  end;
end;

procedure TWxJvInspectorTStringsItem.SetDisplayValue(const Value: string);
var
  Obj: TObject;
begin
  if Multiline then
  begin
    Obj := TObject(Data.AsOrdinal);
    TStrings(Obj).Text := Value;
  end;
end;

procedure TWxJvInspectorTStringsItem.SetFlags(const Value: TInspectorItemFlags);
var
  OldMask: TInspectorItemFlags;
  NewMask: TInspectorItemFlags;
begin
  { The item has either an edit button or is multiline. If one of them is set,
    the other one will be removed }
  OldMask := Flags * [iifEditButton, iifMultiLine];
  NewMask := Value * [iifEditButton, iifMultiLine];
  if OldMask <> NewMask then
  begin
    if Multiline and not (iifEditButton in OldMask) and (iifEditButton in NewMask) then
      inherited SetFlags(Value - [iifMultiLine]) // iifEditButton has changed
    else if not Multiline and (iifEditButton in OldMask) and
      (iifMultiLine in NewMask) then
      inherited SetFlags(Value - [iifEditButton]) // iifMultiLine has changed
    else
      inherited SetFlags(Value); // Neither flag has changed. Should never occur.
  end
  else // Flags have not changed
    inherited SetFlags(Value);
  if RowSizing <> nil then
  begin
    RowSizing.Sizable := Multiline; // Update sizable state
    if not Multiline then
      RowSizing.SizingFactor := irsNoReSize
    else
      RowSizing.SizingFactor := irsValueHeight;
  end;
end;

class procedure TWxJvInspectorTStringsItem.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
    if IndexOf(Self) = -1 then
      Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TStrings)));
end;


{-------------------------------------------------------}
procedure TJvInspectorColorEditItem.Edit;
var
  ColorEditForm: TColorEdit;
  strColorValue: string;
  compIntf:      IWxComponentInterface;
begin
  ColorEditForm := TColorEdit.Create(GetParentForm(Inspector));
  try
    if (TJvInspectorPropData(Self.GetData()).Instance).GetInterface(
      IID_IWxComponentInterface, compIntf) then
    begin

      if AnsiSameText(Data.Name, 'Wx_ProxyBGColorString') then
        strColorValue := compIntf.GetBGColor
      else if AnsiSameText(Data.Name, 'Wx_ProxyFGColorString') then
        strColorValue := compIntf.GetFGColor
        else
          strColorValue := compIntf.GetGenericColor(Data.Name);
    end;

    ColorEditForm.SetColorString(strColorValue);

    if ColorEditForm.ShowModal <> mrOk then
      exit;

    strColorValue := ColorEditForm.GetColorString;

    if (TJvInspectorPropData(Self.GetData()).Instance).GetInterface(
      IID_IWxComponentInterface, compIntf) then
    begin
      if AnsiSameText(Data.Name, 'Wx_ProxyBGColorString') then
        compIntf.SetBGColor(strColorValue)
      else
        if AnsiSameText(Data.Name, 'Wx_ProxyFGColorString') then
          compIntf.SetFGColor(strColorValue)
        else
          compIntf.SetGenericColor(Data.Name,strColorValue);
    end;

    if assigned(TJvInspector(GetInspector).OnDataValueChanged) then
      TJvInspector(GetInspector).OnDataValueChanged(nil, Data);

  finally
    ColorEditForm.Destroy;
  end;

end;

function TJvInspectorColorEditItem.GetDisplayValue: string;
begin
  Result := 'Edit Color';
end;

procedure TJvInspectorColorEditItem.SetDisplayValue(const Value: string);
begin

end;

procedure TJvInspectorColorEditItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewValue: TInspectorItemFlags;
begin
  NewValue := Value + [iifEditButton];
  inherited SetFlags(NewValue);
end;

class procedure TJvInspectorColorEditItem.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
    if IndexOf(Self) = -1 then
      Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TWxColorString)));
end;

class procedure TJvInspectorFileNameEditItem.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
    if IndexOf(Self) = -1 then
      Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TWxFileNameString)));
end;
//-------------------------------------------------------------------------------


//-------------------------------------------------------------------------------

procedure TJvInspectorListItemsItem.Edit;
begin

end;

function TJvInspectorListItemsItem.GetDisplayValue: string;
begin
  Result := 'Edit Items';
end;

procedure TJvInspectorListItemsItem.SetDisplayValue(const Value: string);
begin

end;

procedure TJvInspectorListItemsItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewValue: TInspectorItemFlags;
begin
  NewValue := Value + [iifEditButton];
  inherited SetFlags(NewValue);
end;

class procedure TJvInspectorListItemsItem.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
    if IndexOf(Self) = -1 then
      Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TListItems)));
end;
//-------------------------------------------------------------------------------


procedure TJvInspectorStatusBarItem.Edit;
var
  sbForm: TStatusBarForm;
  i:      integer;
  stPnl:  TStatusPanel;
begin

  sbForm := TStatusBarForm.Create(GetParentForm(Inspector));
  try
    sbForm.StatusBarObj.Panels.Clear;
    for i := 0 to
      TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).Panels.Count - 1 do
    begin
      stPnl      := sbForm.StatusBarObj.Panels.Add;
      stPnl.Text := TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).Panels[i].Text;
      stPnl.Width := TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).Panels[i].Width;
    end;
    sbForm.fillListInfo;

    if sbForm.ShowModal <> mrOk then
      Exit
    else begin
      TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).panels.Clear;
      for i := 0 to sbForm.StatusBarObj.Panels.Count - 1 do
      begin
        stPnl      :=
          TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).Panels.Add;
        stPnl.Text := sbForm.StatusBarObj.Panels[i].Text;
        stPnl.Width := sbForm.StatusBarObj.Panels[i].Width;
      end;
    end;

    if assigned(TJvInspector(GetInspector).OnDataValueChanged) then
      TJvInspector(GetInspector).OnDataValueChanged(nil, Data);

  finally
    sbForm.Destroy;
  end;

end;

function TJvInspectorStatusBarItem.GetDisplayValue: string;
begin
  Result := 'Edit Fields';
end;

procedure TJvInspectorStatusBarItem.SetDisplayValue(const Value: string);
begin

end;

procedure TJvInspectorStatusBarItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewValue: TInspectorItemFlags;
begin
  NewValue := Value + [iifEditButton];
  inherited SetFlags(NewValue);
end;

class procedure TJvInspectorStatusBarItem.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
    if IndexOf(Self) = -1 then
      Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TStatusPanels)));
end;

//-------------------------------------------------------------------------------

procedure TJvInspectorListColumnsItem.Edit;
var
  ListviewForm: TListviewForm;
  i: integer;
  lstColumn: TListColumn;
begin

  ListviewForm := TListviewForm.Create(GetParentForm(Inspector));
  try
    ListviewForm.LstViewObj.Columns.Clear;
    for i := 0 to
      TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Count - 1 do
    begin
      lstColumn := ListviewForm.LstViewObj.Columns.Add;
      lstColumn.Caption :=
        TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Caption;
      lstColumn.Width :=
        TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Width;
      lstColumn.Alignment :=
        TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Alignment;
    end;
    ListviewForm.fillListInfo;

    if ListviewForm.ShowModal <> mrOk then
      Exit
    else begin
      TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Clear;
      for i := 0 to ListviewForm.LstViewObj.Columns.Count - 1 do
      begin
        lstColumn :=
          TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Add;
        lstColumn.Caption := ListviewForm.LstViewObj.Columns[i].Caption;
        lstColumn.Width := ListviewForm.LstViewObj.Columns[i].Width;
        lstColumn.Alignment := ListviewForm.LstViewObj.Columns[i].Alignment;
      end;
    end;

    if assigned(TJvInspector(GetInspector).OnDataValueChanged) then
      TJvInspector(GetInspector).OnDataValueChanged(nil, Data);

  finally
    ListviewForm.Destroy;
  end;

end;

function TJvInspectorListColumnsItem.GetDisplayValue: string;
begin
  Result := 'Edit Columns';
end;

procedure TJvInspectorListColumnsItem.SetDisplayValue(const Value: string);
begin

end;

procedure TJvInspectorListColumnsItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewValue: TInspectorItemFlags;
begin
  NewValue := Value + [iifEditButton];
  inherited SetFlags(NewValue);
end;

class procedure TJvInspectorListColumnsItem.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
    if IndexOf(Self) = -1 then
      Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TListColumns)));
end;
//-------------------------------------------------------------------------------

procedure TJvInspectorTreeNodesItem.Edit;
begin
  ShowMessage('TJvInspectorTreeNodesItem.Edit');
end;

function TJvInspectorTreeNodesItem.GetDisplayValue: string;
begin
  Result := 'Edit Nodes';
end;

procedure TJvInspectorTreeNodesItem.SetDisplayValue(const Value: string);
begin

end;

procedure TJvInspectorTreeNodesItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewValue: TInspectorItemFlags;
begin
  NewValue := Value + [iifEditButton];
  inherited SetFlags(NewValue);
end;

class procedure TJvInspectorTreeNodesItem.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
    if IndexOf(Self) = -1 then
      Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TTreeNodes)));
end;
//-------------------------------------------------------------------------------

procedure TJvInspectorBitmapItem.Edit;
var
  PictureEdit: TPictureEdit;
  picObj:      Tpicture;
  strClassName: string;
begin
  PictureEdit  := TPictureEdit.Create(GetParentForm(Inspector));
  strClassName := UpperCase((TJvInspectorPropData(Self.GetData()).Instance).ClassName);

  if strClassName = UpperCase('TWxBitmapButton') then
    PictureEdit.Image1.Picture.Assign(TWxBitmapButton(
      TJvInspectorPropData(Self.GetData()).Instance).Wx_Bitmap);

  if strClassName = UpperCase('TWxToolButton') then
    PictureEdit.Image1.Picture.Assign(
      TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_Bitmap);

  if strClassName = UpperCase('TWxStaticBitmap') then
    PictureEdit.Image1.Picture.Assign(TWxStaticBitmap(
      TJvInspectorPropData(Self.GetData()).Instance).picture);

  if strClassName = UpperCase('TFrmNewForm') then
    PictureEdit.Image1.Picture.Assign(
      TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).Wx_ICON);

  try
    if PictureEdit.ShowModal = mrOk then
    begin
      picObj := TPicture.Create;
      picObj.Bitmap.Assign(PictureEdit.Image1.Picture.Bitmap);

      if strClassName = UpperCase('TWxStaticBitmap') then
      begin
        TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).picture.Assign(picObj);
        TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).picture.Bitmap.Transparent := True;
        TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).Width :=
          TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).picture.Bitmap.Width;
        TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).Height :=
          TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).picture.Bitmap.Height;
      end;

      if strClassName = UpperCase('TFrmNewForm') then
      begin
        TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).Wx_ICON.Assign(picObj);
        TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).Wx_ICON.Bitmap.Transparent := True;
      end;

      if strClassName = UpperCase('TWxBitmapButton') then
      begin
        TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Assign(picObj);
        TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Bitmap.Transparent := True;
        TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).SetButtonBitmap(picObj);
      end;

      if strClassName = UpperCase('TWxToolButton') then
      begin
        TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Assign(picObj);
        TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Bitmap.Transparent := True;
        TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).SetButtonBitmap(picObj);
      end;

      if assigned(TJvInspector(GetInspector).OnDataValueChanged) then
        TJvInspector(GetInspector).OnDataValueChanged(nil, Data);
    end;

  finally
    PictureEdit.Destroy;
  end;
end;

function TJvInspectorBitmapItem.GetDisplayValue: string;
begin
  Result := 'Edit Picture';
end;

procedure TJvInspectorBitmapItem.SetDisplayValue(const Value: string);
begin

end;

procedure TJvInspectorBitmapItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewValue: TInspectorItemFlags;
begin
  NewValue := Value + [iifEditButton];
  inherited SetFlags(NewValue);
end;

class procedure TJvInspectorBitmapItem.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
    if IndexOf(Self) = -1 then
      Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TPicture)));
end;
//------------------------------------------------------------------------------
procedure TJvInspectorMyFontItem.Edit;
var
  FontDlg:  TFontDialog;
  fnt:      TFont;
  compIntf: IWxComponentInterface;
  prevColor: TColor;
  ColorInt: integer;
begin

  fnt := TFont(Data.AsOrdinal);

  prevColor := fnt.Color;

  FontDlg := TFontDialog.Create(GetParentForm(Inspector));

  try
    FontDlg.Font.Assign(fnt);
    if not FontDlg.Execute then
      exit;
    fnt.Assign(FontDlg.Font);

    if prevColor <> fnt.Color then
      if (TJvInspectorPropData(Self.GetData()).Instance).GetInterface(
        IID_IWxComponentInterface, compIntf) then
      begin
        ColorInt := ColorToRGB(fnt.Color);
        compIntf.SetFGColor('CUS:' + IntToStr(GetRValue(ColorInt)) +
          ',' + IntToStr(GetGValue(ColorInt)) + ',' + IntToStr(GetBValue(ColorInt)));
      end;

    if assigned(TJvInspector(GetInspector).OnDataValueChanged) then
      TJvInspector(GetInspector).OnDataValueChanged(nil, Data);

  finally
    FontDlg.Destroy;
  end;
end;

function TJvInspectorMyFontItem.GetDisplayValue: string;
begin
  Result := 'Edit Font';
end;

procedure TJvInspectorMyFontItem.SetDisplayValue(const Value: string);
begin

end;

procedure TJvInspectorMyFontItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewValue: TInspectorItemFlags;
begin
  NewValue := Value + [iifEditButton];
  inherited SetFlags(NewValue);
end;

class procedure TJvInspectorMyFontItem.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
    if IndexOf(Self) = -1 then
      Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TFont)));
end;

//------------------------------------------------------------------------------
procedure TJvInspectorMenuItem.Edit;
var
  mnuDlg:    TMenuItemForm;
  pMenuItem: TWxPopupMenu;
  mbItem:    TWxMenuBar;
  maxControlValue: integer;
  MenuName:String;
begin
  try
  if (TJvInspectorPropData(Self.GetData()).Instance is TControl) then
      MenuName:=TControl(TJvInspectorPropData(Self.GetData()).Instance).Name;
  except
  end;
  mnuDlg := TMenuItemForm.Create(GetParentForm(Inspector),MenuName);
  try
    if (TJvInspectorPropData(Self.GetData()).Instance is TWxPopupMenu) then
    begin
      pMenuItem := TWxPopupMenu(TJvInspectorPropData(Self.GetData()).Instance);
      maxControlValue := GetMaxIDofWxForm(pMenuItem.parent);
      mnuDlg.SetMaxID(maxControlValue);
      mnuDlg.SetMenuItemsDes(pMenuItem.Parent, pMenuItem, TWxCustomMenuItem(
        pMenuItem.Wx_MenuItems), mnuDlg.FMenuItems);

      if mnuDlg.ShowModal <> mrOk then
        exit;

      pMenuItem.Wx_MenuItems.Destroy;
      pMenuItem.Wx_MenuItems := TWxCustomMenuItem.Create(pMenuItem);
      mnuDlg.SetMenuItemsDes(pMenuItem.Parent, pMenuItem, mnuDlg.FMenuItems,
        TWxCustomMenuItem(pMenuItem.Wx_MenuItems));

    end;

    if (TJvInspectorPropData(Self.GetData()).Instance is TWxMenuBar) then
    begin
      mbItem := TWxMenuBar(TJvInspectorPropData(Self.GetData()).Instance);
      maxControlValue := GetMaxIDofWxForm(mbItem.parent);
      mnuDlg.SetMaxID(maxControlValue);
      mnuDlg.SetMenuItemsDes(mbItem.Parent, mbItem, TWxCustomMenuItem(
        mbItem.Wx_MenuItems), mnuDlg.FMenuItems);

      if mnuDlg.ShowModal <> mrOk then
        exit;

      mbItem.Wx_MenuItems.Destroy;
      mbItem.Wx_MenuItems := TWxCustomMenuItem.Create(mbItem);
      mnuDlg.SetMenuItemsDes(mbItem.Parent, mbItem, mnuDlg.FMenuItems,
        TWxCustomMenuItem(mbItem.Wx_MenuItems));
      mbItem.BuildMenus(mbItem.Wx_MenuItems);

    end;

    if assigned(TJvInspector(GetInspector).OnDataValueChanged) then
      TJvInspector(GetInspector).OnDataValueChanged(nil, Data);

  finally
    mnuDlg.Destroy;
  end;
end;

function TJvInspectorMenuItem.GetDisplayValue: string;
begin
  Result := 'Edit MenuItems';
end;

procedure TJvInspectorMenuItem.SetDisplayValue(const Value: string);
begin

end;

procedure TJvInspectorMenuItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewValue: TInspectorItemFlags;
begin
  NewValue := Value + [iifEditButton];
  inherited SetFlags(NewValue);
end;

class procedure TJvInspectorMenuItem.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
    if IndexOf(Self) = -1 then
      Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TWxCustomMenuItem)));
end;

procedure TJvInspectorFileNameEditItem.Edit;
var
  FileOpenForm:     TOpenDialog;
  WxFileNameString: TWxFileNameString;
begin

  WxFileNameString := TWxFileNameString(Data.AsOrdinal);

  FileOpenForm := TOpenDialog.Create(GetParentForm(Inspector));
  FileOpenForm.Filter := 'All files (*.*)|*.*';

  if (FileOpenForm.Execute) then // If a file is selected
    WxFileNameString.FstrFileNameValue := FileOpenForm.FileName
  else  // If Cancel is pushed, then remove file to load
    WxFileNameString.FstrFileNameValue := '';

  // if strEqual(UpperCase((TJvInspectorPropData(Self.GetData()).Instance).ClassName), UpperCase('TWxMemo')) then
  //       TWxMemo(TJvInspectorPropData(Self.GetData()).Instance).SetWxFileName(WxFileNameString.FstrFileNameValue);

  // Tony 15 May 2005
  // Unfortunately, I need to do the OnDataValueChanged twice to get the
  // wxform to update. Problem is that I need to invoke SetWxFileName procedure
  // in the calling function (at this point WxMemo). The 2 lines above should
  // do this (TWxMemo(...)), but I compiler complains that it can't find TWxMemo
  if assigned(TJvInspector(GetInspector).OnDataValueChanged) then
  begin
    TJvInspector(GetInspector).OnDataValueChanged(nil, Data);
    TJvInspector(GetInspector).OnDataValueChanged(nil, Data);
  end;

end;

function TJvInspectorFileNameEditItem.GetDisplayValue: string;
var
  WxFileNameString: TWxFileNameString;
begin

  WxFileNameString := TWxFileNameString(Data.AsOrdinal);

  Result := 'File to load';

  if trim(WxFileNameString.FstrFileNameValue) <> '' then
    Result := WxFileNameString.FstrFileNameValue;
end;

procedure TJvInspectorFileNameEditItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewValue: TInspectorItemFlags;
begin
  NewValue := Value + [iifEditButton];
  inherited SetFlags(NewValue);
end;


 // Added by Tony Reina 20 June 2006
 // We need a TButton class that will allow for the caption to be aligned
// I found this code at the Delphi Central website: http://www.delphi-central.com/tbut.aspx
//  BEGIN: TMultiLineBtn
constructor TMultiLineBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fMultiLine     := True;
  fHorizAlign    := halCentre;
  fVerticalAlign := valCentre;
end;

procedure TMultiLineBtn.SetVerticalAlign(Value: TVerticalAlign);
begin
  if fVerticalAlign <> Value then
  begin
    fVerticalAlign := Value;
    RecreateWnd;
  end;
end;

procedure TMultiLineBtn.SetHorizAlign(Value: THorizAlign);
begin
  if fHorizAlign <> Value then
  begin
    fHorizAlign := Value;
    RecreateWnd;
  end;
end;

procedure TMultiLineBtn.SetMultiLine(Value: boolean);
begin
  if fMultiLine <> Value then
  begin
    fMultiLine := Value;
    RecreateWnd;
  end;
end;

procedure TMultiLineBtn.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  case VerticalAlign of
    valTop: Params.Style    := Params.Style or BS_TOP;
    valBottom: Params.Style := Params.Style or BS_BOTTOM;
    valCentre: Params.Style := Params.Style or BS_VCENTER;
  end;

  case HorizAlign of
    halLeft: Params.Style   := Params.Style or BS_LEFT;
    halRight: Params.Style  := Params.Style or BS_RIGHT;
    halCentre: Params.Style := Params.Style or BS_CENTER;
  end;

  if MultiLine then
    Params.Style := Params.Style or BS_MULTILINE
  else
    Params.Style := Params.Style and not BS_MULTILINE;
end;

// END: TMultiLineBtn

function CreateBlankXRC: TStringList;
begin

  Result := TStringList.Create;

  try

    Result.Add('<?xml version="1.0" encoding="ISO-8859-1"?>');
    Result.Add('<resource version="2.3.0.1">');
    Result.Add('<!-- Created by wxDev-C++ ' + DEVCPP_VERSION + ' -->');

    // Result.Add(Format('<object class="%s" name="%s">', [frmNewForm.Wx_class, frmNewForm.Wx_Name]));

    //Result.Add('</object>');
    Result.Add('</resource>');

  except
    Result.Destroy;
  end;
end;

function GetLongName(const ShortPathName: String): String;
var
  hKernel32Dll: THandle;
  fncGetLongPathName: function (lpszShortPath: LPCTSTR; lpszLongPath: LPTSTR;
    cchBuffer: DWORD): DWORD stdcall;
  bSuccess: Boolean;
  szBuffer: array[0..MAX_PATH] of Char;
  pDesktop: IShellFolder;
  swShortPath: WideString;
  iEaten: ULONG;
  pItemList: PItemIDList;
  iAttributes: ULONG;
begin
  // try to find the function "GetLongPathNameA" (Windows 98/2000)
  hKernel32Dll := GetModuleHandle('Kernel32.dll');
  if (hKernel32Dll <> 0) then
    @fncGetLongPathName := GetProcAddress(hKernel32Dll, 'GetLongPathNameA')
  else
    @fncGetLongPathName := nil;
  // use the function "GetLongPathNameA" if available
  bSuccess := False;
  if (Assigned(fncGetLongPathName)) then
  begin
    bSuccess := fncGetLongPathName(PChar(ShortPathName), szBuffer,
      SizeOf(szBuffer)) > 0;
    if bSuccess then
      Result := szBuffer;
  end;
  // use an alternative way of getting the path (Windows 95/NT)
  if (not bSuccess) and Succeeded(SHGetDesktopFolder(pDesktop)) then
  begin
    swShortPath := ShortPathName;
    iAttributes := 0;
    if Succeeded(pDesktop.ParseDisplayName(0, nil, POLESTR(swShortPath),
      iEaten, pItemList, iAttributes)) then
    begin
      bSuccess := SHGetPathFromIDList(pItemList, szBuffer);
      if bSuccess then
        Result := szBuffer;
      // release ItemIdList (SHGetMalloc is superseded)
      CoTaskMemFree(pItemList);
    end;
  end;
  // give back the original path if unsuccessful
  if (not bSuccess) then
    Result := ShortPathName;
end;

function strContains(const S1, S2: string): Boolean;
begin
    Result := Pos(S1, S2) > 0;
end;

{This unit contains 4 functions designed to validate and correct C++ class names
and windows file names. The functions are as follows

ValidateClassName       Takes a string and returns an integer containing the
                        number of errors found. It checks for empty class names,
                        names which don't contain only alphanumeric characters
                        or underscores. It also checks that the name is not a
                        reserved keyword.

CreateValidClassName    Takes a string containing the class name and returns a
                        string containing a 'fixed' class name. It runs through
                        the checks above, if an empty class name is found then
                        a default one is used. Any illegal characters are
                        replaced with an underscore. This may make strange
                        looking names but they are legal.

ValidateFileName        Takes a string containing the file name and returns an
                        integer containing the number of errors found. It checks
                        for empty filenames, names which contain "*?|:<>, since
                        these can choke the make program

CreateValidFileName     Takes a string containing the filename and returns a
                        string containing a legal filename. If the string is
                        empty a default name is filled in, otherwise any
                        illegal characters are replaced with an underscore.

Example usage of these functions.

  if(ValidateClassName(Edit1.Text) > 0 ) then
  begin
     if MessageDlg('Your class name contains errors, do you want it fixed automatically?',mtError,[mbYes, mbNo],0) = mrYes then
     begin
         Edit2.Text := CreateValidClassName(Edit1.Text);
     end
     else
     begin
        MessageDlg('Please fix the class name yourself, class names can only contain alphanumeric characters and an underscore, they cannot be reserved keywords or start with numbers',mtWarning,[mbOK],0);
     end;
  end;

This copyright to Sof.T 2006 and provided under the GPL license version 2 or
later at your preference.}
function ValidateClassName(ClassName: String) :Integer;
var
    NumberOfErrors, LoopIndex : integer;
    ReservedKeywordList : TStrings;
begin

    NumberOfErrors := 0;

    //Check we have a name to work with
    if Length(ClassName) < 1 then
    begin
        NumberOfErrors := NumberOfErrors+1;
    end
    //Check the first character is not a number
    else if (ClassName[1] in ['0'..'9']) then
    begin
        NumberOfErrors := NumberOfErrors + 1;
    end;

    //Look for invalid characters in the class name
    for LoopIndex := 1 to Length(ClassName) do
    begin
        //if not((ClassName[LoopIndex] in ['a'..'z']) or (ClassName[LoopIndex] in ['A'..'Z']) or (ClassName[LoopIndex] in ['0'..'9']) or (ClassName[LoopIndex] = '_')) then
        if not((ClassName[LoopIndex] in ['a'..'z','A'..'Z','0'..'9','_'])) then
        begin
            NumberOfErrors := NumberOfErrors + 1;
        end;
    end;

    //Check we haven't ended up with a reserved keyword
    ReservedKeywordList := TStringList.Create;
    try
        //Build the list of reserved keywords
        ReservedKeywordList.Add('asm');
        ReservedKeywordList.Add('do');
        ReservedKeywordList.Add('if');
        ReservedKeywordList.Add('return');
        ReservedKeywordList.Add('typedef');
        ReservedKeywordList.Add('auto');
        ReservedKeywordList.Add('double');
        ReservedKeywordList.Add('inline');
        ReservedKeywordList.Add('short');
        ReservedKeywordList.Add('typeid');
        ReservedKeywordList.Add('bool');
        ReservedKeywordList.Add('dynamic_cast');
        ReservedKeywordList.Add('int');
        ReservedKeywordList.Add('signed');
        ReservedKeywordList.Add('union');
        ReservedKeywordList.Add('break');
        ReservedKeywordList.Add('else');
        ReservedKeywordList.Add('long');
        ReservedKeywordList.Add('sizeof');
        ReservedKeywordList.Add('unsigned');
        ReservedKeywordList.Add('case');
        ReservedKeywordList.Add('enum');
        ReservedKeywordList.Add('mutable');
        ReservedKeywordList.Add('static');
        ReservedKeywordList.Add('using');
        ReservedKeywordList.Add('catch');
        ReservedKeywordList.Add('explicit');
        ReservedKeywordList.Add('namespace');
        ReservedKeywordList.Add('static_cast');
        ReservedKeywordList.Add('virtual');
        ReservedKeywordList.Add('char');
        ReservedKeywordList.Add('export');
        ReservedKeywordList.Add('new');
        ReservedKeywordList.Add('struct');
        ReservedKeywordList.Add('void');
        ReservedKeywordList.Add('class');
        ReservedKeywordList.Add('extern');
        ReservedKeywordList.Add('operator');
        ReservedKeywordList.Add('switch');
        ReservedKeywordList.Add('volatile');
        ReservedKeywordList.Add('const');
        ReservedKeywordList.Add('false');
        ReservedKeywordList.Add('private');
        ReservedKeywordList.Add('template');
        ReservedKeywordList.Add('wchar_t');
        ReservedKeywordList.Add('const_cast');
        ReservedKeywordList.Add('float');
        ReservedKeywordList.Add('protected');
        ReservedKeywordList.Add('this');
        ReservedKeywordList.Add('while');
        ReservedKeywordList.Add('continue');
        ReservedKeywordList.Add('for');
        ReservedKeywordList.Add('public');
        ReservedKeywordList.Add('throw');
        ReservedKeywordList.Add('default');
        ReservedKeywordList.Add('friend');
        ReservedKeywordList.Add('register');
        ReservedKeywordList.Add('true');
        ReservedKeywordList.Add('delete');
        ReservedKeywordList.Add('goto');
        ReservedKeywordList.Add('reinterpret_cast');
        ReservedKeywordList.Add('try');

        //Now check our ClassName against list of reserved keywords
        for LoopIndex := 0 to ReservedKeywordList.Count - 1 do
        begin
            if(CompareStr(ReservedKeywordList[LoopIndex],ClassName) = 0) then
            begin
                NumberOfErrors := NumberOfErrors + 1;
            end;
        end;

    finally
        ReservedKeywordList.Free;	{ destroy the list object }
    end;

   Result := NumberOfErrors;

end;

function CreateValidClassName(ClassName: String) :String;
var
    ValidClassName : String;
    LoopIndex : integer;
    ReservedKeywordList : TStrings;
begin

    ValidClassName := ClassName;

    //Check we have a name to work with, if not then assign a safe one
    if Length(ValidClassName) < 1 then
        ValidClassName := 'DefaultClassName';

    //Look for invalid characters in the class name. Replace with '_'
    for LoopIndex := 1 to Length(ValidClassName) do
    begin
        if not((ValidClassName[LoopIndex] in ['a'..'z','A'..'Z','0'..'9','_'])) then
        begin
            ValidClassName[LoopIndex] := '_';
        end;
    end;

    //Check the first character is not a number if so add '_' in front
    if (ValidClassName[1] in ['0'..'9']) then
    begin
        Insert('_',ValidClassName,0);
    end;

    //Check we haven't ended up with a reserved keyword
    ReservedKeywordList := TStringList.Create;
    try
        //Build the list of reserved keywords
        ReservedKeywordList.Add('asm');
        ReservedKeywordList.Add('do');
        ReservedKeywordList.Add('if');
        ReservedKeywordList.Add('return');
        ReservedKeywordList.Add('typedef');
        ReservedKeywordList.Add('auto');
        ReservedKeywordList.Add('double');
        ReservedKeywordList.Add('inline');
        ReservedKeywordList.Add('short');
        ReservedKeywordList.Add('typeid');
        ReservedKeywordList.Add('bool');
        ReservedKeywordList.Add('dynamic_cast');
        ReservedKeywordList.Add('int');
        ReservedKeywordList.Add('signed');
        ReservedKeywordList.Add('union');
        ReservedKeywordList.Add('break');
        ReservedKeywordList.Add('else');
        ReservedKeywordList.Add('long');
        ReservedKeywordList.Add('sizeof');
        ReservedKeywordList.Add('unsigned');
        ReservedKeywordList.Add('case');
        ReservedKeywordList.Add('enum');
        ReservedKeywordList.Add('mutable');
        ReservedKeywordList.Add('static');
        ReservedKeywordList.Add('using');
        ReservedKeywordList.Add('catch');
        ReservedKeywordList.Add('explicit');
        ReservedKeywordList.Add('namespace');
        ReservedKeywordList.Add('static_cast');
        ReservedKeywordList.Add('virtual');
        ReservedKeywordList.Add('char');
        ReservedKeywordList.Add('export');
        ReservedKeywordList.Add('new');
        ReservedKeywordList.Add('struct');
        ReservedKeywordList.Add('void');
        ReservedKeywordList.Add('class');
        ReservedKeywordList.Add('extern');
        ReservedKeywordList.Add('operator');
        ReservedKeywordList.Add('switch');
        ReservedKeywordList.Add('volatile');
        ReservedKeywordList.Add('const');
        ReservedKeywordList.Add('false');
        ReservedKeywordList.Add('private');
        ReservedKeywordList.Add('template');
        ReservedKeywordList.Add('wchar_t');
        ReservedKeywordList.Add('const_cast');
        ReservedKeywordList.Add('float');
        ReservedKeywordList.Add('protected');
        ReservedKeywordList.Add('this');
        ReservedKeywordList.Add('while');
        ReservedKeywordList.Add('continue');
        ReservedKeywordList.Add('for');
        ReservedKeywordList.Add('public');
        ReservedKeywordList.Add('throw');
        ReservedKeywordList.Add('default');
        ReservedKeywordList.Add('friend');
        ReservedKeywordList.Add('register');
        ReservedKeywordList.Add('true');
        ReservedKeywordList.Add('delete');
        ReservedKeywordList.Add('goto');
        ReservedKeywordList.Add('reinterpret_cast');
        ReservedKeywordList.Add('try');

        //Now check our ValidClassName against list of reserved keywords
        //If we find a match flag error and add '_' to the start of the name
        for LoopIndex := 0 to ReservedKeywordList.Count - 1 do
        begin
            if(CompareStr(ReservedKeywordList[LoopIndex],ValidClassName) = 0) then
            begin
                Insert('_',ValidClassName,0);
            end;
        end;

    finally
        ReservedKeywordList.Free;	{ destroy the list object }
    end;

   Result := ValidClassName;

end;


function ValidateFileName(FileName: String): Integer;
var
    NumberOfErrors, LoopIndex : integer;
begin

    NumberOfErrors := 0;

    if Length(FileName) < 1 then
        NumberOfErrors := NumberOfErrors+1;

    //Look for invalid characters in the file name
    for LoopIndex := 1 to Length(FileName) do
    begin
        if ((FileName[LoopIndex] in ['"','*',':','<','>','?','|'])) then
        begin
            NumberOfErrors := NumberOfErrors+1;
        end;
    end;

    Result := NumberOfErrors;

end;

function CreateValidFileName(FileName: String): String;
var
    ValidFileName : String;
    LoopIndex : integer;
begin

    ValidFileName := FileName;

    if Length(ValidFileName) < 1 then
        ValidFileName := 'DefaultFileName';

    //Look for invalid characters in the file name. Replace with '_'
    for LoopIndex := 1 to Length(ValidFileName) do
    begin
        if ((ValidFileName[LoopIndex] in ['"','*',':','<','>','?','|'])) then
        begin
            ValidFileName[LoopIndex] := '_';
        end;
    end;

    Result := ValidFileName;

end;

end.
