unit iplugin;

interface

uses
    Classes, Forms, ExtCtrls, Windows, Controls, ComCtrls;
const
	IID_IPlug_In: TGUID = '{C9E8FCF9-BEBD-4A51-80C1-16AF5197BBB3}';
type

  IPlug_In = interface(IInterface) ['{C9E8FCF9-BEBD-4A51-80C1-16AF5197BBB3}']
  
	//Startup and shutdown
  procedure Create(name: String; module: HModule; _parent: HWND; _owner: TControlBar; _wowner: TWinControl; toolbar_x: Integer; toolbar_y: Integer);
  procedure Destroy;

  //Properties
  function GetPluginName: String;
  function IsDelphiPlugin: Boolean;

  // Replace with <Object> is IPluginDesigner?? Does the is operator support this?
  function IsCurrentPageDesigner: Boolean;

  function GetChild: HWND;

  // This function should be not broadcasted to all plugins; only on a plugin-profile
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
  function ConvertLibsToCurrentVersion(strValue: String): String;
  function GetXMLExtension: String;
  function EditorDisplaysText(FileName: String): Boolean;
  function GetTextHighlighterType(FileName: String): String;
  function GET_COMMON_CPP_INCLUDE_DIR: String;  // EAB TODO: Generalize this.

  procedure CutExecute;
  procedure CopyExecute;
  procedure PasteExecute;
end;


implementation

end.

