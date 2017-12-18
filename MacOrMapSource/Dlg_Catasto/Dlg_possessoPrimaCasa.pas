unit Dlg_possessoPrimaCasa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids;

type
  TForm_PossessoPrimaCasa = class(TForm)
    GrigliaDati: TStringGrid;
    PanBottom: TPanel;
    PanLeft: TPanel;
    PanRight: TPanel;
    PanTop: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
   procedure svuota;
   procedure disegna;
  end;

var
  Form_PossessoPrimaCasa: TForm_PossessoPrimaCasa;

implementation

{$R *.dfm}

uses Possesso, Immobilidati, funzioni,FunzioniconListe, soggetto  ;


procedure TForm_PossessoPrimaCasa.disegna;
var k : Integer;
   locsPossesso : TPossesso;
   LaListadaprendereDati : TList;
   locsog : Tsoggetto;
begin
 svuota;
   LaListadaprendereDati := GliImmobiliDati.ListaPossessiPrimaCasa;


        GrigliaDati.RowCount:= LaListadaprendereDati.count+1;

         GrigliaDati.Cells[0,0]:= 'Cognome';
         GrigliaDati.Cells[1,0]:= 'Nome';
         GrigliaDati.Cells[2,0]:= 'Cod Fis';
         GrigliaDati.Cells[3,0]:= 'Quota';
         GrigliaDati.Cells[4,0]:= 'Descr';


        for k:= 0 to LaListadaprendereDati.count-1 do
         begin
          locsPossesso := LaListadaprendereDati.items[k];

           locsog := soggettodaId(locsPossesso.IdentificativoSoggetto,GliImmobiliDati.ListaProprietariFabbricati );
           if locsog<>nil then
             begin
              GrigliaDati.Cells[0,k+1]:= locsog.Cognome;
              GrigliaDati.Cells[1,k+1]:= locsog.Nome;
              GrigliaDati.Cells[2,k+1]:= locsog.CodiceFiscale;
             end;
            GrigliaDati.Cells[3,k+1]:= locsPossesso.QuotaNumeratore+'/'+locsPossesso.QuotaDenominatore;
            GrigliaDati.Cells[4,k+1]:= DescrizionePossessoCod(locsPossesso.CodiceDiritto);
            if DescrizionePossessoCod(locsPossesso.CodiceDiritto)= 'Non Codificato' then
                GrigliaDati.Cells[4,k+1]:= locsPossesso.TitoloNonCodificato;
            if DescrizionePossessoCod(locsPossesso.CodiceDiritto) ='' then
             begin
//               showmessage(IntToStr(k)+'-'+locsPossesso.CodiceDiritto+'-');   exit;
             end;
         end;
end;



procedure TForm_PossessoPrimaCasa.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;   GrigliaDati.Row:=0;
end;

end.
