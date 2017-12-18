unit Dlg_ImportTracciato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm_Tracciato = class(TForm)
    OpenCat: TOpenDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    But_Ter_TER: TSpeedButton;
    But_Ter_TIT: TSpeedButton;
    But_Ter_SOG: TSpeedButton;
    But_AzionaTerreni: TSpeedButton;
    ListBox1: TListBox;
    But_Anagrafe: TSpeedButton;
    Bot_Tares: TSpeedButton;
    But_Imu: TSpeedButton;
    But_associa_IMU: TSpeedButton;
    But_associa_Tares: TSpeedButton;
    Bot_AnagAssociazione: TSpeedButton;
    But_stessocivicoedif: TSpeedButton;
    But_DaImu: TSpeedButton;
    procedure But_Ter_TERClick(Sender: TObject);
    procedure But_Ter_TITClick(Sender: TObject);
    procedure But_Ter_SOGClick(Sender: TObject);
    procedure But_AzionaTerreniClick(Sender: TObject);
    procedure But_AnagrafeClick(Sender: TObject);
    procedure Bot_TaresClick(Sender: TObject);
    procedure But_ImuClick(Sender: TObject);
    procedure But_associa_IMUClick(Sender: TObject);
    procedure But_associa_TaresClick(Sender: TObject);
    procedure Bot_AnagAssociazioneClick(Sender: TObject);
    procedure But_stessocivicoedifClick(Sender: TObject);
    procedure But_DaImuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure elaboraFAB;
    procedure elaboraTER;
    procedure elaboraSOG(code : Integer);
    procedure elaboraTIT(code : Integer);
    procedure ElaboraAnagrafe;
    procedure ElaboraTares;
    procedure ElaboraImu;
    procedure TogliImuSenzaFgPart;


    { Private declarations }
  public
    { Public declarations }
    Procedure ButtaEdificiSenzaCategoria;
    Procedure ButtaEdificiSenzaFgPart;
    Procedure ButtaEdificiToErase;
    Procedure ButtaEdificiDoppi;
    Procedure ButtaTerreniToErase;
    Procedure ButtaPossessiEdificiToErase;
    Procedure ButtaPossessiTerreniToErase;
  end;

var
  Form_Tracciato: TForm_Tracciato;
  nomeTer_Ter   : String;
  nomeTer_Tit   : String;
  nomeTer_sog   : String;

  nomeFab_Fab   : String;
  nomeFab_Tit   : String;
  nomeFab_sog   : String;

  inTolfa3 : Boolean;

implementation

{$R *.dfm}
uses funzioni, FabCatDati,TerCatDati, ImmobiliDati, Soggetto, Possesso,Anagrafe,Famiglia,Residente,Tares,Imu , progetto, varbase
     , proprietario ;


procedure TForm_Tracciato.elaboraFAB;
var F : TextFile;
   riga, r1,r2 : String;
   tiporecord : Integer;
   locFabdato : TFabCatDati;
   _codiceamministrativo : String;
   _sezione : String;
   _IdentificativoImmobile : String;
   _Categoria              : String;
   _Classe                 : String;
   _Consistenza            : String;
   _superficie             : String;
   _RenditaStrEuro         : String;
   _Interno                : String;
   _Piano                  : String;
   _Foglio                 : String;
   _Particella             : String;
   _Subalterno             : String;
   _Foglio2                : String;
   _Particella2            : String;
   _Subalterno2            : String;
   _codicestrada           : String;
   _Topo_Catastale         : String;
   _Via_Catastale          : String;
   _Civico_Catastale       : String;
   inrep : Boolean;
begin

GliImmobiliDati.listaFabbricati.clear;
 inrep := false;

    if inTolfa3 then nomeFab_Fab := 'D:\Tolfa\Catasto_Dati\Fabbricati_Tolfa\L192770226_1.FAB'
               else nomeFab_Fab := 'D:\Magliano_Sabina\Catasto_Dati\Fabbricati_Magliano\E812758075_1.FAB';




   assignFile(F,nomeFab_Fab); reset(F);
   while not(eof(F))  do
    begin
      readln(F,riga);
        SpezzastringaBarra(riga,r1,riga);
        _codiceamministrativo := r1;
        if inrep then ListBox1.Items.Add('CODICE AMMINISTRATIVO    : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        _sezione := r1;
        if inrep then ListBox1.Items.Add('SEZIONE                  : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        _IdentificativoImmobile := r1;
        if inrep then ListBox1.Items.Add('IDENTIFICATIVO IMMOBILE  : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('TIPO IMMOBILE            : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('PROGRESSIVO              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('TIPO RECORD              : '+r1);

    tiporecord := strToInt(r1);
{
  CODICE AMMINISTRATIVO alfanumerico 4 caratteri.
  SEZIONE alfanumerico 1 carattere.
  La codifica delle sezioni è riportata nella tabella “Sezioni censuarie del catasto
  fabbricati e del catasto terreni”.
  Progressivo dell’immobile nella banca dati
  IDENTIFICATIVO IMMOBILE numerico 9 caratteri.
  Assume valore fisso F (fabbricati)
  TIPO IMMOBILE alfanumerico 1 carattere
  I valori dei due campi precedenti referenziano gli analoghi campi nel file delle
  titolarità e consentono di reperire i soggetti che vantano diritti sul bene.
  Numero progressivo delle situazioni oggettive dell’immobile
  PROGRESSIVO numerico 3 caratteri.
  Identificativo del tipo record del file immobili, assume valore fisso 1
  TIPO RECORD numerico 1 carattere
}

  case tiporecord of
   1 : begin

     locFabdato := TFabCatDati.Create;  GliImmobiliDati.listaFabbricati.Add(locFabdato);

     locFabdato.codiceamministrativo   := _codiceamministrativo;
     locFabdato.sezione                := _sezione;
     locFabdato.IdentificativoImmobile := _IdentificativoImmobile;

 


{
  ZONA alfanumerico 3 caratteri.
  CATEGORIA alfanumerico 3 caratteri.
  La codifica delle categorie è riportata nella tabella “Categorie catastali”.
  CLASSE alfanumerico 2 caratteri.
  L’interpretazione del significato del campo CONSISTENZA dipende dal primo
  carattere del campo CATEGORIA che assume i seguenti valori:
  A la consistenza viene espressa in vani e l'ultimo carattere rappresenta un valore decimale pari a 0 o 5
  B la consistenza viene espressa in metri cubi
  C la consistenza viene espressa in metri quadrati
  CONSISTENZA numerico 7 caratteri
  SUPERFICIE numerico 5 caratteri.
  Il campo superficie non è in alternativa al campo CONSISTENZA, ma viene
  impostato indipendentemente da questo e riporta la superficie calcolata dalla
  parte, con il metodo dei poligoni ai sensi del DPR 138/98, e riportata nel
  documento DOCFA
  RENDITA-LIRE numerico 15 caratteri.
  RENDITA-EURO numerico 18 caratteri
  gli ultimi 3 caratteri sono decimali
}

       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('ZONA              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
       _Categoria := r1;
        if inrep then ListBox1.Items.Add('CATEGORIA              : '+r1);
       locFabdato.Categoria        := _Categoria;

       SpezzastringaBarra(riga,r1,riga);
       _Classe := r1;
       locFabdato.Classe           := _Classe;
        if inrep then ListBox1.Items.Add('CLASSE              : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        _Consistenza := r1;
        locFabdato.Consistenza      := _Consistenza;

         if length(_Categoria)>0 then
          begin
//            if _Categoria[1]='A' then _superficie :=  _Consistenza;
            if _Categoria[1]='B' then locFabdato.superficie :=  _Consistenza;
            if _Categoria[1]='C' then locFabdato.superficie :=  _Consistenza;
//            if _Categoria[1]='D' then  ListBox1.Items.Add('_Consistenza        : '+_Consistenza);
          end;

        if inrep then ListBox1.Items.Add('CONSISTENZA              : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('SUPERFICIE              : '+r1);


       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('RENDITA-LIRE              : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        _RenditaStrEuro := r1;
        locFabdato.RenditaStrEuro   := _RenditaStrEuro;
        if inrep then ListBox1.Items.Add('RENDITA-Euro              : '+r1);



{
  LOTTO alfanumerico 2 caratteri.
  EDIFICIO alfanumerico 2 caratteri.
  SCALA alfanumerico 2 caratteri.
  INTERNO 1 alfanumerico 3 caratteri.
  INTERNO 2 alfanumerico 3 caratteri.
  PIANO 1 alfanumerico 4 caratteri.
  PIANO 2 alfanumerico 4 caratteri.
  PIANO 3 alfanumerico 4 caratteri.
  PIANO 4 alfanumerico 4 caratteri.
}

       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('LOTTO              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('EDIFICIO              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('SCALA              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        r1 := Toglizeroiniziali(r1);
        _Interno := r1;
        locFabdato.Interno          := _Interno;
        if inrep then ListBox1.Items.Add('INTERNO 1              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('INTERNO 2              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        r1 := Toglizeroiniziali(r1);
        _Piano := r1;
        locFabdato.piano            := _Piano;
        if inrep then ListBox1.Items.Add('PIANO 1              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('PIANO 2              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('PIANO 3              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('PIANO 4              : '+r1);




{
  Dati relativi all’atto che ha generato la situazione oggettiva dell’unità:
  DATA DI EFFICACIA numerico 8 caratteri.
  formato GGMMAAAA
  DATA DI REGISTRAZIONE IN ATTI numerico 8 caratteri.
  formato GGMMAAAA
  TIPO NOTA alfanumerico 1 carattere.
  La descrizione del tipo nota è riportata nella tabella “Tipo nota”.
  NUMERO NOTA alfanumerico 6 caratteri.
  PROGRESSIVO NOTA alfanumerico 3 caratteri.
  ANNO NOTA numerico 4 caratteri.
  Dati relativi all’atto che ha concluso la situazione oggettiva dell’unità:
  DATA DI EFFICACIA numerico 8 caratteri.
  formato GGMMAAAA
  DATA DI REGISTRAZIONE IN ATTI numerico 8 caratteri.
  formato GGMMAAAA
  TIPO NOTA alfanumerico 1 carattere.
  NUMERO NOTA alfanumerico 6 caratteri.
  PROGRESSIVO NOTA alfanumerico 3 caratteri.
  ANNO NOTA numerico 4 caratteri
}
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DATA DI EFFICACIA              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DATA DI REGISTRAZIONE IN ATTI              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('TIPO NOTA              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('NUMERO NOTA              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('PROGRESSIVO NOTA               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('ANNO NOTA              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if r1<>'' then locFabdato.toErase:=true;
        if inrep then ListBox1.Items.Add('DATA DI EFFICACIA              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if r1<>'' then locFabdato.toErase:=true;
        if inrep then ListBox1.Items.Add('DATA DI REGISTRAZIONE IN ATTI              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if r1<>'' then locFabdato.toErase:=true;
        if inrep then ListBox1.Items.Add('TIPO NOTA              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if r1<>'' then locFabdato.toErase:=true;
        if inrep then ListBox1.Items.Add('NUMERO NOTA               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if r1<>'' then locFabdato.toErase:=true;
        if inrep then ListBox1.Items.Add('PROGRESSIVO NOTA                : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if r1<>'' then locFabdato.toErase:=true;
        if inrep then ListBox1.Items.Add('ANNO NOTA               : '+r1);

{
  PARTITA (ove presente) alfanumerico 7 caratteri.
  Informazioni aggiuntive sulle caratteristiche dell’immobile
  ANNOTAZIONE alfanumerico 200 caratteri.
  IDENTIFICATIVO MUTAZIONE INIZIALE numerico 9 caratteri
  IDENTIFICATIVO MUTAZIONE FINALE numerico 9 caratteri
}

       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('PARTITA               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('ANNOTAZIONE               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('IDENTIFICATIVO MUTAZIONE INIZIALE               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('IDENTIFICATIVO MUTAZIONE FINALE               : '+r1);

{
  PROTOCOLLO NOTIFICA alfanumerico 18 caratteri
  DATA NOTIFICA numerico 8 caratteri,
  formato GGMMAAAA
  Dati relativi all’atto che ha generato la situazione oggettiva dell’unità
  CODICE CAUSALE ATTO GENERANTE alfanumerico 3 caratteri,
  DESCRIZIONE ATTO GENERANTE alfanumerico 100 caratteri,
  Dati relativi all’atto che ha concluso la situazione oggettiva dell’unità
  CODICE CAUSALE ATTO CONCLUSIVO alfanumerico 3 caratteri,
  DESCRIZIONE ATTO CONCLUSIVO alfanumerico 100 caratteri,
  FLAG CLASSAMENTO numerico 1 carattere.
  1 = classamento proposto dalla parte
  2 = classamento proposto dalla parte
  e validato dall’ufficio
  3 = classamento automatico
  4 = classamento d’ufficio
  5 = classamento derivante da liste di
  classamento
  space = residuale su uiu antecedenti
  DOCFA
}

       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('PROTOCOLLO NOTIFICA               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DATA NOTIFICA               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('CODICE CAUSALE ATTO GENERANTE              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DESCRIZIONE ATTO GENERANTE               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('CODICE CAUSALE ATTO CONCLUSIVO              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DESCRIZIONE ATTO CONCLUSIVO               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('FLAG CLASSAMENTO               : '+r1);

        if inrep then ListBox1.Items.Add('-------------:'+riga);

   end;  // case recrod 1

   2 : begin

{
   TABELLA IDENTIFICATIVI (max 10 elementi):
  · SEZIONE URBANA alfanumerico 3 caratteri.
  · FOGLIO alfanume rico 4 caratteri.
  · NUMERO alfanumerico 5 caratteri.
  · DENOMINATORE numerico 4 caratteri.
  · SUBALTERNO alfanumerico 4 caratteri.
  · EDIFICIALITA' alfanumerico 1 carattere.' +
}
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('SEZIONE URBANA               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
       r1 := Toglizeroiniziali(r1);
        _Foglio := r1;
        locFabdato.Foglio           := _Foglio;
        if inrep then ListBox1.Items.Add('FOGLIO               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
       r1 := Toglizeroiniziali(r1);
        _Particella:= r1;
        locFabdato.Particella       := _Particella;
        if inrep then ListBox1.Items.Add('NUMERO               : '+r1);


       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DENOMINATORE               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
       r1 := Toglizeroiniziali(r1);
        _Subalterno := r1;
        locFabdato.Subalterno       := _Subalterno;
        if inrep then ListBox1.Items.Add('SUBALTERNO               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('EDIFICIALITA               : '+r1);
// potrebbero essere molteplici ...

      SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('SEZIONE URBANA               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
       r1 := Toglizeroiniziali(r1);
        _Foglio2 := r1;
        locFabdato.Foglio2           := _Foglio2;
        if inrep then ListBox1.Items.Add('FOGLIO 2              : '+r1);

       SpezzastringaBarra(riga,r1,riga);
       r1 := Toglizeroiniziali(r1);
        _Particella2:= r1;
        locFabdato.Particella2       := _Particella2;
        if inrep then ListBox1.Items.Add('NUMERO               : '+r1);


       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DENOMINATORE               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
       r1 := Toglizeroiniziali(r1);
        _Subalterno2 := r1;
        locFabdato.Subalterno2       := _Subalterno2;
        if inrep then ListBox1.Items.Add('SUBALTERNO               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('EDIFICIALITA               : '+r1);



   end; // case resord 2

   3 : begin

{
  · TOPONIMO numerico 3 caratteri
  · INDIRIZZO alfanumerico 50 caratteri.
  · CIVICO 1 alfanumerico 6 caratteri.
  · CIVICO 2 alfanumerico 6 caratteri.
  · CIVICO 3 alfanumerico 6 caratteri.
  · CODICE STRADA numerico 5 caratteri
}
       SpezzastringaBarra(riga,r1,riga);
        _Topo_Catastale := r1;
        locFabdato.Topo_Catastale   := _Topo_Catastale;
        if inrep then ListBox1.Items.Add('TOPONIMO               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        _Via_Catastale := r1;
        locFabdato.Via_Catastale    := _Via_Catastale;
        if inrep then ListBox1.Items.Add('INDIRIZZO               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
       r1 := Toglizeroiniziali(r1);
        _Civico_Catastale := r1;
        locFabdato.Civico_Catastale := _Civico_Catastale;
        if inrep then ListBox1.Items.Add('CIVICO 1               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        r1 := Toglizeroiniziali(r1);
        if inrep then ListBox1.Items.Add('CIVICO 2               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
       r1 := Toglizeroiniziali(r1);
        if inrep then ListBox1.Items.Add('CIVICO 3               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        _codicestrada           := r1;
        locFabdato.codicestrada     := _codicestrada;
        if inrep then ListBox1.Items.Add('CODICE STRADA               : '+r1);




   end; // case record 3

   4 : begin
{
  · SEZIONE URBANA alfanumerico 3 caratteri.
  · FOGLIO alfanumerico 4 caratteri.
  · NUMERO alfanumerico 5 caratteri.
  · DENOMINATORE numerico 4 caratteri.
  · SUBALTERNO alfanumerico 4 caratteri.
}
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('SEZIONE URBANA               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
       r1 := Toglizeroiniziali(r1);
         if inrep then ListBox1.Items.Add('FOGLIO               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
       r1 := Toglizeroiniziali(r1);
        if inrep then ListBox1.Items.Add('NUMERO               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DENOMINATORE               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
       r1 := Toglizeroiniziali(r1);
        if inrep then ListBox1.Items.Add('SUBALTERNO               : '+r1);

   end; //case record 4

  end;


//    if GliImmobiliDati.listaFabbricati.count>1 then break;
//     break;
    end;

// Butta edifici senza categoria;
   ButtaEdificiSenzaCategoria;
   ButtaEdificiSenzaFgPart;
   ButtaEdificiToErase;
   ButtaEdificiDoppi;
end;

procedure TForm_Tracciato.Bot_AnagAssociazioneClick(Sender: TObject);
var kt,kf,kr,ke : Integer;
    loctares : TTares;
    locImu   : TImu;
    locfam   : TFamiglia;
    locres   : TResidente;
    locPoss  : TPossesso;
    locpropr : TSoggetto;
    contaTaresconIndirizzo : Integer;
    LocListatares : TList;
    locedif : TFabCatDati;
begin
 Ilprogetto.OpenInfoTributiAnagrafe;

   for kf := 0 to LaAnagrafe.listaFamiglie.Count-1 do
    begin
     locfam := LaAnagrafe.listaFamiglie.items[kf];
     locfam.Foglio          :='';
     locfam.Particella      := '';
     locfam.Subalterno      := '';
     locfam.associato       := false;
     locfam.valAssociazione := '';
     locfam.ListaTares.clear;
     locfam.ListaImu.clear;
     locfam.ListaPossessi.clear;
    end;

   for kf := 0 to GliImmobiliDati.listaFabbricati.Count-1 do
    begin
     locedif :=  GliImmobiliDati.listaFabbricati.Items[kf];
     locedif.Topo_Anagrafe   := '';
     locedif.Via_Anagrafe    := '';
     locedif.Civico_Anagrafe := '';
     locedif.Topo_Corretta   :='';
     locedif.Via_Corretta    :='';
     locedif.Civico_Corretta :='';
     locedif.Residenti.clear;
    end;


{

      GliImmobiliDati.salvaInfoAnagrafe(NomefileAnagrafeInfo);
      GliImmobiliDati.salvafabbricati(NomefileFabbricatidati);
      LaAnagrafe.salva(NomefileAnagrafe);
      exit;

}

 LocListatares := TList.Create;

 for kt:=0 to  GliImmobiliDati.listaTares.Count-1 do
  begin
   loctares:= GliImmobiliDati.listaTares.items[kt];
   for kf := 0 to LaAnagrafe.listaFamiglie.Count-1 do
    begin
     locfam := LaAnagrafe.listaFamiglie.items[kf];
     for kr := 0 to locfam.ListaFamiglia.Count-1 do
      begin
       locres:=locfam.ListaFamiglia.items[kr];
       if loctares.CFIVA = locres.CF then
        begin
         locfam.ListaTares.Add(loctares);
         break;
        end;
      end;
    end;
  end;

 for kt:=0 to  GliImmobiliDati.ListaImu.Count-1 do
  begin
   locImu:= GliImmobiliDati.ListaImu.items[kt];
   for kf := 0 to LaAnagrafe.listaFamiglie.Count-1 do
    begin
     locfam := LaAnagrafe.listaFamiglie.items[kf];
     for kr := 0 to locfam.ListaFamiglia.Count-1 do
      begin
       locres:=locfam.ListaFamiglia.items[kr];
       if locImu.CFIVA = locres.CF then
        begin
         locfam.ListaImu.Add(locImu);
         break;
        end;
      end;
    end;
  end;


   for kt:=0 to  GliImmobiliDati.ListaPossessiFabbricati.Count-1 do
    begin
     locPoss:= GliImmobiliDati.ListaPossessiFabbricati.items[kt];
     locpropr := GliImmobiliDati.dammiproprietarioCF(locPoss.IdPossesso);
     for kf := 0 to LaAnagrafe.listaFamiglie.Count-1 do
      begin
       locfam := LaAnagrafe.listaFamiglie.items[kf];
       for kr := 0 to locfam.ListaFamiglia.Count-1 do
        begin
         locres:=locfam.ListaFamiglia.items[kr];
         if (locres.CF = locpropr.CodiceFiscale) then
          begin
           locfam.ListaPossessi.Add(locposs);
           break;
          end;
        end;
      end;
    end;

   // ora usa i dati per capire dove abitano
   for kf := 0 to LaAnagrafe.listaFamiglie.Count-1 do
    begin
     locfam := LaAnagrafe.listaFamiglie.items[kf];
     if locfam.associato then continue;
     contaTaresconIndirizzo :=0;
     LocListatares.Clear;

     for kt:=0 to  locfam.listaTares.Count-1 do
      begin
       loctares:= locfam.listaTares.items[kt];
       if loctares.inIndirizzo(locfam.Indirizzo) then
        begin
         LocListatares.add(loctares);
        end;
      end;

       if LocListatares.count>1 then
        begin
         for ke := LocListatares.count-1 downto 0 do
          begin
           loctares := LocListatares.items[ke];
           locedif := GliImmobiliDati.FabDatoFgPartSub(loctares.Foglio,loctares.Particella,loctares.Subalterno);
           if locedif<>nil then
            begin
             if length(locedif.Categoria)=0 then continue;
             if locedif.Categoria[1]='A' then
              begin
               LocListatares.delete(ke);
               LocListatares.insert(0,loctares);
               break;
              end;
            end;
          end;
        end;


       if LocListatares.count>0 then
        begin
         loctares := LocListatares.items[0];
         locedif := GliImmobiliDati.FabDatoFgPartSub(loctares.Foglio,loctares.Particella,loctares.Subalterno);
         if locedif<>nil then
          begin
           locfam.Foglio     := loctares.Foglio;
           locfam.Particella := loctares.Particella;
           locfam.Subalterno := loctares.Subalterno;
           locfam.associato := true;
           if LocListatares.count=1 then locfam.valAssociazione := '10' else locfam.valAssociazione := '12';
           locedif.Topo_Anagrafe   := locfam.Toponimo;
           locedif.Via_Anagrafe    := locfam.Indirizzo;
           locedif.Civico_Anagrafe := locfam.civico;
           if (locedif.Topo_Anagrafe   = interpretaTopoCatastale(locedif.Topo_Catastale)) then locedif.Topo_Corretta := locedif.Topo_Anagrafe;
           if (locedif.Via_Anagrafe    = locedif.Via_Catastale)   then locedif.Via_Corretta  := locedif.Via_Anagrafe;
           if (locedif.Civico_Anagrafe = locedif.Civico_Catastale) then locedif.Civico_Corretta := locedif.Civico_Anagrafe;
           locedif.Residenti.Add(locfam);
          end
           else
        // non sono riuscito a trovare il sub ma provo con il solo fg,part
          begin
           locedif := GliImmobiliDati.FabDatoFgPart_primo(loctares.Foglio,loctares.Particella);
           if locedif<>nil then
            begin
             locfam.Foglio     := loctares.Foglio;
             locfam.Particella := loctares.Particella;
             locfam.Subalterno := '?';
             locfam.associato := true;
             locfam.valAssociazione := '18'
            end;
          end;
        end;



    end;

  LocListatares.Clear;
  LocListatares.Free;


  GliImmobiliDati.salvaInfoAnagrafe(NomefileAnagrafeInfo);
  GliImmobiliDati.salvafabbricati(NomefileFabbricatidati);
  LaAnagrafe.salva(NomefileAnagrafe);
end;

procedure TForm_Tracciato.Bot_TaresClick(Sender: TObject);
var baseSalvataggio : String;
    nomefileToSaveTxt : String;
begin
 if inTolfa3 then baseSalvataggio:='D:\Tolfa\Dati\Catasto\'
            else baseSalvataggio:='D:\Magliano_Sabina\Dati\Catasto\';
       ElaboraTares;
       nomefileToSaveTxt :=  baseSalvataggio+'Tares.txt';
       GliImmobiliDati.SalvaTares(nomefileToSaveTxt);
end;


Procedure TForm_Tracciato.ButtaEdificiSenzaCategoria;
var  locFabdato : TFabCatDati;
     k : Integer;
begin
 for k := GliImmobiliDati.listaFabbricati.count-1 downto 0 do
  begin
   locFabdato := GliImmobiliDati.listaFabbricati.items[k];
   if locFabdato.Categoria='' then GliImmobiliDati.listaFabbricati.delete(k);
  end;
end;


Procedure TForm_Tracciato.ButtaEdificiSenzaFgPart;
var  locFabdato : TFabCatDati;
     k : Integer;
begin
 for k := GliImmobiliDati.listaFabbricati.count-1 downto 0 do
  begin
   locFabdato := GliImmobiliDati.listaFabbricati.items[k];
   if ((locFabdato.foglio='') or (locFabdato.particella=''))  then GliImmobiliDati.listaFabbricati.delete(k);
  end;
end;

Procedure TForm_Tracciato.ButtaEdificiToErase;
var  locFabdato : TFabCatDati;
     k : Integer;
begin
 for k := GliImmobiliDati.listaFabbricati.count-1 downto 0 do
  begin
   locFabdato := GliImmobiliDati.listaFabbricati.items[k];
   if (locFabdato.toerase)  then GliImmobiliDati.listaFabbricati.delete(k);
  end;
end;

Procedure TForm_Tracciato.ButtaPossessiEdificiToErase;
var  locpossesso : TPossesso;
     k : Integer;
begin
   for k := GliImmobiliDati.ListaPossessiFabbricati.count-1 downto 0 do
    begin
     locpossesso := GliImmobiliDati.ListaPossessiFabbricati.items[k];
     if (locpossesso.toerase)  then GliImmobiliDati.ListaPossessiFabbricati.delete(k);
    end;

   for k := 0 to GliImmobiliDati.ListaPossessiFabbricati.count-1 do
    begin
     locpossesso := GliImmobiliDati.ListaPossessiFabbricati.items[k];
     locpossesso.IdPossesso := IntToStr(k+1);
    end;

end;

Procedure TForm_Tracciato.ButtaPossessiTerreniToErase;
var  locpossesso : TPossesso;
     k : Integer;
begin
   for k := GliImmobiliDati.ListaPossessiTerra.count-1 downto 0 do
    begin
     locpossesso := GliImmobiliDati.ListaPossessiTerra.items[k];
     if (locpossesso.toerase)  then GliImmobiliDati.ListaPossessiTerra.delete(k);
    end;

   for k := 0 to GliImmobiliDati.ListaPossessiTerra.count-1 do
    begin
     locpossesso := GliImmobiliDati.ListaPossessiTerra.items[k];
     locpossesso.IdPossesso := IntToStr(k+1);
    end;

end;


Procedure TForm_Tracciato.ButtaTerreniToErase;
var  locTerdato : TTerCatDati;
     k : Integer;
begin
 for k := GliImmobiliDati.listaTerreni.count-1 downto 0 do
  begin
   locTerdato := GliImmobiliDati.listaTerreni.items[k];
   if (locTerdato.toerase)  then GliImmobiliDati.listaTerreni.delete(k);
  end;
end;


Procedure TForm_Tracciato.ButtaEdificiDoppi;
var  locFabdatok,locFabdatoj : TFabCatDati;
     k,j : Integer;
     deter : Boolean;
begin
 for k := GliImmobiliDati.listaFabbricati.count-1 downto 0 do
  begin
   locFabdatok := GliImmobiliDati.listaFabbricati.items[k];
    for j := GliImmobiliDati.listaFabbricati.count-1 downto 0 do
     begin
      if j=k then continue;
      locFabdatoj := GliImmobiliDati.listaFabbricati.items[j];
      if ((locFabdatoj.foglio = locFabdatok.foglio) and (locFabdatoj.particella = locFabdatok.particella)
           and ( locFabdatoj.Subalterno = locFabdatok.Subalterno) ) then
       begin
        if locFabdatoj.RenditaStrEuro>=locFabdatok.RenditaStrEuro then
          GliImmobiliDati.listaFabbricati.delete(k)  else GliImmobiliDati.listaFabbricati.delete(j);
        break;
       end;
     end;
  end;
end;


procedure TForm_Tracciato.elaboraTER;
var F : TextFile;
   riga, r1,r2 : String;
   tiporecord : Integer;
   inrep : Boolean;
   locTerdato : TTerCatDati;
   _codiceamministrativo : String;
   _sezione : String;
   _IdentificativoImmobile    : String;
   _Foglio                    : String;
   _Particella                : String;
   _Subalterno                : String;
   _Edificabile               : String;
   _Qualita                   : String;
   _QualitaCod                : String;
   _Classe                    : String;
   _RenditaAgrariaStrEuro     : String;
   _RenditaDomenicaleStrEuro  : String;
   _Superficie                : Integer;
   _ettari                    : String;
   _are                       : String;
   _centiare                  : String;

begin
 inrep := false;

    if inTolfa3 then nomeTer_Ter := 'D:\Tolfa\Catasto_Dati\Terreni_Tolfa\L192770227_1.TER'
               else nomeTer_Ter := 'D:\Magliano_Sabina\Catasto_Dati\Terreni_Magliano\E812758074_1.TER';



   assignFile(F,nomeTer_Ter); reset(F);
   while not(eof(F))  do
    begin
      readln(F,riga);
      if inrep then  ListBox1.Items.Add(riga);
       SpezzastringaBarra(riga,r1,riga);
        _codiceamministrativo := r1;
        if inrep then ListBox1.Items.Add('CODICE AMMINISTRATIVO    : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        _sezione := r1;
        if inrep then ListBox1.Items.Add('SEZIONE                  : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        _IdentificativoImmobile := r1;
        if inrep then ListBox1.Items.Add('IDENTIFICATIVO IMMOBILE  : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('TIPO IMMOBILE            : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('PROGRESSIVO              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('TIPO RECORD              : '+r1);

    tiporecord := strToInt(r1);




{
  Dati relativi al Comune
  CODICE AMMINISTRATIVO alfanumerico 4 caratteri.
  SEZIONE alfanumerico 1 carattere.
  La codifica delle sezioni è riportata nella tabella “Sezioni censuarie del catasto
  fabbricati e del catasto terreni”.
  Progressivo dell’immobile nella banca dati
  IDENTIFICATIVO IMMOBILE numerico 9 caratteri.
  Assume valore fisso T (terreni)
  TIPO IMMOBILE alfanumerico 1 carattere
  I valori dei due campi precedenti referenziano gli analoghi campi nel file delle
  titolarità e consentono di reperire i soggetti che vantano diritti sul bene.
  Numero progressivo delle situazioni oggettive dell’immobile
  PROGRESSIVO numerico 3 caratteri.
  Identificativo del tipo record del file particelle, assume valore fisso 1
  TIPO RECORD numerico 1 carattere
}
// se tiporecord = 1
{
  Elementi identificativi della particella
  FOGLIO numerico 5 caratteri.
  NUMERO alfanumerico 5 caratteri.
  DENOMINATORE numerico 4 caratteri.
  SUBALTERNO alfanumerico 4 caratteri.
}

case tiporecord of
 1 : begin

      locTerdato := TTerCatDati.Create;  GliImmobiliDati.listaTerreni.Add(locTerdato);

     locTerdato.codiceamministrativo   := _codiceamministrativo;
     locTerdato.sezione                := _sezione;
     locTerdato.IdentificativoImmobile := _IdentificativoImmobile;








        if inrep then ListBox1.Items.Add('');

       SpezzastringaBarra(riga,r1,riga);
        _Foglio := r1;
        locTerdato.Foglio := _Foglio;
        if inrep then ListBox1.Items.Add('FOGLIO                   : '+r1);

       SpezzastringaBarra(riga,r1,riga); r1:= Toglizeroiniziali(r1);
        _Particella := r1;
        locTerdato.Particella := _Particella;
        if inrep then ListBox1.Items.Add('NUMERO                   : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DENOMINATORE             : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        _Subalterno := r1;
        locTerdato.Subalterno := _Subalterno;
        if inrep then ListBox1.Items.Add('SUBALTERNO               : '+r1);
{
  EDIFICIALITA' alfanumerico 1 carattere.
  Dati caratteristici della particella
  QUALITA’ numerico 3 caratteri.
  La decodifica della qualità è riportata nella tabella “Codici qualità”.
  CLASSE alfanumerico 2 caratteri.
  ETTARI numerico 5 caratteri.
  ARE numerico 2 caratteri.
  CENTIARE numerico 2 caratteri.
  Dati relativi al reddito
  FLAG REDDITO alfanumerico 1 carattere.
  (0 calcolabile; 1 non calcolabile)
  FLAG PORZIONE alfanumerico 1 carattere.
  (0 assenti; 1 esistenza porzioni)
  FLAG DEDUZIONI alfanumerico 1 carattere.
  (0 assenti; 1 esistenza deduzioni)
  REDDITO-DOMINICALE LIRE numerico 9 caratteri.
  REDDITO-AGRARIO LIRE numerico 8 caratteri
  REDDITO-DOMINICALE EURO numerico 12 caratteri.
  (gli ultimi 3 caratteri sono decimali)
  REDDITO-AGRARIO EURO numerico 11 caratteri
  (gli ultimi 3 caratteri sono decimali)
}


       SpezzastringaBarra(riga,r1,riga);
        _Edificabile := r1;
        locTerdato.Edificabile  := _Edificabile;
        if inrep then ListBox1.Items.Add('EDIFICIALITA               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        _QualitaCod := r1;
        locTerdato.QualitaCod  := _QualitaCod;
        if inrep then ListBox1.Items.Add('QUALITA               : '+r1);

        _Qualita := QualitaTerrenodaCod(_QualitaCod);
        if _Qualita='' then showmessage(' Codice qualita terreno non conosciuto '+_QualitaCod);

       locTerdato.Qualita  := _Qualita;


       SpezzastringaBarra(riga,r1,riga);
        _Classe := toglizeroiniziali(r1);
        locTerdato.Classe  := _Classe;
        if inrep then ListBox1.Items.Add('CLASSE               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        _ettari := r1;
        locTerdato.ettari := _ettari;
        if inrep then ListBox1.Items.Add('ETTARI               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        _are := r1;
        locTerdato.are := _are;
        if inrep then ListBox1.Items.Add('ARE               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        _centiare := r1;
        locTerdato.centiare := _centiare;
        if inrep then ListBox1.Items.Add('CENTIARE               : '+r1);

         locTerdato.Superficie := 0;
        if locTerdato.ettari<>'' then locTerdato.Superficie := locTerdato.Superficie + StrToInt(locTerdato.ettari)*10000;
        if locTerdato.are<>'' then locTerdato.Superficie := locTerdato.Superficie + StrToInt(locTerdato.are)*100;
        if locTerdato.centiare<>'' then locTerdato.Superficie := locTerdato.Superficie + StrToInt(locTerdato.centiare);



// continue;

       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('FLAG REDDITO               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('FLAG PORZIONE               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('FLAG DEDUZIONI               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('REDDITO-DOMINICALE LIRE               : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('REDDITO-AGRARIO LIRE                : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        _RenditaDomenicaleStrEuro := r1;
        locTerdato.RenditaDomenicaleStrEuro := _RenditaDomenicaleStrEuro;
        if inrep then ListBox1.Items.Add('REDDITO-DOMINICALE Euro               : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        _RenditaAgrariaStrEuro := r1;
        locTerdato.RenditaAgrariaStrEuro := _RenditaAgrariaStrEuro;
        if inrep then ListBox1.Items.Add('REDDITO-AGRARIO Euro                : '+r1);



{
  Dati relativi all’atto che ha generato la situazione oggettiva della particella:
  DATA DI EFFICACIA numerico 8 caratteri.
  formato GGMMAAAA
  DATA DI REGISTRAZIONE IN ATTI numerico 8 caratteri.
  formato GGMMAAAA
  TIPO NOTA alfanumerico 1 carattere.
  La descrizione del tipo nota è riportata nella tabella “Tipo nota”.
  NUMERO NOTA alfanumerico 6 caratteri.
  PROGRESSIVO NOTA alfanumerico 3 caratteri.
  ANNO NOTA numerico 4 caratteri.
  Dati relativi all’atto che ha concluso la situazione oggettiva della particella:
  DATA DI EFFICACIA numerico 8 caratteri.
  formato GGMMAAAA
  DATA DI REGISTRAZIONE IN ATTI numerico 8 caratteri.
  formato GGMMAAAA
  TIPO NOTA alfanumerico 1 carattere.
  NUMERO NOTA alfanumerico 6 caratteri.
  PROGRESSIVO NOTA alfanumerico 3 caratteri.
  ANNO NOTA numerico 4 caratteri.
}

       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DATA DI EFFICACIA  GGMMAAAA              : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DATA DI REGISTRAZIONE IN ATTI                : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('TIPO NOTA                : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('NUMERO NOTA                 : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('PROGRESSIVO NOTA                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('ANNO NOTA                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if r1<>'' then locTerdato.toErase:=true;
        if inrep then ListBox1.Items.Add('DATA DI EFFICACIA                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if r1<>'' then locTerdato.toErase:=true;
        if inrep then ListBox1.Items.Add('DATA DI REGISTRAZIONE IN ATTI                 : '+r1);

       SpezzastringaBarra(riga,r1,riga);
        if r1<>'' then locTerdato.toErase:=true;
        if inrep then ListBox1.Items.Add('TIPO NOTA                   : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if r1<>'' then locTerdato.toErase:=true;
        if inrep then ListBox1.Items.Add('NUMERO NOTA                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if r1<>'' then locTerdato.toErase:=true;
        if inrep then ListBox1.Items.Add('PROGRESSIVO NOTA                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if r1<>'' then locTerdato.toErase:=true;
        if inrep then ListBox1.Items.Add('ANNO NOTA                 : '+r1);



{
  PARTITA (ove presente) alfanumerico 7 caratteri.
  Ulteriori informazioni sulle caratteristiche della particella
  ANNOTAZIONE alfanumerico 200 caratteri.
  Progressivo della mutazione che ha generato la situazione oggettiva della
  particella
  IDENTIFICATIVO MUTAZIONE INIZIALE numerico 9 caratteri
  Progressivo della mutazione che ha concluso la situazione oggettiva della
  particella
  IDENTIFICATIVO MUTAZIONE FINALE numerico 9 caratteri
  Dati relativi all’atto che ha generato la situazione oggettiva della particella
  CODICE CAUSALE ATTO GENERANTE alfanumerico 3 caratteri,
  DESCRIZIONE ATTO GENERANTE alfanumerico 100 caratteri,
  Dati relativi all’atto che ha concluso la situazione oggettiva della particella
  CODICE CAUSALE ATTO CONCLUSIVO alfanumerico 3 caratteri,
  DESCRIZIONE ATTO CONCLUSIVO alfanumerico 100 caratteri,
}
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('PARTITA                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('ANNOTAZIONE                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('IDENTIFICATIVO MUTAZIONE Iniziale                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('IDENTIFICATIVO MUTAZIONE FINALE                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('CODICE CAUSALE ATTO GENERANTE                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DESCRIZIONE ATTO GENERANTE                   : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('CODICE CAUSALE ATTO GENERANTE                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('CODICE CAUSALE ATTO CONCLUSIVO                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('DESCRIZIONE ATTO CONCLUSIVO                 : '+r1);
       if inrep then ListBox1.Items.Add(riga);
      end; // tiporecord = 1

      2:  begin end;
      3:  begin end;
      4:  begin
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('IDENTIFICATIVO PORZIONE                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('QUALITA’                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('CLASSE                  : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('ETTARI                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('ARE                 : '+r1);
       SpezzastringaBarra(riga,r1,riga);
        if inrep then ListBox1.Items.Add('CENTIARE                 : '+r1);
{
  · IDENTIFICATIVO PORZIONE alfanumerico 2 caratteri.
  · QUALITA’ numerico 3 caratteri.
  · CLASSE alfanumerico 2 caratteri.
  · ETTARI numerico 5 caratteri.
  · ARE numerico 2 caratteri.
  · CENTIARE
}
      end;
     end; // case
    end;
   closefile(F);

  GliImmobiliDati.togliterreni0Sup;
   ButtaTerreniToErase;
//   ButtaTerreniDoppi;


end;


procedure TForm_Tracciato.elaboraSOG(code : Integer);
var F : TextFile;
   riga, r1,r2 : String;
   tiporecord : Integer;
   tiposog : String;
   locSog     : TSoggetto;
   inrep: Boolean;
begin
  inrep := false;
 case code of
  1 : // fabbricati
   begin
    if inTolfa3 then nomeFab_Sog := 'D:\Tolfa\Catasto_Dati\Fabbricati_Tolfa\L192770226_1.SOG'
               else nomeFab_Sog := 'D:\Magliano_Sabina\Catasto_Dati\Fabbricati_Magliano\E812758075_1.SOG';
    assignFile(F,nomeFab_Sog);
   end;
  2 : // terreni
   begin
    if inTolfa3 then nomeTer_Sog := 'D:\Tolfa\Catasto_Dati\Terreni_Tolfa\L192770227_1.SOG'
               else nomeTer_Sog := 'D:\Magliano_Sabina\Catasto_Dati\Terreni_Magliano\E812758074_1.SOG';
    assignFile(F,nomeTer_Sog);
   end;
  end;

    reset(F);
    while not(eof(F))  do
     begin
      readln(F,riga);
      locSog := TSoggetto.Create;
      case code of
       1 : GliImmobiliDati.ListaProprietariFabbricati.Add(locSog);
       2 : GliImmobiliDati.ListaProprietariTerra.Add(locSog);
      end;

{
  CODICE AMMINISTRATIVO alfanumerico 4 caratteri.
  SEZIONE alfanumerico 1 carattere.
  La codifica delle sezioni è riportata nella tabella “Sezioni censuarie del catasto
  fabbricati e del catasto terreni”.
  Progressivo del soggetto nella banca dati
  IDENTIFICATIVO SOGGETTO numerico 9 caratteri.
  TIPO SOGGETTO alfanumerico 1 carattere
  P = persona fisica
  I valori dei due campi precedenti referenziano gli analoghi campi nel file delle
  titolarità e consentono di reperire i beni su cui il soggetto vanta diritti.
  ------------ Totale chiave 15 caratteri.
  Dati anagrafici
  COGNOME alfanumerico 50 caratteri.
  NOME alfanumerico 50 caratteri.
  SESSO alfanumerico 1 carattere
  1 = maschio
  2 = femmina.
  DATA DI NASCITA numerico 8 caratteri.
  formato GGMMAAAA
  Codice amministrativo del comune di nascita
  LUOGO DI NASCITA alfanumerico 4 caratteri.
  CODICE FISCALE alfanumerico 16 caratteri.
}

      SpezzastringaBarra(riga,r1,riga);
       locSog.CodiceAmministrativo :=r1;
       if inrep then ListBox1.Items.Add('CODICE AMMINISTRATIVO                 : '+r1);

      SpezzastringaBarra(riga,r1,riga);
       locSog.Sezione:=r1;
        if inrep then ListBox1.Items.Add('SEZIONE                 : '+r1);

      SpezzastringaBarra(riga,r1,riga);
        locSog.Identificativo:=r1;
        if inrep then ListBox1.Items.Add('IDENTIFICATIVO SOGGETTO                 : '+r1);

      SpezzastringaBarra(riga,r1,riga);
        locSog.TipoSoggetto:=r1;
        if inrep then ListBox1.Items.Add('TIPO SOGGETTO                 : '+r1);

      tiposog :=r1;
      if tiposog='P' then
       begin
        SpezzastringaBarra(riga,r1,riga);
          locSog.Cognome:= r1;
          if inrep then ListBox1.Items.Add('COGNOME                 : '+r1);
        SpezzastringaBarra(riga,r1,riga);
          locSog.Nome:= r1;
          if inrep then ListBox1.Items.Add('NOME                 : '+r1);
        SpezzastringaBarra(riga,r1,riga);
          locSog.CodSesso := r1;
          if inrep then ListBox1.Items.Add('sesso                 : '+r1);
        SpezzastringaBarra(riga,r1,riga);
          locSog.DataNascitaStr:=r1;
          if inrep then ListBox1.Items.Add('Data Nascita                 : '+r1);
        SpezzastringaBarra(riga,r1,riga);
          locSog.LuogoNascita:=r1;
          if inrep then ListBox1.Items.Add('Luogo Nascita cod                : '+r1);
        SpezzastringaBarra(riga,r1,riga);
          locSog.CodiceFiscale:= r1;
          if inrep then ListBox1.Items.Add('Codice fiscale                 : '+r1);
       end;

      if tiposog='G' then
       begin
{
  Dati identificativi della persona giuridica
  DENOMINAZIONE alfanumerico 150 caratteri.
  Codice amministrativo del comune dove ha sede il soggetto
  SEDE alfanumerico 4 caratteri.
  CODICE FISCALE numerico 11 caratteri.
}
        SpezzastringaBarra(riga,r1,riga);
          locSog.DenominazioneAzienda:= r1;
          if inrep then ListBox1.Items.Add('DENOMINAZIONE                 : '+r1);
        SpezzastringaBarra(riga,r1,riga);
          locSog.CodiceSedeAzienda:= r1;
          if inrep then ListBox1.Items.Add('SEDE                 : '+r1);
        SpezzastringaBarra(riga,r1,riga);
          locSog.CFAzienda:= r1;
          if inrep then ListBox1.Items.Add('Codice fiscale                 : '+r1);
       end;
     end;
    closefile(F);

end;


procedure TForm_Tracciato.elaboraTIT(code : Integer);
var F           : TextFile;
    riga, r1,r2 : String;
    tiporecord  : Integer;
    tiposog     : String;
    inrep       : Boolean;
    locPoss    : TPossesso;
begin
 inrep := false;
 case code of
  1 : // fabbricati
   begin
    if inTolfa3 then nomeFab_Tit := 'D:\Tolfa\Catasto_Dati\Fabbricati_Tolfa\L192770226_1.TIT'
               else nomeFab_Tit := 'D:\Magliano_Sabina\Catasto_Dati\Fabbricati_Magliano\E812758075_1.TIT';
    assignFile(F,nomeFab_Tit);
   end;
  2 : // terreni
   begin
    if inTolfa3 then nomeTer_Tit := 'D:\Tolfa\Catasto_Dati\Terreni_Tolfa\L192770227_1.TIT'
               else nomeTer_Tit := 'D:\Magliano_Sabina\Catasto_Dati\Terreni_Magliano\E812758074_1.TIT';
    assignFile(F,nomeTer_Tit);
   end;
 end;




    reset(F);
    while not(eof(F))  do
     begin
      readln(F,riga);
       locPoss := TPossesso.Create;

       case code of
        1 : // fabbricati
         begin
          locPoss.IdPossesso := IntToStr(GliImmobiliDati.ListaPossessiFabbricati.count);
          GliImmobiliDati.ListaPossessiFabbricati.Add(locPoss);
         end;
        2 : // terreni
         begin
          locPoss.IdPossesso := IntToStr(GliImmobiliDati.ListaPossessiTerra.count);
          GliImmobiliDati.ListaPossessiTerra.Add(locPoss);
         end;
       end;


        SpezzastringaBarra(riga,r1,riga);
         locPoss.CodiceAmministrativo := r1;
         if inrep then ListBox1.Items.Add('CODICE AMMINISTRATIVO                 : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         locPoss.Sezione := r1;
         if inrep then ListBox1.Items.Add('SEZIONE                               : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         locPoss.IdentificativoSoggetto := r1;
         if inrep then ListBox1.Items.Add('IDENTIFICATIVO SOGGETTO               : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         locPoss.TipoSoggetto := r1;
         if inrep then ListBox1.Items.Add('TIPO SOGGETTO                         : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         locPoss.IdentificativoImmobile := r1;
         if inrep then ListBox1.Items.Add('IDENTIFICATIVO IMMOBILE               : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         locPoss.TipoImmobile := r1;
         if inrep then ListBox1.Items.Add('TIPO IMMOBILE                         : '+r1);


        SpezzastringaBarra(riga,r1,riga);
         locPoss.CodiceDiritto := r1;
         if inrep then ListBox1.Items.Add('CODICE DIRITTO                         : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         locPoss.TitoloNonCodificato := r1;
         if inrep then ListBox1.Items.Add('TITOLO NON CODIFICATO                         : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         locPoss.QuotaNumeratore := r1;
         if inrep then ListBox1.Items.Add('QUOTA NUMERATORE                        : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         locPoss.QuotaDenominatore := r1;
         if inrep then ListBox1.Items.Add('QUOTA DENOMINATORE                         : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         locPoss.Regime := r1;
         if inrep then ListBox1.Items.Add('REGIME                         : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('SOGGETTO DI RIFERIMENTO                         : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         locPoss.DatavaliditaStr := r1;
         if inrep then ListBox1.Items.Add('DATA DI VALIDITA                         : '+r1);
        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('TIPO NOTA                         : '+r1);
        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('NUMERO NOTA                         : '+r1);
        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('PROGRESSIVO NOTA                         : '+r1);
        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('ANNO NOTA                        : '+r1);
        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('DATA DI REGISTRAZIONE IN ATTI                        : '+r1);



        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('PARTITA                          : '+r1);
        SpezzastringaBarra(riga,r1,riga);
         if r1<>'' then locPoss.toerase := true;
         if inrep then ListBox1.Items.Add('DATA DI VALIDITA                 : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         if r1<>'' then locPoss.toerase := true;
         if inrep then ListBox1.Items.Add('Tipo Nota                        : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('NUMERO NOTA                      : '+r1);
        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('PROGRESSIVO NOTA                 : '+r1);
        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('ANNO NOTA                        : '+r1);
        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('DATA DI REGISTRAZIONE IN ATTI    : '+r1);


        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('IDENTIFICATIVO MUTAZIONE INIZIALE    : '+r1);
        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('IDENTIFICATIVO MUT AZIONE FINALE    : '+r1);
        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('IDENTIFICATIVO TITOLARITA     : '+r1);
        SpezzastringaBarra(riga,r1,riga);
         if inrep then ListBox1.Items.Add('CODICE CAUSALE ATTO GENERANTE     : '+r1);

// !!!! non piu' esistente visto che concluso
        SpezzastringaBarra(riga,r1,riga);
         if r1<>'' then locPoss.toerase := true;
         if inrep then ListBox1.Items.Add('CODICE CAUSALE ATTO CONCLUSIVO   : '+r1);

        SpezzastringaBarra(riga,r1,riga);
         if r1<>'' then locPoss.toerase := true;
         if inrep then ListBox1.Items.Add('DESCRIZIONE ATTO CONCLUSIVO    : '+r1);



     end;

     closefile(F);

            case code of
              1 :  ButtaPossessiEdificiToErase; // fabbricati
              2 :  ButtaPossessiTerreniToErase; // Terreni
             end;


            case code of
              1 : // fabbricati
               begin
                showmessage('Fabbricati:'+IntToStr(GliImmobiliDati.ListaPossessiFabbricati.count));
               end;
              2 : // terreni
               begin
//                showmessage('Terreni:'+IntToStr(GliImmobiliDati.ListaPossessiTerra.count));
               end;
             end;




end;

procedure TForm_Tracciato.FormCreate(Sender: TObject);
begin
 inTolfa3 := true;
end;

procedure TForm_Tracciato.But_DaImuClick(Sender: TObject);
var kf,kc,ke : integer;
    locfam ,famcomp : TFamiglia;
    locImu : TImu;
    LaLista : TList;
    locedif : TFabCatDati;
begin
 LaLista := TList.Create;
 Ilprogetto.OpenInfoTributiAnagrafe;
   for kf := 0 to LaAnagrafe.listaFamiglie.Count-1 do
    begin
     locfam := LaAnagrafe.listaFamiglie.items[kf];
     if locfam.associato then continue;
     LaLista.clear;
     for kc:=0 to  locfam.ListaImu.Count-1 do
      begin
       locImu := locfam.ListaImu.items[kc];
       if locImu.inIndirizzo(locfam.Indirizzo) then
        begin
         LaLista.add(locImu);
        end;
      end;

       if LaLista.count>1 then
        begin
         for ke := LaLista.count-1 downto 0 do
          begin
           locImu := LaLista.items[ke];
           locedif := GliImmobiliDati.FabDatoFgPartSub(locImu.Foglio,locImu.Particella,locImu.Subalterno);
           if locedif<>nil then
            begin
             if length(locedif.Categoria)=0 then continue;
             if locedif.Categoria[1]='A' then
              begin
               LaLista.delete(ke);
               LaLista.insert(0,locImu);
               break;
              end;
            end;
          end;
        end;

       if LaLista.count>0 then
        begin
         locImu := LaLista.items[0];
         locedif := GliImmobiliDati.FabDatoFgPartSub(locImu.Foglio,locImu.Particella,locImu.Subalterno);
         if locedif<>nil then
          begin
           locfam.Foglio     := locImu.Foglio;
           locfam.Particella := locImu.Particella;
           locfam.Subalterno := locImu.Subalterno;
           locfam.associato := true;
           if LaLista.count=1 then locfam.valAssociazione := '30' else locfam.valAssociazione := '32';
           locedif.Topo_Anagrafe   := locfam.Toponimo;
           locedif.Via_Anagrafe    := locfam.Indirizzo;
           locedif.Civico_Anagrafe := locfam.civico;
           if (locedif.Topo_Anagrafe   = interpretaTopoCatastale(locedif.Topo_Catastale)) then locedif.Topo_Corretta := locedif.Topo_Anagrafe;
           if (locedif.Via_Anagrafe    = locedif.Via_Catastale)   then locedif.Via_Corretta  := locedif.Via_Anagrafe;
           if (locedif.Civico_Anagrafe = locedif.Civico_Catastale) then locedif.Civico_Corretta := locedif.Civico_Anagrafe;
           locedif.Residenti.Add(locfam);
          end
           else
        // non sono riuscito a trovare il sub ma provo con il solo fg,part
          begin
           locedif := GliImmobiliDati.FabDatoFgPart_primo(locImu.Foglio,locImu.Particella);
           if locedif<>nil then
            begin
             locfam.Foglio     := locImu.Foglio;
             locfam.Particella := locImu.Particella;
             locfam.Subalterno := '?';
             locfam.associato := true;
             locfam.valAssociazione := '38';
            end;
          end;
        end;
    end;
 LaLista.Free;

  GliImmobiliDati.salvaInfoAnagrafe(NomefileAnagrafeInfo);
  GliImmobiliDati.salvafabbricati(NomefileFabbricatidati);
  LaAnagrafe.salva(NomefileAnagrafe);
end;

procedure TForm_Tracciato.But_AnagrafeClick(Sender: TObject);
var baseSalvataggio : String;
    nomefileToSaveTxt : String;
begin
 if inTolfa3 then baseSalvataggio:='D:\Tolfa\Dati\Catasto\'
            else baseSalvataggio:='D:\Magliano_Sabina\Dati\Catasto\';
       ElaboraAnagrafe;
       nomefileToSaveTxt :=  baseSalvataggio+'Anagrafe.txt';
       LaAnagrafe.salva(nomefileToSaveTxt);
end;

procedure TForm_Tracciato.But_associa_IMUClick(Sender: TObject);
var k,j : Integer;
    locFabdato : TFabCatDati;
    locImu : TImu;
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
 for k:= 0 to GliImmobiliDati.listaFabbricati.Count-1 do
  begin
   locFabdato := GliImmobiliDati.listaFabbricati.items[k];
    for j:= 0 to GliImmobiliDati.ListaImu.Count-1 do
     begin
      locImu:= GliImmobiliDati.ListaImu.items[j];
      if ((locFabdato.foglio = locImu.Foglio) and (locFabdato.Particella = locImu.Particella) and (locFabdato.subalterno = locImu.subalterno) ) then
       begin
        locFabdato.ICI_paganti.Add(locImu);
        locImu.associato:=true;
       end;
     end;
  end;

 GliImmobiliDati.salvafabbricati(NomefileFabbricatidati);
 GliImmobiliDati.SalvaImu(NomefileImu);
end;

procedure TForm_Tracciato.But_associa_TaresClick(Sender: TObject);
var k,j : Integer;
    locFabdato : TFabCatDati;
    locTares : TTares;
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
 for k:= 0 to GliImmobiliDati.listaFabbricati.Count-1 do
  begin
   locFabdato  := GliImmobiliDati.listaFabbricati.items[k];
    for j:= 0 to GliImmobiliDati.listaTares.Count-1 do
     begin
      locTares := GliImmobiliDati.listaTares.items[j];
      if ((locFabdato.foglio = locTares.Foglio) and (locFabdato.Particella = locTares.Particella) and (locFabdato.subalterno = locTares.subalterno) ) then
       begin
        locFabdato.Tares_paganti.Add(locTares);
        locTares.associato:=true;
       end;
     end;
  end;

 GliImmobiliDati.salvafabbricati(NomefileFabbricatidati);
 GliImmobiliDati.SalvaTares(NomefileTares);

end;

procedure TForm_Tracciato.But_AzionaTerreniClick(Sender: TObject);
var  G , H : TextFile;
    riga : String;
    r1,r2 : String;
    tiporecord : Integer;
    nomefileFabTxt : String;
    nomefileTerTxt : String;
    nomefileToSaveTxt : String;
    baseSalvataggio : String;

begin
// if ( fileexists(nomeTer_sog)  and fileexists(nomeTer_Ter) and fileexists(nomeTer_Tit) ) then
 if inTolfa3 then baseSalvataggio:='D:\Tolfa\Dati\Catasto\'
            else baseSalvataggio:='D:\Magliano_Sabina\Dati\Catasto\';

  begin

       elaboraSOG(1);
         nomefileToSaveTxt :=  baseSalvataggio+'SoggettiFabbricati.txt';
         GliImmobiliDati.SalvaProprietari(1,nomefileToSaveTxt);
        elaboraSOG(2);
         nomefileToSaveTxt :=  baseSalvataggio+'SoggettiTerreni.txt';
         GliImmobiliDati.SalvaProprietari(2,nomefileToSaveTxt);



            elaboraTIT(1);
               nomefileToSaveTxt := baseSalvataggio+'PossessiFabbricati.txt';
               GliImmobiliDati.SalvaTitoloProp(1,nomefileToSaveTxt);
              elaboraTIT(2);
               nomefileToSaveTxt :=  baseSalvataggio+'PossessiTerreni.txt';
               GliImmobiliDati.SalvaTitoloProp(2,nomefileToSaveTxt);





               elaboraFAB;
               GliImmobiliDati.associaPossessi(1);
               nomefileFabTxt :=  baseSalvataggio+'Fabbricati.txt';
               GliImmobiliDati.salvafabbricati(nomefileFabTxt);



             elaboraTER;
              GliImmobiliDati.associaPossessi(2);
              nomefileTerTxt :=  baseSalvataggio+'Terreni.txt';
              GliImmobiliDati.salvaTerreni(nomefileTerTxt);




   GliImmobiliDati.caricata := true;
  end
//   else beep();
end;

procedure TForm_Tracciato.But_ImuClick(Sender: TObject);
var baseSalvataggio : String;
    nomefileToSaveTxt : String;
begin
 if inTolfa3 then baseSalvataggio:='D:\Tolfa\Dati\Catasto\'
            else baseSalvataggio:='D:\Magliano_Sabina\Dati\Catasto\';
       ElaboraImu;
       nomefileToSaveTxt :=  baseSalvataggio+'Imu.txt';
       GliImmobiliDati.SalvaImu(nomefileToSaveTxt);
end;


procedure TForm_Tracciato.But_stessocivicoedifClick(Sender: TObject);
var kf,kc : integer;
    locfam ,famcomp : TFamiglia;
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
   for kf := 0 to LaAnagrafe.listaFamiglie.Count-1 do
    begin
     locfam := LaAnagrafe.listaFamiglie.items[kf];
     if locfam.associato then continue;
     for kc :=0 to LaAnagrafe.listaFamiglie.Count-1 do
      begin
       if kc = kf then continue;
       famcomp := LaAnagrafe.listaFamiglie.items[kc];
       if (locfam.Indirizzo = famcomp.Indirizzo) then
        begin
         if locfam.civico='' then continue;
         if Uppercase(locfam.civico)='SNC' then continue;
         if (locfam.civico = famcomp.civico) then
          begin
           locfam.associato := true;
           locfam.valAssociazione:='30';
           locfam.Foglio     := famcomp.foglio;
           locfam.Particella := famcomp.Particella;
           locfam.Subalterno := famcomp.Subalterno;
          break;
          end;
        end;
      end;
    end;
 LaAnagrafe.salva(NomefileAnagrafe);
end;

procedure TForm_Tracciato.But_Ter_SOGClick(Sender: TObject);
begin
 OpenCat.FilterIndex:=3;
 if OpenCat.Execute then
  begin
   nomeTer_sog   := OpenCat.FileName;
   But_Ter_Sog.Caption := extractFilename(nomeTer_sog);
  end;


end;

procedure TForm_Tracciato.But_Ter_TERClick(Sender: TObject);
begin
 OpenCat.FilterIndex:=1;
 if OpenCat.Execute then
  begin
   nomeTer_Ter   := OpenCat.FileName;
   But_Ter_Ter.Caption := extractFilename(nomeTer_Ter);
    ListBox1.Items.Add(nomeTer_Ter);
  end;
end;

procedure TForm_Tracciato.But_Ter_TITClick(Sender: TObject);
begin
 OpenCat.FilterIndex:=2;
 if OpenCat.Execute then
  begin
   nomeTer_Tit   := OpenCat.FileName;
   But_Ter_Tit.Caption := extractFilename(nomeTer_Tit);
  end;
end;

procedure TForm_Tracciato.ElaboraImu;
var F             : TextFile;
    nomeImu_csv   : String;
    riga,r1       : String;
    inrep         : Boolean;
    locImu        : TImu;
    k             : integer;
    precImu       : TImu;
begin
  inrep := false;  precImu  := nil;
  nomeImu_csv := 'D:\Magliano_Sabina\Catasto_Dati\Imucsv.csv';
  if Not(fileexists(nomeImu_csv)) then begin beep; exit; end;
   assignFile(F,nomeImu_csv); reset(F);
   if not(eof(F)) then readln(F,riga);

//   GliImmobiliDati.ListaTares

   while not(eof(F)) do
    begin
     readln(F,riga);
     locImu := TImu.Create;
     locImu.indice := inttostr(GliImmobiliDati.ListaImu.count);
     GliImmobiliDati.ListaImu.Add(locImu);


     SpezzaStringaDotcoma(riga,r1,riga);
     SpezzaStringaDotcoma(riga,r1,riga);
     SpezzaStringaDotcoma(riga,r1,riga);

     SpezzaStringaDotcoma(riga,r1,riga);
     locImu.CFIVA:=r1;

     SpezzaStringaDotcoma(riga,r1,riga);
     SpezzaStringaDotcoma(riga,r1,riga);
     SpezzaStringaDotcoma(riga,r1,riga);
     SpezzaStringaDotcoma(riga,r1,riga);

     SpezzaStringaDotcoma(riga,r1,riga);   locImu.Cognome:=r1;
     SpezzaStringaDotcoma(riga,r1,riga);   locImu.Nome:=r1;

     for k:=1 to 24 do  SpezzaStringaDotcoma(riga,r1,riga);


     for k:=1 to 17 do  SpezzaStringaDotcoma(riga,r1,riga);

     SpezzaStringaDotcoma(riga,r1,riga);   locImu.Foglio:=r1;
     SpezzaStringaDotcoma(riga,r1,riga);   locImu.Particella:=r1;
     SpezzaStringaDotcoma(riga,r1,riga);   locImu.Subalterno:=r1;
     SpezzaStringaDotcoma(riga,r1,riga);   locImu.Categoria:=r1;

     for k:=1 to 3 do  SpezzaStringaDotcoma(riga,r1,riga);

     SpezzaStringaDotcoma(riga,r1,riga);   locImu.Indirizzo:=r1;


     for k:=1 to 21 do  SpezzaStringaDotcoma(riga,r1,riga);
     SpezzaStringaDotcoma(riga,r1,riga);   locImu.RenditaStr:=r1;
     SpezzaStringaDotcoma(riga,r1,riga);   locImu.ValoreStr:=r1;

     if precImu<>nil then
      begin
       if ((locImu.Cognome='') and (locImu.Nome='')) then
        begin
         locImu.cognome := precImu.Cognome;
         locImu.nome    := precImu.nome;
        end;
      end;
     precImu := locImu;
    end;
   closefile(F);

   TogliImuSenzaFgPart;

end;

procedure TForm_Tracciato.TogliImuSenzaFgPart;
var locImu        : TImu;
    k : integer;
begin
 for k:=GliImmobiliDati.ListaImu.count-1 downto 0 do
  begin
   locImu := GliImmobiliDati.ListaImu.items[k];
   if ((locImu.foglio='') or (locImu.particella='')) then
    begin
     GliImmobiliDati.ListaImu.delete(k);
     locImu.Free;
    end;
  end;

 for k:=0 to GliImmobiliDati.ListaImu.count-1 do
  begin
   locImu := GliImmobiliDati.ListaImu.items[k];
   locImu.indice := intToStr(k);
  end;

end;


procedure TForm_Tracciato.ElaboraTares;
var F             : TextFile;
    nomeTares_csv : String;
    riga,r1       : String;
    inrep         : Boolean;
    loctares      : TTares;
begin
  inrep := false;
  nomeTares_csv := 'D:\Magliano_Sabina\Catasto_Dati\TAREScsv.csv';
  if Not(fileexists(nomeTares_csv)) then begin beep; exit; end;
   assignFile(F,nomeTares_csv); reset(F);
   if not(eof(F)) then readln(F,riga);
   if not(eof(F)) then readln(F,riga);

//   GliImmobiliDati.ListaTares

   while not(eof(F)) do
    begin
     readln(F,riga);
     loctares := TTares.Create;
     loctares.indice := inttostr(GliImmobiliDati.ListaTares.count);
     GliImmobiliDati.ListaTares.Add(loctares);


     SpezzaStringaDotcoma(riga,r1,riga);
     loctares.Cognome:=r1;

     SpezzaStringaDotcoma(riga,r1,riga);
     loctares.Nome:=r1;

     SpezzaStringaDotcoma(riga,r1,riga);
     loctares.CFIVA:=r1;

     SpezzaStringaDotcoma(riga,r1,riga);

     SpezzaStringaDotcoma(riga,r1,riga);      loctares.Indirizzo:=r1;

     SpezzaStringaDotcoma(riga,r1,riga);

     SpezzaStringaDotcoma(riga,r1,riga);      loctares.Foglio:=r1;
     SpezzaStringaDotcoma(riga,r1,riga);      loctares.Particella:=r1;
     SpezzaStringaDotcoma(riga,r1,riga);      loctares.Subalterno:=r1;
     SpezzaStringaDotcoma(riga,r1,riga);      loctares.Categoria:=r1;

     SpezzaStringaDotcoma(riga,r1,riga);
     SpezzaStringaDotcoma(riga,r1,riga);

     SpezzaStringaDotcoma(riga,r1,riga);      loctares.DataIscStr:=r1;
     SpezzaStringaDotcoma(riga,r1,riga);      loctares.MqTarsuStr:=r1;
     SpezzaStringaDotcoma(riga,r1,riga);      loctares.MqCatacStr:=r1;


    end;

//   showmessage(riga);
   closefile(F);

end;



procedure TForm_Tracciato.ElaboraAnagrafe;
var F            : TextFile;
    nomeAnag_csv : String;
    riga,r1      : String;
    inrep        : Boolean;
    fampresente  : Boolean;
    k            : Integer;
    testFam      : TFamiglia;
    locFam       : TFamiglia;
    loccodFam    : String;
    locCognome   : String;
    locNome      : String;
    locResidente : TResidente;
    loctopo      : String;
    locindirizzo : String;
    loccivico    : String;
    locCF        : String;
begin
  inrep := false;
  nomeAnag_csv := 'D:\Magliano_Sabina\Catasto_Dati\anagrafecsv.csv';
  if Not(fileexists(nomeAnag_csv)) then begin beep; exit; end;
   assignFile(F,nomeAnag_csv); reset(F);
   if not(eof(F)) then readln(F,riga);

   while not(eof(F)) do
    begin
     readln(F,riga);

     SpezzaStringaDotcoma(riga,r1,riga);
     loccodFam := r1;
     if inrep then ListBox1.Items.Add('cod Fam      : '+r1);

     fampresente := false;

     for k := 0 to LaAnagrafe.listaFamiglie.count-1 do
      begin
       testFam := LaAnagrafe.listaFamiglie.items[k];
       if testFam.codfamily = loccodFam then
        begin
          fampresente := True;
          locFam := testFam;
          break;
        end;
      end;

      if not(fampresente) then
       begin
        locFam:= TFamiglia.Create;
        locFam.codfamily := loccodFam;
        LaAnagrafe.listaFamiglie.add(locfam);
       end;


     SpezzaStringaDotcoma(riga,r1,riga);

     SpezzaCognomenome(r1,locCognome,locnome);



     locResidente := TResidente.create;
     locResidente.cognome := locCognome;
     locResidente.nome    := locNome;
     locResidente.famer   := locFam;
     locResidente.famiglia:=locFam.codfamily;
     locFam.ListaFamiglia.Add(locResidente);
     LaAnagrafe.listaResidenti.add(locResidente);

     SpezzaStringaDotcoma(riga,r1,riga);
     loctopo := r1;
     if not(fampresente) then begin locFam.Toponimo := loctopo; end;

     SpezzaStringaDotcoma(riga,r1,riga);
     locindirizzo := r1;
     if not(fampresente) then begin locFam.Indirizzo := locindirizzo; end;

     SpezzaStringaDotcoma(riga,r1,riga);
     loccivico := r1;
     if not(fampresente) then begin locFam.civico := loccivico; end;

     SpezzaStringaDotcoma(riga,r1,riga);
     locCF := r1;
     locResidente.CF := locCF;

    end;
   closefile(F);


end;



end.
