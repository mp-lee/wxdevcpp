{*******************************************************}
{                                                       }
{       HTML Help API Interface Unit                    }
{                                                       }
{       Copyright (c) 1999 The Helpware Group           }
{                                                       }
{*******************************************************}

{
========================================================
  hh.pas
  Version: 1.9
  HTML Help API Unit

  htmlhelp.h ported to The Helpware Group
  Copyright (c) 1999 The Helpware Group
  Email: support@helpware.net
  Web: http://www.helpware.net
  Platform: Delphi 2, 3, 4, 5, 6, 7 ...

  Notes:
    htmlhelp.h is distributed with HH Workshop.
    A free download from
    http://msdn.microsoft.com/library/en-us/htmlhelp/html/vsconhh1start.asp

    The name hh.pas was used instead of htmlhelp.pas
    to avoid a name clash with API function htmlhelp()

  Changes Notes: See hh_doc.txt
    Download: http://helpware.net/delphi/delphikit.zip
    from Kit Home Page: http://helpware.net/delphi/

========================================================
}



Unit hh;

Interface

Uses
    Windows,   //This line will not compile under Delphi 1 -- D1 is not supported
    SysUtils,
    dialogs,
    Registry;

{ >> Create conditional symbols.
     Note: This module is Delphi 2/3/4/5/.. compatible

     VER90     - Predefined by Delphi 2 compiler.
     VER100    - Predefined by Delphi 3 compiler.
     D4PLUS    - We defined this if Compiler is Delphi 4 or greater
}

{$DEFINE D4PLUS}

{$IFDEF VER90}        //Dephi 2
  {$UNDEF D4PLUS}
{$ENDIF}

{$IFDEF VER100}       //Dephi 3
  {$UNDEF D4PLUS}
{$ENDIF}



Var
    //0 if hhctrl.ocx could not be loaded
    HHCtrlHandle: THandle = 0;

    //You can set this to false to override the default load API load on module initialization
    AutoLoadAPI: Boolean = True;

Const
    hhctrlLib = 'hhctrl.ocx';

{exports}
Function GetPathToHHCtrlOCX: String;
Procedure LoadHtmlHelp;
Procedure UnloadHtmlHelp;


{ Externals from HHCTRL.OCX }

Var                            //functions are invalid if HHCtrlHandle = 0
    HtmlHelpA: Function(hwndCaller: HWND; pszFile: PAnsiChar;
    uCommand: UInt; dwData: DWORD): HWND; Stdcall;

    HtmlHelpW: Function(hwndCaller: HWND; pszFile: PWideChar;
    uCommand: UInt; dwData: DWORD): HWND; Stdcall;

    HtmlHelp: Function(hwndCaller: HWND; pszFile: Pchar;
    uCommand: UInt; dwData: DWORD): HWND; Stdcall;


{ Use the following for GetProcAddress to load from hhctrl.ocx }

Const
    ATOM_HTMLHELP_API_ANSI = 14;
    ATOM_HTMLHELP_API_UNICODE = 15;


{ Commands to pass to HtmlHelp() }

Const
    HH_DISPLAY_TOPIC = $0000;  {**}
    HH_HELP_FINDER = $0000;  // WinHelp equivalent
    HH_DISPLAY_TOC = $0001;  // not currently implemented
    HH_DISPLAY_INDEX = $0002;  // not currently implemented
    HH_DISPLAY_SEARCH = $0003;  // not currently implemented
    HH_SET_WIN_TYPE = $0004;
    HH_GET_WIN_TYPE = $0005;
    HH_GET_WIN_HANDLE = $0006;
    HH_ENUM_INFO_TYPE = $0007;
    // Get Info type name, call repeatedly to enumerate, -1 at end
    HH_SET_INFO_TYPE = $0008;  // Add Info type to filter.
    HH_SYNC = $0009;
    HH_RESERVED1 = $000A;
    HH_RESERVED2 = $000B;
    HH_RESERVED3 = $000C;
    HH_KEYWORD_LOOKUP = $000D;
    HH_DISPLAY_TEXT_POPUP = $000E;
    // display string resource id or text in a popup window
    HH_HELP_CONTEXT = $000F;
    {**}// display mapped numeric value in dwData
    HH_TP_HELP_CONTEXTMENU = $0010;
    // text popup help, same as WinHelp HELP_CONTEXTMENU
    HH_TP_HELP_WM_HELP = $0011;
    // text popup help, same as WinHelp HELP_WM_HELP
    HH_CLOSE_ALL = $0012;
    // close all windows opened directly or indirectly by the caller
    HH_ALINK_LOOKUP = $0013;  // ALink version of HH_KEYWORD_LOOKUP
    HH_GET_LAST_ERROR = $0014;
    // not currently implemented // See HHERROR.h
    HH_ENUM_CATEGORY = $0015;
	   // Get category name, call repeatedly to enumerate, -1 at end
    HH_ENUM_CATEGORY_IT = $0016;
    // Get category info type members, call repeatedly to enumerate, -1 at end
    HH_RESET_IT_FILTER = $0017;
    // Clear the info type filter of all info types.
    HH_SET_INCLUSIVE_FILTER = $0018;
    // set inclusive filtering method for untyped topics to be included in display
    HH_SET_EXCLUSIVE_FILTER = $0019;
    // set exclusive filtering method for untyped topics to be excluded from display
    HH_INITIALIZE = $001C;  // Initializes the help system.
    HH_UNINITIALIZE = $001D;  // Uninitializes the help system.
    HH_SAFE_DISPLAY_TOPIC = $0020;
    // Safe Call works with IE6 window.ShowHelp() - See Q811630
    HH_PRETRANSLATEMESSAGE = $00fd;  // Pumps messages. (NULL, NULL, MSG*).
    HH_SET_GLOBAL_PROPERTY = $00fc;
// Set a global property. (NULL, NULL, HH_GPROP)

{ window properties }

Const
    HHWIN_PROP_TAB_AUTOHIDESHOW = $00000001;
    // (1 << 0)  Automatically hide/show tri-pane window
    HHWIN_PROP_ONTOP = $00000002;  // (1 << 1)  Top-most window
    HHWIN_PROP_NOTITLEBAR = $00000004;  // (1 << 2)  no title bar
    HHWIN_PROP_NODEF_STYLES = $00000008;
    // (1 << 3)  no default window styles (only HH_WINTYPE.dwStyles)
    HHWIN_PROP_NODEF_EXSTYLES = $00000010;
    // (1 << 4)  no default extended window styles (only HH_WINTYPE.dwExStyles)
    HHWIN_PROP_TRI_PANE = $00000020;  // (1 << 5)  use a tri-pane window
    HHWIN_PROP_NOTB_TEXT = $00000040;
    // (1 << 6)  no text on toolbar buttons
    HHWIN_PROP_POST_QUIT = $00000080;
    // (1 << 7)  post WM_QUIT message when window closes
    HHWIN_PROP_AUTO_SYNC = $00000100;
    // (1 << 8)  automatically ssync contents and index
    HHWIN_PROP_TRACKING = $00000200;
    // (1 << 9)  send tracking notification messages
    HHWIN_PROP_TAB_SEARCH = $00000400;
    // (1 << 10) include search tab in navigation pane
    HHWIN_PROP_TAB_HISTORY = $00000800;
    // (1 << 11) include history tab in navigation pane
    HHWIN_PROP_TAB_FAVORITES = $00001000;
    // (1 << 12) include favorites tab in navigation pane
    HHWIN_PROP_CHANGE_TITLE = $00002000;
    // (1 << 13) Put current HTML title in title bar
    HHWIN_PROP_NAV_ONLY_WIN = $00004000;
    // (1 << 14) Only display the navigation window
    HHWIN_PROP_NO_TOOLBAR = $00008000;
    // (1 << 15) Don't display a toolbar
    HHWIN_PROP_MENU = $00010000;  // (1 << 16) Menu
    HHWIN_PROP_TAB_ADVSEARCH = $00020000;  // (1 << 17) Advanced FTS UI.
    HHWIN_PROP_USER_POS = $00040000;
    // (1 << 18) After initial creation, user controls window size/position
    HHWIN_PROP_TAB_CUSTOM1 = $00080000;  // (1 << 19) Use custom tab #1
    HHWIN_PROP_TAB_CUSTOM2 = $00100000;  // (1 << 20) Use custom tab #2
    HHWIN_PROP_TAB_CUSTOM3 = $00200000;  // (1 << 21) Use custom tab #3
    HHWIN_PROP_TAB_CUSTOM4 = $00400000;  // (1 << 22) Use custom tab #4
    HHWIN_PROP_TAB_CUSTOM5 = $00800000;  // (1 << 23) Use custom tab #5
    HHWIN_PROP_TAB_CUSTOM6 = $01000000;  // (1 << 24) Use custom tab #6
    HHWIN_PROP_TAB_CUSTOM7 = $02000000;  // (1 << 25) Use custom tab #7
    HHWIN_PROP_TAB_CUSTOM8 = $04000000;  // (1 << 26) Use custom tab #8
    HHWIN_PROP_TAB_CUSTOM9 = $08000000;  // (1 << 27) Use custom tab #9
    HHWIN_TB_MARGIN = $10000000;
// (1 << 28) the window type has a margin

{ window parameters }

Const
    HHWIN_PARAM_PROPERTIES = $00000002;  // (1 << 1)  valid fsWinProperties
    HHWIN_PARAM_STYLES = $00000004;  // (1 << 2)  valid dwStyles
    HHWIN_PARAM_EXSTYLES = $00000008;  // (1 << 3)  valid dwExStyles
    HHWIN_PARAM_RECT = $00000010;  // (1 << 4)  valid rcWindowPos
    HHWIN_PARAM_NAV_WIDTH = $00000020;  // (1 << 5)  valid iNavWidth
    HHWIN_PARAM_SHOWSTATE = $00000040;  // (1 << 6)  valid nShowState
    HHWIN_PARAM_INFOTYPES = $00000080;  // (1 << 7)  valid apInfoTypes
    HHWIN_PARAM_TB_FLAGS = $00000100;  // (1 << 8)  valid fsToolBarFlags
    HHWIN_PARAM_EXPANSION = $00000200;  // (1 << 9)  valid fNotExpanded
    HHWIN_PARAM_TABPOS = $00000400;  // (1 << 10) valid tabpos
    HHWIN_PARAM_TABORDER = $00000800;  // (1 << 11) valid taborder
    HHWIN_PARAM_HISTORY_COUNT = $00001000;  // (1 << 12) valid cHistory
    HHWIN_PARAM_CUR_TAB = $00002000;  // (1 << 13) valid curNavType

{ button constants }

Const
    HHWIN_BUTTON_EXPAND = $00000002;  // (1 << 1)  Expand/contract button
    HHWIN_BUTTON_BACK = $00000004;  // (1 << 2)  Back button
    HHWIN_BUTTON_FORWARD = $00000008;  // (1 << 3)  Forward button
    HHWIN_BUTTON_STOP = $00000010;  // (1 << 4)  Stop button
    HHWIN_BUTTON_REFRESH = $00000020;  // (1 << 5)  Refresh button
    HHWIN_BUTTON_HOME = $00000040;  // (1 << 6)  Home button
    HHWIN_BUTTON_BROWSE_FWD = $00000080;  // (1 << 7)  not implemented
    HHWIN_BUTTON_BROWSE_BCK = $00000100;  // (1 << 8)  not implemented
    HHWIN_BUTTON_NOTES = $00000200;  // (1 << 9)  not implemented
    HHWIN_BUTTON_CONTENTS = $00000400;  // (1 << 10) not implemented
    HHWIN_BUTTON_SYNC = $00000800;  // (1 << 11) Sync button
    HHWIN_BUTTON_OPTIONS = $00001000;  // (1 << 12) Options button
    HHWIN_BUTTON_PRINT = $00002000;  // (1 << 13) Print button
    HHWIN_BUTTON_INDEX = $00004000;  // (1 << 14) not implemented
    HHWIN_BUTTON_SEARCH = $00008000;  // (1 << 15) not implemented
    HHWIN_BUTTON_HISTORY = $00010000;  // (1 << 16) not implemented
    HHWIN_BUTTON_FAVORITES = $00020000;  // (1 << 17) not implemented
    HHWIN_BUTTON_JUMP1 = $00040000;  // (1 << 18)
    HHWIN_BUTTON_JUMP2 = $00080000;  // (1 << 19)
    HHWIN_BUTTON_ZOOM = $00100000;  // (1 << 20)
    HHWIN_BUTTON_TOC_NEXT = $00200000;  // (1 << 21)
    HHWIN_BUTTON_TOC_PREV = $00400000;  // (1 << 22)

    HHWIN_DEF_BUTTONS = (HHWIN_BUTTON_EXPAND
        Or HHWIN_BUTTON_BACK
        Or HHWIN_BUTTON_OPTIONS
        Or HHWIN_BUTTON_PRINT);


{ Button IDs }

Const
    IDTB_EXPAND = 200;
    IDTB_CONTRACT = 201;
    IDTB_STOP = 202;
    IDTB_REFRESH = 203;
    IDTB_BACK = 204;
    IDTB_HOME = 205;
    IDTB_SYNC = 206;
    IDTB_PRINT = 207;
    IDTB_OPTIONS = 208;
    IDTB_FORWARD = 209;
    IDTB_NOTES = 210; // not implemented
    IDTB_BROWSE_FWD = 211;
    IDTB_BROWSE_BACK = 212;
    IDTB_CONTENTS = 213; // not implemented
    IDTB_INDEX = 214; // not implemented
    IDTB_SEARCH = 215; // not implemented
    IDTB_HISTORY = 216; // not implemented
    IDTB_FAVORITES = 217; // not implemented
    IDTB_JUMP1 = 218;
    IDTB_JUMP2 = 219;
    IDTB_CUSTOMIZE = 221;
    IDTB_ZOOM = 222;
    IDTB_TOC_NEXT = 223;
    IDTB_TOC_PREV = 224;


{ Notification codes }

Const
    HHN_FIRST = (0 - 860);
    HHN_LAST = (0 - 879);

    HHN_NAVCOMPLETE = (HHN_FIRST - 0);
    HHN_TRACK = (HHN_FIRST - 1);
    HHN_WINDOW_CREATE = (HHN_FIRST - 2);


Type
    {*** Notify event info for HHN_NAVCOMPLETE, HHN_WINDOW_CREATE }
    PHHNNotify = ^THHNNotify;
    tagHHN_NOTIFY = Packed Record
        hdr: TNMHdr;
        pszUrl: Pchar;              //PCSTR: Multi-byte, null-terminated string
    End;
    HHN_NOTIFY = tagHHN_NOTIFY;
    THHNNotify = tagHHN_NOTIFY;

    {** Use by command HH_DISPLAY_TEXT_POPUP}
    PHHPopup = ^THHPopup;
    tagHH_POPUP = Packed Record
        cbStruct: Integer;     // sizeof this structure
        hinst: HINST;       // instance handle for string resource
        idString: Cardinal;
        // string resource id, or text id if pszFile is specified in HtmlHelp call
        pszText: Pchar;       // used if idString is zero
        pt: TPOINT;      // top center of popup window
        clrForeground: COLORREF;    // use -1 for default
        clrBackground: COLORREF;    // use -1 for default
        rcMargins: TRect;
        // amount of space between edges of window and text, -1 for each member to ignore
        pszFont: Pchar;
        // facename, point size, char set, BOLD ITALIC UNDERLINE
    End;
    HH_POPUP = tagHH_POPUP;
    THHPopup = tagHH_POPUP;

    {** Use by commands - HH_ALINK_LOOKUP, HH_KEYWORD_LOOKUP}
    PHHAKLink = ^THHAKLink;
    tagHH_AKLINK = Packed Record
        cbStruct: Integer;     // sizeof this structure
        fReserved: BOOL;        // must be FALSE (really!)
        pszKeywords: Pchar;       // semi-colon separated keywords
        pszUrl: Pchar;
        // URL to jump to if no keywords found (may be NULL)
        pszMsgText: Pchar;
        // Message text to display in MessageBox if pszUrl is NULL and no keyword match
        pszMsgTitle: Pchar;
        // Message text to display in MessageBox if pszUrl is NULL and no keyword match
        pszWindow: Pchar;       // Window to display URL in
        fIndexOnFail: BOOL;        // Displays index if keyword lookup fails.
    End;
    HH_AKLINK = tagHH_AKLINK;
    THHAKLink = tagHH_AKLINK;


Const
    HHWIN_NAVTYPE_TOC = 0;
    HHWIN_NAVTYPE_INDEX = 1;
    HHWIN_NAVTYPE_SEARCH = 2;
    HHWIN_NAVTYPE_FAVORITES = 3;
    HHWIN_NAVTYPE_HISTORY = 4;   // not implemented
    HHWIN_NAVTYPE_AUTHOR = 5;
    HHWIN_NAVTYPE_CUSTOM_FIRST = 11;


Const
    IT_INCLUSIVE = 0;
    IT_EXCLUSIVE = 1;
    IT_HIDDEN = 2;

Type
    PHHEnumIT = ^THHEnumIT;
    tagHH_ENUM_IT = Packed Record
        //tagHH_ENUM_IT, HH_ENUM_IT, *PHH_ENUM_IT
        cbStruct: Integer;     // size of this structure
        iType: Integer;
        // the type of the information type ie. Inclusive, Exclusive, or Hidden
        pszCatName: PAnsiChar;
        // Set to the name of the Category to enumerate the info types in a category; else NULL
        pszITName: PAnsiChar;
        // volitile pointer to the name of the infotype. Allocated by call. Caller responsible for freeing
        pszITDescription: PAnsiChar;
        // volitile pointer to the description of the infotype.
    End;
    THHEnumIT = tagHH_ENUM_IT;


Type
    PHHEnumCat = ^THHEnumCat;
    tagHH_ENUM_CAT = Packed Record
        //tagHH_ENUM_CAT, HH_ENUM_CAT, *PHH_ENUM_CAT
        cbStruct: Integer;     // size of this structure
        pszCatName: PAnsiChar;   // volitile pointer to the category name
        pszCatDescription: PAnsiChar;
        // volitile pointer to the category description
    End;
    THHEnumCat = tagHH_ENUM_CAT;


Type
    PHHSetInfoType = ^THHSetInfoType;
    tagHH_SET_INFOTYPE = Packed Record
        //tagHH_SET_INFOTYPE, HH_SET_INFOTYPE, *PHH_SET_INFOTYPE
        cbStruct: Integer;     // the size of this structure
        pszCatName: PAnsiChar;
        // the name of the category, if any, the InfoType is a member of.
        pszInfoTypeName: PAnsiChar;
        // the name of the info type to add to the filter
    End;
    THHSetInfoType = tagHH_SET_INFOTYPE;


Type
    HH_INFOTYPE = DWORD;
    THHInfoType = HH_INFOTYPE;
    PHHInfoType = ^THHInfoType;        //PHH_INFOTYPE


Const
    HHWIN_NAVTAB_TOP = 0;
    HHWIN_NAVTAB_LEFT = 1;
    HHWIN_NAVTAB_BOTTOM = 2;

Const
    HH_MAX_TABS = 19;                 // maximum number of tabs
Const
    HH_TAB_CONTENTS = 0;
    HH_TAB_INDEX = 1;
    HH_TAB_SEARCH = 2;
    HH_TAB_FAVORITES = 3;
    HH_TAB_HISTORY = 4;
    HH_TAB_AUTHOR = 5;
    HH_TAB_CUSTOM_FIRST = 11;
    HH_TAB_CUSTOM_LAST = HH_MAX_TABS;

    HH_MAX_TABS_CUSTOM = (HH_TAB_CUSTOM_LAST - HH_TAB_CUSTOM_FIRST + 1);



{ HH_DISPLAY_SEARCH Command Related Structures and Constants }

Const
    HH_FTS_DEFAULT_PROXIMITY = (-1);

Type
    {** Used by command HH_DISPLAY_SEARCH}
    PHHFtsQuery = ^THHFtsQuery;
    tagHH_FTS_QUERY = Packed Record          //tagHH_FTS_QUERY, HH_FTS_QUERY
        cbStruct: Integer;      // Sizeof structure in bytes.
        fUniCodeStrings: BOOL;         // TRUE if all strings are unicode.
        pszSearchQuery: Pchar;        // String containing the search query.
        iProximity: Longint;      // Word proximity.
        fStemmedSearch: Bool;         // TRUE for StemmedSearch only.
        fTitleOnly: Bool;         // TRUE for Title search only.
        fExecute: Bool;         // TRUE to initiate the search.
        pszWindow: Pchar;        // Window to display in
    End;
    THHFtsQuery = tagHH_FTS_QUERY;


{ HH_WINTYPE Structure }

Type
    {** Used by commands HH_GET_WIN_TYPE, HH_SET_WIN_TYPE}
    PHHWinType = ^THHWinType;
    tagHH_WINTYPE = Packed Record
        //tagHH_WINTYPE, HH_WINTYPE, *PHH_WINTYPE;
        cbStruct: Integer;
        // IN: size of this structure including all Information Types
        fUniCodeStrings: BOOL;
        // IN/OUT: TRUE if all strings are in UNICODE
        pszType: Pchar;        // IN/OUT: Name of a type of window
        fsValidMembers: DWORD;
        // IN: Bit flag of valid members (HHWIN_PARAM_)
        fsWinProperties: DWORD;
        // IN/OUT: Properties/attributes of the window (HHWIN_)

        pszCaption: Pchar;        // IN/OUT: Window title
        dwStyles: DWORD;        // IN/OUT: Window styles
        dwExStyles: DWORD;        // IN/OUT: Extended Window styles
        rcWindowPos: TRect;
        // IN: Starting position, OUT: current position
        nShowState: Integer;      // IN: show state (e.g., SW_SHOW)

        hwndHelp: HWND;         // OUT: window handle
        hwndCaller: HWND;         // OUT: who called this window

        paInfoTypes: PHHInfoType;
        // IN: Pointer to an array of Information Types

        { The following members are only valid if HHWIN_PROP_TRI_PANE is set }

        hwndToolBar: HWND;         // OUT: toolbar window in tri-pane window
        hwndNavigation: HWND;
        // OUT: navigation window in tri-pane window
        hwndHTML: HWND;
        // OUT: window displaying HTML in tri-pane window
        iNavWidth: Integer;      // IN/OUT: width of navigation window
        rcHTML: TRect;        // OUT: HTML window coordinates

        pszToc: Pchar;
        // IN: Location of the table of contents file
        pszIndex: Pchar;        // IN: Location of the index file
        pszFile: Pchar;        // IN: Default location of the html file
        pszHome: Pchar;
        // IN/OUT: html file to display when Home button is clicked
        fsToolBarFlags: DWORD;
        // IN: flags controling the appearance of the toolbar (HHWIN_BUTTON_)
        fNotExpanded: BOOL;
        // IN: TRUE/FALSE to contract or expand, OUT: current state
        curNavType: Integer;
        // IN/OUT: UI to display in the navigational pane
        tabpos: Integer;
        // IN/OUT: HHWIN_NAVTAB_TOP, HHWIN_NAVTAB_LEFT, or HHWIN_NAVTAB_BOTTOM
        idNotify: Integer;      // IN: ID to use for WM_NOTIFY messages
        tabOrder: Packed Array[0..HH_MAX_TABS] Of Byte;
        // IN/OUT: tab order: Contents, Index, Search, History, Favorites, Reserved 1-5, Custom tabs
        cHistory: Integer;
        // IN/OUT: number of history items to keep (default is 30)
        pszJump1: Pchar;         // Text for HHWIN_BUTTON_JUMP1
        pszJump2: Pchar;         // Text for HHWIN_BUTTON_JUMP2
        pszUrlJump1: Pchar;         // URL for HHWIN_BUTTON_JUMP1
        pszUrlJump2: Pchar;         // URL for HHWIN_BUTTON_JUMP2
        rcMinSize: TRect;
        // Minimum size for window (ignored in version 1)

        cbInfoTypes: Integer;       // size of paInfoTypes;
        pszCustomTabs: Pchar;         // multiple zero-terminated strings
    End;
    HH_WINTYPE = tagHH_WINTYPE;
    THHWinType = tagHH_WINTYPE;

Const
    HHACT_TAB_CONTENTS = 0;
    HHACT_TAB_INDEX = 1;
    HHACT_TAB_SEARCH = 2;
    HHACT_TAB_HISTORY = 3;
    HHACT_TAB_FAVORITES = 4;

    HHACT_EXPAND = 5;
    HHACT_CONTRACT = 6;
    HHACT_BACK = 7;
    HHACT_FORWARD = 8;
    HHACT_STOP = 9;
    HHACT_REFRESH = 10;
    HHACT_HOME = 11;
    HHACT_SYNC = 12;
    HHACT_OPTIONS = 13;
    HHACT_PRINT = 14;
    HHACT_HIGHLIGHT = 15;
    HHACT_CUSTOMIZE = 16;
    HHACT_JUMP1 = 17;
    HHACT_JUMP2 = 18;
    HHACT_ZOOM = 19;
    HHACT_TOC_NEXT = 20;
    HHACT_TOC_PREV = 21;
    HHACT_NOTES = 22;

    HHACT_LAST_ENUM = 23;


Type
    {*** Notify event info for HHN_TRACK }
    PHHNTrack = ^THHNTrack;
    tagHHNTRACK = Packed Record                  //tagHHNTRACK, HHNTRACK;
        hdr: TNMHdr;
        pszCurUrl: Pchar;
        // Multi-byte, null-terminated string  
        idAction: Integer;                // HHACT_ value
        phhWinType: PHHWinType;             // Current window type structure
    End;
    HHNTRACK = tagHHNTRACK;
    THHNTrack = tagHHNTRACK;


//========================
//
// Global Control Properties.
//
Const
    HH_GPROPID_SINGLETHREAD = 1;      // VARIANT_BOOL: True for single thread
    HH_GPROPID_TOOLBAR_MARGIN = 2;
    // long: Provides a left/right margin around the toolbar.
    HH_GPROPID_UI_LANGUAGE = 3;      // long: LangId of the UI.
    HH_GPROPID_CURRENT_SUBSET = 4;      // BSTR: Current subset.
    HH_GPROPID_CONTENT_LANGUAGE = 5;      // long: LandId for desired content.

Type
    tagHH_GPROPID = HH_GPROPID_SINGLETHREAD..HH_GPROPID_CONTENT_LANGUAGE;
    //tagHH_GPROPID, HH_GPROPID
    HH_GPROPID = tagHH_GPROPID;
    THHGPropID = HH_GPROPID;

//========================
//
// Global Property structure
//
Type
    PHHGlobalProperty = ^THHGlobalProperty;
    tagHH_GLOBAL_PROPERTY = Record
        //tagHH_GLOBAL_PROPERTY, HH_GLOBAL_PROPERTY
        id: THHGPropID;
        Dummy: Integer;
        // Added to enforce 8-byte packing
        var_: Variant;
    End;
    HH_GLOBAL_PROPERTY = tagHH_GLOBAL_PROPERTY;
    THHGlobalProperty = tagHH_GLOBAL_PROPERTY;

//========================
//
// Hherror.h --- HTML Help API errors
// Published: http://support.microsoft.com/default.aspx?scid=kb;en-us;297768

{ Translated from HHERROR.H }

Type

  { HH_LAST_ERROR Command Related structures and constants
    Used by command HH_GET_LAST_ERROR
    You must call SysFreeString(xx.description) to free BSTR
  }
    tagHH_LAST_ERROR = Packed Record
        cbStruct: Integer;     // sizeof this structure
        hr: HRESULT;     // Specifies the last error code.
        description: PWideChar;
        // (BSTR) Specifies a Unicode string containing a description of the error.
    End;
    HH_LAST_ERROR = tagHH_LAST_ERROR;
    THHLastError = tagHH_LAST_ERROR;


// Error codes
// MAKE_HRESULT(sev,fac,code) \HRESULT) (((unsigned long)(sev)<<31) | ((unsigned long)(fac)<<16) | ((unsigned long)(code))) )
Const
    HH_E_FILENOTFOUND: HResult =
        HResult(SEVERITY_ERROR Shl 31) Or (FACILITY_ITF Shl 16) Or $0201;
    // %1 could not be found.
    HH_E_TOPICDOESNOTEXIST: HResult =
        HResult(SEVERITY_ERROR Shl 31) Or (FACILITY_ITF Shl 16) Or $0202;
    // The requested topic does not exist.
    HH_E_INVALIDHELPFILE: HResult =
        HResult(SEVERITY_ERROR Shl 31) Or (FACILITY_ITF Shl 16) Or $0203;
    // %1 is not a valid help file.
    HH_E_NOCONTEXTIDS: HResult =
        HResult(SEVERITY_ERROR Shl 31) Or (FACILITY_ITF Shl 16) Or $020A;
    // Help file does not contain context ids.
    HH_E_CONTEXTIDDOESNTEXIT: HResult =
        HResult(SEVERITY_ERROR Shl 31) Or (FACILITY_ITF Shl 16) Or $020B;
    // The context id does not exist.

    // 0x0300 - 0x03FF reserved for keywords
    HH_E_KEYWORD_NOT_FOUND: HResult =
        HResult(SEVERITY_ERROR Shl 31) Or (FACILITY_ITF Shl 16) Or $0300;
    // no hits found.
    HH_E_KEYWORD_IS_PLACEHOLDER: HResult =
        HResult(SEVERITY_ERROR Shl 31) Or (FACILITY_ITF Shl 16) Or $0301;
    // keyword is a placeholder or a "runaway" see also.
    HH_E_KEYWORD_NOT_IN_SUBSET: HResult =
        HResult(SEVERITY_ERROR Shl 31) Or (FACILITY_ITF Shl 16) Or $0302;
    // no hits found because of subset exclusion.
    HH_E_KEYWORD_NOT_IN_INFOTYPE: HResult =
        HResult(SEVERITY_ERROR Shl 31) Or (FACILITY_ITF Shl 16) Or $0303;
    // no hits found because of infotype exclusion.
    HH_E_KEYWORD_EXCLUDED: HResult =
        HResult(SEVERITY_ERROR Shl 31) Or (FACILITY_ITF Shl 16) Or $0304;
    // no hits found because of infotype and subset exclusion.
    HH_E_KEYWORD_NOT_SUPPORTED: HResult =
        HResult(SEVERITY_ERROR Shl 31) Or (FACILITY_ITF Shl 16) Or $0305;
// no hits found because of keywords not being supported in this mode.


Implementation


{Return Windows System Dir - with no trailing slash}
Function GetWinSysDir: String;
Var path: Array[0..260] Of Char;
Begin
    GetSystemDirectory(path, SizeOf(path));
    result := path;
    If result[length(result)] = '\' Then
        SetLength(result, length(result) - 1);
End;

{Return Windows Dir - with no trailing slash}
Function GetWinDir: String;
Var path: Array[0..260] Of Char;
Begin
    GetWindowsDirectory(path, SizeOf(path));
    result := path;
    If result[length(result)] = '\' Then
        SetLength(result, length(result) - 1);
End;

Const hhPathRegKey =
        'CLSID\{adb880a6-d8ff-11cf-9377-00aa003b7a11}\InprocServer32';

//Expand %SystemRoot% -> c:\windows
//Fix for Windows Vista
Procedure ExpandSystemRoot(Var s: String);
Var L: Integer;
Begin
    L := length('%SystemRoot%');
    If (Length(s) >= L)
        And (s[1] = '%')
        And (s[2] In ['s', 'S'])
        And (s[3] In ['y', 'Y'])
        And (s[4] In ['s', 'S'])
        And (s[5] In ['t', 'T'])
        And (s[6] In ['e', 'E'])
        And (s[7] In ['m', 'M'])
        And (s[8] In ['r', 'R'])
        And (s[9] In ['o', 'O'])
        And (s[10] In ['o', 'O'])
        And (s[11] In ['t', 'T'])
        And (s[12] = '%') Then
        s := GetWinDir + Copy(s, L + 1, maxint);
End;

{ Returns full path to hhctrl.ocx.
  Returns empty string if file or registry entry not found.
  Note: hhctrl.ocx may not be in the path. Consider the case where
        the ocx has been downloaded to the windows ocx cache via the net.
        So.. best to get the path from the registry.
  Note: Delphi 2 and 3 do not support reg.OpenKeyReadOnly()
        and to access the registry as RW mode under NT (as non admin user) will cause
        an access violation. Best to simply return the ocx path to system folder.
        In 99.9% of cases this will be correct.
}
Function GetPathToHHCtrlOCX: String;
{$IFDEF D4PLUS} // -- Delphi >=4 ------------
var Reg: TRegistry;
{$ENDIF}
Begin
    result := '';  //default return
{$IFDEF D4PLUS} // -- Delphi >=4 ------------
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CLASSES_ROOT;
  if Reg.OpenKeyReadOnly(hhPathRegKey) then  //safer call under NT
  begin
    result := Reg.ReadString('');  //default value
    Reg.CloseKey;

    ExpandSystemRoot(result);   // %SystemRoot%  --> Windows dir
    if (result <> '') and (not FileExists(result)) then  //final check - file must exist
      result := '';
  end;
  Reg.Free;
{$ENDIF}
    If result = '' Then
        result := GetWinSysDir + '\' + hhctrlLib;
End;


{setup HTML Help API function interface
 sets HHCtrlHandle = 0 if API function not available }
Procedure LoadHtmlHelp;
Var OcxPath: String;
Begin
    If HHCtrlHandle = 0 Then
    Begin
        // v1.9 -- Normally 'hhctrl.ocx' is in the Windows search path
        HHCtrlHandle := LoadLibrary(hhctrlLib);

        //Not found? Unlikely! Try looking it up in the registry
        If (HHCtrlHandle = 0) Then
        Begin
            OcxPath := GetPathToHHCtrlOCX;
            If (OcxPath <> '') And FileExists(OcxPath) Then
                HHCtrlHandle := LoadLibrary(Pchar(OcxPath));
        End;

        If HHCtrlHandle <> 0 Then
        Begin
            @HtmlHelpA := GetProcAddress(HHCtrlHandle, 'HtmlHelpA');
            @HtmlHelpW := GetProcAddress(HHCtrlHandle, 'HtmlHelpW');
            @HtmlHelp := GetProcAddress(HHCtrlHandle, 'HtmlHelpA');
        End;
    End;
End;

Procedure UnloadHtmlHelp;
Begin
    If HHCtrlHandle <> 0 Then
    Begin
        FreeLibrary(HHCtrlHandle);
        @HtmlHelpA := Nil;
        @HtmlHelpW := Nil;
        @HtmlHelp := Nil;
        HHCtrlHandle := 0;
    End;
End;

Initialization
    If AutoLoadAPI Then
        LoadHtmlHelp;
Finalization
    UnloadHtmlHelp;
End.
