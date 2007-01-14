object MainForm: TMainForm
  Left = 356
  Top = 123
  Width = 636
  Height = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnContextPopup = FormContextPopup
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object devFileMonitor: TdevFileMonitor
    Left = 0
    Top = 0
    Width = 30
    Height = 30
    Active = True
    OnNotifyChange = devFileMonitorNotifyChange
  end
  object MessageControl: TPageControl
    Left = 0
    Top = 240
    Width = 622
    Height = 130
    ActivePage = TodoSheet
    Align = alBottom
    Constraints.MinHeight = 1
    Images = dmMain.MenuImages_Gnome
    MultiLine = True
    PopupMenu = MessagePopup
    TabOrder = 0
    object CompSheet: TTabSheet
      BorderWidth = 2
      Caption = 'Compiler'
      ImageIndex = 28
      object CompilerOutput: TListView
        Left = 0
        Top = 0
        Width = 610
        Height = 98
        Align = alClient
        BevelOuter = bvRaised
        BevelKind = bkSoft
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'Line'
          end
          item
            Caption = 'Unit'
            Width = 200
          end
          item
            Caption = 'Message'
            Width = 480
          end>
        ColumnClick = False
        GridLines = True
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        ParentShowHint = False
        PopupMenu = MessagePopup
        ShowHint = True
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = CompilerOutputDblClick
        OnKeyDown = CompilerOutputKeyDown
      end
    end
    object ResSheet: TTabSheet
      BorderWidth = 2
      Caption = 'Resource'
      ImageIndex = 2
      object ResourceOutput: TListBox
        Left = 0
        Top = 0
        Width = 610
        Height = 98
        Align = alClient
        BevelKind = bkSoft
        BorderStyle = bsNone
        ItemHeight = 13
        ParentShowHint = False
        PopupMenu = MessagePopup
        ShowHint = True
        TabOrder = 0
      end
    end
    object LogSheet: TTabSheet
      BorderWidth = 2
      Caption = 'Compile log'
      ImageIndex = 43
      object InfoGroupBox: TGroupBox
        Left = 0
        Top = 0
        Width = 225
        Height = 98
        Align = alLeft
        Caption = 'Information :'
        TabOrder = 0
        object ErrorLabel: TLabel
          Left = 8
          Top = 20
          Width = 56
          Height = 13
          Caption = 'Total errors:'
        end
        object SizeOfOutput: TLabel
          Left = 8
          Top = 44
          Width = 84
          Height = 13
          Caption = 'Size of output file:'
        end
        object btnAbortCompilation: TSpeedButton
          Left = 8
          Top = 64
          Width = 209
          Height = 20
          Action = actAbortCompilation
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object SizeFile: TEdit
          Left = 96
          Top = 40
          Width = 121
          Height = 21
          ReadOnly = True
          TabOrder = 1
          Text = '0'
        end
        object TotalErrors: TEdit
          Left = 96
          Top = 16
          Width = 121
          Height = 21
          ReadOnly = True
          TabOrder = 0
          Text = '0'
        end
      end
      object CompResGroupBox: TGroupBox
        Left = 225
        Top = 0
        Width = 385
        Height = 98
        Align = alClient
        Caption = 'Compile log :'
        TabOrder = 1
        DesignSize = (
          385
          98)
        object LogOutput: TMemo
          Left = 7
          Top = 16
          Width = 359
          Height = 80
          Anchors = [akLeft, akTop, akRight, akBottom]
          PopupMenu = MessagePopup
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object DebugSheet: TTabSheet
      BorderWidth = 2
      Caption = 'Debugging'
      ImageIndex = 32
      object DebugSubPages: TPageControl
        Left = 0
        Top = 0
        Width = 610
        Height = 98
        ActivePage = tabDebugOutput
        Align = alClient
        TabOrder = 0
        object tabBacktrace: TTabSheet
          Caption = 'Stack Trace'
          ImageIndex = 1
          object lvBacktrace: TListView
            Left = 0
            Top = 0
            Width = 602
            Height = 70
            Align = alClient
            Columns = <
              item
                Caption = 'Function name'
                Width = 150
              end
              item
                Caption = 'Arguments'
                Width = 250
              end
              item
                Caption = 'Filename'
                Width = 150
              end
              item
                Caption = 'Line'
              end>
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnCustomDrawItem = lvBacktraceCustomDrawItem
            OnDblClick = lvBacktraceDblClick
            OnMouseMove = lvBacktraceMouseMove
          end
        end
        object tabLocals: TTabSheet
          Caption = 'Local Variables'
          ImageIndex = 3
          object lvLocals: TListView
            Left = 0
            Top = 0
            Width = 602
            Height = 70
            Align = alClient
            Columns = <
              item
                Caption = 'Name'
                Width = 200
              end
              item
                Caption = 'Value'
                Width = 325
              end
              item
                Caption = 'Location'
                Width = 75
              end>
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object tabThreads: TTabSheet
          Caption = 'Threads'
          ImageIndex = 3
          object lvThreads: TListView
            Left = 0
            Top = 0
            Width = 602
            Height = 70
            Align = alClient
            Columns = <
              item
                Width = 25
              end
              item
                Caption = 'Index'
              end
              item
                Caption = 'Thread ID'
                Width = 575
              end>
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnDblClick = lvThreadsDblClick
          end
        end
        object tabWatches: TTabSheet
          Caption = 'Watches'
          ImageIndex = -1
          object DebugTree: TTreeView
            Left = 0
            Top = 0
            Width = 602
            Height = 70
            Align = alClient
            Images = dmMain.MenuImages_NewLook
            Indent = 19
            MultiSelectStyle = []
            PopupMenu = DebugVarsPopup
            ReadOnly = True
            RightClickSelect = True
            TabOrder = 0
            OnKeyDown = DebugTreeKeyDown
          end
        end
        object tabDebugOutput: TTabSheet
          Caption = 'Output'
          ImageIndex = 2
          object DebugOutput: TMemo
            Left = 0
            Top = 22
            Width = 606
            Height = 47
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            PopupMenu = MessagePopup
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object DebuggerCmdPanel: TPanel
            Left = 0
            Top = 0
            Width = 606
            Height = 22
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object lblSendCommandDebugger: TLabel
              Left = 0
              Top = 2
              Width = 137
              Height = 13
              Caption = 'Send command to debugger:'
            end
            object edCommand: TEdit
              Left = 160
              Top = 0
              Width = 285
              Height = 21
              TabOrder = 0
              OnKeyPress = edCommandKeyPress
            end
            object btnSendCommand: TButton
              Left = 450
              Top = 0
              Width = 62
              Height = 21
              Caption = 'Send'
              TabOrder = 1
              OnClick = btnSendCommandClick
            end
          end
        end
      end
    end
    object FindSheet: TTabSheet
      BorderWidth = 2
      Caption = 'Find results'
      ImageIndex = 21
      object FindOutput: TListView
        Left = 0
        Top = 0
        Width = 610
        Height = 98
        Align = alClient
        BevelOuter = bvRaised
        BevelKind = bkSoft
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'Line'
            Width = 40
          end
          item
            Caption = 'Col'
            MinWidth = 20
            Width = 40
          end
          item
            Caption = 'Unit'
            Width = 200
          end
          item
            Caption = 'Message'
            Width = 450
          end>
        ColumnClick = False
        GridLines = True
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        ParentShowHint = False
        PopupMenu = MessagePopup
        ShowHint = True
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = FindOutputDblClick
        OnKeyDown = FindOutputKeyDown
      end
    end
    object TodoSheet: TTabSheet
      Caption = 'To-Do List'
      ImageIndex = 5
      object lvTodo: TListView
        Left = 0
        Top = 0
        Width = 614
        Height = 61
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Width = 24
          end
          item
            Caption = 'Priority'
          end
          item
            Caption = 'Description'
            Width = 224
          end
          item
            Caption = 'Filename'
            Width = 150
          end
          item
            Caption = 'User'
            Width = 90
          end>
        ReadOnly = True
        RowSelect = True
        SortType = stBoth
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = lvTodoColumnClick
        OnCompare = lvTodoCompare
        OnCustomDrawItem = lvTodoCustomDrawItem
        OnDblClick = lvTodoDblClick
        OnMouseDown = lvTodoMouseDown
      end
      object TodoSettings: TPanel
        Left = 0
        Top = 61
        Width = 614
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          614
          41)
        object lblTodoFilter: TLabel
          Left = 6
          Top = 5
          Width = 25
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Filter:'
        end
        object chkTodoIncomplete: TCheckBox
          Left = 6
          Top = 25
          Width = 289
          Height = 16
          Anchors = [akLeft, akBottom]
          Caption = 'Don'#39't show items marked as done'
          TabOrder = 0
          OnClick = chkTodoIncompleteClick
        end
        object cmbTodoFilter: TComboBox
          Left = 37
          Top = 2
          Width = 245
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akBottom]
          ItemHeight = 13
          ItemIndex = 5
          TabOrder = 1
          Text = 'Current file only'
          OnChange = cmbTodoFilterChange
          Items.Strings = (
            'All files (in project and not)'
            'Open files only (in project and not)'
            'All project files'
            'Open project files only'
            'Non-project open files'
            'Current file only')
        end
      end
    end
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 16
    Width = 622
    Height = 86
    Align = alTop
    AutoDock = False
    AutoSize = True
    BevelInner = bvSpace
    RowSize = 28
    TabOrder = 1
    OnContextPopup = ControlBar1ContextPopup
    object tbMain: TToolBar
      Left = 11
      Top = 2
      Width = 177
      Height = 22
      AutoSize = True
      Caption = 'Main'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Wrapable = False
      object NewProjectBtn: TToolButton
        Left = 0
        Top = 0
        Action = actNewProject
      end
      object OpenBtn: TToolButton
        Left = 23
        Top = 0
        Action = actOpen
      end
      object ToolButton3: TToolButton
        Left = 46
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object NewFileBtn: TToolButton
        Left = 54
        Top = 0
        Action = actNewSource
      end
      object SaveUnitBtn: TToolButton
        Left = 77
        Top = 0
        Action = actSave
      end
      object SaveAllBtn: TToolButton
        Left = 100
        Top = 0
        Action = actSaveAll
      end
      object CloseBtn: TToolButton
        Left = 123
        Top = 0
        Action = actClose
      end
      object ToolButton7: TToolButton
        Left = 146
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object PrintBtn: TToolButton
        Left = 154
        Top = 0
        Action = actPrint
      end
    end
    object tbCompile: TToolBar
      Left = 11
      Top = 30
      Width = 130
      Height = 22
      AutoSize = True
      Caption = 'Compile and Run'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Wrapable = False
      object CompileBtn: TToolButton
        Left = 0
        Top = 0
        Action = actCompile
      end
      object RebuildAllBtn: TToolButton
        Left = 23
        Top = 0
        Action = actRebuild
      end
      object ToolButton2: TToolButton
        Left = 46
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 49
        Style = tbsSeparator
      end
      object CompileAndRunBtn: TToolButton
        Left = 54
        Top = 0
        Action = actCompRun
      end
      object RunBtn: TToolButton
        Left = 77
        Top = 0
        Action = actRun
      end
      object ProgramResetBtn: TToolButton
        Left = 100
        Top = 0
        Action = actProgramReset
      end
    end
    object tbOptions: TToolBar
      Left = 317
      Top = 30
      Width = 46
      Height = 22
      AutoSize = True
      Caption = 'Options and help'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Wrapable = False
      object HelpBtn: TToolButton
        Left = 0
        Top = 0
        ImageIndex = 46
        OnClick = HelpBtnClick
      end
      object AboutBtn: TToolButton
        Left = 23
        Top = 0
        Action = actAbout
      end
    end
    object tbProject: TToolBar
      Left = 375
      Top = 2
      Width = 78
      Height = 22
      AutoSize = True
      Caption = 'Project'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Wrapable = False
      object AddToProjectBtn: TToolButton
        Left = 0
        Top = 0
        Action = actProjectAdd
      end
      object RemoveFromProjectBtn: TToolButton
        Left = 23
        Top = 0
        Action = actProjectRemove
      end
      object ToolButton20: TToolButton
        Left = 46
        Top = 0
        Width = 8
        Caption = 'ToolButton20'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object ProjectOptionsBtn: TToolButton
        Left = 54
        Top = 0
        Action = actProjectOptions
      end
    end
    object tbEdit: TToolBar
      Left = 201
      Top = 2
      Width = 47
      Height = 22
      AutoSize = True
      Caption = 'Edit'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Wrapable = False
      object UndoBtn: TToolButton
        Left = 0
        Top = 0
        Action = actUndo
      end
      object RedoBtn: TToolButton
        Left = 23
        Top = 0
        Action = actRedo
      end
    end
    object tbSearch: TToolBar
      Left = 261
      Top = 2
      Width = 101
      Height = 22
      AutoSize = True
      Caption = 'Search'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Wrapable = False
      object Findbtn: TToolButton
        Left = 0
        Top = 0
        Action = actFind
      end
      object Replacebtn: TToolButton
        Left = 23
        Top = 0
        Action = actReplace
      end
      object FindNextbtn: TToolButton
        Left = 46
        Top = 0
        Action = actFindNext
      end
      object ToolButton12: TToolButton
        Left = 69
        Top = 0
        Width = 8
        Caption = 'ToolButton12'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object GotoLineBtn: TToolButton
        Left = 77
        Top = 0
        Action = actGoto
      end
    end
    object tbSpecials: TToolBar
      Left = 376
      Top = 30
      Width = 231
      Height = 22
      AutoSize = True
      ButtonWidth = 60
      Caption = 'Specials'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.SpecialImages_Gnome
      List = True
      ShowCaptions = True
      TabOrder = 6
      Wrapable = False
      object NewAllBtn: TToolButton
        Left = 0
        Top = 0
        Caption = 'New'
        ImageIndex = 0
        OnClick = NewAllBtnClick
      end
      object InsertBtn: TToolButton
        Left = 60
        Top = 0
        Caption = 'Insert'
        ImageIndex = 1
        OnClick = InsertBtnClick
      end
      object ToggleBtn: TToolButton
        Left = 120
        Top = 0
        Caption = 'Toggle'
        ImageIndex = 2
        OnClick = ToggleBtnClick
      end
      object GotoBtn: TToolButton
        Left = 180
        Top = 0
        Caption = 'Goto'
        ImageIndex = 3
        OnClick = GotoBtnClick
      end
    end
    object tbClasses: TToolBar
      Left = 11
      Top = 58
      Width = 466
      Height = 22
      AutoSize = True
      Caption = 'Classes'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      object cmbClasses: TComboBox
        Left = 0
        Top = 0
        Width = 232
        Height = 22
        Style = csDropDownList
        DropDownCount = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        Sorted = True
        TabOrder = 0
        OnChange = cmbClassesChange
      end
      object cmbMembers: TComboBox
        Left = 232
        Top = 0
        Width = 232
        Height = 22
        Style = csDropDownList
        DropDownCount = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        Sorted = True
        TabOrder = 1
        OnChange = cmbMembersChange
      end
    end
    object tbDebug: TToolBar
      Left = 154
      Top = 30
      Width = 150
      Height = 22
      AutoSize = True
      Caption = 'Debug'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Wrapable = False
      object DebugBtn: TToolButton
        Left = 0
        Top = 0
        Action = actDebug
      end
      object DebugPauseBtn: TToolButton
        Left = 23
        Top = 0
        Action = actPauseDebug
      end
      object DebugStopBtn: TToolButton
        Left = 46
        Top = 0
        Action = actStopExecute
      end
      object DebugRestartBtn: TToolButton
        Left = 69
        Top = 0
        Action = actRestartDebug
      end
      object ToolButton1: TToolButton
        Left = 92
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 33
        Style = tbsSeparator
      end
      object DebugStepOver: TToolButton
        Left = 100
        Top = 0
        Action = actStepOver
      end
      object DebugStepInto: TToolButton
        Left = 123
        Top = 0
        Action = actStepInto
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 370
    Width = 622
    Height = 19
    Panels = <
      item
        Width = 70
      end
      item
        Width = 50
      end
      item
        Width = 80
      end
      item
        Width = 100
      end
      item
        Style = psOwnerDraw
        Width = 135
      end>
    ParentFont = True
    UseSystemFont = False
    OnDrawPanel = StatusBarDrawPanel
  end
  object pnlFull: TPanel
    Left = 0
    Top = 0
    Width = 622
    Height = 16
    Align = alTop
    BevelOuter = bvNone
    Caption = 
      'Dev-C++ version 5.0 full screen press shift+F12 to toggle Toolba' +
      'rs or F12 to go to normal mode.'
    TabOrder = 3
    Visible = False
    DesignSize = (
      622
      16)
    object btnFullScrRevert: TSpeedButton
      Left = 607
      Top = 0
      Width = 14
      Height = 14
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDD77
        7777D00DDDD00D777777D000DD000D777777DD000000DD777777DDD0000DDD77
        7777DDD0000DDD777777DD000000DD777777D000DD000D777777D00DDDD00D77
        7777DDDDDDDDDD777777}
      ParentFont = False
      OnClick = btnFullScrRevertClick
    end
  end
  object prgFormProgress: TProgressBar
    Left = 488
    Top = 214
    Width = 134
    Height = 17
    TabOrder = 5
  end
  object LeftPageControl: TPageControl
    Left = 0
    Top = 102
    Width = 192
    Height = 138
    ActivePage = ProjectSheet
    Align = alLeft
    Images = dmMain.ProjectImage_NewLook
    TabOrder = 6
    object ProjectSheet: TTabSheet
      Caption = 'Project'
      ImageIndex = -1
      object ProjectView: TTreeView
        Left = 0
        Top = 0
        Width = 184
        Height = 110
        Align = alClient
        ChangeDelay = 1
        DragMode = dmAutomatic
        HideSelection = False
        HotTrack = True
        Images = dmMain.ProjectImage_Gnome
        Indent = 19
        MultiSelect = True
        MultiSelectStyle = [msControlSelect, msShiftSelect]
        ReadOnly = True
        RightClickSelect = True
        SortType = stText
        TabOrder = 0
        OnClick = ProjectViewClick
        OnCompare = ProjectViewCompare
        OnContextPopup = ProjectViewContextPopup
        OnDblClick = ProjectViewDblClick
        OnDragDrop = ProjectViewDragDrop
        OnDragOver = ProjectViewDragOver
        OnKeyDown = ProjectViewKeyDown
        OnKeyPress = ProjectViewKeyPress
        OnMouseDown = ProjectViewMouseDown
      end
    end
    object ClassSheet: TTabSheet
      Caption = 'Classes'
      ImageIndex = -1
      object ClassBrowser1: TClassBrowser
        Left = 0
        Top = 0
        Width = 184
        Height = 110
        Align = alClient
        Images = dmMain.ClassImages
        ReadOnly = True
        Indent = 19
        TabOrder = 0
        PopupMenu = BrowserPopup
        ShowFilter = sfAll
        OnSelect = ClassBrowser1Select
        Parser = CppParser1
        ItemImages.Globals = 0
        ItemImages.Classes = 1
        ItemImages.VariablePrivate = 2
        ItemImages.VariableProtected = 3
        ItemImages.VariablePublic = 4
        ItemImages.VariablePublished = 4
        ItemImages.MethodPrivate = 5
        ItemImages.MethodProtected = 6
        ItemImages.MethodPublic = 7
        ItemImages.MethodPublished = 7
        ItemImages.InheritedMethodProtected = 8
        ItemImages.InheritedMethodPublic = 10
        ItemImages.InheritedVariableProtected = 9
        ItemImages.InheritedVariablePublic = 11
        UseColors = True
        ShowInheritedMembers = False
      end
    end
  end
  object PageControl: TPageControl
    Left = 192
    Top = 102
    Width = 430
    Height = 138
    Align = alClient
    PopupMenu = EditorPopupMenu
    TabOrder = 7
    OnChange = PageControlChange
    OnChanging = PageControlChanging
    OnDragDrop = PageControlDragDrop
    OnDragOver = PageControlDragOver
    OnMouseDown = PageControlMouseDown
  end
  object HiddenSci: TScintilla
    Left = 496
    Top = 184
    Width = 25
    Height = 25
    Color = clGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -20
    Font.Name = 'Courier New'
    Font.Style = []
    Visible = False
    EOLStyle = eolCRLF
    Indentation = [KeepIndent, TabIndents, BackSpaceUnIndents, IndentationGuides]
    IndentWidth = 0
    MarginLeft = 1
    MarginRight = 1
    ReadOnly = True
    CodePage = cpAnsi
    Caret.ForeColor = clYellow
    Caret.LineBackColor = 9474192
    Caret.LineVisible = True
    Caret.Width = 3
    Caret.Period = 500
    Caret.LineBackAlpha = 0
    DivOptions.ViewWSpace = sciWsInvisible
    DivOptions.UsePalette = False
    DivOptions.OverType = False
    DivOptions.ViewEOL = False
    DivOptions.EndAtLastLine = True
    DivOptions.ScrollBarH = True
    DivOptions.ScrollBarV = True
    ActiveHotSpot.BackColor = clDefault
    ActiveHotSpot.ForeColor = clAqua
    ActiveHotSpot.Underlined = True
    ActiveHotSpot.SingleLine = True
    Colors.SelFore = clHighlightText
    Colors.SelBack = clHighlight
    Colors.MarkerFore = 26367
    Colors.MarkerBack = 13209
    Colors.FoldHi = clBlack
    Colors.FoldLo = clBlack
    Colors.WhiteSpaceFore = clYellow
    Colors.WhiteSpaceBack = clDefault
    Bookmark.BackColor = clDefault
    Bookmark.ForeColor = clDefault
    Bookmark.MarkerType = sciMCircle
    ClearUndoAfterSave = True
    Gutter0.Width = 32
    Gutter0.MarginType = gutLineNumber
    Gutter0.Sensitive = False
    Gutter1.Width = 16
    Gutter1.MarginType = gutSymbol
    Gutter1.Sensitive = False
    Gutter2.Width = 14
    Gutter2.MarginType = gutSymbol
    Gutter2.Sensitive = True
    Gutter3.Width = 0
    Gutter3.MarginType = gutSymbol
    Gutter3.Sensitive = False
    Gutter4.Width = 0
    Gutter4.MarginType = gutSymbol
    Gutter4.Sensitive = False
    WordWrapVisualFlags = []
    WordWrapVisualFlagsLocation = []
    LayoutCache = sciCacheCaret
    HideSelect = False
    WordWrap = sciNoWrap
    EdgeColumn = 200
    EdgeColor = clSilver
    WordChars = '_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    ControlCharSymbol = #0
    Folding = [foldFold, foldCompact, foldComment, foldPreprocessor, foldAtElse, foldHTML, foldHTMLPreProcessor]
    FoldMarkers.MarkerType = sciMarkCustom
    FoldMarkers.FoldOpen.BackColor = clDefault
    FoldMarkers.FoldOpen.ForeColor = clDefault
    FoldMarkers.FoldOpen.MarkerType = sciMArrowDown
    FoldMarkers.FoldClosed.BackColor = clDefault
    FoldMarkers.FoldClosed.ForeColor = clDefault
    FoldMarkers.FoldClosed.MarkerType = sciMArrow
    FoldMarkers.FoldSub.BackColor = clDefault
    FoldMarkers.FoldSub.ForeColor = clDefault
    FoldMarkers.FoldSub.MarkerType = sciMEmpty
    FoldMarkers.FoldTail.BackColor = clDefault
    FoldMarkers.FoldTail.ForeColor = clDefault
    FoldMarkers.FoldTail.MarkerType = sciMEmpty
    FoldMarkers.FoldEnd.BackColor = clDefault
    FoldMarkers.FoldEnd.ForeColor = clDefault
    FoldMarkers.FoldEnd.MarkerType = sciMEmpty
    FoldMarkers.FoldOpenMid.BackColor = clDefault
    FoldMarkers.FoldOpenMid.ForeColor = clDefault
    FoldMarkers.FoldOpenMid.MarkerType = sciMEmpty
    FoldMarkers.FoldMidTail.BackColor = clDefault
    FoldMarkers.FoldMidTail.ForeColor = clDefault
    FoldMarkers.FoldMidTail.MarkerType = sciMEmpty
    LanguageManager.LanguageList = <
      item
        Name = 'null'
        Lexer = 'null'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'ADA'
        Lexer = 'ADA'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifiers'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators (delimiters)'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Character'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'End of line where character is not closed'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'End of line where string is not closed'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 127
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Label'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Illegal token'
            StyleNumber = 11
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'abort'
              'abstract'
              'accept'
              'access'
              'aliased'
              'all'
              'array'
              'at'
              'begin'
              'body'
              'case'
              'constant'
              'declare'
              'delay'
              'delta'
              'digits'
              'do'
              'else'
              'elsif'
              'end'
              'entry'
              'exception'
              'exit'
              'for'
              'function'
              'generic'
              'goto'
              'if'
              'in'
              'is'
              'limited'
              'loop'
              'new'
              'null'
              'of'
              'others'
              'out'
              'package'
              'pragma'
              'private'
              'procedure'
              'protected'
              'raise'
              'range'
              'record'
              'renames'
              'requeue'
              'return'
              'reverse'
              'select'
              'separate'
              'subtype'
              'tagged'
              'task'
              'terminate'
              'then'
              'type'
              'until'
              'use'
              'when'
              'while'
              'with'
              'abs'
              'and'
              'mod'
              'not'
              'or'
              'rem'
              'xor')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '--'
        CommentBoxEnd = '--'
        CommentBoxMiddle = '--'
        CommentBlock = '--'
        CommentAtLineStart = True
        CommentStreamStart = '--'
        CommentStreamEnd = '--'
        NumStyleBits = 5
      end
      item
        Name = 'Apache Config'
        Lexer = 'conf'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White Space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Apache Runtime Directive'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 49344
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'extensions (like .gz, .tgz, .html)'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'parameters for Apache Runtime directives'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12566272
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'IP address'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12632064
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 9
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Directives'
            Keywords.Strings = (
              'accessconfig'
              'accessfilename'
              'action'
              'addalt'
              'addaltbyencoding'
              'addaltbytype'
              'addcharset'
              'adddefaultcharset'
              'adddescription'
              'addencoding'
              'addhandler'
              'addicon'
              'addiconbyencoding'
              'addiconbytype'
              'addlanguage'
              'addmodule'
              'addmoduleinfo'
              'addtype'
              'agentlog'
              'alias'
              'aliasmatch'
              'allow'
              'allowconnect'
              'allowoverride'
              'anonymous'
              'anonymous_authoritative'
              'anonymous_logemail'
              'anonymous_mustgiveemail'
              'anonymous_nouserid'
              'anonymous_verifyemail'
              'authauthoritative'
              'authdbauthoritative'
              'authdbgroupfile'
              'authdbmauthoritative'
              'authdbmgroupfile'
              'authdbmgroupfile'
              'authdbuserfile'
              'authdbmuserfile'
              'authdigestfile'
              'authgroupfile'
              'authname'
              'authtype'
              'authuserfile'
              'bindaddress'
              'browsermatch'
              'browsermatchnocase'
              'bs2000account'
              'cachedefaultexpire'
              'cachedirlength'
              'cachedirlevels'
              'cacheforcecompletion'
              'cachegcinterval'
              'cachelastmodifiedfactor'
              'cachemaxexpire'
              'cachenegotiateddocs'
              'cacheroot'
              'cachesize'
              'checkspelling'
              'clearmodulelist'
              'contentdigest'
              'cookieexpires'
              'cookielog'
              'cookielog'
              'cookietracking'
              'coredumpdirectory'
              'customlog'
              'defaulticon'
              'defaultlanguage'
              'defaulttype'
              'define'
              'deny'
              'directory'
              'directorymatch'
              'directoryindex'
              'documentroot'
              'errordocument'
              'errorlog'
              'example'
              'expiresactive'
              'expiresbytype'
              'expiresdefault'
              'extendedstatus'
              'fancyindexing'
              'files'
              'filesmatch'
              'forcetype'
              'group'
              'header'
              'headername'
              'hostnamelookups'
              'identitycheck'
              'ifdefine'
              'ifmodule'
              'imapbase'
              'imapdefault'
              'imapmenu'
              'include'
              'indexignore'
              'indexoptions'
              'keepalive'
              'keepalivetimeout'
              'languagepriority'
              'limit'
              'limitexcept'
              'limitrequestbody'
              'limitrequestfields'
              'limitrequestfieldsize'
              'limitrequestline'
              'listen'
              'listenbacklog'
              'loadfile'
              'loadmodule'
              'location'
              'locationmatch'
              'lockfile'
              'logformat'
              'loglevel'
              'maxclients'
              'maxkeepaliverequests'
              'maxrequestsperchild'
              'maxspareservers'
              'metadir'
              'metafiles'
              'metasuffix'
              'mimemagicfile'
              'minspareservers'
              'mmapfile'
              'namevirtualhost'
              'nocache'
              'options'
              'order'
              'passenv'
              'pidfile'
              'port'
              'proxyblock'
              'proxydomain'
              'proxypass'
              'proxypassreverse'
              'proxyreceivebuffersize'
              'proxyremote'
              'proxyrequests'
              'proxyvia'
              'qsc'
              'readmename'
              'redirect'
              'redirectmatch'
              'redirectpermanent'
              'redirecttemp'
              'refererignore'
              'refererlog'
              'removehandler'
              'require'
              'resourceconfig'
              'rewritebase'
              'rewritecond'
              'rewriteengine'
              'rewritelock'
              'rewritelog'
              'rewriteloglevel'
              'rewritemap'
              'rewriteoptions'
              'rewriterule'
              'rlimitcpu'
              'rlimitmem'
              'rlimitnproc'
              'satisfy'
              'scoreboardfile'
              'script'
              'scriptalias'
              'scriptaliasmatch'
              'scriptinterpretersource'
              'scriptlog'
              'scriptlogbuffer'
              'scriptloglength'
              'sendbuffersize'
              'serveradmin'
              'serveralias'
              'servername'
              'serverpath'
              'serverroot'
              'serversignature'
              'servertokens'
              'servertype'
              'setenv'
              'setenvif'
              'setenvifnocase'
              'sethandler'
              'singlelisten'
              'startservers'
              'threadsperchild'
              'timeout'
              'transferlog'
              'typesconfig'
              'unsetenv'
              'usecanonicalname'
              'user'
              'userdir'
              'virtualhost'
              'virtualdocumentroot'
              'virtualdocumentrootip'
              'virtualscriptalias'
              'virtualscriptaliasip'
              'xbithack'
              'from'
              'all')
          end
          item
            KeywordListNumber = 1
            Name = 'Parameters'
            Keywords.Strings = (
              'on'
              'off'
              'standalone'
              'inetd'
              'force-response-1.0'
              'downgrade-1.0'
              'nokeepalive'
              'indexes'
              'includes'
              'followsymlinks'
              'none'
              'x-compress'
              'x-gzip')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '#'
        CommentBoxEnd = '#'
        CommentBoxMiddle = '#'
        CommentBlock = '#'
        CommentAtLineStart = True
        CommentStreamStart = '#'
        CommentStreamEnd = '#'
        NumStyleBits = 5
      end
      item
        Name = 'APDL'
        Lexer = 'apdl'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'CommentBlock'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Word'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Processor'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Command'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SlashCommand'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'StarCommand'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Argument'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Function'
            StyleNumber = 12
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Processors'
          end
          item
            KeywordListNumber = 1
            Name = 'Commands'
          end
          item
            KeywordListNumber = 2
            Name = 'SlashCommands'
          end
          item
            KeywordListNumber = 3
            Name = 'StarCommands'
          end
          item
            KeywordListNumber = 4
            Name = 'Arguments'
          end
          item
            KeywordListNumber = 5
            Name = 'Functions'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'ASM'
        Lexer = 'asm'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'CPU Instruction'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Math Instruction'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Register'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Directive'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Directive Operand'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment Block'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Character'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            Name = 'String not terminated'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Extended Instruction'
            StyleNumber = 14
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Processors'
          end
          item
            KeywordListNumber = 1
            Name = 'Commands'
          end
          item
            KeywordListNumber = 2
            Name = 'SlashCommands'
          end
          item
            KeywordListNumber = 3
            Name = 'StarCommands'
          end
          item
            KeywordListNumber = 4
            Name = 'Arguments'
          end
          item
            KeywordListNumber = 5
            Name = 'Functions'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = ';'
        CommentBoxEnd = ';'
        CommentBoxMiddle = ';'
        CommentBlock = ';'
        CommentAtLineStart = True
        CommentStreamStart = ';'
        CommentStreamEnd = ';'
        NumStyleBits = 5
      end
      item
        Name = 'ASN1'
        Lexer = 'asn1'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifiers'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 8355584
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Numeric OID definition'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Non OID numbers'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keywords'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12624032
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Attributes'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Descriptors'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Types'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 10
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'ACCESS'
              'AGENT'
              'AUGMENTS'
              'BEGIN'
              'BITS'
              'CAPABILITIES'
              'CHOICE'
              'COMPLIANCE'
              'CONTACT'
              'CONVENTION'
              'DEFINITIONS'
              'DEFVAL'
              'DESCRIPTION'
              'DISPLAY'
              'END'
              'ENTERPRISE'
              'EXPORTS'
              'FALSE'
              'FROM'
              'GROUP'
              'GROUPS'
              'HINT'
              'IDENTITY'
              'IMPLIED'
              'IMPORTS'
              'INCLUDES'
              'INDEX'
              'INFO'
              'LAST'
              'MANDATORY'
              'MAX'
              'MIN'
              'MODULE'
              'NOTATION'
              'NOTIFICATION'
              'NULL'
              'OBJECTS'
              'OBJECT-TYPE'
              'OF'
              'ORGANIZATION'
              'PRODUCT'
              'RELEASE'
              'REFERENCE'
              'REQUIRES'
              'REVISION'
              'SEQUENCE'
              'SIZE'
              'STATUS'
              'SUPPORTS'
              'SYNTAX'
              'TEXTUAL'
              'TRAP'
              'TYPE'
              'TRAP-TYPE'
              'UPDATED'
              'VALUE'
              'VARIABLES'
              'VARIATION'
              'WRITE')
          end
          item
            KeywordListNumber = 1
            Name = 'Attributes'
            Keywords.Strings = (
              'accessible'
              'create'
              'current'
              'deprecated'
              'for'
              'mandatory'
              'not'
              'notify'
              'not-accessible'
              'obsolete'
              'only'
              'optional'
              'read'
              'read-only'
              'read-write'
              'write')
          end
          item
            KeywordListNumber = 2
            Name = 'Descriptors'
            Keywords.Strings = (
              'ABSENT'
              'ANY'
              'APPLICATION'
              'BIT'
              'BOOLEAN'
              'BY'
              'COMPONENT'
              'COMPONENTS'
              'DEFAULT'
              'DEFINED'
              'ENUMERATED'
              'EXPLICIT'
              'EXTERNAL'
              'IMPLICIT'
              'INIFINITY'
              'MAX'
              'MIN'
              'MINUS'
              'OPTIONAL'
              'PRESENT'
              'PRIVATE'
              'REAL'
              'SET'
              'TAGS'
              'TRUE')
          end
          item
            KeywordListNumber = 3
            Name = 'Types'
            Keywords.Strings = (
              'Counter'
              'Counter32'
              'Counter64'
              'DisplayString'
              'Gauge'
              'Gauge32'
              'IDENTIFIER'
              'INTEGER'
              'Integer32'
              'IpAddress'
              'NetworkAddress'
              'NsapAddress'
              'OBJECT'
              'OCTET'
              'Opaque'
              'PhysAddress'
              'STRING'
              'TimeTicks'
              'UInteger32'
              'UNITS'
              'Unsigned32')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'AutoIt_3'
        Lexer = 'au3'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'WhiteSpace'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment Block'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 15728880
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Function'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keywords'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 16724991
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Macro'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clAqua
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Variable'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 35071
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Sent keys in string'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PreProcessor'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Special'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Expand'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ComObj'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'UDF'
            StyleNumber = 15
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'and'
              'byref'
              'case'
              'continueloop'
              'dim'
              'do'
              'else'
              'elseif'
              'endfunc'
              'endif'
              'endselect'
              'exit'
              'exitloop'
              'for'
              'func'
              'global'
              'if'
              'local'
              'next'
              'not'
              'or'
              'return'
              'select'
              'step'
              'then'
              'to'
              'until'
              'wend'
              'while'
              'exit')
          end
          item
            KeywordListNumber = 1
            Name = 'Functions'
            Keywords.Strings = (
              'abs'
              'acos'
              'adlibdisable'
              'adlibenable'
              'asc'
              'asin'
              'atan'
              'autoitsetoption'
              'autoitwingettitle'
              'autoitwinsettitle'
              'bitand'
              'bitnot'
              'bitor'
              'bitshift'
              'bitxor'
              'blockinput'
              'break'
              'call'
              'cdtray'
              'chr'
              'clipget'
              'clipput'
              'controlclick'
              'controlcommand'
              'controldisable'
              'controlenable'
              'controlfocus'
              'controlgetfocus'
              'controlgetpos'
              'controlgettext'
              'controlhide'
              'controlmove'
              'controlsend'
              'controlsettext'
              'controlshow'
              'cos'
              'dec'
              'dircopy'
              'dircreate'
              'dirmove'
              'dirremove'
              'drivegetdrive'
              'drivegetfilesystem'
              'drivegetlabel'
              'drivegetserial'
              'drivegettype'
              'drivesetlabel'
              'drivespacefree'
              'drivespacetotal'
              'drivestatus'
              'envget'
              'envset'
              'envupdate'
              'eval'
              'exp'
              'filechangedir'
              'fileclose'
              'filecopy'
              'filecreateshortcut'
              'filedelete'
              'fileexists'
              'filefindfirstfile'
              'filefindnextfile'
              'filegetattrib'
              'filegetlongname'
              'filegetshortname'
              'filegetsize'
              'filegettime'
              'filegetversion'
              'fileinstall'
              'filemove'
              'fileopen'
              'fileopendialog'
              'fileread'
              'filereadline'
              'filerecycle'
              'filerecycleempty'
              'filesavedialog'
              'fileselectfolder'
              'filesetattrib'
              'filesettime'
              'filewrite'
              'filewriteline'
              'guicreate'
              'guicreateex'
              'guidefaultfont'
              'guidelete'
              'guigetcontrolstate'
              'guihide'
              'guimsg'
              'guiread'
              'guirecvmsg'
              'guisendmsg'
              'guisetcontrol'
              'guisetcontroldata'
              'guisetcontrolex'
              'guisetcontrolfont'
              'guisetcontrolnotify'
              'guisetcoord'
              'guisetcursor'
              'guishow'
              'guiwaitclose'
              'guiwrite'
              'hex'
              'hotkeyset'
              'inidelete'
              'iniread'
              'iniwrite'
              'inputbox'
              'int'
              'isadmin'
              'isarray'
              'isdeclared'
              'isfloat'
              'isint'
              'isnumber'
              'isstring'
              'log'
              'memgetstats'
              'mod'
              'mouseclick'
              'mouseclickdrag'
              'mousedown'
              'mousegetcursor'
              'mousegetpos'
              'mousemove'
              'mouseup'
              'mousewheel'
              'msgbox'
              'number'
              'pixelchecksum'
              'pixelgetcolor'
              'pixelsearch'
              'processclose'
              'processexists'
              'processsetpriority'
              'processwait'
              'processwaitclose'
              'progressoff'
              'progresson'
              'progressset'
              'random'
              'regdelete'
              'regenumkey'
              'regenumval'
              'regread'
              'regwrite'
              'round'
              'run'
              'runasset'
              'runwait'
              'send'
              'seterror'
              'shutdown'
              'sin'
              'sleep'
              'soundplay'
              'soundsetwavevolume'
              'splashimageon'
              'splashoff'
              'splashtexton'
              'sqrt'
              'statusbargettext'
              'string'
              'stringaddcr'
              'stringformat'
              'stringinstr'
              'stringisalnum'
              'stringisalpha'
              'stringisascii'
              'stringisdigit'
              'stringisfloat'
              'stringisint'
              'stringislower'
              'stringisspace'
              'stringisupper'
              'stringisxdigit'
              'stringleft'
              'stringlen'
              'stringlower'
              'stringmid'
              'stringreplace'
              'stringright'
              'stringsplit'
              'stringstripcr'
              'stringstripws'
              'stringtrimleft'
              'stringtrimright'
              'stringupper'
              'tan'
              'timerstart'
              'timerstop'
              'tooltip'
              'traytip'
              'ubound'
              'urldownloadtofile'
              'winactivate'
              'winactive'
              'winclose'
              'winexists'
              'wingetcaretpos'
              'wingetclasslist'
              'wingetclientsize'
              'wingethandle'
              'wingetpos'
              'wingetstate'
              'wingettext'
              'wingettitle'
              'winkill'
              'winmenuselectitem'
              'winminimizeall'
              'winminimizeallundo'
              'winmove'
              'winsetontop'
              'winsetstate'
              'winsettitle'
              'winwait'
              'winwaitactive'
              'winwaitclose'
              'winwaitnotactive')
          end
          item
            KeywordListNumber = 2
            Name = 'Macros'
            Keywords.Strings = (
              '@appdatacommondir'
              '@appdatadir'
              '@autoitversion'
              '@commonfilesdir'
              '@compiled'
              '@computername'
              '@comspec'
              '@cr'
              '@crlf'
              '@desktopcommondir'
              '@desktopdir'
              '@desktopheight'
              '@desktopwidth'
              '@documentscommondir'
              '@error'
              '@favoritescommondir'
              '@favoritesdir'
              '@homedrive'
              '@homepath'
              '@homeshare'
              '@hour'
              '@ipaddress1'
              '@ipaddress2'
              '@ipaddress3'
              '@ipaddress4'
              '@lf'
              '@logondnsdomain'
              '@logondomain'
              '@logonserver'
              '@mday'
              '@min'
              '@mon'
              '@mydocumentsdir'
              '@osbuild'
              '@oslang'
              '@osservicepack'
              '@ostype'
              '@osversion'
              '@programfilesdir'
              '@programscommondir'
              '@programsdir'
              '@scriptdir'
              '@scriptfullpath'
              '@scriptname'
              '@sec'
              '@startmenucommondir'
              '@startmenudir'
              '@startupcommondir'
              '@startupdir'
              '@sw_hide'
              '@sw_maximize'
              '@sw_minimize'
              '@sw_restore'
              '@sw_show'
              '@systemdir'
              '@tab'
              '@tempdir'
              '@userprofiledir'
              '@username'
              '@wday'
              '@windowsdir'
              '@workingdir'
              '@yday'
              '@year')
          end
          item
            KeywordListNumber = 3
            Name = 'Sent Keys'
            Keywords.Strings = (
              '{!}'
              '{#}'
              '{^}'
              '{{}'
              '{}}'
              '{+}'
              '{alt}'
              '{altdown}'
              '{altup}'
              '{appskey}'
              '{asc}'
              '{backspace}'
              '{browser_back}'
              '{browser_favorites}'
              '{browser_forward}'
              '{browser_home}'
              '{browser_refresh}'
              '{browser_search}'
              '{browser_stop}'
              '{bs}'
              '{capslock}'
              '{ctrlbreak}'
              '{ctrldown}'
              '{ctrlup}'
              '{del}'
              '{delete}'
              '{down}'
              '{end}'
              '{enter}'
              '{esc}'
              '{escape}'
              '{f1}'
              '{f10}'
              '{f11}'
              '{f12}'
              '{f2}'
              '{f3}'
              '{f4}'
              '{f5}'
              '{f6}'
              '{f7}'
              '{f8}'
              '{f9}'
              '{home}'
              '{ins}'
              '{insert}'
              '{lalt}'
              '{launch_app1}'
              '{launch_app2}'
              '{launch_mail}'
              '{launch_media}'
              '{lctrl}'
              '{left}'
              '{lshift}'
              '{lwin}'
              '{lwindown}'
              '{media_next}'
              '{media_play_pause}'
              '{media_prev}'
              '{media_stop}'
              '{numlock}'
              '{numpad0}'
              '{numpad1}'
              '{numpad2}'
              '{numpad3}'
              '{numpad4}'
              '{numpad5}'
              '{numpad6}'
              '{numpad7}'
              '{numpad8}'
              '{numpad9}'
              '{numpadadd}'
              '{numpaddiv}'
              '{numpaddot}'
              '{numpadenter}'
              '{numpadmult}'
              '{numpadsub}'
              '{pause}'
              '{pgdn}'
              '{pgup}'
              '{printscreen}'
              '{ralt}'
              '{rctrl}'
              '{right}'
              '{rshift}'
              '{rwin}'
              '{rwindown}'
              '{scrolllock}'
              '{shiftdown}'
              '{shiftup}'
              '{sleep}'
              '{space}'
              '{tab}'
              '{up}'
              '{volume_down}'
              '{volume_mute}'
              '{volume_up}')
          end
          item
            KeywordListNumber = 4
            Name = 'Preprocessor'
            Keywords.Strings = (
              '#include'
              '#include-once')
          end
          item
            KeywordListNumber = 5
            Name = 'Special'
            Keywords.Strings = (
              '#region'
              '#endregion')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = ';'
        CommentBoxEnd = ';'
        CommentBoxMiddle = ';'
        CommentBlock = ';'
        CommentAtLineStart = True
        CommentStreamStart = ';'
        CommentStreamEnd = ';'
        NumStyleBits = 5
      end
      item
        Name = 'Avenue'
        Lexer = 'ave'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'KeyWord'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Enum'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            Name = 'String not closed'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword 1'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword 2'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword 3'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword 4'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword 5'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword 6'
            StyleNumber = 16
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords 1'
          end
          item
            KeywordListNumber = 1
            Name = 'Keywords 2'
          end
          item
            KeywordListNumber = 2
            Name = 'Keywords 3'
          end
          item
            KeywordListNumber = 4
            Name = 'Keywords 4'
          end
          item
            KeywordListNumber = 5
            Name = 'Keywords 5'
          end
          item
            KeywordListNumber = 6
            Name = 'Keywords 6'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = #39
        CommentBoxEnd = #39
        CommentBoxMiddle = #39
        CommentBlock = #39
        CommentAtLineStart = True
        CommentStreamStart = #39
        CommentStreamEnd = #39
        NumStyleBits = 5
      end
      item
        Name = 'Baan'
        Lexer = 'baan'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'DLL Usage'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'EOL if string is not closed'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword 2'
            StyleNumber = 10
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords 1'
          end
          item
            KeywordListNumber = 1
            Name = 'Keywords 2'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'BASH'
        Lexer = 'bash'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White Space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clRed
            CharCase = CASE_MIXED
            Name = 'Error'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16763904
            BackColor = 723723
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Number'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifiers (functions, etc.)'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Scalars: $var'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Parameter expansion: ${var}'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = 10518656
            CharCase = CASE_MIXED
            Name = 'Back Ticks'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16724672
            BackColor = 14536925
            CharCase = CASE_MIXED
            Name = 'Here-doc (delimiter)'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 8323199
            BackColor = 14536925
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Here-doc (single quoted, q)'
            StyleNumber = 13
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'alias'
              'ar'
              'asa'
              'awk'
              'banner'
              'basename'
              'bash'
              'bc'
              'bdiff'
              'break'
              'bunzip2'
              'bzip2'
              'cal'
              'calendar'
              'case'
              'cat'
              'cc'
              'cd'
              'chmod'
              'cksum'
              'clear'
              'cmp'
              'col'
              'comm'
              'compress'
              'continue'
              'cp'
              'cpio'
              'crypt'
              'csplit'
              'ctags'
              'cut'
              'date'
              'dc'
              'dd'
              'declare'
              'deroff'
              'dev'
              'df'
              'diff'
              'diff3'
              'dircmp'
              'dirname'
              'do'
              'done'
              'du'
              'echo'
              'ed'
              'egrep'
              'elif'
              'else'
              'env'
              'esac'
              'eval'
              'ex'
              'exec'
              'exit'
              'expand'
              'export'
              'expr'
              'false'
              'fc'
              'fgrep'
              'fi'
              'file'
              'find'
              'fmt'
              'fold'
              'for'
              'function'
              'functions'
              'getconf'
              'getopt'
              'getopts'
              'grep'
              'gres'
              'hash'
              'head'
              'help'
              'history'
              'iconv'
              'id'
              'if'
              'in'
              'integer'
              'jobs'
              'join'
              'kill'
              'local'
              'lc'
              'let'
              'line'
              'ln'
              'logname'
              'look'
              'ls'
              'm4'
              'mail'
              'mailx'
              'make'
              'man'
              'mkdir'
              'more'
              'mt'
              'mv'
              'newgrp'
              'nl'
              'nm'
              'nohup'
              'ntps'
              'od'
              'pack'
              'paste'
              'patch'
              'pathchk'
              'pax'
              'pcat'
              'perl'
              'pg'
              'pr'
              'print'
              'printf'
              'ps'
              'pwd'
              'read'
              'readonly'
              'red'
              'return'
              'rev'
              'rm'
              'rmdir'
              'sed'
              'select'
              'set'
              'sh'
              'shift'
              'size'
              'sleep'
              'sort'
              'spell'
              'split'
              'start'
              'stop'
              'strings'
              'strip'
              'stty'
              'sum'
              'suspend'
              'sync'
              'tail'
              'tar'
              'tee'
              'test'
              'then'
              'time'
              'times'
              'touch'
              'tr'
              'trap'
              'true'
              'tsort'
              'tty'
              'type'
              'typeset'
              'ulimit'
              'umask'
              'unalias'
              'uname'
              'uncompress'
              'unexpand'
              'uniq'
              'unpack'
              'unset'
              'until'
              'uudecode'
              'uuencode'
              'vi'
              'vim'
              'vpax'
              'wait'
              'wc'
              'whence'
              'which'
              'while'
              'who'
              'wpaste'
              'wstart'
              'xargs'
              'zcat'
              'chgrp'
              'chown'
              'chroot'
              'dir'
              'dircolors'
              'factor'
              'groups'
              'hostid'
              'install'
              'link'
              'md5sum'
              'mkfifo'
              'mknod'
              'nice'
              'pinky'
              'printenv'
              'ptx'
              'readlink'
              'seq'
              'sha1sum'
              'shred'
              'stat'
              'su'
              'tac'
              'unlink'
              'users'
              'vdir'
              'whoami'
              'yes')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '#'
        CommentBoxEnd = '#'
        CommentBoxMiddle = '#'
        CommentBlock = '#'
        CommentAtLineStart = True
        CommentStreamStart = '#'
        CommentStreamEnd = '#'
        NumStyleBits = 5
      end
      item
        Name = 'Batch'
        Lexer = 'batch'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Label'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Hide command char (@)'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16763904
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'External Commands'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13408767
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Variable'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 10089408
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = clGreen
            CharCase = CASE_MIXED
            Name = 'String Not EOL'
            StyleNumber = 9
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Internal Commands'
            Keywords.Strings = (
              'rem'
              'set'
              'if'
              'exist'
              'errorlevel'
              'for'
              'in'
              'do'
              'break'
              'call'
              'chcp'
              'cd'
              'chdir'
              'choice'
              'cls'
              'country'
              'ctty'
              'date'
              'del'
              'erase'
              'dir'
              'echo'
              'exit'
              'goto'
              'loadfix'
              'loadhigh'
              'mkdir'
              'md'
              'move'
              'path'
              'pause'
              'prompt'
              'rename'
              'ren'
              'rmdir'
              'rd'
              'shift'
              'time'
              'type'
              'ver'
              'verify'
              'vol'
              'com'
              'con'
              'lpt'
              'nul'
              'endlocal'
              'setlocal')
          end
          item
            KeywordListNumber = 1
            Name = 'External Commands'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = 'rem'
        CommentBoxEnd = 'rem'
        CommentBoxMiddle = 'rem'
        CommentBlock = 'rem'
        CommentAtLineStart = True
        CommentStreamStart = 'rem'
        CommentStreamEnd = 'rem'
        NumStyleBits = 5
      end
      item
        Name = 'BlitzBasic'
        Lexer = 'blitzbasic'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keywords'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PreProcessor'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Date'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String not terminated'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Keywords 1'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Keywords 2'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Keywords 3'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Constant'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Asm'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Label'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clRed
            CharCase = CASE_MIXED
            Name = 'Error'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'HexNumber'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'BinNumber'
            StyleNumber = 18
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'abs'
              'accepttcpstream'
              'acos'
              'after'
              'and'
              'apptitle'
              'asc'
              'asin'
              'atan'
              'atan2'
              'automidhandle'
              'autosuspend'
              'availvidmem'
              'backbuffer'
              'banksize'
              'before'
              'bin'
              'calldll'
              'case'
              'ceil'
              'changedir'
              'channelpan'
              'channelpitch'
              'channelplaying'
              'channelvolume'
              'chr'
              'closedir'
              'closefile'
              'closemovie'
              'closetcpserver'
              'closetcpstream'
              'closeudpstream'
              'cls'
              'clscolor'
              'color'
              'colorblue'
              'colorgreen'
              'colorred'
              'commandline'
              'const'
              'copybank'
              'copyfile'
              'copyimage'
              'copypixel'
              'copypixelfast'
              'copyrect'
              'copystream'
              'cos'
              'countgfxdrivers'
              'countgfxmodes'
              'counthostips'
              'createbank'
              'createdir'
              'createimage'
              'createnetplayer'
              'createprocess'
              'createtcpserver'
              'createtimer'
              'createudpstream'
              'currentdate'
              'currentdir'
              'currenttime'
              'data'
              'debuglog'
              'default'
              'delay'
              'delete'
              'deletedir'
              'deletefile'
              'deletenetplayer'
              'desktopbuffer'
              'dim'
              'dottedip'
              'drawblock'
              'drawblockrect'
              'drawimage'
              'drawimagerect'
              'drawmovie'
              'each'
              'else'
              'else'
              'if'
              'elseif'
              'end'
              'end'
              'function'
              'end'
              'if'
              'end'
              'select'
              'end'
              'type'
              'endgraphics'
              'endif'
              'eof'
              'execfile'
              'exit'
              'exp'
              'false'
              'field'
              'filepos'
              'filesize'
              'filetype'
              'first'
              'flip'
              'float'
              'floor'
              'flushjoy'
              'flushkeys'
              'flushmouse'
              'fontheight'
              'fontname'
              'fontsize'
              'fontstyle'
              'fontwidth'
              'for'
              'forever'
              'freebank'
              'freefont'
              'freeimage'
              'freesound'
              'freetimer'
              'frontbuffer'
              'function'
              'gammablue'
              'gammagreen'
              'gammared'
              'getcolor'
              'getenv'
              'getkey'
              'getmouse'
              'gfxdrivername'
              'gfxmodedepth'
              'gfxmodeexists'
              'gfxmodeformat'
              'gfxmodeheight'
              'gfxmodewidth'
              'global'
              'gosub'
              'goto'
              'grabimage'
              'graphics'
              'graphicsbuffer'
              'graphicsdepth'
              'graphicsformat'
              'graphicsheight'
              'graphicswidth'
              'handleimage'
              'hex'
              'hidepointer'
              'hostip'
              'hostnetgame'
              'if'
              'imagebuffer'
              'imageheight'
              'imagerectcollide'
              'imagerectoverlap'
              'imagescollide'
              'imagesoverlap'
              'imagewidth'
              'imagexhandle'
              'imageyhandle'
              'include'
              'input'
              'insert'
              'instr'
              'int'
              'joinnetgame'
              'joydown'
              'joyhat'
              'joyhit'
              'joypitch'
              'joyroll'
              'joytype'
              'joyu'
              'joyudir'
              'joyv'
              'joyvdir'
              'joyx'
              'joyxdir'
              'joyy'
              'joyyaw'
              'joyydir'
              'joyz'
              'joyzdir'
              'keydown'
              'keyhit'
              'keywait'
              'last'
              'left'
              'len'
              'line'
              'loadanimimage'
              'loadbuffer'
              'loadfont'
              'loadimage'
              'loadsound'
              'local'
              'lockbuffer'
              'lockedformat'
              'lockedpitch'
              'lockedpixels'
              'log'
              'log10'
              'loopsound'
              'lower'
              'lset'
              'maskimage'
              'mid'
              'midhandle'
              'millisecs'
              'mod'
              'morefiles'
              'mousedown'
              'mousehit'
              'mousex'
              'mousexspeed'
              'mousey'
              'mouseyspeed'
              'mousez'
              'mousezspeed'
              'movemouse'
              'movieheight'
              'movieplaying'
              'moviewidth'
              'netmsgdata'
              'netmsgfrom'
              'netmsgto'
              'netmsgtype'
              'netplayerlocal'
              'netplayername'
              'new'
              'next'
              'nextfile'
              'not'
              'null'
              'openfile'
              'openmovie'
              'opentcpstream'
              'or'
              'origin'
              'oval'
              'pausechannel'
              'pausetimer'
              'peekbyte'
              'peekfloat'
              'peekint'
              'peekshort'
              'pi'
              'playcdtrack'
              'playmusic'
              'playsound'
              'plot'
              'pokebyte'
              'pokefloat'
              'pokeint'
              'pokeshort'
              'print'
              'queryobject'
              'rand'
              'read'
              'readavail'
              'readbyte'
              'readbytes'
              'readdir'
              'readfile'
              'readfloat'
              'readint'
              'readline'
              'readpixel'
              'readpixelfast'
              'readshort'
              'readstring'
              'rect'
              'rectsoverlap'
              'recvnetmsg'
              'recvudpmsg'
              'repeat'
              'replace'
              'resettimer'
              'resizebank'
              'resizeimage'
              'restore'
              'resumechannel'
              'resumetimer'
              'return'
              'right'
              'rnd'
              'rndseed'
              'rotateimage'
              'rset'
              'runtimeerror'
              'sar'
              'savebuffer'
              'saveimage'
              'scaleimage'
              'scanline'
              'seedrnd'
              'seekfile'
              'select'
              'sendnetmsg'
              'sendudpmsg'
              'setbuffer'
              'setenv'
              'setfont'
              'setgamma'
              'setgfxdriver'
              'sgn'
              'shl'
              'showpointer'
              'shr'
              'sin'
              'soundpan'
              'soundpitch'
              'soundvolume'
              'sqr'
              'startnetgame'
              'step'
              'stop'
              'stopchannel'
              'stopnetgame'
              'str'
              'string'
              'stringheight'
              'stringwidth'
              'systemproperty'
              'tan'
              'tcpstreamip'
              'tcpstreamport'
              'tcptimeouts'
              'text'
              'tformfilter'
              'tformimage'
              'then'
              'tileblock'
              'tileimage'
              'timerticks'
              'to'
              'totalvidmem'
              'trim'
              'true'
              'type'
              'udpmsgip'
              'udpmsgport'
              'udpstreamip'
              'udpstreamport'
              'udptimeouts'
              'unlockbuffer'
              'until'
              'updategamma'
              'upper'
              'viewport'
              'vwait'
              'waitkey'
              'waitmouse'
              'waittimer'
              'wend'
              'while'
              'write'
              'writebyte'
              'writebytes'
              'writefile'
              'writefloat'
              'writeint'
              'writeline'
              'writepixel'
              'writepixelfast'
              'writeshort'
              'writestring'
              'xor')
          end
          item
            KeywordListNumber = 1
            Name = 'User Defined 1'
          end
          item
            KeywordListNumber = 2
            Name = 'User Defined 2'
          end
          item
            KeywordListNumber = 3
            Name = 'User Defined 3'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Bullant'
        Lexer = 'bullant'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Character'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 8355584
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Symbols'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 8323199
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'EOL if string is not closed'
            StyleNumber = 12
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '@off'
        CommentBoxEnd = '@on'
        CommentBoxMiddle = '*'
        CommentBlock = ';'
        CommentAtLineStart = True
        CommentStreamStart = ';'
        CommentStreamEnd = ';'
        NumStyleBits = 5
      end
      item
        Name = 'C#'
        Lexer = 'cpp'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Symbols/UUID'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'EOL if string is not closed'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Verbatim strings for C#'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16724672
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Regular expressions'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment Line'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User-defined keywords'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment keyword'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment keyword error'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Global classes and typedefs'
            StyleNumber = 19
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'abstract'
              'as'
              'base'
              'bool'
              'break'
              'byte'
              'case'
              'catch'
              'char'
              'checked'
              'class'
              'const'
              'continue'
              'decimal'
              'default'
              'delegate'
              'do'
              'double'
              'else'
              'enum'
              'event'
              'explicit'
              'extern'
              'false'
              'finally'
              'fixed'
              'float'
              'for'
              'foreach'
              'goto'
              'if'
              'implicit'
              'in'
              'int'
              'interface'
              'internal'
              'is'
              'lock'
              'long'
              'namespace'
              'new'
              'null'
              'object'
              'operator'
              'out'
              'override'
              'params'
              'private'
              'protected'
              'public'
              'readonly'
              'ref'
              'return'
              'sbyte'
              'sealed'
              'short'
              'sizeof'
              'stackalloc'
              'static'
              'string'
              'struct'
              'switch'
              'this'
              'throw'
              'true'
              'try'
              'typeof'
              'uint'
              'ulong'
              'unchecked'
              'unsafe'
              'ushort'
              'using'
              'virtual'
              'void'
              'while')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'C++/C'
        Lexer = 'cpp'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Symbols/UUID'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'EOL if string is not closed'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Verbatim strings for C#'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16724672
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Regular expressions'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment Line'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User-defined keywords'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment keyword'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment keyword error'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Global classes and typedefs'
            StyleNumber = 19
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Primary keywords and identifiers'
            Keywords.Strings = (
              '__asm'
              '_asm'
              'asm'
              'auto'
              '__automated'
              'bool'
              'break'
              'case'
              'catch'
              '__cdecl'
              '_cdecl'
              'cdecl'
              'char'
              'class'
              '__classid'
              '__closure'
              'const'
              'const_cast'
              'continue'
              '__declspec'
              'default'
              'delete'
              '__dispid'
              'do'
              'double'
              'dynamic_cast'
              'else'
              'enum'
              '__except'
              'explicit'
              '__export'
              'export'
              'extern'
              'false'
              '__fastcall'
              '_fastcall'
              '__finally'
              'float'
              'for'
              'friend'
              'goto'
              'if'
              '__import'
              '_import'
              '__inline'
              'inline'
              'int'
              '__int16'
              '__int32'
              '__int64'
              '__int8'
              'long'
              '__msfastcall'
              '__msreturn'
              'mutable'
              'namespace'
              'new'
              '__pascal'
              '_pascal'
              'pascal'
              'private'
              '__property'
              'protected'
              'public'
              '__published'
              'register'
              'reinterpret_cast'
              'return'
              '__rtti'
              'short'
              'signed'
              'sizeof'
              'static_cast'
              'static'
              '__stdcall'
              '_stdcall'
              'struct'
              'switch'
              'template'
              'this'
              '__thread'
              'throw'
              'true'
              '__try'
              'try'
              'typedef'
              'typeid'
              'typename'
              'union'
              'unsigned'
              'using'
              'virtual'
              'void'
              'volatile'
              'wchar_t'
              'while'
              'dllexport'
              'dllimport'
              'naked'
              'noreturn'
              'nothrow'
              'novtable'
              'property'
              'selectany'
              'thread'
              'uuid')
          end
          item
            KeywordListNumber = 1
            Name = 'Secondary keywords and identifiers'
            Keywords.Strings = (
              'TStream'
              'TFileStream'
              'TMemoryStream'
              'TBlobStream'
              'TOleStream'
              'TStrings'
              'TStringList'
              'AnsiString'
              'String'
              'WideString'
              'cout'
              'cin'
              'cerr'
              'endl'
              'fstream'
              'ostream'
              'istream'
              'wstring'
              'string'
              'deque'
              'list'
              'vector'
              'set'
              'multiset'
              'bitset'
              'map'
              'multimap'
              'stack'
              'queue'
              'priority_queue')
          end
          item
            KeywordListNumber = 2
            Name = 'Doc Comments'
            Keywords.Strings = (
              'a'
              'addindex'
              'addtogroup'
              'anchor'
              'arg'
              'attention'
              'author'
              'b'
              'brief'
              'bug'
              'c'
              'class'
              'code'
              'date'
              'def'
              'defgroup'
              'deprecated'
              'dontinclude'
              'e'
              'em'
              'endcode'
              'endhtmlonly'
              'endif'
              'endlatexonly'
              'endlink'
              'endverbatim'
              'enum'
              'example'
              'exception'
              'f$'
              'f['
              'f]'
              'file'
              'fn'
              'hideinitializer'
              'htmlinclude'
              'htmlonly'
              'if'
              'image'
              'include'
              'ingroup'
              'internal'
              'invariant'
              'interface'
              'latexonly'
              'li'
              'line'
              'link'
              'mainpage'
              'name'
              'namespace'
              'nosubgrouping'
              'note'
              'overload'
              'p'
              'page'
              'par'
              'param'
              'post'
              'pre'
              'ref'
              'relates'
              'remarks'
              'return'
              'retval'
              'sa'
              'section'
              'see'
              'showinitializer'
              'since'
              'skip'
              'skipline'
              'struct'
              'subsection'
              'test'
              'throw'
              'todo'
              'typedef'
              'union'
              'until'
              'var'
              'verbatim'
              'verbinclude'
              'version'
              'warning'
              'weakgroup'
              '$'
              '@'
              '<'
              '>'
              '\'
              '&'
              '#'
              '{'
              '}')
          end
          item
            KeywordListNumber = 3
            Name = 'Unused'
          end
          item
            KeywordListNumber = 4
            Name = 'Global classes and typedefs'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Clarion'
        Lexer = 'clarion'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Label'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Identifier'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Integer Constant'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Real Constant'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Picture String'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Compiler Directive'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Builtin Procedures/Function'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Structure/Data type'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Attribute'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Standard Equate'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Error'
            StyleNumber = 14
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Clarion Keywords'
          end
          item
            KeywordListNumber = 1
            Name = 'Compiler Directives'
          end
          item
            KeywordListNumber = 2
            Name = 'Built-in Procedures and Functions'
          end
          item
            KeywordListNumber = 3
            Name = 'Structure and Data Types'
          end
          item
            KeywordListNumber = 4
            Name = 'Attributes'
          end
          item
            KeywordListNumber = 5
            Name = 'Standard Equates'
          end
          item
            KeywordListNumber = 6
            Name = 'Reserved Words'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Clarion_Nocase'
        Lexer = 'clarionnocase'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Label'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Identifier'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Integer Constant'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Real Constant'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Picture String'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Compiler Directive'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Builtin Procedures/Function'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Structure/Data type'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Attribute'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Standard Equate'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Error'
            StyleNumber = 14
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Clarion Keywords'
          end
          item
            KeywordListNumber = 1
            Name = 'Compiler Directives'
          end
          item
            KeywordListNumber = 2
            Name = 'Built-in Procedures and Functions'
          end
          item
            KeywordListNumber = 3
            Name = 'Structure and Data Types'
          end
          item
            KeywordListNumber = 4
            Name = 'Attributes'
          end
          item
            KeywordListNumber = 5
            Name = 'Standard Equates'
          end
          item
            KeywordListNumber = 6
            Name = 'Reserved Words'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'CSS'
        Lexer = 'css'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'CSS1 Tag'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Class'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Pseudo Class'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Pseudo Class'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12624032
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifiers'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Identifiers'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 43673
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Value'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16744576
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ID'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Important'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 4500223
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Directive'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 14721024
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'CSS2 Tag'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Attribute'
            StyleNumber = 16
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'color'
              'background-color'
              'background-image'
              'background-repeat'
              'background-attachment'
              'background-position'
              'background'
              'font-family'
              'font-style'
              'font-variant'
              'font-weight'
              'font-size'
              'font'
              'word-spacing'
              'letter-spacing'
              'text-decoration'
              'vertical-align'
              'text-transform'
              'text-align'
              'text-indent'
              'line-height'
              'margin-top'
              'margin-right'
              'margin-bottom'
              'margin-left'
              'margin'
              'padding-top'
              'padding-right'
              'padding-bottom'
              'padding-left'
              'padding'
              'border-top-width'
              'border-right-width'
              'border-bottom-width'
              'border-left-width'
              'border-width'
              'border-top'
              'border-right'
              'border-bottom'
              'border-left'
              'border'
              'border-color'
              'border-style'
              'width'
              'height'
              'float'
              'clear'
              'display'
              'white-space'
              'list-style-type'
              'list-style-image'
              'list-style-position'
              'list-style'
              'scrollbar-3dlight-color'
              'scrollbar-arrow-color'
              'scrollbar-base-color'
              'scrollbar-darkshadow-color'
              'scrollbar-face-color'
              'scrollbar-highlight-color'
              'scrollbar-shadow-color'
              'scrollbar-track-color')
          end
          item
            KeywordListNumber = 1
            Name = 'Pseudo Classes'
            Keywords.Strings = (
              'first-letter'
              'first-line'
              'link'
              'active'
              'visited'
              'first-child'
              'focus'
              'hover'
              'lang'
              'before'
              'after'
              'left'
              'right'
              'first')
          end
          item
            KeywordListNumber = 2
            Name = 'CSS2 Keywords'
            Keywords.Strings = (
              'border-top-color'
              'border-right-color'
              'border-bottom-color'
              'border-left-color'
              'border-color'
              'border-top-style'
              'border-right-style'
              'border-bottom-style'
              'border-left-style'
              'border-style'
              'top'
              'right'
              'bottom'
              'left'
              'position'
              'z-index'
              'direction'
              'unicode-bidi'
              'min-width'
              'max-width'
              'min-height'
              'max-height'
              'overflow'
              'clip'
              'visibility'
              'content'
              'quotes'
              'counter-reset'
              'counter-increment'
              'marker-offset'
              'size'
              'marks'
              'page-break-before'
              'page-break-after'
              'page-break-inside'
              'page'
              'orphans'
              'widows'
              'font-stretch'
              'font-size-adjust'
              'unicode-range'
              'units-per-em'
              'src'
              'panose-1'
              'stemv'
              'stemh'
              'slope'
              'cap-height'
              'x-height'
              'ascent'
              'descent'
              'widths'
              'bbox'
              'definition-src'
              'baseline'
              'centerline'
              'mathline'
              'topline'
              'text-shadow'
              'caption-side'
              'table-layout'
              'border-collapse'
              'border-spacing'
              'empty-cells'
              'speak-header'
              'cursor'
              'outline'
              'outline-width'
              'outline-style'
              'outline-color'
              'volume'
              'speak'
              'pause-before'
              'pause-after'
              'pause'
              'cue-before'
              'cue-after'
              'cue'
              'play-during'
              'azimuth'
              'elevation'
              'speech-rate'
              'voice-family'
              'pitch'
              'pitch-range'
              'stress'
              'richness'
              'speak-punctuation'
              'speak-numeral')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Diff'
        Lexer = 'diff'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 
              'Comment (part before "diff ..." or "--- ..." and , Only in ..., ' +
              'Binary file...)'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Command (diff ...)'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 159
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Source file (--- ...) and Destination file (+++ ...)'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 4129023
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Position setting (@@ ...)'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clAqua
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line removal (-...)'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16720639
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Line addition (+...)'
            StyleNumber = 6
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '#'
        CommentBoxEnd = '#'
        CommentBoxMiddle = '#'
        CommentBlock = '#'
        CommentAtLineStart = True
        CommentStreamStart = '#'
        CommentStreamEnd = '#'
        NumStyleBits = 5
      end
      item
        Name = 'Eiffel'
        Lexer = 'eiffel'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Character'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'EOL if string is not closed'
            StyleNumber = 8
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'alias'
              'all'
              'and'
              'any'
              'as'
              'bit'
              'boolean'
              'check'
              'class'
              'character'
              'clone'
              'create'
              'creation'
              'current'
              'debug'
              'deferred'
              'div'
              'do'
              'double'
              'else'
              'elseif'
              'end'
              'ensure'
              'equal'
              'expanded'
              'export'
              'external'
              'false'
              'feature'
              'forget'
              'from'
              'frozen'
              'general'
              'if'
              'implies'
              'indexing'
              'infix'
              'inherit'
              'inspect'
              'integer'
              'invariant'
              'is'
              'language'
              'like'
              'local'
              'loop'
              'mod'
              'name'
              'nochange'
              'none'
              'not'
              'obsolete'
              'old'
              'once'
              'or'
              'platform'
              'pointer'
              'prefix'
              'precursor'
              'real'
              'redefine'
              'rename'
              'require'
              'rescue'
              'result'
              'retry'
              'select'
              'separate'
              'string'
              'strip'
              'then'
              'true'
              'undefine'
              'unique'
              'until'
              'variant'
              'void'
              'when'
              'xor')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Eiffel_kw'
        Lexer = 'eiffelkw'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Character'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'EOL if string is not closed'
            StyleNumber = 8
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'alias'
              'all'
              'and'
              'any'
              'as'
              'bit'
              'boolean'
              'check'
              'class'
              'character'
              'clone'
              'create'
              'creation'
              'current'
              'debug'
              'deferred'
              'div'
              'do'
              'double'
              'else'
              'elseif'
              'end'
              'ensure'
              'equal'
              'expanded'
              'export'
              'external'
              'false'
              'feature'
              'forget'
              'from'
              'frozen'
              'general'
              'if'
              'implies'
              'indexing'
              'infix'
              'inherit'
              'inspect'
              'integer'
              'invariant'
              'is'
              'language'
              'like'
              'local'
              'loop'
              'mod'
              'name'
              'nochange'
              'none'
              'not'
              'obsolete'
              'old'
              'once'
              'or'
              'platform'
              'pointer'
              'prefix'
              'precursor'
              'real'
              'redefine'
              'rename'
              'require'
              'rescue'
              'result'
              'retry'
              'select'
              'separate'
              'string'
              'strip'
              'then'
              'true'
              'undefine'
              'unique'
              'until'
              'variant'
              'void'
              'when'
              'xor')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'EmailMessage'
        Lexer = 'email'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Header Tags'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16750487
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Header Value'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Highlighted Headers'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Highlighted Headers Value'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Quote'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 55769
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'EMail Address'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 15921664
            BackColor = clDefault
            CharCase = CASE_MIXED
            Hotspot = True
            Name = 'Url Adresses'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword 1'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword 2'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword 3'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword 4'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword 5'
            StyleNumber = 12
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Header Tags'
            Keywords.Strings = (
              'return-path'
              'received'
              'reply-to'
              'from'
              'sender'
              'resent-reply-to'
              'resent-from'
              'resent-sender'
              'date'
              'resent-date'
              'to'
              'cc'
              'resent-cc'
              'bcc'
              'resent-bcc'
              'message-id'
              'resent-message-id'
              'in-reply-to'
              'references'
              'keywords'
              'comments'
              'encrypted'
              'newsgroups'
              'path'
              'followup-to'
              'expires'
              'references'
              'distribution'
              'organization'
              'summary'
              'approved'
              'lines'
              'xref'
              'mime-version'
              'control'
              'also-control'
              'content-disposition'
              'mail-system-version'
              'mailer'
              'originating-client'
              'x-mailer'
              'x-newsreader'
              'apparently-to'
              'for-comment'
              'for-handling'
              'disclose-recipients'
              'alternate-recipient'
              'original-encoded-information-types'
              'errors-to'
              'return-receipt-to'
              'prevent-nondelivery-report'
              'generate-delivery-report'
              'content-return'
              'content-id'
              'content-base'
              'content-location'
              'see-also'
              'obsoletes'
              'supersedes'
              'article-updates'
              'article-names'
              'content-description'
              'organisation'
              'content-identifier'
              'delivery-date'
              'expiry-date'
              'reply-by'
              'priority'
              'precedence'
              'importance'
              'sensitivity'
              'incomplete-copy'
              'language'
              'content-language'
              'content-length'
              'conversion'
              'content-conversion'
              'conversion-with-loss'
              'content-type'
              'content-sgml-entity'
              'content-transfer-encoding'
              'message-type'
              'encoding'
              'content-md5'
              'fcc'
              'auto-forwarded'
              'status'
              'discarded-x400-ipms-extensions'
              'discarded-x400-mts-extensions'
              'x-beenthere'
              'x-mailman-version'
              'list-id'
              'list-unsubscribe'
              'list-archive'
              'list-post'
              'list-help'
              'list-subscribe')
          end
          item
            KeywordListNumber = 1
            Name = 'Highlighted Header Tags'
            Keywords.Strings = (
              'subject')
          end
          item
            KeywordListNumber = 2
            Name = 'Keywords 1'
          end
          item
            KeywordListNumber = 3
            Name = 'Keywords 2'
          end
          item
            KeywordListNumber = 4
            Name = 'Keywords 3'
          end
          item
            KeywordListNumber = 5
            Name = 'Keywords 4'
          end
          item
            KeywordListNumber = 6
            Name = 'Keywords 5'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'ErrorList'
        Lexer = 'errorlist'
        Styles = <
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Python Error'
            StyleNumber = 1
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'GCC Error'
            StyleNumber = 2
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Microsoft Error'
            StyleNumber = 3
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clAqua
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Command or return status'
            StyleNumber = 4
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Borland Error and Warnings'
            StyleNumber = 5
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Perl Error and Warnings'
            StyleNumber = 6
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = '.Net tracebacks'
            StyleNumber = 7
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Lua error and warning messages'
            StyleNumber = 8
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'CTags'
            StyleNumber = 9
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Diff Changed !'
            StyleNumber = 10
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = 16720639
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Diff Addition +'
            StyleNumber = 11
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clAqua
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Diff Deletion -'
            StyleNumber = 12
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Diff Message ---'
            StyleNumber = 13
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Error'
            StyleNumber = 14
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Essential Lahey Fortran 90 error'
            StyleNumber = 15
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Intel Fortran Compiler error'
            StyleNumber = 16
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Intel Fortran Compiler v8.0 error/warning'
            StyleNumber = 17
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Absoft Pro Fortran 90/95 v8.2 error or warning'
            StyleNumber = 18
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'HTML Tidy'
            StyleNumber = 19
          end
          item
            FontSize = 10
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Java runtime stack trace'
            StyleNumber = 20
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'EScript'
        Lexer = 'escript'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Primary keywords and identifiers'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted String'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifiers'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Braces'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Intrinsic functions'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Extended and user defined functions'
            StyleNumber = 11
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Primary keywords and identifiers'
            Keywords.Strings = (
              'basic'
              'basicio'
              'boats'
              'cfgfile'
              'file'
              'http'
              'npc'
              'os'
              'uo'
              'util'
              'accessible'
              'addmenuitem'
              'appendconfigfileelem'
              'applyconstraint'
              'applydamage'
              'applyrawdamage'
              'assignrecttoweatherregion'
              'append'
              'baseskilltorawskill'
              'boatfromitem'
              'broadcast'
              'ban'
              'cdbl'
              'cint'
              'cstr'
              'checklineofsight'
              'checklosat'
              'checkskill'
              'consumemana'
              'consumereagents'
              'consumesubstance'
              'createaccount'
              'createitematlocation'
              'createiteminbackpack'
              'createitemininventory'
              'createitemincontainer'
              'createmenu'
              'createmultiatlocation'
              'createnpcfromtemplate'
              'createrootiteminstoragearea'
              'createstoragearea'
              'clear_script_profile_counters'
              'close'
              'damage'
              'destroyitem'
              'destroymulti'
              'destroyrootiteminstoragearea'
              'detach'
              'disableevents'
              'disconnectclient'
              'distance'
              'disable'
              'enableevents'
              'enumerateitemsincontainer'
              'enumerateonlinecharacters'
              'equipfromtemplate'
              'equipitem'
              'eraseglobalproperty'
              'eraseobjproperty'
              'enable'
              'enabled'
              'erase'
              'events_waiting'
              'exists'
              'findconfigelem'
              'findobjtypeincontainer'
              'findrootiteminstoragearea'
              'findstoragearea'
              'fclose'
              'find'
              'fopen'
              'fread'
              'fseek'
              'ftell'
              'fwrite'
              'gamestat'
              'getamount'
              'getcommandhelp'
              'getconfigint'
              'getconfigintkeys'
              'getconfigmaxintkey'
              'getconfigreal'
              'getconfigstring'
              'getconfigstringkeys'
              'getconfigstringarray'
              'getelemproperty'
              'getequipmentbylayer'
              'getglobalproperty'
              'getharvestdifficulty'
              'getmapinfo'
              'getmenuobjtypes'
              'getobjproperty'
              'getobjtype'
              'getobjtypebyname'
              'getproperty'
              'getrawskill'
              'getregionstring'
              'getskill'
              'getspelldifficulty'
              'getstandingheight'
              'getworldheight'
              'grantprivilege'
              'harvestresource'
              'healdamage'
              'hex'
              'islegalmove'
              'insert'
              'keys'
              'listequippeditems'
              'listghostsnearlocation'
              'listhostiles'
              'listitemsatlocation'
              'listitemsnearlocation'
              'listitemsnearlocationoftype'
              'listmobilesinlineofsight'
              'listmobilesnearlocation'
              'listmobilesnearlocationex'
              'listobjectsinbox'
              'loadtusscpfile'
              'left'
              'len'
              'log_profile'
              'lower'
              'makeboundingbox'
              'move'
              'moveboat'
              'moveboatrelative'
              'movecharactertolocation'
              'moveitemtocontainer'
              'moveitemtolocation'
              'move_offline_mobiles'
              'openpaperdoll'
              'open'
              'pack'
              'performaction'
              'playlightningbolteffect'
              'playmovingeffect'
              'playmovingeffectxyz'
              'playobjectcenteredeffect'
              'playsoundeffect'
              'playsoundeffectprivate'
              'playstationaryeffect'
              'printtextabove'
              'printtextaboveprivate'
              'packages'
              'polcore'
              'position'
              'print'
              'queryparam'
              'randomdiceroll'
              'randomint'
              'rawskilltobaseskill'
              'readconfigfile'
              'readgameclock'
              'releaseitem'
              'registerforspeechevents'
              'registeritemwithboat'
              'requestinput'
              'reserveitem'
              'restartscript'
              'resurrect'
              'revokeprivilege'
              'runawayfrom'
              'runawayfromlocation'
              'runtoward'
              'runtowardlocation'
              'reverse'
              'run_script_to_completion'
              'saveworldstate'
              'selectmenuitem2'
              'self'
              'sendbuywindow'
              'senddialoggump'
              'sendevent'
              'sendopenspecialcontainer'
              'sendpacket'
              'sendsellwindow'
              'sendskillwindow'
              'sendstringastipwindow'
              'sendsysmessage'
              'sendtextentrygump'
              'setanchor'
              'setglobalproperty'
              'setname'
              'setobjproperty'
              'setopponent'
              'setproperty'
              'setrawskill'
              'setregionlightlevel'
              'setregionweatherlevel'
              'setscriptcontroller'
              'setwarmode'
              'shutdown'
              'speakpowerwords'
              'splitwords'
              'startspelleffect'
              'subtractamount'
              'systemfindboatbyserial'
              'systemfindobjectbyserial'
              'say'
              'set_critical'
              'set_debug'
              'set_priority'
              'set_priority_divide'
              'set_script_option'
              'setcmdlevel'
              'setdex'
              'setint'
              'setlightlevel'
              'setmaster'
              'setname'
              'setpassword'
              'setstr'
              'shrink'
              'size'
              'sleep'
              'sleepms'
              'sort'
              'spendgold'
              'squelch'
              'start_script'
              'syslog'
              'system_rpm'
              'target'
              'targetcoordinates'
              'targetmultiplacement'
              'turnawayfrom'
              'turnawayfromlocation'
              'turnboat'
              'turntoward'
              'turntowardlocation'
              'toggle'
              'unloadconfigfile'
              'unpack'
              'unban'
              'unload_scripts'
              'upper'
              'walkawayfrom'
              'walkawayfromlocation'
              'walktoward'
              'walktowardlocation'
              'wander'
              'writehtml'
              'writehtmlraw'
              'wait_for_event'
              'movechar_forcelocation'
              'moveitem_forcelocation'
              'moveitem_normal'
              'scriptopt_debug'
              'scriptopt_no_interrupt'
              'scriptopt_no_runaway'
              'te_cancel_disable'
              'te_cancel_enable'
              'te_style_disable'
              'te_style_normal'
              'te_style_numerical'
              'tgtopt_check_los'
              'tgtopt_harmful'
              'tgtopt_helpful'
              'tgtopt_neutral'
              'tgtopt_nocheck_los'
              'setprop'
              'getprop')
          end
          item
            KeywordListNumber = 1
            Name = 'Intrinsic functions'
            Keywords.Strings = (
              'array'
              'const'
              'dictionary'
              'global'
              'local'
              'var'
              'and'
              'default'
              'in'
              'next'
              'not'
              'or'
              'return'
              'to'
              'include'
              'use'
              'enum')
          end
          item
            KeywordListNumber = 2
            Name = 'Extended and user defined functions'
            Keywords.Strings = (
              'while'
              'for'
              'endfor'
              'function'
              'program'
              'endprogram'
              'endfunction'
              'foreach'
              'case'
              'else'
              'elseif'
              'if'
              'endcase'
              'endenum'
              'endforeach'
              'endif'
              'endwhile')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Forth'
        Lexer = 'forth'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment ML'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Control Keywords'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keywords'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Definition Words'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Prewords with one argument'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Prewords with two arguments'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Locale'
            StyleNumber = 11
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Control keywords'
            Keywords.Strings = (
              'AGAIN'
              'BEGIN'
              'CASE'
              'DO'
              'ELSE'
              'ENDCASE'
              'ENDOF'
              'IF'
              'LOOP'
              'OF'
              'REPEAT'
              'THEN'
              'UNTIL'
              'WHILE'
              '[IF]'
              '[ELSE]'
              '[THEN]'
              '?DO')
          end
          item
            KeywordListNumber = 1
            Name = 'Keywords'
            Keywords.Strings = (
              'DUP'
              'DROP'
              'ROT'
              'SWAP'
              'OVER'
              '@'
              '!'
              '2@'
              '2!'
              '2DUP'
              '2DROP'
              '2SWAP'
              '2OVER'
              'NIP'
              'R@'
              '>R'
              'R>'
              '2R@'
              '2>R'
              '2R>'
              '0='
              '0<'
              'SP@'
              'SP!'
              'W@'
              'W!'
              'C@'
              'C!'
              '<'
              '>'
              '='
              '<>'
              '0<>SPACE'
              'SPACES'
              'KEY?'
              'KEY'
              'THROW'
              'CATCH'
              'ABORT'
              '*/'
              '2*'
              '/MOD'
              'CELL+'
              'CELLS'
              'CHAR+'
              'CHARS'
              'MOVE'
              'ERASE'
              'DABS'
              'TITLE'
              'HEX'
              'DECIMAL'
              'HOLD'
              '<#'
              '#'
              '#S'
              '#>'
              'SIGN'
              'D.'
              '.'
              'U.'
              'DUMP'
              '(.")'
              '>NUMBER'
              #39
              'IMMEDIATE'
              'EXIT'
              'RECURSE'
              'UNLOOP'
              'LEAVE'
              'HERE'
              'ALLOT'
              ','
              'C,'
              'W,'
              'COMPILE,'
              'BRANCH,'
              'RET,'
              'LIT,'
              'DLIT,'
              '?BRANCH,'
              ','
              '>MARK'
              '>RESOLVE1'
              '<MARK'
              '>RESOLVE'
              'ALIGN'
              'ALIGNED'
              'USER-ALLOT'
              'USER-HERE'
              'HEADER'
              'DOES>'
              'SMUDGE'
              'HIDE'
              ':NONAME'
              'LAST-WORD'
              '?ERROR'
              'ERROR2'
              'FIND1'
              'SFIND'
              'SET-CURRENT'
              'GET-CURRENT'
              'DEFINITIONS'
              'GET-ORDER'
              'FORTH'
              'ONLY'
              'SET-ORDER'
              'ALSO'
              'PREVIOUS'
              'VOC-NAME.'
              'ORDER'
              'LATEST'
              'LITERAL'
              '2LITERAL'
              'SLITERAL'
              'CLITERAL'
              '?LITERAL1'
              '?SLITERAL1'
              'HEX-LITERAL'
              'HEX-SLITERAL'
              '?LITERAL2'
              '?SLITERAL2'
              'SOURCE'
              'EndOfChunk'
              'CharAddr'
              'PeekChar'
              'IsDelimiter'
              'GetChar'
              'OnDelimiter'
              'SkipDelimiters'
              'OnNotDelimiter'
              'SkipWord'
              'SkipUpTo'
              'ParseWord'
              'NextWord'
              'PARSE'
              'SKIP'
              'CONSOLE-HANDLES'
              'REFILL'
              'DEPTH'
              '?STACK'
              '?COMP'
              'WORD'
              'INTERPRET'
              'BYE'
              'QUIT'
              'MAIN1'
              'EVALUATE'
              'INCLUDE-FILE'
              'INCLUDED'
              '>BODY'
              '+WORD'
              'WORDLIST'
              'CLASS!'
              'CLASS@'
              'PAR!'
              'PAR@'
              'ID.'
              '?IMMEDIATE'
              '?VOC'
              'IMMEDIATE'
              'VOC'
              'WordByAddrWl'
              'WordByAddr'
              'NLIST'
              'WORDS'
              'SAVE'
              'OPTIONS'
              '/notransl'
              'ANSI>OEM'
              'ACCEPT'
              'EMIT'
              'CR'
              'TYPE'
              'EKEY?'
              'EKEY'
              'EKEY>CHAR'
              'EXTERNTASK'
              'ERASE-IMPORTS'
              'ModuleName'
              'ModuleDirName'
              'ENVIRONMENT?'
              'DROP-EXC-HANDLER'
              'SET-EXC-HANDLER'
              'HALT'
              'ERR'
              'CLOSE-FILE'
              'CREATE-FILE'
              'CREATE-FILE-SHARED'
              'OPEN-FILE-SHARED'
              'DELETE-FILE'
              'FILE-POSITION'
              'FILE-SIZE'
              'OPEN-FILE'
              'READ-FILE'
              'REPOSITION-FILE'
              'DOS-LINES'
              'UNIX-LINES'
              'READ-LINE'
              'WRITE-FILE'
              'RESIZE-FILE'
              'WRITE-LINE'
              'ALLOCATE'
              'FREE'
              'RESIZE'
              'START'
              'SUSPEND'
              'RESUME'
              'STOP'
              'PAUSE'
              'MIN'
              'MAX'
              'TRUE'
              'FALSE'
              'ASCIIZ>'
              'R/O'
              'W/O'
              ';CLASS'
              'ENDWITH'
              'OR'
              'AND'
              '/STRING'
              'SEARCH'
              'COMPARE'
              'EXPORT'
              ';MODULE'
              'SPAC')
          end
          item
            KeywordListNumber = 2
            Name = 'Definition Words'
            Keywords.Strings = (
              'VARIABLE'
              'CREATE'
              ':'
              'VALUE'
              'CONSTANT'
              'VM:'
              'M:'
              'var'
              'dvar'
              'chars'
              'OBJ'
              'CONSTR:'
              'DESTR:'
              'CLASS:'
              'OBJECT:'
              'POINTER'
              'USER'
              'USER-CREATE'
              'USER-VALUE'
              'VECT'
              'WNDPROC:'
              'VOCABULARY'
              '--'
              'TASK:'
              'CEZ:'
              'MODULE:')
          end
          item
            KeywordListNumber = 3
            Name = 'Prewords with one argument'
            Keywords.Strings = (
              'CHAR'
              '[CHAR]'
              'POSTPONE'
              'WITH'
              '['#39']'
              'TO'
              '[COMPILE]'
              'CHAR'
              'ASCII'
              '\'#39)
          end
          item
            KeywordListNumber = 4
            Name = 'Prewords with two arguments'
            Keywords.Strings = (
              'REQUIRE'
              'WINAPI:')
          end
          item
            KeywordListNumber = 5
            Name = 'String definition keywords'
            Keywords.Strings = (
              'S"'
              'ABORT"'
              'Z"'
              '.'
              'C"')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Fortran'
        Lexer = 'fortran'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String 1'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String 2'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            Name = 'String not closed'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Primary keywords and identifiers'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Intrinsic functions'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Extended and user defined functions'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator 2'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Label'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Continuation'
            StyleNumber = 14
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Primary keywords and identifiers'
            Keywords.Strings = (
              'access'
              'action'
              'advance'
              'allocatable'
              'allocate'
              'apostrophe'
              'assign'
              'assignment'
              'associate'
              'asynchronous'
              'backspace'
              'bind'
              'blank'
              'blockdata'
              'call'
              'case'
              'character'
              'class'
              'close'
              'common'
              'complex'
              'contains'
              'continue'
              'cycle'
              'data'
              'deallocate'
              'decimal'
              'delim'
              'default'
              'dimension'
              'direct'
              'do'
              'dowhile'
              'double'
              'doubleprecision'
              'else'
              'elseif'
              'elsewhere'
              'encoding'
              'end'
              'endassociate'
              'endblockdata'
              'enddo'
              'endfile'
              'endforall'
              'endfunction'
              'endif'
              'endinterface'
              'endmodule'
              'endprogram'
              'endselect'
              'endsubroutine'
              'endtype'
              'endwhere'
              'entry'
              'eor'
              'equivalence'
              'err'
              'errmsg'
              'exist'
              'exit'
              'external'
              'file'
              'flush'
              'fmt'
              'forall'
              'form'
              'format'
              'formatted'
              'function'
              'go'
              'goto'
              'id'
              'if'
              'implicit'
              'in'
              'include'
              'inout'
              'integer'
              'inquire'
              'intent'
              'interface'
              'intrinsic'
              'iomsg'
              'iolength'
              'iostat'
              'kind'
              'len'
              'logical'
              'module'
              'name'
              'named'
              'namelist'
              'nextrec'
              'nml'
              'none'
              'nullify'
              'number'
              'only'
              'open'
              'opened'
              'operator'
              'optional'
              'out'
              'pad'
              'parameter'
              'pass'
              'pause'
              'pending'
              'pointer'
              'pos'
              'position'
              'precision'
              'print'
              'private'
              'program'
              'protected'
              'public'
              'quote'
              'read'
              'readwrite'
              'real'
              'rec'
              'recl'
              'recursive'
              'result'
              'return'
              'rewind'
              'save'
              'select'
              'selectcase'
              'selecttype'
              'sequential'
              'sign'
              'size'
              'stat'
              'status'
              'stop'
              'stream'
              'subroutine'
              'target'
              'then'
              'to'
              'type'
              'unformatted'
              'unit'
              'use'
              'value'
              'volatile'
              'wait'
              'where'
              'while'
              'write')
          end
          item
            KeywordListNumber = 1
            Name = 'Intrinsic functions'
            Keywords.Strings = (
              'abs'
              'achar'
              'acos'
              'acosd'
              'adjustl'
              'adjustr'
              'aimag'
              'aimax0'
              'aimin0'
              'aint'
              'ajmax0'
              'ajmin0'
              'akmax0'
              'akmin0'
              'all'
              'allocated'
              'alog'
              'alog10'
              'amax0'
              'amax1'
              'amin0'
              'amin1'
              'amod'
              'anint'
              'any'
              'asin'
              'asind'
              'associated'
              'atan'
              'atan2'
              'atan2d'
              'atand'
              'bitest'
              'bitl'
              'bitlr'
              'bitrl'
              'bjtest'
              'bit_size'
              'bktest'
              'break'
              'btest'
              'cabs'
              'ccos'
              'cdabs'
              'cdcos'
              'cdexp'
              'cdlog'
              'cdsin'
              'cdsqrt'
              'ceiling'
              'cexp'
              'char'
              'clog'
              'cmplx'
              'conjg'
              'cos'
              'cosd'
              'cosh'
              'count'
              'cpu_time'
              'cshift'
              'csin'
              'csqrt'
              'dabs'
              'dacos'
              'dacosd'
              'dasin'
              'dasind'
              'datan'
              'datan2'
              'datan2d'
              'datand'
              'date'
              'date_and_time'
              'dble'
              'dcmplx'
              'dconjg'
              'dcos'
              'dcosd'
              'dcosh'
              'dcotan'
              'ddim'
              'dexp'
              'dfloat'
              'dflotk'
              'dfloti'
              'dflotj'
              'digits'
              'dim'
              'dimag'
              'dint'
              'dlog'
              'dlog10'
              'dmax1'
              'dmin1'
              'dmod'
              'dnint'
              'dot_product'
              'dprod'
              'dreal'
              'dsign'
              'dsin'
              'dsind'
              'dsinh'
              'dsqrt'
              'dtan'
              'dtand'
              'dtanh'
              'eoshift'
              'epsilon'
              'errsns'
              'exp'
              'exponent'
              'float'
              'floati'
              'floatj'
              'floatk'
              'floor'
              'fraction'
              'free'
              'huge'
              'iabs'
              'iachar'
              'iand'
              'ibclr'
              'ibits'
              'ibset'
              'ichar'
              'idate'
              'idim'
              'idint'
              'idnint'
              'ieor'
              'ifix'
              'iiabs'
              'iiand'
              'iibclr'
              'iibits'
              'iibset'
              'iidim'
              'iidint'
              'iidnnt'
              'iieor'
              'iifix'
              'iint'
              'iior'
              'iiqint'
              'iiqnnt'
              'iishft'
              'iishftc'
              'iisign'
              'ilen'
              'imax0'
              'imax1'
              'imin0'
              'imin1'
              'imod'
              'index'
              'inint'
              'inot'
              'int'
              'int1'
              'int2'
              'int4'
              'int8'
              'iqint'
              'iqnint'
              'ior'
              'ishft'
              'ishftc'
              'isign'
              'isnan'
              'izext'
              'jiand'
              'jibclr'
              'jibits'
              'jibset'
              'jidim'
              'jidint'
              'jidnnt'
              'jieor'
              'jifix'
              'jint'
              'jior'
              'jiqint'
              'jiqnnt'
              'jishft'
              'jishftc'
              'jisign'
              'jmax0'
              'jmax1'
              'jmin0'
              'jmin1'
              'jmod'
              'jnint'
              'jnot'
              'jzext'
              'kiabs'
              'kiand'
              'kibclr'
              'kibits'
              'kibset'
              'kidim'
              'kidint'
              'kidnnt'
              'kieor'
              'kifix'
              'kind'
              'kint'
              'kior'
              'kishft'
              'kishftc'
              'kisign'
              'kmax0'
              'kmax1'
              'kmin0'
              'kmin1'
              'kmod'
              'knint'
              'knot'
              'kzext'
              'lbound'
              'leadz'
              'len'
              'len_trim'
              'lenlge'
              'lge'
              'lgt'
              'lle'
              'llt'
              'log'
              'log10'
              'logical'
              'lshift'
              'malloc'
              'matmul'
              'max'
              'max0'
              'max1'
              'maxexponent'
              'maxloc'
              'maxval'
              'merge'
              'min'
              'min0'
              'min1'
              'minexponent'
              'minloc'
              'minval'
              'mod'
              'modulo'
              'mvbits'
              'nearest'
              'nint'
              'not'
              'nworkers'
              'number_of_processors'
              'pack'
              'popcnt'
              'poppar'
              'precision'
              'present'
              'product'
              'radix'
              'random'
              'random_number'
              'random_seed'
              'range'
              'real'
              'repeat'
              'reshape'
              'rrspacing'
              'rshift'
              'scale'
              'scan'
              'secnds'
              'selected_int_kind'
              'selected_real_kind'
              'set_exponent'
              'shape'
              'sign'
              'sin'
              'sind'
              'sinh'
              'size'
              'sizeof'
              'sngl'
              'snglq'
              'spacing'
              'spread'
              'sqrt'
              'sum'
              'system_clock'
              'tan'
              'tand'
              'tanh'
              'tiny'
              'transfer'
              'transpose'
              'trim'
              'ubound'
              'unpack'
              'verify+')
          end
          item
            KeywordListNumber = 2
            Name = 'Extended and user defined functions'
            Keywords.Strings = (
              'cdabs'
              'cdcos'
              'cdexp'
              'cdlog'
              'cdsin'
              'cdsqrt'
              'cotan'
              'cotand'
              'dcmplx'
              'dconjg'
              'dcotan'
              'dcotand'
              'decode'
              'dimag'
              'dll_export'
              'dll_import'
              'doublecomplex'
              'dreal'
              'dvchk'
              'encode'
              'find'
              'flen'
              'flush'
              'getarg'
              'getcharqq'
              'getcl'
              'getdat'
              'getenv'
              'gettim'
              'hfix'
              'ibchng'
              'identifier'
              'imag'
              'int1'
              'int2'
              'int4'
              'intc'
              'intrup'
              'invalop'
              'iostat_msg'
              'isha'
              'ishc'
              'ishl'
              'jfix'
              'lacfar'
              'locking'
              'locnear'
              'map'
              'nargs'
              'nbreak'
              'ndperr'
              'ndpexc'
              'offset'
              'ovefl'
              'peekcharqq'
              'precfill'
              'prompt'
              'qabs'
              'qacos'
              'qacosd'
              'qasin'
              'qasind'
              'qatan'
              'qatand'
              'qatan2'
              'qcmplx'
              'qconjg'
              'qcos'
              'qcosd'
              'qcosh'
              'qdim'
              'qexp'
              'qext'
              'qextd'
              'qfloat'
              'qimag'
              'qlog'
              'qlog10'
              'qmax1'
              'qmin1'
              'qmod'
              'qreal'
              'qsign'
              'qsin'
              'qsind'
              'qsinh'
              'qsqrt'
              'qtan'
              'qtand'
              'qtanh'
              'ran'
              'rand'
              'randu'
              'rewrite'
              'segment'
              'setdat'
              'settim'
              'system'
              'timer'
              'undfl'
              'unlock'
              'union'
              'val'
              'virtual'
              'volatile'
              'zabs'
              'zcos'
              'zexp'
              'zlog'
              'zsin'
              'zsqrt')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '!~'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Fortran77'
        Lexer = 'f77'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String 1'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String 2'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            Name = 'String not closed'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Primary keywords and identifiers'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Intrinsic functions'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Extended and user defined functions'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator 2'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Label'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Continuation'
            StyleNumber = 14
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Primary keywords and identifiers'
            Keywords.Strings = (
              'access'
              'action'
              'advance'
              'allocatable'
              'allocate'
              'apostrophe'
              'assign'
              'assignment'
              'associate'
              'asynchronous'
              'backspace'
              'bind'
              'blank'
              'blockdata'
              'call'
              'case'
              'character'
              'class'
              'close'
              'common'
              'complex'
              'contains'
              'continue'
              'cycle'
              'data'
              'deallocate'
              'decimal'
              'delim'
              'default'
              'dimension'
              'direct'
              'do'
              'dowhile'
              'double'
              'doubleprecision'
              'else'
              'elseif'
              'elsewhere'
              'encoding'
              'end'
              'endassociate'
              'endblockdata'
              'enddo'
              'endfile'
              'endforall'
              'endfunction'
              'endif'
              'endinterface'
              'endmodule'
              'endprogram'
              'endselect'
              'endsubroutine'
              'endtype'
              'endwhere'
              'entry'
              'eor'
              'equivalence'
              'err'
              'errmsg'
              'exist'
              'exit'
              'external'
              'file'
              'flush'
              'fmt'
              'forall'
              'form'
              'format'
              'formatted'
              'function'
              'go'
              'goto'
              'id'
              'if'
              'implicit'
              'in'
              'include'
              'inout'
              'integer'
              'inquire'
              'intent'
              'interface'
              'intrinsic'
              'iomsg'
              'iolength'
              'iostat'
              'kind'
              'len'
              'logical'
              'module'
              'name'
              'named'
              'namelist'
              'nextrec'
              'nml'
              'none'
              'nullify'
              'number'
              'only'
              'open'
              'opened'
              'operator'
              'optional'
              'out'
              'pad'
              'parameter'
              'pass'
              'pause'
              'pending'
              'pointer'
              'pos'
              'position'
              'precision'
              'print'
              'private'
              'program'
              'protected'
              'public'
              'quote'
              'read'
              'readwrite'
              'real'
              'rec'
              'recl'
              'recursive'
              'result'
              'return'
              'rewind'
              'save'
              'select'
              'selectcase'
              'selecttype'
              'sequential'
              'sign'
              'size'
              'stat'
              'status'
              'stop'
              'stream'
              'subroutine'
              'target'
              'then'
              'to'
              'type'
              'unformatted'
              'unit'
              'use'
              'value'
              'volatile'
              'wait'
              'where'
              'while'
              'write')
          end
          item
            KeywordListNumber = 1
            Name = 'Intrinsic functions'
            Keywords.Strings = (
              'abs'
              'achar'
              'acos'
              'acosd'
              'adjustl'
              'adjustr'
              'aimag'
              'aimax0'
              'aimin0'
              'aint'
              'ajmax0'
              'ajmin0'
              'akmax0'
              'akmin0'
              'all'
              'allocated'
              'alog'
              'alog10'
              'amax0'
              'amax1'
              'amin0'
              'amin1'
              'amod'
              'anint'
              'any'
              'asin'
              'asind'
              'associated'
              'atan'
              'atan2'
              'atan2d'
              'atand'
              'bitest'
              'bitl'
              'bitlr'
              'bitrl'
              'bjtest'
              'bit_size'
              'bktest'
              'break'
              'btest'
              'cabs'
              'ccos'
              'cdabs'
              'cdcos'
              'cdexp'
              'cdlog'
              'cdsin'
              'cdsqrt'
              'ceiling'
              'cexp'
              'char'
              'clog'
              'cmplx'
              'conjg'
              'cos'
              'cosd'
              'cosh'
              'count'
              'cpu_time'
              'cshift'
              'csin'
              'csqrt'
              'dabs'
              'dacos'
              'dacosd'
              'dasin'
              'dasind'
              'datan'
              'datan2'
              'datan2d'
              'datand'
              'date'
              'date_and_time'
              'dble'
              'dcmplx'
              'dconjg'
              'dcos'
              'dcosd'
              'dcosh'
              'dcotan'
              'ddim'
              'dexp'
              'dfloat'
              'dflotk'
              'dfloti'
              'dflotj'
              'digits'
              'dim'
              'dimag'
              'dint'
              'dlog'
              'dlog10'
              'dmax1'
              'dmin1'
              'dmod'
              'dnint'
              'dot_product'
              'dprod'
              'dreal'
              'dsign'
              'dsin'
              'dsind'
              'dsinh'
              'dsqrt'
              'dtan'
              'dtand'
              'dtanh'
              'eoshift'
              'epsilon'
              'errsns'
              'exp'
              'exponent'
              'float'
              'floati'
              'floatj'
              'floatk'
              'floor'
              'fraction'
              'free'
              'huge'
              'iabs'
              'iachar'
              'iand'
              'ibclr'
              'ibits'
              'ibset'
              'ichar'
              'idate'
              'idim'
              'idint'
              'idnint'
              'ieor'
              'ifix'
              'iiabs'
              'iiand'
              'iibclr'
              'iibits'
              'iibset'
              'iidim'
              'iidint'
              'iidnnt'
              'iieor'
              'iifix'
              'iint'
              'iior'
              'iiqint'
              'iiqnnt'
              'iishft'
              'iishftc'
              'iisign'
              'ilen'
              'imax0'
              'imax1'
              'imin0'
              'imin1'
              'imod'
              'index'
              'inint'
              'inot'
              'int'
              'int1'
              'int2'
              'int4'
              'int8'
              'iqint'
              'iqnint'
              'ior'
              'ishft'
              'ishftc'
              'isign'
              'isnan'
              'izext'
              'jiand'
              'jibclr'
              'jibits'
              'jibset'
              'jidim'
              'jidint'
              'jidnnt'
              'jieor'
              'jifix'
              'jint'
              'jior'
              'jiqint'
              'jiqnnt'
              'jishft'
              'jishftc'
              'jisign'
              'jmax0'
              'jmax1'
              'jmin0'
              'jmin1'
              'jmod'
              'jnint'
              'jnot'
              'jzext'
              'kiabs'
              'kiand'
              'kibclr'
              'kibits'
              'kibset'
              'kidim'
              'kidint'
              'kidnnt'
              'kieor'
              'kifix'
              'kind'
              'kint'
              'kior'
              'kishft'
              'kishftc'
              'kisign'
              'kmax0'
              'kmax1'
              'kmin0'
              'kmin1'
              'kmod'
              'knint'
              'knot'
              'kzext'
              'lbound'
              'leadz'
              'len'
              'len_trim'
              'lenlge'
              'lge'
              'lgt'
              'lle'
              'llt'
              'log'
              'log10'
              'logical'
              'lshift'
              'malloc'
              'matmul'
              'max'
              'max0'
              'max1'
              'maxexponent'
              'maxloc'
              'maxval'
              'merge'
              'min'
              'min0'
              'min1'
              'minexponent'
              'minloc'
              'minval'
              'mod'
              'modulo'
              'mvbits'
              'nearest'
              'nint'
              'not'
              'nworkers'
              'number_of_processors'
              'pack'
              'popcnt'
              'poppar'
              'precision'
              'present'
              'product'
              'radix'
              'random'
              'random_number'
              'random_seed'
              'range'
              'real'
              'repeat'
              'reshape'
              'rrspacing'
              'rshift'
              'scale'
              'scan'
              'secnds'
              'selected_int_kind'
              'selected_real_kind'
              'set_exponent'
              'shape'
              'sign'
              'sin'
              'sind'
              'sinh'
              'size'
              'sizeof'
              'sngl'
              'snglq'
              'spacing'
              'spread'
              'sqrt'
              'sum'
              'system_clock'
              'tan'
              'tand'
              'tanh'
              'tiny'
              'transfer'
              'transpose'
              'trim'
              'ubound'
              'unpack'
              'verify+')
          end
          item
            KeywordListNumber = 2
            Name = 'Extended and user defined functions'
            Keywords.Strings = (
              'cdabs'
              'cdcos'
              'cdexp'
              'cdlog'
              'cdsin'
              'cdsqrt'
              'cotan'
              'cotand'
              'dcmplx'
              'dconjg'
              'dcotan'
              'dcotand'
              'decode'
              'dimag'
              'dll_export'
              'dll_import'
              'doublecomplex'
              'dreal'
              'dvchk'
              'encode'
              'find'
              'flen'
              'flush'
              'getarg'
              'getcharqq'
              'getcl'
              'getdat'
              'getenv'
              'gettim'
              'hfix'
              'ibchng'
              'identifier'
              'imag'
              'int1'
              'int2'
              'int4'
              'intc'
              'intrup'
              'invalop'
              'iostat_msg'
              'isha'
              'ishc'
              'ishl'
              'jfix'
              'lacfar'
              'locking'
              'locnear'
              'map'
              'nargs'
              'nbreak'
              'ndperr'
              'ndpexc'
              'offset'
              'ovefl'
              'peekcharqq'
              'precfill'
              'prompt'
              'qabs'
              'qacos'
              'qacosd'
              'qasin'
              'qasind'
              'qatan'
              'qatand'
              'qatan2'
              'qcmplx'
              'qconjg'
              'qcos'
              'qcosd'
              'qcosh'
              'qdim'
              'qexp'
              'qext'
              'qextd'
              'qfloat'
              'qimag'
              'qlog'
              'qlog10'
              'qmax1'
              'qmin1'
              'qmod'
              'qreal'
              'qsign'
              'qsin'
              'qsind'
              'qsinh'
              'qsqrt'
              'qtan'
              'qtand'
              'qtanh'
              'ran'
              'rand'
              'randu'
              'rewrite'
              'segment'
              'setdat'
              'settim'
              'system'
              'timer'
              'undfl'
              'unlock'
              'union'
              'val'
              'virtual'
              'volatile'
              'zabs'
              'zcos'
              'zexp'
              'zlog'
              'zsin'
              'zsqrt')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '!~'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'FreeBasic'
        Lexer = 'freebasic'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keywords'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PreProcessor'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Date'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String not terminated'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PreProcessor Keywords'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Defined 1'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Defined 2'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Constant'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Asm'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Label'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clRed
            CharCase = CASE_MIXED
            Name = 'Error'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'HexNumber'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'BinNumber'
            StyleNumber = 18
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'append'
              'as'
              'asc'
              'asin'
              'asm'
              'atan2'
              'atn'
              'beep'
              'bin'
              'binary'
              'bit'
              'bitreset'
              'bitset'
              'bload'
              'bsave'
              'byref'
              'byte'
              'byval'
              'call'
              'callocate'
              'case'
              'cbyte'
              'cdbl'
              'cdecl'
              'chain'
              'chdir'
              'chr'
              'cint'
              'circle'
              'clear'
              'clng'
              'clngint'
              'close'
              'cls'
              'color'
              'command'
              'common'
              'cons'
              'const'
              'continue'
              'cos'
              'cshort'
              'csign'
              'csng'
              'csrlin'
              'cubyte'
              'cuint'
              'culngint'
              'cunsg'
              'curdir'
              'cushort'
              'custom'
              'cvd'
              'cvi'
              'cvl'
              'cvlongint'
              'cvs'
              'cvshort'
              'data'
              'date'
              'deallocate'
              'declare'
              'defbyte'
              'defdbl'
              'defined'
              'defint'
              'deflng'
              'deflngint'
              'defshort'
              'defsng'
              'defstr'
              'defubyte'
              'defuint'
              'defulngint'
              'defushort'
              'dim'
              'dir'
              'do'
              'double'
              'draw'
              'dylibload'
              'dylibsymbol'
              'else'
              'elseif'
              'end'
              'enum'
              'environ'
              'environ$'
              'eof'
              'eqv'
              'erase'
              'err'
              'error'
              'exec'
              'exepath'
              'exit'
              'exp'
              'export'
              'extern'
              'field'
              'fix'
              'flip'
              'for'
              'fre'
              'freefile'
              'function'
              'get'
              'getjoystick'
              'getkey'
              'getmouse'
              'gosub'
              'goto'
              'hex'
              'hibyte'
              'hiword'
              'if'
              'iif'
              'imagecreate'
              'imagedestroy'
              'imp'
              'inkey'
              'inp'
              'input'
              'instr'
              'int'
              'integer'
              'is'
              'kill'
              'lbound'
              'lcase'
              'left'
              'len'
              'let'
              'lib'
              'line'
              'lobyte'
              'loc'
              'local'
              'locate'
              'lock'
              'lof'
              'log'
              'long'
              'longint'
              'loop'
              'loword'
              'lset'
              'ltrim'
              'mid'
              'mkd'
              'mkdir'
              'mki'
              'mkl'
              'mklongint'
              'mks'
              'mkshort'
              'mod'
              'multikey'
              'mutexcreate'
              'mutexdestroy'
              'mutexlock'
              'mutexunlock'
              'name'
              'next'
              'not'
              'oct'
              'on'
              'once'
              'open'
              'option'
              'or'
              'out'
              'output'
              'overload'
              'paint'
              'palette'
              'pascal'
              'pcopy'
              'peek'
              'peeki'
              'peeks'
              'pipe'
              'pmap'
              'point'
              'pointer'
              'poke'
              'pokei'
              'pokes'
              'pos'
              'preserve'
              'preset'
              'print'
              'private'
              'procptr'
              'pset'
              'ptr'
              'public'
              'put'
              'random'
              'randomize'
              'read'
              'reallocate'
              'redim'
              'rem'
              'reset'
              'restore'
              'resume'
              'resume'
              'next'
              'return'
              'rgb'
              'rgba'
              'right'
              'rmdir'
              'rnd'
              'rset'
              'rtrim'
              'run'
              'sadd'
              'screen'
              'screencopy'
              'screeninfo'
              'screenlock'
              'screenptr'
              'screenres'
              'screenset'
              'screensync'
              'screenunlock'
              'seek'
              'statement'
              'seek'
              'function'
              'selectcase'
              'setdate'
              'setenviron'
              'setmouse'
              'settime'
              'sgn'
              'shared'
              'shell'
              'shl'
              'short'
              'shr'
              'sin'
              'single'
              'sizeof'
              'sleep'
              'space'
              'spc'
              'sqr'
              'static'
              'stdcall'
              'step'
              'stop'
              'str'
              'string'
              'string'
              'strptr'
              'sub'
              'swap'
              'system'
              'tab'
              'tan'
              'then'
              'threadcreate'
              'threadwait'
              'time'
              'time'
              'timer'
              'to'
              'trans'
              'trim'
              'type'
              'ubound'
              'ubyte'
              'ucase'
              'uinteger'
              'ulongint'
              'union'
              'unlock'
              'unsigned'
              'until'
              'ushort'
              'using'
              'va_arg'
              'va_first'
              'va_next'
              'val'
              'val64'
              'valint'
              'varptr'
              'view'
              'viewprint'
              'wait'
              'wend'
              'while'
              'width'
              'window'
              'windowtitle'
              'with'
              'write'
              'xor'
              'zstring')
          end
          item
            KeywordListNumber = 1
            Name = 'PreProcessor'
            Keywords.Strings = (
              '#define'
              '#dynamic'
              '#else'
              '#endif'
              '#error'
              '#if'
              '#ifdef'
              '#ifndef'
              '#inclib'
              '#include'
              '#print'
              '#static'
              '#undef')
          end
          item
            KeywordListNumber = 2
            Name = 'User Defined 1'
          end
          item
            KeywordListNumber = 3
            Name = 'User Defined 2'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Haskell'
        Lexer = 'haskell'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Character'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Class'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Module'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Capital'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Data'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Import'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Instance'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Commentline'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Commentblock'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Commentblock 2'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Commentblock 3'
            StyleNumber = 16
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'HTML'
        Lexer = 'hypertext'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Text'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Tags'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Tags'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12624032
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Attributes'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Attributes'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Numbers'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted strings'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted strings'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other inside tag'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 9
          end
          item
            FontName = 'Times New Roman'
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 10526880
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Entities'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12632064
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML style tag ends'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 10485920
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier start'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 10485920
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier end'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 15132160
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SCRIPT'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP <% ... %>'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP <% ... %>'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 57343
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'CDATA'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 56797
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unquoted values'
            StyleNumber = 19
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XC Comment'
            StyleNumber = 20
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML tags <! ... >'
            StyleNumber = 21
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML command'
            StyleNumber = 22
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 15793935
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML 1st param'
            StyleNumber = 23
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML double string'
            StyleNumber = 24
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML single string'
            StyleNumber = 25
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML error'
            StyleNumber = 26
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16737843
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML special'
            StyleNumber = 27
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML entity'
            StyleNumber = 28
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML comment'
            StyleNumber = 29
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlue
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML block'
            StyleNumber = 31
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 32639
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Start'
            StyleNumber = 40
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Default'
            StyleNumber = 41
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Comment'
            StyleNumber = 42
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Line Comment'
            StyleNumber = 43
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Doc Comment'
            StyleNumber = 44
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Number'
            StyleNumber = 45
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Word'
            StyleNumber = 46
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Keyword'
            StyleNumber = 47
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Double quoted string'
            StyleNumber = 48
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Single quoted string'
            StyleNumber = 49
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Symbols'
            StyleNumber = 50
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS EOL'
            StyleNumber = 51
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16724672
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Regex'
            StyleNumber = 52
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 32639
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP JS Start'
            StyleNumber = 55
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP JS Default'
            StyleNumber = 56
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP JS Comment'
            StyleNumber = 57
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP JS Line Comment'
            StyleNumber = 58
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP JS Doc Comment'
            StyleNumber = 59
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP JS Number'
            StyleNumber = 60
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 14737632
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP JS Word'
            StyleNumber = 61
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP JS Keyword'
            StyleNumber = 62
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP JS Double quoted string'
            StyleNumber = 63
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP JS Single quoted string'
            StyleNumber = 64
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP JS Symbols'
            StyleNumber = 65
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP JS EOL'
            StyleNumber = 66
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16724672
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP JS Regex'
            StyleNumber = 67
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS Default'
            StyleNumber = 71
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS Comment'
            StyleNumber = 72
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS Number'
            StyleNumber = 73
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS KeyWord'
            StyleNumber = 74
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS String'
            StyleNumber = 75
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS Identifier'
            StyleNumber = 76
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS Unterminated string'
            StyleNumber = 77
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Default'
            StyleNumber = 81
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Comment'
            StyleNumber = 82
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Number'
            StyleNumber = 83
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP KeyWord'
            StyleNumber = 84
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP String'
            StyleNumber = 85
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Identifier'
            StyleNumber = 86
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Unterminated string'
            StyleNumber = 87
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Python Start'
            StyleNumber = 90
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Default'
            StyleNumber = 91
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Comment'
            StyleNumber = 92
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Number'
            StyleNumber = 93
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python String'
            StyleNumber = 94
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Single quoted string'
            StyleNumber = 95
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Keyword'
            StyleNumber = 96
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 127
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Triple quotes'
            StyleNumber = 97
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 127
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Triple double quotes'
            StyleNumber = 98
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clBlue
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Class name definition'
            StyleNumber = 99
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 8355584
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python function or method name definition'
            StyleNumber = 100
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python function or method name definition'
            StyleNumber = 101
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Identifiers'
            StyleNumber = 102
          end
          item
            FontSize = 0
            FontStyles = [fsItalic]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Complex Variable'
            StyleNumber = 104
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'ASP Python Start'
            StyleNumber = 105
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Python Default'
            StyleNumber = 106
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Python Comment'
            StyleNumber = 107
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Python Number'
            StyleNumber = 108
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Python String'
            StyleNumber = 109
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Python Single quoted string'
            StyleNumber = 110
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Python Keyword'
            StyleNumber = 111
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 127
            BackColor = 13627343
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Python Triple quotes'
            StyleNumber = 112
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 127
            BackColor = 13627343
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Python Triple double quotes'
            StyleNumber = 113
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clBlue
            BackColor = 13627343
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Python Class name definition'
            StyleNumber = 114
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 8355584
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Python function or method name definition'
            StyleNumber = 115
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = 13627343
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Python function or method name definition'
            StyleNumber = 116
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = 13627343
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'ASP Python Identifiers'
            StyleNumber = 117
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'PHP Default'
            StyleNumber = 118
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Double quoted string'
            StyleNumber = 119
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Single quoted string'
            StyleNumber = 120
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Keyword'
            StyleNumber = 121
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Number'
            StyleNumber = 122
          end
          item
            FontSize = 0
            FontStyles = [fsItalic]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Variable'
            StyleNumber = 123
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Comment'
            StyleNumber = 124
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP One line Comment'
            StyleNumber = 125
          end
          item
            FontSize = 0
            FontStyles = [fsItalic]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Variable in double quoted string'
            StyleNumber = 126
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP operator'
            StyleNumber = 127
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'HyperText'
            Keywords.Strings = (
              'a'
              'abbr'
              'acronym'
              'address'
              'applet'
              'area'
              'b'
              'base'
              'basefont'
              'bdo'
              'big'
              'blockquote'
              'body'
              'br'
              'button'
              'caption'
              'center'
              'cite'
              'code'
              'col'
              'colgroup'
              'dd'
              'del'
              'dfn'
              'dir'
              'div'
              'dl'
              'dt'
              'em'
              'fieldset'
              'font'
              'form'
              'frame'
              'frameset'
              'h1'
              'h2'
              'h3'
              'h4'
              'h5'
              'h6'
              'head'
              'hr'
              'html'
              'i'
              'iframe'
              'img'
              'input'
              'ins'
              'isindex'
              'kbd'
              'label'
              'legend'
              'li'
              'link'
              'map'
              'menu'
              'meta'
              'noframes'
              'noscript'
              'object'
              'ol'
              'optgroup'
              'option'
              'p'
              'param'
              'pre'
              'q'
              's'
              'samp'
              'script'
              'select'
              'small'
              'span'
              'strike'
              'strong'
              'style'
              'sub'
              'sup'
              'table'
              'tbody'
              'td'
              'textarea'
              'tfoot'
              'th'
              'thead'
              'title'
              'tr'
              'tt'
              'u'
              'ul'
              'var'
              'xml'
              'xmlns'
              'abbr'
              'accept-charset'
              'accept'
              'accesskey'
              'action'
              'align'
              'alink'
              'alt'
              'archive'
              'axis'
              'background'
              'bgcolor'
              'border'
              'cellpadding'
              'cellspacing'
              'char'
              'charoff'
              'charset'
              'checked'
              'cite'
              'class'
              'classid'
              'clear'
              'codebase'
              'codetype'
              'color'
              'cols'
              'colspan'
              'compact'
              'content'
              'coords'
              'data'
              'datafld'
              'dataformatas'
              'datapagesize'
              'datasrc'
              'datetime'
              'declare'
              'defer'
              'dir'
              'disabled'
              'enctype'
              'event'
              'face'
              'for'
              'frame'
              'frameborder'
              'headers'
              'height'
              'href'
              'hreflang'
              'hspace'
              'http-equiv'
              'id'
              'ismap'
              'label'
              'lang'
              'language'
              'leftmargin'
              'link'
              'longdesc'
              'marginwidth'
              'marginheight'
              'maxlength'
              'media'
              'method'
              'multiple'
              'name'
              'nohref'
              'noresize'
              'noshade'
              'nowrap'
              'object'
              'onblur'
              'onchange'
              'onclick'
              'ondblclick'
              'onfocus'
              'onkeydown'
              'onkeypress'
              'onkeyup'
              'onload'
              'onmousedown'
              'onmousemove'
              'onmouseover'
              'onmouseout'
              'onmouseup'
              'onreset'
              'onselect'
              'onsubmit'
              'onunload'
              'profile'
              'prompt'
              'readonly'
              'rel'
              'rev'
              'rows'
              'rowspan'
              'rules'
              'scheme'
              'scope'
              'selected'
              'shape'
              'size'
              'span'
              'src'
              'standby'
              'start'
              'style'
              'summary'
              'tabindex'
              'target'
              'text'
              'title'
              'topmargin'
              'type'
              'usemap'
              'valign'
              'value'
              'valuetype'
              'version'
              'vlink'
              'vspace'
              'width'
              'text'
              'password'
              'checkbox'
              'radio'
              'submit'
              'reset'
              'file'
              'hidden'
              'image'
              'framespacing'
              'scrolling'
              'allowtransparency'
              'bordercolor')
          end
          item
            KeywordListNumber = 1
            Name = 'JavaScript'
            Keywords.Strings = (
              'abstract'
              'boolean'
              'break'
              'byte'
              'case'
              'catch'
              'char'
              'class'
              'const'
              'continue'
              'debugger'
              'default'
              'delete'
              'do'
              'double'
              'else'
              'enum'
              'export'
              'extends'
              'final'
              'finally'
              'float'
              'for'
              'function'
              'goto'
              'if'
              'implements'
              'import'
              'in'
              'instanceof'
              'int'
              'interface'
              'long'
              'native'
              'new'
              'package'
              'private'
              'protected'
              'public'
              'return'
              'short'
              'static'
              'super'
              'switch'
              'synchronized'
              'this'
              'throw'
              'throws'
              'transient'
              'try'
              'typeof'
              'var'
              'void'
              'volatile'
              'while'
              'with')
          end
          item
            KeywordListNumber = 2
            Name = 'VBScript'
            Keywords.Strings = (
              'and'
              'begin'
              'case'
              'call'
              'class'
              'continue'
              'do'
              'each'
              'else'
              'elseif'
              'end'
              'erase'
              'error'
              'event'
              'exit'
              'false'
              'for'
              'function'
              'get'
              'gosub'
              'goto'
              'if'
              'implement'
              'in'
              'load'
              'loop'
              'lset'
              'me'
              'mid'
              'new'
              'next'
              'not'
              'nothing'
              'on'
              'or'
              'property'
              'raiseevent'
              'rem'
              'resume'
              'return'
              'rset'
              'select'
              'set'
              'stop'
              'sub'
              'then'
              'to'
              'true'
              'unload'
              'until'
              'wend'
              'while'
              'with'
              'withevents'
              'attribute'
              'alias'
              'as'
              'boolean'
              'byref'
              'byte'
              'byval'
              'const'
              'compare'
              'currency'
              'date'
              'declare'
              'dim'
              'double'
              'enum'
              'explicit'
              'friend'
              'global'
              'integer'
              'let'
              'lib'
              'long'
              'module'
              'object'
              'option'
              'optional'
              'preserve'
              'private'
              'public'
              'redim'
              'single'
              'static'
              'string'
              'type'
              'variant')
          end
          item
            KeywordListNumber = 3
            Name = 'Python'
            Keywords.Strings = (
              'and'
              'assert'
              'break'
              'class'
              'continue'
              'def'
              'del'
              'elif'
              'else'
              'except'
              'exec'
              'finally'
              'for'
              'from'
              'global'
              'if'
              'import'
              'in'
              'is'
              'lambda'
              'None'
              'not'
              'or'
              'pass'
              'print'
              'raise'
              'return'
              'try'
              'while'
              'yield')
          end
          item
            KeywordListNumber = 4
            Name = 'PHP'
            Keywords.Strings = (
              'and'
              'array'
              'as'
              'bool'
              'boolean'
              'break'
              'case'
              'cfunction'
              'class'
              'const'
              'continue'
              'declare'
              'default'
              'die'
              'directory'
              'do'
              'double'
              'echo'
              'else'
              'elseif'
              'empty'
              'enddeclare'
              'endfor'
              'endforeach'
              'endif'
              'endswitch'
              'endwhile'
              'eval'
              'exit'
              'extends'
              'false'
              'float'
              'for'
              'foreach'
              'function'
              'global'
              'if'
              'include'
              'include_once'
              'int'
              'integer'
              'isset'
              'list'
              'new'
              'null'
              'object'
              'old_function'
              'or'
              'parent'
              'print'
              'real'
              'require'
              'require_once'
              'resource'
              'return'
              'static'
              'stdclass'
              'string'
              'switch'
              'true'
              'unset'
              'use'
              'var'
              'while'
              'xor'
              'abstract'
              'catch'
              'clone'
              'exception'
              'final'
              'implements'
              'interface'
              'php_user_filter'
              'private'
              'protected'
              'public'
              'this'
              'throw'
              'try'
              '__class__'
              '__file__'
              '__function__'
              '__line__'
              '__method__'
              '__sleep'
              '__wakeup')
          end
          item
            KeywordListNumber = 5
            Name = 'DTD Keywords'
            Keywords.Strings = (
              'ELEMENT'
              'DOCTYPE'
              'ATTLIST'
              'ENTITY'
              'NOTATION')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '<!--'
        CommentBoxEnd = '-->'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '<!--'
        CommentStreamEnd = '-->'
        NumStyleBits = 7
      end
      item
        Name = 'IDL'
        Lexer = 'cpp'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Symbols/UUID'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'EOL if string is not closed'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Verbatim strings for C#'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16724672
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Regular expressions'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment Line'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User-defined keywords'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment keyword'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment keyword error'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Global classes and typedefs'
            StyleNumber = 19
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Primary keywords and identifiers'
            Keywords.Strings = (
              'aggregatable'
              'allocate'
              'appobject'
              'arrays'
              'async'
              'async_uuid'
              'auto_handle'
              'bindable'
              'boolean'
              'broadcast'
              'byte'
              'byte_count'
              'call_as'
              'callback'
              'char'
              'coclass'
              'code'
              'comm_status'
              'const'
              'context_handle'
              'context_handle_noserialize'
              'context_handle_serialize'
              'control'
              'cpp_quote'
              'custom'
              'decode'
              'default'
              'defaultbind'
              'defaultcollelem'
              'defaultvalue'
              'defaultvtable'
              'dispinterface'
              'displaybind'
              'dllname'
              'double'
              'dual'
              'enable_allocate'
              'encode'
              'endpoint'
              'entry'
              'enum'
              'error_status_t'
              'explicit_handle'
              'fault_status'
              'first_is'
              'float'
              'handle_t'
              'heap'
              'helpcontext'
              'helpfile'
              'helpstring'
              'helpstringcontext'
              'helpstringdll'
              'hidden'
              'hyper'
              'id'
              'idempotent'
              'ignore'
              'iid_as'
              'iid_is'
              'immediatebind'
              'implicit_handle'
              'import'
              'importlib'
              'in'
              'include'
              'in_line'
              'int'
              '__int64'
              '__int3264'
              'interface'
              'last_is'
              'lcid'
              'length_is'
              'library'
              'licensed'
              'local'
              'long'
              'max_is'
              'maybe'
              'message'
              'methods'
              'midl_pragma'
              'midl_user_allocate'
              'midl_user_free'
              'min_is'
              'module'
              'ms_union'
              'ncacn_at_dsp'
              'ncacn_dnet_nsp'
              'ncacn_http'
              'ncacn_ip_tcp'
              'ncacn_nb_ipx'
              'ncacn_nb_nb'
              'ncacn_nb_tcp'
              'ncacn_np'
              'ncacn_spx'
              'ncacn_vns_spp'
              'ncadg_ip_udp'
              'ncadg_ipx'
              'ncadg_mq'
              'ncalrpc'
              'nocode'
              'nonbrowsable'
              'noncreatable'
              'nonextensible'
              'notify'
              'object'
              'odl'
              'oleautomation'
              'optimize'
              'optional'
              'out'
              'out_of_line'
              'pipe'
              'pointer_default'
              'pragma'
              'properties'
              'propget'
              'propput'
              'propputref'
              'ptr'
              'public'
              'range'
              'readonly'
              'ref'
              'represent_as'
              'requestedit'
              'restricted'
              'retval'
              'shape'
              'short'
              'signed'
              'size_is'
              'small'
              'source'
              'strict_context_handle'
              'string'
              'struct'
              'switch'
              'switch_is'
              'switch_type'
              'transmit_as'
              'typedef'
              'uidefault'
              'union'
              'unique'
              'unsigned'
              'user_marshal'
              'usesgetlasterror'
              'uuid'
              'v1_enum'
              'vararg'
              'version'
              'void'
              'wchar_t'
              'wire_marshal'
              'attribute'
              'native'
              'noscript'
              'scriptable'
              'shared'
              'wstring'
              'inout')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Inno Setup'
        Lexer = 'inno'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Parameter'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Section'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor (inline)'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Pascal Comment'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Pascal Keyword'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Userdefined Keywords'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 12
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Sections'
            Keywords.Strings = (
              'code'
              'components'
              'custommessages'
              'dirs'
              'files'
              'icons'
              'ini'
              'installdelete'
              'langoptions'
              'languages'
              'messages'
              'registry'
              'run'
              'setup'
              'types'
              'tasks'
              'uninstalldelete'
              'uninstallrun')
          end
          item
            KeywordListNumber = 1
            Name = 'Keywords'
            Keywords.Strings = (
              'allowcancelduringinstall'
              'allownoicons'
              'allowrootdirectory'
              'allowuncpath'
              'alwaysrestart'
              'alwaysshowcomponentslist'
              'alwaysshowdironreadypage'
              'alwaysshowgrouponreadypage'
              'alwaysusepersonalgroup'
              'appcomments'
              'appcontact'
              'appcopyright'
              'appenddefaultdirname'
              'appenddefaultgroupname'
              'appid'
              'appmodifypath'
              'appmutex'
              'appname'
              'apppublisher'
              'apppublisherurl'
              'appreadmefile'
              'appsupporturl'
              'appupdatesurl'
              'appvername'
              'appversion'
              'architecturesallowed'
              'architecturesinstallin64bitmode'
              'backcolor'
              'backcolor2'
              'backcolordirection'
              'backsolid'
              'changesassociations'
              'changesenvironment'
              'compression'
              'copyrightfontname'
              'copyrightfontsize'
              'createappdir'
              'createuninstallregkey'
              'defaultdirname'
              'defaultgroupname'
              'defaultuserinfoname'
              'defaultuserinfoorg'
              'defaultuserinfoserial'
              'dialogfontname'
              'dialogfontsize'
              'direxistswarning'
              'disabledirpage'
              'disablefinishedpage'
              'disableprogramgrouppage'
              'disablereadymemo'
              'disablereadypage'
              'disablestartupprompt'
              'diskclustersize'
              'diskslicesize'
              'diskspanning'
              'enablesdirdoesntexistwarning'
              'encryption'
              'extradiskspacerequired'
              'flatcomponentslist'
              'infoafterfile'
              'infobeforefile'
              'internalcompresslevel'
              'languagedetectionmethod'
              'languagecodepage'
              'languageid'
              'languagename'
              'licensefile'
              'mergeduplicatefiles'
              'minversion'
              'onlybelowversion'
              'outputbasefilename'
              'outputdir'
              'outputmanifestfile'
              'password'
              'privilegesrequired'
              'reservebytes'
              'restartifneededbyrun'
              'setupiconfile'
              'showcomponentsizes'
              'showlanguagedialog'
              'showtaskstreelines'
              'slicesperdisk'
              'solidcompression'
              'sourcedir'
              'timestamprounding'
              'timestampsinutc'
              'titlefontname'
              'titlefontsize'
              'touchdate'
              'touchtime'
              'uninstallable'
              'uninstalldisplayicon'
              'uninstalldisplayname'
              'uninstallfilesdir'
              'uninstalllogmode'
              'uninstallrestartcomputer'
              'updateuninstalllogappname'
              'usepreviousappdir'
              'usepreviousgroup'
              'useprevioussetuptype'
              'useprevioustasks'
              'useprevioususerinfo'
              'userinfopage'
              'usesetupldr'
              'versioninfocompany'
              'versioninfocopyright'
              'versioninfodescription'
              'versioninfotextversion'
              'versioninfoversion'
              'welcomefontname'
              'welcomefontsize'
              'windowshowcaption'
              'windowstartmaximized'
              'windowresizable'
              'windowvisible'
              'wizardimagebackcolor'
              'wizardimagefile'
              'wizardimagestretch'
              'wizardsmallimagefile')
          end
          item
            KeywordListNumber = 2
            Name = 'Parameters'
            Keywords.Strings = (
              'afterinstall'
              'attribs'
              'beforeinstall'
              'check'
              'comment'
              'components'
              'copymode'
              'description'
              'destdir'
              'destname'
              'excludes'
              'extradiskspacerequired'
              'filename'
              'flags'
              'fontinstall'
              'groupdescription'
              'hotkey'
              'infoafterfile'
              'infobeforefile'
              'iconfilename'
              'iconindex'
              'key'
              'languages'
              'licensefile'
              'messagesfile'
              'minversion'
              'name'
              'onlybelowversion'
              'parameters'
              'permissions'
              'root'
              'runonceid'
              'section'
              'source'
              'statusmsg'
              'string'
              'subkey'
              'tasks'
              'type'
              'types'
              'valuedata'
              'valuename'
              'valuetype'
              'workingdir')
          end
          item
            KeywordListNumber = 3
            Name = 'Preprocessor directives'
            Keywords.Strings = (
              'append'
              'define'
              'dim'
              'else'
              'emit'
              'endif'
              'endsub'
              'error'
              'expr'
              'file'
              'for'
              'if'
              'ifdef'
              'ifexist'
              'ifndef'
              'ifnexist'
              'include'
              'insert'
              'pragma'
              'sub'
              'undef')
          end
          item
            KeywordListNumber = 4
            Name = 'Pascal keywords'
            Keywords.Strings = (
              'begin'
              'break'
              'case'
              'const'
              'continue'
              'do'
              'downto'
              'else'
              'end'
              'except'
              'finally'
              'for'
              'function'
              'if'
              'of'
              'procedure'
              'repeat'
              'then'
              'to'
              'try'
              'until'
              'uses'
              'var'
              'while'
              'with')
          end
          item
            KeywordListNumber = 5
            Name = 'Userdefined Keywords'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = ';'
        CommentBoxEnd = ';'
        CommentBoxMiddle = ';'
        CommentBlock = ';'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Java'
        Lexer = 'cpp'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Symbols/UUID'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'EOL if string is not closed'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Verbatim strings for C#'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16724672
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Regular expressions'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment Line'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User-defined keywords'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment keyword'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment keyword error'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Global classes and typedefs'
            StyleNumber = 19
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'abstract'
              'boolean'
              'break'
              'byte'
              'case'
              'catch'
              'char'
              'class'
              'const'
              'continue'
              'debugger'
              'default'
              'delete'
              'do'
              'double'
              'else'
              'enum'
              'export'
              'extends'
              'final'
              'finally'
              'float'
              'for'
              'function'
              'goto'
              'if'
              'implements'
              'import'
              'in'
              'instanceof'
              'int'
              'interface'
              'long'
              'native'
              'new'
              'package'
              'private'
              'protected'
              'public'
              'return'
              'short'
              'static'
              'super'
              'switch'
              'synchronized'
              'this'
              'throw'
              'throws'
              'transient'
              'try'
              'typeof'
              'var'
              'void'
              'volatile'
              'while'
              'with'
              'true'
              'false'
              'null')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'JavaScript'
        Lexer = 'cpp'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Symbols/UUID'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'EOL if string is not closed'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Verbatim strings for C#'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clAqua
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Regular expressions'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment Line'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User-defined keywords'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment keyword'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment keyword error'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Global classes and typedefs'
            StyleNumber = 19
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'abstract'
              'boolean'
              'break'
              'byte'
              'case'
              'catch'
              'char'
              'class'
              'const'
              'continue'
              'debugger'
              'default'
              'delete'
              'do'
              'double'
              'else'
              'enum'
              'export'
              'extends'
              'final'
              'finally'
              'float'
              'for'
              'function'
              'goto'
              'if'
              'implements'
              'import'
              'in'
              'instanceof'
              'int'
              'interface'
              'long'
              'native'
              'new'
              'package'
              'private'
              'protected'
              'public'
              'return'
              'short'
              'static'
              'super'
              'switch'
              'synchronized'
              'this'
              'throw'
              'throws'
              'transient'
              'try'
              'typeof'
              'var'
              'void'
              'volatile'
              'while'
              'with'
              'true'
              'false'
              'null')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'KIX'
        Lexer = 'kix'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'WhiteSpace'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String 2'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Variables'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Macro'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Function'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 9
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Commands'
            Keywords.Strings = (
              '?'
              'and'
              'beep'
              'big'
              'break'
              'call'
              'cd'
              'cls'
              'color'
              'cookie1'
              'copy'
              'debug'
              'del'
              'dim'
              'display'
              'do'
              'until'
              'exit'
              'flushkb'
              'for'
              'each'
              'next'
              'function'
              'endfunction'
              'get'
              'gets'
              'global'
              'go'
              'gosub'
              'goto'
              'if'
              'else'
              'endif'
              'md'
              'or'
              'password'
              'play'
              'quit'
              'rd'
              'redim'
              'return'
              'run'
              'select'
              'case'
              'endselect'
              'set'
              'setl'
              'setm'
              'settime'
              'shell'
              'sleep'
              'small'
              'use'
              'while'
              'loop')
          end
          item
            KeywordListNumber = 1
            Name = 'Functions'
            Keywords.Strings = (
              'abs'
              'addkey'
              'addprinterconnection'
              'addprogramgroup'
              'addprogramitem'
              'asc'
              'ascan'
              'at'
              'backupeventlog'
              'box'
              'cdbl'
              'chr'
              'cint'
              'cleareventlog'
              'close'
              'comparefiletimes'
              'createobject'
              'cstr'
              'dectohex'
              'delkey'
              'delprinterconnection'
              'delprogramgroup'
              'delprogramitem'
              'deltree'
              'delvalue'
              'dir'
              'enumgroup'
              'enumipinfo'
              'enumkey'
              'enumlocalgroup'
              'enumvalue'
              'execute'
              'exist'
              'existkey'
              'expandenvironmentvars'
              'fix'
              'formatnumber'
              'freefilehandle'
              'getdiskspace'
              'getfileattr'
              'getfilesize'
              'getfiletime'
              'getfileversion'
              'getobject'
              'iif'
              'ingroup'
              'instr'
              'instrrev'
              'int'
              'isdeclared'
              'join'
              'kbhit'
              'keyexist'
              'lcase'
              'left'
              'len'
              'loadhive'
              'loadkey'
              'logevent'
              'logoff'
              'ltrim'
              'memorysize'
              'messagebox'
              'open'
              'readline'
              'readprofilestring'
              'readtype'
              'readvalue'
              'redirectoutput'
              'right'
              'rnd'
              'round'
              'rtrim'
              'savekey'
              'sendkeys'
              'sendmessage'
              'setascii'
              'setconsole'
              'setdefaultprinter'
              'setfileattr'
              'setfocus'
              'setoption'
              'setsystemstate'
              'settitle'
              'setwallpaper'
              'showprogramgroup'
              'shutdown'
              'sidtoname'
              'split'
              'srnd'
              'substr'
              'trim'
              'ubound'
              'ucase'
              'unloadhive'
              'val'
              'vartype'
              'vartypename'
              'writeline'
              'writeprofilestring'
              'writevalue')
          end
          item
            KeywordListNumber = 2
            Name = 'Macro'
            Keywords.Strings = (
              'address'
              'build'
              'color'
              'comment'
              'cpu'
              'crlf'
              'csd'
              'curdir'
              'date'
              'day'
              'domain'
              'dos'
              'error'
              'fullname'
              'homedir'
              'homedrive'
              'homeshr'
              'hostname'
              'inwin'
              'ipaddress0'
              'ipaddress1'
              'ipaddress2'
              'ipaddress3'
              'kix'
              'lanroot'
              'ldomain'
              'ldrive'
              'lm'
              'logonmode'
              'longhomedir'
              'lserver'
              'maxpwage'
              'mdayno'
              'mhz'
              'monthno'
              'month'
              'msecs'
              'pid'
              'primarygroup'
              'priv'
              'productsuite'
              'producttype'
              'pwage'
              'ras'
              'result'
              'rserver'
              'scriptdir'
              'scriptexe'
              'scriptname'
              'serror'
              'sid'
              'site'
              'startdir'
              'syslang'
              'ticks'
              'time'
              'userid'
              'userlang'
              'wdayno'
              'wksta'
              'wuserid'
              'ydayno'
              'year')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = ';'
        CommentBoxEnd = ';'
        CommentBoxMiddle = ';'
        CommentBlock = ';'
        CommentAtLineStart = True
        CommentStreamStart = ';'
        CommentStreamEnd = ';'
        NumStyleBits = 5
      end
      item
        Name = 'LaTeX'
        Lexer = 'latex'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'WhiteSpace'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Command'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Tag'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Math'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 4
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Lisp'
        Lexer = 'lisp'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White Space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'End of line where string is not closed'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifiers'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Special'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Multi Comment'
            StyleNumber = 12
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'not'
              'defun'
              '+'
              '-'
              '*'
              '/'
              '='
              '<'
              '>'
              '<='
              '>='
              'princ'
              'eval'
              'apply'
              'funcall'
              'quote'
              'identity'
              'function'
              'complement'
              'backquote'
              'lambda'
              'set'
              'setq'
              'setf'
              'defun'
              'defmacro'
              'gensym'
              'make'
              'symbol'
              'intern'
              'symbol'
              'name'
              'symbol'
              'value'
              'symbol'
              'plist'
              'get'
              'getf'
              'putprop'
              'remprop'
              'hash'
              'make'
              'array'
              'aref'
              'car'
              'cdr'
              'caar'
              'cadr'
              'cdar'
              'cddr'
              'caaar'
              'caadr'
              'cadar'
              'caddr'
              'cdaar'
              'cdadr'
              'cddar'
              'cdddr'
              'caaaar'
              'caaadr'
              'caadar'
              'caaddr'
              'cadaar'
              'cadadr'
              'caddar'
              'cadddr'
              'cdaaar'
              'cdaadr'
              'cdadar'
              'cdaddr'
              'cddaar'
              'cddadr'
              'cdddar'
              'cddddr'
              'cons'
              'list'
              'append'
              'reverse'
              'last'
              'nth'
              'nthcdr'
              'member'
              'assoc'
              'subst'
              'sublis'
              'nsubst'
              'nsublis'
              'remove'
              'length'
              'list'
              'length'
              'mapc'
              'mapcar'
              'mapl'
              'maplist'
              'mapcan'
              'mapcon'
              'rplaca'
              'rplacd'
              'nconc'
              'delete'
              'atom'
              'symbolp'
              'numberp'
              'boundp'
              'null'
              'listp'
              'consp'
              'minusp'
              'zerop'
              'plusp'
              'evenp'
              'oddp'
              'eq'
              'eql'
              'equal'
              'cond'
              'case'
              'and'
              'or'
              'let'
              'l'
              'if'
              'prog'
              'prog1'
              'prog2'
              'progn'
              'go'
              'return'
              'do'
              'dolist'
              'dotimes'
              'catch'
              'throw'
              'error'
              'cerror'
              'break'
              'continue'
              'errset'
              'baktrace'
              'evalhook'
              'truncate'
              'float'
              'rem'
              'min'
              'max'
              'abs'
              'sin'
              'cos'
              'tan'
              'expt'
              'exp'
              'sqrt'
              'random'
              'logand'
              'logior'
              'logxor'
              'lognot'
              'bignums'
              'logeqv'
              'lognand'
              'lognor'
              'logorc2'
              'logtest'
              'logbitp'
              'logcount'
              'integer'
              'length'
              'nil')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = ';;'
        CommentBoxEnd = ';;'
        CommentBoxMiddle = ';;'
        CommentBlock = ';'
        CommentAtLineStart = True
        CommentStreamStart = ';;'
        CommentStreamEnd = ';;'
        NumStyleBits = 5
      end
      item
        Name = 'LUA'
        Lexer = 'lua'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White Space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Block Comment (5.0)'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Char'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Literal String'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor (obsolete in Lua 4.0 and up)'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            Name = 'EOL when string not closed'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other Keywords 1 (testcolors)'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other Keywords 2 (testcolors)'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other Keywords 3 (testcolors)'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other Keywords 4 (testcolors)'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other Keywords 5 (testcolors)'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other Keywords 6 (testcolors)'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other Keywords 7 (testcolors)'
            StyleNumber = 19
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'and'
              'break'
              'do'
              'else'
              'elseif'
              'end'
              'false'
              'for'
              'function'
              'if'
              'in'
              'local'
              'nil'
              'not'
              'or'
              'repeat'
              'return'
              'then'
              'true'
              'until'
              'while')
          end
          item
            KeywordListNumber = 1
            Name = 'Basic Functions'
            Keywords.Strings = (
              '_VERSION'
              'assert'
              'collectgarbage'
              'dofile'
              'error'
              'gcinfo'
              'loadfile'
              'loadstring'
              'print'
              'tonumber'
              'tostring'
              'type'
              'unpack'
              '_ALERT'
              '_ERRORMESSAGE'
              '_INPUT'
              '_PROMPT'
              '_OUTPUT'
              '_STDERR'
              '_STDIN'
              '_STDOUT'
              'call'
              'dostring'
              'foreach'
              'foreachi'
              'getn'
              'globals'
              'newtype'
              'rawget'
              'rawset'
              'require'
              'sort'
              'tinsert'
              'tremove'
              '_G'
              'getfenv'
              'getmetatable'
              'ipairs'
              'loadlib'
              'next'
              'pairs'
              'pcall'
              'rawegal'
              'rawget'
              'rawset'
              'require'
              'setfenv'
              'setmetatable'
              'xpcall'
              'string'
              'table'
              'math'
              'coroutine'
              'io'
              'os'
              'debug')
          end
          item
            KeywordListNumber = 2
            Name = 'String, (table) & math functions'
            Keywords.Strings = (
              'abs'
              'acos'
              'asin'
              'atan'
              'atan2'
              'ceil'
              'cos'
              'deg'
              'exp'
              'floor'
              'format'
              'frexp'
              'gsub'
              'ldexp'
              'log'
              'log10'
              'max'
              'min'
              'mod'
              'rad'
              'random'
              'randomseed'
              'sin'
              'sqrt'
              'strbyte'
              'strchar'
              'strfind'
              'strlen'
              'strlower'
              'strrep'
              'strsub'
              'strupper'
              'tan'
              'string.byte'
              'string.char'
              'string.dump'
              'string.find'
              'string.len'
              'string.lower'
              'string.rep'
              'string.sub'
              'string.upper'
              'string.format'
              'string.gfind'
              'string.gsub'
              'table.concat'
              'table.foreach'
              'table.foreachi'
              'table.getn'
              'table.sort'
              'table.insert'
              'table.remove'
              'table.setn'
              'math.abs'
              'math.acos'
              'math.asin'
              'math.atan'
              'math.atan2'
              'math.ceil'
              'math.cos'
              'math.deg'
              'math.exp'
              'math.floor'
              'math.frexp'
              'math.ldexp'
              'math.log'
              'math.log10'
              'math.max'
              'math.min'
              'math.mod'
              'math.pi'
              'math.rad'
              'math.random'
              'math.randomseed'
              'math.sin'
              'math.sqrt'
              'math.tan')
          end
          item
            KeywordListNumber = 3
            Name = '(coroutines), I/O & system facilities'
            Keywords.Strings = (
              'openfile'
              'closefile'
              'readfrom'
              'writeto'
              'appendto'
              'remove'
              'rename'
              'flush'
              'seek'
              'tmpfile'
              'tmpname'
              'read'
              'write'
              'clock'
              'date'
              'difftime'
              'execute'
              'exit'
              'getenv'
              'setlocale'
              'time'
              'coroutine.create'
              'coroutine.resume'
              'coroutine.status'
              'coroutine.wrap'
              'coroutine.yield'
              'io.close'
              'io.flush'
              'io.input'
              'io.lines'
              'io.open'
              'io.output'
              'io.read'
              'io.tmpfile'
              'io.type'
              'io.write'
              'io.stdin'
              'io.stdout'
              'io.stderr'
              'os.clock'
              'os.date'
              'os.difftime'
              'os.execute'
              'os.exit'
              'os.getenv'
              'os.remove'
              'os.rename'
              'os.setlocale'
              'os.time'
              'os.tmpname')
          end
          item
            KeywordListNumber = 4
            Name = '???'
          end
          item
            KeywordListNumber = 5
            Name = '??? 2'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '--[['
        CommentBoxEnd = ']]'
        CommentBoxMiddle = '*'
        CommentBlock = '--'
        CommentAtLineStart = True
        CommentStreamStart = '--[['
        CommentStreamEnd = ']]'
        NumStyleBits = 5
      end
      item
        Name = 'Makefile'
        Lexer = 'makefile'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Variable'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 10089408
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 238
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Target'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clRed
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Error'
            StyleNumber = 9
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '#'
        CommentBoxEnd = '#'
        CommentBoxMiddle = '#'
        CommentBlock = '#'
        CommentAtLineStart = True
        CommentStreamStart = '#'
        CommentStreamEnd = '#'
        NumStyleBits = 5
      end
      item
        Name = 'MMixal'
        Lexer = 'mmixal'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Divsion of leading whitespace in line'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 127
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Label'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Opcode (not validated)'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Division between Label and Opcode'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Valid Opcode'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Unknown Opcode'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Division between Opcode and Operands'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Division of Operands'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Number'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Reference (to a Label)'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Char'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'String'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 8323199
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Register'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Hexadecimal Number'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Operator'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Symbol'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Preprocessor'
            StyleNumber = 17
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Operation Codes'
            Keywords.Strings = (
              '2ADDU'
              '4ADDU'
              '8ADDU'
              '16ADDU'
              'ADD'
              'ADDU'
              'AND'
              'ANDNH'
              'ANDNL'
              'ANDNMH'
              'ANDNML'
              'BDIF'
              'BEV'
              'BN'
              'BNN'
              'BNP'
              'BNZ'
              'BOD'
              'BP'
              'BSPEC'
              'BYTE'
              'BZ'
              'CMP'
              'CMPU'
              'CSEV'
              'CSN'
              'CSNN'
              'CSNP'
              'CSNZ'
              'CSOD'
              'CSP'
              'CSWAP'
              'CSZ'
              'DIV'
              'DIVU'
              'ESPEC'
              'EXPR'
              'FADD'
              'FCMP'
              'FCMPE'
              'FDIV'
              'FEQL'
              'FEQLE'
              'FIX'
              'FIXU'
              'FLOT'
              'FLOTU'
              'FMUL'
              'FREM'
              'FSQRT'
              'FSUB'
              'FUN'
              'FUNE'
              'GET'
              'GETA'
              'GO'
              'GREG'
              'I_BIT'
              'INCH'
              'INCL'
              'INCMH'
              'INCML'
              'IS'
              'JMP'
              'LDA'
              'LDB'
              'LDBU'
              'LDHT'
              'LDO'
              'LDOU'
              'LDSF'
              'LDT'
              'LDTU'
              'LDUNC'
              'LDVTS'
              'LDW'
              'LDWU'
              'LOC'
              'LOCAL'
              'MOR'
              'MUL'
              'MULU'
              'MUX'
              'MXOR'
              'NAND'
              'NEG'
              'NEGU'
              'NNIX'
              'NOR'
              'NXOR'
              'O_BIT'
              'OCTA'
              'ODIF'
              'OR'
              'ORH'
              'ORL'
              'ORMH'
              'ORML'
              'ORN'
              'PBEV'
              'PBN'
              'PBNN'
              'PBNP'
              'PBNZ'
              'PBOD'
              'PBP'
              'PBZ'
              'POP'
              'PREFIX'
              'PREGO'
              'PRELD'
              'PREST'
              'PUSHGO'
              'PUSHJ'
              'PUT'
              'RESUME'
              'SAVE'
              'SET'
              'SETH'
              'SETL'
              'SETMH'
              'SETML'
              'SFLOT'
              'SFLOTU'
              'SL'
              'SLU'
              'SR'
              'SRU'
              'STB'
              'STBU'
              'STCO'
              'STHT'
              'STO'
              'STOU'
              'STSF'
              'STT'
              'STTU'
              'STUNC'
              'STW'
              'STWU'
              'SUB'
              'SUBU'
              'SWYM'
              'SYNC'
              'SYNCD'
              'TDIF'
              'TETRA'
              'TRAP'
              'TRIP'
              'UNSAVE'
              'WDIF'
              'WYDEXOR'
              'ZSEV'
              'ZSN'
              'ZSNN'
              'ZSNP'
              'ZSNZ'
              'ZSOD'
              'ZSP'
              'ZSZ')
          end
          item
            KeywordListNumber = 1
            Name = 'Special Register'
            Keywords.Strings = (
              'rA'
              'rB'
              'rC'
              'rD'
              'rE'
              'rF'
              'rG'
              'rH'
              'rI'
              'rJ'
              'rK'
              'rL'
              'rM'
              'rN'
              'rO'
              'rP'
              'rQ'
              'rR'
              'rS'
              'rT'
              'rU'
              'rV'
              'rW'
              'rX'
              'rY'
              'rZ'
              'rBB'
              'rTT'
              'rWW'
              'rXX'
              'rYY'
              'rZZ')
          end
          item
            KeywordListNumber = 2
            Name = 'Predefined Symbols'
            Keywords.Strings = (
              '@'
              'Text_Segment'
              'Data_Segment'
              'Pool_Segment'
              'Stack_Segment'
              'StdErr'
              'StdIn'
              'StdOut'
              'Fopen'
              'Fclose'
              'Fread'
              'Fwrite'
              'Fgets'
              'Fputs'
              'Fgetws'
              'Fputws'
              'Ftell'
              'Fseek'
              'TextRead'
              'TextWrite'
              'BinaryRead'
              'BinaryWrite'
              'BinaryReadWrite')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'MSSQL'
        Lexer = 'mssql'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Variable'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Column Name'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Statement'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Data Type'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'System Table'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Global Variable'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Function'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Stored Procedure'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default Pref Datatype'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Column Name 2'
            StyleNumber = 16
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Statements'
          end
          item
            KeywordListNumber = 1
            Name = 'Data Types'
          end
          item
            KeywordListNumber = 2
            Name = 'System tables'
          end
          item
            KeywordListNumber = 3
            Name = 'Global variables'
          end
          item
            KeywordListNumber = 4
            Name = 'Functions'
          end
          item
            KeywordListNumber = 5
            Name = 'System Stored Procedures'
          end
          item
            KeywordListNumber = 6
            Name = 'Operators'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '#'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'nnCronTab'
        Lexer = 'nncrontab'
        Styles = <
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = 9474192
            CharCase = CASE_MIXED
            Name = 'Task start/end'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Section Keywords'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keywords'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsItalic]
            ForeColor = 8355584
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Modificators'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clBlack
            BackColor = 16769279
            CharCase = CASE_MIXED
            Name = 'Asterisk'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double Quoted String'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Environment Variable'
            StyleNumber = 9
          end
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Section keywords and Forth words'
            Keywords.Strings = (
              'AGAIN'
              'ALLOT'
              'AND'
              'Action'
              'BEGIN'
              'CASE'
              'COMPARE'
              'CONSTANT'
              'CREATE'
              'DO'
              'Days'
              'ELSE'
              'ENDCASE'
              'ENDOF'
              'EVAL-SUBST'
              'EVALUATE'
              'FALSE'
              'Hours'
              'I'
              'IF'
              'LEAVE'
              'LOOP'
              'Minutes'
              'Months'
              'NOT'
              'OF'
              'OFF'
              'ON'
              'OR'
              'PAD'
              'REPEAT'
              'Rule'
              'SET'
              'THEN'
              'TRUE'
              'Time'
              'UNTIL'
              'VALUE'
              'VARIABLE'
              'WHILE'
              'WeekDays'
              'Years')
          end
          item
            KeywordListNumber = 1
            Name = 'nnCrontab keywords'
            Keywords.Strings = (
              '</JScript>'
              '</SCRIPT>'
              '</VBScript>'
              '<JScript>'
              '<VBScript>'
              'ACCESS-DATE'
              'BEEP'
              'CALL_DIAL'
              'CALL_HANGUP'
              'CHAR'
              'CLIPBOARD'
              'CONSOLE'
              'CREATION-DATE'
              'CUR-DATE'
              'DATE-'
              'DATE-INTERVAL'
              'DELAY'
              'DIAL'
              'DIR-CREATE'
              'DIR-DELETE'
              'DIR-EMPTY'
              'DIR-SIZE'
              'Day@'
              'Domain'
              'ERR-MSG'
              'EXIST'
              'FILE-ACCESS-DATE'
              'FILE-APPEND'
              'FILE-COPY'
              'FILE-CREATE'
              'FILE-CREATION-DATE'
              'FILE-CROP'
              'FILE-DATE'
              'FILE-DELETE'
              'FILE-EMPTY'
              'FILE-EXIST'
              'FILE-MOVE'
              'FILE-RENAME'
              'FILE-SIZE'
              'FILE-WRITE'
              'FILE-WRITE-DATE'
              'FOR-CHILD-WINDOWS'
              'FOR-FILES'
              'FOR-WINDOWS'
              'FREE-SPACE'
              'GET-CUR-TIME'
              'GET-REG'
              'GET-VER'
              'GetTickCount'
              'HANGUP'
              'HIDE-ICON'
              'HINT'
              'HINT-OFF'
              'HINT-POS'
              'HINT-SIZE'
              'HINTW'
              'HOST-EXIST'
              'Hour@'
              'IDLE'
              'INTERVAL'
              'IS-ARCHIVE'
              'IS-DIR'
              'IS-HIDDEN'
              'IS-READONLY'
              'IS-SYSTEM'
              'KILL'
              'LAUNCH'
              'LOG'
              'LOGGEDON'
              'LOGOFF'
              'LogonBatch'
              'LogonInteractive'
              'LogonNetwork'
              'MOUSE-LBCLK'
              'MOUSE-LBDCLK'
              'MOUSE-LBDN'
              'MOUSE-LBUP'
              'MOUSE-MOVE'
              'MOUSE-MOVER'
              'MOUSE-MOVEW'
              'MOUSE-RBCLK'
              'MOUSE-RBDCLK'
              'MOUSE-RBDN'
              'MOUSE-RBUP'
              'MSG'
              'Min@'
              'Mon@'
              'MonitorResponseTime'
              'NHOST-EXIST'
              'No'
              'ONLINE'
              'PAUSE'
              'PLAY-SOUND'
              'PLAY-SOUNDW'
              'POP3-CHECK'
              'POWEROFF'
              'PROC-EXIST'
              'PROC-TIME'
              'PURGE-OLD'
              'PURGE-OLDA'
              'PURGE-OLDW'
              'Password'
              'QSTART-APP'
              'QSTART-APPW'
              'QUERY'
              'QUIT'
              'RASDomain'
              'RASError'
              'RASPassword'
              'RASPhone'
              'RASSecPassword'
              'RASUser'
              'RE-ALL'
              'RE-MATCH'
              'REBOOT'
              'REG-DELETE-KEY'
              'REG-DELETE-VALUE'
              'REG-DWORD'
              'REG-SZ'
              'REMINDER'
              'RUN'
              'SEND-KEYS'
              'SEND-KEYS-DELAY'
              'SHOW-ICON'
              'SHUTDOWN'
              'START-APP'
              'START-APPW'
              'START-QUIT'
              'START-TIME'
              'Sec@'
              'SecPassword'
              'THINT'
              'THINTW'
              'TimeSec@'
              'TMSG'
              'TQUERY'
              'User'
              'WDay@'
              'WIN-ACTIVATE'
              'WIN-ACTIVE'
              'WIN-CLICK'
              'WIN-CLOSE'
              'WIN-EXIST'
              'WIN-HIDE'
              'WIN-HWND'
              'WIN-MAXIMIZE'
              'WIN-MINIMIZE'
              'WIN-MOVE'
              'WIN-MOVER'
              'WIN-RESTORE'
              'WIN-SEND-KEYS'
              'WIN-SHOW'
              'WIN-TERMINATE'
              'WIN-TOPMOST'
              'WIN-VER'
              'WIN-WAIT'
              'WINAPI'
              'WRITE-DATE'
              'WatchClipboard'
              'WatchConnect'
              'WatchDir'
              'WatchDisconnect'
              'WatchDriveInsert'
              'WatchDriveRemove'
              'WatchFile'
              'WatchProc'
              'WatchProcStop'
              'WatchWinActivate'
              'WatchWinCreate'
              'WatchWinDestroy'
              'WatchWindow'
              'WinNT'
              'Year@'
              'Yes')
          end
          item
            KeywordListNumber = 2
            Name = 'Modifiers'
            Keywords.Strings = (
              'ALL'
              'AboveNormalPriority'
              'AsService'
              'BelowNormalPriority'
              'FILESONLY'
              'HighPriority'
              'IdlePriority'
              'LoadProfile'
              'NoActive'
              'NoDel'
              'NoLog'
              'NoRunAs'
              'NormalPriority'
              'OnceADay'
              'OnceAHour'
              'OnceAMonth'
              'OnceAWeek'
              'RECURSIVE'
              'RealtimePriority'
              'RunOnce'
              'SWHide'
              'ShowMaximized'
              'ShowMinimized'
              'ShowNoActivate'
              'ShowNormal'
              'StartIn'
              'StartPos'
              'StartSize'
              'TODEPTH'
              'WATCH-CHANGE-ATTRIBUTES'
              'WATCH-CHANGE-DIR-NAME'
              'WATCH-CHANGE-FILE-NAME'
              'WATCH-CHANGE-LAST-WRITE'
              'WATCH-CHANGE-SECURITY'
              'WATCH-CHANGE-SIZE'
              'WaitFor'
              'WatchSubtree'
              'WithoutProfile')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = 
          ' CommentBoxEnd= CommentBoxMiddle= CommentBlock= CommentStreamSta' +
          'rt= CommentStreamEnd= AssignmentOperator=='
        CommentBoxEnd = 
          ' CommentBoxMiddle= CommentBlock= CommentStreamStart= CommentStre' +
          'amEnd= AssignmentOperator=='
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Objective_Caml'
        Lexer = 'caml'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White Space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifiers'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Tag Names'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keywords'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keywords 2'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Linenum Directive'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Numbers'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single Quoted String'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double Quoted String'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment (Not Nested)'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment (Singly Nested)'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment (Doubly Nested)'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment (Triply Nested)'
            StyleNumber = 13
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'and'
              'as'
              'assert'
              'asr'
              'begin'
              'class'
              'constraint'
              'do'
              'done'
              'downto'
              'else'
              'end'
              'exception'
              'external'
              'false'
              'for'
              'fun'
              'function'
              'functor'
              'if'
              'in'
              'include'
              'inherit'
              'initializer'
              'land'
              'lazy'
              'let'
              'lor'
              'lsl'
              'lsr'
              'lxor'
              'match'
              'method'
              'mod'
              'module'
              'mutable'
              'new'
              'object'
              'of'
              'open'
              'or'
              'private'
              'rec'
              'sig'
              'struct'
              'then'
              'to'
              'true'
              'try'
              'type'
              'val'
              'virtual'
              'when'
              'while'
              'with')
          end
          item
            KeywordListNumber = 1
            Name = 'Optional Keywords'
            Keywords.Strings = (
              'option'
              'Some'
              'None'
              'ignore'
              'ref')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '(*'
        CommentBoxEnd = '*)'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '(*'
        CommentStreamEnd = '*)'
        NumStyleBits = 5
      end
      item
        Name = 'Pascal'
        Lexer = 'pascal'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Symbols'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Inline Assembler'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Class Keywords'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment Keyword'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment Keyword Error'
            StyleNumber = 18
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'const'
              'type'
              'var'
              'begin'
              'end'
              'array'
              'set'
              'packed'
              'record'
              'string'
              'if'
              'then'
              'else'
              'while'
              'for'
              'to'
              'downto'
              'do'
              'with'
              'repeat'
              'until'
              'case'
              'of'
              'goto'
              'exit'
              'label'
              'procedure'
              'function'
              'nil'
              'file'
              'and'
              'or'
              'not'
              'xor'
              'div'
              'mod'
              'external'
              'asm'
              'inline'
              'object'
              'constructor'
              'destructor'
              'virtual'
              'far'
              'assembler'
              'near'
              'inherited'
              'stdcall'
              'cdecl'
              'export'
              'exports'
              'end.'
              'class'
              'ansistring'
              'raise'
              'try'
              'except'
              'on'
              'index'
              'name'
              'finally'
              'false'
              'true'
              'initialization'
              'finalization'
              'override'
              'overload'
              'at'
              'threadvar'
              'resourcestring'
              'as'
              'dispinterface'
              'in'
              'is'
              'out'
              'program'
              'package'
              'library'
              'unit'
              'interface'
              'uses'
              'implementation'
              'shr')
          end
          item
            KeywordListNumber = 1
            Name = 'Class Keywords'
            Keywords.Strings = (
              'write'
              'read'
              'default'
              'public'
              'protected'
              'private'
              'property'
              'published'
              'stored'
              'automated')
          end>
        AssignmentOperator = ':='
        EndOfStatementOperator = ';'
        CommentBoxStart = '{'
        CommentBoxEnd = '}'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '{'
        CommentStreamEnd = '}'
        NumStyleBits = 5
      end
      item
        Name = 'PERL'
        Lexer = 'perl'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White Space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clRed
            CharCase = CASE_MIXED
            Name = 'Error'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16763904
            BackColor = 723723
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'POD: = at beginning of line'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Punctuation'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifiers (functions, etc.)'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Scalars: $var'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Array: @var'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Hash: %var'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Symbol table: *var'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clAqua
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Regex: /re/ or m{re}'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clAqua
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Substitution: s/re/ore/'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clAqua
            BackColor = 10518656
            CharCase = CASE_MIXED
            Name = 'Long Quote (qq, qx, qr, qw)'
            StyleNumber = 19
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = 10518656
            CharCase = CASE_MIXED
            Name = 'Back Ticks'
            StyleNumber = 20
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16763904
            BackColor = 723723
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Data Section: __DATA__ or __END__ at beginning of line'
            StyleNumber = 21
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16724672
            BackColor = 14536925
            CharCase = CASE_MIXED
            Name = 'Here-doc (delimiter)'
            StyleNumber = 22
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 8323199
            BackColor = 14536925
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Here-doc (single quoted, q)'
            StyleNumber = 23
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 8323199
            BackColor = 14536925
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Here-doc (double quoted, qq)'
            StyleNumber = 24
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Here-doc (back ticks, qx)'
            StyleNumber = 25
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string, generic'
            StyleNumber = 26
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'qq = Double quoted string'
            StyleNumber = 27
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'qx = Back ticks'
            StyleNumber = 28
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clAqua
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'qr = Regex'
            StyleNumber = 29
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'qw = Array'
            StyleNumber = 30
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'POD Verb'
            StyleNumber = 31
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'NULL'
              '__FILE__'
              '__LINE__'
              '__PACKAGE__'
              '__DATA__'
              '__END__'
              'AUTOLOAD'
              'BEGIN'
              'CORE'
              'DESTROY'
              'END'
              'EQ'
              'GE'
              'GT'
              'INIT'
              'LE'
              'LT'
              'NE'
              'CHECK'
              'abs'
              'accept'
              'alarm'
              'and'
              'atan2'
              'bind'
              'binmode'
              'bless'
              'caller'
              'chdir'
              'chmod'
              'chomp'
              'chop'
              'chown'
              'chr'
              'chroot'
              'close'
              'closedir'
              'cmp'
              'connect'
              'continue'
              'cos'
              'crypt'
              'dbmclose'
              'dbmopen'
              'defined'
              'delete'
              'die'
              'do'
              'dump'
              'each'
              'else'
              'elsif'
              'endgrent'
              'endhostent'
              'endnetent'
              'endprotoent'
              'endpwent'
              'endservent'
              'eof'
              'eq'
              'eval'
              'exec'
              'exists'
              'exit'
              'exp'
              'fcntl'
              'fileno'
              'flock'
              'for'
              'foreach'
              'fork'
              'format'
              'formline'
              'ge'
              'getc'
              'getgrent'
              'getgrgid'
              'getgrnam'
              'gethostbyaddr'
              'gethostbyname'
              'gethostent'
              'getlogin'
              'getnetbyaddr'
              'getnetbyname'
              'getnetent'
              'getpeername'
              'getpgrp'
              'getppid'
              'getpriority'
              'getprotobyname'
              'getprotobynumber'
              'getprotoent'
              'getpwent'
              'getpwnam'
              'getpwuid'
              'getservbyname'
              'getservbyport'
              'getservent'
              'getsockname'
              'getsockopt'
              'glob'
              'gmtime'
              'goto'
              'grep'
              'gt'
              'hex'
              'if'
              'index'
              'int'
              'ioctl'
              'join'
              'keys'
              'kill'
              'last'
              'lc'
              'lcfirst'
              'le'
              'length'
              'link'
              'listen'
              'local'
              'localtime'
              'lock'
              'log'
              'lstat'
              'lt'
              'map'
              'mkdir'
              'msgctl'
              'msgget'
              'msgrcv'
              'msgsnd'
              'my'
              'ne'
              'next'
              'no'
              'not'
              'oct'
              'open'
              'opendir'
              'or'
              'ord'
              'our'
              'pack'
              'package'
              'pipe'
              'pop'
              'pos'
              'print'
              'printf'
              'prototype'
              'push'
              'quotemeta'
              'qu'
              'rand'
              'read'
              'readdir'
              'readline'
              'readlink'
              'readpipe'
              'recv'
              'redo'
              'ref'
              'rename'
              'require'
              'reset'
              'return'
              'reverse'
              'rewinddir'
              'rindex'
              'rmdir'
              'scalar'
              'seek'
              'seekdir'
              'select'
              'semctl'
              'semget'
              'semop'
              'send'
              'setgrent'
              'sethostent'
              'setnetent'
              'setpgrp'
              'setpriority'
              'setprotoent'
              'setpwent'
              'setservent'
              'setsockopt'
              'shift'
              'shmctl'
              'shmget'
              'shmread'
              'shmwrite'
              'shutdown'
              'sin'
              'sleep'
              'socket'
              'socketpair'
              'sort'
              'splice'
              'split'
              'sprintf'
              'sqrt'
              'srand'
              'stat'
              'study'
              'sub'
              'substr'
              'symlink'
              'syscall'
              'sysopen'
              'sysread'
              'sysseek'
              'system'
              'syswrite'
              'tell'
              'telldir'
              'tie'
              'tied'
              'time'
              'times'
              'truncate'
              'uc'
              'ucfirst'
              'umask'
              'undef'
              'unless'
              'unlink'
              'unpack'
              'unshift'
              'untie'
              'until'
              'use'
              'utime'
              'values'
              'vec'
              'wait'
              'waitpid'
              'wantarray'
              'warn'
              'while'
              'write'
              'xor')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '#'
        CommentBoxEnd = '#'
        CommentBoxMiddle = '#'
        CommentBlock = '#'
        CommentAtLineStart = True
        CommentStreamStart = '#'
        CommentStreamEnd = '#'
        NumStyleBits = 5
      end
      item
        Name = 'PHP'
        Lexer = 'hypertext'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Text'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Tags'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Tags'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12624032
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Attributes'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Attributes'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Numbers'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 39338
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted strings'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted strings'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other inside tag'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 9
          end
          item
            FontName = 'Times New Roman'
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 10526880
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Entities'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12632064
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML style tag ends'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 10485920
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier start'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 10485920
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier end'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 657920
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SCRIPT'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 57343
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'CDATA'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 56797
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unquoted values'
            StyleNumber = 19
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XC Comment'
            StyleNumber = 20
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML tags <! ... >'
            StyleNumber = 21
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML command'
            StyleNumber = 22
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 15793935
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML 1st param'
            StyleNumber = 23
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML double string'
            StyleNumber = 24
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML single string'
            StyleNumber = 25
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML error'
            StyleNumber = 26
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16737843
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML special'
            StyleNumber = 27
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML entity'
            StyleNumber = 28
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML comment'
            StyleNumber = 29
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlue
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML block'
            StyleNumber = 31
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 32639
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Start'
            StyleNumber = 40
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'JS Default'
            StyleNumber = 41
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'JS Comment'
            StyleNumber = 42
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Line Comment'
            StyleNumber = 43
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'JS Doc Comment'
            StyleNumber = 44
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Number'
            StyleNumber = 45
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Word'
            StyleNumber = 46
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Keyword'
            StyleNumber = 47
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Double quoted string'
            StyleNumber = 48
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Single quoted string'
            StyleNumber = 49
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Symbols'
            StyleNumber = 50
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'JS EOL'
            StyleNumber = 51
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16724672
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'JS Regex'
            StyleNumber = 52
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS Default'
            StyleNumber = 71
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS Comment'
            StyleNumber = 72
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS Number'
            StyleNumber = 73
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS KeyWord'
            StyleNumber = 74
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS String'
            StyleNumber = 75
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS Identifier'
            StyleNumber = 76
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'VBS Unterminated string'
            StyleNumber = 77
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Python Start'
            StyleNumber = 90
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Default'
            StyleNumber = 91
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Comment'
            StyleNumber = 92
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Number'
            StyleNumber = 93
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python String'
            StyleNumber = 94
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Single quoted string'
            StyleNumber = 95
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Keyword'
            StyleNumber = 96
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 127
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Triple quotes'
            StyleNumber = 97
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 127
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Triple double quotes'
            StyleNumber = 98
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clBlue
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Class name definition'
            StyleNumber = 99
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 8355584
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python function or method name definition'
            StyleNumber = 100
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python function or method name definition'
            StyleNumber = 101
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = 15728623
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'Python Identifiers'
            StyleNumber = 102
          end
          item
            FontSize = 0
            FontStyles = [fsItalic]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Complex Variable'
            StyleNumber = 104
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'PHP Default'
            StyleNumber = 118
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Double quoted string'
            StyleNumber = 119
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Single quoted string'
            StyleNumber = 120
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Keyword'
            StyleNumber = 121
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Number'
            StyleNumber = 122
          end
          item
            FontSize = 0
            FontStyles = [fsItalic]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Variable'
            StyleNumber = 123
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Comment'
            StyleNumber = 124
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP One line Comment'
            StyleNumber = 125
          end
          item
            FontSize = 0
            FontStyles = [fsItalic]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Variable in double quoted string'
            StyleNumber = 126
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP operator'
            StyleNumber = 127
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'HyperText'
            Keywords.Strings = (
              'a'
              'abbr'
              'acronym'
              'address'
              'applet'
              'area'
              'b'
              'base'
              'basefont'
              'bdo'
              'big'
              'blockquote'
              'body'
              'br'
              'button'
              'caption'
              'center'
              'cite'
              'code'
              'col'
              'colgroup'
              'dd'
              'del'
              'dfn'
              'dir'
              'div'
              'dl'
              'dt'
              'em'
              'fieldset'
              'font'
              'form'
              'frame'
              'frameset'
              'h1'
              'h2'
              'h3'
              'h4'
              'h5'
              'h6'
              'head'
              'hr'
              'html'
              'i'
              'iframe'
              'img'
              'input'
              'ins'
              'isindex'
              'kbd'
              'label'
              'legend'
              'li'
              'link'
              'map'
              'menu'
              'meta'
              'noframes'
              'noscript'
              'object'
              'ol'
              'optgroup'
              'option'
              'p'
              'param'
              'pre'
              'q'
              's'
              'samp'
              'script'
              'select'
              'small'
              'span'
              'strike'
              'strong'
              'style'
              'sub'
              'sup'
              'table'
              'tbody'
              'td'
              'textarea'
              'tfoot'
              'th'
              'thead'
              'title'
              'tr'
              'tt'
              'u'
              'ul'
              'var'
              'xml'
              'xmlns'
              'abbr'
              'accept-charset'
              'accept'
              'accesskey'
              'action'
              'align'
              'alink'
              'alt'
              'archive'
              'axis'
              'background'
              'bgcolor'
              'border'
              'cellpadding'
              'cellspacing'
              'char'
              'charoff'
              'charset'
              'checked'
              'cite'
              'class'
              'classid'
              'clear'
              'codebase'
              'codetype'
              'color'
              'cols'
              'colspan'
              'compact'
              'content'
              'coords'
              'data'
              'datafld'
              'dataformatas'
              'datapagesize'
              'datasrc'
              'datetime'
              'declare'
              'defer'
              'dir'
              'disabled'
              'enctype'
              'event'
              'face'
              'for'
              'frame'
              'frameborder'
              'headers'
              'height'
              'href'
              'hreflang'
              'hspace'
              'http-equiv'
              'id'
              'ismap'
              'label'
              'lang'
              'language'
              'leftmargin'
              'link'
              'longdesc'
              'marginwidth'
              'marginheight'
              'maxlength'
              'media'
              'method'
              'multiple'
              'name'
              'nohref'
              'noresize'
              'noshade'
              'nowrap'
              'object'
              'onblur'
              'onchange'
              'onclick'
              'ondblclick'
              'onfocus'
              'onkeydown'
              'onkeypress'
              'onkeyup'
              'onload'
              'onmousedown'
              'onmousemove'
              'onmouseover'
              'onmouseout'
              'onmouseup'
              'onreset'
              'onselect'
              'onsubmit'
              'onunload'
              'profile'
              'prompt'
              'readonly'
              'rel'
              'rev'
              'rows'
              'rowspan'
              'rules'
              'scheme'
              'scope'
              'selected'
              'shape'
              'size'
              'span'
              'src'
              'standby'
              'start'
              'style'
              'summary'
              'tabindex'
              'target'
              'text'
              'title'
              'topmargin'
              'type'
              'usemap'
              'valign'
              'value'
              'valuetype'
              'version'
              'vlink'
              'vspace'
              'width'
              'text'
              'password'
              'checkbox'
              'radio'
              'submit'
              'reset'
              'file'
              'hidden'
              'image'
              'framespacing'
              'scrolling'
              'allowtransparency'
              'bordercolor')
          end
          item
            KeywordListNumber = 1
            Name = 'JavaScript'
            Keywords.Strings = (
              'abstract'
              'boolean'
              'break'
              'byte'
              'case'
              'catch'
              'char'
              'class'
              'const'
              'continue'
              'debugger'
              'default'
              'delete'
              'do'
              'double'
              'else'
              'enum'
              'export'
              'extends'
              'final'
              'finally'
              'float'
              'for'
              'function'
              'goto'
              'if'
              'implements'
              'import'
              'in'
              'instanceof'
              'int'
              'interface'
              'long'
              'native'
              'new'
              'package'
              'private'
              'protected'
              'public'
              'return'
              'short'
              'static'
              'super'
              'switch'
              'synchronized'
              'this'
              'throw'
              'throws'
              'transient'
              'try'
              'typeof'
              'var'
              'void'
              'volatile'
              'while'
              'with')
          end
          item
            KeywordListNumber = 2
            Name = 'VBScript'
            Keywords.Strings = (
              'and'
              'begin'
              'case'
              'call'
              'class'
              'continue'
              'do'
              'each'
              'else'
              'elseif'
              'end'
              'erase'
              'error'
              'event'
              'exit'
              'false'
              'for'
              'function'
              'get'
              'gosub'
              'goto'
              'if'
              'implement'
              'in'
              'load'
              'loop'
              'lset'
              'me'
              'mid'
              'new'
              'next'
              'not'
              'nothing'
              'on'
              'or'
              'property'
              'raiseevent'
              'rem'
              'resume'
              'return'
              'rset'
              'select'
              'set'
              'stop'
              'sub'
              'then'
              'to'
              'true'
              'unload'
              'until'
              'wend'
              'while'
              'with'
              'withevents'
              'attribute'
              'alias'
              'as'
              'boolean'
              'byref'
              'byte'
              'byval'
              'const'
              'compare'
              'currency'
              'date'
              'declare'
              'dim'
              'double'
              'enum'
              'explicit'
              'friend'
              'global'
              'integer'
              'let'
              'lib'
              'long'
              'module'
              'object'
              'option'
              'optional'
              'preserve'
              'private'
              'public'
              'redim'
              'single'
              'static'
              'string'
              'type'
              'variant')
          end
          item
            KeywordListNumber = 3
            Name = 'Python'
            Keywords.Strings = (
              'and'
              'assert'
              'break'
              'class'
              'continue'
              'def'
              'del'
              'elif'
              'else'
              'except'
              'exec'
              'finally'
              'for'
              'from'
              'global'
              'if'
              'import'
              'in'
              'is'
              'lambda'
              'None'
              'not'
              'or'
              'pass'
              'print'
              'raise'
              'return'
              'try'
              'while'
              'yield')
          end
          item
            KeywordListNumber = 4
            Name = 'PHP'
            Keywords.Strings = (
              'and'
              'array'
              'as'
              'bool'
              'boolean'
              'break'
              'case'
              'cfunction'
              'class'
              'const'
              'continue'
              'declare'
              'default'
              'die'
              'directory'
              'do'
              'double'
              'echo'
              'else'
              'elseif'
              'empty'
              'enddeclare'
              'endfor'
              'endforeach'
              'endif'
              'endswitch'
              'endwhile'
              'eval'
              'exit'
              'extends'
              'false'
              'float'
              'for'
              'foreach'
              'function'
              'global'
              'if'
              'include'
              'include_once'
              'int'
              'integer'
              'isset'
              'list'
              'new'
              'null'
              'object'
              'old_function'
              'or'
              'parent'
              'print'
              'real'
              'require'
              'require_once'
              'resource'
              'return'
              'static'
              'stdclass'
              'string'
              'switch'
              'true'
              'unset'
              'use'
              'var'
              'while'
              'xor'
              'abstract'
              'catch'
              'clone'
              'exception'
              'final'
              'implements'
              'interface'
              'php_user_filter'
              'private'
              'protected'
              'public'
              'this'
              'throw'
              'try'
              '__class__'
              '__file__'
              '__function__'
              '__line__'
              '__method__'
              '__sleep'
              '__wakeup')
          end
          item
            KeywordListNumber = 5
            Name = 'DTD Keywords'
            Keywords.Strings = (
              'ELEMENT'
              'DOCTYPE'
              'ATTLIST'
              'ENTITY'
              'NOTATION')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '<!--'
        CommentBoxEnd = '-->'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '<!--'
        CommentStreamEnd = '-->'
        NumStyleBits = 7
      end
      item
        Name = 'PhpScript'
        Lexer = 'phpscript'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = [fsItalic]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Complex Variable'
            StyleNumber = 104
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'PHP Default'
            StyleNumber = 118
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Double quoted string'
            StyleNumber = 119
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Single quoted string'
            StyleNumber = 120
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Keyword'
            StyleNumber = 121
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Number'
            StyleNumber = 122
          end
          item
            FontSize = 0
            FontStyles = [fsItalic]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Variable'
            StyleNumber = 123
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Comment'
            StyleNumber = 124
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP One line Comment'
            StyleNumber = 125
          end
          item
            FontSize = 0
            FontStyles = [fsItalic]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP Variable in double quoted string'
            StyleNumber = 126
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PHP operator'
            StyleNumber = 127
          end>
        Keywords = <
          item
            KeywordListNumber = 4
            Name = 'PHP'
            Keywords.Strings = (
              'and'
              'argv'
              'as'
              'argc'
              'break'
              'case'
              'cfunction'
              'class'
              'continue'
              'declare'
              'default'
              'do'
              'die'
              'echo'
              'else'
              'elseif'
              'empty'
              'enddeclare'
              'endfor'
              'endforeach'
              'endif'
              'endswitch'
              'endwhile'
              'e_all'
              'e_parse'
              'e_error'
              'e_warning'
              'eval'
              'exit'
              'extends'
              'false'
              'for'
              'foreach'
              'function'
              'global'
              'http_cookie_vars'
              'http_get_vars'
              'http_post_vars'
              'http_post_files'
              'http_env_vars'
              'http_server_vars'
              'if'
              'include'
              'include_once'
              'list'
              'new'
              'not'
              'null'
              'old_function'
              'or'
              'parent'
              'php_os'
              'php_self'
              'php_version'
              'print'
              'require'
              'require_once'
              'return'
              'static'
              'switch'
              'stdclass'
              'this'
              'true'
              'var'
              'xor'
              'virtual'
              'while'
              'define'
              '__file__'
              '__line__'
              '__sleep'
              '__wakeup')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 7
      end
      item
        Name = 'PowerBasic'
        Lexer = 'powerbasic'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Whitespace'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String Not Closed (EOL)'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Constant'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Asm'
            StyleNumber = 14
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = #39
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Properties'
        Lexer = 'props'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Section'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 10089408
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Assignment'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default value (@)'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Key'
            StyleNumber = 5
          end>
        Keywords = <>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '#'
        CommentBoxEnd = '#'
        CommentBoxMiddle = '#'
        CommentBlock = '#'
        CommentAtLineStart = True
        CommentStreamStart = '#'
        CommentStreamEnd = '#'
        NumStyleBits = 5
      end
      item
        Name = 'PureBasic'
        Lexer = 'purebasic'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keywords'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'PreProcessor'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Date'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String not terminated'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Keywords 1'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Keywords 2'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Keywords 3'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Constant'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Asm'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Label'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clRed
            CharCase = CASE_MIXED
            Name = 'Error'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'HexNumber'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'BinNumber'
            StyleNumber = 18
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'and'
              'break'
              'case'
              'continue'
              'data'
              'datasection'
              'declare'
              'declarecdll'
              'declaredll'
              'default'
              'deftype'
              'dim'
              'else'
              'elseif'
              'end'
              'enddatasection'
              'endenumeration'
              'endif'
              'endinterface'
              'endprocedure'
              'endselect'
              'endstructure'
              'endstructureunion'
              'enumeration'
              'extends'
              'fakereturn'
              'for'
              'foreach'
              'forever'
              'global'
              'gosub'
              'goto'
              'if'
              'includebinary'
              'includefile'
              'includepath'
              'interface'
              'newlist'
              'next'
              'or'
              'procedure'
              'procedurecdll'
              'proceduredll'
              'procedurereturn'
              'protected'
              'read'
              'repeat'
              'restore'
              'return'
              'select'
              'shared'
              'static'
              'step'
              'structure'
              'structureunion'
              'to'
              'until'
              'wend'
              'while'
              'xincludefile')
          end
          item
            KeywordListNumber = 1
            Name = 'PreProcessor'
            Keywords.Strings = (
              'compilercase'
              'compilerdefault'
              'compilerelse'
              'compilerendif'
              'compilerendselect'
              'compilerif'
              'compilerselect')
          end
          item
            KeywordListNumber = 2
            Name = 'User Defined 1'
          end
          item
            KeywordListNumber = 3
            Name = 'User Defined 1'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Python'
        Lexer = 'python'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Triple quotes'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Triple quoted string'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Class name definition'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 8355584
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Function or method name definition'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifiers'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment blocks'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'End of line where string is not closed'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword2'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Decorator'
            StyleNumber = 15
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'and'
              'assert'
              'break'
              'class'
              'continue'
              'def'
              'del'
              'elif'
              'else'
              'except'
              'exec'
              'finally'
              'for'
              'from'
              'global'
              'if'
              'import'
              'in'
              'is'
              'lambda'
              'None'
              'not'
              'or'
              'pass'
              'print'
              'raise'
              'return'
              'try'
              'while'
              'yield')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '#'
        CommentBoxEnd = '#'
        CommentBoxMiddle = '#'
        CommentBlock = '#'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Resource'
        Lexer = 'cpp'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Symbols/UUID'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'EOL if string is not closed'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Verbatim strings for C#'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16724672
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Regular expressions'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment Line'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13421568
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User-defined keywords'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment keyword'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment keyword error'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Global classes and typedefs'
            StyleNumber = 19
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Primary keywords and identifiers'
            Keywords.Strings = (
              'ACCELERATORS'
              'ALT'
              'AUTO3STATE'
              'AUTOCHECKBOX'
              'AUTORADIOBUTTON'
              'BEGIN'
              'BITMAP'
              'BLOCK'
              'BUTTON'
              'CAPTION'
              'CHARACTERISTICS'
              'CHECKBOX'
              'CLASS'
              'COMBOBOX'
              'CONTROL'
              'CTEXT'
              'CURSOR'
              'DEFPUSHBUTTON'
              'DIALOG'
              'DIALOGEX'
              'DISCARDABLE'
              'EDITTEXT'
              'END'
              'EXSTYLE'
              'FONT'
              'GROUPBOX'
              'ICON'
              'LANGUAGE'
              'LISTBOX'
              'LTEXT'
              'MENU'
              'MENUEX'
              'MENUITEM'
              'MESSAGETABLE'
              'POPUP'
              'PUSHBUTTON'
              'RADIOBUTTON'
              'RCDATA'
              'RTEXT'
              'SCROLLBAR'
              'SEPARATOR'
              'SHIFT'
              'STATE3'
              'STRINGTABLE'
              'STYLE'
              'TEXTINCLUDE'
              'VALUE'
              'VERSION'
              'VERSIONINFO'
              'VIRTKEY')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'Ruby'
        Lexer = 'ruby'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Error'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'POD'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted string'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Class name definition'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 8355584
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Function or method name definition'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifiers'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Regex'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Global'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Symbol'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Module Name'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Instance Var'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Class Var'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Backtick'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Data Section'
            StyleNumber = 19
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Here Delimiter'
            StyleNumber = 20
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Here Q'
            StyleNumber = 21
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Here QQ'
            StyleNumber = 22
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Here QX'
            StyleNumber = 23
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String Q'
            StyleNumber = 24
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String QQ'
            StyleNumber = 25
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String QX'
            StyleNumber = 26
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String QR'
            StyleNumber = 27
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String QW'
            StyleNumber = 28
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Word Demoted'
            StyleNumber = 29
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'StdIn'
            StyleNumber = 30
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'StdOut'
            StyleNumber = 31
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'StdErr'
            StyleNumber = 40
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Upper Bound'
            StyleNumber = 41
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              '__FILE__'
              'and'
              'def'
              'end'
              'in'
              'or'
              'self'
              'unless'
              '__LINE__'
              'begin'
              'defined?'
              'ensure'
              'module'
              'redo'
              'super'
              'until'
              'BEGIN'
              'break'
              'do'
              'false'
              'next'
              'rescue'
              'then'
              'when'
              'END'
              'case'
              'else'
              'for'
              'nil'
              'require'
              'retry'
              'true'
              'while'
              'alias'
              'class'
              'elsif'
              'if'
              'not'
              'return'
              'undef'
              'yield')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '#'
        CommentBoxEnd = '#'
        CommentBoxMiddle = '#'
        CommentBlock = '#'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 6
      end
      item
        Name = 'Scheme'
        Lexer = 'lisp'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'White Space'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'End of line where string is not closed'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifiers'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operator'
            StyleNumber = 10
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              '+'
              '-'
              '*'
              '/'
              '='
              '<'
              '>'
              '<='
              '>='
              '=>'
              'abs'
              'acos'
              'and'
              'angle'
              'append'
              'apply'
              'asin'
              'assoc'
              'assoc'
              'assq'
              'assv'
              'atan'
              'begin'
              'boolean?'
              'caar'
              'cadr'
              'call-with-current-continuation'
              'call/cc'
              'call-with-input-file'
              'call-with-output-file'
              'call-with-values'
              'car'
              'cdr'
              'caar'
              'cadr'
              'cdar'
              'cddr'
              'caaar'
              'caadr'
              'cadar'
              'caddr'
              'cdaar'
              'cdadr'
              'cddar'
              'cdddr'
              'caaaar'
              'caaadr'
              'caadar'
              'caaddr'
              'cadaar'
              'cadadr'
              'caddar'
              'cadddr'
              'cdaaar'
              'cdaadr'
              'cdadar'
              'cdaddr'
              'cddaar'
              'cddadr'
              'cdddar'
              'cddddr'
              'case'
              'ceiling'
              'char->integer'
              'char-alphabetic?'
              'char-ci<=?'
              'char-ci<?'
              'char-ci=?'
              'char-ci>=?'
              'char-ci>?'
              'char-downcase'
              'char-lower-case?'
              'char-numeric?'
              'char-ready?'
              'char-upcase'
              'char-upper-case?'
              'char-whitespace?'
              'char<=?'
              'char<?'
              'char=?'
              'char>=?'
              'char>?'
              'char?'
              'close-input-port'
              'close-output-port'
              'complex?'
              'cond'
              'cons'
              'cos'
              'current-input-port'
              'current-output-port'
              'define'
              'define-syntax'
              'delay'
              'denominator'
              'display'
              'do'
              'dynamic-wind'
              'else'
              'eof-object?'
              'eq?'
              'equal?'
              'eqv?'
              'eval'
              'even?'
              'exact->inexact'
              'exact?'
              'exp'
              'expt'
              'floor'
              'for-each'
              'force'
              'gcd'
              'if'
              'imag-part'
              'inexact->exact'
              'inexact?'
              'input-port?'
              'integer->char'
              'integer?'
              'interaction-environment'
              'lambda'
              'lcm'
              'length'
              'let'
              'let*'
              'let-syntax'
              'letrec'
              'letrec-syntax'
              'list'
              'list->string'
              'list->vector'
              'list-ref'
              'list-tail'
              'list?'
              'load'
              'log'
              'magnitude'
              'make-polar'
              'make-rectangular'
              'make-string'
              'make-vector'
              'map'
              'max'
              'member'
              'memq'
              'memv'
              'min'
              'modulo'
              'negative?'
              'newline'
              'not'
              'null-environment'
              'null?'
              'number->string'
              'number?'
              'numerator'
              'odd?'
              'open-input-file'
              'open-output-file'
              'or'
              'output-port?'
              'pair?'
              'peek-char'
              'input-port?'
              'output-port?'
              'positive?'
              'procedure?'
              'quasiquote'
              'quote'
              'quotient'
              'rational?'
              'rationalize'
              'read'
              'read-char'
              'real-part'
              'real?'
              'remainder'
              'reverse'
              'round'
              'scheme-report-environment'
              'set!'
              'set-car!'
              'set-cdr!'
              'sin'
              'sqrt'
              'string'
              'string->list'
              'string->number'
              'string->symbol'
              'string-append'
              'string-ci<=?'
              'string-ci<?'
              'string-ci=?'
              'string-ci>=?'
              'string-ci>?'
              'string-copy'
              'string-fill!'
              'string-length'
              'string-ref'
              'string-set!'
              'string<=?'
              'string<?'
              'string=?'
              'string>=?'
              'string>?'
              'string?'
              'substring'
              'symbol->string'
              'symbol?'
              'syntax-rules'
              'transcript-off'
              'transcript-on'
              'truncate'
              'unquote'
              'unquote-splicing'
              'values'
              'vector'
              'vector->list'
              'vector-fill!'
              'vector-length'
              'vector-ref'
              'vector-set!'
              'vector?'
              'with-input-from-file'
              'with-output-to-file'
              'write'
              'write-char'
              'zero?')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = ';;'
        CommentBoxEnd = ';;'
        CommentBoxMiddle = ';;'
        CommentBlock = ';'
        CommentAtLineStart = True
        CommentStreamStart = ';;'
        CommentStreamEnd = ';;'
        NumStyleBits = 5
      end
      item
        Name = 'SQL'
        Lexer = 'sql'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Whitespace'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Character'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SQL*Plus'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SQL*Plus Prompt'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'EOL if string is not closed'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SQL*Plus Comment'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Line Doc Comment'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword2'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment Keyword'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Doc Comment Keyword Error'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User 1'
            StyleNumber = 19
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User 2'
            StyleNumber = 20
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User 3'
            StyleNumber = 21
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User 4'
            StyleNumber = 22
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Quoted Identifier'
            StyleNumber = 23
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'action'
              'add'
              'aggregate'
              'all'
              'alter'
              'after'
              'and'
              'as'
              'asc'
              'avg'
              'avg_row_length'
              'auto_increment'
              'between'
              'bigint'
              'bit'
              'binary'
              'blob'
              'bool'
              'both'
              'by'
              'cascade'
              'case'
              'char'
              'character'
              'change'
              'check'
              'checksum'
              'column'
              'columns'
              'comment'
              'constraint'
              'create'
              'cross'
              'current_date'
              'current_time'
              'current_timestamp'
              'data'
              'database'
              'databases'
              'date'
              'datetime'
              'day'
              'day_hour'
              'day_minute'
              'day_second'
              'dayofmonth'
              'dayofweek'
              'dayofyear'
              'dec'
              'decimal'
              'default'
              'delayed'
              'delay_key_write'
              'delete'
              'desc'
              'describe'
              'distinct'
              'distinctrow'
              'double'
              'drop'
              'end'
              'else'
              'escape'
              'escaped'
              'enclosed'
              'enum'
              'explain'
              'exists'
              'fields'
              'file'
              'first'
              'float'
              'float4'
              'float8'
              'flush'
              'foreign'
              'from'
              'for'
              'full'
              'function'
              'global'
              'grant'
              'grants'
              'group'
              'having'
              'heap'
              'high_priority'
              'hour'
              'hour_minute'
              'hour_second'
              'hosts'
              'identified'
              'ignore'
              'in'
              'index'
              'infile'
              'inner'
              'insert'
              'insert_id'
              'int'
              'integer'
              'interval'
              'int1'
              'int2'
              'int3'
              'int4'
              'int8'
              'into'
              'if'
              'is'
              'isam'
              'join'
              'key'
              'keys'
              'kill'
              'last_insert_id'
              'leading'
              'left'
              'length'
              'like'
              'lines'
              'limit'
              'load'
              'local'
              'lock'
              'logs'
              'long'
              'longblob'
              'longtext'
              'low_priority'
              'max'
              'max_rows'
              'match'
              'mediumblob'
              'mediumtext'
              'mediumint'
              'middleint'
              'min_rows'
              'minute'
              'minute_second'
              'modify'
              'month'
              'monthname'
              'myisam'
              'natural'
              'numeric'
              'no'
              'not'
              'null'
              'on'
              'optimize'
              'option'
              'optionally'
              'or'
              'order'
              'outer'
              'outfile'
              'pack_keys'
              'partial'
              'password'
              'precision'
              'primary'
              'procedure'
              'process'
              'processlist'
              'privileges'
              'read'
              'real'
              'references'
              'reload'
              'regexp'
              'rename'
              'replace'
              'restrict'
              'returns'
              'revoke'
              'rlike'
              'row'
              'rows'
              'second'
              'select'
              'set'
              'show'
              'shutdown'
              'smallint'
              'soname'
              'sql_big_tables'
              'sql_big_selects'
              'sql_low_priority_updates'
              'sql_log_off'
              'sql_log_update'
              'sql_select_limit'
              'sql_small_result'
              'sql_big_result'
              'sql_warnings'
              'straight_join'
              'starting'
              'status'
              'string'
              'table'
              'tables'
              'temporary'
              'terminated'
              'text'
              'then'
              'time'
              'timestamp'
              'tinyblob'
              'tinytext'
              'tinyint'
              'trailing'
              'to'
              'type'
              'use'
              'using'
              'unique'
              'unlock'
              'unsigned'
              'update'
              'usage'
              'values'
              'varchar'
              'variables'
              'varying'
              'varbinary'
              'with'
              'write'
              'when'
              'where'
              'year'
              'year_month'
              'zerofill')
          end
          item
            KeywordListNumber = 1
            Name = 'Database Objects'
          end
          item
            KeywordListNumber = 2
            Name = 'PLDoc'
          end
          item
            KeywordListNumber = 3
            Name = 'SQL*Plus'
          end
          item
            KeywordListNumber = 4
            Name = 'User Keywords 1'
          end
          item
            KeywordListNumber = 5
            Name = 'User Keywords 2'
          end
          item
            KeywordListNumber = 6
            Name = 'User Keywords 3'
          end
          item
            KeywordListNumber = 7
            Name = 'User Keywords 4'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '#'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'TCL/TK'
        Lexer = 'tcl'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Whitespace'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Commentline'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword in Quote'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'In Quote'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifiers'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Substitution'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Subst with Brace'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Modifier'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Expand'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'TCL Keywords'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'TK Keywords'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'iTCL Keywords'
            StyleNumber = 14
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'tkCommands'
            StyleNumber = 15
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Keywords 1'
            StyleNumber = 16
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Keywords 2'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Keywords 3'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User Keywords 4'
            StyleNumber = 19
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment Box'
            StyleNumber = 20
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Block Comment'
            StyleNumber = 21
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'TCL Keywords'
            Keywords.Strings = (
              'after'
              'append'
              'array'
              'auto_execok'
              'auto_import'
              'auto_load'
              'auto_load_index'
              'auto_qualify'
              'beep'
              'bgerror'
              'binary'
              'break'
              'case'
              'catch'
              'cd'
              'clock'
              'close'
              'concat'
              'continue'
              'dde'
              'default'
              'echo'
              'else'
              'elseif'
              'encoding'
              'eof'
              'error'
              'eval'
              'exec'
              'exit'
              'expr'
              'fblocked'
              'fconfigure'
              'fcopy'
              'file'
              'fileevent'
              'flush'
              'for'
              'foreach'
              'format'
              'gets'
              'glob'
              'global'
              'history'
              'http'
              'if'
              'incr'
              'info'
              'interp'
              'join'
              'lappend'
              'lindex'
              'linsert'
              'list'
              'llength'
              'load'
              'loadTk'
              'lrange'
              'lreplace'
              'lsearch'
              'lset'
              'lsort'
              'memory'
              'msgcat'
              'namespace'
              'open'
              'package'
              'pid'
              'pkg::create'
              'pkg_mkIndex'
              'Platform-specific'
              'proc'
              'puts'
              'pwd'
              're_syntax'
              'read'
              'regexp'
              'registry'
              'regsub'
              'rename'
              'resource'
              'return'
              'scan'
              'seek'
              'set'
              'socket'
              'source'
              'split'
              'string'
              'subst'
              'switch'
              'tclLog'
              'tclMacPkgSearch'
              'tclPkgSetup'
              'tclPkgUnknown'
              'tell'
              'time'
              'trace'
              'unknown'
              'unset'
              'update'
              'uplevel'
              'upvar'
              'variable'
              'vwait'
              'while')
          end
          item
            KeywordListNumber = 1
            Name = 'TK Keywords'
            Keywords.Strings = (
              'bell'
              'bind'
              'bindtags'
              'bitmap'
              'button'
              'canvas'
              'checkbutton'
              'clipboard'
              'colors'
              'console'
              'cursors'
              'destroy'
              'entry'
              'event'
              'focus'
              'font'
              'frame'
              'grab'
              'grid'
              'image'
              'Inter-client'
              'keysyms'
              'label'
              'labelframe'
              'listbox'
              'lower'
              'menu'
              'menubutton'
              'message'
              'option'
              'options'
              'pack'
              'panedwindow'
              'photo'
              'place'
              'radiobutton'
              'raise'
              'scale'
              'scrollbar'
              'selection'
              'send'
              'spinbox'
              'text'
              'tk'
              'tk_chooseColor'
              'tk_chooseDirectory'
              'tk_dialog'
              'tk_focusNext'
              'tk_getOpenFile'
              'tk_messageBox'
              'tk_optionMenu'
              'tk_popup'
              'tk_setPalette'
              'tkerror'
              'tkvars'
              'tkwait'
              'toplevel'
              'winfo'
              'wish'
              'wm')
          end
          item
            KeywordListNumber = 2
            Name = 'iTCL Keywords'
            Keywords.Strings = (
              'tk_bisque'
              'tk_chooseColor'
              'tk_dialog'
              'tk_focusFollowsMouse'
              'tk_focusNext'
              'tk_focusPrev'
              'tk_getOpenFile'
              'tk_getSaveFile'
              'tk_messageBox'
              'tk_optionMenu'
              'tk_popup'
              'tk_setPalette'
              'tk_textCopy'
              'tk_textCut'
              'tk_textPaste'
              'tkButtonAutoInvoke'
              'tkButtonDown'
              'tkButtonEnter'
              'tkButtonInvoke'
              'tkButtonLeave'
              'tkButtonUp'
              'tkCancelRepeat'
              'tkCheckRadioDown'
              'tkCheckRadioEnter'
              'tkCheckRadioInvoke'
              'tkColorDialog'
              'tkColorDialog_BuildDialog'
              'tkColorDialog_CancelCmd'
              'tkColorDialog_Config'
              'tkColorDialog_CreateSelector'
              'tkColorDialog_DrawColorScale'
              'tkColorDialog_EnterColorBar'
              'tkColorDialog_HandleRGBEntry'
              'tkColorDialog_HandleSelEntry'
              'tkColorDialog_InitValues'
              'tkColorDialog_LeaveColorBar'
              'tkColorDialog_MoveSelector'
              'tkColorDialog_OkCmd'
              'tkColorDialog_RedrawColorBars'
              'tkColorDialog_RedrawFinalColor'
              'tkColorDialog_ReleaseMouse'
              'tkColorDialog_ResizeColorBars'
              'tkColorDialog_RgbToX'
              'tkColorDialog_SetRGBValue'
              'tkColorDialog_StartMove'
              'tkColorDialog_XToRgb'
              'tkConsoleAbout'
              'tkConsoleBind'
              'tkConsoleExit'
              'tkConsoleHistory'
              'tkConsoleInit'
              'tkConsoleInsert'
              'tkConsoleInvoke'
              'tkConsoleOutput'
              'tkConsolePrompt'
              'tkConsoleSource'
              'tkDarken'
              'tkEntryAutoScan'
              'tkEntryBackspace'
              'tkEntryButton1'
              'tkEntryClosestGap'
              'tkEntryGetSelection'
              'tkEntryInsert'
              'tkEntryKeySelect'
              'tkEntryMouseSelect'
              'tkEntryNextWord'
              'tkEntryPaste'
              'tkEntryPreviousWord'
              'tkEntrySeeInsert'
              'tkEntrySetCursor'
              'tkEntryTranspose'
              'tkEventMotifBindings'
              'tkFDGetFileTypes'
              'tkFirstMenu'
              'tkFocusGroup_BindIn'
              'tkFocusGroup_BindOut'
              'tkFocusGroup_Create'
              'tkFocusGroup_Destroy'
              'tkFocusGroup_In'
              'tkFocusGroup_Out'
              'tkFocusOK'
              'tkGenerateMenuSelect'
              'tkIconList'
              'tkIconList_Add'
              'tkIconList_Arrange'
              'tkIconList_AutoScan'
              'tkIconList_Btn1'
              'tkIconList_Config'
              'tkIconList_Create'
              'tkIconList_CtrlBtn1'
              'tkIconList_Curselection'
              'tkIconList_DeleteAll'
              'tkIconList_Double1'
              'tkIconList_DrawSelection'
              'tkIconList_FocusIn'
              'tkIconList_FocusOut'
              'tkIconList_Get'
              'tkIconList_Goto'
              'tkIconList_Index'
              'tkIconList_Invoke'
              'tkIconList_KeyPress'
              'tkIconList_Leave1'
              'tkIconList_LeftRight'
              'tkIconList_Motion1'
              'tkIconList_Reset'
              'tkIconList_ReturnKey'
              'tkIconList_See'
              'tkIconList_Select'
              'tkIconList_Selection'
              'tkIconList_ShiftBtn1'
              'tkIconList_UpDown'
              'tkListbox'
              'tkListboxAutoScan'
              'tkListboxBeginExtend'
              'tkListboxBeginSelect'
              'tkListboxBeginToggle'
              'tkListboxCancel'
              'tkListboxDataExtend'
              'tkListboxExtendUpDown'
              'tkListboxKeyAccel_Goto'
              'tkListboxKeyAccel_Key'
              'tkListboxKeyAccel_Reset'
              'tkListboxKeyAccel_Set'
              'tkListboxKeyAccel_Unset'
              'tkListboxMotion'
              'tkListboxSelectAll'
              'tkListboxUpDown'
              'tkMbButtonUp'
              'tkMbEnter'
              'tkMbLeave'
              'tkMbMotion'
              'tkMbPost'
              'tkMenuButtonDown'
              'tkMenuDownArrow'
              'tkMenuDup'
              'tkMenuEscape'
              'tkMenuFind'
              'tkMenuFindName'
              'tkMenuFirstEntry'
              'tkMenuInvoke'
              'tkMenuLeave'
              'tkMenuLeftArrow'
              'tkMenuMotion'
              'tkMenuNextEntry'
              'tkMenuNextMenu'
              'tkMenuRightArrow'
              'tkMenuUnpost'
              'tkMenuUpArrow'
              'tkMessageBox'
              'tkMotifFDialog'
              'tkMotifFDialog_ActivateDList'
              'tkMotifFDialog_ActivateFEnt'
              'tkMotifFDialog_ActivateFList'
              'tkMotifFDialog_ActivateSEnt'
              'tkMotifFDialog_BrowseDList'
              'tkMotifFDialog_BrowseFList'
              'tkMotifFDialog_BuildUI'
              'tkMotifFDialog_CancelCmd'
              'tkMotifFDialog_Config'
              'tkMotifFDialog_Create'
              'tkMotifFDialog_FileTypes'
              'tkMotifFDialog_FilterCmd'
              'tkMotifFDialog_InterpFilter'
              'tkMotifFDialog_LoadFiles'
              'tkMotifFDialog_MakeSList'
              'tkMotifFDialog_OkCmd'
              'tkMotifFDialog_SetFilter'
              'tkMotifFDialog_SetListMode'
              'tkMotifFDialog_Update'
              'tkPostOverPoint'
              'tkRecolorTree'
              'tkRestoreOldGrab'
              'tkSaveGrabInfo'
              'tkScaleActivate'
              'tkScaleButton2Down'
              'tkScaleButtonDown'
              'tkScaleControlPress'
              'tkScaleDrag'
              'tkScaleEndDrag'
              'tkScaleIncrement'
              'tkScreenChanged'
              'tkScrollButton2Down'
              'tkScrollButtonDown'
              'tkScrollButtonDrag'
              'tkScrollButtonUp'
              'tkScrollByPages'
              'tkScrollByUnits'
              'tkScrollDrag'
              'tkScrollEndDrag'
              'tkScrollSelect'
              'tkScrollStartDrag'
              'tkScrollTopBottom'
              'tkScrollToPos'
              'tkTabToWindow'
              'tkTearOffMenu'
              'tkTextAutoScan'
              'tkTextButton1'
              'tkTextClosestGap'
              'tkTextInsert'
              'tkTextKeyExtend'
              'tkTextKeySelect'
              'tkTextNextPara'
              'tkTextNextPos'
              'tkTextNextWord'
              'tkTextPaste'
              'tkTextPrevPara'
              'tkTextPrevPos'
              'tkTextPrevWord'
              'tkTextResetAnchor'
              'tkTextScrollPages'
              'tkTextSelectTo'
              'tkTextSetCursor'
              'tkTextTranspose'
              'tkTextUpDownLine'
              'tkTraverseToMenu'
              'tkTraverseWithinMenu')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '##'
        CommentBoxEnd = '##'
        CommentBoxMiddle = '#'
        CommentBlock = '#'
        CommentAtLineStart = True
        CommentStreamStart = '##'
        CommentStreamEnd = '##'
        NumStyleBits = 5
      end
      item
        Name = 'TEX'
        Lexer = 'tex'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Special'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Group'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Symbol'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Command'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Text'
            StyleNumber = 5
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'TeX, eTeX, pdfTeX, Omega'
          end
          item
            KeywordListNumber = 1
            Name = 'ConTeXt Dutch'
          end
          item
            KeywordListNumber = 2
            Name = 'ConTeXt English'
          end
          item
            KeywordListNumber = 3
            Name = 'ConTeXt German'
          end
          item
            KeywordListNumber = 4
            Name = 'ConTeXt Czech'
          end
          item
            KeywordListNumber = 5
            Name = 'ConTeXt Italian'
          end
          item
            KeywordListNumber = 6
            Name = 'ConTeXt Romanian'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'VB'
        Lexer = 'vb'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Whitespace'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 32639
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Date'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String Not Closed (EOL)'
            StyleNumber = 9
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'and'
              'begin'
              'case'
              'call'
              'class'
              'continue'
              'do'
              'each'
              'else'
              'elseif'
              'end'
              'erase'
              'error'
              'event'
              'exit'
              'false'
              'for'
              'function'
              'get'
              'gosub'
              'goto'
              'if'
              'implement'
              'in'
              'load'
              'loop'
              'lset'
              'me'
              'mid'
              'new'
              'next'
              'not'
              'nothing'
              'on'
              'or'
              'property'
              'raiseevent'
              'rem'
              'resume'
              'return'
              'rset'
              'select'
              'set'
              'stop'
              'sub'
              'then'
              'to'
              'true'
              'unload'
              'until'
              'wend'
              'while'
              'with'
              'withevents'
              'attribute'
              'alias'
              'as'
              'boolean'
              'byref'
              'byte'
              'byval'
              'const'
              'compare'
              'currency'
              'date'
              'declare'
              'dim'
              'double'
              'enum'
              'explicit'
              'friend'
              'global'
              'integer'
              'let'
              'lib'
              'long'
              'module'
              'object'
              'option'
              'optional'
              'preserve'
              'private'
              'public'
              'redim'
              'single'
              'static'
              'string'
              'type'
              'variant')
          end
          item
            KeywordListNumber = 1
            Name = 'User 1'
          end
          item
            KeywordListNumber = 2
            Name = 'User 2'
          end
          item
            KeywordListNumber = 3
            Name = 'User 3'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = #39
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'VBScript'
        Lexer = 'vbscript'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Whitespace'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Preprocessor'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 32639
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Date'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'String Not Closed (EOL)'
            StyleNumber = 9
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'and'
              'begin'
              'case'
              'call'
              'class'
              'continue'
              'do'
              'each'
              'else'
              'elseif'
              'end'
              'erase'
              'error'
              'event'
              'exit'
              'false'
              'for'
              'function'
              'get'
              'gosub'
              'goto'
              'if'
              'implement'
              'in'
              'load'
              'loop'
              'lset'
              'me'
              'mid'
              'new'
              'next'
              'not'
              'nothing'
              'on'
              'or'
              'property'
              'raiseevent'
              'rem'
              'resume'
              'return'
              'rset'
              'select'
              'set'
              'stop'
              'sub'
              'then'
              'to'
              'true'
              'unload'
              'until'
              'wend'
              'while'
              'with'
              'withevents'
              'attribute'
              'alias'
              'as'
              'boolean'
              'byref'
              'byte'
              'byval'
              'const'
              'compare'
              'currency'
              'date'
              'declare'
              'dim'
              'double'
              'enum'
              'explicit'
              'friend'
              'global'
              'integer'
              'let'
              'lib'
              'long'
              'module'
              'object'
              'option'
              'optional'
              'preserve'
              'private'
              'public'
              'redim'
              'single'
              'static'
              'string'
              'type'
              'variant')
          end
          item
            KeywordListNumber = 1
            Name = 'User 1'
          end
          item
            KeywordListNumber = 2
            Name = 'User 2'
          end
          item
            KeywordListNumber = 3
            Name = 'User 3'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = #39
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'VHDL'
        Lexer = 'vhdl'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'WhiteSpace'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bang Comment'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Number'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted string'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Operators?'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Identifier'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clWhite
            BackColor = 2105376
            CharCase = CASE_MIXED
            Name = 'End of line where string is not closed'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clOlive
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Keyword'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Std Operator'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12624032
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Attribute'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 2130048
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Std Function'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 2129952
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Std Package'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 8421408
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Std Type'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 4202624
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'User defined identifiers and tasks'
            StyleNumber = 14
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'access'
              'after'
              'alias'
              'all'
              'architecture'
              'array'
              'assert'
              'attribute'
              'begin'
              'block'
              'body'
              'buffer'
              'bus'
              'case'
              'component'
              'configuration'
              'constant'
              'disconnect'
              'downto'
              'else'
              'elsif'
              'end'
              'entity'
              'exit'
              'file'
              'for'
              'function'
              'generate'
              'generic'
              'group'
              'guarded'
              'if'
              'impure'
              'in'
              'inertial'
              'inout'
              'is'
              'label'
              'library'
              'linkage'
              'literal'
              'loop'
              'map'
              'new'
              'next'
              'null'
              'of'
              'on'
              'open'
              'others'
              'out'
              'package'
              'port'
              'postponed'
              'procedure'
              'process'
              'pure'
              'range'
              'record'
              'register'
              'reject'
              'report'
              'return'
              'select'
              'severity'
              'shared'
              'signal'
              'subtype'
              'then'
              'to'
              'transport'
              'type'
              'unaffected'
              'units'
              'until'
              'use'
              'variable'
              'wait'
              'when'
              'while'
              'with')
          end
          item
            KeywordListNumber = 1
            Name = 'Operators'
            Keywords.Strings = (
              'abs'
              'and'
              'mod'
              'nand'
              'nor'
              'not'
              'or'
              'rem'
              'rol'
              'ror'
              'sla'
              'sll'
              'sra'
              'srl'
              'xnor'
              'xor')
          end
          item
            KeywordListNumber = 2
            Name = 'Attributes'
            Keywords.Strings = (
              'left'
              'right'
              'low'
              'high'
              'ascending'
              'image'
              'value'
              'pos'
              'val'
              'succ'
              'pred'
              'leftof'
              'rightof'
              'base'
              'range'
              'reverse_range'
              'length'
              'delayed'
              'stable'
              'quiet'
              'transaction'
              'event'
              'active'
              'last_event'
              'last_active'
              'last_value'
              'driving'
              'driving_value'
              'simple_name'
              'path_name'
              'instance_name')
          end
          item
            KeywordListNumber = 3
            Name = 'Standard Functions'
            Keywords.Strings = (
              'now'
              'readline'
              'read'
              'writeline'
              'write'
              'endfile'
              'resolved'
              'to_bit'
              'to_bitvector'
              'to_stdulogic'
              'to_stdlogicvector'
              'to_stdulogicvector'
              'to_x01'
              'to_x01z'
              'to_UX01'
              'rising_edge'
              'falling_edge'
              'is_x'
              'shift_left'
              'shift_right'
              'rotate_left'
              'rotate_right'
              'resize'
              'to_integer'
              'to_unsigned'
              'to_signed'
              'std_match'
              'to_01')
          end
          item
            KeywordListNumber = 4
            Name = 'Standard Packages'
            Keywords.Strings = (
              'std'
              'ieee'
              'work'
              'standard'
              'textio'
              'std_logic_1164'
              'std_logic_arith'
              'std_logic_misc'
              'std_logic_signed'
              'std_logic_textio'
              'std_logic_unsigned'
              'numeric_bit'
              'numeric_std'
              'math_complex'
              'math_real'
              'vital_primitives'
              'vital_timing')
          end
          item
            KeywordListNumber = 5
            Name = 'Standard Types'
            Keywords.Strings = (
              'boolean'
              'bit'
              'character'
              'severity_level'
              'integer'
              'real'
              'time'
              'delay_length'
              'natural'
              'positive'
              'string'
              'bit_vector'
              'file_open_kind'
              'file_open_status'
              'line'
              'text'
              'side'
              'width'
              'std_ulogic'
              'std_ulogic_vector'
              'std_logic'
              'std_logic_vector'
              'X01'
              'X01Z'
              'UX01'
              'UX01Z'
              'unsigned'
              'signed')
          end
          item
            KeywordListNumber = 6
            Name = 'User Words'
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '--'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'VXML'
        Lexer = 'xml'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Tags'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Tags'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12624032
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Attributes'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12624032
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Attributes'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Numbers'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted strings'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted strings'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 10485920
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other inside tag'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Entities'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 10485920
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML style tag ends'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 10485920
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier start'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 10485920
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier end'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clMaroon
            BackColor = 15790335
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'CDATA'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 160
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML Question'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unquoted values'
            StyleNumber = 19
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML tags <! ... >'
            StyleNumber = 21
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML command'
            StyleNumber = 22
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 15793935
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML 1st param'
            StyleNumber = 23
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML double string'
            StyleNumber = 24
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML single string'
            StyleNumber = 25
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML error'
            StyleNumber = 26
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16737843
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML special'
            StyleNumber = 27
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML entity'
            StyleNumber = 28
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML comment'
            StyleNumber = 29
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 6684672
            BackColor = 14732492
            CharCase = CASE_MIXED
            Name = 'SGML block'
            StyleNumber = 31
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Elements and Attributes'
            Keywords.Strings = (
              'assign'
              'audio'
              'block'
              'break'
              'catch'
              'choice'
              'clear'
              'disconnect'
              'else'
              'elseif'
              'emphasis'
              'enumerate'
              'error'
              'exit'
              'field'
              'filled'
              'form'
              'goto'
              'grammar'
              'help'
              'if'
              'initial'
              'link'
              'log'
              'menu'
              'meta'
              'noinput'
              'nomatch'
              'object'
              'option'
              'p'
              'paragraph'
              'param'
              'phoneme'
              'prompt'
              'property'
              'prosody'
              'record'
              'reprompt'
              'return'
              's'
              'say-as'
              'script'
              'sentence'
              'subdialog'
              'submit'
              'throw'
              'transfer'
              'value'
              'var'
              'voice'
              'vxmlaccept'
              'age'
              'alphabet'
              'anchor'
              'application'
              'base'
              'beep'
              'bridge'
              'category'
              'charset'
              'classid'
              'cond'
              'connecttimeout'
              'content'
              'contour'
              'count'
              'dest'
              'destexpr'
              'dtmf'
              'dtmfterm'
              'duration'
              'enctype'
              'event'
              'eventexpr'
              'expr'
              'expritem'
              'fetchtimeout'
              'finalsilence'
              'gender'
              'http-equiv'
              'id'
              'level'
              'maxage'
              'maxstale'
              'maxtime'
              'message'
              'messageexpr'
              'method'
              'mime'
              'modal'
              'mode'
              'name'
              'namelist'
              'next'
              'nextitem'
              'ph'
              'pitch'
              'range'
              'rate'
              'scope'
              'size'
              'sizeexpr'
              'skiplist'
              'slot'
              'src'
              'srcexpr'
              'sub'
              'time'
              'timeexpr'
              'timeout'
              'transferaudio'
              'type'
              'value'
              'variant'
              'version'
              'volume'
              'xml:lang')
          end
          item
            KeywordListNumber = 5
            Name = 'DTD Keywords'
            Keywords.Strings = (
              'public'
              '!doctype')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '<!--'
        CommentBoxEnd = '-->'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '<!--'
        CommentStreamEnd = '-->'
        NumStyleBits = 5
      end
      item
        Name = 'WML'
        Lexer = 'xml'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Tags'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Tags'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12624032
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Attributes'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Attributes'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Numbers'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted strings'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted strings'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 10485920
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other inside tag'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Entities'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Short tag end'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier start'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier end'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = 15790335
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'CDATA'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 160
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML Question'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unquoted values'
            StyleNumber = 19
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML tags <! ... >'
            StyleNumber = 21
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML command'
            StyleNumber = 22
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 15793935
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML 1st param'
            StyleNumber = 23
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML double string'
            StyleNumber = 24
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML single string'
            StyleNumber = 25
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML error'
            StyleNumber = 26
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16737843
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML special'
            StyleNumber = 27
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML entity'
            StyleNumber = 28
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML comment'
            StyleNumber = 29
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 6684672
            BackColor = 14732492
            CharCase = CASE_MIXED
            Name = 'SGML block'
            StyleNumber = 31
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Elements and Attributes'
            Keywords.Strings = (
              'a'
              'access'
              'anchor'
              'big'
              'br'
              'em'
              'i'
              'p'
              'reset'
              'small'
              'strong'
              'card'
              'catch'
              'b'
              'do'
              'exit'
              'fieldset'
              'go'
              'head'
              'img'
              'input'
              'link'
              'meta'
              'noop'
              'onevent'
              'optgroup'
              'option'
              'postfield'
              'prev'
              'receive'
              'refresh'
              'select'
              'send'
              'setvar'
              'spawn'
              'table'
              'td'
              'template'
              'throw'
              'timer'
              'tr'
              'u'
              'wml'
              'xml'
              'href'
              'domain'
              'path'
              'title'
              'accesskey'
              'align'
              'id'
              'title'
              'newcontext'
              'ordered'
              'onenterforward'
              'onenterbackward'
              'ontimer'
              'name'
              'onthrow'
              'label'
              'optional'
              'type'
              'sendreferer'
              'method'
              'accept-charset'
              'http-equiv'
              'content'
              'src'
              'localsrc'
              'height'
              'width'
              'vspace'
              'hspace'
              'emptyok'
              'maxlength'
              'tabindex'
              'format'
              'size'
              'rel'
              'onpick'
              'value'
              'multiple'
              'iname'
              'ivalue'
              'onexit'
              'columns'
              'xml:lang'
              'version'
              'encoding')
          end
          item
            KeywordListNumber = 5
            Name = 'DTD Keywords'
            Keywords.Strings = (
              'ELEMENT'
              'DOCTYPE'
              'ATTLIST'
              'ENTITY'
              'NOTATION')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '<!--'
        CommentBoxEnd = '-->'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '<!--'
        CommentStreamEnd = '-->'
        NumStyleBits = 5
      end
      item
        Name = 'XML'
        Lexer = 'xml'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Tags'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Tags'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12624032
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Attributes'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Attributes'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Numbers'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted strings'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted strings'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 14745825
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other inside tag'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Entities'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 14745825
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML style tag ends'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier start'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier end'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'CDATA'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 160
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML Question'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unquoted values'
            StyleNumber = 19
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML tags <! ... >'
            StyleNumber = 21
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML command'
            StyleNumber = 22
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 15793935
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML 1st param'
            StyleNumber = 23
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML double string'
            StyleNumber = 24
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML single string'
            StyleNumber = 25
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clMaroon
            CharCase = CASE_MIXED
            Name = 'SGML error'
            StyleNumber = 26
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16737843
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML special'
            StyleNumber = 27
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML entity'
            StyleNumber = 28
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML comment'
            StyleNumber = 29
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 6684672
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'SGML block'
            StyleNumber = 31
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
          end
          item
            KeywordListNumber = 5
            Name = 'SGML Keywords'
            Keywords.Strings = (
              'ELEMENT'
              'DOCTYPE'
              'ATTLIST'
              'ENTITY'
              'NOTATION')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '<!--'
        CommentBoxEnd = '-->'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '<!--'
        CommentStreamEnd = '-->'
        NumStyleBits = 5
      end
      item
        Name = 'XSL'
        Lexer = 'xml'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clBlack
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Tags'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Tags'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 12624032
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Attributes'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Attributes'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Numbers'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted strings'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted strings'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 14745825
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other inside tag'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Entities'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 14745825
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML style tag ends'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier start'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier end'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clSkyBlue
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'CDATA'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 160
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML Question'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unquoted values'
            StyleNumber = 19
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML tags <! ... >'
            StyleNumber = 21
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML command'
            StyleNumber = 22
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 15793935
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML 1st param'
            StyleNumber = 23
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML double string'
            StyleNumber = 24
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML single string'
            StyleNumber = 25
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clMaroon
            CharCase = CASE_MIXED
            Name = 'SGML error'
            StyleNumber = 26
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16737843
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML special'
            StyleNumber = 27
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML entity'
            StyleNumber = 28
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML comment'
            StyleNumber = 29
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 6684672
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'SGML block'
            StyleNumber = 31
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.Strings = (
              'xml'
              'xsl:apply-imports'
              'xsl:apply-templates'
              'xsl:attribute'
              'xsl:attribute-set'
              'xsl:call-template'
              'xsl:choose'
              'xsl:comment'
              'xsl:copy'
              'xsl:copy-of'
              'xsl:decimal-format'
              'xsl:element'
              'xsl:fallback'
              'xsl:for-each'
              'xsl:if'
              'xsl:import'
              'xsl:include'
              'xsl:key'
              'xsl:message'
              'xsl:namespace-alias'
              'xsl:number'
              'xsl:otherwise'
              'xsl:output'
              'xsl:param'
              'xsl:preserve-space'
              'xsl:processing-instruction'
              'xsl:sort'
              'xsl:strip-space'
              'xsl:stylesheet'
              'xsl:template'
              'xsl:text'
              'xsl:transform'
              'xsl:value-of'
              'xsl:variable'
              'xsl:when'
              'xsl:with-param'
              'msxsl:script'
              'msxml:script'
              'xmlns:xsl'
              'xmlns:msxml'
              'elements'
              'indent'
              'match'
              'mode'
              'test'
              'namespace'
              'use-attribute-sets'
              'decimal-separator'
              'grouping-separator'
              'infinity'
              'minus-sign'
              'NaN'
              'percent'
              'per-mille'
              'zero-digit'
              'digit'
              'pattern-separator'
              'use'
              'terminate'
              'stylesheet-prefix'
              'result-prefix'
              'level'
              'count'
              'from'
              'value'
              'format'
              'lang'
              'letter-value'
              'grouping-size'
              'method'
              'version'
              'encoding'
              'omit-xml-declaration'
              'standalone'
              'doctype-public'
              'doctype-system'
              'cdata-section-elements'
              'indent'
              'media-type'
              'implements-prefix'
              'data-type'
              'order'
              'case-order'
              'extension-element-prefixes'
              'exclude-result-prefixes'
              'priority'
              'disable-output-escaping'
              'a'
              'abbr'
              'acronym'
              'address'
              'applet'
              'area'
              'b'
              'base'
              'basefont'
              'bdo'
              'big'
              'blockquote'
              'body'
              'br'
              'button'
              'caption'
              'center'
              'cite'
              'code'
              'col'
              'colgroup'
              'dd'
              'del'
              'dfn'
              'dir'
              'div'
              'dl'
              'dt'
              'em'
              'fieldset'
              'font'
              'form'
              'frame'
              'frameset'
              'h1'
              'h2'
              'h3'
              'h4'
              'h5'
              'h6'
              'head'
              'hr'
              'html'
              'i'
              'iframe'
              'img'
              'input'
              'ins'
              'isindex'
              'kbd'
              'label'
              'legend'
              'li'
              'link'
              'map'
              'menu'
              'meta'
              'noframes'
              'noscript'
              'object'
              'ol'
              'optgroup'
              'option'
              'p'
              'param'
              'pre'
              'q'
              's'
              'samp'
              'script'
              'select'
              'small'
              'span'
              'strike'
              'strong'
              'style'
              'sub'
              'sup'
              'table'
              'tbody'
              'td'
              'textarea'
              'tfoot'
              'th'
              'thead'
              'title'
              'tr'
              'tt'
              'u'
              'ul'
              'var'
              'xml'
              'xmlns'
              'abbr'
              'accept-charset'
              'accept'
              'accesskey'
              'action'
              'align'
              'alink'
              'alt'
              'archive'
              'axis'
              'background'
              'bgcolor'
              'border'
              'cellpadding'
              'cellspacing'
              'char'
              'charoff'
              'charset'
              'checked'
              'cite'
              'class'
              'classid'
              'clear'
              'codebase'
              'codetype'
              'color'
              'cols'
              'colspan'
              'compact'
              'content'
              'coords'
              'data'
              'datafld'
              'dataformatas'
              'datapagesize'
              'datasrc'
              'datetime'
              'declare'
              'defer'
              'dir'
              'disabled'
              'enctype'
              'event'
              'face'
              'for'
              'frame'
              'frameborder'
              'headers'
              'height'
              'href'
              'hreflang'
              'hspace'
              'http-equiv'
              'id'
              'ismap'
              'label'
              'lang'
              'language'
              'leftmargin'
              'link'
              'longdesc'
              'marginwidth'
              'marginheight'
              'maxlength'
              'media'
              'method'
              'multiple'
              'name'
              'nohref'
              'noresize'
              'noshade'
              'nowrap'
              'object'
              'onblur'
              'onchange'
              'onclick'
              'ondblclick'
              'onfocus'
              'onkeydown'
              'onkeypress'
              'onkeyup'
              'onload'
              'onmousedown'
              'onmousemove'
              'onmouseover'
              'onmouseout'
              'onmouseup'
              'onreset'
              'onselect'
              'onsubmit'
              'onunload'
              'profile'
              'prompt'
              'readonly'
              'rel'
              'rev'
              'rows'
              'rowspan'
              'rules'
              'scheme'
              'scope'
              'selected'
              'shape'
              'size'
              'span'
              'src'
              'standby'
              'start'
              'style'
              'summary'
              'tabindex'
              'target'
              'text'
              'title'
              'topmargin'
              'type'
              'usemap'
              'valign'
              'value'
              'valuetype'
              'version'
              'vlink'
              'vspace'
              'width'
              'text'
              'password'
              'checkbox'
              'radio'
              'submit'
              'reset'
              'file'
              'hidden'
              'image'
              'framespacing'
              'scrolling'
              'allowtransparency'
              'bordercolor'
              'OBJECT'
              'PARAM'
              'LI'
              'BODY'
              'UL')
          end
          item
            KeywordListNumber = 5
            Name = 'SGML Keywords'
            Keywords.Strings = (
              'ELEMENT'
              'DOCTYPE'
              'ATTLIST'
              'ENTITY'
              'NOTATION')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '<!--'
        CommentBoxEnd = '-->'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '<!--'
        CommentStreamEnd = '-->'
        NumStyleBits = 5
      end>
    LanguageManager.SelectedLanguage = 'C++/C'
    FoldDrawFlags = [sciBelowIfNotExpanded]
    KeyCommands = <
      item
        Command = 2300
        ShortCut = 40
      end
      item
        Command = 2301
        ShortCut = 8232
      end
      item
        Command = 2342
        ShortCut = 16424
      end
      item
        Command = 2426
        ShortCut = 41000
      end
      item
        Command = 2302
        ShortCut = 38
      end
      item
        Command = 2303
        ShortCut = 8230
      end
      item
        Command = 2343
        ShortCut = 16422
      end
      item
        Command = 2427
        ShortCut = 40998
      end
      item
        Command = 2415
        ShortCut = 49190
      end
      item
        Command = 2416
        ShortCut = 57382
      end
      item
        Command = 2413
        ShortCut = 49192
      end
      item
        Command = 2414
        ShortCut = 57384
      end
      item
        Command = 2304
        ShortCut = 37
      end
      item
        Command = 2305
        ShortCut = 8229
      end
      item
        Command = 2308
        ShortCut = 16421
      end
      item
        Command = 2309
        ShortCut = 24613
      end
      item
        Command = 2428
        ShortCut = 40997
      end
      item
        Command = 2306
        ShortCut = 39
      end
      item
        Command = 2307
        ShortCut = 8231
      end
      item
        Command = 2310
        ShortCut = 16423
      end
      item
        Command = 2311
        ShortCut = 24615
      end
      item
        Command = 2429
        ShortCut = 40999
      end
      item
        Command = 2390
        ShortCut = 49189
      end
      item
        Command = 2391
        ShortCut = 57381
      end
      item
        Command = 2392
        ShortCut = 49191
      end
      item
        Command = 2393
        ShortCut = 57383
      end
      item
        Command = 2331
        ShortCut = 36
      end
      item
        Command = 2332
        ShortCut = 8228
      end
      item
        Command = 2431
        ShortCut = 40996
      end
      item
        Command = 2316
        ShortCut = 16420
      end
      item
        Command = 2317
        ShortCut = 24612
      end
      item
        Command = 2345
        ShortCut = 32804
      end
      item
        Command = 2314
        ShortCut = 35
      end
      item
        Command = 2315
        ShortCut = 8227
      end
      item
        Command = 2318
        ShortCut = 16419
      end
      item
        Command = 2319
        ShortCut = 24611
      end
      item
        Command = 2347
        ShortCut = 32803
      end
      item
        Command = 2432
        ShortCut = 40995
      end
      item
        Command = 2320
        ShortCut = 33
      end
      item
        Command = 2321
        ShortCut = 8225
      end
      item
        Command = 2433
        ShortCut = 40993
      end
      item
        Command = 2322
        ShortCut = 34
      end
      item
        Command = 2323
        ShortCut = 8226
      end
      item
        Command = 2434
        ShortCut = 40994
      end
      item
        Command = 2180
        ShortCut = 46
      end
      item
        Command = 2177
        ShortCut = 8238
      end
      item
        Command = 2336
        ShortCut = 16430
      end
      item
        Command = 2396
        ShortCut = 24622
      end
      item
        Command = 2324
        ShortCut = 45
      end
      item
        Command = 2179
        ShortCut = 8237
      end
      item
        Command = 2178
        ShortCut = 16429
      end
      item
        Command = 2325
        ShortCut = 27
      end
      item
        Command = 2326
        ShortCut = 8
      end
      item
        Command = 2326
        ShortCut = 8200
      end
      item
        Command = 2335
        ShortCut = 16392
      end
      item
        Command = 2176
        ShortCut = 32776
      end
      item
        Command = 2395
        ShortCut = 24584
      end
      item
        Command = 2176
        ShortCut = 16474
      end
      item
        Command = 2011
        ShortCut = 16473
      end
      item
        Command = 2177
        ShortCut = 16472
      end
      item
        Command = 2178
        ShortCut = 16451
      end
      item
        Command = 2179
        ShortCut = 16470
      end
      item
        Command = 2013
        ShortCut = 16449
      end
      item
        Command = 2327
        ShortCut = 9
      end
      item
        Command = 2328
        ShortCut = 8201
      end
      item
        Command = 2329
        ShortCut = 13
      end
      item
        Command = 2329
        ShortCut = 8205
      end
      item
        Command = 2333
        ShortCut = 16491
      end
      item
        Command = 2334
        ShortCut = 16493
      end
      item
        Command = 2373
        ShortCut = 16495
      end
      item
        Command = 2337
        ShortCut = 16460
      end
      item
        Command = 2338
        ShortCut = 24652
      end
      item
        Command = 2455
        ShortCut = 24660
      end
      item
        Command = 2339
        ShortCut = 16468
      end
      item
        Command = 2469
        ShortCut = 16452
      end
      item
        Command = 2340
        ShortCut = 16469
      end
      item
        Command = 2341
        ShortCut = 24661
      end>
  end
  object MainMenu: TMainMenu
    Images = dmMain.MenuImages_Gnome
    Left = 464
    Top = 130
    object FileMenu: TMenuItem
      Action = actFileMenu
      object mnuNew: TMenuItem
        Caption = 'New'
        object NewSourceFileItem: TMenuItem
          Tag = 2
          Action = actNewSource
        end
        object NewWxDialogItem: TMenuItem
          Action = actNewwxDialog
        end
        object NewWxFrameItem: TMenuItem
          Action = actNewWxFrame
        end
        object N73: TMenuItem
          Caption = '-'
        end
        object NewprojectItem: TMenuItem
          Action = actNewProject
        end
        object N13: TMenuItem
          Caption = '-'
        end
        object NewresourcefileItem: TMenuItem
          Action = actNewRes
        end
        object NewTemplateItem: TMenuItem
          Action = actNewTemplate
        end
      end
      object N34: TMenuItem
        Caption = '-'
      end
      object OpenprojectItem: TMenuItem
        Tag = 1
        Action = actOpen
      end
      object ReOpenItem: TMenuItem
        AutoHotkeys = maManual
        Caption = '&Reopen'
        ImageIndex = 39
        object ClearhistoryItem: TMenuItem
          Action = actHistoryClear
        end
        object N11: TMenuItem
          Caption = '-'
          Enabled = False
        end
      end
      object N12: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object SaveUnitItem: TMenuItem
        Tag = 3
        Action = actSave
      end
      object SaveUnitAsItem: TMenuItem
        Action = actSaveAs
      end
      object SaveprojectasItem: TMenuItem
        Action = actSaveProjectAs
      end
      object SaveallItem: TMenuItem
        Action = actSaveAll
      end
      object N33: TMenuItem
        Caption = '-'
      end
      object CloseItem: TMenuItem
        Tag = 4
        Action = actClose
      end
      object CloseAll2: TMenuItem
        Action = actCloseAll
      end
      object CloseprojectItem: TMenuItem
        Action = actCloseProject
      end
      object N35: TMenuItem
        Caption = '-'
      end
      object Properties1: TMenuItem
        Action = actFileProperties
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object ImportItem: TMenuItem
        Caption = '&Import'
        object ImportMSVisualCproject1: TMenuItem
          Action = actImportMSVC
        end
      end
      object ExportItem: TMenuItem
        Caption = '&Export'
        ImageIndex = 12
        object HTMLItem: TMenuItem
          Action = actXHTML
        end
        object RTFItem: TMenuItem
          Action = actXRTF
        end
        object N19: TMenuItem
          Caption = '-'
        end
        object ProjecttoHTMLItem: TMenuItem
          Action = actXProject
        end
      end
      object N43: TMenuItem
        Caption = '-'
      end
      object PrintItem: TMenuItem
        Tag = 5
        Action = actPrint
      end
      object PrinterSetupItem: TMenuItem
        Action = actPrintSU
      end
      object N3: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object ExitItem: TMenuItem
        Action = actExit
        GroupIndex = 9
      end
    end
    object EditMenu: TMenuItem
      Action = actEditMenu
      object UndoItem: TMenuItem
        Tag = 6
        Action = actUndo
      end
      object RedoItem: TMenuItem
        Action = actRedo
      end
      object N4: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object CutItem: TMenuItem
        Action = actCut
        AutoHotkeys = maAutomatic
        AutoLineReduction = maAutomatic
      end
      object CopyItem: TMenuItem
        Action = actCopy
      end
      object PasteItem: TMenuItem
        Action = actPaste
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object Swapheadersource2: TMenuItem
        Action = actSwapHeaderSource
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object InsertItem: TMenuItem
        Caption = '&Insert'
        object DateTimeMenuItem: TMenuItem
          Caption = '&Date/Time'
          OnClick = DateTimeMenuItemClick
        end
        object CommentheaderMenuItem: TMenuItem
          Caption = '&Comment header'
          OnClick = CommentheaderMenuItemClick
        end
      end
      object ToggleBookmarksItem: TMenuItem
        Caption = 'Toggle &Bookmarks'
        ImageIndex = 19
      end
      object GotoBookmarksItem: TMenuItem
        Caption = '&Goto Bookmarks'
        ImageIndex = 20
      end
      object N5: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object SelectallItem: TMenuItem
        Action = actSelectAll
      end
      object N26: TMenuItem
        Caption = '-'
      end
      object Comment1: TMenuItem
        Action = actComment
        ShortCut = 16574
      end
      object Uncomment1: TMenuItem
        Action = actUncomment
        ShortCut = 16556
      end
      object N27: TMenuItem
        Caption = '-'
      end
      object Indent1: TMenuItem
        Action = actIndent
      end
      object Unindent1: TMenuItem
        Action = actUnindent
      end
    end
    object SearchMenu: TMenuItem
      Action = actSearchMenu
      object FindItem: TMenuItem
        Tag = 7
        Action = actFind
      end
      object FindinallfilesItem: TMenuItem
        Action = actFindAll
      end
      object FindnextItem: TMenuItem
        Action = actFindNext
      end
      object ReplaceItem: TMenuItem
        Action = actReplace
      end
      object IncrementalSearch1: TMenuItem
        Action = actIncremental
      end
      object N7: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object Gotofunction1: TMenuItem
        Action = actGotoFunction
      end
      object GotolineItem: TMenuItem
        Action = actGoto
      end
    end
    object ViewMenu: TMenuItem
      Action = actViewMenu
      object StatusbarItem: TMenuItem
        Action = actStatusbar
        AutoCheck = True
      end
      object ToDolist1: TMenuItem
        Action = actViewToDoList
      end
      object ToolbarsItem: TMenuItem
        Caption = '&Toolbars'
        ImageIndex = 44
        object ToolMainItem: TMenuItem
          AutoCheck = True
          Caption = '&Main'
          Checked = True
          OnClick = ToolbarClick
        end
        object ToolEditItem: TMenuItem
          AutoCheck = True
          Caption = 'Edit'
          Checked = True
          OnClick = ToolbarClick
        end
        object ToolSearchItem: TMenuItem
          AutoCheck = True
          Caption = 'Search'
          Checked = True
          OnClick = ToolbarClick
        end
        object N2: TMenuItem
          Caption = '-'
        end
        object ToolCompileandRunItem: TMenuItem
          AutoCheck = True
          Caption = '&Compile and Run'
          Checked = True
          OnClick = ToolbarClick
        end
        object ToolDebugItem: TMenuItem
          AutoCheck = True
          Caption = '&Debug'
          Checked = True
          OnClick = ToolbarClick
        end
        object ToolProjectItem: TMenuItem
          AutoCheck = True
          Caption = '&Project'
          Checked = True
          OnClick = ToolbarClick
        end
        object N9: TMenuItem
          Caption = '-'
        end
        object ToolOptionItem: TMenuItem
          AutoCheck = True
          Caption = '&Options and help'
          Checked = True
          OnClick = ToolbarClick
        end
        object ToolSpecialsItem: TMenuItem
          AutoCheck = True
          Caption = '&Specials'
          Checked = True
          OnClick = ToolbarClick
        end
        object N17: TMenuItem
          Caption = '-'
        end
        object ToolClassesItem: TMenuItem
          AutoCheck = True
          Caption = 'Classes'
          Checked = True
          OnClick = ToolbarClick
        end
      end
      object N63: TMenuItem
        Caption = '-'
      end
      object ShowProjectInspItem: TMenuItem
        Caption = 'Show &Project Inspector'
        OnClick = ShowProjectInspItemClick
      end
      object N57: TMenuItem
        Caption = '-'
      end
      object GotoprojectmanagerItem: TMenuItem
        Caption = 'Go to Project &Inspector'
        ShortCut = 16497
        OnClick = actGotoProjectManagerExecute
      end
      object GoToClassBrowserItem: TMenuItem
        Caption = 'Go to Class &Browser'
        ShortCut = 16498
        OnClick = GoToClassBrowserItemClick
      end
    end
    object ProjectMenu: TMenuItem
      Action = actProjectMenu
      object NewunitinprojectItem: TMenuItem
        Tag = 2
        Action = actProjectNew
      end
      object AddtoprojectItem: TMenuItem
        Action = actProjectAdd
      end
      object RemovefromprojectItem: TMenuItem
        Action = actProjectRemove
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object ProjectoptionsItem: TMenuItem
        Action = actProjectOptions
      end
    end
    object ExecuteMenu: TMenuItem
      Action = actExecuteMenu
      object CompileItem: TMenuItem
        Tag = 8
        Action = actCompile
      end
      object Compilecurrentfile1: TMenuItem
        Action = actCompileCurrentFile
      end
      object RunItem: TMenuItem
        Tag = 9
        Action = actRun
      end
      object mnuExecParameters: TMenuItem
        Action = actExecParams
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object CompileandRunItem: TMenuItem
        Action = actCompRun
      end
      object RebuildallItem: TMenuItem
        Action = actRebuild
      end
      object SyntaxCheckItem: TMenuItem
        Action = actSyntaxCheck
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object CleanItem: TMenuItem
        Action = actClean
      end
      object N29: TMenuItem
        Caption = '-'
      end
      object Profileanalysis1: TMenuItem
        Action = actProfileProject
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object Programreset1: TMenuItem
        Action = actProgramReset
      end
    end
    object DebugMenu: TMenuItem
      Action = actDebugMenu
      object DebugItem: TMenuItem
        Tag = 10
        Action = actDebug
      end
      object Pause1: TMenuItem
        Action = actPauseDebug
      end
      object StopExecution1: TMenuItem
        Action = actStopExecute
        ShortCut = 49265
      end
      object Restart1: TMenuItem
        Action = actRestartDebug
      end
      object AttachtoprocessItem: TMenuItem
        Action = actAttachProcess
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object TogglebreakpointItem: TMenuItem
        Action = actBreakPoint
      end
      object DbgStepOver: TMenuItem
        Action = actStepOver
      end
      object DbgStepInto: TMenuItem
        Action = actStepInto
        ShortCut = 8310
      end
      object RuntocursorItem: TMenuItem
        Action = actRunToCursor
        ShortCut = 8307
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object AddwatchItem: TMenuItem
        Action = actAddWatch
      end
      object WatchItem: TMenuItem
        Action = actWatchItem
        GroupIndex = 9
      end
      object ViewCPUItem: TMenuItem
        Action = actViewCPU
        GroupIndex = 9
      end
    end
    object ToolsMenu: TMenuItem
      Action = actToolsMenu
      GroupIndex = 9
      object CompileroptionsItem: TMenuItem
        Tag = 11
        Action = actCompOptions
      end
      object EnvironmentoptionsItem: TMenuItem
        Tag = 12
        Action = actEnviroOptions
      end
      object EditorOptions1: TMenuItem
        Action = actEditorOptions
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object Configureshortcuts1: TMenuItem
        Action = actConfigShortcuts
      end
      object ConfiguretoolsItem: TMenuItem
        Action = actConfigTools
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object CheckforupdatesItem: TMenuItem
        Action = actUpdateCheck
      end
      object mnuToolSep1: TMenuItem
        Caption = '-'
      end
      object PackageManagerItem: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000BFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000000000000
          0000000000000000000000000000000000000000000000000000BFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBF000000DFDFDFB8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
          B8B8B8B8969696000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000F3F3F3DF
          DFDFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFB8B8B8000000BFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBF000000F3F3F3DFDFDF656565CFCFCF6565656565656565
          65CFCFCFB8B8B8000000000000000000000000000000000000000000F3F3F3DF
          DFDFDFDFDFDFDFDFDFDFDFCFCFCFCFCFCFCFCFCFB8B8B80000000000004CC6FF
          4CB5E64CB5E64CB5E6000000F3F3F3DFDFDF656565656565DFDFDF6565656565
          65CFCFCFB8B8B80000000000008DDBFF4CC6FF4CC6FF4CC6FF000000FFFFFFF3
          F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3DFDFDF0000000000008DDBFF
          4CC6FF4CC6FF4CC6FF6868680000000000000000000000000000000000000000
          000000000000000000000000008DDBFF4CC6FF4CC6FF4CC6FF4CC6FF4CC6FF24
          607B4CC6FF4CC6FF4CC6FF4CC6FF4CC6FF4CB5E6000000BFBFBF000000296D8C
          24607B24607B24607B24607B24607B24607B24607B24607B24607B24607B2460
          7B1F536B000000BFBFBF0000008DDBFF4CC6FF4CC6FF4CC6FF4CC6FF4CC6FF24
          607B4CC6FF4CC6FF226C8B226C8B226C8B4CB5E6000000BFBFBF0000008DDBFF
          4CC6FF4CC6FF4CC6FF4CC6FF4CC6FF24607B4CC6FF4CC6FF226C8B226C8B226C
          8B4CB5E6000000BFBFBF0000008DDBFF4CC6FF4CC6FF4CC6FF4CC6FF4CC6FF24
          607B4CC6FF4CC6FF226C8B226C8B226C8B4CB5E6000000BFBFBF000000D1F1FF
          8DDBFF8DDBFF8DDBFF8DDBFF8DDBFF296D8C8DDBFF8DDBFF8DDBFF8DDBFF8DDB
          FF4CC6FF000000BFBFBF68686800000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000BFBFBF}
        Caption = '&Package Manager'
        OnClick = PackageManagerItemClick
      end
    end
    object mnuCVS: TMenuItem
      Caption = 'CVS'
      GroupIndex = 9
      OnClick = mnuCVSClick
      object mnuCVSCurrent: TMenuItem
        Caption = 'Current File...'
        object mnuCVSUpdate: TMenuItem
          Tag = 3
          Action = actCVSUpdate
        end
        object mnuCVSDiff: TMenuItem
          Tag = 3
          Action = actCVSDiff
        end
        object N53: TMenuItem
          Caption = '-'
        end
        object mnuCVSCommit: TMenuItem
          Tag = 3
          Action = actCVSCommit
        end
        object N56: TMenuItem
          Caption = '-'
        end
        object mnuCVSLog: TMenuItem
          Tag = 3
          Action = actCVSLog
        end
        object N61: TMenuItem
          Caption = '-'
        end
        object mnuCVSAdd: TMenuItem
          Tag = 3
          Action = actCVSAdd
        end
        object mnuCVSRemove: TMenuItem
          Tag = 3
          Action = actCVSRemove
        end
      end
      object mnuCVSWhole: TMenuItem
        Caption = 'Whole Project...'
        object mnuCVSUpdateP: TMenuItem
          Tag = 4
          Action = actCVSUpdate
        end
        object mnuCVSDiffP: TMenuItem
          Tag = 4
          Action = actCVSDiff
        end
        object N58: TMenuItem
          Caption = '-'
        end
        object Commit1: TMenuItem
          Tag = 4
          Action = actCVSCommit
        end
        object N46: TMenuItem
          Caption = '-'
        end
        object mnuCVSLogP: TMenuItem
          Tag = 4
          Action = actCVSLog
        end
      end
      object N65: TMenuItem
        Caption = '-'
      end
      object Login1: TMenuItem
        Action = actCVSLogin
      end
      object Logout1: TMenuItem
        Action = actCVSLogout
      end
      object N66: TMenuItem
        Caption = '-'
      end
      object mnuCVSImportP: TMenuItem
        Tag = 4
        Action = actCVSImport
      end
      object mnuCVSCheckoutP: TMenuItem
        Tag = 4
        Action = actCVSCheckout
      end
    end
    object WindowMenu: TMenuItem
      Action = actWindowMenu
      GroupIndex = 9
      object CloseAllItem: TMenuItem
        Action = actCloseAll
      end
      object N28: TMenuItem
        Caption = '-'
      end
      object FullscreenmodeItem: TMenuItem
        Action = actFullScreen
        AutoCheck = True
        Enabled = False
      end
      object N36: TMenuItem
        Caption = '-'
      end
      object NextItem: TMenuItem
        Action = actNext
      end
      object PreviousItem: TMenuItem
        Action = actPrev
      end
      object N32: TMenuItem
        Caption = '-'
      end
      object ListItem: TMenuItem
        Caption = '&List...'
        OnClick = ListItemClick
      end
    end
    object HelpMenu: TMenuItem
      Action = actHelpMenu
      SubMenuImages = dmMain.HelpImages_Gnome
      GroupIndex = 9
      object HelpMenuItem: TMenuItem
        Caption = '&Help on Dev-C++'
        OnClick = HelpMenuItemClick
      end
      object HelpSep1: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object HelpSep2: TMenuItem
        Caption = '-'
      end
      object Customize1: TMenuItem
        Action = actHelpCustomize
        Caption = 'Customize Help Menu...'
      end
      object Tips1: TMenuItem
        Action = actShowTips
        Caption = 'Tip of the Day'
      end
      object AboutDevCppItem: TMenuItem
        Tag = 18
        Action = actAbout
        Caption = 'About wxDev-C++...'
      end
    end
  end
  object EditorPopupMenu: TPopupMenu
    Images = dmMain.MenuImages_Gnome
    Left = 574
    Top = 102
    object Close1: TMenuItem
      Action = actClose
    end
    object CloseAll1: TMenuItem
      Action = actCloseAll
    end
    object Closeallexceptthis1: TMenuItem
      Action = actCloseAllButThis
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object UndoPopItem: TMenuItem
      Action = actUndo
    end
    object RedoPopItem: TMenuItem
      Action = actRedo
    end
    object MenuItem1: TMenuItem
      Caption = '-'
    end
    object CutPopItem: TMenuItem
      Action = actCut
    end
    object CopyPopItem: TMenuItem
      Action = actCopy
    end
    object PastePopItem: TMenuItem
      Action = actPaste
    end
    object SelectAllPopItem: TMenuItem
      Action = actSelectAll
    end
    object DeletePopItem: TMenuItem
      Action = actDelete
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object Swapheadersource1: TMenuItem
      Action = actSwapHeaderSource
      ShortCut = 16456
    end
    object MenuItem2: TMenuItem
      Caption = '-'
    end
    object InsertPopItem: TMenuItem
      Caption = '&Insert'
      object CommentheaderPopItem: TMenuItem
        Caption = 'Comment header'
      end
      object DateandtimePopItem: TMenuItem
        Caption = 'Date and time'
      end
      object MenuItem3: TMenuItem
        Caption = '-'
      end
      object MainfunctionPopItem: TMenuItem
        Caption = 'Main function'
      end
      object WinMainfunctionPopItem: TMenuItem
        Caption = 'WinMain function'
      end
      object MenuItem4: TMenuItem
        Caption = '-'
      end
      object ifdefPopItem: TMenuItem
        Caption = '#ifdef'
      end
      object ifndefPopItem: TMenuItem
        Caption = '#ifndef'
      end
      object includePopItem: TMenuItem
        Caption = '#include'
      end
      object MenuItem5: TMenuItem
        Caption = '-'
      end
      object ifPopItem: TMenuItem
        Caption = 'if ()'
      end
      object whilePopItem: TMenuItem
        Caption = 'while ()'
      end
      object dowhilePopItem: TMenuItem
        Caption = 'do..while ()'
      end
      object forPopItem: TMenuItem
        Caption = 'for ()'
      end
      object MenuItem6: TMenuItem
        Caption = '-'
      end
      object MessageBoxPopItem: TMenuItem
        Caption = 'MessageBox'
      end
    end
    object SurroundWithPopItem: TMenuItem
      Caption = 'Surround With'
      object trycatchPopItem: TMenuItem
        Caption = 'try...catch'
      end
      object N68: TMenuItem
        Caption = '-'
      end
      object forloopPopItem: TMenuItem
        Caption = 'for'
      end
      object forintloopPopItem: TMenuItem
        Caption = 'for(int i...'
      end
      object whileLoopPopItem: TMenuItem
        Caption = 'while'
      end
      object dowhileLoopPopItem: TMenuItem
        Caption = 'do..while'
      end
      object N71: TMenuItem
        Caption = '-'
      end
      object ifLoopPopItem: TMenuItem
        Caption = 'if'
      end
      object ifelseloopPopItem: TMenuItem
        Caption = 'if...else'
      end
      object switchLoopPopItem: TMenuItem
        Caption = 'switch'
      end
      object N72: TMenuItem
        Caption = '-'
      end
      object bracesPopItem: TMenuItem
        Caption = '{..}'
      end
      object N69: TMenuItem
        Caption = '-'
      end
      object CStyleCommentPopItem: TMenuItem
        Caption = 'C Style Comment'
      end
      object CppStyleCommentPopItem: TMenuItem
        Caption = 'C++ Style Comment'
      end
    end
    object N70: TMenuItem
      Caption = '-'
    end
    object TogglebookmarksPopItem: TMenuItem
      Caption = '&Toggle bookmarks'
    end
    object GotobookmarksPopItem: TMenuItem
      Caption = '&Goto bookmarks'
    end
    object N41: TMenuItem
      Caption = '-'
    end
    object ToggleBreakpointPopupItem: TMenuItem
      Action = actBreakPoint
    end
    object AddWatchPopupItem: TMenuItem
      Action = actAddWatch
    end
    object Runtocursor1: TMenuItem
      Action = actRunToCursor
    end
    object N38: TMenuItem
      Caption = '-'
    end
    object AddToDoitem1: TMenuItem
      Action = actAddToDo
    end
    object N45: TMenuItem
      Caption = '-'
    end
    object CVS1: TMenuItem
      Caption = 'CVS'
      object mnuCVSUpdate3: TMenuItem
        Tag = 3
        Action = actCVSUpdate
      end
      object mnuCVSDiff3: TMenuItem
        Tag = 3
        Action = actCVSDiff
      end
      object N60: TMenuItem
        Caption = '-'
      end
      object mnuCVSCommit3: TMenuItem
        Tag = 3
        Action = actCVSCommit
      end
      object N47: TMenuItem
        Caption = '-'
      end
      object mnuCVSLog3: TMenuItem
        Tag = 3
        Action = actCVSLog
      end
    end
    object N50: TMenuItem
      Caption = '-'
    end
    object mnuFileProps: TMenuItem
      Action = actFileProperties
    end
  end
  object UnitPopup: TPopupMenu
    Images = dmMain.MenuImages_Gnome
    MenuAnimation = [maBottomToTop]
    Left = 519
    Top = 102
    object RemoveFilefromprojectPopItem: TMenuItem
      Action = actUnitRemove
    end
    object RenamefilePopItem: TMenuItem
      Action = actUnitRename
    end
    object N30: TMenuItem
      Caption = '-'
    end
    object OpenPopItem: TMenuItem
      Action = actUnitOpen
    end
    object mnuOpenWith: TMenuItem
      Caption = 'Open with'
      OnClick = mnuOpenWithClick
    end
    object ClosefilePopItem: TMenuItem
      Action = actUnitClose
    end
    object N40: TMenuItem
      Caption = '-'
    end
    object Addfile1: TMenuItem
      Action = actProjectAdd
    end
    object N44: TMenuItem
      Caption = '-'
    end
    object Addfolder1: TMenuItem
      Action = actProjectNewFolder
    end
    object Renamefolder1: TMenuItem
      Action = actProjectRenameFolder
    end
    object Removefolder1: TMenuItem
      Action = actProjectRemoveFolder
    end
    object N49: TMenuItem
      Caption = '-'
    end
    object CVS3: TMenuItem
      Caption = 'CVS'
      object mnuCVSUpdate2: TMenuItem
        Tag = 2
        Action = actCVSUpdate
      end
      object mnuCVSDiff2: TMenuItem
        Tag = 2
        Action = actCVSDiff
      end
      object N52: TMenuItem
        Caption = '-'
      end
      object mnuCVSCommit2: TMenuItem
        Tag = 2
        Action = actCVSCommit
      end
      object N51: TMenuItem
        Caption = '-'
      end
      object mnuCVSLog2: TMenuItem
        Tag = 2
        Action = actCVSLog
      end
      object N62: TMenuItem
        Caption = '-'
      end
      object mnuCVSAdd2: TMenuItem
        Tag = 2
        Action = actCVSAdd
      end
      object mnuCVSRemove2: TMenuItem
        Tag = 2
        Action = actCVSRemove
      end
    end
    object N54: TMenuItem
      Caption = '-'
    end
    object mnuUnitProperties: TMenuItem
      Action = actFileProperties
    end
  end
  object ProjectPopup: TPopupMenu
    Images = dmMain.MenuImages_Gnome
    MenuAnimation = [maBottomToTop]
    Left = 547
    Top = 102
    object NewunitinprojectPopItem: TMenuItem
      Tag = 2
      Action = actProjectNew
    end
    object AddtoprojectPopItem: TMenuItem
      Action = actProjectAdd
    end
    object RemovefromprojectPopItem: TMenuItem
      Action = actProjectRemove
    end
    object N39: TMenuItem
      Caption = '-'
    end
    object Newfolder1: TMenuItem
      Action = actProjectNewFolder
    end
    object MenuItem18: TMenuItem
      Caption = '-'
    end
    object ProjectoptionsPopItem: TMenuItem
      Action = actProjectOptions
    end
    object N48: TMenuItem
      Caption = '-'
    end
    object CVS2: TMenuItem
      Caption = 'CVS'
      object mnuCVSUpdate1: TMenuItem
        Tag = 1
        Action = actCVSUpdate
      end
      object mnuCVSDiff1: TMenuItem
        Tag = 1
        Action = actCVSDiff
      end
      object N59: TMenuItem
        Caption = '-'
      end
      object mnuCVSCommit1: TMenuItem
        Tag = 1
        Action = actCVSCommit
      end
      object N55: TMenuItem
        Caption = '-'
      end
      object mnuCVSLog1: TMenuItem
        Tag = 1
        Action = actCVSLog
      end
    end
  end
  object HelpPop: TPopupMenu
    Left = 436
    Top = 102
    object HelponDevPopupItem: TMenuItem
      Caption = '&Help on Dev-C++'
      OnClick = HelpMenuItemClick
    end
    object N64: TMenuItem
      Caption = '-'
    end
  end
  object alMain: TActionList
    Images = dmMain.MenuImages_Gnome
    Left = 492
    Top = 130
    object actViewCPU: TAction
      Category = 'Debug'
      Caption = '&View CPU Window'
      OnExecute = ViewCPUItemClick
      OnUpdate = actUpdateDebuggerRunning
    end
    object actNewSource: TAction
      Tag = 1
      Category = 'File'
      Caption = '&Source File'
      ImageIndex = 1
      ShortCut = 16462
      OnExecute = actNewSourceExecute
    end
    object actNewProject: TAction
      Tag = 2
      Category = 'File'
      Caption = '&Project...'
      ImageIndex = 0
      OnExecute = actNewProjectExecute
    end
    object actRunToCursor: TAction
      Category = 'Debug'
      Caption = 'Run to &cursor'
      ImageIndex = 24
      ShortCut = 16499
      OnExecute = actRunToCursorExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actNewRes: TAction
      Tag = 3
      Category = 'File'
      Caption = '&Resource File'
      ImageIndex = 2
      OnExecute = actNewResExecute
    end
    object actNewTemplate: TAction
      Tag = 4
      Category = 'File'
      Caption = '&Template...'
      ImageIndex = 3
      OnExecute = actNewTemplateExecute
      OnUpdate = actNewTemplateUpdate
    end
    object actOpen: TAction
      Tag = 1
      Category = 'File'
      Caption = '&Open project or file...'
      ImageIndex = 4
      ShortCut = 16463
      OnExecute = actOpenExecute
    end
    object actHistoryClear: TAction
      Tag = 2
      Category = 'File'
      Caption = '&Clear History'
      ImageIndex = 5
      OnExecute = actHistoryClearExecute
    end
    object actSave: TAction
      Tag = 3
      Category = 'File'
      Caption = '&Save'
      ImageIndex = 6
      ShortCut = 16467
      OnExecute = actSaveExecute
      OnUpdate = actSaveUpdate
    end
    object actSaveAs: TAction
      Tag = 4
      Category = 'File'
      Caption = 'Save &As'
      ImageIndex = 7
      ShortCut = 16507
      OnExecute = actSaveAsExecute
      OnUpdate = actSaveAsUpdate
    end
    object actSaveProjectAs: TAction
      Category = 'File'
      Caption = 'Save project as...'
      ImageIndex = 7
      OnExecute = actSaveProjectAsExecute
      OnUpdate = actUpdateProject
    end
    object actSaveAll: TAction
      Tag = 5
      Category = 'File'
      Caption = 'Save A&ll'
      ImageIndex = 8
      OnExecute = actSaveAllExecute
      OnUpdate = actUpdatePageorProject
    end
    object actClose: TAction
      Tag = 7
      Category = 'File'
      Caption = '&Close'
      ImageIndex = 9
      ShortCut = 16499
      OnExecute = actCloseExecute
      OnUpdate = actUpdatePageCount
    end
    object actCloseAll: TAction
      Tag = 11
      Category = 'File'
      Caption = 'Close All'
      OnExecute = actCloseAllExecute
      OnUpdate = actUpdatePageCount
    end
    object actCloseProject: TAction
      Tag = 6
      Category = 'File'
      Caption = 'Close Project'
      OnExecute = actCloseProjectExecute
      OnUpdate = actUpdateProject
    end
    object actXHTML: TAction
      Tag = 1
      Category = 'File'
      Caption = 'to &HTML'
      OnExecute = actXHTMLExecute
      OnUpdate = actUpdatePageCount
    end
    object actXRTF: TAction
      Tag = 2
      Category = 'File'
      Caption = 'to &RTF'
      OnExecute = actXRTFExecute
      OnUpdate = actUpdatePageCount
    end
    object actXProject: TAction
      Tag = 3
      Category = 'File'
      Caption = '&Project to HTML'
      OnExecute = actXProjectExecute
      OnUpdate = actUpdateProject
    end
    object actPrint: TAction
      Tag = 8
      Category = 'File'
      Caption = '&Print'
      ImageIndex = 10
      ShortCut = 16464
      OnExecute = actPrintExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actPrintSU: TAction
      Tag = 9
      Category = 'File'
      Caption = 'Prin&ter Setup...'
      OnExecute = actPrintSUExecute
    end
    object actExit: TAction
      Tag = 10
      Category = 'File'
      Caption = 'E&xit Dev-C++'
      ImageIndex = 11
      OnExecute = actExitExecute
    end
    object actUndo: TAction
      Tag = 1
      Category = 'Edit'
      Caption = '&Undo'
      ImageIndex = 13
      ShortCut = 16474
      OnExecute = actUndoExecute
      OnUpdate = actUndoUpdate
    end
    object actRedo: TAction
      Tag = 2
      Category = 'Edit'
      Caption = '&Redo'
      ImageIndex = 14
      ShortCut = 24666
      OnExecute = actRedoExecute
      OnUpdate = actRedoUpdate
    end
    object actCut: TAction
      Tag = 3
      Category = 'Edit'
      Caption = 'C&ut'
      ImageIndex = 15
      ShortCut = 16472
      OnExecute = actCutExecute
      OnUpdate = actCutUpdate
    end
    object actCopy: TAction
      Tag = 4
      Category = 'Edit'
      Caption = '&Copy'
      ImageIndex = 16
      ShortCut = 16451
      OnExecute = actCopyExecute
      OnUpdate = actCopyUpdate
    end
    object actPaste: TAction
      Tag = 5
      Category = 'Edit'
      Caption = '&Paste'
      ImageIndex = 17
      ShortCut = 16470
      OnExecute = actPasteExecute
      OnUpdate = actPasteUpdate
    end
    object actSelectAll: TAction
      Tag = 6
      Category = 'Edit'
      Caption = '&Select All'
      ShortCut = 16449
      OnExecute = actSelectAllExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actDelete: TAction
      Category = 'Edit'
      Caption = 'Delete'
      OnExecute = actDeleteExecute
    end
    object actFind: TAction
      Tag = 1
      Category = 'Search'
      Caption = '&Find'
      ImageIndex = 21
      ShortCut = 16454
      OnExecute = actFindExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actFindAll: TAction
      Tag = 2
      Category = 'Search'
      Caption = 'Fin&d in all Files'
      ShortCut = 41030
      OnExecute = actFindAllExecute
      OnUpdate = actUpdatePageorProject
    end
    object actReplace: TAction
      Tag = 3
      Category = 'Search'
      Caption = '&Replace'
      ImageIndex = 22
      ShortCut = 16466
      OnExecute = actReplaceExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actFindNext: TAction
      Tag = 4
      Category = 'Search'
      Caption = '&Search Again'
      ImageIndex = 23
      ShortCut = 114
      OnExecute = actFindNextExecute
      OnUpdate = actFindNextUpdate
    end
    object actIncremental: TAction
      Category = 'Search'
      Caption = 'Incremental Search'
      ShortCut = 16457
      OnExecute = actIncrementalExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actGoto: TAction
      Tag = 5
      Category = 'Search'
      Caption = '&Go to line...'
      ImageIndex = 24
      ShortCut = 16455
      OnExecute = actGotoExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actStatusbar: TAction
      Category = 'View'
      AutoCheck = True
      Caption = '&Statusbar'
      OnExecute = actStatusbarExecute
    end
    object actProjectNew: TAction
      Tag = 1
      Category = 'Project'
      Caption = '&New Unit'
      ImageIndex = 1
      OnExecute = actProjectNewExecute
      OnUpdate = actUpdateProject
    end
    object actProjectAdd: TAction
      Tag = 2
      Category = 'Project'
      Caption = '&Add file...'
      ImageIndex = 25
      OnExecute = actProjectAddExecute
      OnUpdate = actUpdateProject
    end
    object actProjectRemove: TAction
      Tag = 3
      Category = 'Project'
      Caption = '&Remove file...'
      ImageIndex = 26
      OnExecute = actProjectRemoveExecute
      OnUpdate = actUpdateProject
    end
    object actProjectOptions: TAction
      Tag = 5
      Category = 'Project'
      Caption = '&Options...'
      ImageIndex = 27
      ShortCut = 32848
      OnExecute = actProjectOptionsExecute
      OnUpdate = actUpdateProject
    end
    object actProjectMakeFile: TAction
      Category = 'Project'
      Caption = 'Edit &Makefile'
      OnExecute = actProjectMakeFileExecute
      OnUpdate = actUpdateProject
    end
    object actProjectSource: TAction
      Tag = 6
      Category = 'Project'
      Caption = 'Source'
      OnExecute = actProjectSourceExecute
      OnUpdate = actUpdateProject
    end
    object actCompile: TAction
      Tag = 1
      Category = 'Execute'
      Caption = '&Compile'
      ImageIndex = 28
      ShortCut = 16504
      OnExecute = actCompileExecute
      OnUpdate = actCompileUpdate
    end
    object actRun: TAction
      Tag = 2
      Category = 'Execute'
      Caption = '&Run'
      ImageIndex = 31
      ShortCut = 16505
      OnExecute = actRunExecute
      OnUpdate = actRunUpdate
    end
    object actCompRun: TAction
      Tag = 3
      Category = 'Execute'
      Caption = 'Compile &and Run'
      ImageIndex = 33
      ShortCut = 120
      OnExecute = actCompRunExecute
      OnUpdate = actRunUpdate
    end
    object actRebuild: TAction
      Tag = 4
      Category = 'Execute'
      Caption = 'R&ebuild All'
      ImageIndex = 30
      ShortCut = 16506
      OnExecute = actRebuildExecute
      OnUpdate = actCompileUpdate
    end
    object actClean: TAction
      Tag = 5
      Category = 'Execute'
      Caption = 'C&lean'
      OnExecute = actCleanExecute
      OnUpdate = actCompileUpdate
    end
    object actDebug: TAction
      Tag = 1
      Category = 'Debug'
      Caption = '&Run'
      ImageIndex = 54
      ShortCut = 119
      OnExecute = actDebugExecute
      OnUpdate = actDebugUpdate
    end
    object actCompOptions: TAction
      Tag = 1
      Category = 'Tools'
      Caption = '&Compiler Options...'
      ImageIndex = 34
      OnExecute = actCompOptionsExecute
    end
    object actEnviroOptions: TAction
      Tag = 2
      Category = 'Tools'
      Caption = '&Environment Options...'
      ImageIndex = 35
      OnExecute = actEnviroOptionsExecute
    end
    object actEditorOptions: TAction
      Tag = 3
      Category = 'Tools'
      Caption = 'E&ditor Options...'
      ImageIndex = 36
      OnExecute = actEditorOptionsExecute
    end
    object actConfigTools: TAction
      Tag = 4
      Category = 'Tools'
      Caption = 'Configure &Tools...'
      ImageIndex = 37
      OnExecute = actConfigToolsExecute
    end
    object actFullScreen: TAction
      Tag = 1
      Category = 'Window'
      AutoCheck = True
      Caption = '&Full screen mode'
      ImageIndex = 38
      ShortCut = 123
      OnExecute = actFullScreenExecute
    end
    object actNext: TAction
      Tag = 2
      Category = 'Window'
      Caption = '&Next'
      ImageIndex = 39
      ShortCut = 117
      OnExecute = actNextExecute
      OnUpdate = actUpdatePageCount
    end
    object actPrev: TAction
      Tag = 3
      Category = 'Window'
      Caption = '&Previous'
      ImageIndex = 40
      ShortCut = 116
      OnExecute = actPrevExecute
      OnUpdate = actUpdatePageCount
    end
    object actUpdateCheck: TAction
      Category = 'Help'
      Caption = '&Check for Updates/Packages'
      ImageIndex = 41
      OnExecute = actUpdateCheckExecute
    end
    object actAbout: TAction
      Category = 'Help'
      Caption = 'About...'
      ImageIndex = 42
      OnExecute = actAboutExecute
    end
    object actHelpCustomize: TAction
      Category = 'Help'
      Caption = 'Customize...'
      OnExecute = actHelpCustomizeExecute
    end
    object actUnitRemove: TAction
      Tag = 1
      Category = 'Project'
      Caption = '&Remove from project'
      OnExecute = actUnitRemoveExecute
      OnUpdate = actUpdateProject
    end
    object actUnitRename: TAction
      Tag = 2
      Category = 'Project'
      Caption = 'Re&name file'
      OnExecute = actUnitRenameExecute
      OnUpdate = actUpdateProject
    end
    object actUnitHeader: TAction
      Tag = 5
      Category = 'Project'
      Caption = 'Open &Header'
      OnUpdate = actUpdateProject
    end
    object actUnitOpen: TAction
      Tag = 4
      Category = 'Project'
      Caption = '&Open'
      OnExecute = actUnitOpenExecute
      OnUpdate = actUpdateProject
    end
    object actUnitClose: TAction
      Tag = 3
      Category = 'Project'
      Caption = '&Close'
      OnExecute = actUnitCloseExecute
      OnUpdate = actUpdateProject
    end
    object actMsgCopy: TAction
      Category = 'MessageControl'
      Caption = '&Copy'
      OnExecute = actMsgCopyExecute
    end
    object actMsgClear: TAction
      Category = 'MessageControl'
      Caption = 'C&lear'
      OnExecute = actMsgClearExecute
    end
    object actShowBars: TAction
      Caption = 'Show Toolbars'
      ShortCut = 8315
      OnExecute = actShowBarsExecute
    end
    object actBreakPoint: TAction
      Category = 'Debug'
      Caption = 'Toggle Breakpoint'
      ShortCut = 16500
      OnExecute = actBreakPointExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actAddWatch: TAction
      Category = 'Debug'
      Caption = '&Add watch'
      ImageIndex = 21
      ShortCut = 115
      OnExecute = actAddWatchExecute
      OnUpdate = actUpdatePageCount
    end
    object actEditWatch: TAction
      Category = 'Debug'
      Caption = '&Edit watch'
      ImageIndex = 36
    end
    object actStepOver: TAction
      Category = 'Debug'
      Caption = 'Step &Over'
      ImageIndex = 18
      ShortCut = 118
      OnExecute = actNextStepExecute
      OnUpdate = actUpdateDebuggerPaused
    end
    object actWatchItem: TAction
      Category = 'Debug'
      Caption = '&Watch variables'
      ShortCut = 16471
      OnExecute = actWatchItemExecute
      OnUpdate = actUpdatePageorProject
    end
    object actRemoveWatch: TAction
      Category = 'Debug'
      Caption = '&Remove Watch'
      ImageIndex = 5
      OnExecute = actRemoveWatchExecute
    end
    object actStopExecute: TAction
      Category = 'Debug'
      Caption = 'Stop Execution'
      ImageIndex = 55
      ShortCut = 32881
      OnExecute = actStopExecuteExecute
      OnUpdate = actUpdateDebuggerRunning
    end
    object actFileMenu: TAction
      Caption = '&File'
      OnExecute = actFileMenuExecute
    end
    object actEditMenu: TAction
      Caption = '&Edit'
      OnExecute = actFileMenuExecute
    end
    object actSearchMenu: TAction
      Caption = '&Search'
      OnExecute = actFileMenuExecute
    end
    object actViewMenu: TAction
      Caption = '&View'
      OnExecute = actFileMenuExecute
    end
    object actProjectMenu: TAction
      Caption = '&Project'
      OnExecute = actFileMenuExecute
    end
    object actExecuteMenu: TAction
      Caption = 'E&xecute'
      OnExecute = actFileMenuExecute
    end
    object actDebugMenu: TAction
      Caption = '&Debug'
      OnExecute = actFileMenuExecute
    end
    object actToolsMenu: TAction
      Caption = '&Tools'
      OnExecute = actToolsMenuExecute
    end
    object actWindowMenu: TAction
      Caption = '&Window'
      OnExecute = actWindowMenuExecute
    end
    object actHelpMenu: TAction
      Caption = '&Help'
      OnExecute = actFileMenuExecute
    end
    object actSwapHeaderSource: TAction
      Category = 'Edit'
      Caption = '&Swap header/source'
      OnExecute = actSwapHeaderSourceExecute
      OnUpdate = actSwapHeaderSourceUpdate
    end
    object actSyntaxCheck: TAction
      Category = 'Execute'
      Caption = '&Syntax Check'
      OnExecute = actSyntaxCheckExecute
      OnUpdate = actCompileUpdate
    end
    object actConfigShortcuts: TAction
      Category = 'Tools'
      Caption = 'Configure &shortcuts'
      ImageIndex = 31
      OnExecute = actConfigShortcutsExecute
    end
    object actProgramReset: TAction
      Category = 'Execute'
      Caption = 'Program reset'
      ImageIndex = 48
      ShortCut = 32881
      OnExecute = actProgramResetExecute
      OnUpdate = actProgramResetUpdate
    end
    object actComment: TAction
      Category = 'Edit'
      Caption = 'Comment'
      ShortCut = 49342
      OnExecute = actCommentExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actUncomment: TAction
      Category = 'Edit'
      Caption = 'Uncomment'
      ShortCut = 49340
      OnExecute = actUncommentExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actIndent: TAction
      Category = 'Edit'
      Caption = 'Indent'
      ShortCut = 24649
      OnExecute = actIndentExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actUnindent: TAction
      Category = 'Edit'
      Caption = 'Unindent'
      ShortCut = 24661
      OnExecute = actUnindentExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actGotoFunction: TAction
      Category = 'Search'
      Caption = 'Goto function'
      ImageIndex = 44
      ShortCut = 24647
      OnExecute = actGotoFunctionExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actBrowserGotoDecl: TAction
      Category = 'ClassBrowser'
      Caption = 'Goto declaration'
      OnExecute = actBrowserGotoDeclExecute
      OnUpdate = actBrowserGotoDeclUpdate
    end
    object actBrowserGotoImpl: TAction
      Category = 'ClassBrowser'
      Caption = 'Goto implementation'
      OnExecute = actBrowserGotoImplExecute
      OnUpdate = actBrowserGotoImplUpdate
    end
    object actBrowserNewClass: TAction
      Category = 'ClassBrowser'
      Caption = 'New class'
      OnExecute = actBrowserNewClassExecute
      OnUpdate = actBrowserNewClassUpdate
    end
    object actBrowserNewMember: TAction
      Category = 'ClassBrowser'
      Caption = 'New member function'
      OnExecute = actBrowserNewMemberExecute
      OnUpdate = actBrowserNewMemberUpdate
    end
    object actBrowserNewVar: TAction
      Category = 'ClassBrowser'
      Caption = 'New variable'
      OnExecute = actBrowserNewVarExecute
      OnUpdate = actBrowserNewVarUpdate
    end
    object actBrowserViewAll: TAction
      Category = 'ClassBrowser'
      Caption = 'All files'
      Checked = True
      OnExecute = actBrowserViewAllExecute
      OnUpdate = actBrowserViewAllUpdate
    end
    object actBrowserViewProject: TAction
      Category = 'ClassBrowser'
      Caption = 'Project files'
      OnExecute = actBrowserViewProjectExecute
      OnUpdate = actBrowserViewAllUpdate
    end
    object actBrowserViewCurrent: TAction
      Category = 'ClassBrowser'
      Caption = 'Current file'
      OnExecute = actBrowserViewCurrentExecute
      OnUpdate = actBrowserViewAllUpdate
    end
    object actProfileProject: TAction
      Category = 'Execute'
      Caption = 'Profile analysis'
      OnExecute = actProfileProjectExecute
      OnUpdate = actRunUpdate
    end
    object actBrowserAddFolder: TAction
      Category = 'ClassBrowser'
      Caption = 'Add folder'
      OnExecute = actBrowserAddFolderExecute
      OnUpdate = actBrowserAddFolderUpdate
    end
    object actBrowserRemoveFolder: TAction
      Category = 'ClassBrowser'
      Caption = 'Remove folder'
      OnExecute = actBrowserRemoveFolderExecute
      OnUpdate = actBrowserAddFolderUpdate
    end
    object actBrowserRenameFolder: TAction
      Category = 'ClassBrowser'
      Caption = 'Rename folder'
      OnExecute = actBrowserRenameFolderExecute
      OnUpdate = actBrowserAddFolderUpdate
    end
    object actCloseAllButThis: TAction
      Category = 'File'
      Caption = 'Close all except this'
      OnExecute = actCloseAllButThisExecute
      OnUpdate = actUpdatePageCount
    end
    object actStepInto: TAction
      Category = 'Debug'
      Caption = '&Step Into'
      ImageIndex = 57
      OnExecute = actStepSingleExecute
      OnUpdate = actUpdateDebuggerPaused
    end
    object actFileProperties: TAction
      Category = 'File'
      Caption = 'Properties'
      OnExecute = actFilePropertiesExecute
      OnUpdate = actUpdatePageCount
    end
    object actViewToDoList: TAction
      Category = 'View'
      Caption = 'To-Do list...'
      OnExecute = actViewToDoListExecute
      OnUpdate = actViewToDoListUpdate
    end
    object actAddToDo: TAction
      Category = 'Edit'
      Caption = 'Add To-Do item...'
      ShortCut = 24660
      OnExecute = actAddToDoExecute
      OnUpdate = actUpdatePageorProject
    end
    object actProjectNewFolder: TAction
      Category = 'Project'
      Caption = 'Add folder'
      OnExecute = actProjectNewFolderExecute
      OnUpdate = actUpdateProject
    end
    object actProjectRemoveFolder: TAction
      Category = 'Project'
      Caption = 'Remove folder'
      OnExecute = actProjectRemoveFolderExecute
      OnUpdate = actUpdateProject
    end
    object actProjectRenameFolder: TAction
      Category = 'Project'
      Caption = 'Rename folder'
      OnExecute = actProjectRenameFolderExecute
      OnUpdate = actUpdateProject
    end
    object actImportMSVC: TAction
      Category = 'File'
      Caption = 'Import MS Visual C++ project'
      OnExecute = actImportMSVCExecute
    end
    object actExecParams: TAction
      Category = 'Execute'
      Caption = 'Parameters...'
      OnExecute = actExecParamsExecute
      OnUpdate = actDebugUpdate
    end
    object actShowTips: TAction
      Category = 'Help'
      Caption = 'Tips'
      OnExecute = actShowTipsExecute
    end
    object actBrowserUseColors: TAction
      Category = 'ClassBrowser'
      Caption = 'Use colors'
      Checked = True
      OnExecute = actBrowserUseColorsExecute
    end
    object actAbortCompilation: TAction
      Category = 'Execute'
      Caption = 'Abort compilation'
      OnExecute = actAbortCompilationExecute
      OnUpdate = actAbortCompilationUpdate
    end
    object actCVSImport: TAction
      Category = 'CVS'
      Caption = 'Import'
      OnExecute = actCVSImportExecute
    end
    object actCVSCheckout: TAction
      Category = 'CVS'
      Caption = 'Checkout'
      OnExecute = actCVSCheckoutExecute
    end
    object actCVSUpdate: TAction
      Category = 'CVS'
      Caption = 'Update'
      OnExecute = actCVSUpdateExecute
      OnUpdate = actUpdatePageorProject
    end
    object actCVSCommit: TAction
      Category = 'CVS'
      Caption = 'Commit'
      OnExecute = actCVSCommitExecute
      OnUpdate = actUpdatePageorProject
    end
    object actCVSDiff: TAction
      Category = 'CVS'
      Caption = 'Diff'
      OnExecute = actCVSDiffExecute
      OnUpdate = actUpdatePageorProject
    end
    object actCVSLog: TAction
      Category = 'CVS'
      Caption = 'Log'
      OnExecute = actCVSLogExecute
      OnUpdate = actUpdatePageorProject
    end
    object actCVSAdd: TAction
      Category = 'CVS'
      Caption = 'Add'
      OnExecute = actCVSAddExecute
      OnUpdate = actUpdatePageorProject
    end
    object actCVSRemove: TAction
      Category = 'CVS'
      Caption = 'Remove'
      OnExecute = actCVSRemoveExecute
      OnUpdate = actUpdatePageorProject
    end
    object actBrowserShowInherited: TAction
      Category = 'ClassBrowser'
      Caption = 'Show inherited members'
      OnExecute = actBrowserShowInheritedExecute
    end
    object actCVSLogin: TAction
      Category = 'CVS'
      Caption = 'Login'
      OnExecute = actCVSLoginExecute
    end
    object actCVSLogout: TAction
      Category = 'CVS'
      Caption = 'Logout'
      OnExecute = actCVSLogoutExecute
    end
    object actCompileCurrentFile: TAction
      Category = 'Execute'
      Caption = 'Compile current file'
      ImageIndex = 28
      ShortCut = 24696
      OnExecute = actCompileCurrentFileExecute
      OnUpdate = actCompileCurrentFileUpdate
    end
    object actAttachProcess: TAction
      Category = 'Debug'
      Caption = 'Attach to process...'
      OnExecute = actAttachProcessExecute
      OnUpdate = actAttachProcessUpdate
    end
    object actModifyWatch: TAction
      Category = 'Debug'
      Caption = '&Modify value'
      ImageIndex = 37
      OnExecute = actModifyWatchExecute
      OnUpdate = actModifyWatchUpdate
    end
    object actNewwxDialog: TAction
      Category = 'File'
      Caption = 'New wxDialog'
      ImageIndex = 1
      OnExecute = actNewwxDialogExecute
    end
    object actDesignerCopy: TAction
      Category = 'Designer'
      Caption = 'Copy'
      ShortCut = 49219
      OnExecute = actDesignerCopyExecute
    end
    object actDesignerCut: TAction
      Category = 'Designer'
      Caption = 'Cut'
      ShortCut = 49240
      OnExecute = actDesignerCutExecute
    end
    object actDesignerPaste: TAction
      Category = 'Designer'
      Caption = 'Paste'
      ShortCut = 49238
      OnExecute = actDesignerPasteExecute
    end
    object actDesignerDelete: TAction
      Category = 'Designer'
      Caption = 'Delete'
      ShortCut = 16430
      OnExecute = actDesignerDeleteExecute
    end
    object actNewWxFrame: TAction
      Category = 'File'
      Caption = 'New wxFrame'
      ImageIndex = 1
      OnExecute = actNewWxFrameExecute
    end
    object actWxPropertyInspectorCut: TAction
      Category = 'Designer'
      Caption = 'Cut'
      ShortCut = 16472
      OnExecute = actWxPropertyInspectorCutExecute
    end
    object actWxPropertyInspectorCopy: TAction
      Category = 'Designer'
      Caption = 'Copy'
      ShortCut = 16451
      OnExecute = actWxPropertyInspectorCopyExecute
    end
    object actWxPropertyInspectorPaste: TAction
      Category = 'Designer'
      Caption = 'Paste'
      ShortCut = 16470
      OnExecute = actWxPropertyInspectorPasteExecute
    end
    object actRestartDebug: TAction
      Category = 'Debug'
      Caption = '&Restart'
      ImageIndex = 56
      ShortCut = 8311
      OnExecute = actRestartDebugExecute
      OnUpdate = actUpdateDebuggerRunning
    end
    object actPauseDebug: TAction
      Category = 'Debug'
      Caption = 'Pause Execution'
      ImageIndex = 58
      OnExecute = actPauseDebugExecute
      OnUpdate = actPauseDebugUpdate
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnActivate = ApplicationEvents1Activate
    OnDeactivate = ApplicationEvents1Deactivate
    OnIdle = ApplicationEvents1Idle
    Left = 520
    Top = 130
  end
  object MessagePopup: TPopupMenu
    Images = dmMain.MenuImages_Gnome
    Left = 436
    Top = 130
    object MsgCopyItem: TMenuItem
      Action = actMsgCopy
      ImageIndex = 16
    end
    object MsgClearitem: TMenuItem
      Action = actMsgClear
    end
  end
  object CppTokenizer1: TCppTokenizer
    LogTokens = False
    Left = 573
    Top = 130
  end
  object CppParser1: TCppParser
    Enabled = True
    OnTotalProgress = CppParser1TotalProgress
    Tokenizer = CppTokenizer1
    ParseLocalHeaders = False
    ParseGlobalHeaders = False
    LogStatements = False
    OnStartParsing = CppParser1StartParsing
    OnEndParsing = CppParser1EndParsing
    Left = 436
    Top = 158
  end
  object CodeCompletion1: TCodeCompletion
    Parser = CppParser1
    Color = clWhite
    Width = 320
    Height = 240
    Enabled = True
    HintTimeout = 4000
    MinWidth = 256
    MinHeight = 128
    MaxWidth = 640
    MaxHeight = 480
    OnResize = CodeCompletion1Resize
    OnlyGlobals = False
    CurrentClass = 0
    Left = 546
    Top = 130
  end
  object devShortcuts1: TdevShortcuts
    Filename = 'devshortcuts.cfg'
    AlternateColor = 14737632
    MultiLangStrings.Caption = 'Configure Shortcuts'
    MultiLangStrings.Title = ' Click on an item and press the shortcut you desire!'
    MultiLangStrings.Tip = 'Tip: press "Escape" to clear a shortcut...'
    MultiLangStrings.HeaderEntry = 'Menu entry'
    MultiLangStrings.HeaderShortcut = 'Shortcut assigned'
    MultiLangStrings.OK = 'OK'
    MultiLangStrings.Cancel = 'Cancel'
    Left = 491
    Top = 158
  end
  object BrowserPopup: TPopupMenu
    Left = 464
    Top = 102
    object mnuBrowserGotoDecl: TMenuItem
      Action = actBrowserGotoDecl
    end
    object mnuBrowserGotoImpl: TMenuItem
      Action = actBrowserGotoImpl
      Default = True
    end
    object mnuBrowserSep1: TMenuItem
      Caption = '-'
    end
    object mnuBrowserNewClass: TMenuItem
      Action = actBrowserNewClass
    end
    object mnuBrowserSep2: TMenuItem
      Caption = '-'
    end
    object mnuBrowserNewMember: TMenuItem
      Action = actBrowserNewMember
    end
    object mnuBrowserNewVariable: TMenuItem
      Action = actBrowserNewVar
    end
    object N31: TMenuItem
      Caption = '-'
    end
    object mnuBrowserAddFolder: TMenuItem
      Action = actBrowserAddFolder
    end
    object mnuBrowserRemoveFolder: TMenuItem
      Action = actBrowserRemoveFolder
    end
    object mnuBrowserRenameFolder: TMenuItem
      Action = actBrowserRenameFolder
    end
    object mnuBrowserSep3: TMenuItem
      Caption = '-'
    end
    object mnuBrowserViewMode: TMenuItem
      Caption = 'View mode'
      object mnuBrowserViewAll: TMenuItem
        Action = actBrowserViewAll
        RadioItem = True
      end
      object mnuBrowserViewProject: TMenuItem
        Action = actBrowserViewProject
      end
      object mnuBrowserViweCurrent: TMenuItem
        Action = actBrowserViewCurrent
        RadioItem = True
      end
      object N42: TMenuItem
        Caption = '-'
      end
      object Usecolors1: TMenuItem
        Action = actBrowserUseColors
      end
      object Showinheritedmembers1: TMenuItem
        Action = actBrowserShowInherited
      end
    end
  end
  object DebugVarsPopup: TPopupMenu
    Images = dmMain.MenuImages_Gnome
    OnPopup = DebugVarsPopupPopup
    Left = 492
    Top = 102
    object AddwatchPop: TMenuItem
      Action = actAddWatch
    end
    object ModifyWatchPop: TMenuItem
      Action = actModifyWatch
    end
    object N67: TMenuItem
      Caption = '-'
    end
    object RemoveWatchPop: TMenuItem
      Action = actRemoveWatch
    end
    object ClearallWatchPop: TMenuItem
      Caption = '&Clear all'
      OnClick = ClearallWatchPopClick
    end
  end
  object DevCppDDEServer: TDdeServerConv
    OnExecuteMacro = DevCppDDEServerExecuteMacro
    Left = 519
    Top = 158
  end
  object XPMenu: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    Color = clBtnFace
    DrawMenuBar = False
    IconBackColor = clBtnFace
    MenuBarColor = clBtnFace
    SelectColor = clHighlight
    SelectBorderColor = clHighlight
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clHighlight
    IconWidth = 24
    DrawSelect = True
    UseSystemColors = True
    UseDimColor = False
    OverrideOwnerDraw = False
    Gradient = True
    FlatMenu = False
    AutoDetect = True
    XPControls = [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcListBox, xcEdit, xcMaskEdit, xcMemo, xcRichEdit, xcMiscEdit, xcCheckBox, xcRadioButton, xcButton, xcBitBtn, xcSpeedButton, xcUpDown, xcPanel, xcTreeView, xcListView, xcProgressBar, xcHotKey]
    Active = False
    Left = 464
    Top = 158
  end
  object DockServer: TJvDockServer
    LeftSplitterStyle.Cursor = crHSplit
    LeftSplitterStyle.ParentColor = False
    RightSplitterStyle.Cursor = crHSplit
    RightSplitterStyle.ParentColor = False
    TopSplitterStyle.Cursor = crVSplit
    TopSplitterStyle.ParentColor = False
    BottomSplitterStyle.Cursor = crVSplit
    BottomSplitterStyle.ParentColor = False
    CustomDock = False
    Left = 547
    Top = 158
  end
  object pLoader: TSciPropertyLoader
    Editor = HiddenSci
    StoreWhat = [stDefaults, stColors, stStyles, stOther, stLexerProperties, stExtensions]
    Left = 464
    Top = 184
  end
  object SciPrinter: TSciPrinter
    Title = 'DelphiSci'
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clBlack
    HeaderFont.Height = -11
    HeaderFont.Name = 'Arial'
    HeaderFont.Style = []
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clBlack
    FooterFont.Height = -11
    FooterFont.Name = 'Arial'
    FooterFont.Style = []
    ColorMode = sccmNormal
    WordWrap = sciNoWrap
    Magnification = 0
    Left = 552
    Top = 184
  end
  object SciAutoComplete1: TSciAutoComplete
    IgnoreCase = False
    ChooseSingle = False
    AutoHide = True
    DropRestOfWord = False
    CancelAtStart = True
    FromDocument = False
    WordCharacters = '_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    MaxWidth = 0
    MaxHeight = 0
    Left = 520
    Top = 184
  end
  object FCodeToolTip: TSciCallTips
    EndDefinition = ')'
    Editor = HiddenSci
    ParametersEnd = ')'
    ParametersSeparators = ','
    ParametersStart = '('
    WordCharacters = '_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    TabSize = 0
    UseStyle = False
    OnBeforeShow = FCodeToolTipBeforeShow
    Left = 488
    Top = 216
  end
end
