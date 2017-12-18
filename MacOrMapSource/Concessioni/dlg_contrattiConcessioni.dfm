object Form_contrattiConcessioni: TForm_contrattiConcessioni
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Contratti Concessioni'
  ClientHeight = 193
  ClientWidth = 428
  Color = 12615680
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanTop: TPanel
    Left = 0
    Top = 0
    Width = 428
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 552
    object Bot_Add: TSpeedButton
      Left = 41
      Top = 3
      Width = 41
      Height = 24
      AllowAllUp = True
      GroupIndex = 100
      Caption = '+'
      OnClick = Bot_AddClick
    end
    object Bot_NonAssociati: TSpeedButton
      Left = 142
      Top = 3
      Width = 41
      Height = 24
      AllowAllUp = True
      GroupIndex = 100
      Caption = '-'
      OnClick = Bot_NonAssociatiClick
    end
  end
  object PanLeft: TPanel
    Left = 0
    Top = 33
    Width = 13
    Height = 150
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
  end
  object GrigliaDati: TStringGrid
    Left = 13
    Top = 33
    Width = 402
    Height = 150
    ParentCustomHint = False
    Align = alClient
    BevelKind = bkFlat
    BiDiMode = bdLeftToRight
    Color = clBlack
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
    OnClick = GrigliaDatiClick
    OnDblClick = GrigliaDatiDblClick
    OnDrawCell = GrigliaDatiDrawCell
    ExplicitWidth = 526
    ColWidths = (
      26
      220
      3
      4
      35
      3
      37
      33)
  end
  object PanRight: TPanel
    Left = 415
    Top = 33
    Width = 13
    Height = 150
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitLeft = 539
  end
  object PanBottom: TPanel
    Left = 0
    Top = 183
    Width = 428
    Height = 10
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitWidth = 552
  end
end
