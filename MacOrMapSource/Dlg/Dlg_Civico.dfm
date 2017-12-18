object Form_txtCivico: TForm_txtCivico
  Left = 177
  Top = 124
  BorderIcons = [biSystemMenu]
  Caption = 'Numero Civico'
  ClientHeight = 107
  ClientWidth = 200
  Color = 11235867
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 36
    Top = 22
    Width = 42
    Height = 16
    Caption = 'Civico :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit_nrCiv: TEdit
    Left = 96
    Top = 21
    Width = 61
    Height = 21
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 60
    Top = 64
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
end
