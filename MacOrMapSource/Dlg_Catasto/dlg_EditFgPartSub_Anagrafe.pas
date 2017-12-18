unit dlg_EditFgPartSub_Anagrafe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm_EditFgAnagrafe = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit_fg: TEdit;
    Edit_part: TEdit;
    Edit_sub: TEdit;
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
  Form_EditFgAnagrafe: TForm_EditFgAnagrafe;

implementation

{$R *.dfm}

uses Anagrafe, famiglia,residente,immobilidati,varbase;

procedure TForm_EditFgAnagrafe.BitBtn2Click(Sender: TObject);
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
 locFam.Foglio     := Edit_Fg.Text;
 locFam.Particella := Edit_part.Text;
 locFam.Subalterno := Edit_sub.Text;
 locFam.associato  := false;
 locFam.valAssociazione := '0';
 GliImmobiliDati.disassociaFamiglia(locFam.codfamily);
 if GliImmobiliDati.associaFamiglia(locFam.codfamily,locFam.Foglio,locFam.Particella,locFam.Subalterno) then
  begin
   locFam.associato       := true;
   locFam.valAssociazione := '80';
  end;

 if ((NomefileAnagrafe<>'') and  (NomefileFabbricatidati<>'') and (NomefileAnagrafeInfo<>'')) then
  begin
   LaAnagrafe.salva(NomefileAnagrafe);
   GliImmobiliDati.salvafabbricati(NomefileFabbricatidati);
   GliImmobiliDati.SalvaInfoAnagrafe(NomefileAnagrafeInfo);
  end;
end;

procedure TForm_EditFgAnagrafe.FormShow(Sender: TObject);
var locFam : TFamiglia;
    locres : TResidente;
begin
 Edit_Fg.Text :='';    Edit_part.Text :='';  Edit_sub.Text :='';
 case modoFamiglia of
  0 : begin
   locFam := LaAnagrafe.listaFamiglie.Items[indiceListaAnagrafe];
  end;
  1 : begin
   locres  := LaAnagrafe.listaResidenti.Items[indiceListaAnagrafe];
   locFam  := locres.famer;
  end;
 end;
 Edit_Fg.Text :=locFam.Foglio;    Edit_part.Text :=locFam.Particella;  Edit_sub.Text :=locFam.Subalterno;
end;




end.
