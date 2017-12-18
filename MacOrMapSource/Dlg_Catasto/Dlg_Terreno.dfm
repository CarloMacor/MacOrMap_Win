object Dlg_InfoTerreno: TDlg_InfoTerreno
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Info Terreno'
  ClientHeight = 174
  ClientWidth = 545
  Color = 8421440
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanTop: TPanel
    Left = 0
    Top = 0
    Width = 545
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Color = 8421440
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
    object Bot_Export: TSpeedButton
      Left = 464
      Top = 3
      Width = 49
      Height = 18
      AllowAllUp = True
      GroupIndex = 106
      Caption = 'Export'
      OnClick = Bot_ExportClick
    end
  end
  object PanLeft: TPanel
    Left = 0
    Top = 25
    Width = 13
    Height = 133
    Align = alLeft
    BevelOuter = bvNone
    Color = 8421440
    ParentBackground = False
    TabOrder = 1
  end
  object PanRight: TPanel
    Left = 532
    Top = 25
    Width = 13
    Height = 133
    Align = alRight
    BevelOuter = bvNone
    Color = 8421440
    ParentBackground = False
    TabOrder = 2
  end
  object PanBottom: TPanel
    Left = 0
    Top = 158
    Width = 545
    Height = 16
    Align = alBottom
    BevelOuter = bvNone
    Color = 8421440
    ParentBackground = False
    TabOrder = 3
  end
  object GrigliaDati: TStringGrid
    Left = 13
    Top = 25
    Width = 519
    Height = 133
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
      2
      34
      35
      91
      31
      64
      79
      73
      35
      31)
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    Filter = 'csv|*.csv'
    Left = 454
    Top = 110
  end
end
