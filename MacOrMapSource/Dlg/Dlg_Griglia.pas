unit Dlg_Griglia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm_Griglia = class(TForm)
    Comb_Utm84: TComboBox;
    ColDialog: TColorDialog;
    Panel1: TPanel;
    Bot_Utm84: TSpeedButton;
    Bot_Sfe84: TSpeedButton;
    Bot_Utm50: TSpeedButton;
    Bot_Sfe50: TSpeedButton;
    Bot_Cassini: TSpeedButton;
    Comb_Sfe84: TComboBox;
    Panel2: TPanel;
    Comb_Utm50: TComboBox;
    Panel3: TPanel;
    Comb_Sfe50: TComboBox;
    Panel4: TPanel;
    Comb_Cassini: TComboBox;
    Panel5: TPanel;
    procedure Bot_Utm84Click(Sender: TObject);
    procedure Comb_Utm84Change(Sender: TObject);
    procedure Bot_Sfe84Click(Sender: TObject);
    procedure Comb_Sfe84Change(Sender: TObject);
    procedure Bot_Utm50Click(Sender: TObject);
    procedure Comb_Utm50Change(Sender: TObject);
    procedure Bot_Sfe50Click(Sender: TObject);
    procedure Bot_CassiniClick(Sender: TObject);
    procedure Comb_Sfe50Change(Sender: TObject);
    procedure Comb_CassiniChange(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
    procedure Panel5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Griglia: TForm_Griglia;

implementation

{$R *.dfm}
 uses interfaccia,varbase;

{
      B_Griglia_Utm84   := false;
      B_Griglia_Utm50   := false;
      B_Griglia_Sfer84  := false;
      B_Griglia_Sfer50  := false;
      B_Griglia_cassini := false;

}
procedure TForm_Griglia.Bot_Utm50Click(Sender: TObject);
begin
 B_Griglia_Utm50 := Bot_Utm50.Down;
 ridisegna;
end;

procedure TForm_Griglia.Bot_Utm84Click(Sender: TObject);
begin
 B_Griglia_Utm84 := Bot_Utm84.Down;
 ridisegna;
end;

procedure TForm_Griglia.Comb_CassiniChange(Sender: TObject);
begin
 opzioneGr5:=Comb_Cassini.ItemIndex;
 ridisegna;
end;

procedure TForm_Griglia.Comb_Sfe50Change(Sender: TObject);
begin
 opzioneGr4:=Comb_Sfe50.ItemIndex;
 ridisegna;
end;

procedure TForm_Griglia.Comb_Sfe84Change(Sender: TObject);
begin
 opzioneGr2:=Comb_Sfe84.ItemIndex;
 ridisegna;
end;

procedure TForm_Griglia.Comb_Utm50Change(Sender: TObject);
begin
 opzioneGr3:=Comb_Utm50.ItemIndex;
 ridisegna;
end;

procedure TForm_Griglia.Comb_Utm84Change(Sender: TObject);
begin
 opzioneGr1:=Comb_Utm84.ItemIndex;
 ridisegna;
end;

procedure TForm_Griglia.FormCreate(Sender: TObject);
begin
 Panel1.Color:= GridColor1;
 Panel2.Color:= GridColor2;
 Panel3.Color:= GridColor3;
 Panel4.Color:= GridColor4;
 Panel5.Color:= GridColor5;
end;

procedure TForm_Griglia.Panel1Click(Sender: TObject);
begin
 if ColDialog.Execute then
  begin  GridColor1 := ColDialog.Color;  Panel1.Color:= GridColor1;  ridisegna;  end;
end;

procedure TForm_Griglia.Panel2Click(Sender: TObject);
begin
 if ColDialog.Execute then
  begin  GridColor2 := ColDialog.Color;  Panel2.Color:= GridColor2;  ridisegna;  end;
end;

procedure TForm_Griglia.Panel3Click(Sender: TObject);
begin
 if ColDialog.Execute then
  begin  GridColor3 := ColDialog.Color;  Panel3.Color:= GridColor3;  ridisegna;  end;
end;

procedure TForm_Griglia.Panel4Click(Sender: TObject);
begin
 if ColDialog.Execute then
  begin  GridColor4 := ColDialog.Color;  Panel4.Color:= GridColor4;  ridisegna;  end;
end;

procedure TForm_Griglia.Panel5Click(Sender: TObject);
begin
 if ColDialog.Execute then
  begin  GridColor5 := ColDialog.Color;  Panel5.Color:= GridColor5;  ridisegna;  end;
end;

procedure TForm_Griglia.Bot_CassiniClick(Sender: TObject);
begin
 B_Griglia_cassini := Bot_Cassini.Down;
 ridisegna;
end;

procedure TForm_Griglia.Bot_Sfe50Click(Sender: TObject);
begin
 B_Griglia_Sfer50 := Bot_Sfe50.Down;
 ridisegna;
end;

procedure TForm_Griglia.Bot_Sfe84Click(Sender: TObject);
begin
 B_Griglia_Sfer84 := Bot_Sfe84.Down;
 ridisegna;
end;

end.
