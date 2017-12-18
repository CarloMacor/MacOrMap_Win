unit Varbase;

interface

uses sysutils,System.classes,  GR32,  GR32_Image, VCL.dialogs

  ,Winapi.Windows, Winapi.Messages,

  System.Variants,  Vcl.Graphics
;

procedure initvarbase;


 type
  Tipovector  = (NNulla, PPunto, PPlinea, PPoligono, PCerchio, PTesto, PSimbolo, PArco,PCivico);
  Tipocomando = (kStato_nulla, kStato_Punto, kStato_Polilinea, kStato_Poligono, kStato_Regione,   CSimbolo, CArco,  kStato_Civico,
                 kStato_Testo,kStato_TestoRuotato,kStato_TestoRotoScalato, kStato_CatPoligono  ,kStato_Cerchio, kStato_TestoRot,  kStato_TestoRotSca,
                 kStato_PtTastiera,kStato_Simbolo,kStato_SimboloFisso,kStato_SimboloRot, kStato_SimboloRotSca,
                 kStato_Rettangolo,kStato_Righello, kStato_DistRighello,   kStato_txtstradale,
                 kStato_SpostaDisegno,  kStato_SpostaDisegnoptDlg,
                 kStato_FixVCentroRot, kStato_Seleziona, kStato_Deseleziona,kStato_CancellaSelected,
                 kStato_SpostaSelected, kStato_CopiaSelected, kStato_RuotaSelected, kStato_ScalaSelected,
                 kStato_Info,kStato_InfoSup, kStato_InfoLeg, kStato_InfoIntersezione2Poligoni, kStato_InfoEdificio,
                 kStato_Match, kStato_TarquiniaFogliopt, kStato_RettangoloStampa ,kStato_RettangoloDoppioStampa,

                  kStato_SpostaVertice, kStato_InserisciVertice, kStato_CancellaVertice ,kStato_zoomWindow
                  , kstato_editText
                 ,kStato_zoomC,kStato_Pan
                 ,kStato_SpostaPosCivico

                 ,kStato_spostaRaster_tutti,  kStato_spostaRaster2pt_tutti,  kStato_spostaRaster_uno
                 ,kStato_rotoScal2PtCentrato, kStato_spostaRaster2pt_uno,    kStato_scalarighello
                 ,kStato_rotoscalaraster,     kStato_calibra8click,          kStato_Calibraraster,     kStato_CalibrarasterFix
                 ,kStato_FixCentroRot,        kStato_CropRasterRettangolo
                 ,kStato_InfoConcessione
                 // le 4 barre sul disegno vettoriale
                 , kStato_FixCentroRotVettoriale
                 // procedure sviluppo
                 ,kstato_spostaTerritorioPrCoord
                 ,kStato_TagliaPoligono
                 ,kStato_DefStampa
  );


var b_SnapFine , b_SnapVicino, b_SnapOrto, b_SnapOrtoSeg, b_SnapGriglia : Boolean;

    catastoselezonabile : Boolean;
    xOrigineVista, yOrigineVista,ScalaVista : Real;
    x2origineVista,y2origineVista           : Real;
  	xprezoomw,yprezoomw,sprezoomw           : Real;

    TxtCatastoOnOff                         : Boolean;

    xmouse       , ymouse                   : Real;
    xmouseProj   , ymouseProj               : Real;
    xsnap        , ysnap                    : Real;
    xmouseI      , ymouseI                  : Integer;
   	xclickdown   , yclickdown               : Integer;
   	x1virt       , y1virt                   : Integer;
   	x2virt       , y2virt                   : Integer;
    xcoordLast   , ycoordLast               : Real;
    x1coord      , y1coord                  : Real;
    x2coord      , y2coord                  : Real;
    x3coord      , y3coord                  : Real;
    x4coord      , y4coord                  : Real;
    lastdist                                : Real;
    xprecVirt    , yprecVirt                : Real;

    xOriginePrePan , yOriginePrePan         : Real;
    xstMiddleI     , ystMiddleI             : Integer;
    xIPan , yIPan                           : Integer;
    mouseMiddleIsDown                       : Boolean;
    Hschermo                                : Integer;
    Wschermo                                : Integer;
    EsternostampadimYpx                     : Integer;

    ProiezioneCorrente    : Integer;
    fasecomando                             : Integer;
    dimmirino                               : Integer;
    comando                                 : TipoComando;
    Lastcomando                             : TipoComando;
    offsetmirino                            : Real;

    MUndor                                  : TList;

    parahTesto                              : Real;
    altezzatesto_InInserimento : Real;
    testoTxt_InInserimento     : String;

    scrollDown : Boolean;
    comandocorrente : Integer;

    directoryapertura : String;
    DirDatiFotoAeree  : String;
    DirCXFComune      : String;
    MaindirDati       : String;
    NomefileAnagrafe  : String;
    NomefileAnagrafeInfo  : String;
    NomefileQUnione   : String;
    NomefileFabbricatidati      : String;
    NomefileTerrenidati         : String;
    NomefileProprietariTerra    : String;
    NomefileProprietariEdifici  : String;
    NomefilePossessiTerreni     : String;
    NomefilePossessiEdifici     : String;
    NomefileTares               : String;
    NomefileImu                 : String;
    NomefileStrade              : String;
    NomefileCivici              : String;
    NomefileToponomastica       : String;

    dirDisegniConcessioni       : String;
    NomeFileSoggettiConcessioni : String;

    ColoreSfondo: TColor32;

    Mom1 , Mom2 , Mom3 : Boolean;


   	// Limiti
	  limx1DisR,  limy1DisR,  limx2DisR,  limy2DisR  : Real;  // limiti del disegno RASTER corrente
	  limx1Ras,	  limy1Ras,	  limx2Ras,	  limy2Ras   : Real;  // limiti del singolo Raster corrente
	  limx1DisV,  limy1DisV,	limx2DisV,	limy2DisV  : Real;  // limiti del disegno VETTORIALE corrente
	  limx1Piano, limy1Piano,	limx2Piano, limy2Piano : Real;  // limiti del singolo PIANO corrente
	  limx1Tutto, limx2Tutto,	limy1Tutto,	limy2Tutto : Real;  // limiti del tutto.

    LimTerx1 , LimTery1 , LimTerx2 , LimTery2 , scalater: real;
    dimPicTer,MaxKool : Integer;

    // griglia
    B_Griglia_Utm84 : Boolean;
    B_Griglia_Utm50 : Boolean;
    B_Griglia_Sfer84 : Boolean;
    B_Griglia_Sfer50 : Boolean;
    B_Griglia_cassini : Boolean;
    opzioneGr1 : Integer;
    opzioneGr2 : Integer;
    opzioneGr3 : Integer;
    opzioneGr4 : Integer;
    opzioneGr5 : Integer;
    GridColor1 : Tcolor;
    GridColor2 : Tcolor;
    GridColor3 : Tcolor;
    GridColor4 : Tcolor;
    GridColor5 : Tcolor;


    incomandotrasparente : Boolean;


    image_pdf    : TBitmap;
    image_pdfrid : TBitmap;
    image_tarsu1 : TBitmap;
    image_tarsu_rid : TBitmap;
    image_ici1   : TBitmap;
    image_tarsu2 : TBitmap;
    image_ici2   : TBitmap;
    image_casaverde   : TBitmap;
    image_pianta      : TBitmap;
    image_proprietario: TBitmap;
    image_prop_rid    : TBitmap;
    image_propr_rid   : TBitmap;
    image_piantarid   : TBitmap;
    image_c2          : TBitmap;
    image_c6          : TBitmap;
    image_doc_rid     : TBitmap;
    image_docs_rid    : TBitmap;

    image_Family      : TBitmap;
    image_Family_rid  : TBitmap;
    image_FamMult_rid : TBitmap;
    image_Key         : TBitmap;
    image_Key_Rid     : TBitmap;
    image_Map         : TBitmap;
    image_Map_Rid     : TBitmap;
    image_Mappe_Rid   : TBitmap;
    image_Mappe_UltRid: TBitmap;
    image_Dust        : TBitmap;
    image_Dust_Rid    : TBitmap;
    image_Casa1       : TBitmap;
    image_Casa1_Rid   : TBitmap;
    image_Ici         : TBitmap;
    image_Ici_Rid     : TBitmap;

    image_Lanpadina   : TBitmap;
    image_snapfine    : TBitMap;
    image_editabile   : TBitMap;


    vedopallinivertici       : Boolean;
    vedopalliniverticiFinali : Boolean;

    xmom, ymom : Integer; // per virtualline
    angmom ,scamom    : real;

    CodiceCatastale    : String;
    ProiezioneCatastale : Integer;
    Inconcessioniproduction : Boolean;

    faseAperturaProgramma : Boolean;

    aprostradeMagliano : Boolean;
    htestostrade       : real;

    dimxStampaVir,dimyStampaVir : Real;
    primovirtRetstampa : Boolean;

    stampadimXmm      : real;
    stampadimYmm      : real;
    stampaScalaStampa : real;
    stampaScalaOrMap  : real;
    stampaxorigine, stampayorigine : real;
    stampax2origine, stampay2origine : real;
    stampadpi         : real;

    spostoTerritorioAttivo : Boolean;
    salvarotTerritorioAttivo : Boolean;

function  give_offsetmirino: real;
procedure setxysnap(x,y: Real);
procedure update_offsetmirino;
procedure comando00;


implementation

uses interfaccia,costanti;

procedure initvarbase;
var F : TextFile;
begin
    Inconcessioniproduction := true;
    catastoselezonabile := true;
    aprostradeMagliano:= false;
     InizializzaAngolifissi;
    parahTesto := 80.0;
    TxtCatastoOnOff := false;

    B_Griglia_Utm84   := true;
    B_Griglia_Utm50   := false;
    B_Griglia_Sfer84  := false;
    B_Griglia_Sfer50  := false;
    B_Griglia_cassini := false;
    opzioneGr1 :=0;
    opzioneGr2 :=0;
    opzioneGr3 :=0;
    opzioneGr4 :=0;
    opzioneGr5 :=0;
    GridColor1 := clGray;
    GridColor2 := clSilver;
    GridColor3 := clMaroon;
    GridColor4 := clOlive;
    GridColor5 := clyellow;

   xprezoomw := 0.0;
   yprezoomw := 0.0;
   sprezoomw := 1.0;

    vedopallinivertici       := false;
    vedopalliniverticiFinali := false;

    spostoTerritorioAttivo   := false;
    salvarotTerritorioAttivo := false;

// le imagini
  image_pdf    := TBitMap.Create;  image_pdf.LoadFromResourceName(HInstance,'Bit_pdficon');
  image_pdfrid := TBitMap.Create;  image_pdfrid.LoadFromResourceName(HInstance,'Bit_pdfrid');
  image_tarsu1 := TBitMap.Create;  image_tarsu1.LoadFromResourceName(HInstance,'Bit_Tarsu1');
  image_tarsu_rid := TBitMap.Create;  image_tarsu_rid.LoadFromResourceName(HInstance,'Bit_Tarsu_rid');

  image_ici1   := TBitMap.Create;  image_ici1.LoadFromResourceName(HInstance,'Bit_ici1');
  image_tarsu2 := TBitMap.Create;  image_tarsu2.LoadFromResourceName(HInstance,'Bit_Tarsu2');
  image_ici2   := TBitMap.Create;  image_ici2.LoadFromResourceName(HInstance,'Bit_ici2');

  image_casaverde    := TBitMap.Create;  image_casaverde.LoadFromResourceName(HInstance,'Bit_Casaverde');

  image_pianta       := TBitMap.Create;  image_pianta.LoadFromResourceName(HInstance,'Bit_pianta');
  image_proprietario := TBitMap.Create;  image_proprietario.LoadFromResourceName(HInstance,'Bit_proprietario');

  image_c2           := TBitMap.Create;  image_c2.LoadFromResourceName(HInstance,'Bit_C2');
  image_c6           := TBitMap.Create;  image_c6.LoadFromResourceName(HInstance,'Bit_C6');


  image_propr_rid    := TBitMap.Create;  image_propr_rid.LoadFromResourceName(HInstance,'Bit_prop_rid');
  image_piantarid    := TBitMap.Create;  image_piantarid.LoadFromResourceName(HInstance,'Bit_pianta_rid');
  image_doc_rid      := TBitMap.Create;  image_doc_rid.LoadFromResourceName(HInstance,'Bit_documento_rid');
  image_docs_rid     := TBitMap.Create;  image_docs_rid.LoadFromResourceName(HInstance,'Bit_documenti_rid');


  image_Family       := TBitMap.Create;  image_Family.LoadFromResourceName(HInstance,'Bit_Family');
  image_Family_rid   := TBitMap.Create;  image_Family_rid.LoadFromResourceName(HInstance,'Bit_Fam_rid');
  image_FamMult_rid  := TBitMap.Create;  image_FamMult_rid.LoadFromResourceName(HInstance,'Bit_FamMult_rid');


  image_Key          := TBitMap.Create;  image_Key.LoadFromResourceName(HInstance,'Bit_key');
  image_Key_Rid      := TBitMap.Create;  image_Key_Rid.LoadFromResourceName(HInstance,'Bit_key_rid');

  image_Map          := TBitMap.Create;  image_Map.LoadFromResourceName(HInstance,'Bit_map');
  image_Map_Rid      := TBitMap.Create;  image_Map_Rid.LoadFromResourceName(HInstance,'Bit_map_rid');
  image_Mappe_Rid    := TBitMap.Create;  image_Mappe_Rid.LoadFromResourceName(HInstance,'Bit_mappe_rid');
  image_Mappe_UltRid := TBitMap.Create;  image_Mappe_UltRid.LoadFromResourceName(HInstance,'Bit_map_ultrarid');


  image_Dust          := TBitMap.Create;  image_Dust.LoadFromResourceName(HInstance,'Bit_dust');
  image_Dust_Rid      := TBitMap.Create;  image_Dust_Rid.LoadFromResourceName(HInstance,'Bit_dust_rid');

  image_Casa1          := TBitMap.Create;  image_Casa1.LoadFromResourceName(HInstance,'Bit_casa1');
  image_Casa1_Rid      := TBitMap.Create;  image_Casa1_Rid.LoadFromResourceName(HInstance,'Bit_casa1_rid');

  image_Ici          := TBitMap.Create;  image_Ici.LoadFromResourceName(HInstance,'Bit_Ici');
  image_Ici_Rid      := TBitMap.Create;  image_Ici_Rid.LoadFromResourceName(HInstance,'Bit_Ici_rid');

  image_Lanpadina    := TBitMap.Create;  image_Lanpadina.LoadFromResourceName(HInstance,'Bit_Light');

  image_snapfine     := TBitMap.Create;  image_snapfine.LoadFromResourceName(HInstance,'Bit_snapfine');
  image_editabile    := TBitMap.Create;  image_editabile.LoadFromResourceName(HInstance,'Bit_editabile');


// gli snap
   b_SnapFine     := false;
   b_SnapVicino   := false;
   b_SnapOrto     := false;
   b_SnapOrtoSeg  := false;
   b_SnapGriglia  := false;

    xOrigineVista := 0;
    yOrigineVista := 0;
    ScalaVista    := 1;

   scrollDown     := false;

   comandocorrente :=0;
   ProiezioneCorrente := 1;
   fasecomando        := 0;
   dimmirino :=4;

    TColor32Entry(ColoreSfondo).A := 255;
    TColor32Entry(ColoreSfondo).R := 153;
    TColor32Entry(ColoreSfondo).G := 171;
    TColor32Entry(ColoreSfondo).B := 193;

  MUndor := TList.create;
  mouseMiddleIsDown := false;

  Mom1:=false;
  Mom2:=false;
  Mom3:=false;

  Hschermo :=100;
  incomandotrasparente :=false;

  CodiceCatastale := 'E812';
  ProiezioneCatastale := 1;
  htestostrade := 300.0;

end;

function give_offsetmirino: real;
begin
 result := ScalaVista*dimmirino ;
end;

procedure setxysnap(x,y: Real);
begin


end;

procedure update_offsetmirino;
begin
  offsetmirino := dimmirino*scalaVista;
end;

procedure comando00;
begin
  Comando := kStato_nulla;
	FaseComando:=0;
  AggiornaInterfaceComandoAzione(comando,fasecomando);
end;

end.




