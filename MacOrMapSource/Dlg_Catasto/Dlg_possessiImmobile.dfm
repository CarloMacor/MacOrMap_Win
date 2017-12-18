object Form_PossessiImmobile: TForm_PossessiImmobile
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Possessi dell'#39' Immobile'
  ClientHeight = 158
  ClientWidth = 975
  Color = 8279060
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
    Width = 949
    Height = 139
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
    ColWidths = (
      164
      105
      117
      57
      154
      36
      41
      36
      196)
  end
  object PanBottom: TPanel
    Left = 0
    Top = 148
    Width = 975
    Height = 10
    Align = alBottom
    BevelOuter = bvNone
    Color = 8279060
    ParentBackground = False
    TabOrder = 1
  end
  object PanLeft: TPanel
    Left = 0
    Top = 9
    Width = 13
    Height = 139
    Align = alLeft
    BevelOuter = bvNone
    Color = 8279060
    ParentBackground = False
    TabOrder = 2
  end
  object PanRight: TPanel
    Left = 962
    Top = 9
    Width = 13
    Height = 139
    Align = alRight
    BevelOuter = bvNone
    Color = 8279060
    ParentBackground = False
    TabOrder = 3
  end
  object PanTop: TPanel
    Left = 0
    Top = 0
    Width = 975
    Height = 9
    Align = alTop
    BevelOuter = bvNone
    Color = 8279060
    ParentBackground = False
    TabOrder = 4
  end
end
