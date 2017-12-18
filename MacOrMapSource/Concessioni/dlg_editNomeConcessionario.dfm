object Form_editNomeConcessionario: TForm_editNomeConcessionario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Nome  Concessionario'
  ClientHeight = 121
  ClientWidth = 380
  Color = 12615680
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 27
    Top = 7
    Width = 128
    Height = 16
    Caption = 'Nome Concessionario:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 27
    Top = 32
    Width = 324
    Height = 21
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 62
    Top = 78
    Width = 87
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 226
    Top = 78
    Width = 87
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
    OnClick = BitBtn2Click
  end
end
