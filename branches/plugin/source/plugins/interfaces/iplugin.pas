unit iplugin;

interface

uses
    Classes, Forms, ExtCtrls, Windows, Controls, ComCtrls;
const
	IID_IPlug_In: TGUID = '{C9E8FCF9-BEBD-4A51-80C1-16AF5197BBB3}';
type

  IPlug_In = interface(IInterface) ['{C9E8FCF9-BEBD-4A51-80C1-16AF5197BBB3}']
  
	// Change to Create
    procedure StartUp(name: String; module: HModule; _parent: HWND; _owner: TControlBar; _wowner: TWinControl; toolbar_x: Integer; toolbar_y: Integer);
    procedure CutExecute;
    procedure CopyExecute;
    procedure PasteExecute;
	
	//Change to Destroy
    procedure Terminate;
	
	//Remove
    procedure DisableDesignerControls;
    procedure OnToolbarEvent(WM_COMMAND: Word);    
	
	// Move these 2 to a initialization code inside wxdesigner, before the Retrieve_Form_Items call
    procedure SetBoolInspectorDataClear(b: Boolean);
    procedure SetDisablePropertyBuilding(b: Boolean);	
	
	
    function IsCurrentPageDesigner: Boolean;
    function IsDelphiPlugin: Boolean;
    function GetChild: HWND;
	function HasDesigner(editorName: String): Boolean;
	
    function SaveFileAndCloseEditor(s: String; b: Boolean): Boolean;
    procedure Init(strFileName: String);
    procedure OpenFile(s: String);
    procedure OpenUnit(s: String);
    function IsForm(s: String): Boolean;
    function SaveFile(s: String; var pluginFileExist: Boolean): Boolean;	

    function IsSource(FileName: String): Boolean;
    function GetDefaultText(FileName: String): String;	
    function GetFilter(editorName: String): String;
    function Get_EXT(editorName: String): String;
    procedure GenerateXPM(s:String; b: Boolean);
	procedure CreateNewXPMs(strFileName:String);
    procedure NewProject(s: String);
    function MainPageChanged(askIfShouldGetFocus: Boolean; FileName: String): Boolean;	
	function IsCurrentEditorInPlugin(FileName: String; curFilename: String): Boolean;
    procedure Reload(FileName: String);
	function  ReloadForm(FileName: String): Boolean;
    procedure ReloadFromFile(FileName: String; fileToReloadFrom: String);
    procedure TerminateEditor(FileName: String);
    function Retrieve_Form_Items: TList;	    
	function Retrieve_Tabbed_LeftDock_Panels: TList;
	function Retrieve_LeftDock_Panels: TList;
	function Retrieve_Toolbars: TToolBar;	
    function GetPluginName: String;
	function ConvertLibsToCurrentVersion(strValue: String): String;
	function GetXMLExtension: String;
	function EditorDisplaysText(FileName: String): Boolean;
	function GetTextHighlighterType(FileName: String): String;
	function GET_COMMON_CPP_INCLUDE_DIR: String;  // EAB TODO: Generalize this.
  end;


implementation

end.

