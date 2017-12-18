object Form_editPartConc: TForm_editPartConc
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Edit Particella Concessione'
  ClientHeight = 154
  ClientWidth = 438
  Color = 10440704
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
    Left = 14
    Top = 19
    Width = 23
    Height = 16
    Caption = 'Fg :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 144
    Top = 19
    Width = 32
    Height = 16
    Caption = 'Part :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 294
    Top = 19
    Width = 52
    Height = 16
    Caption = 'Mia Part:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 14
    Top = 60
    Width = 31
    Height = 16
    Caption = 'Sup :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 144
    Top = 60
    Width = 28
    Height = 16
    Caption = 'Cat :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 296
    Top = 60
    Width = 46
    Height = 16
    Caption = 'Classe :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit_Fg: TEdit
    Left = 58
    Top = 14
    Width = 61
    Height = 21
    TabOrder = 0
    Text = 'Edit_Fg'
  end
  object Edit_part: TEdit
    Left = 196
    Top = 14
    Width = 51
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit_miaPart: TEdit
    Left = 362
    Top = 14
    Width = 47
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit_Sup: TEdit
    Left = 58
    Top = 55
    Width = 61
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object Edit_cat: TEdit
    Left = 196
    Top = 55
    Width = 87
    Height = 21
    TabOrder = 4
    Text = 'Edit1'
  end
  object Edit_classe: TEdit
    Left = 362
    Top = 55
    Width = 47
    Height = 21
    TabOrder = 5
    Text = 'Edit1'
  end
  object BitBtn1: TBitBtn
    Left = 102
    Top = 104
    Width = 87
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 6
  end
  object BitBtn2: TBitBtn
    Left = 242
    Top = 104
    Width = 95
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 7
    OnClick = BitBtn2Click
  end
end
