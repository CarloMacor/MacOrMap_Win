object Form_EditFgAnagrafe: TForm_EditFgAnagrafe
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Edit Fg Part Sub    Anagrafe'
  ClientHeight = 203
  ClientWidth = 300
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
    Width = 54
    Height = 19
    Caption = 'Foglio :'
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
    Width = 74
    Height = 19
    Caption = 'Particella :'
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
    Width = 87
    Height = 19
    Caption = 'Subalterno :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit_fg: TEdit
    Left = 138
    Top = 26
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit_fg'
  end
  object Edit_part: TEdit
    Left = 138
    Top = 58
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit_sub: TEdit
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
