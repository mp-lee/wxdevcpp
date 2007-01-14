object EditorOptForm: TEditorOptForm
  Left = 390
  Top = 192
  HelpType = htKeyword
  BorderStyle = bsDialog
  Caption = 'Editor Options'
  ClientHeight = 416
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnHelp = FormHelp
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    429
    416)
  PixelsPerInch = 96
  TextHeight = 13
  object PagesMain: TPageControl
    Left = 7
    Top = 8
    Width = 415
    Height = 373
    ActivePage = tabSyntax
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabIndex = 1
    TabOrder = 0
    OnChange = PagesMainChange
    object tabGeneral: TTabSheet
      Caption = 'General'
      object lblEditorOpts: TGroupBox
        Left = 4
        Top = 4
        Width = 399
        Height = 210
        Caption = 'Editor Options'
        TabOrder = 0
        object cbAppendNewline: TCheckBox
          Left = 8
          Top = 168
          Width = 380
          Height = 17
          Caption = 'Ensure that file ends with newline'
          TabOrder = 0
        end
        object cbSpecialChars: TCheckBox
          Left = 8
          Top = 151
          Width = 190
          Height = 17
          Caption = 'Show Special Line Chars'
          TabOrder = 1
        end
        object cbDropFiles: TCheckBox
          Left = 8
          Top = 134
          Width = 190
          Height = 17
          Caption = 'Insert Dropped Files'
          TabOrder = 2
        end
        object cbGroupUndo: TCheckBox
          Left = 8
          Top = 117
          Width = 190
          Height = 17
          Hint = 'handle all changes of same type as single action'
          Caption = 'Group Undo'
          TabOrder = 3
        end
        object cbTrailingBlanks: TCheckBox
          Left = 8
          Top = 83
          Width = 190
          Height = 17
          Hint = 'Blanks at end of lines will be saved with file'
          Caption = 'Keep Trailing Blanks'
          TabOrder = 4
        end
        object cbTabtoSpaces: TCheckBox
          Left = 8
          Top = 49
          Width = 190
          Height = 17
          Caption = 'Use Tab Character'
          TabOrder = 5
        end
        object cbSmartTabs: TCheckBox
          Left = 8
          Top = 66
          Width = 190
          Height = 17
          Hint = 
            'on tab cursor is moved to first nonblank space of preceeding lin' +
            'e'
          Caption = 'Smart Tabs'
          TabOrder = 6
        end
        object cbInsertMode: TCheckBox
          Left = 8
          Top = 32
          Width = 190
          Height = 17
          Hint = 'editor is in insert mode on start'
          Caption = 'Insert Mode'
          TabOrder = 7
        end
        object cbPastEOL: TCheckBox
          Left = 199
          Top = 50
          Width = 190
          Height = 17
          Hint = 'allows cursor position past end of line'
          Caption = 'Cursor Past EOL'
          TabOrder = 8
        end
        object cbFindText: TCheckBox
          Left = 199
          Top = 84
          Width = 190
          Height = 17
          Hint = 'inserts text at cursor into text to find of search dialog'
          Caption = 'Find Text at Cursor'
          TabOrder = 9
        end
        object cbHalfPage: TCheckBox
          Left = 199
          Top = 117
          Width = 190
          Height = 17
          Hint = 'page up/down will move text by half a page instead of full page'
          Caption = 'Half Page Scrolling'
          TabOrder = 10
        end
        object cbScrollHint: TCheckBox
          Left = 199
          Top = 134
          Width = 190
          Height = 17
          Hint = 'shows current line when scrolling'
          Caption = 'Scroll Hint'
          TabOrder = 11
        end
        object cbParserHints: TCheckBox
          Left = 199
          Top = 151
          Width = 190
          Height = 17
          Caption = 'Show editor hints'
          TabOrder = 12
        end
        object cbSmartScroll: TCheckBox
          Left = 199
          Top = 100
          Width = 190
          Height = 17
          Hint = 'show scrollbars only when content is available'
          Caption = 'Scollbars on need'
          TabOrder = 13
        end
        object cbDoubleLine: TCheckBox
          Left = 199
          Top = 67
          Width = 190
          Height = 17
          Hint = 'double clicking a line selects it'
          Caption = 'Double Click Line'
          TabOrder = 14
        end
        object cbEHomeKey: TCheckBox
          Left = 199
          Top = 17
          Width = 190
          Height = 17
          Hint = 'enhances home key positioning, similar to visual studio'
          Caption = 'Enhanced home key'
          TabOrder = 15
        end
        object cbPastEOF: TCheckBox
          Left = 199
          Top = 33
          Width = 190
          Height = 17
          Hint = 'allow cursor position past end of file'
          Caption = 'Cursor Past EOF'
          TabOrder = 16
        end
      end
    end
    object tabSyntax: TTabSheet
      Caption = 'Syntax'
      object lblSpeed: TLabel
        Left = 281
        Top = 8
        Width = 97
        Height = 13
        Caption = 'Color Speed Setting:'
      end
      object btnSaveSyntax: TSpeedButton
        Left = 280
        Top = 23
        Width = 21
        Height = 21
        Hint = 'Save custom syntax settings'
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000CE0E0000D80E0000000000000000000000FF0000FF00
          00FF0000FF0000FF0000000000000000000000000000FF0000FF0000FF0000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000666148A89F77DD
          DDDD9B9A8F00000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF00
          00FF0000FF00000000A89F77A89F77E9E9E9B2B0A7D5D4D29392894848480000
          0000FF0000FF0000FF0000FF0000FF0000FF00000000B9B294A89F77756E534A
          473AACA47EDADAD5E0E0E0B4B4B476736500000000FF0000FF0000FF0000FF00
          00FF00000000A89F77A89F77756E53F3F3F3F1F1F1E7E7E7E1E1E1B4B2A96661
          48635E464A463400000000FF0000FF00000000B2AA87F0EFE8EBE9E0A89F7763
          5E46ADABA4EAEAEAE4E4E4646360A89F77A89F7700000000000000FF0000FF00
          000000EBE9E0FFFFFFFFFFFFF5F4F0A89F77A89F77635E465A574B787255A89F
          77A89F7700000000FF0000FF00000000B2AA87F2F1EBFFFFFFFFFFFFFFFFFFF5
          F4F0EBE9E0A89F77A89F77756E53756E5300000000000000FF0000FF00000000
          EBE9E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F6F2EBE9E0A89F77A89F
          7700000000FF0000FF000000008D8A78F2F1EBFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFF0EFE800000000000000FF0000FF00000000B9B294
          DFDCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEECE40000
          0000FF0000FF0000FF0000FF00000000000000C9C4AED5D1BFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFF9F8F500000000000000FF0000FF0000FF0000FF0000FF00
          00FF00000000000000C9C4AED5D1BFD5D1BFFFFFFFF4F3EEA89F7700000000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000000000D5
          D1BFC5C1A8EDECE400000000000000FF0000FF0000FF0000FF0000FF0000FF00
          00FF0000FF0000FF0000FF0000FF00000000000000A89F7700000000FF0000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
          FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF00}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnSaveSyntaxClick
      end
      object btnScintillaOptions: TSpeedButton
        Left = 8
        Top = 24
        Width = 23
        Height = 22
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000BFBFBFBFBFBF
          BFBFBFBEBEBEBBBBBBB9B9B9BABABABBBBBBBCBCBCBCBCBCBCBCBCBDBDBDBEBE
          BEBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBCBCBCACACAC9090908A8A8A9292929E
          9E9EA9A9A9AEAEAEB3B3B3B6B6B6B9B9B9BCBCBCBEBEBEBFBFBFBFBFBFBDBDBD
          B2B2B29999998383835555555454546464647D7D7D8E8E8E999999A4A4A4ACAC
          ACB2B2B2B8B8B8BCBCBCBFBFBFBABABAA5A5A5C4C4C4FBFBFBE6E6E6A3A3A362
          62625151515D5D5D7171718484849191919E9E9EAEAEAEB8B8B8BFBFBFB7B7B7
          9A9A9AEAEAEAFEFEFEFAFBFBF5F5F5E8E8E8B6B6B66F6F6F4A4A4A5959596A6A
          6A858585A4A4A4B8B8B8BEBEBEB3B3B3A3A3A3F8F8F8F7F7F7F2F2F2EEEEEEE4
          E4E7E3E4E4DEDEDEBDBEBE6F6F6F4E4E4E7474749F9F9FBABABABEBEBEB0B0B0
          B9B9B9F2F2F2EBEBEBD5D5DFD4D4DDCFCFDADDDDDED8D8D8D2D3D3CACACAA1A1
          A1848484A7A7A7BCBCBCBDBDBDADADADCACACAE2E2E2D0D1D9CACAD5D6D6D9C9
          CAD3C4C4CEC9CACECBCCCCC4C5C59797979D9D9DB6B6B6BFBFBFBCBCBCADADAD
          C6C6C6C6C6C7B5B5C1B7B7C5CCCCCEC1C2C8BEBFC5BABAC2C3C3C3ACACAC9595
          95B0B0B0BEBEBEBFBFBFBDBDBDAFAFAFB2B2B2ADADAD9F9FACB8B8BBB7B7BCB3
          B3BBADADB7A8A8B5B5B5B8919292A6A6A6BBBBBBBFBFBFBFBFBFBFBFBFB6B6B6
          8D8D8D8989898C8C969D9DA8A8A8AF9B9BAB9F9FABA1A2AD9D9D9E9D9D9DB6B6
          B6BFBFBFBFBFBFBFBFBFBFBFBFC4C4C4C2C2C28F8F8F929292A6A6A7A7A8AC99
          99A7AAABACA9AAAA979898ADADADBCBCBCBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          CCCCCC9D9D9DA2A2A2B1B1B1AEAFB0A3A3ABADADADA0A1A1A7A7A7B9B9B9BFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB5B6B6B7B8B8B9B9B9B5B6B6B1
          B1B2ADADADACACACB7B7B7BDBDBDBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBEBEBEBBBBBBB7B7B7BCBCBCBDBDBDBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF}
        OnClick = btnScintillaOptionsClick
      end
      object cboQuickColor: TComboBox
        Left = 303
        Top = 23
        Width = 102
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnSelect = cboQuickColorSelect
        Items.Strings = (
          'Classic'
          'Twilight'
          'Ocean'
          'Visual Studio'
          'Borland'
          'Matrix')
      end
      object CppEdit: TScintilla
        Left = 8
        Top = 56
        Width = 385
        Height = 273
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ShowHint = True
        ParentShowHint = False
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
        Caret.LineBackAlpha = 0
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
      object StaticText1: TStaticText
        Left = 8
        Top = 8
        Width = 40
        Height = 17
        Caption = 'Scintilla'
        TabOrder = 2
      end
    end
    object tabCode: TTabSheet
      Caption = 'Code'
      object codepages: TPageControl
        Left = 5
        Top = 5
        Width = 396
        Height = 335
        ActivePage = tabCPDefault
        TabIndex = 1
        TabOrder = 0
        object tabCPInserts: TTabSheet
          Caption = 'Inserts'
          DesignSize = (
            388
            307)
          object lblCode: TLabel
            Left = 10
            Top = 105
            Width = 28
            Height = 13
            Anchors = [akLeft, akTop, akRight, akBottom]
            Caption = 'Code:'
          end
          object btnAdd: TButton
            Left = 309
            Top = 10
            Width = 70
            Height = 23
            Caption = 'Add'
            TabOrder = 1
            OnClick = btnAddClick
          end
          object btnEdit: TButton
            Left = 309
            Top = 35
            Width = 70
            Height = 23
            Caption = 'Edit'
            TabOrder = 2
            OnClick = btnEditClick
          end
          object btnRemove: TButton
            Left = 309
            Top = 60
            Width = 70
            Height = 23
            Caption = 'Remove'
            TabOrder = 3
            OnClick = btnRemoveClick
          end
          object lvCodeins: TListView
            Left = 10
            Top = 10
            Width = 290
            Height = 91
            Columns = <
              item
                Caption = 'Menu text'
                Width = 100
              end
              item
                Caption = 'Section'
              end
              item
                Caption = 'Description'
                Width = -2
                WidthType = (
                  -2)
              end>
            ColumnClick = False
            FlatScrollBars = True
            GridLines = True
            HideSelection = False
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnColumnClick = lvCodeinsColumnClick
            OnCompare = lvCodeinsCompare
            OnSelectItem = lvCodeinsSelectItem
          end
          object CodeIns: TScintilla
            Left = 8
            Top = 120
            Width = 369
            Height = 169
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
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
            Caret.LineBackAlpha = 0
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
        object tabCPDefault: TTabSheet
          Caption = 'Default Source'
          object seDefault: TScintilla
            Left = 0
            Top = 8
            Width = 393
            Height = 265
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
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
            Caret.LineBackAlpha = 0
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
          object cbDefaultintoprj: TCheckBox
            Left = 2
            Top = 277
            Width = 382
            Height = 17
            Caption = 'Insert Default Code into Empty Projects'
            TabOrder = 1
          end
        end
      end
    end
    object tabClassBrowsing: TTabSheet
      Caption = 'Class browsing'
      object chkEnableClassBrowser: TCheckBox
        Left = 5
        Top = 5
        Width = 395
        Height = 17
        Caption = 'Enable class browser'
        TabOrder = 0
        OnClick = chkEnableClassBrowserClick
      end
      object devPages1: TPageControl
        Left = 5
        Top = 28
        Width = 397
        Height = 310
        ActivePage = tabCBCompletion
        TabIndex = 1
        TabOrder = 1
        OnChange = devPages1Change
        object tabCBBrowser: TTabSheet
          Caption = 'Class browsing'
          object lblClassBrowserSample: TLabel
            Left = 8
            Top = 148
            Width = 38
            Height = 13
            Caption = 'Sample:'
          end
          object ClassBrowser1: TClassBrowser
            Left = 60
            Top = 148
            Width = 320
            Height = 125
            Images = dmMain.ClassImages
            ReadOnly = True
            Indent = 19
            TabOrder = 2
            ShowFilter = sfAll
            ItemImages.Globals = -1
            ItemImages.Classes = 1
            ItemImages.VariablePrivate = 2
            ItemImages.VariableProtected = 3
            ItemImages.VariablePublic = 4
            ItemImages.VariablePublished = 4
            ItemImages.MethodPrivate = 5
            ItemImages.MethodProtected = 6
            ItemImages.MethodPublic = 7
            ItemImages.MethodPublished = 7
            ItemImages.InheritedMethodProtected = 0
            ItemImages.InheritedMethodPublic = 0
            ItemImages.InheritedVariableProtected = 0
            ItemImages.InheritedVariablePublic = 0
            UseColors = True
            ShowInheritedMembers = False
          end
          object gbCBEngine: TGroupBox
            Left = 7
            Top = 6
            Width = 374
            Height = 60
            Caption = 'Engine behaviour'
            TabOrder = 0
            object chkCBParseGlobalH: TCheckBox
              Left = 8
              Top = 36
              Width = 360
              Height = 17
              Caption = 'Scan global files referenced in #include'#39's'
              TabOrder = 1
            end
            object chkCBParseLocalH: TCheckBox
              Left = 8
              Top = 16
              Width = 360
              Height = 17
              Caption = 'Scan local files referenced in #include'#39's'
              TabOrder = 0
            end
          end
          object gbCBView: TGroupBox
            Left = 6
            Top = 72
            Width = 374
            Height = 60
            Caption = 'View options'
            TabOrder = 1
            object chkCBUseColors: TCheckBox
              Left = 8
              Top = 16
              Width = 360
              Height = 17
              Caption = 'Use colors'
              TabOrder = 0
              OnClick = chkCBUseColorsClick
            end
            object chkCBShowInherited: TCheckBox
              Left = 8
              Top = 36
              Width = 360
              Height = 17
              Caption = 'Show inherited members'
              TabOrder = 1
              OnClick = chkCBShowInheritedClick
            end
          end
        end
        object tabCBCompletion: TTabSheet
          Caption = 'Code completion'
          object lblCompletionDelay: TLabel
            Left = 24
            Top = 31
            Width = 52
            Height = 13
            Caption = 'Delay (ms):'
          end
          object cpCompletionBackground: TColorPickerButton
            Left = 175
            Top = 54
            Width = 110
            Height = 22
            CustomText = 'Custom'
            DefaultText = 'Default'
            PopupSpacing = 8
            ShowSystemColors = True
            OnChange = StyleChange
            OnDefaultSelect = DefaultSelect
            OnHint = PickerHint
          end
          object lblCompletionColor: TLabel
            Left = 24
            Top = 56
            Width = 121
            Height = 13
            Caption = 'Dialog Background Color:'
          end
          object lblCCCache: TLabel
            Left = 24
            Top = 104
            Width = 68
            Height = 13
            Caption = 'Files in cache:'
          end
          object chkEnableCompletion: TCheckBox
            Left = 8
            Top = 8
            Width = 370
            Height = 17
            Caption = 'Enable code-completion'
            TabOrder = 0
            OnClick = chkEnableCompletionClick
          end
          object chkCCCache: TCheckBox
            Left = 8
            Top = 84
            Width = 370
            Height = 17
            Caption = 'Use code-completion cache'
            TabOrder = 1
            OnClick = chkCCCacheClick
          end
          object lbCCC: TListBox
            Left = 24
            Top = 120
            Width = 260
            Height = 155
            ItemHeight = 13
            Sorted = True
            TabOrder = 2
            OnClick = FontChange
          end
          object pbCCCache: TProgressBar
            Left = 292
            Top = 175
            Width = 89
            Height = 16
            Min = 0
            Max = 100
            TabOrder = 3
            Visible = False
          end
          object btnCCCnew: TButton
            Left = 292
            Top = 120
            Width = 90
            Height = 23
            Caption = 'Add'
            TabOrder = 4
            OnClick = btnCCCnewClick
          end
          object btnCCCdelete: TButton
            Left = 292
            Top = 147
            Width = 90
            Height = 23
            Caption = 'Clear'
            TabOrder = 5
            OnClick = btnCCCdeleteClick
          end
          object edCompletionDelay: TSpinEdit
            Left = 175
            Top = 27
            Width = 110
            Height = 22
            MaxValue = 1500
            MinValue = 0
            TabOrder = 6
            Value = 500
          end
        end
      end
    end
  end
  object btnOk: TBitBtn
    Left = 166
    Top = 387
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = btnOkClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btnCancel: TBitBtn
    Left = 251
    Top = 387
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    TabOrder = 2
    OnClick = btnCancelClick
    Kind = bkCancel
  end
  object btnHelp: TBitBtn
    Left = 346
    Top = 387
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    TabOrder = 3
    OnClick = btnHelpClick
    Kind = bkHelp
  end
  object CppTokenizer1: TCppTokenizer
    LogTokens = False
    Left = 35
    Top = 384
  end
  object CppParser1: TCppParser
    Enabled = True
    OnTotalProgress = CppParser1TotalProgress
    Tokenizer = CppTokenizer1
    ParseLocalHeaders = True
    ParseGlobalHeaders = True
    LogStatements = False
    OnStartParsing = CppParser1StartParsing
    OnEndParsing = CppParser1EndParsing
    Left = 63
    Top = 384
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
    Left = 91
    Top = 384
  end
  object pLoadEdit: TSciPropertyLoader
    Editor = CppEdit
    StoreWhat = [stDefaults, stColors, stStyles, stOther, stLexerProperties, stExtensions]
    Top = 384
  end
  object ScintillaOptionsDlg1: TScintillaOptionsDlg
    Editor = CppEdit
    Pages = [opOptions, opColors, opHighlighter, opKeyboard]
    Left = 128
    Top = 384
  end
end
