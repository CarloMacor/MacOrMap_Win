unit Dlg_possessiTutti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.StdCtrls;

type
  TForm_PossessiTutti = class(TForm)
    GrigliaDati: TStringGrid;
    PanBottom: TPanel;
    PanLeft: TPanel;
    PanRight: TPanel;
    PanTop: TPanel;
    Bot_Case: TSpeedButton;
    Bot_Terreni: TSpeedButton;
    Label1: TLabel;
    Lab_numPos: TLabel;
    procedure Bot_CaseClick(Sender: TObject);
    procedure Bot_TerreniClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   mododisegna : Integer;
   filtroAttivo : Integer;
   procedure svuota;
   procedure disegna;
  end;

var
  Form_PossessiTutti: TForm_PossessiTutti;

implementation

{$R *.dfm}

uses Possesso, Immobilidati, funzioni;


procedure TForm_PossessiTutti.Bot_CaseClick(Sender: TObject);
begin
 mododisegna := 1;
 disegna;
end;

procedure TForm_PossessiTutti.Bot_TerreniClick(Sender: TObject);
begin
 mododisegna := 0;
 disegna;
end;

procedure TForm_PossessiTutti.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;   GrigliaDati.Row:=0;
end;

procedure TForm_PossessiTutti.disegna;
var k : Integer;
   locsPossesso : TPossesso;
   LaListadaprendereDati : TList;
begin
 svuota;
   case mododisegna of
    0 : LaListadaprendereDati := GliImmobiliDati.ListaPossessiTerra;
    1 : LaListadaprendereDati := GliImmobiliDati.ListaPossessiFabbricati;
   end;

   // label per indicare se tutto o solo elemento
   case mododisegna of
    0 : begin caption :='Possesso Terreni'; end;
    1 : begin caption :='Possesso Fabbricati'; end;
   end;


        GrigliaDati.RowCount:= LaListadaprendereDati.count+1;

        Lab_numPos.Caption := IntToStr(LaListadaprendereDati.count);

         GrigliaDati.Cells[0,0]:= 'Id Soggetto';
         GrigliaDati.Cells[1,0]:= 'Id Immobile';
         GrigliaDati.Cells[2,0]:= 'Sog';
         GrigliaDati.Cells[3,0]:= 'Diritto';
         GrigliaDati.Cells[4,0]:= 'Quota';
         GrigliaDati.Cells[5,0]:= 'Descr';
         GrigliaDati.Cells[6,0]:= 'Id Possesso';


        for k:= 0 to LaListadaprendereDati.count-1 do
         begin
          locsPossesso := LaListadaprendereDati.items[k];
            GrigliaDati.Cells[0,k+1]:= locsPossesso.IdentificativoSoggetto;
            GrigliaDati.Cells[1,k+1]:= locsPossesso.IdentificativoImmobile;
            GrigliaDati.Cells[2,k+1]:= locsPossesso.TipoSoggetto;
            GrigliaDati.Cells[3,k+1]:= locsPossesso.CodiceDiritto;
            GrigliaDati.Cells[4,k+1]:= locsPossesso.QuotaNumeratore+'/'+locsPossesso.QuotaDenominatore;
            GrigliaDati.Cells[5,k+1]:= DescrizionePossessoCod(locsPossesso.CodiceDiritto);
            if DescrizionePossessoCod(locsPossesso.CodiceDiritto)= 'Non Codificato' then
                GrigliaDati.Cells[5,k+1]:= locsPossesso.TitoloNonCodificato;
            GrigliaDati.Cells[6,k+1]:= locsPossesso.IdPossesso;

            if DescrizionePossessoCod(locsPossesso.CodiceDiritto) ='' then
             begin
               showmessage(IntToStr(k)+'-'+locsPossesso.CodiceDiritto+'-');
               exit;
             end;
         end;
end;

procedure TForm_PossessiTutti.FormCreate(Sender: TObject);
begin
 mododisegna :=1;
end;

(*

   IdPossesso             : String;
   CodiceAmministrativo   : String;
   Sezione                : String;
   IdentificativoSoggetto : String;
   TipoSoggetto           : String;
   IdentificativoImmobile : String;
   TipoImmobile           : String;
   CodiceDiritto          : String;
   TitoloNonCodificato    : String;
   QuotaNumeratore        : String;
   QuotaDenominatore      : String;
   Regime                 : String;
   IdSoggettoRiferimento  : String;
   DatavaliditaStr        : String;

*)

end.
