object Form_Imu: TForm_Imu
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Imu'
  ClientHeight = 289
  ClientWidth = 932
  Color = 12615680
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
    Width = 932
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Color = 12615680
    ParentBackground = False
    TabOrder = 0
    object Bot_Associati: TSpeedButton
      Left = 41
      Top = 3
      Width = 41
      Height = 24
      AllowAllUp = True
      GroupIndex = 100
    end
    object Bot_NonAssociati: TSpeedButton
      Left = 88
      Top = 3
      Width = 41
      Height = 24
      AllowAllUp = True
      GroupIndex = 100
    end
  end
  object PanLeft: TPanel
    Left = 0
    Top = 33
    Width = 13
    Height = 246
    Align = alLeft
    BevelOuter = bvNone
    Color = 12615680
    ParentBackground = False
    TabOrder = 1
  end
  object GrigliaDati: TStringGrid
    Left = 13
    Top = 33
    Width = 906
    Height = 246
    ParentCustomHint = False
    Align = alClient
    BevelKind = bkFlat
    BiDiMode = bdLeftToRight
    Color = clWhite
    ColCount = 11
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
    ColWidths = (
      26
      111
      151
      168
      33
      37
      31
      40
      64
      60
      144)
  end
  object PanRight: TPanel
    Left = 919
    Top = 33
    Width = 13
    Height = 246
    Align = alRight
    BevelOuter = bvNone
    Color = 12615680
    ParentBackground = False
    TabOrder = 3
  end
  object PanBottom: TPanel
    Left = 0
    Top = 279
    Width = 932
    Height = 10
    Align = alBottom
    BevelOuter = bvNone
    Color = 12615680
    ParentBackground = False
    TabOrder = 4
  end
end
