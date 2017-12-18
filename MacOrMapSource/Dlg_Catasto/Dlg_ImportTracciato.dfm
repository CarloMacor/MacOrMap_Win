object Form_Tracciato: TForm_Tracciato
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Import Tracciato Catasto'
  ClientHeight = 441
  ClientWidth = 566
  Color = 12615680
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 22
    Top = 47
    Width = 33
    Height = 19
    Caption = '.TER'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 28
    Top = 19
    Width = 211
    Height = 19
    Caption = 'Files Tracciato Catasto Terreni'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 22
    Top = 75
    Width = 29
    Height = 19
    Caption = '.TIT'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 18
    Top = 106
    Width = 37
    Height = 19
    Caption = '.SOG'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object But_Ter_TER: TSpeedButton
    Left = 94
    Top = 44
    Width = 145
    Height = 22
    OnClick = But_Ter_TERClick
  end
  object But_Ter_TIT: TSpeedButton
    Left = 94
    Top = 72
    Width = 145
    Height = 22
    OnClick = But_Ter_TITClick
  end
  object But_Ter_SOG: TSpeedButton
    Left = 94
    Top = 106
    Width = 145
    Height = 22
    OnClick = But_Ter_SOGClick
  end
  object But_AzionaTerreni: TSpeedButton
    Left = 340
    Top = 8
    Width = 137
    Height = 25
    Caption = 'Azione Base'
    OnClick = But_AzionaTerreniClick
  end
  object But_Anagrafe: TSpeedButton
    Left = 340
    Top = 39
    Width = 137
    Height = 25
    Caption = 'Anagrafe'
    OnClick = But_AnagrafeClick
  end
  object Bot_Tares: TSpeedButton
    Left = 340
    Top = 70
    Width = 137
    Height = 25
    Caption = 'Tares'
    OnClick = Bot_TaresClick
  end
  object But_Imu: TSpeedButton
    Left = 340
    Top = 101
    Width = 137
    Height = 25
    Caption = 'Imu'
    OnClick = But_ImuClick
  end
  object But_associa_IMU: TSpeedButton
    Left = 28
    Top = 261
    Width = 137
    Height = 25
    Caption = 'Associa Imu Fabbricato'
    OnClick = But_associa_IMUClick
  end
  object But_associa_Tares: TSpeedButton
    Left = 188
    Top = 261
    Width = 137
    Height = 25
    Caption = 'Associa Tares Fabbricato'
    OnClick = But_associa_TaresClick
  end
  object Bot_AnagAssociazione: TSpeedButton
    Left = 112
    Top = 305
    Width = 137
    Height = 25
    Caption = 'Associa Anagrafe'
    OnClick = Bot_AnagAssociazioneClick
  end
  object But_stessocivicoedif: TSpeedButton
    Left = 28
    Top = 336
    Width = 297
    Height = 25
    Caption = 'Associa civico fam se esiste un edificio con stesso civico'
    OnClick = But_stessocivicoedifClick
  end
  object But_DaImu: TSpeedButton
    Left = 28
    Top = 372
    Width = 297
    Height = 25
    Caption = 'Uso Imu senza Tares , se in indirizzo IMU prendo il fg part'
    OnClick = But_DaImuClick
  end
  object ListBox1: TListBox
    Left = 8
    Top = 134
    Width = 513
    Height = 102
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 0
  end
  object OpenCat: TOpenDialog
    Filter = 'TER|*.ter|TIT|*.tit|SOG|*.sog|FAB|*.fab'
    Left = 280
    Top = 16
  end
end
