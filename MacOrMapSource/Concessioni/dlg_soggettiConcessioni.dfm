object Form_sogConc: TForm_sogConc
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Soggetti delle Concessioni'
  ClientHeight = 297
  ClientWidth = 383
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
    Width = 383
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Bot_Add: TSpeedButton
      Left = 19
      Top = 3
      Width = 41
      Height = 24
      AllowAllUp = True
      Caption = '+'
      OnClick = Bot_AddClick
    end
    object Bot_NonAssociati: TSpeedButton
      Left = 323
      Top = 3
      Width = 41
      Height = 24
      AllowAllUp = True
      Caption = 'Salva'
      OnClick = Bot_NonAssociatiClick
    end
    object But_edit: TSpeedButton
      Left = 66
      Top = 3
      Width = 41
      Height = 24
      AllowAllUp = True
      Caption = 'Edit'
      OnClick = But_editClick
    end
    object But_Alfab: TSpeedButton
      Left = 210
      Top = 3
      Width = 59
      Height = 24
      AllowAllUp = True
      Caption = 'Alfabetico'
      OnClick = But_AlfabClick
    end
    object SpeedButton1: TSpeedButton
      Left = 277
      Top = 3
      Width = 28
      Height = 24
      AllowAllUp = True
      Caption = 'Gr'
      OnClick = SpeedButton1Click
    end
    object But_Export: TSpeedButton
      Left = 116
      Top = 3
      Width = 59
      Height = 24
      AllowAllUp = True
      Caption = 'Export'
      OnClick = But_ExportClick
    end
  end
  object PanLeft: TPanel
    Left = 0
    Top = 33
    Width = 13
    Height = 254
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
  end
  object GrigliaDati: TStringGrid
    Left = 13
    Top = 33
    Width = 357
    Height = 254
    ParentCustomHint = False
    Align = alClient
    BevelKind = bkFlat
    BiDiMode = bdLeftToRight
    Color = clBlack
    ColCount = 4
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
    ColWidths = (
      26
      215
      43
      37)
  end
  object PanRight: TPanel
    Left = 370
    Top = 33
    Width = 13
    Height = 254
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 3
  end
  object PanBottom: TPanel
    Left = 0
    Top = 287
    Width = 383
    Height = 10
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
  end
end
