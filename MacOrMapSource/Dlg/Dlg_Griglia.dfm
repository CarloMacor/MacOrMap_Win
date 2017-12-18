object Form_Griglia: TForm_Griglia
  Left = 242
  Top = 107
  BorderIcons = [biSystemMenu]
  Caption = 'Imposta Griglia'
  ClientHeight = 174
  ClientWidth = 336
  Color = 11440761
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bot_Utm84: TSpeedButton
    Left = 17
    Top = 17
    Width = 111
    Height = 22
    AllowAllUp = True
    GroupIndex = 1
    Down = True
    Caption = 'UTM Wgs84'
    OnClick = Bot_Utm84Click
  end
  object Bot_Sfe84: TSpeedButton
    Left = 17
    Top = 47
    Width = 111
    Height = 22
    AllowAllUp = True
    GroupIndex = 2
    Caption = 'Sferiche Wgs84'
    OnClick = Bot_Sfe84Click
  end
  object Bot_Utm50: TSpeedButton
    Left = 17
    Top = 77
    Width = 111
    Height = 22
    AllowAllUp = True
    GroupIndex = 3
    Caption = 'UTM D50'
    OnClick = Bot_Utm50Click
  end
  object Bot_Sfe50: TSpeedButton
    Left = 17
    Top = 107
    Width = 111
    Height = 22
    AllowAllUp = True
    GroupIndex = 4
    Caption = 'Sferiche D50'
    OnClick = Bot_Sfe50Click
  end
  object Bot_Cassini: TSpeedButton
    Left = 17
    Top = 138
    Width = 111
    Height = 22
    AllowAllUp = True
    GroupIndex = 5
    Caption = 'Cassini-Soldner'
    OnClick = Bot_CassiniClick
  end
  object Comb_Utm84: TComboBox
    Left = 165
    Top = 18
    Width = 78
    Height = 21
    ItemIndex = 0
    TabOrder = 0
    Text = 'Automatico'
    OnChange = Comb_Utm84Change
    Items.Strings = (
      'Automatico'
      '100'
      '1.000'
      '10.000')
  end
  object Panel1: TPanel
    Left = 260
    Top = 16
    Width = 52
    Height = 23
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clBlack
    ParentBackground = False
    TabOrder = 1
    OnClick = Panel1Click
  end
  object Comb_Sfe84: TComboBox
    Left = 165
    Top = 48
    Width = 78
    Height = 21
    TabOrder = 2
    Text = 'Automatico'
    OnChange = Comb_Sfe84Change
    Items.Strings = (
      'Automatico'
      '10 "'
      '30 "'
      '1 '#176
      '5 '#176)
  end
  object Panel2: TPanel
    Left = 260
    Top = 46
    Width = 52
    Height = 23
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clBlack
    ParentBackground = False
    TabOrder = 3
    OnClick = Panel2Click
  end
  object Comb_Utm50: TComboBox
    Left = 165
    Top = 78
    Width = 78
    Height = 21
    TabOrder = 4
    Text = 'Automatico'
    OnChange = Comb_Utm50Change
    Items.Strings = (
      'Automatico'
      '100'
      '1.000'
      '10.000')
  end
  object Panel3: TPanel
    Left = 260
    Top = 76
    Width = 52
    Height = 23
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clBlack
    ParentBackground = False
    TabOrder = 5
    OnClick = Panel3Click
  end
  object Comb_Sfe50: TComboBox
    Left = 165
    Top = 108
    Width = 78
    Height = 21
    TabOrder = 6
    Text = 'Automatico'
    OnChange = Comb_Sfe50Change
    Items.Strings = (
      'Automatico'
      '10 "'
      '30 "'
      '1 '#176
      '5 '#176
      '')
  end
  object Panel4: TPanel
    Left = 260
    Top = 106
    Width = 52
    Height = 23
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clBlack
    ParentBackground = False
    TabOrder = 7
    OnClick = Panel4Click
  end
  object Comb_Cassini: TComboBox
    Left = 165
    Top = 139
    Width = 78
    Height = 21
    TabOrder = 8
    Text = 'Automatico'
    OnChange = Comb_CassiniChange
    Items.Strings = (
      'Automatico'
      '100'
      '1.000'
      '10.000')
  end
  object Panel5: TPanel
    Left = 260
    Top = 137
    Width = 52
    Height = 23
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clBlack
    ParentBackground = False
    TabOrder = 9
    OnClick = Panel5Click
  end
  object ColDialog: TColorDialog
    Left = 132
    Top = 5
  end
end
