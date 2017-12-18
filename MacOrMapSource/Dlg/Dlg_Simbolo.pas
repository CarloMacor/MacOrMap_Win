unit Dlg_Simbolo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, GR32_Image,
  Vcl.ExtCtrls;

type
  TForm_Simbolo = class(TForm)
    ComboNomiDef: TComboBox;
    Label3: TLabel;
    Bot_Txtorizzontale: TSpeedButton;
    Label4: TLabel;
    Bot_TxtRuotato: TSpeedButton;
    Label5: TLabel;
    Bot_TxtRotoScalato: TSpeedButton;
    Panel1: TPanel;
    Image321: TImage32;
    procedure FormShow(Sender: TObject);
    procedure ComboNomiDefChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Bot_TxtRuotatoClick(Sender: TObject);
    procedure Bot_TxtorizzontaleClick(Sender: TObject);
    procedure Bot_TxtRotoScalatoClick(Sender: TObject);
  private
    { Private declarations }
  public
    indicesimbolo : Integer;
    procedure aziona(modo : Integer);
    procedure disegnasimbolo(ind : Integer);
    { Public declarations }
  end;

var
  Form_Simbolo: TForm_Simbolo;

implementation

{$R *.dfm}
uses Progetto,listadefSimboli,defsimbolo,varbase;

procedure TForm_Simbolo.Bot_TxtorizzontaleClick(Sender: TObject);
begin
 aziona(1);
end;

procedure TForm_Simbolo.Bot_TxtRotoScalatoClick(Sender: TObject);
begin
 aziona(3);
end;

procedure TForm_Simbolo.Bot_TxtRuotatoClick(Sender: TObject);
begin
 aziona(2);
end;

procedure TForm_Simbolo.ComboNomiDefChange(Sender: TObject);
begin
 indicesimbolo:=ComboNomiDef.itemindex;
 disegnasimbolo(ComboNomiDef.itemindex);
end;

procedure TForm_Simbolo.disegnasimbolo(ind : Integer);
var  locdef : TDefSimbolo;
     loclistadefsimboli : TlistaDefSimboli;
begin
 loclistadefsimboli := Ilprogetto.LelisteDefSimboli.items[0];
 locdef := loclistadefsimboli.listaDefinizioni.Items[ind];
 locdef.disegnadef(Image321);
end;


procedure TForm_Simbolo.FormCreate(Sender: TObject);
begin
  Image321.SetupBitmap;
  indicesimbolo := 0;
end;

procedure TForm_Simbolo.FormShow(Sender: TObject);
var loclistadefsimboli : TlistaDefSimboli;
    k : integer;
    locdef : TDefSimbolo;
begin
 xmom:=-1000;   ymom:=-1000; angmom :=0.0;  scamom:=1.0;
 xprecVirt := -1000.0;   yprecVirt := -1000.0;
 ComboNomiDef.Clear;

 if Ilprogetto.LelisteDefSimboli.Count>0 then
  begin
   loclistadefsimboli := Ilprogetto.LelisteDefSimboli.items[0];
   for k:=0 to loclistadefsimboli.listaDefinizioni.Count-1 do
    begin
     locdef := loclistadefsimboli.listaDefinizioni.Items[k];
     ComboNomiDef.Items.Add(locdef.nome);
    end;
  end
   else
  begin
    beep;
  end;
 ComboNomiDef.itemindex:=indicesimbolo;
 if indicesimbolo<ComboNomiDef.Items.Count then disegnasimbolo(ComboNomiDef.itemindex);
end;


procedure TForm_Simbolo.aziona(modo : Integer);
var  locdef : TDefSimbolo;
     loclistadefsimboli : TlistaDefSimboli;
begin
 if Ilprogetto.LelisteDefSimboli.Count>0 then
  begin
   loclistadefsimboli := Ilprogetto.LelisteDefSimboli.items[0];
   SimboloVirtuale    := loclistadefsimboli.listaDefinizioni.Items[indicesimbolo];
   case modo of
    1 : ilProgetto.IniziaComando(kStato_Simbolo);
    2 : ilProgetto.IniziaComando(kStato_SimboloRot);
    3 : ilProgetto.IniziaComando(kStato_SimboloRotSca);
    else    ilProgetto.IniziaComando(kStato_nulla);
   end;
  end;
  close;
end;


end.
