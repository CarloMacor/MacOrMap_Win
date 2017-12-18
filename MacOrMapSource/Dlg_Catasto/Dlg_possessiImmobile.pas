unit Dlg_possessiImmobile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids;

type
  TForm_PossessiImmobile = class(TForm)
    GrigliaDati: TStringGrid;
    PanBottom: TPanel;
    PanLeft: TPanel;
    PanRight: TPanel;
    PanTop: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
   modo : Integer;
   procedure svuota;
   procedure disegna;
  end;

var
  Form_PossessiImmobile: TForm_PossessiImmobile;

implementation

{$R *.dfm}
uses Possesso, Immobilidati, funzioni, soggetto, FunzioniconListe,FabCatdati;

procedure TForm_PossessiImmobile.disegna;
var k , kj: Integer;
   locsPossesso : TPossesso;
   LaListadaprendereDati : TList;
    locsog : Tsoggetto;
    locfab : TFabCatDati;
begin
 svuota;
 case modo of
  0 :  LaListadaprendereDati := GliImmobiliDati.ListaPossessiFabbricatiFiltrata;
  1 :  LaListadaprendereDati := GliImmobiliDati.ListaPossessiTerraFiltrata;
 end;


        GrigliaDati.RowCount:= LaListadaprendereDati.count+1;

         GrigliaDati.Cells[0,0]:= 'Cognome';
         GrigliaDati.Cells[1,0]:= 'Nome';
         GrigliaDati.Cells[2,0]:= 'Cod Fis';
         GrigliaDati.Cells[3,0]:= 'Quota';
         GrigliaDati.Cells[4,0]:= 'Descrizione';
         GrigliaDati.Cells[5,0]:= 'Fg';
         GrigliaDati.Cells[6,0]:= 'Part';
         GrigliaDati.Cells[7,0]:= 'Sub';
         GrigliaDati.Cells[8,0]:= 'Via';

        for k:= 0 to LaListadaprendereDati.count-1 do
         begin
          locsPossesso := LaListadaprendereDati.items[k];
          case modo of
            0 :  locsog := soggettodaId(locsPossesso.IdentificativoSoggetto,GliImmobiliDati.ListaProprietariFabbricati );
            1 :  locsog := soggettodaId(locsPossesso.IdentificativoSoggetto,GliImmobiliDati.ListaProprietariTerra );
          end;

           if locsog<>nil then
             begin
              if locsog.TipoSoggetto ='P' then
               begin
                GrigliaDati.Cells[0,k+1]:= locsog.Cognome;
                GrigliaDati.Cells[1,k+1]:= locsog.Nome;
                GrigliaDati.Cells[2,k+1]:= locsog.CodiceFiscale;
               end
                else
               begin
                GrigliaDati.Cells[0,k+1]:= locsog.DenominazioneAzienda;
                GrigliaDati.Cells[1,k+1]:= '';
                GrigliaDati.Cells[2,k+1]:= locsog.CFAzienda;
               end;
             end;
            GrigliaDati.Cells[3,k+1]:= locsPossesso.QuotaNumeratore+'/'+locsPossesso.QuotaDenominatore;
            GrigliaDati.Cells[4,k+1]:= DescrizionePossessoCod(locsPossesso.CodiceDiritto);
            if DescrizionePossessoCod(locsPossesso.CodiceDiritto)= 'Non Codificato' then
                GrigliaDati.Cells[4,k+1]:= locsPossesso.TitoloNonCodificato;

//            GrigliaDati.Cells[5,k+1]:= locsPossesso.IdentificativoSoggetto;
            locfab := GliImmobiliDati.FabDatodaId(locsPossesso.IdentificativoImmobile);
            if locfab<>nil then
             begin
               GrigliaDati.Cells[5,k+1]:= locfab.Foglio;
               GrigliaDati.Cells[6,k+1]:= locfab.Particella;
               GrigliaDati.Cells[7,k+1]:= locfab.Subalterno;
               GrigliaDati.Cells[8,k+1]:= locfab.Via_Catastale;
             end;


            if DescrizionePossessoCod(locsPossesso.CodiceDiritto) ='' then
             begin
//               showmessage(IntToStr(k)+'-'+locsPossesso.CodiceDiritto+'-');
//               exit;
             end;
         end;
end;



procedure TForm_PossessiImmobile.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;   GrigliaDati.Row:=0;
end;

end.
