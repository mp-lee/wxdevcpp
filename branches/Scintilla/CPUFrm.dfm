object CPUForm: TCPUForm
  Left = 255
  Top = 183
  Width = 585
  Height = 487
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'CPU Window'
  Color = clBtnFace
  Constraints.MinHeight = 487
  Constraints.MinWidth = 585
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    577
    453)
  PixelsPerInch = 96
  TextHeight = 13
  object gbAsm: TGroupBox
    Left = 8
    Top = 8
    Width = 405
    Height = 435
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Assembler Code :'
    TabOrder = 0
    DesignSize = (
      405
      435)
    object lblFunc: TLabel
      Left = 8
      Top = 19
      Width = 47
      Height = 13
      Caption = 'Function: '
    end
    object edFunc: TEdit
      Left = 88
      Top = 16
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnKeyPress = edFuncKeyPress
    end
    object CodeList: TScintilla
      Left = 8
      Top = 44
      Width = 388
      Height = 383
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Anchors = [akLeft, akTop, akRight, akBottom]
      EOLStyle = eolCRLF
      Indentation = [TabIndents]
      IndentWidth = 0
      MarginLeft = 1
      MarginRight = 1
      CodePage = cpAnsi
      Caret.ForeColor = clBlack
      Caret.LineBackColor = clYellow
      Caret.LineVisible = False
      Caret.Width = 1
      Caret.Period = 500
      Caret.LineBackAlpha = 256
      DivOptions.ViewWSpace = sciWsInvisible
      DivOptions.UsePalette = False
      DivOptions.OverType = False
      DivOptions.ViewEOL = False
      DivOptions.EndAtLastLine = True
      DivOptions.ScrollBarH = True
      DivOptions.ScrollBarV = True
      ActiveHotSpot.BackColor = clDefault
      ActiveHotSpot.ForeColor = clBlue
      ActiveHotSpot.Underlined = True
      ActiveHotSpot.SingleLine = False
      Colors.SelFore = clHighlightText
      Colors.SelBack = clHighlight
      Colors.MarkerFore = clBlue
      Colors.MarkerBack = clAqua
      Colors.FoldHi = clBtnFace
      Colors.FoldLo = clBtnFace
      Colors.WhiteSpaceFore = clDefault
      Colors.WhiteSpaceBack = clDefault
      Bookmark.BackColor = clDefault
      Bookmark.ForeColor = clDefault
      Bookmark.MarkerType = sciMCircle
      Gutter0.Width = 0
      Gutter0.MarginType = gutLineNumber
      Gutter0.Sensitive = False
      Gutter1.Width = 16
      Gutter1.MarginType = gutSymbol
      Gutter1.Sensitive = False
      Gutter2.Width = 0
      Gutter2.MarginType = gutSymbol
      Gutter2.Sensitive = False
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
      EdgeColor = clSilver
      WordChars = '_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
      ControlCharSymbol = #0
      Folding = [foldCompact, foldComment, foldPreprocessor, foldAtElse, foldHTML, foldHTMLPreProcessor]
      FoldMarkers.MarkerType = sciMarkBox
      FoldMarkers.FoldOpen.BackColor = clDefault
      FoldMarkers.FoldOpen.ForeColor = clDefault
      FoldMarkers.FoldOpen.MarkerType = sciMBoxMinus
      FoldMarkers.FoldClosed.BackColor = clDefault
      FoldMarkers.FoldClosed.ForeColor = clDefault
      FoldMarkers.FoldClosed.MarkerType = sciMBoxPlus
      FoldMarkers.FoldSub.BackColor = clDefault
      FoldMarkers.FoldSub.ForeColor = clDefault
      FoldMarkers.FoldSub.MarkerType = sciMVLine
      FoldMarkers.FoldTail.BackColor = clDefault
      FoldMarkers.FoldTail.ForeColor = clDefault
      FoldMarkers.FoldTail.MarkerType = sciMLCorner
      FoldMarkers.FoldEnd.BackColor = clDefault
      FoldMarkers.FoldEnd.ForeColor = clDefault
      FoldMarkers.FoldEnd.MarkerType = sciMBoxPlusConnected
      FoldMarkers.FoldOpenMid.BackColor = clDefault
      FoldMarkers.FoldOpenMid.ForeColor = clDefault
      FoldMarkers.FoldOpenMid.MarkerType = sciMBoxMinusConnected
      FoldMarkers.FoldMidTail.BackColor = clDefault
      FoldMarkers.FoldMidTail.ForeColor = clDefault
      FoldMarkers.FoldMidTail.MarkerType = sciMTCorner
      LanguageManager.LanguageList = <
        item
          Name = 'null'
          Lexer = 'null'
          Styles = <>
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
        end>
      LanguageManager.SelectedLanguage = 'null'
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
  end
  object gbRegisters: TGroupBox
    Left = 418
    Top = 72
    Width = 150
    Height = 345
    Anchors = [akTop, akRight, akBottom]
    Caption = 'Registers :'
    TabOrder = 1
    DesignSize = (
      150
      345)
    object Registers: TListView
      Left = 9
      Top = 21
      Width = 133
      Height = 313
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = 'Register'
          Width = 55
        end
        item
          Caption = 'Value'
          Width = 74
        end>
      ColumnClick = False
      Items.Data = {
        850100001000000000000000FFFFFFFFFFFFFFFF000000000000000003454158
        00000000FFFFFFFFFFFFFFFF00000000000000000345425800000000FFFFFFFF
        FFFFFFFF00000000000000000345435800000000FFFFFFFFFFFFFFFF00000000
        000000000345445800000000FFFFFFFFFFFFFFFF000000000000000003455349
        00000000FFFFFFFFFFFFFFFF00000000000000000345444900000000FFFFFFFF
        FFFFFFFF00000000000000000345425000000000FFFFFFFFFFFFFFFF00000000
        000000000345535000000000FFFFFFFFFFFFFFFF000000000000000003454950
        00000000FFFFFFFFFFFFFFFF000000000000000002435300000000FFFFFFFFFF
        FFFFFF000000000000000002445300000000FFFFFFFFFFFFFFFF000000000000
        000002535300000000FFFFFFFFFFFFFFFF000000000000000002455300000000
        FFFFFFFFFFFFFFFF000000000000000002465300000000FFFFFFFFFFFFFFFF00
        0000000000000002475300000000FFFFFFFFFFFFFFFF00000000000000000645
        464C414753}
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object rgSyntax: TRadioGroup
    Left = 419
    Top = 8
    Width = 150
    Height = 57
    Anchors = [akTop, akRight]
    Caption = 'Assembly Syntax'
    ItemIndex = 0
    Items.Strings = (
      'Intel'
      'AT&&T')
    TabOrder = 2
    OnClick = rgSyntaxClick
  end
  object CloseBtn: TButton
    Left = 418
    Top = 421
    Width = 150
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = '&Close'
    TabOrder = 3
    OnClick = CloseBtnClick
  end
  object XPMenu: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = ANSI_CHARSET
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
    Gradient = False
    FlatMenu = False
    AutoDetect = True
    XPControls = [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcListBox, xcEdit, xcMaskEdit, xcMemo, xcRichEdit, xcMiscEdit, xcCheckBox, xcRadioButton, xcButton, xcBitBtn, xcSpeedButton, xcUpDown, xcPanel, xcTreeView, xcListView, xcProgressBar, xcHotKey]
    Active = False
    Left = 37
    Top = 420
  end
end
