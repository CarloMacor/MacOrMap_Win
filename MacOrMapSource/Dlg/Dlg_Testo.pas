unit Dlg_Testo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls;

type
  TForm_Text = class(TForm)
    Label1: TLabel;
    EditTxt: TEdit;
    Label2: TLabel;
    EditAltezza: TEdit;
    Bot_Txtorizzontale: TSpeedButton;
    Bot_TxtRuotato: TSpeedButton;
    Bot_TxtRotoScalato: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Bot_TxtRuotatoClick(Sender: TObject);
    procedure Bot_TxtRotoScalatoClick(Sender: TObject);
    procedure Bot_TxtorizzontaleClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
   procedure aziona(modo : Integer);
    { Public declarations }
  end;

var
  Form_Text: TForm_Text;

implementation

{$R *.dfm}

uses Progetto,varbase;


procedure TForm_Text.aziona(modo : Integer);
var alto : Real;
    coda : Integer;
begin
 if EditTxt.Text='' then exit;
 val (EditAltezza.Text,alto,coda);
 if coda=0 then
  begin
   case modo of
    1 : ilProgetto.IniziaComando(kStato_Testo);
    2 : ilProgetto.IniziaComando(kStato_TestoRuotato);
    3 : ilProgetto.IniziaComando(kStato_TestoRotoScalato);
    else    ilProgetto.IniziaComando(kStato_nulla);
   end;
   altezzatesto_InInserimento := alto*parahTesto;
   testoTxt_InInserimento := EditTxt.Text;
   close;
  end;
end;


procedure TForm_Text.Bot_TxtRuotatoClick(Sender: TObject);
begin
 aziona(2);
end;

procedure TForm_Text.FormShow(Sender: TObject);
begin
 xmom:=-1000;   ymom:=-1000; angmom :=0.0;  scamom:=1.0;
 xprecVirt := -1000.0;   yprecVirt := -1000.0;
end;

procedure TForm_Text.Bot_TxtorizzontaleClick(Sender: TObject);
begin
 aziona(1);
end;

procedure TForm_Text.Bot_TxtRotoScalatoClick(Sender: TObject);
begin
 aziona(3);
end;

end.
