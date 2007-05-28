unit iplugin;

interface

uses
    Classes, Forms, ExtCtrls, Windows, Controls, ComCtrls;
const
	IID_IPlug_In: TGUID = '{C9E8FCF9-BEBD-4A51-80C1-16AF5197BBB3}';
type

  IPlug_In = interface(IInterface) ['{C9E8FCF9-BEBD-4A51-80C1-16AF5197BBB3}']
    procedure StartUp(name: String; module: HModule; _parent: HWND; _owner: TControlBar; _wowner: TWinControl; toolbar_x: Integer; toolbar_y: Integer);
    procedure CutExecute;
    procedure CopyExecute;
    procedure PasteExecute;
    procedure Terminate;
    procedure DisableDesignerControls;
    procedure OnToolbarEvent(WM_COMMAND: Word);    
    //procedure SetPnlBrowsersVisible(b: Boolean);
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
    //procedure Activate(FileName: String);
    function IsSource(FileName: String): Boolean;
    function GetDefaultText(FileName: String): String;	
    function GetFilter(editorName: String): String;
    function Get_EXT(editorName: String): String;
    procedure GenerateXPM(s:String);
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
  end;


implementation

end.

