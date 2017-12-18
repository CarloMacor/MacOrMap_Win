object Form_SpostaTerritorio: TForm_SpostaTerritorio
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Sposta Immagine'
  ClientHeight = 139
  ClientWidth = 261
  Color = 9330455
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 26
    Top = 33
    Width = 56
    Height = 16
    Caption = 'Nuova X :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 26
    Top = 64
    Width = 55
    Height = 16
    Caption = 'Nuova Y :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 74
    Top = 8
    Width = 117
    Height = 13
    Caption = 'Le coordinate in WGS 84'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 41
    Top = 100
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 0
  end
  object BitBtn2: TBitBtn
    Left = 140
    Top = 100
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 116
    Top = 28
    Width = 121
    Height = 21
    Alignment = taRightJustify
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 116
    Top = 59
    Width = 121
    Height = 21
    Alignment = taRightJustify
    TabOrder = 3
    Text = 'Edit2'
  end
end
