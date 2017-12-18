object Form_contrattoConcessione: TForm_contrattoConcessione
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Contratto Concessione'
  ClientHeight = 349
  ClientWidth = 354
  Color = 12615680
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 118
    Top = 56
    Width = 91
    Height = 16
    Caption = 'Lista particelle :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 118
    Top = 5
    Width = 95
    Height = 16
    Caption = 'Concessionario :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object But_cancPart: TSpeedButton
    Left = 1
    Top = 332
    Width = 36
    Height = 18
    Caption = 'Erase'
    OnClick = But_cancPartClick
  end
  object Bot_editPart: TSpeedButton
    Left = 286
    Top = 54
    Width = 53
    Height = 18
    Caption = 'Edit'
    OnClick = Bot_editPartClick
  end
  object SpeedButton2: TSpeedButton
    Left = 313
    Top = 5
    Width = 23
    Height = 22
    Caption = '>'
    OnClick = SpeedButton2Click
  end
  object Bot_NonAssociati: TSpeedButton
    Left = 12
    Top = 51
    Width = 41
    Height = 21
    AllowAllUp = True
    Caption = 'Salva'
    OnClick = Bot_NonAssociatiClick
  end
  object Label11: TLabel
    Left = 12
    Top = 274
    Width = 67
    Height = 16
    Caption = 'Sup totale :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label12: TLabel
    Left = 182
    Top = 274
    Width = 127
    Height = 16
    Caption = 'la Sup. e'#39' Forfettaria :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object SpeedButton3: TSpeedButton
    Left = 298
    Top = 301
    Width = 41
    Height = 21
    AllowAllUp = True
    Caption = 'calcola'
    OnClick = SpeedButton3Click
  end
  object SpeedButton4: TSpeedButton
    Left = 288
    Top = 325
    Width = 51
    Height = 16
    AllowAllUp = True
    Caption = 'Svuota 0'
    OnClick = SpeedButton4Click
  end
  object SpeedButton5: TSpeedButton
    Left = 157
    Top = 273
    Width = 19
    Height = 21
    AllowAllUp = True
    Caption = 'fix'
    OnClick = SpeedButton5Click
  end
  object Edit_concessonario: TEdit
    Left = 12
    Top = 27
    Width = 324
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object ListBoxPart: TListBox
    Left = 366
    Top = 285
    Width = 315
    Height = 213
    ItemHeight = 13
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 366
    Top = 90
    Width = 417
    Height = 171
    BevelOuter = bvLowered
    Color = 12615680
    ParentBackground = False
    TabOrder = 2
    object Label2: TLabel
      Left = 16
      Top = 10
      Width = 88
      Height = 16
      Caption = 'Data Contratto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 253
      Top = 78
      Width = 50
      Height = 16
      Caption = 'Tributo :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 43
      Width = 100
      Height = 16
      Caption = 'Data Decorrenza:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 14
      Top = 75
      Width = 90
      Height = 16
      Caption = 'Data Scadenza:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 251
      Top = 14
      Width = 52
      Height = 16
      Caption = 'Delibera:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 16
      Top = 108
      Width = 39
      Height = 16
      Caption = 'Legge:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 225
      Top = 42
      Width = 82
      Height = 16
      Caption = 'Data Delibera:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 16
      Top = 140
      Width = 31
      Height = 16
      Caption = 'Info :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton
      Left = 376
      Top = 106
      Width = 23
      Height = 22
      Caption = 'DGRL'
      Visible = False
      OnClick = SpeedButton1Click
    end
    object Lab_nContratto: TLabel
      Left = 8
      Top = 5
      Width = 8
      Height = 16
      Caption = 'X'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Edit_dataContratto: TEdit
      Left = 318
      Top = 9
      Width = 77
      Height = 21
      Alignment = taRightJustify
      TabOrder = 0
    end
    object Edit_tributo: TEdit
      Left = 318
      Top = 73
      Width = 77
      Height = 21
      Alignment = taRightJustify
      TabOrder = 1
    end
    object Edit_dataDecorrenza: TEdit
      Left = 318
      Top = 42
      Width = 77
      Height = 21
      Alignment = taRightJustify
      TabOrder = 2
    end
    object Edit_DataScadenza: TEdit
      Left = 134
      Top = 72
      Width = 77
      Height = 21
      Alignment = taRightJustify
      TabOrder = 3
    end
    object Edit_Delibera: TEdit
      Left = 134
      Top = 9
      Width = 77
      Height = 21
      Alignment = taRightJustify
      TabOrder = 4
    end
    object Edit_Legge: TEdit
      Left = 134
      Top = 107
      Width = 233
      Height = 21
      TabOrder = 5
    end
    object Edit_DataDelibera: TEdit
      Left = 134
      Top = 41
      Width = 77
      Height = 21
      Alignment = taRightJustify
      TabOrder = 6
    end
    object Edit_Info: TEdit
      Left = 134
      Top = 136
      Width = 265
      Height = 21
      TabOrder = 7
    end
  end
  object BitBtn2: TBitBtn
    Left = 182
    Top = 307
    Width = 91
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object BitBtn1: TBitBtn
    Left = 58
    Top = 307
    Width = 91
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
    OnClick = BitBtn1Click
  end
  object GrigliaDati: TStringGrid
    Left = 12
    Top = 78
    Width = 327
    Height = 183
    ParentCustomHint = False
    BevelKind = bkFlat
    BiDiMode = bdLeftToRight
    Color = clBlack
    ColCount = 7
    Ctl3D = True
    DefaultRowHeight = 20
    DoubleBuffered = False
    FixedColor = 11038491
    FixedCols = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    GradientEndColor = 12692377
    GradientStartColor = 15775658
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColMoving]
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = False
    TabOrder = 5
    OnClick = GrigliaDatiClick
    OnDrawCell = GrigliaDatiDrawCell
    ColWidths = (
      26
      33
      36
      63
      77
      25
      28)
  end
  object EditSupTot: TEdit
    Left = 84
    Top = 271
    Width = 59
    Height = 21
    Alignment = taRightJustify
    TabOrder = 6
  end
  object Checksupforf: TCheckBox
    Left = 316
    Top = 273
    Width = 23
    Height = 17
    TabOrder = 7
  end
end
