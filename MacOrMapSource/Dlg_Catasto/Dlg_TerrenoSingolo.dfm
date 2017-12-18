object Form_TerrenoSingolo: TForm_TerrenoSingolo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Info Terreno Selezionato'
  ClientHeight = 106
  ClientWidth = 525
  Color = 10921555
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PanTop: TPanel
    Left = 0
    Top = 0
    Width = 525
    Height = 16
    Align = alTop
    BevelOuter = bvNone
    Color = 10921555
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 13
      Top = 3
      Width = 31
      Height = 13
      Caption = 'Label1'
      Visible = False
    end
    object Label2: TLabel
      Left = 76
      Top = 3
      Width = 31
      Height = 13
      Caption = 'Label1'
      Visible = False
    end
  end
  object PanLeft: TPanel
    Left = 0
    Top = 16
    Width = 13
    Height = 74
    Align = alLeft
    BevelOuter = bvNone
    Color = 10921555
    ParentBackground = False
    TabOrder = 1
  end
  object PanRight: TPanel
    Left = 512
    Top = 16
    Width = 13
    Height = 74
    Align = alRight
    BevelOuter = bvNone
    Color = 10921555
    ParentBackground = False
    TabOrder = 2
  end
  object PanBottom: TPanel
    Left = 0
    Top = 90
    Width = 525
    Height = 16
    Align = alBottom
    BevelOuter = bvNone
    Color = 10921555
    ParentBackground = False
    TabOrder = 3
  end
  object GrigliaDati: TStringGrid
    Left = 13
    Top = 16
    Width = 499
    Height = 74
    ParentCustomHint = False
    Align = alClient
    BevelKind = bkFlat
    BiDiMode = bdLeftToRight
    Color = clWhite
    ColCount = 10
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
    TabOrder = 4
    OnClick = GrigliaDatiClick
    OnDrawCell = GrigliaDatiDrawCell
    ColWidths = (
      3
      34
      35
      91
      31
      64
      79
      73
      27
      24)
  end
end
