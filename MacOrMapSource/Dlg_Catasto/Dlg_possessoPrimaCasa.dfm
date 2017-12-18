object Form_PossessoPrimaCasa: TForm_PossessoPrimaCasa
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Possesso Prima Casa'
  ClientHeight = 117
  ClientWidth = 572
  Color = 10189150
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GrigliaDati: TStringGrid
    Left = 13
    Top = 9
    Width = 546
    Height = 98
    ParentCustomHint = False
    Align = alClient
    BevelKind = bkFlat
    BiDiMode = bdLeftToRight
    Color = clWhite
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
      92
      100
      113
      56
      149)
  end
  object PanBottom: TPanel
    Left = 0
    Top = 107
    Width = 572
    Height = 10
    Align = alBottom
    BevelOuter = bvNone
    Color = 10189150
    ParentBackground = False
    TabOrder = 1
  end
  object PanLeft: TPanel
    Left = 0
    Top = 9
    Width = 13
    Height = 98
    Align = alLeft
    BevelOuter = bvNone
    Color = 10189150
    ParentBackground = False
    TabOrder = 2
  end
  object PanRight: TPanel
    Left = 559
    Top = 9
    Width = 13
    Height = 98
    Align = alRight
    BevelOuter = bvNone
    Color = 10189150
    ParentBackground = False
    TabOrder = 3
  end
  object PanTop: TPanel
    Left = 0
    Top = 0
    Width = 572
    Height = 9
    Align = alTop
    BevelOuter = bvNone
    Color = 10189150
    ParentBackground = False
    TabOrder = 4
  end
end
