object Form_Info: TForm_Info
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Info'
  ClientHeight = 251
  ClientWidth = 159
  Color = 11038491
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 63
    Top = 8
    Width = 33
    Height = 13
    Alignment = taCenter
    Caption = 'Piano :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Lab_Piano: TLabel
    Left = 15
    Top = 27
    Width = 49
    Height = 13
    Alignment = taCenter
    Caption = 'Lab_piano'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 57
    Top = 49
    Width = 45
    Height = 13
    Alignment = taCenter
    Caption = 'Disegno :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Lab_Disegno: TLabel
    Left = 15
    Top = 68
    Width = 36
    Height = 13
    Alignment = taCenter
    Caption = 'Lab_dis'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Bot_VaiPiano: TSpeedButton
    Left = 15
    Top = 147
    Width = 127
    Height = 22
    Caption = 'Vai al Piano'
    OnClick = Bot_VaiPianoClick
  end
  object BotAddsel: TSpeedButton
    Left = 15
    Top = 175
    Width = 127
    Height = 22
    Caption = 'Aggiungi ai selezionati'
    OnClick = BotAddselClick
  end
  object BotTogliSel: TSpeedButton
    Left = 15
    Top = 203
    Width = 127
    Height = 22
    Caption = 'Togli dai Selezionati'
    OnClick = BotTogliSelClick
  end
  object Bot_prec: TSpeedButton
    Left = 15
    Top = 119
    Width = 29
    Height = 22
    Caption = '<-'
    OnClick = Bot_precClick
  end
  object Bot_next: TSpeedButton
    Left = 116
    Top = 119
    Width = 26
    Height = 22
    Caption = '->'
    OnClick = Bot_nextClick
  end
  object Lab_contatore: TLabel
    Left = 73
    Top = 123
    Width = 16
    Height = 13
    Alignment = taCenter
    Caption = '1/1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Lab_Info: TLabel
    Left = 15
    Top = 92
    Width = 41
    Height = 13
    Alignment = taCenter
    Caption = 'Lab_info'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
end
