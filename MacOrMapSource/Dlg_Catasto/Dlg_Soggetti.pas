unit Dlg_Soggetti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.Grids, Vcl.ExtCtrls;

type
  TForm_Soggetti = class(TForm)
    GrigliaDati: TStringGrid;
    PanBottom: TPanel;
    PanLeft: TPanel;
    PanRight: TPanel;
    PanTop: TPanel;
    Bot_Case: TSpeedButton;
    Bot_Terreni: TSpeedButton;
    procedure Bot_CaseClick(Sender: TObject);
    procedure Bot_TerreniClick(Sender: TObject);
    procedure GrigliaDatiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
   mododisegna : Integer;
   filtroAttivo : Integer;
   nrpossessicalcolati : Boolean;
   procedure svuota;
   procedure disegnalocale;
   procedure calcolapossessi;
  end;

var
  Form_Soggetti: TForm_Soggetti;

implementation

{$R *.dfm}

uses Soggetto, immobilidati,possesso,progetto;

procedure TForm_Soggetti.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;   GrigliaDati.Row:=0;
end;



procedure TForm_Soggetti.Bot_CaseClick(Sender: TObject);
begin
 mododisegna := 1;
 disegnalocale;
end;

procedure TForm_Soggetti.Bot_TerreniClick(Sender: TObject);
begin
 mododisegna := 0;
 disegnalocale;
end;

procedure TForm_Soggetti.calcolapossessi;
var k ,kk,j: Integer;
   locsoggetto : TSoggetto;
   locPossesso : TPossesso;
   LaListadaprendereDati : TList;
   LaListaPossessi : TList;
begin
 for kk :=0 to 1 do
  begin
    case kk of
      0 : begin LaListadaprendereDati := GliImmobiliDati.ListaProprietariTerra;       LaListaPossessi := GliImmobiliDati.ListaPossessiTerra;  end;
      1 : begin LaListadaprendereDati := GliImmobiliDati.ListaProprietariFabbricati;  LaListaPossessi := GliImmobiliDati.ListaPossessiFabbricati;  end;
    end;
     for k:= 0 to LaListadaprendereDati.count-1 do
       begin
        locsoggetto := LaListadaprendereDati.items[k];
         for j:=0 to LaListaPossessi.Count-1 do
          begin
           locPossesso := LaListaPossessi.items[j];
           if locsoggetto.Identificativo = locPossesso.IdentificativoSoggetto then inc(locsoggetto.nrpossessi);
          end;
       end;
  end;
  nrpossessicalcolati := true;
end;

procedure TForm_Soggetti.disegnalocale;
var k : Integer;
   locsoggetto : TSoggetto;
   LaListadaprendereDati : TList;
begin
 if not(nrpossessicalcolati) then calcolapossessi;
 svuota;
 case mododisegna of
  0 : LaListadaprendereDati := GliImmobiliDati.ListaProprietariTerra;
  1 : LaListadaprendereDati := GliImmobiliDati.ListaProprietariFabbricati;
 end;

 // label per indicare se tutto o solo elemento
 case mododisegna of
  0 : begin caption :='Soggetti possesso Terreni'; end;
  1 : begin caption :='Soggetti possesso Fabbricati'; end;
 end;


      GrigliaDati.RowCount:= LaListadaprendereDati.count+1;

       GrigliaDati.Cells[0,0]:= '';
       GrigliaDati.Cells[1,0]:= 'Nome';
       GrigliaDati.Cells[2,0]:= 'Cognome';
       GrigliaDati.Cells[3,0]:= 'S';
       GrigliaDati.Cells[4,0]:= 'Nascita';
       GrigliaDati.Cells[5,0]:= 'Cod Fis';
       GrigliaDati.Cells[6,0]:= 'Id Soggetto';
       GrigliaDati.Cells[7,0]:= 'nr. pos.';


      for k:= 0 to LaListadaprendereDati.count-1 do
       begin
        locsoggetto := LaListadaprendereDati.items[k];
        GrigliaDati.Cells[0,k+1]:= locsoggetto.TipoSoggetto;
        if locsoggetto.TipoSoggetto = 'P' then
         begin
          GrigliaDati.Cells[1,k+1]:= locsoggetto.Nome;
          GrigliaDati.Cells[2,k+1]:= locsoggetto.Cognome;
          if locsoggetto.CodSesso='2' then GrigliaDati.Cells[3,k+1]:='F';
          if locsoggetto.CodSesso='1' then GrigliaDati.Cells[3,k+1]:='M';
          GrigliaDati.Cells[4,k+1]:= copy(locsoggetto.DataNascitaStr,1,2)+'/'
                                      +copy(locsoggetto.DataNascitaStr,3,2)+'/'+copy(locsoggetto.DataNascitaStr,5,4);
          GrigliaDati.Cells[5,k+1]:= locsoggetto.CodiceFiscale;
         end
          else
         begin
          GrigliaDati.Cells[1,k+1]:= '';
          GrigliaDati.Cells[2,k+1]:= locsoggetto.DenominazioneAzienda;
          GrigliaDati.Cells[3,k+1]:= '';
          GrigliaDati.Cells[4,k+1]:= '';
          GrigliaDati.Cells[5,k+1]:= locsoggetto.CFAzienda;
         end;
        GrigliaDati.Cells[6,k+1]:= locsoggetto.Identificativo;
        GrigliaDati.Cells[7,k+1]:= IntToStr(locsoggetto.nrpossessi);
       end;
end;



procedure TForm_Soggetti.FormCreate(Sender: TObject);
begin
 nrpossessicalcolati := False;
end;

procedure TForm_Soggetti.GrigliaDatiClick(Sender: TObject);
begin

 if GrigliaDati.Row = 0 then
  begin

   GliImmobiliDati.riordinaSoggettiModo(mododisegna,GrigliaDati.Col);
   disegnaLocale;
   exit;
  end;

 if GrigliaDati.Col = 8 then
  begin
   IlProgetto.selezionaTerfabSoggetto(mododisegna,GrigliaDati.Cells[6,GrigliaDati.Row]);
  end;

end;

end.
