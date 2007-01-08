object TipOfTheDayForm: TTipOfTheDayForm
  Left = 295
  Top = 212
  BorderStyle = bsDialog
  Caption = 'Tip Of The Day'
  ClientHeight = 236
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnPrev: TButton
    Left = 304
    Top = 32
    Width = 75
    Height = 23
    Caption = 'Previous tip'
    TabOrder = 1
    OnClick = btnPrevClick
  end
  object btnNext: TButton
    Left = 304
    Top = 4
    Width = 75
    Height = 23
    Caption = 'Next tip'
    TabOrder = 0
    OnClick = btnNextClick
  end
  object btnClose: TButton
    Left = 304
    Top = 190
    Width = 75
    Height = 23
    Cancel = True
    Caption = 'Close'
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object chkNotAgain: TCheckBox
    Left = 4
    Top = 216
    Width = 377
    Height = 17
    Caption = 'Don'#39't display tips on startup'
    TabOrder = 3
  end
  object ScrollBox: TScrollBox
    Left = 4
    Top = 4
    Width = 293
    Height = 209
    Color = clWindow
    ParentColor = False
    TabOrder = 4
    object lblTip: TLabel
      Left = 52
      Top = 64
      Width = 230
      Height = 120
      Caption = 'lblTip'
      Constraints.MinWidth = 230
      WordWrap = True
    end
    object lblTitle: TLabel
      Left = 52
      Top = 28
      Width = 117
      Height = 19
      Caption = 'Did you know...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 52
      Top = 52
      Width = 230
      Height = 2
    end
    object Image: TImage
      Left = 8
      Top = 16
      Width = 36
      Height = 36
      Center = True
      Picture.Data = {
        07544269746D617046090000424D460900000000000036040000280000002400
        0000240000000100080000000000100500000000000000000000000100000001
        000000000000FFFF0000007B7B007B7B7B00BDBDBD0000FFFF00DEFFFF00E7FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000BF0000BF000000BF
        BF00BF000000BF00BF00BFBF0000C0C0C000808080000000FF0000FF000000FF
        FF00FF000000FF00FF00FFFF0000FFFFFF000000000000000000000000000000
        0000060606060606060606060606060606060606060606060606060606060606
        0606060606060606060606060606060606060606060606060606060606060606
        060606060606060606060606060606060606060606060606060606F406060606
        060606060606060606060606060606060606060606060606060606060606F4F4
        F406060606060606060606060606060606060606060606060606060606060606
        06F4F4F4F4F40606060606060606060606060606060606060606060606060606
        06060606F4F4F4FFF4F4F4060606060606060606060606060606060606060606
        06060606060606F4F4F4FFFAFFF4F4F406060606060606060606060606060606
        06060606060606060606F4F4F4FFFAFBFAFFF4F4F40606060606060606060606
        06060606060606060606060606F4F4F4FFFAFBFAFBFAFFF4F4F4060606060606
        06060606060606060606060606060606F4F4F4FFFAFBFAFBFAFBFAFFF4F4F406
        06060606060606060606060606060606060606F4F4F4FFFAFBFAFFFFFFFAFBFA
        FFF4F4F4060606060606060606060606060606060606F4F4F4FFFAFBFAFFFFFF
        FFFFFAFBFAFFF4F4F406060606060606060606060606060606F4F4F4FFFAFBFA
        F4F4FBF3F3FFFFFAFBFAFFF4F4F40606060606060606060606060606F4F4F4FF
        FAFBFAFBF4FBFFFFFFF3FFFBFAFBFAFFF4F4F406060606060606060606060606
        06F4FFFAFBFAFBF4F4FFFBF3F3FFFFFFFBFAFBFAFFF406060606060606060606
        0606060606FFFAFBFAFBFAF4FBFBFFFFFFF3F3FFFAFBFAFBFAFF060606060606
        0606060606060606FFFAFBFAFBFAFBF4FFFF020202FFFFFFFBFAFBFAFBFAFF06
        06060606060606060606060606F4FAFBFAFBFAFF0202F7F7F70202FFFAFBFAFB
        FAFF06060606060606060606060606060606F4FAFBFAFF02F7F7F7F7F7F7F702
        FFFAFBFAFF060606060606060606060606060606060606F4FAFBFF02F7F7FBF7
        FBF7FB02FFFBFAFF0606060606060606060606060606060606060606F4FF02F7
        F7F7F4FFF4F7F7F702FFFF060606060606060606060606060606060606060606
        FF02F7F7FBF7FFFFFFF7FBF7FB02FF0606060606060606060606060606060606
        06060606FFF7F7F7F7FBF4FFF4FBF7F7F702FF06060606060606060606060606
        0606060606060602F7F7FBF7FBF7FBF7FBF7FBF7FBF702FF0606060606060606
        060606060606060606060602F7F7F7FBF7FBF7FFF7FBF7FBF7F702FF06060606
        06060606060606060606060606060602FBF7FBFBFBFBFBFFFBF7FBF7FBF702FF
        0606060606060606060606060606060606060602F7FBFBFBFBFBF4FFF4FBF7FB
        F7F702FF0606060606060606060606060606060606060602F7FBFBFBFBFBFFFF
        FFF7FBF7FBF702FF060606060606060606060606060606060606060602FBFBFB
        FBFBFFFFFFFBF7FBF7F7FF060606060606060606060606060606060606060606
        02F7FBFBFBFBFFFFFFF7FBF7FBF7FF0606060606060606060606060606060606
        060606060602F7FBFBFBF4FFF4FBF7F7F7FF0606060606060606060606060606
        0606060606060606060602F7FBF7FBF7FBF7FBF7020606060606060606060606
        0606060606060606060606060606060202F7F7F7F7F702020606060606060606
        0606060606060606060606060606060606060606060202020202060606060606
        0606060606060606060606060606060606060606060606060606060606060606
        0606060606060606060606060606060606060606060606060606060606060606
        060606060606060606060606060606060606}
      Transparent = True
    end
    object lblUrl: TLabel
      Left = 0
      Top = 192
      Width = 289
      Height = 13
      Cursor = crHandPoint
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblUrl'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = lblUrlClick
    end
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
    Left = 348
    Top = 154
  end
end
