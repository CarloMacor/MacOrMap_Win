object Form_PossessiTutti: TForm_PossessiTutti
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Tutti i Possessi'
  ClientHeight = 290
  ClientWidth = 664
  Color = 7682560
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GrigliaDati: TStringGrid
    Left = 13
    Top = 31
    Width = 638
    Height = 249
    ParentCustomHint = False
    Align = alClient
    BevelKind = bkFlat
    BiDiMode = bdLeftToRight
    Color = clWhite
    ColCount = 7
    Ctl3D = True
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
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColMoving, goThumbTracking]
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = False
    TabOrder = 0
    ColWidths = (
      67
      62
      25
      56
      76
      211
      64)
  end
  object PanBottom: TPanel
    Left = 0
    Top = 280
    Width = 664
    Height = 10
    Align = alBottom
    BevelOuter = bvNone
    Color = 7682560
    ParentBackground = False
    TabOrder = 1
  end
  object PanLeft: TPanel
    Left = 0
    Top = 31
    Width = 13
    Height = 249
    Align = alLeft
    BevelOuter = bvNone
    Color = 7682560
    ParentBackground = False
    TabOrder = 2
  end
  object PanRight: TPanel
    Left = 651
    Top = 31
    Width = 13
    Height = 249
    Align = alRight
    BevelOuter = bvNone
    Color = 7682560
    ParentBackground = False
    TabOrder = 3
  end
  object PanTop: TPanel
    Left = 0
    Top = 0
    Width = 664
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    Color = 7682560
    ParentBackground = False
    TabOrder = 4
    object Bot_Case: TSpeedButton
      Left = 28
      Top = 4
      Width = 41
      Height = 24
      AllowAllUp = True
      GroupIndex = 100
      Caption = 'Fabb'
      OnClick = Bot_CaseClick
    end
    object Bot_Terreni: TSpeedButton
      Left = 84
      Top = 4
      Width = 53
      Height = 24
      AllowAllUp = True
      GroupIndex = 100
      Caption = 'Terreni'
      OnClick = Bot_TerreniClick
    end
    object Label1: TLabel
      Left = 220
      Top = 8
      Width = 106
      Height = 16
      Caption = 'Numero Possessi :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Lab_numPos: TLabel
      Left = 340
      Top = 9
      Width = 14
      Height = 16
      Caption = 'nn'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
end
