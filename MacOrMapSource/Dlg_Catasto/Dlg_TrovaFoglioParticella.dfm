object Form_TrovaFoglioParticella: TForm_TrovaFoglioParticella
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Trova Foglio Particella'
  ClientHeight = 212
  ClientWidth = 379
  Color = 11106062
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 31
    Top = 19
    Width = 62
    Height = 23
    Caption = 'Foglio :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 196
    Top = 19
    Width = 87
    Height = 23
    Caption = 'Particella :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Bot_Grafica: TBitBtn
    Left = 31
    Top = 115
    Width = 128
    Height = 25
    Caption = 'Territorio'
    Default = True
    TabOrder = 0
    OnClick = Bot_GraficaClick
  end
  object ED_FG: TEdit
    Left = 116
    Top = 21
    Width = 43
    Height = 21
    Alignment = taRightJustify
    TabOrder = 1
  end
  object ED_Part: TEdit
    Left = 289
    Top = 21
    Width = 43
    Height = 21
    Alignment = taRightJustify
    TabOrder = 2
  end
  object Bot_Tabella: TBitBtn
    Left = 204
    Top = 115
    Width = 128
    Height = 25
    Caption = 'Tabella'
    Default = True
    TabOrder = 3
    OnClick = Bot_TabellaClick
  end
  object RadioGroup1: TRadioGroup
    Left = 31
    Top = 56
    Width = 327
    Height = 37
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Fabbricato'
      'Terreno')
    TabOrder = 4
  end
  object Bot_vedofoglio: TBitBtn
    Left = 31
    Top = 161
    Width = 128
    Height = 25
    Caption = 'Vedo solo foglio Indicato'
    Default = True
    TabOrder = 5
    OnClick = Bot_vedofoglioClick
  end
  object Bot_vedotuttifogli: TBitBtn
    Left = 204
    Top = 161
    Width = 128
    Height = 25
    Caption = 'Vedo Tutti i Fogli'
    Default = True
    TabOrder = 6
    OnClick = Bot_vedotuttifogliClick
  end
end
