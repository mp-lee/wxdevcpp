object frmHelpEdit: TfrmHelpEdit
  Left = 272
  Top = 141
  Width = 350
  Height = 395
  BorderStyle = bsSizeToolWin
  Caption = 'Help Menu Editor'
  Color = clBtnFace
  Constraints.MinHeight = 394
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    342
    361)
  PixelsPerInch = 96
  TextHeight = 13
  object btnNew: TSpeedButton
    Left = 8
    Top = 177
    Width = 75
    Height = 22
    Caption = 'Add'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000BFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0F0F0F0F
      0F0F0F0F0F0F0F0FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBF0F0F0F00C04400A33B00A33B008D310F0F0FBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0F0F0F94FF9400
      C04400B33F00A33B0F0F0FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBF0F0F0F94FF9400C04400C04400A33B0F0F0FBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0F0F0F0F0F0F0F0F0F0F0F0F94FF9400
      C04400C04400A33B0F0F0F0F0F0F0F0F0F0F0F0FBFBFBFBFBFBFBFBFBF353535
      00C04400A33B00A33B00A33B00C04400C04400C04400A33B00A33B00A33B00A3
      3B008D310F0F0FBFBFBFBFBFBF35353594FF9400C04400C04400C04400C04400
      C04400C04400C04400C04400C04400B33F00A33B0F0F0FBFBFBFBFBFBF353535
      94FF9400E05000C04400C04400C04400C04400C04400C04400C04400C04400C0
      4400A33B0F0F0FBFBFBFBFBFBF5B5B5BBFFFD694FF9494FF9494FF94BFFFD600
      C04400C04400C044BFFFD694FF9494FF9400C0440F0F0FBFBFBFBFBFBFBFBFBF
      5B5B5B35353535353535353594FF9400C04400C04400A33B0F0F0F0F0F0F0F0F
      0F0F0F0FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF35353594FF9400
      C04400C04400A33B0F0F0FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBF35353594FF9400E05000C04400A33B0F0F0FBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF5B5B5BBFFFD694
      FF9494FF9400C0440F0F0FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBF5B5B5B353535353535353535BFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF}
    OnClick = btnNewClick
  end
  object btnDelete: TSpeedButton
    Left = 91
    Top = 177
    Width = 75
    Height = 22
    Caption = 'Delete'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000BFBFBFBFBFBF
      BFBFBF000000000000000000000000000000000000000000000000000000BFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000073C88A72C48870BC846FB5826C
      AE7D6AA57A689E75679975679975000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      00000073C88A72C38871BC846FB4816CAC7D6AA579689E756799756799750000
      00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000073C88A72C3876FBD846EB5806D
      AD7C6AA579689E76679975679975000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      00000073C88A72C48871BD856EB4826DAC7C6AA57A689E756799756799750000
      00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000073C88A72C4886FBD846FB4816D
      AC7C6AA57A689E75679975679975000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      00000073C88A72C48871BD856FB4826CAC7D6AA57A689E756799756799750000
      00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000073C88A72C38871BD836FB4816C
      AC7D6AA579689E76679975679975000000BFBFBFBFBFBFBFBFBFBFBFBF000000
      10381B10381B10381B10381B10381B10381B10381B10381B10381B10381B1038
      1B000000BFBFBFBFBFBFBFBFBF0000007CD79479CA8F73BE8773BE8773BE8773
      BE876AA57A6AA57A679975679975679975000000BFBFBFBFBFBFBFBFBF000000
      7CD7947CD79479CA8F73BE8773BE8773BE8773BE876AA57A6AA57A6799756799
      75000000BFBFBFBFBFBFBFBFBFBFBFBF0000007CD7947CD7947CD79479CA8F73
      BE8773BE8773BE876AA57A6AA57A000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBF6868680000007CD7947CD79479CA8F79CA8F79CA8F000000000000BFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000000000000
      0000000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBF000000BFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF68686800
      0000686868BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF}
    OnClick = btnDeleteClick
  end
  object btnBrowse: TSpeedButton
    Left = 175
    Top = 177
    Width = 75
    Height = 22
    Caption = 'Browse'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000BFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBF0000000000000000
      00000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BF
      BFBF000000BFBFBF0000005DCCFF5DCCFF5DCCFF000000BFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBF6868680000000000
      00000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBF0000000000000000
      00000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BF
      BFBF000000BFBFBF0000005DCCFF5DCCFF5DCCFF000000BFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBF6868680000000000
      00000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000000000
      000000000000000000000000000000000000000000000000000000BFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBF00000000AEFF0096DB0096DB0096DB0096DB0096DB00
      96DB0096DB0082BE000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000005DCCFF
      00AEFF00AEFF00AEFF00AEFF00AEFF00AEFF00AEFF0096DB000000BFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBF0000005DCCFF00AEFF00AEFF00AEFF00AEFF00AEFF00
      AEFF00AEFF0096DB000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000005DCCFF
      00AEFF00AEFF00AEFF00AEFF00AEFF00AEFF00AEFF0096DB000000BFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBF0000005DCCFF00AEFF00AEFF5DCCFF5DCCFF5DCCFF5D
      CCFF5DCCFF00AEFF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF686868BDEBFF
      5DCCFF5DCCFF000000000000000000000000000000000000BFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBF000000000000000000BFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF}
    OnClick = btnBrowseClick
  end
  object btnRename: TSpeedButton
    Left = 259
    Top = 177
    Width = 75
    Height = 22
    Caption = 'Rename'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000BFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBF00000037C84537C845000000BFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBF00000099E3A0
      72D87C72D87C37C845000000BFBFBFBFBFBFBFBFBFBFBFBF00000037C8450000
      00BFBFBFBFBFBFBFBFBF00000099E3A099E3A072D87C72D87C37C84500000000
      0000BFBFBFBFBFBF00000072D87C37C845000000BFBFBFBFBFBFBFBFBF686868
      00000099E3A099E3A099E3A072D87C72D87C00000000000000000072D87C72D8
      7C37C845000000BFBFBFBFBFBFBFBFBFBFBFBF68686800000000000099E3A099
      E3A099E3A099E3A099E3A072D87C72D87C72D87C37C845000000BFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBF00000000000000000000000000000099E3A072D8
      7C99E3A0000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBF00000099E3A099E3A0000000BFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF68686899E3A00000
      00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF}
    OnClick = btnRenameClick
  end
  object btnOk: TBitBtn
    Left = 81
    Top = 341
    Width = 80
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
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
    Left = 166
    Top = 341
    Width = 80
    Height = 23
    Anchors = [akLeft, akBottom]
    TabOrder = 1
    Kind = bkCancel
  end
  object btnHelp: TBitBtn
    Left = 261
    Top = 341
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    TabOrder = 2
    Kind = bkHelp
  end
  object grpOptions: TGroupBox
    Left = 8
    Top = 206
    Width = 327
    Height = 128
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Help Menu Options'
    TabOrder = 3
    object lblIcon: TLabel
      Left = 8
      Top = 16
      Width = 21
      Height = 13
      Caption = 'Icon'
    end
    object cboIcon: TComboBoxEx
      Left = 8
      Top = 31
      Width = 90
      Height = 22
      ItemsEx = <
        item
          Caption = 'None'
        end
        item
          ImageIndex = 0
          SelectedImageIndex = 0
        end
        item
          ImageIndex = 1
          SelectedImageIndex = 1
        end
        item
          ImageIndex = 2
          SelectedImageIndex = 2
        end
        item
          ImageIndex = 3
          SelectedImageIndex = 3
        end
        item
          ImageIndex = 4
          SelectedImageIndex = 4
        end
        item
          ImageIndex = 5
          SelectedImageIndex = 5
        end
        item
          ImageIndex = 6
          SelectedImageIndex = 6
        end>
      Style = csExDropDownList
      ItemHeight = 16
      TabOrder = 0
      OnSelect = cboIconSelect
      Images = dmMain.HelpImages_Gnome
      DropDownCount = 8
    end
    object grpMenu: TRadioGroup
      Left = 136
      Top = 16
      Width = 178
      Height = 36
      Caption = '  Menu  '
      Columns = 2
      Items.Strings = (
        'Section 1'
        'Section 2')
      TabOrder = 1
      OnClick = grpMenuClick
    end
    object cbPop: TCheckBox
      Left = 8
      Top = 97
      Width = 305
      Height = 17
      Caption = 'On Help Popup Menu'
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 2
      OnClick = cbPopClick
    end
    object cbSearchWord: TCheckBox
      Left = 8
      Top = 64
      Width = 305
      Height = 17
      Caption = 'Search in help file for the word at cursor position'
      TabOrder = 3
      OnClick = cbSearchWordClick
    end
    object cbAffectF1: TCheckBox
      Left = 8
      Top = 80
      Width = 305
      Height = 17
      Caption = 'Assign F1 shortcut'
      TabOrder = 4
      OnClick = cbAffectF1Click
    end
  end
  object lvFiles: TListView
    Left = 8
    Top = 8
    Width = 326
    Height = 165
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvLowered
    BevelKind = bkSoft
    BorderStyle = bsNone
    Columns = <
      item
        Caption = 'Menu Text'
        Width = 150
      end
      item
        Caption = 'Help File'
        Width = 170
      end>
    ColumnClick = False
    GridLines = True
    HideSelection = False
    RowSelect = True
    TabOrder = 4
    ViewStyle = vsReport
    OnChange = lvFilesChange
    OnEdited = lvFilesEdited
    OnEditing = lvFilesEditing
    OnSelectItem = lvFilesSelectItem
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
    Left = 8
    Top = 338
  end
end
