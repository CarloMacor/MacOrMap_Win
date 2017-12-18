object Form_Stampa: TForm_Stampa
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Stampa in Scala Area da Selezionare'
  ClientHeight = 270
  ClientWidth = 264
  Color = 7428361
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 22
    Top = 12
    Width = 28
    Height = 23
    GroupIndex = 100
    Down = True
    Caption = 'A4'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 70
    Top = 12
    Width = 28
    Height = 23
    GroupIndex = 100
    Caption = 'A3'
    OnClick = SpeedButton2Click
  end
  object Label1: TLabel
    Left = 11
    Top = 102
    Width = 136
    Height = 16
    Caption = 'cm stampa interna x,y :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 26
    Top = 139
    Width = 102
    Height = 16
    Caption = 'Scala di Stampa :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object SpeedButton4: TSpeedButton
    Left = 64
    Top = 210
    Width = 135
    Height = 29
    Caption = 'Definisci Area Stampa'
    OnClick = SpeedButton4Click
  end
  object SpeedButton3: TSpeedButton
    Left = 119
    Top = 12
    Width = 28
    Height = 23
    GroupIndex = 100
    Caption = 'A2'
    OnClick = SpeedButton3Click
  end
  object SpeedButton5: TSpeedButton
    Left = 168
    Top = 12
    Width = 28
    Height = 23
    GroupIndex = 100
    Caption = 'A1'
    OnClick = SpeedButton5Click
  end
  object SpeedButton6: TSpeedButton
    Left = 217
    Top = 12
    Width = 28
    Height = 23
    GroupIndex = 100
    Caption = 'A0'
    OnClick = SpeedButton6Click
  end
  object Label3: TLabel
    Left = 26
    Top = 167
    Width = 94
    Height = 16
    Caption = 'Risoluzione dpi :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 36
    Top = 74
    Width = 89
    Height = 16
    Caption = 'Dim Foglio x,y :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BotOr: TSpeedButton
    Left = 54
    Top = 45
    Width = 66
    Height = 23
    GroupIndex = 101
    Down = True
    Caption = 'Orizzontale'
    OnClick = BotOrClick
  end
  object BotVert: TSpeedButton
    Left = 153
    Top = 45
    Width = 61
    Height = 23
    GroupIndex = 101
    Caption = 'Verticale'
    OnClick = BotVertClick
  end
  object Labxr: TLabel
    Left = 166
    Top = 74
    Width = 25
    Height = 16
    Caption = '29.7'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Labyr: TLabel
    Left = 216
    Top = 74
    Width = 25
    Height = 16
    Caption = '21.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Editcmx: TEdit
    Left = 153
    Top = 101
    Width = 41
    Height = 21
    Alignment = taRightJustify
    TabOrder = 0
    Text = '28.2'
  end
  object Editcmy: TEdit
    Left = 206
    Top = 101
    Width = 39
    Height = 21
    Alignment = taRightJustify
    TabOrder = 1
    Text = '19.5'
  end
  object ComboScala: TComboBox
    Left = 152
    Top = 134
    Width = 93
    Height = 21
    ItemIndex = 0
    TabOrder = 2
    Text = '500'
    Items.Strings = (
      '500'
      '1000'
      '2000'
      '5000'
      '10000')
  end
  object Combodpi: TComboBox
    Left = 152
    Top = 166
    Width = 93
    Height = 21
    ItemIndex = 1
    TabOrder = 3
    Text = '100'
    Items.Strings = (
      '80'
      '100'
      '150'
      '200'
      '250'
      '300')
  end
end
