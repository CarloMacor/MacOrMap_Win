unit dlg_EditIndirizzo_Anagrafe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm_editIndirizzoAnagrafe = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit_topo: TEdit;
    Edit_via: TEdit;
    Edit_civico: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    indiceListaAnagrafe : Integer;
    modoFamiglia   : Integer;
  end;

var
  Form_editIndirizzoAnagrafe: TForm_editIndirizzoAnagrafe;

implementation

{$R *.dfm}

uses Anagrafe, famiglia,residente,immobilidati,varbase;

procedure TForm_editIndirizzoAnagrafe.BitBtn2Click(Sender: TObject);
var locFam : TFamiglia;
    locres : TResidente;
begin
 case modoFamiglia of
  0 : begin
   locFam := LaAnagrafe.listaFamiglie.Items[indiceListaAnagrafe];
  end;
  1 : begin
   locres  := LaAnagrafe.listaResidenti.Items[indiceListaAnagrafe];
   locFam  := locres.famer;
  end;
 end;
 locFam.Toponimo     := Edit_topo.Text;
 locFam.Indirizzo    := Edit_via.Text;
 locFam.civico       := Edit_civico.Text;

   if ((NomefileAnagrafe<>'') and  (NomefileFabbricatidati<>'') and (NomefileAnagrafeInfo<>'')) then
    begin
     LaAnagrafe.salva(NomefileAnagrafe);
     GliImmobiliDati.salvafabbricati(NomefileFabbricatidati);
     GliImmobiliDati.SalvaInfoAnagrafe(NomefileAnagrafeInfo);
    end;

end;

procedure TForm_editIndirizzoAnagrafe.FormShow(Sender: TObject);
var locFam : TFamiglia;
    locres : TResidente;
begin
 Edit_topo.Text :='';    Edit_via.Text :='';  Edit_civico.Text :='';
 case modoFamiglia of
  0 : begin
   locFam := LaAnagrafe.listaFamiglie.Items[indiceListaAnagrafe];
  end;
  1 : begin
   locres  := LaAnagrafe.listaResidenti.Items[indiceListaAnagrafe];
   locFam  := locres.famer;
  end;
 end;
 Edit_topo.Text :=locFam.Toponimo;    Edit_via.Text :=locFam.Indirizzo;  Edit_civico.Text :=locFam.civico;
end;


end.
