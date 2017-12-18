unit DisegnoV;

interface

uses  windows, System.classes, GR32,  GR32_Image, GR32_Layers, Vcl.Controls ,FMX.Dialogs ,sysutils;

type
 TDisegnoV = class

 	VersioneSoftware  : Integer; //    100 = prima versione
	eventuale_xc      : real;
	eventuale_yc      : real;
	eventuale_ang     : real;
	eventuale_scala   : real;
	eventuale_offx    : real;
	eventuale_offy    : real;
	eventuale_codice1 : Integer;
	eventuale_codice2 : Integer;
	eventuale_codice3 : Integer;
  Escala            : Real;
	Exorigine         : Real;
  Eyorigine         : Real;
  Eanglerot         : Real;
	Ex_xc             : Real;
	Ex_yc             : Real;
  Centrato          : Boolean;
  Roted             : Boolean;
  Scaled            : Boolean;
  movedX            : Boolean;
  movedY            : Boolean;
	nomedbaseDisegno  : String;
	nometavolaDisegno : String;
  b_connessodbase   : Boolean;

  minGauSca ,maxGauSca ,laPosSca    : integer;
  minGauRot ,maxGauRot ,laPosRot    : integer;
  minGauSpoX,maxGauSpoX,laPosSpoX   : integer;
  minGauSpoY,maxGauSpoY,laPosSpoY   : integer;


  // ------------------------------------- Importanti -------------------
  ListaPiani        : TList;
  indPianocorrente  : Integer;

	limx1, limx2      : Real;
  limy1, limy2      : Real;
	xorigine          : Real;
	yorigine          : Real;

	b_visibile        : Boolean;
	b_editabile       : Boolean;
  b_snappabile      : Boolean;

  alfalinee         : Integer;
  alfasuperfici     : Integer;
	nomedisegno       : String;
	nomedisegnoconPath: String;
	npiani            : Integer;
	numobj            : Integer;



   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   Svuota;
   procedure   riazzera;

   procedure   Disegna(HHDC : TImage32) ;
   procedure   DisegnaCatasto(HHDC : TImage32) ;
   procedure   UpdateLimiti(x,y : Real);
   procedure   faiLimiti;
   procedure   Apri(nomefile: String);
   procedure   ApriDXF(nomefile: String);
   procedure   ApriCXF(nomefile: String);
   procedure   ApriSHP(nomefile: String);
   procedure   ApriSHPLayers(nomefile: String);
   procedure   ApriMacMap(nomefile: String);
   procedure   addLayerCorrente (_nome : String);
   procedure   setpianocorrente (indice : Integer);
   procedure   setcolorepianorgb (indice : Integer ; _r,_g,_b : integer);
   procedure   setalphasuppiano (indice : Integer ; value : integer);
   procedure   setvisibilepiano (indice : Integer ; stato :boolean);
   procedure   setspessorepiano (indice : Integer ; _spess :Integer);
   procedure   setdimPuntopiano (indice : Integer ; _dim :Integer);
   procedure   setalphalinepiano (indice : Integer ; _value :Integer);
   procedure   seteditabilepiano (indice : Integer ; _state :Boolean);
   procedure   setsnappabilepiano (indice : Integer ; _state :Boolean);
   procedure   RiordinaPianiAlfateticamente;
   function    snapFine    (x1,y1 : real): Boolean;
   function    snapVicino  (x1,y1 : real): Boolean;
   function    testinternoschermo : Boolean;

   procedure   faipunto         (HHDC : TImage32; x1 , y1 : real);
   procedure   faiplinea        (HHDC : TImage32; x1 , y1 : real; fasecom : Integer);
   procedure   faipoligono      (HHDC : TImage32; x1 , y1 : real; fasecom : Integer);
   procedure   faisimbolo       (HHDC : TImage32; x1 , y1 : real; indice  : Integer; dimfissa : Boolean;
                                 listadefinizioni: TList; nomelista: String; _scalaSimb:real; _angrot:real);
   procedure   faiCivico        (HHDC : TImage32; x1 , y1, x2, y2, x3, y3 : real; txtCiv : String);

   procedure   ruotasimbolo     (HHDC : TImage32; rot: Real);
   procedure   scalasimbolo     (HHDC : TImage32; sca: Real);
   procedure   fairegione       (HHDC : TImage32; x1 , y1 : real; fasecom,fasereg : Integer);
   procedure   faitesto         (HHDC : TImage32; x1 , y1, ht, ang : real; txtText : String);
   procedure   faitestovirtuale (HHDC : TImage32; ht, ang : real; txtText : String);


//   procedure    FissaUndoSeNonRotScaDisegno : (NSUndoManager  *) MUndor : (double) xc : (double) yc;
   procedure    EseguiUndoEventuali;
//   procedure    impostaUndoRot             : (NSUndoManager  *) MUndor ;
//   procedure    impostaUndoSca             : (NSUndoManager  *) MUndor ;
//   procedure    impostaUndoOrigineX        : (NSUndoManager  *) MUndor ;
//   procedure    impostaUndoOrigineY        : (NSUndoManager  *) MUndor ;
   procedure   EseguiUndoRot  ;
   procedure   EseguiUndoSca  ;
   procedure   EseguiUndoOffX ;
   procedure   EseguiUndoOffY ;
   procedure   RemoveDisegno;
   procedure   addpiano;
   procedure   DisSpostaDisegno (HHDC : TImage32; dx , dy : Real);
   procedure   RuotaDisegnoxcyc  (xc , yc, ang  : real);
   procedure   ScalaDisegnoxcyc  (xc , yc, scal : real);
   procedure   Distxtvirtual    (HHDC : TImage32; xc , yc, ang, scal : Real);
   procedure   DisegnaSplineVirtuale (HHDC : TImage32; x1, y1 : Integer);
   procedure   disegnailpianino (HHDC : TImage32);
   procedure   dispallinispline (HHDC : TImage32);
   procedure   disVtTutti       (HHDC : TImage32);
   procedure   salvaDisegnoMacMac  (_nomedisegno: String);
   procedure   apriDisegnoMacMac   (_nomedisegno: String);
   procedure   SalvaDisegnoDxf  (_nomedisegno: String);
   procedure   apriDisegnoShp   (_nomedisegno: String);
   procedure   apriDisegnoCxf   (_nomedisegno: String);
   procedure   cambianomedbase  (_newtext    : string);
   procedure   cambianomeTavola (_newtext    : string);
// edit vettoriale
   procedure   ortosegmenta     (x1, y1 : real);
   procedure   seleziona_conPt         (x1, y1 : real;  _LSelezionati : Tlist);
   function    selezionaCivicoEditPt (xc, yc : real) : Boolean;
   procedure   seleziona_conPtInterno  (x1,y1:  real;  _LSelezionati : Tlist);
   procedure   selezionaEdif_conPtInterno  ( x1,y1:  real;  _LSelezionati : Tlist);
   procedure   selezionaTerre_conPtInterno ( x1,y1:  real;  _LSelezionati : Tlist);
   function    Match_conPt     (x1, y1 : real) : boolean;
   function    selezionaVtconPt   (x1,y1:  real;  _LSelezionati : Tlist) : boolean;
   function    selezionaVtspconPt (HHDC : TImage32;   x1,y1:  real;  _LSelezionati : Tlist) : boolean;
// aggiungi elementi vettoriali
   function    faiCatpoligono   (HHDC : TImage32; x1,y1:  real; fasecom : integer; disVcomp : TDisegnoV)  : boolean;
   procedure   BackPlineaAdded;
   procedure   finitaPolilinea  (HHDC : TImage32);
   procedure   finitoRettangolo (HHDC : TImage32);
   procedure   chiudipoligono   (HHDC : TImage32);
   procedure   faicerchio       (HHDC : TImage32; x1, y1, x2,y2: Real);
   procedure   fairettangolo    (HHDC : TImage32; x1, y1, x2, y2:real);
   procedure   updateEventualeRegione (HHDC : TImage32);
   procedure   cancellaultimovt ;
   procedure   SpostaDisegnodxdy(dx, dy : Real);
   procedure   RuotaDisegnodxdy (xc, yc, xc2, yc2 : real);
   procedure   RuotaDisegnoang  (xc, yc, ang : real);
   procedure   ScalaDisegno     (xc,yc,xc2, yc2: Real);
   procedure   ScalaDisegnoPar  (xc,yc, par : real);
   function    dimptPianoInd    ( indice : Integer): real;
   procedure   SetdimptPianoInd (valore : real; indice: integer);
   procedure   updateInfoConLimiti;
   procedure   updateInfoConLimitiPianoCorrente;
   function    damminumpiani : Integer;
   function    IndicePianocorrente : Integer;
   procedure   setvisibile       (_state : integer);
   function    visibile : Boolean;
   function    visibilepiano     (indice :Integer): Boolean;
   procedure   seteditabile      (_state : Integer);
   function    editabilepiano    (indice : Integer) : Boolean;
   procedure   setsnappabile     (_state : integer);
   function    snappabilepiano   (indice :Integer): Boolean;
   function    spessorepiano     (indice : Integer)  : real;
   procedure   setnomedisegno    (_nome : string);

   function    nomeFoglioCXF  : String;
   function    Solonomedisegno  : String;
   function    SolonomedisegnoNoext  : String;

   procedure   setnomepianoind   (_nome: String;  indice : integer);
   function    alphaline : Integer;
   function    alphasup : integer;
   procedure   setalphaline     (_value : integer);
   procedure   setalphasup      (_value : integer);
   function    alphalinepiano   (_indpiano : integer) : real;
   function    alphasuppiano    (_indpiano : integer) : real;

	// - (void)   impostalimiti;
   procedure   rifarenomipianicancelletto;
   function    colorepianoind_r(_indpiano : integer) : integer;
   function    colorepianoind_g(_indpiano : integer) : integer;
   function    colorepianoind_b(_indpiano : integer) : integer;
   function    givemenomepianocorrente : String;
   function    givemecommentopianocorrente : String;
   function    givemenomepianoindice(indice : Integer) : String;
   function    infopianocorrente : String;
   function    infodisegno       : String;
   function    nomepoligonopt    (xc, yc : real) : String;

// edit topologico
   procedure EliminaPianiVuoti ;
   procedure EliminaPianoCorrente;
   procedure FondiDis                    (disadd : TDisegnoV);
   procedure FondiPianiStessoNome ;
   procedure EliminaPuntiDoppiNelPiano;
   procedure EliminaPianoIndice         (indice : integer);
   procedure setdispallinivtpiano       (indice : integer;  state : Boolean);
   procedure setdispallinivtfinalipiano (indice : integer;  state: Boolean);
   procedure dispallinivtpiano          (indice : integer) ;
   function  dispallinivtfinalipiano    (indice : integer) : Boolean;
   procedure settratteggiopiano         (indice : integer; indtratto : Integer);
   procedure setCampitura               (indice : integer; indCamp : Integer);
   procedure CatToUtm;
   function  esistenomepiano            (nompia : String): Boolean;
   function  indicePianoconNome         (nompia : String): Integer;
//   procedure TematizzaTerreno           : (Immobili *) immobili;
//   procedure TematizzaTerrenoSuNuovoDis : (DisegnoV *) Disnuovo  : (Immobili *) immobili;
   procedure NoTematizzaTerreno ;
   procedure TestoAltoQU;

   procedure layerscatastaliOnOff(modo : Integer);

   procedure ScalaDaBarra(sca :  Integer);
   procedure RuotaDaBarra(newrot :  Integer);
   procedure SpostaXDaBarra(newX :  Integer);
   procedure SpostaYDaBarra(newY :  Integer);

   procedure tuttoPenDownPolyline;

   function  nomepianovicinopt(xa,ya : Real) : String;
   procedure PolyToPoligoni;

   procedure EliminaPianiOff;
   procedure EliminaPianiON;

   procedure PianiTuttiON;
   procedure PianiTuttiOff;
   procedure FondituttoPrimoPiano;

  end;


 var ilDisegnoV : TDisegnoV;
     LeStradeV  : TDisegnoV;

implementation

uses Piano,varbase,funzioni , Polylinea,progetto, Vettoriale;



Constructor TDisegnoV.Create;
var locpiano : TPiano;
begin
 	VersioneSoftware  :=100; //    100 = prima versione
	eventuale_xc      :=0.0;
	eventuale_yc      :=0.0;
	eventuale_ang     :=0.0;
	eventuale_scala   :=1.0;
	eventuale_offx    :=0.0;
	eventuale_offy    :=0.0;
	eventuale_codice1 :=0;
	eventuale_codice2 :=0;
	eventuale_codice3 :=0;
  Escala            :=0.0;
	Exorigine         :=0.0;
  Eyorigine         :=0.0;
  Eanglerot         :=0.0;
	Ex_xc             :=0.0;
	Ex_yc             :=0.0;
  Centrato          :=false;
  Roted             :=false;
  Scaled            :=false;
  movedX            :=false;
  movedY            :=false;
	nomedbaseDisegno  :='';
	nometavolaDisegno :='';
  b_connessodbase   :=false;

  minGauSca         :=   10;
  maxGauSca         := 2000;
  laPosSca          := 1000;
  minGauRot         := -600;
  maxGauRot         :=  600;
  laPosRot          :=    0;
  minGauSpoX        := -100;
  maxGauSpoX        :=  100;
  laPosSpoX         :=    0;
  minGauSpoY        := -100;
  maxGauSpoY        :=  100;
  laPosSpoY         :=    0;

  // ------------------------------------- Importanti -------------------
  ListaPiani        := TList.create;
  locpiano          := TPiano.Create;
  locpiano.InitPiano(self);
   ListaPiani.Add(locpiano); locpiano.nomepiano:='0';
  indPianocorrente  :=0;

	limx1             :=0.0;
  limx2             :=0.0;
  limy1             :=0.0;
  limy2             :=0.0;
	xorigine          :=0.0;
	yorigine          :=0.0;
	b_visibile        :=true;
	b_editabile       :=true;
  b_snappabile      :=true;

  alfalinee         :=255;
  alfasuperfici     :=255;
	nomedisegno       :='NoName';
  nomedisegnoconPath:='';
	npiani            :=0;
	numobj            :=0;
end;

Destructor  TDisegnoV.Done;
begin
end;

function    TDisegnoV.testinternoschermo : Boolean;
var locres : Boolean;
begin
	locres := True;
	if (limx2<xOrigineVista)  then locres := false;
	if (limx1>x2OrigineVista) then locres := false;
	if (limy1>y2OrigineVista) then locres := false;
	if (limy2<yOrigineVista)  then locres := false;
	result := locres;
end;

procedure   TDisegnoV.Svuota;
begin

end;

procedure   TDisegnoV.riazzera;
var k : Integer;
    locpiano : TPiano;
begin
 Listapiani.Clear;
 addLayerCorrente('0');
{
   for k:= Listapiani.Count-1 downto 1 do
    begin Listapiani.delete(k); end;
    
} 
end;


procedure   TDisegnoV.Disegna(HHDC : TImage32) ;
var 	locpiano  : TPiano;
      i : Integer;
begin
	if not (b_visibile)  then exit;
  if not(testinternoschermo) then exit;
  for i:=0 to ListaPiani.Count-1 do
   begin
		locpiano := ListaPiani.Items[i];
    locpiano.disegna(HHDC,alfalinee,alfasuperfici);
   end;
end;

procedure  TDisegnoV.DisegnaCatasto(HHDC : TImage32) ;
var 	locpiano  : TPiano;
      i : Integer;
begin
	if not (b_visibile)  then exit;
  if not(testinternoschermo) then begin exit;  end;
  for i:=0 to ListaPiani.Count-1 do
   begin
		locpiano := ListaPiani.Items[i];
    locpiano.disegnaCatasto(HHDC,alfalinee,alfasuperfici);
   end;
end;


function   TDisegnoV.snapFine  (x1,y1 : real): Boolean;
var locres : Boolean;
	  locpiano : TPiano;
    i : Integer;
begin
	locres :=false;
	if not(b_visibile) then begin result :=locres; exit; end;
//	if not(b_snappabile) then begin result :=locres; exit; end;
	for i:=0 to ListaPiani.count-1 do begin
		locpiano := ListaPiani.Items[i];
		locres   := locpiano.snapFine(x1, y1);
		if (locres) then break;
  end;
	result := locres;
end;

function   TDisegnoV.snapVicino  (x1,y1 : real): Boolean;
var locres : Boolean;
	  locpiano : TPiano;
    i : Integer;
begin
	locres :=false;
	if not(b_visibile) then begin result :=locres; exit; end;
	if not(b_snappabile) then begin result :=locres; exit; end;
	for i:=0 to ListaPiani.count-1 do begin
		locpiano := ListaPiani.Items[i];
		locres   := locpiano.snapVicino(x1, y1);
		if (locres) then break;
  end;
	result := locres;
end;


procedure   TDisegnoV.UpdateLimiti(x,y : Real);
begin
 if limx1=0.0 then limx1:=x; if limx2=0.0 then limx2:=x;
 if limy1=0.0 then limy1:=y; if limy2=0.0 then limy2:=y;
 if limx1>x  then limx1:=x;
 if limx2<x  then limx2:=x;
 if limy1>y  then limy1:=y;
 if limy2<y  then limy2:=y;
end;


procedure   TDisegnoV.faiLimiti;
var todid : Boolean;
	  locpiano  : TPiano;
    i : integer;
begin
	todid := true;
	for i:=0 to ListaPiani.count-1 do
   begin
		locpiano := ListaPiani.Items[i];    locpiano.faiLimiti;
		if ( ( locpiano.limx1 = locpiano.limx2) and ( locpiano.limy1 =  locpiano.limy2) ) then continue;
    if (todid) then
     begin
			limx1 :=locpiano.limx1;	   limx2:=locpiano.limx2;
			limy1 :=locpiano.limy1;	   limy2:=locpiano.limy2;
			todid := false;
     end
    else
    begin
			if (limx1>locpiano.limx1) then  limx1:=locpiano.limx1;
			if (limy1>locpiano.limy1) then  limy1:=locpiano.limy1;
			if (limx2<locpiano.limx2) then  limx2:=locpiano.limx2;
			if (limy2<locpiano.limy2) then  limy2:=locpiano.limy2;
    end;
   end;
end;



procedure   TDisegnoV.Apri(nomefile: String);
var estensione : String;
begin

 	nomedisegno        :=extractFilename(nomefile);
  nomedisegnoconPath :=nomefile;

 estensione :=Uppercase(ExtractFileExt(nomefile));
 if estensione = '.DXF' then apridxf(nomefile);
 if estensione = '.CXF' then apricxf(nomefile);
 if estensione = '.SHP' then aprishp(nomefile);
// if estensione = '.SHP' then begin if aprostradeMagliano then  ApriSHPLayers(nomefile) else  aprishp(nomefile); end;
 if estensione = '.MACMAP' then aprimacmap(nomefile);

 faiLimiti;
end;



procedure   TDisegnoV.setpianocorrente (indice : Integer);
begin
	indPianocorrente := indice;
  Pianocorrente := ListaPiani.Items[indice];
 if ilProgetto<>nil then IlProgetto.PianoCorrente := Pianocorrente;
end;

procedure   TDisegnoV.setcolorepianorgb (indice : Integer ; _r,_g,_b : integer);
var locpiano : TPiano;
 begin
	locpiano := ListaPiani.Items[indice];
	locpiano.setcolorpianorgb(_r,_g,_b);
 end;

procedure   TDisegnoV.setalphasuppiano (indice : Integer ; value : integer);
var locpiano : Tpiano;
begin
	locpiano := ListaPiani.Items[indice];
	locpiano.alfasuperfici:=value;
end;

procedure   TDisegnoV.setvisibilepiano (indice : Integer ; stato :boolean);
var locpiano : Tpiano;
begin
	locpiano := ListaPiani.Items[indice];
	locpiano.b_visibile := stato;
end;

procedure   TDisegnoV.setspessorepiano (indice : Integer ; _spess :Integer);
var locpiano : Tpiano;
begin
	locpiano := ListaPiani.Items[indice];
	locpiano.spessoreline:= _spess;
end;

procedure   TDisegnoV.setdimPuntopiano (indice : Integer ; _dim :Integer);
var locpiano : Tpiano;
begin
	locpiano := ListaPiani.Items[indice];
	locpiano.dimpunto := _dim;
end;



procedure   TDisegnoV.setalphalinepiano (indice : Integer ; _value :Integer);
var locpiano : Tpiano;
begin
	locpiano := ListaPiani.Items[indice];
	locpiano.alfalinee:= _value;
end;


procedure   TDisegnoV.seteditabilepiano (indice : Integer ; _state :Boolean);
var locpiano : Tpiano;
begin
	locpiano := ListaPiani.Items[indice];
	locpiano.b_editabile:=_state;
end;


procedure   TDisegnoV.setsnappabilepiano (indice : Integer ; _state :Boolean);
var locpiano : Tpiano;
begin
	locpiano := ListaPiani.Items[indice];
	locpiano.b_snappabile:=_state;
end;


procedure   TDisegnoV.RiordinaPianiAlfateticamente;
var	 pia1, pia2 : TPiano;
	   nom1, nom2 : String;
	   indcandidato : Integer;
	   numpia   ,i,j: Integer;
     prelista : TList;
begin
 prelista := TList.Create;

 numpia := ListaPiani.count;
	for i:=1 to numpia-1 do
   begin
		pia1 := ListaPiani.Items[i];     nom1 := pia1.nomepiano;
    indcandidato:=0;
		for j:=0 to prelista.Count-1 do
     begin
			pia2 := prelista.Items[j];     nom2 := pia2.nomepiano;
			if ( nom1 > nom2 ) then begin  indcandidato:=j+1;   end;
     end;
    prelista.insert(indcandidato,pia1);
   end;

	pia1 := ListaPiani.Items[0];
  prelista.insert(0,pia1);


  ListaPiani.clear;
	for i:=0 to numpia-1 do
   begin
		pia1 := prelista.Items[i];
    ListaPiani.add(pia1);
   end;

   prelista.Clear;
   prelista.Free;
end;





procedure   TDisegnoV.addLayerCorrente (_nome : String);
var locpiano, _piano : TPiano;	  todo     : Boolean;    i : Integer;
 begin
  todo := true;
	for i:=0 to ListaPiani.count-1 do
   begin
		locpiano := ListaPiani.Items[i];
    if locpiano.nomepiano=_nome then begin todo:=false; setpianocorrente(i);  break; end;
   end;
	if (todo) then begin
		_piano := TPiano.Create; _piano.InitPiano(self); _piano.setnomepiano(_nome); ListaPiani.Add(_piano);
		setpianocorrente(ListaPiani.count-1);
  end;
 end;


procedure   TDisegnoV.ApriCXF(nomefile: String);
var FF : TStringList;
    IR :  integer;
    tt,tt2 , ttcar , ttnomemappa: String;
    nomebordo : String;
    locinderase : Integer;
begin

// if fileexists(nomefile) then showmessage('-'+nomefile);

 FF := TStringList.Create;
 FF.LoadFromFile(nomefile);
 //	[self setnomedisegno :_nomedisegno];
 //	NSString *ttnomemappa = [[_nomedisegno lastPathComponent] stringByDeletingPathExtension];
 IR :=0;
    tt := FF[IR]; inc(IR);
    tt := FF[IR]; inc(IR);
    tt := FF[IR]; inc(IR);
		//	tt= [self leggirigafile:fileContents:i_filepos];	 // mappa
		//	tt= [self leggirigafile:fileContents:i_filepos];	 // nomemappa
		//	tt= [self leggirigafile:fileContents:i_filepos];	 // scala originale

	while (IR< FF.Count ) do
   begin
    tt := FF[IR]; inc(IR); tt:=togliTuttispazi(tt);
		if ( (tt = 'BORDO') or (tt = 'LINEA') or (tt = 'TESTO')
			or (tt = 'LINEA\\') or (tt = 'TESTO\\') or (tt = 'FIDUCIALE') or (tt = 'SIMBOLO' )) then
     begin
			if (tt = 'BORDO')     then begin tt2 := FF[IR]; inc(IR); tt2:=togliTuttispazi(tt2); end;
			if (tt = 'LINEA')	    then tt2:= 'Linea';
			if (tt = 'LINEA\\')	  then tt2:= 'LineaExt';
			if (tt = 'TESTO')	    then tt2:= 'Testo';
			if (tt = 'TESTO\\')	  then tt2:= 'TestoExt';
			if (tt = 'FIDUCIALE')	then tt2:= 'Fiduciale';
			if (tt = 'SIMBOLO')	  then tt2:= 'Simboli';

			addLayerCorrente(tt2);
      setalphasuppiano  (indPianocorrente, 20);
      setalphalinepiano (indPianocorrente, 60);
			setcolorepianorgb (indPianocorrente, 0, 112 ,0 );

      if ( (tt2= 'Linea') or (tt2= 'LineaExt') or  (tt2= 'Testo')
         or (tt2= 'TestoExt') or (tt2= 'Fiduciale') or (tt2= 'Simboli')) then
          begin
           setvisibilepiano (indPianocorrente , false);
          end;


			if (tt2 = ttnomemappa) then begin
				setalphasuppiano  (indPianocorrente , 162);
				setcolorepianorgb (indPianocorrente, 0 , 0 ,0 );
      end;
      if (tt2 = 'ACQUA') then begin
		    setcolorepianorgb (indPianocorrente , 0, 0, 255);
				setspessorepiano  (indPianocorrente , 168);
				setalphasuppiano  (indPianocorrente , 32);
				setalphalinepiano (indPianocorrente , 32);
      end;
			if (tt2 = 'STRADA') then begin
		    setcolorepianorgb (indPianocorrente , 128, 128, 128);
				setspessorepiano  (indPianocorrente , 168);
      end;
			if (tt2 = 'Linea')  then begin
		    setcolorepianorgb (indPianocorrente , 0, 0, 0);
				setalphalinepiano (indPianocorrente , 25);
				setspessorepiano  (indPianocorrente , 168);
				setvisibilepiano (indPianocorrente , false);
      end;
			if (tt2 = 'LineaExt') then begin
		    setcolorepianorgb (indPianocorrente , 0, 0, 0);
				setalphalinepiano (indPianocorrente , 25);
				setspessorepiano  (indPianocorrente , 168);
				setvisibilepiano (indPianocorrente , false);
      end;
			if (tt2 ='Testo') then begin
		    setcolorepianorgb (indPianocorrente , 0, 0, 0);
				setalphalinepiano (indPianocorrente , 25);
				setspessorepiano  (indPianocorrente , 168);
				seteditabilepiano (indPianocorrente, false);
				setsnappabilepiano(indPianocorrente, false);
				setvisibilepiano  (indPianocorrente , false);
      end;
			if (tt2 = 'TestoExt') then begin
		    setcolorepianorgb (indPianocorrente , 0, 0, 0);
				setalphalinepiano (indPianocorrente , 255);
				setspessorepiano  (indPianocorrente , 168);
				setvisibilepiano  (indPianocorrente , false);
				seteditabilepiano (indPianocorrente, false);
				setsnappabilepiano(indPianocorrente, false);
      end;
			if (tt2 = 'Fiduciale')  then begin
		    setcolorepianorgb (indPianocorrente , 255, 0, 255);
				setalphalinepiano (indPianocorrente , 255);
				setspessorepiano  (indPianocorrente , 255);
				seteditabilepiano (indPianocorrente, false);
				setsnappabilepiano(indPianocorrente, false);
				setvisibilepiano  (indPianocorrente , false);
      end;

			if (tt2 = 'Simboli') then begin
		    setcolorepianorgb (indPianocorrente , 0, 0, 128);
				setalphalinepiano (indPianocorrente , 255);
				setspessorepiano  (indPianocorrente , 180);
				seteditabilepiano (indPianocorrente, false);
				setsnappabilepiano(indPianocorrente, false);
      end;


//     if not(pianocorrente.pianoPlus) then begin setvisibilepiano  (indPianocorrente , false);   end
//      else begin setcolorepianorgb (indPianocorrente , 180, 0, 0);  setalphasuppiano  (indPianocorrente, 120);  end;
     if (pianocorrente.pianoPlus) then begin setcolorepianorgb (indPianocorrente , 180, 0, 0);  setalphasuppiano  (indPianocorrente, 120);  end;

 //    if (tt2 = 'ACQUA') then begin  setvisibilepiano  (indPianocorrente , true); end;

(*
  			NSRange myrange;
  			myrange.location=[tt2 length]-1;    myrange.length = 1;
  			if ([tt2 compare:@"+" options:NSCaseInsensitiveSearch range:myrange] ==0)    {
  				[self setcolorepianorgb:indicePianocorrente: 0.0 : 0.0 : 0.0];
  				[self setalphasuppiano :indicePianocorrente: 0.8];
  			}
*)

			pianocorrente.cxfinPiano2 ( FF, IR,tt);
     end;
   end;
		////////////// --------------------------------------   /////////////////////////////////
	RiordinaPianiAlfateticamente;

  nomebordo := copy(nomedisegno,1,length(nomedisegno)-4);
//  showmessage(nomebordo);
  locinderase := indicePianoconNome (nomebordo);
  if locinderase>=0 then ListaPiani.Delete(locinderase);

	setpianocorrente(0);
//	seteditabilepiano(1,false);
 //	setvisibilepiano(1,false);
	self.b_editabile:=false;
	faiLimiti;
  FF.Clear;
  FF.Free;
end;

procedure   TDisegnoV.ApriSHPLayers(nomefile: String);
var
	x1lim,y1lim,x2lim,y2lim : Real;
	Tiposhp                 : longint;
	laposizione0            : Integer;
	laposizione             : Integer;
	_data                   : TMemoryStream;
	posdata                 : Integer;
	posparti                : Integer;
  recnum                  : longint;
	Numparts,NumPoints      : Integer;
	parts                   : Integer;
	parts1,parts2           : Integer;
  i,kpa,kv                : integer;
  x1up,y1up               : Real;
  ilpianocorr             : TPiano;
  F : TextFile;
  nomecsvfile             : String;
  riga,riga1,riga2        : String;
  conta : Integer;
  kj : Integer;
begin

  nomecsvfile := StringReplace(nomefile, '.shp', '.csv',[rfReplaceAll, rfIgnoreCase]);

  if not(Fileexists(nomecsvfile)) then begin showmessage('manca il file csv dello shp'); exit; end;
  assignFile(F,nomecsvfile); reset(F);
  readln(F,riga);


	posdata  := 0;
	posparti := 0;

	_data := TMemoryStream.Create;
  _data.LoadFromFile(nomefile);
	posdata :=32;
  _data.Seek(32,1);

  _data.Read(Tiposhp,sizeof(Tiposhp));

//   showmessage(intToStr(Tiposhp));

  _data.Read(x1lim,sizeof(x1lim));
  _data.Read(y1lim,sizeof(y1lim));
  _data.Read(x2lim,sizeof(x2lim));
  _data.Read(y2lim,sizeof(y2lim));

  _data.position :=108;


  case tiposhp of

   3 : begin // Polilinee

  			while (_data.Size>=_data.Position) do
         begin
          ilpianocorr := TPiano.Create;
          ilpianocorr.InitPiano(self);
          ListaPiani.Add(ilpianocorr);
          readln(F,riga);
          SpezzaStringaDotcoma(riga , riga1 ,riga);
          SpezzaStringaDotcoma(riga , riga1 ,riga2);

          ilpianocorr.nomepiano:=riga1;


          _data.Read(recnum,sizeof(recnum));
          _data.Read(x1lim,sizeof(x1lim));
          _data.Read(y1lim,sizeof(y1lim));
          _data.Read(x2lim,sizeof(x2lim));
          _data.Read(y2lim,sizeof(y2lim));
          _data.Read(Numparts ,sizeof(Numparts));
          _data.Read(NumPoints,sizeof(NumPoints));

  				if  (Numparts = 1) then begin
  					Polyincostruzione := TPolylinea.create; 	Polyincostruzione.initer(self,ilpianocorr);  Polyincostruzione.InitPolilinea(false);
  					ilpianocorr.Listavector.Add(Polyincostruzione);
            _data.Read(parts,sizeof(parts));
  					for i:=0 to NumPoints-1 do begin
             _data.Read(x1lim,sizeof(x1lim));
             _data.Read(y1lim,sizeof(y1lim));
             Polyincostruzione.addvertex(x1lim,y1lim);
            end;
           end
           else
          begin
  					Polyincostruzione := TPolylinea.create; 	Polyincostruzione.initer(self,ilpianocorr);  Polyincostruzione.InitPolilinea(false);
  					ilpianocorr.Listavector.Add(Polyincostruzione);
   					posparti := _data.Position;
  					for kpa:=0 to Numparts-1 do
             begin
              _data.position :=  posparti+kpa*4;
              _data.Read(parts1,sizeof(parts1));
              if kpa< ( Numparts-1) then  _data.Read(parts2,sizeof(parts2)) else parts2:=NumPoints;
              _data.position :=  posparti+Numparts*4+parts1*16;

  							for kv := parts1 to parts2-1 do
                 begin
                  _data.Read(x1lim,sizeof(x1lim));
                  _data.Read(y1lim,sizeof(y1lim));
  								if (kv=parts1) then Polyincostruzione.addvertexUp(x1lim,y1lim)
                                 else Polyincostruzione.addvertexnoUpdate(x1lim,y1lim);
                 end;

             end;
              _data.position :=  posparti+Numparts*4+NumPoints*16;
          end;

          _data.position := _data.position +8;
         end; // end while
       end; // Polilinee

     5 : // Poligoni
      begin
   			while (_data.Size>=_data.Position) do
         begin

          _data.Read(recnum,sizeof(recnum));
          _data.Read(x1lim,sizeof(x1lim));
          _data.Read(y1lim,sizeof(y1lim));
          _data.Read(x2lim,sizeof(x2lim));
          _data.Read(y2lim,sizeof(y2lim));
          _data.Read(Numparts ,sizeof(Numparts));
          _data.Read(NumPoints,sizeof(NumPoints));

//    showmessage(intToStr(Numparts));

  				if  (Numparts = 1) then begin
  					Polyincostruzione := TPolylinea.create; 	Polyincostruzione.initer(self,ilpianocorr);  Polyincostruzione.InitPolilinea(true);
  					ilpianocorr.Listavector.Add(Polyincostruzione);
            _data.Read(parts,sizeof(parts));
  					for i:=0 to NumPoints-1 do begin
             _data.Read(x1lim,sizeof(x1lim));
             _data.Read(y1lim,sizeof(y1lim));
             Polyincostruzione.addvertex(x1lim,y1lim);
            end;

            Polyincostruzione.chiudiSeChiusa;
           end
            else
           begin
  					Polyincostruzione := TPolylinea.create; 	Polyincostruzione.initer(self,ilpianocorr);  Polyincostruzione.InitPolilinea(false);
  					ilpianocorr.Listavector.Add(Polyincostruzione);
   					posparti := _data.Position;
  					for kpa:=0 to Numparts-1 do
             begin
              _data.position :=  posparti+kpa*4;
              _data.Read(parts1,sizeof(parts1));
              if kpa< ( Numparts-1) then  _data.Read(parts2,sizeof(parts2)) else parts2:=NumPoints;
              _data.position :=  posparti+Numparts*4+parts1*16;
  							for kv := parts1 to parts2-1 do
                 begin
                  _data.Read(x1lim,sizeof(x1lim));
                  _data.Read(y1lim,sizeof(y1lim));
  								if (kv=parts1) then begin
                                        Polyincostruzione.addvertexUpnoUpdate(x1lim,y1lim);
                                        x1up:=x1lim; y1up:=y1lim;  end
                                 else Polyincostruzione.addvertexnoUpdate(x1lim,y1lim);
                 end;
              Polyincostruzione.chiudiconUltimoUp;
             end;

              _data.position :=  posparti+Numparts*4+NumPoints*16;
//            Polyincostruzione.chiudiSeChiusa;
           end;

          _data.position := _data.position +8;
      end;
     end; // poligoni

  end;

{
    conta :=0;
    while not(eof(F)) do begin readln(F,riga);  inc(conta);  end;
    showmessage(IntTostr(conta));

}

  closefile(F);
end;





procedure   TDisegnoV.ApriSHP(nomefile: String);
var nomepiano : String;
begin
  nomepiano := extractFilename(nomefile);
  nomepiano := StringReplace(nomepiano, '.shp', '', [rfReplaceAll, rfIgnoreCase]);
 	addLayerCorrente(nomepiano);
  pianocorrente.shpin(nomefile);
end;

procedure   TDisegnoV.apriMacMap(nomefile: String);
var _data : TMemoryStream;
    nump , k : Integer;
    locpia : TPiano;
begin
  locpia := ListaPiani.items[0];  locpia.free; ListaPiani.delete(0); _data := TMemoryStream.Create;
 _data.LoadFromFile(nomefile);
  _data.Read(VersioneSoftware,sizeof(VersioneSoftware));
  _data.Read(b_editabile,sizeof(b_editabile));
  _data.Read(b_snappabile,sizeof(b_snappabile));
  _data.Read(alfalinee,sizeof(alfalinee));
  _data.Read(alfasuperfici,sizeof(alfasuperfici));
  _data.Read(indPianocorrente,sizeof(indPianocorrente));
  _data.Read(nump,sizeof(nump));
  for k:=1 to nump do
   begin
    locpia := TPiano.Create;
    locpia.InitPiano(self);
    ListaPiani.add(locpia);
    locpia.apripianoMacMap(_data);
   end;
 _data.Free;
  setpianocorrente (indPianocorrente);
 failimiti;
end;








procedure   TDisegnoV.ApriDXF(nomefile: String);
var FF : TStringList;
    IR :  integer;
    tt : String;
    indcolor , tipoelemento: Integer;
    faseEntity : Boolean;
    illopiano : TPiano;
begin

//  showmessage(DecimalSeparator);
//  showmessage(DecimalSeparator);

 tipoelemento :=0;
 faseEntity := false;

 FF := TStringList.Create;
 FF.LoadFromFile(nomefile);
 IR := 0;
 while IR< FF.Count do
  begin
    tt := FF[IR]; inc(IR);
    if tt='EOF' then break;
    if tt='LAYER' then
     begin
		 	while ((tt<>'  0') and (tt<>'   0')) do
       begin
        tt := FF[IR]; inc(IR);
		  	if (tt ='  2')then
         begin tt := FF[IR]; inc(IR); addLayerCorrente(tt); end;
		  	if (tt =' 62')then
         begin
          tt := FF[IR]; inc(IR);
 					indcolor := StrToInt(tt);
  					case  indcolor of
  						 1:	setcolorepianorgb(indPianocorrente, 255 , 0 ,   0);
  						 2:	setcolorepianorgb(indPianocorrente, 255, 255,   0);
  						 3:	setcolorepianorgb(indPianocorrente,   0, 255,   0);
  						 4:	setcolorepianorgb(indPianocorrente,   0, 255, 255);
  						 5:	setcolorepianorgb(indPianocorrente,   0,   0, 255);
  						 6:	setcolorepianorgb(indPianocorrente, 255,   0, 255);
  						 7:	setcolorepianorgb(indPianocorrente,   0,   0,   0);
  						 8:	setcolorepianorgb(indPianocorrente, 122, 122, 122);
  						 9:	setcolorepianorgb(indPianocorrente, 168, 168, 168);
  						else setcolorepianorgb(indPianocorrente, 0, 0, 0);
             end;
         end;
       end;
     end;


    if tt='ENTITIES' then faseEntity := true;
		while (faseEntity)  do
     begin
       tt := FF[IR]; inc(IR);
       if (tt = '  0') 	  then
        begin tt := FF[IR]; inc(IR);
   			 if (tt = 'ENDSEC')	then begin faseEntity := false; continue; end;

         if (tt = 'POINT')      then tipoelemento :=    1;
 //   	 if (tt = 'INSERT')     then tipoelemento :=    4;
//  		 if (tt = 'LINE')       then tipoelemento :=   20;
//////  	  	 if (tt = 'VERTEX')     then tipoelemento :=  101;
//////   			 if (tt = 'POLYLINE')   then tipoelemento :=    2;
    		 if (tt = 'CIRCLE')     then tipoelemento :=    5;
//////    		 if (tt = 'SEQEND')     then tipoelemento :=    3;
//  		 if (tt = 'TEXT')       then tipoelemento :=    6;
       //	if ([tt isEqualToString:@"ARC"])        { tipoelemento= 7;  }
   		 if (tt = 'LWPOLYLINE') then tipoelemento := 1000;
   		 if (tt = 'HATCH')      then tipoelemento := 1001;
//         if tipoelemento = -1 then showmessage(tt);

        end;
        if (tt='  8')	then
         begin
          tt := FF[IR]; inc(IR);
  				addLayerCorrente(tt);
 //         begin  showmessage(intTostr(tipoelemento));  end;
 //        if tt='parametro' then exit;
     //     Pianocorrente := listapiani.Items[indPianocorrente];
          Pianocorrente.dxfinPianoK(FF,IR,tipoelemento);
//          if (tipoelemento=1001) then begin  showmessage('fatto 1'); exit;  end;
  				tipoelemento :=-1;
         end;
     end;
  end;
  failimiti;
end;


procedure  TDisegnoV.faipunto (HHDC : TImage32; x1 , y1 : real);
var locpiano : TPiano;
begin
	locpiano := ListaPiani.Items[indPianocorrente];
  locpiano.faipunto(HHDC,x1,y1,nil);
end;

procedure  TDisegnoV.faiCivico        (HHDC : TImage32; x1 , y1, x2, y2, x3, y3 : real; txtCiv : String);
var locpiano : TPiano;
begin
	locpiano := ListaPiani.Items[indPianocorrente];
  locpiano.faicivico(HHDC,x1,y1,x2,y2,x3,y3,txtciv);
end;

procedure   TDisegnoV.faiplinea        (HHDC : TImage32; x1 , y1 : real; fasecom : Integer);
var locpiano : TPiano;
begin
	locpiano := ListaPiani.Items[indPianocorrente];
  locpiano.faiplinea(HHDC,x1,y1,fasecom,nil);
end;

procedure   TDisegnoV.faipoligono      (HHDC : TImage32; x1 , y1 : real; fasecom : Integer);
var locpiano : TPiano;
begin
	locpiano := ListaPiani.Items[indPianocorrente];
  locpiano.faiplinea(HHDC,x1,y1,fasecom,nil);
end;

procedure   TDisegnoV.faisimbolo       (HHDC : TImage32; x1 , y1 : real; indice  : Integer; dimfissa : Boolean;
                                        listadefinizioni: TList; nomelista: String; _scalaSimb:real; _angrot:real);
var locpiano : TPiano;
begin
	locpiano := ListaPiani.Items[indPianocorrente];
  locpiano.faisimbolo(HHDC,x1,y1,indice,dimfissa,listadefinizioni,nomelista,_scalaSimb,_angrot);
end;

procedure   TDisegnoV.ruotasimbolo     (HHDC : TImage32; rot: Real);
begin

end;

procedure   TDisegnoV.scalasimbolo     (HHDC : TImage32; sca: Real);
begin

end;

procedure   TDisegnoV.fairegione       (HHDC : TImage32; x1 , y1 : real; fasecom,fasereg : Integer);
var locpiano : TPiano;
begin
	locpiano := ListaPiani.Items[indPianocorrente];
  locpiano.fairegione(HHDC,x1,y1,fasecom,fasereg,nil);
end;


procedure   TDisegnoV.faitesto         (HHDC : TImage32; x1 , y1, ht, ang : real; txtText : String);
var locpiano : TPiano;
begin
	locpiano := ListaPiani.Items[indPianocorrente];
  locpiano.faitesto(HHDC,x1,y1,ht,ang,txtText);
end;

procedure   TDisegnoV.faitestovirtuale (HHDC : TImage32; ht, ang : real; txtText : String);
begin

end;

//   procedure    FissaUndoSeNonRotScaDisegno : (NSUndoManager  *) MUndor : (double) xc : (double) yc;
procedure    TDisegnoV.EseguiUndoEventuali;
begin

end;

//   procedure    impostaUndoRot             : (NSUndoManager  *) MUndor ;
//   procedure    impostaUndoSca             : (NSUndoManager  *) MUndor ;
//   procedure    impostaUndoOrigineX        : (NSUndoManager  *) MUndor ;
//   procedure    impostaUndoOrigineY        : (NSUndoManager  *) MUndor ;
procedure   TDisegnoV.EseguiUndoRot  ;
begin

end;

procedure   TDisegnoV.EseguiUndoSca  ;
begin

end;

procedure   TDisegnoV.EseguiUndoOffX ;
begin

end;

procedure   TDisegnoV.EseguiUndoOffY ;
begin

end;

procedure   TDisegnoV.RemoveDisegno;
begin

end;

procedure   TDisegnoV.addpiano;
begin

end;

procedure   TDisegnoV.DisSpostaDisegno (HHDC : TImage32; dx , dy : Real);
begin

end;

procedure   TDisegnoV.RuotaDisegnoxcyc  ( xc , yc, ang  : real);
var locpiano : TPiano;
    i : Integer;
begin
 for i:=0 to ListaPiani.count-1 do
  begin
		locpiano := ListaPiani.Items[i];
    locpiano.RuotaPiano(xc,yc,ang);
  end;
end;

procedure   TDisegnoV.ScalaDisegnoxcyc  (xc , yc, scal : real);
var locpiano : TPiano;
    i : Integer;
begin
 for i:=0 to ListaPiani.count-1 do
  begin
		locpiano := ListaPiani.Items[i];
    locpiano.ScalaPiano(xc,yc,scal);
  end;
end;

procedure   TDisegnoV.Distxtvirtual    (HHDC : TImage32; xc , yc, ang, scal : Real);
begin

end;

procedure   TDisegnoV.DisegnaSplineVirtuale (HHDC : TImage32; x1, y1 : Integer);
begin

end;

procedure   TDisegnoV.disegnailpianino (HHDC : TImage32);
begin

end;

procedure   TDisegnoV.dispallinispline (HHDC : TImage32);
begin

end;

procedure   TDisegnoV.disVtTutti       (HHDC : TImage32);
begin

end;

procedure   TDisegnoV.salvaDisegnoMacMac  (_nomedisegno: String);
var _data : TMemoryStream;
    nump , k : Integer;
    locpia : TPiano;
begin
 _data := TMemoryStream.Create;

  _data.Write(VersioneSoftware,sizeof(VersioneSoftware));

  _data.Write(b_editabile,sizeof(b_editabile));
  _data.Write(b_snappabile,sizeof(b_snappabile));
  _data.Write(alfalinee,sizeof(alfalinee));
  _data.Write(alfasuperfici,sizeof(alfasuperfici));

  nump:= ListaPiani.Count;
  _data.Write(indPianocorrente,sizeof(indPianocorrente));
  _data.Write(nump,sizeof(nump));

  for k:=0 to ListaPiani.Count-1 do
   begin
    locpia := ListaPiani.Items[k];
    locpia.salvapianoMacMap(_data);
   end;
 _data.SaveToFile(_nomedisegno);
 _data.Free;
end;

procedure   TDisegnoV.apriDisegnoMacMac   (_nomedisegno: String);
begin

end;


procedure   TDisegnoV.SalvaDisegnoDxf  (_nomedisegno: String);
begin

end;

procedure   TDisegnoV.apriDisegnoShp   (_nomedisegno: String);
begin

end;

procedure   TDisegnoV.apriDisegnoCxf   (_nomedisegno: String);
begin

end;

procedure   TDisegnoV.cambianomedbase  (_newtext    : string);
begin

end;

procedure   TDisegnoV.cambianomeTavola (_newtext    : string);
begin

end;

// edit vettoriale
procedure   TDisegnoV.ortosegmenta     (x1, y1 : real);
begin

end;

procedure   TDisegnoV.seleziona_conPt  (x1, y1 : real;  _LSelezionati : Tlist);
var k : Integer;
    locpiano : TPiano;
begin
 if not(b_visibile) then exit;
 for k:=0 to Listapiani.Count-1 do
  begin
   locpiano := Listapiani.items[k];
   locpiano.seleziona_conPt(x1,y1,_LSelezionati);
  end;
end;

function   TDisegnoV.selezionaCivicoEditPt (xc, yc : real) : Boolean;
var k : Integer;
    locpiano : TPiano;
    locres : Boolean;
begin
 locres := false;
 if not(b_visibile) then exit;
 for k:=0 to Listapiani.Count-1 do
  begin
   locpiano := Listapiani.items[k];
   if locpiano.selezionaCivicoEditPt (xc, yc) then
    begin locres := true; break; end;
  end;
  result := locres;
end;

procedure   TDisegnoV.seleziona_conPtInterno  (x1,y1:  real;  _LSelezionati : Tlist);
var k : Integer;
    locpiano : TPiano;
begin
 for k:=0 to Listapiani.Count-1 do
  begin
   locpiano := Listapiani.items[k];
   locpiano.seleziona_conPtInterno(x1,y1,_LSelezionati);
  end;
end;

procedure   TDisegnoV.selezionaEdif_conPtInterno  (x1,y1:  real;  _LSelezionati : Tlist);
var k : Integer;
    locpiano : TPiano;
begin
 for k:=0 to Listapiani.Count-1 do
  begin
   locpiano := Listapiani.items[k];
   if locpiano.pianoPlus then locpiano.seleziona_conPtInterno(x1,y1,_LSelezionati);
  end;
end;


procedure   TDisegnoV.selezionaTerre_conPtInterno (x1,y1:  real;  _LSelezionati : Tlist);
begin

end;

function    TDisegnoV.Match_conPt     (x1, y1 : real) : boolean;
var k : Integer;
    locpiano : TPiano;
    resulta : Boolean;
begin
 resulta := false;
 for k:=0 to Listapiani.Count-1 do
  begin
   locpiano := Listapiani.items[k];
   if not(locpiano.b_visibile) then continue;

   if locpiano.Match_conPt(x1,y1) then
    begin indPianocorrente:=k; resulta := true; break; end;
  end;
  result := resulta;
end;

function   TDisegnoV.selezionaVtconPt   (x1,y1:  real;  _LSelezionati : Tlist) : boolean;
var k : Integer;
    locpiano : TPiano;
    resulta : Boolean;
begin
 resulta := false;
 for k:=0 to Listapiani.Count-1 do
  begin
   locpiano := Listapiani.items[k];
   if not (locpiano.b_visibile) then continue;
   if locpiano.selezionaVtconPt(x1,y1,_LSelezionati) then
    begin resulta := true; break; end;
  end;
  result := resulta;
end;

function    TDisegnoV.selezionaVtspconPt (HHDC : TImage32;   x1,y1:  real;  _LSelezionati : Tlist) : boolean;
begin

end;

// aggiungi elementi vettoriali
function    TDisegnoV.faiCatpoligono   (HHDC : TImage32; x1,y1:  real; fasecom : integer; disVcomp : TDisegnoV)  : boolean;
begin

end;

procedure   TDisegnoV.BackPlineaAdded;
begin

end;

procedure   TDisegnoV.finitaPolilinea  (HHDC : TImage32);
var dc : Hdc;
begin
 dc  := HHDC.Bitmap.Handle;                                                          setrop2(dc,r2_not);
  movetoEx(dc,xclickdown,hSchermo-yclickdown,nil); lineto(dc,xmom,hSchermo-ymom);
 setrop2(dc,r2_copypen);
 HHDC.Repaint;
end;

procedure   TDisegnoV.finitoRettangolo (HHDC : TImage32);
var dc : Hdc;
begin
 dc  := HHDC.Bitmap.Handle;                                                          setrop2(dc,r2_not);
  movetoEx(dc,xclickdown,hSchermo-yclickdown,nil);
   lineto(dc,xmom,hSchermo-yclickdown);
   lineto(dc,xmom,hSchermo-ymom);
   lineto(dc,xclickdown,hSchermo-ymom);
   lineto(dc,xclickdown,hSchermo-yclickdown);
 setrop2(dc,r2_copypen);
 HHDC.Repaint;
end;


procedure   TDisegnoV.chiudipoligono   (HHDC : TImage32);
begin

end;

procedure   TDisegnoV.faicerchio       (HHDC : TImage32; x1, y1, x2,y2: Real);
var locpiano : TPiano;
begin
	locpiano := ListaPiani.Items[indPianocorrente];
  locpiano.faicerchio(HHDC,x1,y1,x2,y2,nil);
end;

procedure   TDisegnoV.fairettangolo    (HHDC : TImage32; x1, y1, x2, y2:real);
var locpiano : TPiano;
    fase : Integer;
begin
  fase :=0;
	locpiano := ListaPiani.Items[indPianocorrente];
  locpiano.faiplinea(HHDC,x1,y1,fase,nil);
  locpiano.faiplinea(HHDC,x2,y1,fase,nil);
  locpiano.faiplinea(HHDC,x2,y2,fase,nil);
  locpiano.faiplinea(HHDC,x1,y2,fase,nil);
  locpiano.faiplinea(HHDC,x1,y1,fase,nil);
  Polyincostruzione.b_chiusa:=true;
  Polyincostruzione.Disegna(HHDC);
end;


procedure   TDisegnoV.updateEventualeRegione (HHDC : TImage32);
begin

end;

procedure   TDisegnoV.cancellaultimovt ;
begin

end;

procedure   TDisegnoV.SpostaDisegnodxdy(dx, dy : Real);
var k : Integer;
    locpiano : TPiano;
begin
 for k:=0 to Listapiani.Count-1 do
  begin
   locpiano := Listapiani.items[k];
   locpiano.SpostaPiano(dx,dy);
  end;
    limx1 := limx1+ dx; limx2 := limx2 + dx;
    limy1 := limy1+ dy; limy2 := limy2 + dy;
end;

procedure   TDisegnoV.RuotaDisegnodxdy (xc, yc, xc2, yc2 : real);
begin

end;

procedure   TDisegnoV.RuotaDisegnoang  (xc, yc, ang : real);
begin

end;

procedure   TDisegnoV.ScalaDisegno     (xc,yc,xc2, yc2: Real);
begin

end;

procedure   TDisegnoV.ScalaDisegnoPar  (xc,yc, par : real);
begin

end;

function    TDisegnoV.dimptPianoInd    ( indice : Integer): real;
begin

end;

procedure   TDisegnoV.SetdimptPianoInd (valore : real; indice: integer);
begin

end;

procedure   TDisegnoV.updateInfoConLimiti;
begin

end;

procedure   TDisegnoV.updateInfoConLimitiPianoCorrente;
begin

end;

function    TDisegnoV.damminumpiani : Integer;
begin

end;

function    TDisegnoV.IndicePianocorrente : Integer;
begin
  result := self.indPianocorrente;
end;

procedure   TDisegnoV.setvisibile       (_state : integer);
begin

end;

function    TDisegnoV.visibile : Boolean;
begin

end;

function    TDisegnoV.visibilepiano     (indice :Integer): Boolean;
begin

end;

procedure   TDisegnoV.seteditabile      (_state : Integer);
begin

end;

function    TDisegnoV.editabilepiano    (indice : Integer) : Boolean;
begin

end;

procedure   TDisegnoV.setsnappabile     (_state : integer);
begin

end;

function    TDisegnoV.snappabilepiano   (indice :Integer): Boolean;
begin

end;

function    TDisegnoV.spessorepiano     (indice : Integer)  : real;
begin

end;

procedure   TDisegnoV.setnomedisegno    (_nome : string);
begin

end;


function    TDisegnoV.nomeFoglioCXF  : String;
var resulta : String;
    k : Integer;
    carro : String;
    fattononzero : Boolean;
begin
 resulta := ''; fattononzero := false;
 if length(nomedisegno)<10 then exit;
 for k:= 6 to 9 do
  begin
   carro := nomedisegno[k];
   if carro<>'0' then fattononzero := true;
   if fattononzero then resulta := resulta+carro;
  end;
 result := resulta;
end;


function    TDisegnoV.Solonomedisegno  : String;
begin

end;

function    TDisegnoV.SolonomedisegnoNoext  : String;
begin

end;


procedure   TDisegnoV.setnomepianoind   (_nome: String;  indice : integer);
begin

end;

function    TDisegnoV.alphaline : Integer;
begin

end;

function    TDisegnoV.alphasup : integer;
begin

end;

procedure   TDisegnoV.setalphaline     (_value : integer);
begin

end;

procedure   TDisegnoV.setalphasup      (_value : integer);
begin

end;

function    TDisegnoV.alphalinepiano   (_indpiano : integer) : real;
begin

end;

function    TDisegnoV.alphasuppiano    (_indpiano : integer) : real;
begin

end;


	// - (void)   impostalimiti;
procedure   TDisegnoV.rifarenomipianicancelletto;
begin

end;

function    TDisegnoV.colorepianoind_r(_indpiano : integer) : integer;
begin

end;

function    TDisegnoV.colorepianoind_g(_indpiano : integer) : integer;
begin

end;

function    TDisegnoV.colorepianoind_b(_indpiano : integer) : integer;
begin

end;

function    TDisegnoV.givemenomepianocorrente : String;
begin

end;

function    TDisegnoV.givemecommentopianocorrente : String;
begin

end;

function    TDisegnoV.givemenomepianoindice(indice : Integer) : String;
begin

end;

function    TDisegnoV.infopianocorrente : String;
begin

end;

function    TDisegnoV.infodisegno       : String;
begin

end;

function    TDisegnoV.nomepoligonopt    (xc, yc : real) : String;
begin

end;


// edit topologico
procedure TDisegnoV.EliminaPianiVuoti ;
var k : Integer;
    locpiano : TPiano;
begin
 for k:= ListaPiani.Count-1 downto 1 do
  begin
   locpiano := ListaPiani.items[k];
   if locpiano.Listavector.Count=0 then ListaPiani.delete(k);
  end;
end;

procedure TDisegnoV.EliminaPianoCorrente;
begin

end;

procedure TDisegnoV.FondiDis                    (disadd : TDisegnoV);
begin

end;

procedure TDisegnoV.FondiPianiStessoNome ;
begin

end;


procedure TDisegnoV.EliminaPuntiDoppiNelPiano;
var 	locpiano  : TPiano;    i : Integer;
begin
  for i:=0 to ListaPiani.Count-1 do
   begin locpiano := ListaPiani.Items[i];  locpiano.EliminaPuntiDoppiNelPiano;  end;
end;

procedure TDisegnoV.EliminaPianoIndice         (indice : integer);
begin

end;

procedure TDisegnoV.setdispallinivtpiano       (indice : integer;  state : Boolean);
begin

end;

procedure TDisegnoV.setdispallinivtfinalipiano (indice : integer;  state: Boolean);
begin

end;

procedure TDisegnoV.dispallinivtpiano          (indice : integer) ;
begin

end;

function  TDisegnoV.dispallinivtfinalipiano    (indice : integer) : Boolean;
begin

end;

procedure TDisegnoV.settratteggiopiano         (indice : integer; indtratto : Integer);
begin

end;

procedure TDisegnoV.setCampitura               (indice : integer; indCamp : Integer);
begin

end;

procedure TDisegnoV.CatToUtm;
begin

end;

function  TDisegnoV.esistenomepiano            (nompia : String): Boolean;
begin

end;

function  TDisegnoV.indicePianoconNome         (nompia : String): Integer;
var 	locpiano  : TPiano;
      i : Integer;
      resulta : Integer;
begin
 resulta := -1;
  for i:=0 to ListaPiani.Count-1 do
   begin
		locpiano := ListaPiani.Items[i];
    if (locpiano.nomepiano = nompia) then begin resulta := i; break; end;
   end;
 result := resulta;
end;

//   procedure TematizzaTerreno           : (Immobili *) immobili;
//   procedure TematizzaTerrenoSuNuovoDis : (DisegnoV *) Disnuovo  : (Immobili *) immobili;
procedure TDisegnoV.NoTematizzaTerreno ;
begin

end;

procedure TDisegnoV.TestoAltoQU;
begin

end;


procedure TDisegnoV.layerscatastaliOnOff(modo : Integer);
var 	locpiano  : TPiano;
      i : Integer;
begin
  for i:=0 to ListaPiani.Count-1 do
   begin
		locpiano := ListaPiani.Items[i];
    case modo of
     1 :
      begin
       if locpiano.isTerreno then locpiano.b_visibile:= true;
      end;
     2 :
      begin
//       if locpiano.isTerreno then locpiano.b_visibile:= false;
         locpiano.b_visibile:= true;
         if not(locpiano.pianoPlus) then begin setvisibilepiano (i , false);   end
                                    else begin setvisibilepiano (i , true);    end;
      end;
    end;
   end;
end;

procedure TDisegnoV.ScalaDaBarra(sca : Integer);
var paramsca : Real;
begin
 paramsca := sca/laPosSca;
 ScalaDisegnoxcyc(eventuale_xc,eventuale_yc ,paramsca  );
 laPosSca :=sca;
end;

procedure TDisegnoV.RuotaDaBarra(newrot :  Integer);
var paramrot : Real;
begin
 paramrot := (newrot-laPosRot)/1000;
 RuotaDisegnoxcyc(eventuale_xc,eventuale_yc ,paramrot  );
 laPosRot := newrot;
end;


procedure TDisegnoV.SpostaXDaBarra(newX :  Integer);
var paramSpo : Real;
begin
 paramSpo := (newX- laPosSpoX)/100;
 SpostaDisegnodxdy(paramSpo,0);
 laPosSpoX:=newX;
end;

procedure TDisegnoV.SpostaYDaBarra(newY :  Integer);
var paramSpo : Real;
begin
 paramSpo := (newY- laPosSpoY)/100;
 SpostaDisegnodxdy(0,paramSpo);
 laPosSpoY:=newY;
end;


procedure TDisegnoV.tuttoPenDownPolyline;
var k : Integer;
    locpiano : TPiano;
begin
 for k:=0 to Listapiani.Count-1 do
  begin
   locpiano := Listapiani.items[k];
   locpiano.tuttoPenDownPolyline;
  end;
end;

function  TDisegnoV.nomepianovicinopt(xa,ya : Real) : String;
var resulta : String;
    k : Integer;
    locpiano : TPiano;
begin
 resulta  :='';
 for k:=0 to Listapiani.Count-1 do
  begin
   locpiano := Listapiani.items[k];
   resulta := locpiano.nomepianovicinopt(xa,ya);
   if resulta<>'' then break;
  end;
 result:= resulta;
end;


procedure TDisegnoV.PolyToPoligoni;
var k : Integer;
    locpiano : TPiano;
begin
 for k:=0 to Listapiani.Count-1 do
  begin
   locpiano := Listapiani.items[k];
   locpiano.PolyToPoligoni;
  end;
end;

procedure TDisegnoV.EliminaPianiOff;
var k : Integer;
    locpiano : TPiano;
begin
 for k:=Listapiani.Count-1 downto 1 do
  begin
   locpiano := Listapiani.items[k];
   if not(locpiano.b_visibile) then Listapiani.delete(k);
  end;
end;

procedure TDisegnoV.EliminaPianiON;
var k : Integer;
    locpiano : TPiano;
begin
 for k:=Listapiani.Count-1 downto 1 do
  begin
   locpiano := Listapiani.items[k];
   if (locpiano.b_visibile) then Listapiani.delete(k);
  end;
end;


procedure TDisegnoV.PianiTuttiON;
var k : Integer;
    locpiano : TPiano;
begin
 for k:=Listapiani.Count-1 downto 0 do
  begin
   locpiano := Listapiani.items[k];
   locpiano.b_visibile:=true;
  end;
end;

procedure TDisegnoV.PianiTuttiOff;
var k : Integer;
    locpiano : TPiano;
begin
 for k:=Listapiani.Count-1 downto 0 do
  begin
   locpiano := Listapiani.items[k];
   locpiano.b_visibile:=false;
  end;
end;


procedure TDisegnoV.FondituttoPrimoPiano;
var k,j : Integer;
    locpiano : TPiano;
    piano1 : TPiano;
    locvet : TVettoriale;
begin
 if Listapiani.Count<2 then exit;
 piano1 := Listapiani.items[1];
 for k:=Listapiani.Count-1 downto 2 do
  begin
   locpiano := Listapiani.items[k];
   for j:=0 to locpiano.Listavector.Count-1 do
    begin
     locvet := locpiano.Listavector.items[j];
     piano1.Listavector.Add(locvet);
	   locvet._piano  := piano1;
    end;
   Listapiani.delete(k);
  end;
end;



end.
