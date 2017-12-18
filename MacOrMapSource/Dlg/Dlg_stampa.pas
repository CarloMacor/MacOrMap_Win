unit Dlg_stampa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm_Stampa = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Editcmx: TEdit;
    Editcmy: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ComboScala: TComboBox;
    SpeedButton4: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Label3: TLabel;
    Combodpi: TComboBox;
    Label4: TLabel;
    BotOr: TSpeedButton;
    BotVert: TSpeedButton;
    Labxr: TLabel;
    Labyr: TLabel;
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BotOrClick(Sender: TObject);
    procedure BotVertClick(Sender: TObject);
  private
    { Private declarations }
  public
    orizon : Boolean;
    { Public declarations }
  end;

var
  Form_Stampa: TForm_Stampa;

implementation

{$R *.dfm}
uses varbase, progetto,interfaccia;


procedure TForm_Stampa.FormCreate(Sender: TObject);
begin
 orizon := true;
end;

procedure TForm_Stampa.SpeedButton1Click(Sender: TObject);
begin
  if orizon then begin
               Labxr.Caption := '29.7'; Labyr.Caption := '21.0';
               Editcmx.text := '28.2';  Editcmy.text := '19.5';
              end
            else begin
               Labxr.Caption := '21.0'; Labyr.Caption := '29.7';
               Editcmx.text := '19.5';  Editcmy.text := '28.2';
              end;
end;

procedure TForm_Stampa.SpeedButton2Click(Sender: TObject);
begin
  if orizon then begin
               Labxr.Caption := '42.0'; Labyr.Caption := '29.7';
               Editcmx.text := '40.0';  Editcmy.text := '27.7';
              end
            else begin
               Labxr.Caption := '29.7'; Labyr.Caption := '42.0';
               Editcmx.text := '27.7';  Editcmy.text := '40.0';
              end;
end;

procedure TForm_Stampa.SpeedButton3Click(Sender: TObject);
begin
  if orizon then begin
               Labxr.Caption := '59.4'; Labyr.Caption := '42.0';
               Editcmx.text := '56.9';  Editcmy.text := '39.5';
              end
            else begin
               Labxr.Caption := '42.0'; Labyr.Caption := '59.4';
               Editcmx.text := '39.5';  Editcmy.text := '56.9';
              end;
end;

procedure TForm_Stampa.SpeedButton4Click(Sender: TObject);
begin
 primovirtRetstampa:= true;
 ilProgetto.IniziaComando(kStato_DefStampa);
 ilProgetto.inizializzaVistaDefStampa(Editcmx.text, Editcmy.text, ComboScala.Text, Combodpi.Text );
 close;
 ridisegna;
end;

procedure TForm_Stampa.SpeedButton5Click(Sender: TObject);
begin
  if orizon then begin
              Labxr.Caption := '84.0'; Labyr.Caption := '59.4';
              Editcmx.text := '81.0';  Editcmy.text := '56.4';
             end
            else begin
              Labxr.Caption := '59.4'; Labyr.Caption := '84.0';
              Editcmx.text := '56.4';  Editcmy.text := '81.0';
             end;
end;

procedure TForm_Stampa.SpeedButton6Click(Sender: TObject);
begin
  if orizon then begin
              Labxr.Caption := '108.8'; Labyr.Caption := '84.0';
              Editcmx.text := '105.3';  Editcmy.text := '80.5';
             end
            else begin
              Labxr.Caption := '84.0';  Labyr.Caption := '108.8';
              Editcmy.text := '80.5';   Editcmx.text := '105.3';
             end;
end;

procedure TForm_Stampa.BotOrClick(Sender: TObject);
var passastr : String;
begin
 if not orizon then
  begin
   passastr := Editcmx.text;   Editcmx.text  := Editcmy.text;    Editcmy.text:=passastr;
   passastr := Labxr.Caption;  Labxr.Caption := Labyr.Caption;   Labyr.Caption:=passastr;
  end;
 orizon := true;
end;

procedure TForm_Stampa.BotVertClick(Sender: TObject);
var passastr : String;
begin
 if orizon then
  begin
   passastr := Editcmx.text;   Editcmx.text  := Editcmy.text;    Editcmy.text:=passastr;
   passastr := Labxr.Caption;  Labxr.Caption := Labyr.Caption;   Labyr.Caption:=passastr;
  end;
  orizon := false;
end;

end.
