object Form_editIndirizzoAnagrafe: TForm_editIndirizzoAnagrafe
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Edit Indirizzo Anagrafico Famiglia'
  ClientHeight = 202
  ClientWidth = 310
  Color = 11038491
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
    Left = 24
    Top = 28
    Width = 47
    Height = 19
    Caption = 'Topo :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 60
    Width = 72
    Height = 19
    Caption = 'Indirizzo :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 92
    Width = 53
    Height = 19
    Caption = 'Civico :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit_topo: TEdit
    Left = 138
    Top = 26
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit_topo'
  end
  object Edit_via: TEdit
    Left = 138
    Top = 58
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit_civico: TEdit
    Left = 138
    Top = 90
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object BitBtn1: TBitBtn
    Left = 36
    Top = 148
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Left = 172
    Top = 148
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 4
    OnClick = BitBtn2Click
  end
end
