object wxValidator: TwxValidator
  Left = 252
  Top = 271
  Width = 412
  Height = 225
  Caption = 'wxValidator'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 68
    Height = 13
    Caption = 'Validator Type'
  end
  object Label2: TLabel
    Left = 24
    Top = 64
    Width = 113
    Height = 13
    Caption = 'Validator Variable Name'
  end
  object Label3: TLabel
    Left = 248
    Top = 16
    Width = 48
    Height = 13
    Caption = 'Filter Style'
  end
  object Label4: TLabel
    Left = 24
    Top = 112
    Width = 91
    Height = 13
    Caption = 'Validator Command'
  end
  object Label5: TLabel
    Left = 176
    Top = 86
    Width = 45
    Height = 13
    Caption = '(Optional)'
  end
  object OK: TBitBtn
    Left = 232
    Top = 160
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      555555555555555555555555555555555555555555FF55555555555559055555
      55555555577FF5555555555599905555555555557777F5555555555599905555
      555555557777FF5555555559999905555555555777777F555555559999990555
      5555557777777FF5555557990599905555555777757777F55555790555599055
      55557775555777FF5555555555599905555555555557777F5555555555559905
      555555555555777FF5555555555559905555555555555777FF55555555555579
      05555555555555777FF5555555555557905555555555555777FF555555555555
      5990555555555555577755555555555555555555555555555555}
    NumGlyphs = 2
  end
  object Cancel: TBitBtn
    Left = 320
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
      3333333777333777FF3333993333339993333377FF3333377FF3399993333339
      993337777FF3333377F3393999333333993337F777FF333337FF993399933333
      399377F3777FF333377F993339993333399377F33777FF33377F993333999333
      399377F333777FF3377F993333399933399377F3333777FF377F993333339993
      399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
      99333773FF3333777733339993333339933333773FFFFFF77333333999999999
      3333333777333777333333333999993333333333377777333333}
    NumGlyphs = 2
  end
  object ValidatorString: TEdit
    Left = 24
    Top = 128
    Width = 369
    Height = 21
    TabOrder = 2
  end
  object ValidatorType: TComboBox
    Left = 24
    Top = 32
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = 'wxTextValidator'
    OnChange = ValidatorTypeChange
    Items.Strings = (
      'wxTextValidator'
      'wxGenericValidator')
  end
  object ValidatorVariable: TEdit
    Left = 24
    Top = 80
    Width = 145
    Height = 21
    TabOrder = 4
    OnChange = VariableChange
  end
  object FilterStyle: TComboBox
    Left = 248
    Top = 32
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    Text = 'wxFILTER_NONE'
    OnChange = OnChange
    Items.Strings = (
      'wxFILTER_NONE'
      'wxFILTER_ASCII'
      'wxFILTER_ALPHANUMERIC'
      'wxFILTER_NUMERIC'
      'wxFILTER_INCLUDE_LIST'
      'wxFILTER_EXCLUDE_LIST'
      'wxFILTER_INCLUDE_CHAR_LIST'
      'wxFILTER_EXCLUDE_CHAR_LIST')
  end
end