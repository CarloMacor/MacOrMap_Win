object Form_AnagrafeSingola: TForm_AnagrafeSingola
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Residenti della Richiesta'
  ClientHeight = 178
  ClientWidth = 665
  Color = 10254943
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PanLeft: TPanel
    Left = 0
    Top = 8
    Width = 7
    Height = 160
    Align = alLeft
    BevelOuter = bvNone
    Color = 10254943
    ParentBackground = False
    TabOrder = 0
  end
  object PanBottom: TPanel
    Left = 0
    Top = 168
    Width = 665
    Height = 10
    Align = alBottom
    BevelOuter = bvNone
    Color = 10254943
    ParentBackground = False
    TabOrder = 1
  end
  object PanTop: TPanel
    Left = 0
    Top = 0
    Width = 665
    Height = 8
    Align = alTop
    BevelOuter = bvNone
    Color = 10254943
    ParentBackground = False
    TabOrder = 2
  end
  object PanRight: TPanel
    Left = 656
    Top = 8
    Width = 9
    Height = 160
    Align = alRight
    BevelOuter = bvNone
    Color = 10254943
    ParentBackground = False
    TabOrder = 3
  end
  object GrigliaDati: TStringGrid
    Left = 7
    Top = 8
    Width = 649
    Height = 160
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
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goThumbTracking]
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = False
    TabOrder = 4
    OnDrawCell = GrigliaDatiDrawCell
    ExplicitLeft = 8
    ColWidths = (
      33
      94
      100
      72
      166
      39
      117)
  end
end
