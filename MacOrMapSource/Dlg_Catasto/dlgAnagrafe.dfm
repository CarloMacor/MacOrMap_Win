object FormAnagrafe: TFormAnagrafe
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Anagrafe'
  ClientHeight = 303
  ClientWidth = 994
  Color = 11038491
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanLeft: TPanel
    Left = 0
    Top = 41
    Width = 13
    Height = 246
    Align = alLeft
    BevelOuter = bvNone
    Color = 11038491
    ParentBackground = False
    TabOrder = 0
  end
  object PanBottom: TPanel
    Left = 0
    Top = 287
    Width = 994
    Height = 16
    Align = alBottom
    BevelOuter = bvNone
    Color = 11038491
    ParentBackground = False
    TabOrder = 1
  end
  object PanTop: TPanel
    Left = 0
    Top = 0
    Width = 994
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = 11038491
    ParentBackground = False
    TabOrder = 2
    object SpeedButton3: TSpeedButton
      Left = 101
      Top = 8
      Width = 80
      Height = 22
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Residenti'
      OnClick = SpeedButton3Click
    end
    object SpeedButton6: TSpeedButton
      Left = 17
      Top = 8
      Width = 78
      Height = 22
      AllowAllUp = True
      GroupIndex = 1
      Down = True
      Caption = 'Famiglie'
      OnClick = SpeedButton6Click
    end
    object SpeedButton1: TSpeedButton
      Left = 208
      Top = 8
      Width = 59
      Height = 22
      AllowAllUp = True
      GroupIndex = 2
      Caption = 'Filtrati'
      Visible = False
    end
    object But_Info: TSpeedButton
      Left = 926
      Top = 8
      Width = 53
      Height = 22
      Caption = 'Info'
      OnClick = But_InfoClick
    end
    object But_Edit: TSpeedButton
      Left = 384
      Top = 8
      Width = 95
      Height = 22
      Caption = 'Edit Fg.Part.Sub.'
      OnClick = But_EditClick
    end
    object Bot_export1: TSpeedButton
      Left = 592
      Top = 8
      Width = 85
      Height = 22
      Caption = 'Export snc'
      OnClick = Bot_export1Click
    end
    object Bot_export2: TSpeedButton
      Left = 698
      Top = 8
      Width = 95
      Height = 22
      Caption = 'Export Associare'
      OnClick = Bot_export2Click
    end
    object but_editVia: TSpeedButton
      Left = 278
      Top = 8
      Width = 95
      Height = 22
      Caption = 'Edit via'
      OnClick = but_editViaClick
    end
    object SpeedButton2: TSpeedButton
      Left = 520
      Top = 8
      Width = 57
      Height = 22
      Caption = 'Export'
      OnClick = SpeedButton2Click
    end
  end
  object PanRight: TPanel
    Left = 982
    Top = 41
    Width = 12
    Height = 246
    Align = alRight
    BevelOuter = bvNone
    Color = 11038491
    ParentBackground = False
    TabOrder = 3
  end
  object GrigliaDati: TStringGrid
    Left = 13
    Top = 41
    Width = 969
    Height = 246
    ParentCustomHint = False
    Align = alClient
    BevelKind = bkFlat
    BiDiMode = bdLeftToRight
    Color = clWhite
    ColCount = 17
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
    OnClick = GrigliaDatiClick
    OnDblClick = GrigliaDatiDblClick
    OnDrawCell = GrigliaDatiDrawCell
    ColWidths = (
      33
      94
      100
      72
      166
      39
      30
      24
      23
      28
      29
      28
      29
      123
      34
      31
      31)
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    Filter = 'csv|*.csv'
    Left = 952
    Top = 258
  end
end
