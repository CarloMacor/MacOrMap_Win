object Form_TaresSingola: TForm_TaresSingola
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Tares della Richiesta'
  ClientHeight = 160
  ClientWidth = 679
  Color = 11506554
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
    Width = 679
    Height = 12
    Align = alTop
    BevelOuter = bvNone
    Color = 11506554
    ParentBackground = False
    TabOrder = 0
  end
  object PanLeft: TPanel
    Left = 0
    Top = 12
    Width = 13
    Height = 138
    Align = alLeft
    BevelOuter = bvNone
    Color = 11506554
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 14
  end
  object GrigliaDati: TStringGrid
    Left = 13
    Top = 12
    Width = 653
    Height = 138
    ParentCustomHint = False
    Align = alClient
    BevelKind = bkFlat
    BiDiMode = bdLeftToRight
    Color = clWhite
    ColCount = 8
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
    TabOrder = 2
    OnDrawCell = GrigliaDatiDrawCell
    ColWidths = (
      103
      111
      151
      31
      32
      31
      31
      120)
  end
  object PanRight: TPanel
    Left = 666
    Top = 12
    Width = 13
    Height = 138
    Align = alRight
    BevelOuter = bvNone
    Color = 11506554
    ParentBackground = False
    TabOrder = 3
  end
  object PanBottom: TPanel
    Left = 0
    Top = 150
    Width = 679
    Height = 10
    Align = alBottom
    BevelOuter = bvNone
    Color = 11506554
    ParentBackground = False
    TabOrder = 4
  end
end
