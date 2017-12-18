unit Interfaccia;

interface


uses System.classes,Vcl.Menus,Vcl.Controls, sysutils,FMX.Dialogs,varbase, windows
     , Vcl.Graphics, Vcl.StdCtrls, Buttons
;


//  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,  ,
//   Vcl.Forms, Vcl.Dialogs, , Vcl.ExtCtrls;

//uses   GR32,  GR32_Image, GR32_Layers, Vcl.Controls ,FMX.Dialogs ,sysutils;


procedure ridisegna;
procedure ridisegnaInterfaccia;
procedure ridisegnaCoordinateMouse;
procedure ridisegnaNomiDis;
procedure ridisegnaNomiPiani;
procedure ridisegnaNomiRas;
procedure ridisegnaNomiSubras;

procedure caricaInterfacciaPersonalizzata;

procedure Interf_ToltoDisegnoR(nomedir : String);
procedure Interf_ToltoDisegnoV(nomedir : String);


procedure AggiornaInterfaceComandoAzione ( com : TipoComando;  fase : Integer);
procedure ridisegnaCoordinateMouse2; // Interfaccia
procedure bottonisuegiu;


procedure sw_snapFine;
procedure sw_snapVicino;
procedure sw_snapOrto;
procedure sw_snaportoSeg;
procedure sw_snapGriglia;
procedure sw_snapAllOff;

procedure CambiaProiezione(modo : Integer);

procedure ricentraScaGR;
procedure ricentraRotGR;
procedure RotGR_update;

procedure ricentraScaV;
procedure ricentraRotV;
procedure ricentraSpoXV;
procedure ricentraSpoYV;
procedure RotV_update;


procedure setfasecomando(newfase:Integer);
procedure setfasecomandopiu1;
procedure ImpostaComuneSetUp(modo : Integer);

procedure updateNumSelezionati;

implementation

 uses Main, utility1,  GR32,  GR32_Image, progetto, disegnoV, DisegnoR,DisegnoGR,
     Piano, proiezioni,CatastoV, funzioni;



procedure ridisegna;
begin
 if ilProgetto<>nil then ilProgetto.Disegna(mainform.BaseSchermo,false);
end;

procedure  setlabelComando (msgstr : String);
begin
	 Mainform.BotMsg1.Caption:=msgstr;
end;

procedure  setlabelAzione   (msgstr : String);
begin
	 Mainform.BotMsg2.Caption:=msgstr;
end;


procedure  AggiornaInterfaceComandoAzione ( com : TipoComando;  fase : Integer);
begin
  bottonisuegiu;

 	case com of
   // Viste
	 kStato_zoomWindow : begin
    setlabelComando('Zoom Finestra : ');
		if (fase=0)	then  setlabelAzione('Inserire 1^ Angolo')
                else  setlabelAzione('Inserire 2^ Angolo');
   end;
   kStato_zoomC      : begin
    setlabelComando('Zoom Centro : ');
    setlabelAzione('Indica Nuovo Centro della Vista');
   end;
   kStato_Pan        : begin
    setlabelComando('Pan : ');
		if (fase=0)	then  setlabelAzione('Inserire 1^ Posizione')
                else  setlabelAzione('Inserire 2^ Posizione');
   end;

   // comandi raster
   kStato_spostaRaster_tutti  :  begin
    setlabelComando('Sposta Gruppo Immagini : ');
		if (fase=0)	then  setlabelAzione('Inserire 1^ Posizione')
                else  setlabelAzione('Inserire 2^ Posizione');
    end;

   kStato_spostaRaster2pt_tutti  : begin
    setlabelComando('Sposta Gruppo');
  	setlabelAzione('Inserire 1^ Posizione e dare coordinate in dialog');
   end;

   kStato_spostaRaster_uno       : begin
    setlabelComando('Sposta Immagine');
		if (fase=0)	then  setlabelAzione('Inserire 1^ Posizione')
                else  setlabelAzione('Inserire 2^ Posizione');
   end;

 	 kStato_rotoScal2PtCentrato    : begin
    setlabelComando('Calibra Centrato con 2^ Punto');
  	setlabelAzione('Inserire Posizione e dare coordinate in dialog');
   end;

   kStato_spostaRaster2pt_uno    : begin
    setlabelComando('Sposta Immagine');
    setlabelAzione('Inserire 1^ Posizione e dare coordinate in dialog');
   end;

   kStato_scalarighello          : begin
    setlabelComando('Righello');
		case fase of
  	  0 :  setlabelAzione('Inserisci 1^ Punto');
  	  1 :  setlabelAzione('Inserisci 2^ Punto');
  	  2 :  setlabelAzione('Inserisci Nuova Distanza in dialog');
    end;
   end;

   kStato_rotoscalaraster        : begin
    setlabelComando('Ruota e Scala Immagine con 2 segmenti');
  	case fase of
  	 0 :  setlabelAzione('1^ Punto Attuale');
  	 1 :  setlabelAzione('2^ Punto Attuale');
  	 2 :  setlabelAzione('1^ Punto Futuro');
  	 3 :  setlabelAzione('2^ Punto Futuro');
    end;
   end;

   kStato_calibra8click          :  begin
    setlabelComando('Calibra a 8 Punti');
  	case fase of
  	  0 : setlabelAzione('1^ Punto Attuale');
  	  1 : setlabelAzione('1^ Punto Futuro');
  	  2 : setlabelAzione('2^ Punto Attuale');
  	  3 : setlabelAzione('2^ Punto Futuro');
  	  4 : setlabelAzione('3^ Punto Attuale');
  	  5 : setlabelAzione('3^ Punto Futuro');
  	  6 : setlabelAzione('4^ Punto Attuale');
  	  7 : setlabelAzione('4^ Punto Futuro');
    end;
   end;

	 kStato_Calibraraster          :   begin
    setlabelComando('Calibra Raster');
  	case fase of
  		0 :  setlabelAzione('completare la dialog');
  		1 :  setlabelAzione('Inserisci X1 a schermo');
  		2 :  setlabelAzione('Inserisci X2 a schermo');
  		3 :  setlabelAzione('Inserisci Y1 a schermo');
  		4 :  setlabelAzione('Inserisci Y2 a schermo');
    end;
   end;

 	kStato_CalibrarasterFix	 : begin
   setlabelComando('Calibra Raster');
   case fase of
  	 0 : setlabelAzione('completare la dialog');
  	 1 : setlabelAzione('Inserisci X1 a schermo');
  	 2 : setlabelAzione('Inserisci Y1 a schermo');
   end;
  end;

  kStato_CropRasterRettangolo : begin
   setlabelComando('Crop Raster con Rettangolo');
   case fase of
  	 0 : setlabelAzione('Inserisci 1° Punto');
  	 1 : setlabelAzione('Inserisci 2° Punto');
   end;
  end;


  kStato_FixCentroRot ,kStato_FixCentroRotVettoriale      : begin
   setlabelComando('Centro di Rotazione');
   setlabelAzione('Inserire Posizione del centro');
  end;


  kStato_DistRighello : begin
   setlabelComando('Distanza due Punti');
   case fase of
  	 0 : setlabelAzione('Inserisci 1° Punto');
  	 1 : setlabelAzione('Inserisci 2° Punto');
   end;
  end;

  kStato_DefStampa    : begin
   setlabelComando('Definisci area di Stampa');
   case fase of
  	 0 : setlabelAzione('Individua area con 1 Punto');
   end;
  end;

    		       // comandi vettoriali
  kStato_Punto              : begin
    setlabelComando('Punto : ');   setlabelAzione('Inserire posizione ');
  end;

  kStato_Polilinea          : begin
   setlabelComando('Polilinea');
   setlabelAzione('Inserire vertice');
  end;

  kStato_Poligono           : begin
   setlabelComando('Poligono');
   setlabelAzione('Inserire vertice');
  end;

  kStato_Regione            : begin
   setlabelComando('Regione');
   setlabelAzione('Inserire vertice');
  end;

  kStato_Cerchio            : begin
   setlabelComando('Cerchio');
   setlabelAzione('Centro e Raggio');
  end;

  kStato_Testo              : begin
   setlabelComando('Testo');
   setlabelAzione('Indica Posizione');
  end;

  kStato_TestoRuotato       : begin
   setlabelComando('Testo Ruotato');
    if fase = 0 then setlabelAzione('Indica Posizione')
                else setlabelAzione('Indica Angolo');
  end;

  kStato_TestoRotoScalato   : begin
   setlabelComando('Testo ruota e scala');
    case fase of
  		0 : setlabelAzione('Indica Posizione');
  		1 : setlabelAzione('Indica Angolo');
  		2 : setlabelAzione('Indica Altezza');
    end;
  end;

  kStato_Civico             : begin
   setlabelComando('Civico');
    case fase of
  		0 : setlabelAzione('Indica Posizione edificio');
  		1 : setlabelAzione('Indica Posizione testo');
  		2 : setlabelAzione('Indica Posizione strada');
    end;
  end;

  kStato_txtstradale : begin
   setlabelComando('Testo Strada');
   setlabelAzione('Indica Posizione strada');
  end;

  kStato_PtTastiera         : begin
   setlabelComando('Punto da Tastiera');
   setlabelAzione('Inserire Posizione in Dialog');
  end;

  kStato_Simbolo            : begin
   setlabelComando('Simbolo');
   setlabelAzione('inserire  posizione');
  end;

  kStato_SimboloFisso       : begin
   setlabelComando('Simbolo dimensione fissa');
   setlabelAzione('inserire  posizione');
  end;

  kStato_SimboloRot         : begin
   setlabelComando('Simbolo ruotato');
    if fase = 0 then setlabelAzione('Indica Posizione')
                else setlabelAzione('Indica Angolo');
  end;

  kStato_SimboloRotSca      : begin
   setlabelComando('Simbolo ruotato scalato');
   case fase of
  	 0 : setlabelAzione('inserire  posizione');
  	 1 : setlabelAzione('Indica Angolo');
  	 2 : setlabelAzione('Indica ingrandimento');
   end;
  end;

  kStato_Rettangolo         : begin
   setlabelComando('Rettangolo');
    if fase = 0 then setlabelAzione('Inserisci 1^ vertice')
                else setlabelAzione('Inserisci 2^ vertice');
  end;

  kStato_CatPoligono        : begin
   setlabelComando('Costruzione Poligono');
   setlabelAzione('Inserire vertice');
  end;

  kStato_Righello           : begin
   setlabelComando('Righello');
   setlabelAzione('Punto di partenza');
  end;

  kStato_SpostaDisegno      : begin
   setlabelComando('Sposta Disegno');
    if fase = 0 then setlabelAzione('Posizione Iniziale')
                else setlabelAzione('Posizione Finale');
  end;

  kStato_FixVCentroRot      : begin
   setlabelComando('Centro di Rotazione Disegno');
   setlabelAzione('Inserire Posizione del centro');
  end;

  kStato_Seleziona           : begin
   setlabelComando('Seleziona');
   setlabelAzione('Seleziona oggetti');
  end;

  kStato_Deseleziona         : begin
   setlabelComando('Deseleziona');
   setlabelAzione('Scegli gli oggetti');
  end;

  kStato_CancellaSelected    : begin
   setlabelComando('Cancella');
   setlabelAzione('cancella i selezionati');
  end;

  kStato_SpostaSelected      : begin
   setlabelComando('Sposta Selezionati');
    if fase = 0 then setlabelAzione('Posizione Iniziale')
                else setlabelAzione('Posizione Finale');
  end;

  kStato_CopiaSelected       : begin
   setlabelComando('Copia Selezionati');
    if fase = 0 then setlabelAzione('Posizione Iniziale')
                else setlabelAzione('Posizione Finale');
  end;

  kStato_RuotaSelected        :	begin
   setlabelComando('Ruota Selezionati');
    if fase = 0 then setlabelAzione('Posizione Iniziale')
                else setlabelAzione('Posizione Finale');
  end;

  kStato_ScalaSelected        : begin
   setlabelComando('Scala Selezionati');
    if fase = 0 then setlabelAzione('Posizione Iniziale')
                else setlabelAzione('Posizione Finale');
  end;

  kStato_SpostaVertice        : begin
   setlabelComando('Sposta Vertice');
    if fase = 0 then setlabelAzione('Seleziona vertice')
                else setlabelAzione('Nuova posizione');
  end;

  kStato_InserisciVertice     : begin
   setlabelComando('Inserisci Vertice');
    if fase = 0 then setlabelAzione('Seleziona segmento polilinea')
                else setlabelAzione('Nuova posizione');
  end;

  kStato_CancellaVertice      :	begin
   setlabelComando('Cancella Vertice');
   setlabelAzione('Seleziona vertice di una polilinea');
  end;

  kstato_editText             : begin
   setlabelComando('Edit Testo');
   setlabelAzione('seleziona testo');
  end;

  kStato_Info                 : begin
   setlabelComando('Info');
   setlabelAzione('seleziona elemento');
  end;

  kStato_InfoSup              :	begin
   setlabelComando('Info Superficie');
   setlabelAzione('Indicare punto interno');
  end;

  kStato_InfoLeg              : begin
   setlabelComando('Info Area del Disegno');
   setlabelAzione('Indicare punto interno');
  end;

  kStato_InfoIntersezione2Poligoni:	begin
   setlabelComando('Info Area Intersezione due Poligoni');
   setlabelAzione('Indicare punto interno ai due Poligoni');
  end;

  kStato_InfoEdificio             :	begin
   setlabelComando('Info Edificio');
   setlabelAzione('Indicare punto interno');
  end;

  kStato_Match                    : begin
   setlabelComando('Vai al piano');
   setlabelAzione('seleziona elemento');
  end;

  kStato_TarquiniaFogliopt        : begin
   setlabelComando('Apri foglio catastale');
   setlabelAzione('Indica punto interno QuadroUnione');
  end;

  kStato_RettangoloStampa     ,
  kStato_RettangoloDoppioStampa :
   begin
  	setlabelComando('Definisci la zona da stampare');
    if fase = 0 then setlabelAzione('Inserire primo angolo Rettangolo')
                else setlabelAzione('Inserire opposto angolo del Rettangolo');
   end;

   kStato_SpostaDisegnoptDlg  : begin
    setlabelComando('Sposta Disegno');
  	setlabelAzione('Inserire Una Posizione Mouse e dare coordinate in dialog');
   end;

   kStato_SpostaPosCivico  : begin
    setlabelComando('Sposta Civico');
    if fase = 0 then setlabelAzione('Seleziona attuale Posizione')
                else setlabelAzione('Nuova posizione');
   end;


  kStato_TagliaPoligono : begin
  	setlabelComando('Taglia Poligono selezionato');
    if fase = 0 then setlabelAzione('1^ punto taglio del poligono selezionato');
    if fase = 1 then setlabelAzione('2^ punto taglio del poligono selezionato');
    if fase = 2 then setlabelAzione('seleziona parte da tagliare');
  end;


  kStato_InfoConcessione : begin
  	setlabelComando('Informazione sulla concessione');
    setlabelAzione('Seleziona superficie in concessione');
  end;


  // di sviluppo interno
  kstato_spostaTerritorioPrCoord :  begin
  	setlabelComando('Sposta Intero Territorio');
    if fase = 0 then setlabelAzione('Inserire primo punto')
                else setlabelAzione('completare dialog');
   end
   else begin
   	setlabelComando('Comando : ');   setlabelAzione('');
   end;

  end;

end;

(*

  	[interfacewindow AggiornaInterfaceComandoAzione:com:fase];

  		// gruppo Raster
  	[RBZoomRasAll      setState:0];
  	[RBAddRas          setState:0];
  	[RBLessRas         setState:0];
  	[RBMovOrRasAll     setState:0];
  	[RBMovOrR2ptAll    setState:0];

  		// singolo Raster
  	[RBZoomRas         setState:0];
  	[RBAddSubRas       setState:0];
  	[RBLessSubRas      setState:0];

  	[RBMovOrRas        setState:0];
  	[RBMovOrR2pt       setState:0];
  	[RBRigRas          setState:0];
  	[RBRotScaRas       setState:0];
  	[RBRas0gr          setState:0];
  	[RBCalRasBar       setState:0];
      [RBCalRasBarFix    setState:0];
  	[RBCropRas         setState:0];
  	[RBMaskRas         setState:0];

      [VBMoveDis         setState:0];
          //   [VBRotDis          setState:0];
          //    [VBScaDis          setState:0];


  		// calibrazione fine
  		//	[RBCenCalRas       setState:0];
  	[VBCenCalVet       setState:0];

  		// Catasto
  	[BFoglio       setState:0];

  	[VBInfoLeg setState:0];
  	[VBInfoInt2Polyg setState:0];

  	[LevelIndicatore setHidden:YES];


  	[self setlabelComando:@"Comando"];
  	[self setlabelAzione :@"Azione"];

  	switch (com) {
  				// vista


  				// gruppo Raster
  	  case kStato_spostaRaster_tutti       : [RBMovOrRasAll    setState:1];	  break;
  	  case kStato_spostaRaster2pt_tutti    : [RBMovOrR2ptAll   setState:1];	  break;
  				// singolo Raster
   	  case kStato_spostaRaster_uno         : [RBMovOrRas       setState:1];	  break;
  	  case kStato_spostaRaster2pt_uno      : [RBMovOrR2pt      setState:1];	  break;
  	  case kStato_scalarighello	           : [RBRigRas         setState:1];	  break;
  	  case kStato_rotoscalaraster          : [RBRotScaRas      setState:1];	  break;
  	  case kStato_calibra8click            : [RBcal8pt         setState:1];   break;
  	  case kStato_Calibraraster			   : [RBCalRasBar      setState:1];   break;
   	  case kStato_CalibrarasterFix		   : [RBCalRasBarFix   setState:1];   break;
  				//	  case kStato_FixCentroRot             : [RBCenCalRas      setState:1];   break;

  	  case kStato_FixVCentroRot            : [VBCenCalVet      setState:1];   break;
    kStato_zoomWindow      	[ESZoom2  setSelected:YES   forSegment:2];	break;
   kStato_zoomC                  : [ESZoom1  setSelected:YES  forSegment:3];	[ESZoom2  setSelected:YES   forSegment:3];	break;
   kStato_Pan                    : [ESZoom1  setSelected:YES  forSegment:6];	[ESZoom2  setSelected:YES   forSegment:6];	break;

  				// vettoriale
  		case kStato_Punto      			   : [VSegDis1         setSelected:YES forSegment:0]; break;
  		case kStato_Polilinea              : [VSegDis1         setSelected:YES forSegment:1]; break;
  		case kStato_Poligono               : [VSegDis1         setSelected:YES forSegment:2]; break;
  		case kStato_Regione                : [VSegDis1         setSelected:YES forSegment:3]; break;

  		case kStato_Rettangolo             : [VSegDis2         setSelected:YES forSegment:1]; break;
  		case kStato_Cerchio                : [VSegDis2         setSelected:YES forSegment:2]; break;
  		case kStato_Testo                  : [VSegDis2         setSelected:YES forSegment:3]; break;
  		case kStato_Simbolo                : [VSegDis2         setSelected:YES forSegment:0]; break;
  				//		case kStato_Splinea                : [VSegDis2         setSelected:YES forSegment:1]; break;
  				//		case kStato_Spoligono              : [VSegDis2         setSelected:YES forSegment:2]; break;
  				//		case kStato_Sregione               : [VSegDis2         setSelected:YES forSegment:3]; break;

  	    case kStato_SpostaDisegno          : [VBMoveDis        setState:1];  break;
                  //		case kStato_RuotaDisegno           : [VBRotDis         setState:1];  break;
                  //		case kStato_ScalaDisegno           : [VBScaDis         setState:1];  break;

  		case kStato_Seleziona              : [SVEdit1          setSelected:YES forSegment:0]; break;
  		case kStato_Match                  : [SVEdit1          setSelected:YES forSegment:2]; break;
  		case kStato_Info                   : [SVEdit1          setSelected:YES forSegment:3]; break;
  		case kStato_InfoSup                : [SVEdit1          setSelected:YES forSegment:4]; break;

  		case kStato_CancellaSelected       : [SVEdit2          setSelected:YES forSegment:4]; break;
  		case kStato_SpostaSelected         : [SVEdit2          setSelected:YES forSegment:0]; break;
  		case kStato_CopiaSelected          : [SVEdit2          setSelected:YES forSegment:1]; break;
  		case kStato_RuotaSelected          : [SVEdit2          setSelected:YES forSegment:2]; break;
  		case kStato_ScalaSelected          : [SVEdit2          setSelected:YES forSegment:3]; break;
  		case kStato_SpostaVertice 		   : [SVEdit3          setSelected:YES forSegment:0]; break;
  		case kStato_InserisciVertice       : [SVEdit3          setSelected:YES forSegment:1]; break;
  		case kStato_CancellaVertice        : [SVEdit3          setSelected:YES forSegment:2]; break;
  		case kStato_EditSpVt               : [SVEdit3          setSelected:YES forSegment:3]; break;


  				// Catasto
  		case kStato_TarquiniaFogliopt        : [BFoglio      setState:1];   break;


  		case kStato_InfoLeg                  : [VBInfoLeg      setState:1];   break;

  		case kStato_InfoIntersezione2Poligoni: [VBInfoInt2Polyg      setState:1];   break;


  	}

  		//////////////////////////////////////////////////////////


  	switch (com) {

  	}
  }
*)



procedure ridisegnaCoordinateMouse;
begin
 case  ProiezioneCorrente of
  1,3,5 : begin
            mainform.Info_XMouse.Text := FloatToStrF(xmouseProj, ffNumber, 12, 2);
            mainform.Info_YMouse.Text := FloatToStrF(ymouseProj, ffNumber, 12, 2);
          end;
  2,4 : begin
            mainform.Info_XMouse.Text := ingradi(xmouseProj);
            mainform.Info_YMouse.Text := ingradi(ymouseProj);
        end;

 end;


end;




procedure ridisegnaCoordinateMouse2; // Interfaccia
begin
  mainform.Info_XMouse.Text := IntToStr(xmouseI);
  mainform.Info_YMouse.Text := IntToStr(ymouseI);
end;


procedure ridisegnaNomiPiani;
var k : Integer;
    locdisv : TDisegnoV;
    locpia : TPiano;
begin
  Mainform.ListBoxPian.Clear;
  locdisV := ilProgetto.DisegnoVCorrente;
  if locdisV<>nil then
   begin
    for k:=0 to locdisV.ListaPiani.Count-1 do
     begin
      locpia := locdisV.ListaPiani.Items[k];
      Mainform.ListBoxPian.Items.Add(locpia.nomepiano);
     end;
    Mainform.ListBoxPian.ItemIndex:=locdisV.indPianocorrente;
   end;
end;

procedure ridisegnaNomiDis;
var k : Integer;
    locdisv : TDisegnoV;
    locdiV : TDisegnoV;
    nomeloc : String;
begin
  Mainform.ListBoxDis.Clear;
   for k:=0 to ilProgetto.ListaDisegniV.count-1 do
    begin
      locdisv := ilProgetto.ListaDisegniV.Items[k];
      nomeloc := locdisv.nomedisegno;
      nomeloc :=StringReplace(nomeloc, '.macmap', '',[rfReplaceAll, rfIgnoreCase]);
      Mainform.ListBoxDis.AddItem(nomeloc,nil);
    end;
   if ((ilProgetto.indDisVcorrente>=0) and (ilProgetto.indDisVcorrente< Mainform.ListBoxDis.Items.Count))
      then begin  Mainform.ListBoxDis.ItemIndex:=ilProgetto.indDisVcorrente;  end;
   ridisegnaNomiPiani;
end;

procedure ridisegnaNomiRas;
var k : Integer;
    locdisGR : TDisegnoGR;
begin
  Mainform.ListBoxRastGR.Clear;
   for k:=0 to ilProgetto.ListaDisegniGR.count-1 do
    begin
      locdisGR := ilProgetto.ListaDisegniGR.Items[k];
      Mainform.ListBoxRastGR.AddItem(locdisGR.Nome,nil);
    end;

   if ((ilProgetto.indDisGRcorrente>=0) and (ilProgetto.indDisGRcorrente< Mainform.ListBoxRastGR.Items.Count))
        then begin  Mainform.ListBoxRastGR.ItemIndex:=ilProgetto.indDisGRcorrente;  end;
   ridisegnaNomiSubras;
end;

procedure ridisegnaNomiSubras;
var k : Integer;
    locdisGR : TDisegnoGR;
    locdiR : TDisegnoR;
begin
  Mainform.ListBoxSubRastGR.Clear;
  if ilProgetto.GRCorrente=nil then exit;
   for k:=0 to ilProgetto.GRCorrente.listaDisegniR.count-1 do
    begin
      locdiR := ilProgetto.GRCorrente.listaDisegniR.Items[k];
      Mainform.ListBoxSubRastGR.AddItem(extractfilename(locdiR.NomefileRaster),nil);
    end;

  if ((ilProgetto.GRCorrente.indDisRCorrente>=0) and (ilProgetto.GRCorrente.indDisRCorrente< Mainform.ListBoxSubRastGR.Items.Count))
        then begin  Mainform.ListBoxSubRastGR.ItemIndex:=ilProgetto.GRCorrente.indDisRCorrente;  end;
end;


procedure caricaInterfacciaPersonalizzata;
var  btnAdded: TSpeedButton;
     labelAdded  : Tlabel;
     nomefile1 : String;
     F,G : TextFile;
     riga : String;
     contaLab : Integer;
     contaBut : Integer;
     rig2 : String;
     riga1,riga2 , ladirkey: String;
     nomeconfig1 : String;
     nomeconfig2 : String;
     kf : integer;

begin

 Mainform.But_makePartContratto.Visible := False;
 Mainform.But_T_Contratti.Visible := False;

 nomeconfig1 := 'ConfigPanel1.txt';
 nomeconfig2 := 'ConfigPanel2.txt';


 if fileexists('.\setup\attuale.txt') then
  begin
   assignFile(G,'.\setup\attuale.txt'); reset(G);
   if not(eof(G)) then readln(G,nomeconfig1);
   if not(eof(G)) then readln(G,nomeconfig2);
   closefile(G);
  end;

 contaLab := 0;
 contaBut := 0;

 for kf := 1 to 2 do
 begin
  if kf = 1 then nomefile1 :='.\setup\'+nomeconfig1;
  if kf = 2 then nomefile1 :='.\setup\'+nomeconfig2;

 if FileExists(nomefile1) then
  begin
   assignFile(F,nomefile1); reset(F);
   while not(Eof(F)) do begin
    readln(F,riga);

        if riga='#TITOLO' then
         begin
          while ((riga<>'#ENDTITOLO') and not(eof(F))) do
           begin
            readln(F,riga);
            if copy(riga,1,3) ='T= ' then begin rig2:= copy(riga,4,length(riga)); Mainform.Lac_titoloComune.Caption:=rig2;  end;
            if copy(riga,1,3) ='C= ' then
             begin
              rig2:= copy(riga,4,length(riga));
              CodiceCatastale:=rig2;
              if CodiceCatastale = 'E812' then ProiezioneCatastale:=1; // MaglianoSabina
              if CodiceCatastale = 'L192' then ProiezioneCatastale:=2; // Tolfa

             end;
           end;
         end;

        if riga='#DIRECTORY' then
         begin
            while ((riga<>'#ENDDIRECTORY') and not(eof(F))) do
             begin
              readln(F,riga);
              SpezzastringaCancelletto(riga,riga1,riga2);     ladirkey := riga1;
              SpezzastringaCancelletto(riga2,riga1,riga2);
              if ladirkey='MAINDIR'        then
               begin
                MaindirDati            :=riga1;
                if maindirdati='.' then
                 begin  MaindirDati            := ExtractFilePath(ParamStr(0));    end;
               end;
              if ladirkey='ANAGRAFE'       then NomefileAnagrafe       := MaindirDati +riga1;
              if ladirkey='ANAGRAFEINFO'   then NomefileAnagrafeInfo   := MaindirDati +riga1;
              if ladirkey='TARES'          then NomefileTares          := MaindirDati +riga1;
              if ladirkey='IMU'            then NomefileImu            := MaindirDati +riga1;
              if ladirkey='TERRITORIO'     then DirDatiFotoAeree       := MaindirDati +riga1;
              if ladirkey='QUNIONE'        then NomefileQUnione        := MaindirDati +riga1;
              if ladirkey='DIRCXF'         then DirCXFComune           := MaindirDati +riga1;
              if ladirkey='FABBRICATIDATI' then NomefileFabbricatidati := MaindirDati +riga1;
              if ladirkey='TERRENIDATI'    then NomefileTerrenidati    := MaindirDati +riga1;
              if ladirkey='TERRENIPROPRIETARI'     then NomefileProprietariTerra   := MaindirDati +riga1;
              if ladirkey='TERRENIPOSSESSI'        then NomefilePossessiTerreni    := MaindirDati +riga1;
              if ladirkey='FABBRICATIPROPRIETARI'  then NomefileProprietariEdifici := MaindirDati +riga1;
              if ladirkey='FABBRICATIPOSSESSI'     then NomefilePossessiEdifici    := MaindirDati +riga1;
              if ladirkey='STRADE'                 then NomefileStrade             := MaindirDati +riga1;
              if ladirkey='CIVICI'                 then NomefileCivici             := MaindirDati +riga1;
              if ladirkey='TOPONOMASTICA'          then NomefileToponomastica      := MaindirDati +riga1;
              if ladirkey='CONCESSIONIDISEGNI'     then dirDisegniConcessioni      := MaindirDati +riga1;
              if ladirkey='CONCESSIONISOGGETTI'    then
               begin
                 NomeFileSoggettiConcessioni:= MaindirDati +riga1;
//   showmessage(NomeFileSoggettiConcessioni);
               end;
             end;
         end;


        if riga='#LABEL' then
         begin
          inc(contaLab);
          labelAdded := TLabel.Create(Mainform);
          labelAdded.Name := 'labelAdded'+IntToStr(contaLab);
          case kf of
           1 : labelAdded.Parent := Mainform.Pan_Conf1;
           2 : labelAdded.Parent := Mainform.Pan_Conf2;
          end;
          labelAdded.Font.Color := clWhite;
          labelAdded.alignment := taCenter;
            while ((riga<>'#ENDLABEL') and not(eof(F))) do
             begin
              readln(F,riga);
              if copy(riga,1,3) ='x= ' then begin rig2:= copy(riga,4,length(riga)); labelAdded.Left:=strToInt(rig2);  end;
              if copy(riga,1,3) ='y= ' then begin rig2:= copy(riga,4,length(riga)); labelAdded.Top:=strToInt(rig2);  end;
              if copy(riga,1,3) ='s= ' then begin rig2:= copy(riga,4,length(riga)); labelAdded.Font.size:=strToInt(rig2);  end;
              if copy(riga,1,3) ='w= ' then begin rig2:= copy(riga,4,length(riga)); labelAdded.Width:=strToInt(rig2);  end;
              if copy(riga,1,3) ='T= ' then begin rig2:= copy(riga,4,length(riga)); labelAdded.Caption:=rig2;  end;
             end;
         end;

        if riga='#BUTTON' then
         begin
          inc(contaBut);
          btnAdded := TSpeedButton.Create(Mainform);
          IlProgetto.ListaBottoniAdded.add(btnAdded);
          btnAdded.Name := 'btnAdded'+IntToStr(contaBut);
          case kf of
           1 : btnAdded.Parent := Mainform.Pan_Conf1;
           2 : btnAdded.Parent := Mainform.Pan_Conf2;
          end;
          btnAdded.OnClick := Ilprogetto.btnAddedButtonClick;
          btnAdded.GroupIndex := 2000+contaBut;
          btnAdded.AllowAllUp := true;
          with btnAdded do
           begin
            while ((riga<>'#ENDBUTTON') and not(eof(F))) do
             begin
              readln(F,riga);
              if copy(riga,1,3) ='x= ' then begin rig2:= copy(riga,4,length(riga)); btnAdded.Left:=strToInt(rig2);  end;
              if copy(riga,1,3) ='y= ' then begin rig2:= copy(riga,4,length(riga)); btnAdded.Top:=strToInt(rig2);  end;
              if copy(riga,1,3) ='h= ' then begin rig2:= copy(riga,4,length(riga)); btnAdded.Height:=strToInt(rig2);  end;
              if copy(riga,1,3) ='w= ' then begin rig2:= copy(riga,4,length(riga)); btnAdded.Width:=strToInt(rig2);  end;
              if copy(riga,1,3) ='T= ' then begin rig2:= copy(riga,4,length(riga)); btnAdded.Caption:=rig2;  end;
              if copy(riga,1,3) ='M= ' then
                 begin rig2:= copy(riga,4,length(riga)); Ilprogetto.ListaMacro.add('#'+IntToStr(contaBut)+ rig2);  end;
             end;
           end;
         end;
        if riga='#MODULOTOLFA' then
         begin
          Mainform.Panel_tributi.Visible         := false;
          Mainform.Panel_Moreno.Visible          := true;
          Mainform.Panel_Moreno.Top              := Mainform.Panel_tributi.top;
          Mainform.But_makePartContratto.Visible := True;
          Mainform.But_T_Contratti.Visible       := True;
          Mainform.Bot_Rilievo.visible           := false;
          Mainform.Bot_stradaletxt.visible       := false;
         end;

   end;
   closefile(F);
  end;
 end;


  if FileExists(DirDatiFotoAeree+'LimitiTerritorio.txt') then
   begin
    assignFile(F,DirDatiFotoAeree+'LimitiTerritorio.txt'); reset(F);
     if (not(EOF(F))) then readln(F,LimTerx1);
     if (not(EOF(F))) then readln(F,LimTery1);
     if (not(EOF(F))) then readln(F,LimTerx2);
     if (not(EOF(F))) then readln(F,LimTery2);
     if (not(EOF(F))) then readln(F,scalater);
     if (not(EOF(F))) then readln(F,dimPicTer);
     if (not(EOF(F))) then readln(F,dimPicTer);
     if (not(EOF(F))) then readln(F,MaxKool);
    closefile(F);
   end;

end;


procedure ridisegnaInterfaccia;
var menj : TMenuItem;
begin

   ridisegnaNomiDis;
   ridisegnaNomiRas;
   Mainform.Tumbnail.Bitmap.Clear(ColoreSfondo);

   with mainform do
    begin
    // vettoriale
     Gau_SupDisV.Position     := IlProgetto.DisegnoVCorrente.alfasuperfici;
     Gau_LineDisV.Position    := IlProgetto.DisegnoVCorrente.alfalinee;
     Bot_VisibileDisV.Down    := Not(IlProgetto.DisegnoVCorrente.b_visibile);
     Bot_DisEditabile.Down    := Not(IlProgetto.DisegnoVCorrente.b_editabile);
     Bot_DisSnappabile.Down   := Not(IlProgetto.DisegnoVCorrente.b_snappabile);

     Gau_SupPiano.Position    := IlProgetto.PianoCorrente.alfasuperfici;
     Gau_LinePiano.Position   := IlProgetto.PianoCorrente.alfalinee;
     Bot_VisibilePiano.Down   := Not(IlProgetto.PianoCorrente.b_visibile);
     Bot_VisibilePiano.Down   := Not(IlProgetto.PianoCorrente.b_visibile);
     Bot_PianoSnappabile.Down := Not(IlProgetto.PianoCorrente.b_snappabile);
     Bot_PianoEditabile.Down  := Not(IlProgetto.PianoCorrente.b_editabile);

    // Raster
     if ilProgetto.GRCorrente<>nil then
      begin
       Gau_RasterGR.Position := ilProgetto.GRCorrente.alpha;
       if ilProgetto.GRCorrente.indDisRCorrente>=0 then begin
         ilProgetto.RCorrente  := ilProgetto.GRCorrente.listaDisegniR[ilProgetto.GRCorrente.indDisRCorrente];
         ilProgetto.RCorrente.DisegnaTumbnail;
         Lab_dimxR.Caption     := 'w : '+intToStr(ilProgetto.RCorrente.dimx);
         Lab_dimyR.Caption     := 'h : '+intToStr(ilProgetto.RCorrente.dimy);
       end;
       Gau_ScalaGR.min       := ilProgetto.GRCorrente.minGauSca;
       Gau_ScalaGR.max       := ilProgetto.GRCorrente.maxGauSca;
       Gau_RotGR.min         := ilProgetto.GRCorrente.minGauRot;
       Gau_RotGR.max         := ilProgetto.GRCorrente.maxGauRot;
       Gau_ScalaGR.Position  := round(ilProgetto.GRCorrente.scalaGR*1000);
       Gau_RotGR.Position    := round(ilProgetto.GRCorrente.angoloGR*1000);

      end;
    end;
{
    menj :=  FindItemByName(MainForm.MainMenu1.Items, 'SnapFine1' );
      if menj<>nil then menj.Checked := b_SnapFine;
    menj :=  FindItemByName(MainForm.MainMenu1.Items, 'SnapVicino1' );
      if menj<>nil then menj.Checked := b_SnapVicino;
    menj :=  FindItemByName(MainForm.MainMenu1.Items, 'SnapOrto1' );
      if menj<>nil then menj.Checked := b_SnapOrto;
    menj :=  FindItemByName(MainForm.MainMenu1.Items, 'SnaportoUltimoseg1' );
      if menj<>nil then menj.Checked := b_SnapOrtoSeg;
    menj :=  FindItemByName(MainForm.MainMenu1.Items, 'SnapGriglia1' );
      if menj<>nil then menj.Checked := b_SnapGriglia;


}

  Mainform.Bot_snapFine.Down    := b_SnapFine;
  Mainform.Bot_snapVicino.Down  := b_SnapVicino;
  Mainform.Bot_snapOrto.Down    := b_SnapOrto;
  Mainform.Bot_snapOrtoSeg.Down := b_SnapOrtoSeg;
  Mainform.Bot_snapGriglia.Down := b_SnapGriglia;

{

    menj :=  FindItemByName(MainForm.MainMenu1.Items, 'UTMWgs841' ); if menj<>nil then menj.Checked := false;
    menj :=  FindItemByName(MainForm.MainMenu1.Items, 'GEOWgs841' ); if menj<>nil then menj.Checked := false;
    menj :=  FindItemByName(MainForm.MainMenu1.Items, 'UTM501' ); if menj<>nil then menj.Checked := false;
    menj :=  FindItemByName(MainForm.MainMenu1.Items, 'Geo501' ); if menj<>nil then menj.Checked := false;
    menj :=  FindItemByName(MainForm.MainMenu1.Items, 'CassiniSoldner1' ); if menj<>nil then menj.Checked := false;

}
    case ProiezioneCorrente of
     1 : begin Mainform.Bot_Coord1.Down:=true;
//               menj :=  FindItemByName(MainForm.MainMenu1.Items, 'UTMWgs841' );               if menj<>nil then menj.Checked := true;
         end;
     2 : begin Mainform.Bot_Coord2.Down:=true;
//               menj :=  FindItemByName(MainForm.MainMenu1.Items, 'GEOWgs841' );               if menj<>nil then menj.Checked := true;
         end;
     3 : begin Mainform.Bot_Coord3.Down:=true;
//               menj :=  FindItemByName(MainForm.MainMenu1.Items, 'UTM501' );               if menj<>nil then menj.Checked := true;
         end;
     4 : begin Mainform.Bot_Coord4.Down:=true;
//               menj :=  FindItemByName(MainForm.MainMenu1.Items, 'Geo501' );               if menj<>nil then menj.Checked := true;
         end;
     5 : begin Mainform.Bot_Coord5.Down:=true;
//               menj :=  FindItemByName(MainForm.MainMenu1.Items, 'CassiniSoldner1' );               if menj<>nil then menj.Checked := true;
         end;
    end;

 if IlProgetto.pianocorrente<>nil then begin
  Mainform.Panel_ColorPiano.Color := RGB(IlProgetto.pianocorrente._rosso, IlProgetto.pianocorrente._verde, IlProgetto.pianocorrente._blu );
 end;

 // risistemare le 4 barre
  if IlProgetto.DisegnoVCorrente<>nil then begin
    Mainform.Gau_ScaV.Min      := IlProgetto.DisegnoVCorrente.minGauSca;
    Mainform.Gau_ScaV.Max      := IlProgetto.DisegnoVCorrente.maxGauSca;
    Mainform.Gau_ScaV.Position := IlProgetto.DisegnoVCorrente.laPosSca;

    Mainform.Gau_RotV.Min      := IlProgetto.DisegnoVCorrente.minGauRot;
    Mainform.Gau_RotV.Max      := IlProgetto.DisegnoVCorrente.maxGauRot;
    Mainform.Gau_RotV.Position := IlProgetto.DisegnoVCorrente.laPosRot;

    Mainform.Gau_SpoXV.Min      := IlProgetto.DisegnoVCorrente.minGauSpoX;
    Mainform.Gau_SpoXV.Max      := IlProgetto.DisegnoVCorrente.maxGauSpoX;
    Mainform.Gau_SpoXV.Position := IlProgetto.DisegnoVCorrente.laPosSpoX;

    Mainform.Gau_SpoYV.Min      := IlProgetto.DisegnoVCorrente.minGauSpoY;
    Mainform.Gau_SpoYV.Max      := IlProgetto.DisegnoVCorrente.maxGauSpoY;
    Mainform.Gau_SpoYV.Position := IlProgetto.DisegnoVCorrente.laPosSpoY;
  end;

  // stato dei bottoni;
  Mainform.Bot_QUnione.Down := IlCatastoV.vedoQU;



  if Not(faseAperturaProgramma) then Mainform.Edit_Fittizio.SetFocus;
   bottonisuegiu;
end;

procedure  bottonisuegiu;
begin
  if IlProgetto.DisegnoVCorrente<>nil then begin
    Mainform.Gau_ScaV.enabled:=true;    Mainform.Gau_RotV.enabled:=true;
    Mainform.Gau_SpoXV.enabled:=true;   Mainform.Gau_SpoYV.enabled:=true;
    if IlProgetto.DisegnoVCorrente.visibile then Mainform.Bot_VisibileDisV.Down := true
                                            else Mainform.Bot_VisibileDisV.Down := false;

  end
   else
  begin
    Mainform.Gau_ScaV.enabled:=false;   Mainform.Gau_RotV.enabled:=false;
    Mainform.Gau_SpoXV.enabled:=false;  Mainform.Gau_SpoYV.enabled:=false;
  end;



  if IlProgetto.GRCorrente<>nil then begin
    if IlProgetto.GRCorrente.visibile then Mainform.But_vedoGR.Down := true
                                      else  Mainform.But_vedoGR.Down := false;
  end
   else
  begin
//    Mainform.But_TogliRaster.Enabled:=false;
  end;

  Mainform.Bot_SpostaRaster.Down    := false;
  Mainform.Bot_SpstaRasterDlg.Down  := false;
  Mainform.Bot_RighelloRaster.Down  := false;
  Mainform.Bot_Raster2Segmenti.Down := false;
  Mainform.Bot_CropRaster.Down      := false;
  Mainform.Bot_RasterCrocicchi.Down := false;
  Mainform.Bot_FixCentroCalRas.Down := false;
  // vettoriali
  Mainform.Bot_CPunto.Down          := false;
  Mainform.Bot_CPLinea.Down         := false;
  Mainform.Bot_CPoligono.Down       := false;
  Mainform.Bot_CRegione.Down        := false;
  Mainform.Bot_CCerchio.Down        := false;
  Mainform.Bot_rettangolo.Down      := false;
  Mainform.Bot_CCivico.Down         := false;
  Mainform.Bot_Seleziona.Down       := false;
  Mainform.Bot_Testo.Down           := false;
  Mainform.Bot_Simbolo.Down         := false;
  Mainform.Bot_cancsel.Down         := false;
  Mainform.Bot_informsel.Down       := false;
  Mainform.But_Match.Down           := false;
  Mainform.But_SpostaSelected.Down  := false;
  Mainform.But_CopiaSelected.Down   := false;
  Mainform.But_RuotaSelected.Down   := false;
  Mainform.But_ScalaSelected.Down   := false;
  Mainform.But_editTesto.Down       := false;
  Mainform.Bot_SpostaVertice.Down   := false;
  Mainform.Bot_InsVert.Down         := false;
  Mainform.Bot_cancellaVt.Down      := false;
  Mainform.But_spostacivico.Down    := false;
  Mainform.But_FixCentroVet.Down    := false;

  case comando of
    kStato_spostaRaster_uno      : Mainform.Bot_SpostaRaster.Down    := true;
    kStato_spostaRaster2pt_tutti : Mainform.Bot_SpstaRasterDlg.Down  := true;
    kStato_scalarighello         : Mainform.Bot_RighelloRaster.Down  := true;
    kStato_rotoscalaraster       : Mainform.Bot_Raster2Segmenti.Down := true;
    kStato_CropRasterRettangolo  : Mainform.Bot_CropRaster.Down      := true;
    kStato_Calibraraster         : Mainform.Bot_RasterCrocicchi.Down := true;
    kStato_FixCentroRot          : Mainform.Bot_FixCentroCalRas.Down := true;
                // vettoriali
    kStato_Punto                 : Mainform.Bot_CPunto.Down          := true;
    kStato_Polilinea             : Mainform.Bot_CPLinea.Down         := true;
    kStato_Poligono              : Mainform.Bot_CPoligono.Down       := true;
    kStato_Regione               : Mainform.Bot_CRegione.Down        := true;
    kStato_Cerchio               : Mainform.Bot_CCerchio.Down        := true;
    kStato_Rettangolo            : Mainform.Bot_rettangolo.Down      := true;
    kStato_Civico                : Mainform.Bot_CCivico.Down         := true;
    kStato_Seleziona             : Mainform.Bot_Seleziona.Down       := true;

    kStato_Info                  : Mainform.Bot_informsel.Down       := true;
    kStato_Match                 : Mainform.But_Match.Down           := true;
    kStato_SpostaSelected        : Mainform.But_SpostaSelected.Down  := true;
    kStato_CopiaSelected         : Mainform.But_CopiaSelected.Down   := true;
    kStato_RuotaSelected         : Mainform.But_RuotaSelected.Down   := true;
    kStato_ScalaSelected         : Mainform.But_ScalaSelected.Down   := true;
    kstato_editText              : Mainform.But_editTesto.Down       := true;

    kStato_SpostaVertice         : Mainform.Bot_SpostaVertice.Down   := true;
    kStato_InserisciVertice      : Mainform.Bot_InsVert.Down         := true;
    kStato_CancellaVertice       : Mainform.Bot_cancellaVt.Down      := true;
    kStato_SpostaPosCivico       : Mainform.But_spostacivico.Down    := true;

    kStato_FixCentroRotVettoriale: Mainform.But_FixCentroVet.Down    := true;

  end;


end;


procedure sw_snapFine;
begin
 b_SnapFine := not(b_SnapFine);
 ridisegnaInterfaccia;
end;

procedure sw_snapVicino;
begin
 b_SnapVicino:=not(b_SnapVicino);
 ridisegnaInterfaccia;
end;

procedure sw_snapOrto;
begin
 b_SnapOrto  := not(b_SnapOrto);
 ridisegnaInterfaccia;
end;

procedure sw_snaportoSeg;
begin
 b_SnapOrtoSeg := not(b_SnapOrtoSeg);
 ridisegnaInterfaccia;
end;

procedure sw_snapGriglia;
begin
 b_SnapGriglia := not(b_SnapGriglia);
 ridisegnaInterfaccia;
end;

procedure sw_snapAllOff;
begin
  b_SnapFine    := false;
  b_SnapVicino  := false;
  b_SnapOrto    := false;
  b_SnapOrtoSeg := false;
  b_SnapGriglia := false;
 ridisegnaInterfaccia;
end;


procedure CambiaProiezione(modo : Integer);
begin
 // 1 : UTM WGS 84
 // 2 : Geo WGS 84
 // 3 : UTM Ita
 // 4 : Geo Ita
 // 5 : Cassini Soldner
  ProiezioneCorrente    :=modo;
  ridisegnaCoordinateMouse;
  ridisegnaInterfaccia;
end;


procedure ricentraScaGR;
var ilmin :  integer;
    delta : Integer;
    delta2 : Integer;
begin
 with mainform.Gau_ScalaGR do
  begin
   delta := max-min;
   delta2 := (delta div 2);  if delta2<1 then delta2 := 2;
   ilmin := Position-delta2;
   if ilmin<0  then begin delta2:=delta2+ilmin; ilmin:=0; end;
   if ilmin<10 then begin delta2:=delta2-(10-ilmin); ilmin :=10; end;
   if delta2<10 then delta2 := 10;
   min := ilmin;
   max := position+delta2;
   ilProgetto.GRCorrente.minGauSca:= min;
   ilProgetto.GRCorrente.maxGauSca:= max;
  end;
end;

procedure ricentraRotGR;
var ilmin :  integer;
    delta : Integer;
    delta2 : Integer;
begin
 with mainform.Gau_RotGR do
  begin
   delta := max-min;
   delta2 := (delta div 2);  if delta2<1 then delta2 := 2;
   ilmin := Position-delta2;
   min := ilmin;
   max := position+delta2;
   ilProgetto.GRCorrente.minGauRot := min;
   ilProgetto.GRCorrente.maxGauRot := max;
  end;
end;

procedure RotGR_update;
begin
 with mainform.Gau_ScalaGR do
  begin
   min := 10;
   max := 2000;
   position:=1000;
  end;
end;

procedure ricentraScaV;
var ilmin :  integer;
    delta : Integer;
    delta2 : Integer;
begin
 with mainform.Gau_ScaV do
  begin
   delta := max-min;
   delta2 := (delta div 2);  if delta2<1 then delta2 := 2;
   ilmin := Position-delta2;
   if ilmin<0  then begin delta2:=delta2+ilmin; ilmin:=0; end;
   if ilmin<10 then begin delta2:=delta2-(10-ilmin); ilmin :=10; end;
   if delta2<10 then delta2 := 10;
   min := ilmin;
   max := position+delta2;
   if Ilprogetto.DisegnoVCorrente<>nil then
    begin
     Ilprogetto.DisegnoVCorrente.minGauSca:=min;
     Ilprogetto.DisegnoVCorrente.maxGauSca:=max;
     Ilprogetto.DisegnoVCorrente.laPosSca:=position;
    end;
  end;
end;

procedure ricentraRotV;
var ilmin :  integer;
    delta : Integer;
    delta2 : Integer;
begin
 with mainform.Gau_RotV do
  begin
   delta := max-min;
   delta2 := (delta div 2);  if delta2<1 then delta2 := 2;
   ilmin := Position-delta2;
   min := ilmin;
   max := position+delta2;
   if Ilprogetto.DisegnoVCorrente<>nil then
    begin
     Ilprogetto.DisegnoVCorrente.minGauRot := min;
     Ilprogetto.DisegnoVCorrente.maxGauRot := max;
     Ilprogetto.DisegnoVCorrente.laPosRot  := position;
    end;
  end;
end;

procedure ricentraSpoXV;
var ilmin :  integer;
    delta : Integer;
    delta2 : Integer;
begin
 with mainform.Gau_SpoXV do
  begin
   delta := max-min;
   delta2 := (delta div 2);  if delta2<1 then delta2 := 2;
   ilmin := Position-delta2;
   min := ilmin;
   max := position+delta2;
   if Ilprogetto.DisegnoVCorrente<>nil then
    begin
     Ilprogetto.DisegnoVCorrente.minGauSpoX := min;
     Ilprogetto.DisegnoVCorrente.maxGauSpoX := max;
     Ilprogetto.DisegnoVCorrente.laPosSpoX  := position;
    end;

  end;
end;

procedure ricentraSpoYV;
var ilmin :  integer;
    delta : Integer;
    delta2 : Integer;
begin
 with mainform.Gau_SpoYV do
  begin
   delta := max-min;
   delta2 := (delta div 2);  if delta2<1 then delta2 := 2;
   ilmin := Position-delta2;
   min := ilmin;
   max := position+delta2;
   if Ilprogetto.DisegnoVCorrente<>nil then
    begin
     Ilprogetto.DisegnoVCorrente.minGauSpoY := min;
     Ilprogetto.DisegnoVCorrente.maxGauSpoY := max;
     Ilprogetto.DisegnoVCorrente.laPosSpoY  := position;
    end;
  end;
end;

procedure RotV_update;
begin
 with mainform.Gau_RotV do
  begin
   min := 0;
   max := 2000;
   position:=1000;
  end;
end;




procedure setfasecomando(newfase:Integer);
begin
	FaseComando:=newfase;
	AggiornaInterfaceComandoAzione(comando,fasecomando);
end;

procedure setfasecomandopiu1;
begin
	inc(FaseComando);	AggiornaInterfaceComandoAzione(comando,fasecomando);
end;


procedure Interf_ToltoDisegnoR(nomedir : String);
var k : Integer;
    rigaP,riga1,riga2 : String;
    rigCom, nrbutstr : String;
    locbtnAdded: TSpeedButton;
begin

// showmessage(nomedir);
 for k :=0 to Ilprogetto.ListaMacro.count-1 do
  begin
   rigaP := Ilprogetto.ListaMacro[k];
   SpezzastringaCancelletto(rigaP, riga1, riga2);   rigaP := riga2;
   nrbutstr := riga1;
   SpezzastringaCancelletto(rigaP, riga1, riga2);   rigaP := riga2;
   rigCom := riga1;
   SpezzastringaCancelletto(rigaP, riga1, riga2);   rigaP := riga2;
   SpezzastringaCancelletto(rigaP, riga1, riga2);   rigaP := riga2;
   if ((rigCom='R1') or (rigCom='R2'))  then
    begin
//     if rigCom='R2' then  showmessage(riga1);
     if riga1=nomedir then
      begin
       locbtnAdded := IlProgetto.ListaBottoniAdded.items[strtoInt(nrbutstr)-1];
       locbtnAdded.Down:=false;
      end;
    end;
  end;
end;


procedure Interf_ToltoDisegnoV(nomedir : String);
var k : Integer;
    rigaP,riga1,riga2 : String;
    rigCom, nrbutstr : String;
    locbtnAdded: TSpeedButton;
begin
 for k :=0 to Ilprogetto.ListaMacro.count-1 do
  begin
   rigaP := Ilprogetto.ListaMacro[k];
   SpezzastringaCancelletto(rigaP, riga1, riga2);   rigaP := riga2;
   nrbutstr := riga1;
   SpezzastringaCancelletto(rigaP, riga1, riga2);   rigaP := riga2;
   rigCom := riga1;
   SpezzastringaCancelletto(rigaP, riga1, riga2);   rigaP := riga2;
   SpezzastringaCancelletto(rigaP, riga1, riga2);   rigaP := riga2;
   if (rigCom='V1')   then
    begin
     if riga1=nomedir then
      begin
       locbtnAdded := IlProgetto.ListaBottoniAdded.items[strtoInt(nrbutstr)-1];
       locbtnAdded.Down:=false;
      end;
    end;
  end;
end;


procedure ImpostaComuneSetUp(modo : Integer);
var G : TextFile;
begin
   assignFile(G,'.\setup\attuale.txt'); rewrite(G);
   case modo of
    1 : begin  writeln(G,'ConfigPanel1_Magliano.txt'); writeln(G,'ConfigPanel2_Magliano.txt');  end;
    2 : begin  writeln(G,'ConfigPanel1_Tolfa.txt');    writeln(G,'ConfigPanel2_Tolfa.txt');     end;
   end;
   closefile(G);
end;


procedure updateNumSelezionati;
begin
 Mainform.Lab_numsel.Caption := IntTostr(Ilprogetto.ListaSelezionati.count);
end;

end.
