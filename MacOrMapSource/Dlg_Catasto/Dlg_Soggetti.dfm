object Form_Soggetti: TForm_Soggetti
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Soggetti Proprietari'
  ClientHeight = 215
  ClientWidth = 808
  Color = 12615680
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
    Width = 782
    Height = 174
    ParentCustomHint = False
    Align = alClient
    BevelKind = bkFlat
    BiDiMode = bdLeftToRight
    Color = clWhite
    ColCount = 9
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
    OnClick = GrigliaDatiClick
    ColWidths = (
      20
      111
      244
      26
      76
      114
      67
      48
      34)
  end
  object PanBottom: TPanel
    Left = 0
    Top = 205
    Width = 808
    Height = 10
    Align = alBottom
    BevelOuter = bvNone
    Color = 12615680
    ParentBackground = False
    TabOrder = 1
  end
  object PanLeft: TPanel
    Left = 0
    Top = 31
    Width = 13
    Height = 174
    Align = alLeft
    BevelOuter = bvNone
    Color = 12615680
    ParentBackground = False
    TabOrder = 2
  end
  object PanRight: TPanel
    Left = 795
    Top = 31
    Width = 13
    Height = 174
    Align = alRight
    BevelOuter = bvNone
    Color = 12615680
    ParentBackground = False
    TabOrder = 3
  end
  object PanTop: TPanel
    Left = 0
    Top = 0
    Width = 808
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    Color = 12615680
    ParentBackground = False
    TabOrder = 4
    object Bot_Case: TSpeedButton
      Left = 31
      Top = 5
      Width = 50
      Height = 24
      AllowAllUp = True
      GroupIndex = 100
      Caption = 'Fabb'
      OnClick = Bot_CaseClick
    end
    object Bot_Terreni: TSpeedButton
      Left = 87
      Top = 5
      Width = 51
      Height = 24
      AllowAllUp = True
      GroupIndex = 100
      Caption = 'Terreni'
      OnClick = Bot_TerreniClick
    end
  end
end
