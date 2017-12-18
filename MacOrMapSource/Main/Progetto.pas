unit Progetto;

interface

uses  Windows, GR32,  GR32_Image, GR32_Layers, System.classes , sysutils, FMX.Dialogs , varbase,
     DisegnoV,  DisegnoGR, DisegnoR, Piano  ,UITypes , Graphics ,CatastoV, ImmobiliDati
;

type
 TProgetto = class
   ListaDisegniV    : TList;
   ListaDisegniGR   : TList;
   ListaSelezionati : TList;
   ListaInfo        : TList;
   indToshow        : Integer;

   ListaBottoniAdded : TList;

   ListaEditvt      : TList;
   ListaMacro       : TStringList;
   TerrenoGR        : TDisegnoGR;

   LelisteDefSimboli : Tlist;

//   VCorrente : TDisegnoV;
   GRCorrente : TDisegnoGR;
   RCorrente : TDisegnoR;
   PianoCorrente : TPiano;

   indDisVcorrente  :  integer;
   indDisGRcorrente :  integer;

	 d_xclickdown ,  d_yclickdown : Real;
	 i_xmouselast ,  i_ymouselast : Integer;
	 d_x5coord,  d_y5coord, d_x6coord,  d_y6coord, d_x7coord,  d_y7coord, d_x8coord,  d_y8coord : Real;
	 b_limitisetted : Boolean;

	 l_xprezoomw , l_yprezoomw : Integer;
   f_sprezoomw : Real;
	 FaseRegione : Integer;
	 incomandotrasparente : Boolean;
	 LastComandotrasparente : Boolean;
	 LastFaseComandotrasparente: Boolean;
	 x1spazialevirt , y1spazialevirt : Real;
	 modoaperturavet : Integer;    // se 1 distingue catasto-utm
	 pageRect : TRect;
	 _inrectPan : TRect;
	 rettangoloStampaSingolo : Integer;
	 NumPaginaInStampa : Integer;

   vedoterreno : Boolean;
   vedogriglia : Boolean;



   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   Disegna(HHDC : TImage32;instampa : Boolean);

   procedure   CaricaTerritorio;

   procedure   btnAddedButtonClick(Sender: TObject);
   procedure   MouseDown(HHDC : TImage32; Button: Integer; Sh: TShiftState; x1,y1 : Integer);
   procedure   LeftMouse(HHDC : TImage32; Sh: TShiftState; x,y : Integer);
   procedure   MiddleMouseDown(HHDC : TImage32; Sh: TShiftState; x1,y1 : Integer);
   procedure   MiddleMouseUp(HHDC : TImage32; Sh: TShiftState; x1,y1 : Integer);
   procedure   RigthMouse(HHDC : TImage32; Sh: TShiftState; x1,y1 : Integer);

   procedure   caricadefsimboli;

   procedure   IniziaComando (newcomando :  Tipocomando);
   function    DisegnoVCorrente: TDisegnoV;
   function    DisegnoRCorrente: TDisegnoR;
   function    PianoVCorrente: TPiano;

   procedure   cambiadisegnocorrente(indice : Integer);
   procedure   cambiaPianocorrente(indice : Integer);

// comandi di vista
   procedure   Vista_Zoompiu;
   procedure   Vista_Zoommeno;
   procedure   Vista_ZoomTutto;
   procedure   Vista_ZoomTuttosePrimo;
   procedure   Vista_ZoomUltima;
   procedure   Vista_ZoomCentro;
   procedure   ZoomAllRaster;
   procedure   ZoomLocRaster;
   procedure   ZoomGRCorrente;
   procedure   ZoomRCorrente;
   procedure   ZoomDisegno;
   procedure   ZoomPianoCorrente;
   procedure   ZoomAll;
   procedure   ZoomC              (newx, newy : Real);

   procedure   DisegnaVirtuale                   ( x1, y1, x2, y2 : Integer);
   procedure   DisegnaCerchioVirtuale            (dc:hdc; x1, y1, x2, y2 : Integer);
   procedure   DisegnaquadroVirtuale             ( x1, y1, x2, y2 : Integer);
   procedure   DisegnaPan                        ( dx, dy : real);
   Function    SnappaGriglia                     ( xc, yc : real): Boolean;
   procedure   DisSpostaVirtuale                 (dc:hdc; x1, y1 ,xm, ym : real);
   procedure   DisCopiaVirtuale                  (dc:hdc; x1, y1 ,xm, ym : real);
   procedure   DisRuotaVirtuale                  (dc:hdc; x1, y1 ,xm, ym : real);
   procedure   DisScalaVirtuale                  (dc:hdc; x1, y1 ,xm, ym : real);
   procedure   DisSpostaDisegno                  ( x1, y1 ,xm, ym : real);
   procedure   DisRuotaDisegno                   ( xc, yc ,xm, ym : real);
   procedure   DisScalaDisegno                   ( xc, yc ,xm, ym : real);
   procedure   DisSimbolovirtualeang             ( angrot : Real);
   procedure   DisSimbolovirtualesca             ( parscal : Real);
   procedure   DisSimboloVirtuale                (dc:hdc; fase:integer; xc, yc ,sc, ang : real);
   procedure   DisTestoVirtuale                  (dc:hdc; fase:integer; xc, yc ,sc, ang : real);
   procedure   DisDoppiaVirtual                  (dc:hdc; modo : Integer;  xm, ym: Integer);
   procedure   DisDoppiaVirtualCivico            (dc:hdc;modo : Integer;  xm, ym: Integer);


   procedure   NuovoDisegno;

   procedure   setcomando(com : TipoComando; fase : Integer);
   procedure   mouseSnappe;
   procedure   mouseComandiDisegno     (HHDC : TImage32);
   procedure   mouseComandiRaster      (HHDC : TImage32);
   procedure   mouseComandiSelezionanti(HHDC : TImage32);
   procedure   mouseComandiVertici     (HHDC : TImage32);
   procedure   mouseComandiEditDisegno (HHDC : TImage32);


   procedure   disegnaselezionati(HHDC : TImage32);
   procedure   disegnaInformati  (HHDC : TImage32);
   procedure   disegnaedifterselezionati(HHDC : TImage32);


   procedure   MouseMove(HHDC : TImage32; Sh: TShiftState; X,Y : Integer);

    // raster
   procedure   TogliGRCorrente;
   procedure   CambiaGRcorrente(indice:Integer);

   procedure   updateScalaGR(sca : real);
   procedure   updateRotGR  (rot : real);
   procedure   updateRasExParam;
   procedure   RasExParamSca2mezzi(modo : Integer);
   procedure   RasExParamRot2mezzi(modo : Integer);

   procedure   SalvaInfoCorrenteGR;
   procedure   SalvaInfoTuttiGR;
   procedure   SalvaImmobiliDati;


   // momentanee
   procedure   UpdateTerritorio;
   procedure   eseguimacro(riga : String);

   // vector disegno edit
   procedure   VectParamSca2mezzi(modo : Integer);
   procedure   VectParamRot2mezzi(modo : Integer);
   procedure   VectParamSpoX2mezzi(modo : Integer);
   procedure   VectParamSpoY2mezzi(modo : Integer);
   procedure   updateScalaV(sca : Integer);
   procedure   updateDisegnoVRot(newrot : Integer);
   procedure   updateDisegnoVSpoX(newx : Integer);
   procedure   updateDisegnoVSpoY(newy : Integer);

   procedure   PenDownDiscorrente;

   // TRIBUTI

   procedure   OpenInfoTributiAnagrafe;
   procedure   OpenAnagrafe;
   procedure   deseleziona;
   procedure   cancellatuttiSelezionati;

   procedure   OpenConcessioni;

   procedure   CreareDisegnoStradeDaAnagrafe;
   procedure   RasterGrUpDownLista(modo,indice : Integer);
   procedure   VectorGrUpDownLista(modo,indice : Integer);

   // extra
   procedure   Spessore2AiPiani;
   procedure   mettiCiviciAnagrafe;
   procedure   mettiCiviciCatasto;
   procedure   FaiDisegnoNomiStrade;

   procedure   civiciNonAssociati;
   procedure   civiciSnc;

   procedure   Stampa(nomefile : String);

   procedure   StampaRilievo(nomefile : String);
   procedure   impostaTuttiCiviciAlti(newH : Real);
   procedure   impostaAltezzaNomiStrade(newH : Real);
   procedure   ImpostaalfaCatasto(newalfa : integer);

   procedure   ImpostaGrigioCivici(modo : Integer);
   procedure   mettielencociviciSchermo(LaListaCiviciFoglio : TList);
   procedure   riordinaciviciinLista(var LaListaCiviciFoglio: TList);
   procedure   famigliedeiCivici(LaListaCiviciFoglio: TList;var LaListaAnagrafeFoglio: TList);
   procedure   stradeschermata(var Listastrade: TList);
   procedure   Anagrafesconosciuta(LaListaStradeSchermata : TList ; var LaListaAnagrafeSconosciuti : TList);

   // concessioni
   procedure   apriDisegnoConcessioni(modo : Integer; param : String; nomeaz:string);

   procedure   selezionaTerFabSoggetto(modo : Integer; idsog : String);

   procedure   TuttidisegniConcessioni;

   procedure   inizializzaVistaDefStampa(xstr,ystr,scastr , dpistr: String);

   procedure   prestamparilievo;
   procedure   polytoPoligonoDisegno;
   procedure   eliminaPianiOff;
   procedure   eliminaPianiON;
   procedure   FondiTuttoPrimoPiano;
   procedure   Consessioniselezionati;

 end;

 var ilProgetto : TProgetto;

implementation

   uses main, interfaccia, uviste, polylinea, Civico, Testo,
     Dlg_Spostaterritorio, uraster,uVector, Dlg_Righello,Dlg_Crocicchi
     , Vcl.StdCtrls ,funzioni, buttons , anagrafe, vettoriale
      , dlg_Fabbricato, dlg_FabbricatoSingolo  , dlg_Terreno,costanti ,vertice ,dlg_Testo ,ListaDefSimboli ,Dlg_Simbolo
      ,defsimbolo , Famiglia , Punto ,Dlg_TerrenoSingolo  , FabCatDati ,Dlg_Civico , Dlg_EditTesto, Residente
      ,Dlg_TestCivicoStrade ,LeConcessioni , possesso,tercatdati , ConcessioniV , Dlg_dist
     ;


Constructor TProgetto.Create;
var locDisegnoV : TDisegnoV;
begin
 ListaDisegniV    := TList.Create;
 ListaDisegniGR   := TList.Create;
 ListaSelezionati := TList.Create;
 ListaInfo        := TList.Create;
 ListaEditvt      := TList.Create;
 ListaMacro       := TStringList.Create;
 GliImmobiliDati  := TImmobiliDati.Create;    // in unit Immobilidati

 ListaBottoniAdded:= TList.Create;

 IlCatastoV       := TCatastoV.Create;
 LeConcessioniV   := TConcessioniV.create;
 LaAnagrafe       := TAnagrafe.Create;   // in Unit Anagrafe


 vedoterreno      := false;

 LelisteDefSimboli := TList.Create;
  caricadefsimboli;


 locDisegnoV      := TDisegnoV.create;

 ListaDisegniV.Add(locDisegnoV);
// VCorrente        := locDisegnoV;
 Pianocorrente    := locDisegnoV.ListaPiani.Items[locDisegnoV.indPianocorrente];

 indDisVcorrente :=0;
 indDisGRcorrente :=-1;
 pageRect   := TRect.Empty;
 _inrectPan := TRect.Empty;

end;

procedure   TProgetto.CaricaTerritorio;
begin
 if DirectoryExists(DirDatiFotoAeree) then
  begin
   ApriTerritorioKool(DirDatiFotoAeree);
  end;
end;

procedure  TProgetto.eseguimacro(riga : String);
var    riga1,riga2 : String;
begin


 SpezzastringaCancelletto(riga, riga1, riga2);
 if riga1='R1' then
  begin
   riga := riga2;
   SpezzastringaCancelletto(riga, riga1, riga2);
    riga := riga2;
   SpezzastringaCancelletto(riga, riga1, riga2);
   ApriImmagineDaBottone(maindirdati+riga1);
//   IlProgetto.ZoomGRCorrente;
   Ridisegna;
  end;

 if riga1='R2' then
  begin
   riga := riga2;
   SpezzastringaCancelletto(riga, riga1, riga2);
    riga := riga2;
   SpezzastringaCancelletto(riga, riga1, riga2);
   ApriImmagineKool(maindirdati+riga1);
//   IlProgetto.ZoomGRCorrente;
   Ridisegna;
  end;

 if riga1='V1' then
  begin
   riga := riga2;
   SpezzastringaCancelletto(riga, riga1, riga2);
    riga := riga2;
   SpezzastringaCancelletto(riga, riga1, riga2);
   ApriDisegnoDaBottone (maindirdati+riga1);
   Ridisegna;
  end;

 if riga1='V3' then
  begin
   Ilprogetto.OpenConcessioni;
   Ilprogetto.TuttidisegniConcessioni;
  end;

 if riga1='MA' then
  begin
   prestamparilievo;
  end;


//  C:\Users\developer\Desktop\ImmaginiComune\
end;

procedure TProgetto.btnAddedButtonClick(Sender: TObject);
var partenome : String;
    codbut    : String;
    k : Integer;
    riga1,riga2 : String;
begin
 if Sender is TSpeedButton then
  begin
   partenome := copy(TSpeedButton(Sender).Name,1,8);
   if partenome = 'btnAdded' then
    begin
     codbut := copy(TButton(Sender).Name,9,length(TButton(Sender).Name));
     for k:= 0 to ListaMacro.Count-1 do
      begin
       SpezzastringaCancelletto(ListaMacro.Strings[k], riga1, riga2);
       if riga1=codbut then begin eseguimacro(riga2); end;
      end;
    end;
  end;
end;


procedure TProgetto.UpdateTerritorio;
var  locdisR : TDisegnoR;
     k : integer;
     parscalkool : real;
begin

 if TerrenoGR = nil then exit;

  parscalkool := 0.4399;
  parscalkool := 0.441798;


//  Mainform.Label10.Caption:=FloatToStr(parscalkool);
//  Mainform.Label11.Caption:=FloatToStr(scalaVista);

 if (scalaVista<=(parscalkool*1.0)) then TerrenoGR.Livellokool:=0;
 if (scalaVista>(parscalkool*1.0) ) then TerrenoGR.Livellokool:=1;
 if (scalaVista>(parscalkool*2) )   then begin TerrenoGR.Livellokool:=2;  end;
 if (scalaVista>(parscalkool*4) )   then begin TerrenoGR.Livellokool:=3;  end;
 if (scalaVista>(parscalkool*8) )   then begin TerrenoGR.Livellokool:=4;  end;
 if (scalaVista>(parscalkool*16) )   then begin TerrenoGR.Livellokool:=5;  end;

 if (scalaVista>(parscalkool*32) )   then begin TerrenoGR.Livellokool:=6;  end;
 if (scalaVista>(parscalkool*64) )   then begin TerrenoGR.Livellokool:=7;  end;
// if (scalaVista>(parscalkool*6) )   then Ilprogetto.GRCorrente.Livellokool:=3;
 // maxKool :=3;
  if TerrenoGR.Livellokool> maxKool then TerrenoGR.Livellokool := maxKool;

 if (GRCorrente = TerrenoGR) then  // usato per calibrare territorio
  begin
   TerrenoGR.scaricaTuttiSubRater;
   TerrenoGR.CaricaTerrenoInSchermo;

   TerrenoGR.scalacentroSubRaster(TerrenoGR.xcRot,TerrenoGR.ycRot,TerrenoGR.scalaGR);
   TerrenoGR.rotocentroSubRaster(TerrenoGR.xcRot,TerrenoGR.ycRot,TerrenoGR.angoloGR);
  end
   else
  begin
   TerrenoGR.scaricaNonInKool;
   TerrenoGR.scaricaNonInSchermo;
   TerrenoGR.CaricaTerrenoInSchermo;
  end;
end;


procedure   TProgetto.setcomando(com : TipoComando; fase : Integer);
begin
	Comando := com;
  fasecomando :=fase;
	AggiornaInterfaceComandoAzione( com ,  fase );
end;


procedure   TProgetto.LeftMouse(HHDC : TImage32;  Sh: TShiftState; x,y : Integer);
var x1,y1 : Real;
begin
   	 if not(incomandotrasparente) then Lastcomando := comando;

//   	 _inrectPan := visibleRect;
//    	[self ricordasfondo ];
    	xclickdown := x;  	yclickdown := y;
    	x2virt     := x; 	  y2virt     := y;
    	if (((comando = kStato_Testo) and (fasecomando =1)) or (comando = kStato_CatPoligono) ) then begin end
    	  else begin  x1virt:=x2virt; y1virt:=y2virt;	end;
    	xcoordLast := xorigineVista+xclickdown*scalaVista;
    	ycoordLast := yorigineVista+yclickdown*scalaVista;
    	update_offsetmirino;

    	mouseSnappe;

    	mouseComandiRaster(HHDC);
    	mouseComandiDisegno(HHDC);
    	mouseComandiEditDisegno(HHDC);   // + righello
//    	mouseComandiViste];
    	mouseComandiVertici(HHDC);
      mouseComandiSelezionanti(HHDC);
//    	AggiornaInterfaceComandoAzione];




end;


procedure   TProgetto.mouseComandiVertici     (HHDC : TImage32);
var locvt : Tvertice;
begin
	case comando of
		kStato_SpostaVertice:  begin
			case fasecomando of
				0 : begin if selezionaVtconPt  then begin
               if ListaEditvt.count>1 then
                begin
                 locvt := ListaEditvt.Items[1]; xmom:= round(Xinschermo(locvt.x)); ymom:= hSchermo-Round(Yinschermo(locvt.y));
                 setfasecomandopiu1;
                end;
             end;
         end;
			  1 : begin SpostaVerticeSelezionato  (xcoordLast , ycoordLast); setfasecomando(0); ridisegna;    end;
      end;
     end;
		kStato_InserisciVertice: begin
			case fasecomando of
				0 : begin if selezionaVtconPt  then begin
          locvt := ListaEditvt.Items[1]; xmom:= round(Xinschermo(locvt.x)); ymom:= hSchermo-Round(Yinschermo(locvt.y));
          setfasecomandopiu1;
         end;
        end;
			  1 : begin InserisciVerticeSelezionato(xcoordLast , ycoordLast); setfasecomando(0); ridisegna;   end;
      end;
    end;

		kStato_CancellaVertice: begin
			if selezionaVtconPt then begin CancellaVerticeSelezionato;   ridisegna; end;
    end;

		kStato_SpostaPosCivico:  begin
			case fasecomando of
				0 : begin
             if selezionaCivicoPosconPt  then
              begin
               case modoeditcivico of
                1 : begin  xmom:= round(Xinschermo(CivicoinEdit.x1c));  ymom:= hSchermo-Round(Yinschermo(CivicoinEdit.y1c)); end;
                2 : begin  xmom:= round(Xinschermo(CivicoinEdit.x2c));  ymom:= hSchermo-Round(Yinschermo(CivicoinEdit.y2c)); end;
                3 : begin  xmom:= round(Xinschermo(CivicoinEdit.x3c));  ymom:= hSchermo-Round(Yinschermo(CivicoinEdit.y3c)); end;
                4 : begin
                     Form_txtCivico.inedit:= true;
                     if (Form_txtCivico.showmodal = idOk) then
                      begin
                       if Form_txtCivico.Edit_nrCiv.Text<>'' then CivicoinEdit.txtciv := Form_txtCivico.Edit_nrCiv.Text
                                                             else CivicoinEdit.txtciv := '#';
                       ridisegna;
                      end;
                    end;
               end;
               setfasecomandopiu1;
               if modoeditcivico=4 then setfasecomando(0);
              end;
         end;
			  1 : begin
          case modoeditcivico of
           1 : begin CivicoinEdit.x1c := xcoordLast; CivicoinEdit.y1c := ycoordLast; end;
           2 : begin CivicoinEdit.x2c := xcoordLast; CivicoinEdit.y2c := ycoordLast; end;
           3 : begin CivicoinEdit.x3c := xcoordLast; CivicoinEdit.y3c := ycoordLast; end;
          end;
//          comando00;
           setfasecomando(0);
          ridisegna;
         end;
      end;
     end;


  end;
end;


procedure   TProgetto.mouseComandiEditDisegno (HHDC : TImage32);
var locvt : Tvertice;
    dd : Real;
begin
 case comando of

    kStato_Pan : begin
        case fasecomando of
          0 : begin
               xIPan:=xmouseI;  yIPan:=ymouseI;
               xOriginePrePan := xOrigineVista; yOriginePrePan := yOrigineVista;
               setfasecomandopiu1;
            end;
            else begin comando00; ridisegna;  end;
        end;
    end;

    kStato_DistRighello :  begin
        case fasecomando of
          0 : begin
               x1coord := xcoordLast;	y1coord := ycoordLast;
               setfasecomandopiu1;
            end;
            else begin comando00;
                dd := distsemplicefunz(x1coord,y1coord,xcoordLast,ycoordLast);
                Mainform.BotMsg1.Caption:='Distanza in metri : '+FormatFloat('0.##', dd);
                Form_Infodist.Label1.caption := FormatFloat('0.##', dd);
                Form_Infodist.show;
               end;
        end;
    end;

    kStato_DefStampa    :  begin
        case fasecomando of
          0 : begin
               x1coord := xcoordLast;	y1coord := ycoordLast;
//               showmessage( FormatFloat('0.#', x1coord/10) );
//               showmessage( FormatFloat('0.#', y1coord/10) );

               stampaxorigine    := x1coord-(((stampadimXmm*stampaScalaStampa)/1000)/2);
               stampayorigine    := y1coord-(((stampadimYmm*stampaScalaStampa)/1000)/2);
               stampax2origine   := stampaxorigine + ((stampadimXmm*stampaScalaStampa)/1000);
               stampay2origine   := stampayorigine + ((stampadimYmm*stampaScalaStampa)/1000);


//               showmessage( FormatFloat('0.#',stampaxorigine/10 ));
//               showmessage( FormatFloat('0.#',stampayorigine/10 ));

               comando00;
               if Mainform.SaveStampa.Execute then IlProgetto.Stampa(  Mainform.SaveStampa.FileName);


            end;
        end;
    end;

    kStato_zoomWindow : begin
        case fasecomando of
          0 : begin
               x1coord := xcoordLast;	y1coord := ycoordLast;
               setfasecomandopiu1;
            end;
            else
          begin
           setZoomW (x1coord,y1coord,xcoordLast,ycoordLast );
           comando00; ridisegna;

          end;
        end;
    end;


    kStato_TagliaPoligono : begin
        if selezionaVtconPt  then begin
          case fasecomando of
            0 : begin
               if ListaEditvt.count>1 then
                begin
                 Poligonointaglio := ListaEditvt.Items[0];
                 if Poligonointaglio.b_chiusa then
                  begin
                   locvt := ListaEditvt.Items[1];
                   vtprimoTaglio := locvt;
                   xmom:= round(Xinschermo(locvt.x)); ymom:= hSchermo-Round(Yinschermo(locvt.y));
                   setfasecomandopiu1;
                  end;
                end;
            end;
            1 : begin
               if ListaEditvt.count>1 then
                begin
                 if (Poligonointaglio = ListaEditvt.Items[0]) then
                  begin
                   locvt := ListaEditvt.Items[1];
                   vtsecondoTaglio := locvt;
                   xmom:= round(Xinschermo(locvt.x)); ymom:= hSchermo-Round(Yinschermo(locvt.y));
                   setfasecomandopiu1;
                  end;
                end;
            end;
            2 : begin
               if ListaEditvt.count>1 then
                begin
                 if (Poligonointaglio = ListaEditvt.Items[0]) then
                  begin
                   locvt := ListaEditvt.Items[1];
                   Poligonointaglio.taglia3Vt(vtprimoTaglio,vtsecondoTaglio,locvt);
                 // taglia poligono con le 3 info
                   comando00; ridisegna;
                  end;
                end;
            end;

          end;
        end;
    end;

    kStato_SpostaDisegnoptDlg : begin
     if DisegnoVCorrente<>nil then
      begin
       case fasecomando of
        0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando);
            Form_Spostaterritorio.edit1.Text := Format ('%1.2f',[x1coord]);
            Form_Spostaterritorio.edit2.Text := Format ('%1.2f',[y1coord]);
            if Form_Spostaterritorio.showmodal=idOk then
            begin
             DisegnoVCorrente.SpostaDisegnodxdy( (StrToFloat(Form_Spostaterritorio.Edit1.Text)-x1coord) ,
                     (StrToFloat(Form_Spostaterritorio.Edit2.Text)-y1coord));
            end;
            comando00; ridisegna;
        end;
       end;
      end;
    end;

    kStato_FixCentroRotVettoriale : begin
     if DisegnoVCorrente<>nil then
      begin
  	  	DisegnoVCorrente.eventuale_xc := xcoordLast; 		DisegnoVCorrente.eventuale_yc := ycoordLast;
        RotGR_update;
        comando00;
      end;
     end;
 end;
end;


procedure   TProgetto.disegnaselezionati(HHDC : TImage32);
var k : Integer;
    locvet : TVettoriale;
   AColor32   : TColor32;
   AsupColor32: TColor32;
begin
    TColor32Entry(AColor32).A := 128;
    TColor32Entry(AColor32).R := 255;
    TColor32Entry(AColor32).G := 0;
    TColor32Entry(AColor32).B := 0;

    TColor32Entry(AsupColor32).A := 98;
    TColor32Entry(AsupColor32).R := 255;
    TColor32Entry(AsupColor32).G := 0;
    TColor32Entry(AsupColor32).B := 0;

 for k:=0 to ListaSelezionati.Count-1 do
  begin
   locvet := ListaSelezionati.items[k];
   if not(locvet.testinternoschermo) then continue;
   locvet.DisegnaConColori(HHDC,AColor32,AsupColor32,1);
  end;
end;


procedure   TProgetto.disegnaedifterselezionati(HHDC : TImage32);
var k : Integer;
    locvet : TVettoriale;
   AColor32   : TColor32;
   AsupColor32: TColor32;
begin
    TColor32Entry(AColor32).A := 128;
    TColor32Entry(AColor32).R := 0;
    TColor32Entry(AColor32).G := 0;
    TColor32Entry(AColor32).B := 255;
    TColor32Entry(AsupColor32).A := 98;
    TColor32Entry(AsupColor32).R := 255;
    TColor32Entry(AsupColor32).G := 0;
    TColor32Entry(AsupColor32).B := 255;
 for k:=0 to GliImmobiliDati.listaFabbricatiFiltrata.Count-1 do
  begin
   beep;
   locvet := GliImmobiliDati.listaFabbricatiFiltrata.items[k];
   if not(locvet.testinternoschermo) then continue;
   locvet.DisegnaConColori(HHDC,AColor32,AsupColor32,1);
  end;
end;



procedure   TProgetto.disegnaInformati(HHDC : TImage32);
var k : Integer;
    locvet : TVettoriale;
   AColor32   : TColor32;
   AsupColor32: TColor32;
begin
    TColor32Entry(AColor32).A := 128;
    TColor32Entry(AColor32).R := 255;
    TColor32Entry(AColor32).G := 0;
    TColor32Entry(AColor32).B := 255;

    TColor32Entry(AsupColor32).A := 98;
    TColor32Entry(AsupColor32).R := 255;
    TColor32Entry(AsupColor32).G := 0;
    TColor32Entry(AsupColor32).B := 255;

 for k:=0 to ListaInfo.Count-1 do
  begin
    TColor32Entry(AColor32).R := 255;
   if k = indToshow then TColor32Entry(AColor32).R := 80;
   locvet := ListaInfo.items[k];
   if not(locvet.testinternoschermo) then continue;
   locvet.DisegnaConColori(HHDC,AColor32,AsupColor32,1);
  end;



end;



procedure   TProgetto.MiddleMouseDown(HHDC : TImage32; Sh: TShiftState; x1,y1 : Integer);
begin

  xstMiddleI := x1;
  ystMiddleI := y1;

  xOriginePrePan := xOrigineVista;
  yOriginePrePan := yOrigineVista;
  mouseMiddleIsDown :=true;
end;

procedure   TProgetto.MiddleMouseUp(HHDC : TImage32; Sh: TShiftState; x1,y1 : Integer);
begin
  mouseMiddleIsDown :=false;
end;

procedure   TProgetto.RigthMouse(HHDC : TImage32; Sh: TShiftState; x1,y1 : Integer);
var  daridisegnare : Boolean;
begin

	daridisegnare := false;

	if (( varbase.comando =  kStato_SpostaVertice) or ( varbase.comando =  kStato_InserisciVertice) or ( varbase.comando =  kStato_CancellaVertice) )
   then begin daridisegnare := true; end;

	case comando of

  	kStato_Polilinea:  begin
     if Polyincostruzione<>nil then begin
      if fasecomando>0 then DisegnoVcorrente.finitaPolilinea(HHDC);
     end;
      comando00;
    end;
  	kStato_Rettangolo: begin
     if Polyincostruzione<>nil then begin
      if fasecomando>0 then DisegnoVcorrente.finitoRettangolo(HHDC);
     end;
     setcomando(kStato_nulla,0);
    end;

    kStato_Poligono, kStato_CatPoligono :
     begin
      if Polyincostruzione<>nil then begin Polyincostruzione.chiudiSeChiusa; end;
      setcomando(kStato_nulla,0);
			daridisegnare := true;
     end;

    kStato_Regione : begin
  		if (fasecomando<2) then setcomando(kStato_nulla,0)
       else
				if (FaseRegione = 1) then setcomando(kStato_nulla,0) else
         begin
          Polyincostruzione.aggiungiUltimoPuntoUp(HHDC);  FaseRegione:=1;
         end;
    end;
	  kStato_nulla :
     begin
      case Lastcomando of
       kStato_Testo  , kStato_TestoRuotato,kStato_TestoRotoScalato : begin Form_Text.Show; end;
       kStato_Simbolo, kStato_SimboloRot,  kStato_SimboloRotSca    : begin Form_Simbolo.Show; end;

       else  IniziaComando(Lastcomando);
      end;



     end
    else
     begin
			 setcomando(kStato_nulla,0);
     end;
  end;

  {
        case kStato_Regione:
			[ [varbase DisegnoVcorrente] chiudipoligono:hdc :[varbase MUndor]];
            [ [varbase DisegnoVcorrente] updateEventualeRegione:hdc :[varbase MUndor]];
			[varbase setfasecomando:10];
            [self display];
                //			[self ridisegnasfondo ];
            break;


//	if (incomandotrasparente)
   {
		[varbase setcomando:LastComandotrasparente];
		[varbase setfasecomando:LastFaseComandotrasparente];
		varbase.x1virt = (long)((x1spazialevirt-[LeInfo xorigineVista])/[LeInfo scalaVista]);
		varbase.y1virt = (long)((y1spazialevirt-[LeInfo yorigineVista])/[LeInfo scalaVista]);
	}
//   else



	incomandotrasparente := false;

	if (daridisegnare) then ridisegna;

   AggiornaInterfaceComandoAzione(comando,fasecomando);
end;


Destructor  TProgetto.Done;
begin
end;




procedure   TProgetto.Disegna(HHDC : TImage32;instampa : Boolean);
var k : Integer;
    locdisV : TDisegnoV;
    locdisGR : TDisegnoGR;
    oldXorigine, oldYorigine , oldscalas: real;
    oldhschermo  : Integer;
begin
 if instampa then
  begin
   oldXorigine := xorigineVista;         oldYorigine    := yorigineVista;
   oldscalas   := scalaVista;            scalaVista     := stampaScalaOrMap;
   xorigineVista  := stampaxorigine;     yorigineVista  := stampayorigine;
   oldhschermo    := Hschermo;           Hschermo       := esternostampadimYpx;
  end;

 if instampa then riaggiornax2y2stampa  else riaggiornax2y2;


 if  vedoterreno then UpdateTerritorio;

 HHDC.RepaintMode :=  rmOptimizer ;     // rmDirect; //   rmfull; //

 HHDC.BeginUpdate;

  with HHDC.Bitmap do
  begin
   Clear(ColoreSfondo);
   if vedoterreno then TerrenoGR.Disegna(HHDC);
   for k:=0 to ListadisegniGR.Count-1 do
    begin
     locdisGR := ListadisegniGR.Items[k];
     locdisGR.Disegna(HHDC);
    end;
   for k:=0 to ListadisegniV.Count-1 do
    begin
     locdisV := ListadisegniV.Items[k];
     locdisV.Disegna(HHDC);
    end;
  end;


  if ((IlCatastoV.QUnione<> nil) and (IlCatastoV.vedoQU)) then
   begin
     IlCatastoV.QUnione.Disegna(HHDC);
   end;

  if (IlCatastoV.vedoCXF) then
   begin
    for k:=0 to IlCatastoV.listaCXF.Count-1 do
     begin
      locdisV := IlCatastoV.listaCXF.Items[k];
      locdisV.DisegnaCatasto(HHDC);
     end;
   end;

    for k:=0 to LeConcessioniV.listaDisegni.Count-1 do
     begin
      locdisV := LeConcessioniV.listaDisegni.Items[k];
      locdisV.Disegna(HHDC);
     end;


  disegnaselezionati(HHDC);
  IlCatastoV.disegnaselezionatiFabbricati(HHDC);
  IlCatastoV.disegnaselezionatiTerreni(HHDC);
  disegnaInformati(HHDC);
  LeConcessioniV.disegnaselezionati(HHDC);

  if vedogriglia then  DisegnaGriglia(HHDC);

  HHDC.EndUpdate;
  HHDC.Repaint;
 // HHDC.Bitmap.Changed;
 // HHDC.Refresh; // force repaint

 if instampa then
  begin
   xorigineVista := oldXorigine;
   yorigineVista := oldYorigine;
   scalaVista    := oldscalas;
   hschermo      := oldhschermo;
  end;

end;



procedure  TProgetto.mouseSnappe;
var pre_xcoordLast ,pre_ycoordLast  : Real;
    locdisvet : TDisegnoV;
    i : Integer;
		giasnappato : boolean;

begin

	pre_xcoordLast := xcoordLast;
	pre_ycoordLast := ycoordLast;
  giasnappato := false;

  	// lo snap
  	for i:=0 to ListaDisegniV.count-1 do
     begin
      if giasnappato then break;
  		locdisvet := ListaDisegniV.items[i];
      if Not(locdisvet.b_visibile ) then continue;
  		if (b_snapfine) then
       begin
  			if (locdisvet.snapFine(xcoordLast,ycoordLast)) then begin
  		     xcoordLast := xsnap;  ycoordLast:=ysnap;
  				x1virt := round((xcoordLast-xorigineVista)/scalaVista);
  				y1virt := round((ycoordLast-yorigineVista)/scalaVista);
  				giasnappato := true;
  				Beep;
  				break;
        end;
       end;
     end;

  	for i:=0 to ListaDisegniV.count-1 do
     begin
      if giasnappato then break;
  		locdisvet := ListaDisegniV.items[i];
      if Not(locdisvet.b_visibile ) then continue;
  		if (b_SnapVicino) then
       begin
  			if (locdisvet.snapVicino(xcoordLast,ycoordLast)) then begin
  		     xcoordLast := xsnap;  ycoordLast:=ysnap;
  				x1virt := round((xcoordLast-xorigineVista)/scalaVista);
  				y1virt := round((ycoordLast-yorigineVista)/scalaVista);
  				giasnappato := true;
  				Beep;
  				break;
        end;
       end;
     end;



(*
  			// snap fine se catpoligono ed al primo inserimento
  		if (([varbase comando]== kStato_CatPoligono) & 	([varbase fasecomando]==0))
  			if ([locdisvet snapFine: varbase.d_xcoordLast : varbase.d_ycoordLast ])
  		    { varbase.d_xcoordLast=[LeInfo xsnap];  varbase.d_ycoordLast=[LeInfo ysnap];
  				varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista];
  				varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista];
  				giasnappato = YES;
  				NSBeep();
  				break;  };



  		if (([comandiToolBar b_snapvicino]) & (!giasnappato)) {
  			if ([locdisvet snapVicino: varbase.d_xcoordLast : varbase.d_ycoordLast ])
  			{ varbase.d_xcoordLast=[LeInfo xsnap];  varbase.d_ycoordLast=[LeInfo ysnap];
  				varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista];
  				varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista];
  				giasnappato = YES;
  				NSBeep();

  				break;  };
  		}



  	}

  	if ([comandiToolBar b_snapgriglia])  {
  		bool snappata =NO;
  		if ([varbase inGriglia]) {
  			snappata = [self SnappaGriglia :pre_xcoordLast : pre_ycoordLast];
  		}
  		if (snappata)  NSBeep();
  	}


  	if (([comandiToolBar b_snaporto]) & ([varbase comando]!=kStato_zoomWindow)) {
  		if ([varbase fasecomando]>0)  {
  			double  llx=fabs(pre_xcoordLast-varbase.d_xcoordLast);	double  lly=fabs(pre_ycoordLast-varbase.d_ycoordLast);
  			if (llx>lly) {	varbase.d_ycoordLast=pre_ycoordLast;	} else { varbase.d_xcoordLast=pre_xcoordLast;	}
  			[LeInfo setxysnap : pre_xcoordLast : pre_ycoordLast];
  			varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista];
  			varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista];
  		}
  	}

   	if ([comandiToolBar b_snaportoseg]) {
  			// solo nel caso di plinea e company
  		if (([varbase comando] == kStato_Polilinea ) | ([varbase comando] == kStato_Poligono ) | ([varbase comando] == kStato_Regione ) ) {
  			if ([varbase fasecomando]>1)  {
  				[[varbase DisegnoVcorrente] ortosegmenta: varbase.d_xcoordLast : varbase.d_ycoordLast];
    			    varbase.d_xcoordLast=[LeInfo xsnap];  varbase.d_ycoordLast=[LeInfo ysnap];
  				varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista];
  				varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista];
  			}
  	    }
  	}

  }

*)
end;


procedure TProgetto.mouseComandiRaster(HHDC: TImage32);
var STR_loc : String;
begin

  case comando of
    kStato_FixCentroRot : begin
     if GRCorrente<>nil then
      begin
  	  	GRCorrente.xcRot := xcoordLast; 		GRCorrente.ycRot := ycoordLast;
        GrCorrente.UpdateExParam;           RotGR_update;
        comando00;
      end;
     end;

    kStato_spostaRaster_uno: begin
     if GRCorrente<>nil then
      begin
       case fasecomando of
        0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando); end;
        1 : begin x2coord := xcoordLast;	y2coord := ycoordLast; comando00; ridisegna; end;
       end;
      end;
    end;

    kStato_spostaRaster2pt_tutti : begin
     if GRCorrente<>nil then
      begin
       case fasecomando of
        0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando);
            Form_Spostaterritorio.edit1.Text := Format ('%1.2f',[x1coord]);
            Form_Spostaterritorio.edit2.Text := Format ('%1.2f',[y1coord]);
            if Form_Spostaterritorio.showmodal=idOk then
            begin
             if (spostoTerritorioAttivo) then
              begin
               if GRCorrente.IsKool then begin GRCorrente.spostaKool( (StrToFloat(Form_Spostaterritorio.Edit1.Text)-x1coord) ,
                     (StrToFloat(Form_Spostaterritorio.Edit2.Text)-y1coord));  end;
              end
               else
              begin
               GRCorrente.sposta( (StrToFloat(Form_Spostaterritorio.Edit1.Text)-x1coord) ,
                     (StrToFloat(Form_Spostaterritorio.Edit2.Text)-y1coord));
              end;
            end;
            comando00; ridisegna;
        end;
       end;
      end;
    end;


 		kStato_rotoscalaraster : begin
     if GRCorrente<>nil then
      begin
    	 case fasecomando of
  		 0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando); end;
  		 1 : begin x2coord := xcoordLast;	y2coord := ycoordLast; inc(fasecomando); end;
  		 2 : begin x3coord := xcoordLast;	y3coord := ycoordLast; inc(fasecomando); end;
  		 3 : begin x4coord := xcoordLast;	y4coord := ycoordLast; inc(fasecomando);
  					GRCorrente.rotoscala(x1coord,y1coord, x2coord, y2coord,
  														   x3coord,y3coord, x4coord, y4coord);
//  					[varbase     aggiornaslideCalRaster ];
  					comando00; ridisegna;
          end;
       end;
      end;
    end;

    kstato_spostaTerritorioPrCoord : begin
  	 case fasecomando of
  		 0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando);
          Form_Spostaterritorio.edit1.Text := Format ('%1.2f',[x1coord]);
          Form_Spostaterritorio.edit2.Text := Format ('%1.2f',[y1coord]);
           if Form_Spostaterritorio.showmodal=idOk then
              spostaterritorio(x1coord,y1coord,Form_Spostaterritorio.Edit1.Text,Form_Spostaterritorio.Edit2.Text);

       end;
     end;
    end;

		kStato_scalarighello :  begin
     if GRCorrente<>nil then
      begin
  	   case fasecomando of
         0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando);
         end;
         1 : begin x2coord := xcoordLast;	y2coord := ycoordLast; inc(fasecomando);
    					lastdist := sqrt( (x2coord-x1coord)*(x2coord-x1coord) + (y2coord-y1coord)*(y2coord-y1coord) );
              Form_Righello.Old_distanza.Caption:=  Format('%1.2f',[lastdist]);
              Form_Righello.EditNuovaDist.Text:=  Format('%1.2f',[lastdist]);
              if Form_Righello.ShowModal = idOK then
               begin comando00; ridisegna; end else begin comando00; end;
         end;
       end;
      end;
    end;

		kStato_CropRasterRettangolo :  begin
     if GRCorrente<>nil then
      begin
    	 case fasecomando of
         0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando);   end;
         1 : begin x2coord := xcoordLast;	y2coord := ycoordLast;
          GRCorrente.CropRettangolo(x1coord,y1coord,x2coord,y2coord);
          comando00;
         end;
      end;
     end;
    end;

   kStato_Calibraraster : begin
     if GRCorrente<>nil then
      begin
       case fasecomando of
        0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; if Form_Crocicchi.showmodal=idOk then inc(fasecomando); end;
  			1 : begin x2coord := xcoordLast;	y2coord := ycoordLast; if Form_Crocicchi.showmodal=idOk then inc(fasecomando); end;
  			2 : begin x3coord := xcoordLast;	y3coord := ycoordLast; if Form_Crocicchi.showmodal=idOk then inc(fasecomando); end;
  			3 : begin x4coord := xcoordLast;	y4coord := ycoordLast; if Form_Crocicchi.showmodal=idOk then begin
            GRCorrente.rotoscala(x1coord, y2coord, x3coord, y4coord,
                                 strToFloat(Form_Crocicchi.Edit_X1.text) ,strToFloat(Form_Crocicchi.Edit_Y1.text),
                                 strToFloat(Form_Crocicchi.Edit_X2.text) ,strToFloat(Form_Crocicchi.Edit_Y2.text));
          comando00;
         end;
        end;
       end;
      end;
   end;

  end;
(*



  		case kStato_Calibraraster :
  			switch ([varbase fasecomando]) {
  			}
  			break;


*)

end;


procedure TProgetto.mouseComandiDisegno     (HHDC : TImage32);
var hht,hhang, angloc : real;
  	locdisvet : TDisegnoV;
  	didded    : boolean;
    loclistadefsimboli : TlistaDefSimboli;
 begin
  	didded := false;

  case comando of
			// vettoriali
   kStato_Punto:        begin DisegnoVcorrente.faipunto(HHDC,xcoordLast,ycoordLast);                 comando00;         end;
   kStato_Polilinea:    begin DisegnoVcorrente.faiplinea(HHDC,xcoordLast,ycoordLast,fasecomando);    inc(fasecomando);  end;
   kStato_Poligono:     begin DisegnoVcorrente.faipoligono(HHDC,xcoordLast,ycoordLast,fasecomando);  inc(fasecomando);  end;
   kStato_Regione:      begin DisegnoVcorrente.fairegione(HHDC,xcoordLast,ycoordLast,fasecomando,FaseRegione);
                              inc(fasecomando);   FaseRegione:=0;                                                        end;
   kStato_Cerchio:      begin
  	 case fasecomando of
  		0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando);    end;
  		1 : begin DisegnoVcorrente.faicerchio(HHDC,x1coord,y1coord,xcoordLast,ycoordLast); comando00;  end;
     end;
   end;
   kStato_Rettangolo:   begin
  	 case fasecomando of
  		0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando);    end;
  		1 : begin DisegnoVcorrente.fairettangolo(HHDC,x1coord, y1coord, xcoordLast , ycoordLast); comando00;  end;
     end;
   end;
   kStato_Testo:        begin
      DisegnoVcorrente.faitesto(HHDC,xcoordLast,ycoordLast,altezzatesto_InInserimento,0.0,testoTxt_InInserimento);
       ridisegna;
      comando00;
     end;

   kStato_TestoRuotato: begin
  	 case fasecomando of
  		0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando); angloc:=0.0; end;
  		1 : begin
        angloc :=  angolo2vertici(x1coord,y1coord,xcoordLast,ycoordLast);
        DisegnoVcorrente.faitesto(HHDC,x1coord,y1coord,altezzatesto_InInserimento,angloc,testoTxt_InInserimento);
        ridisegna;
        comando00;
       end;
     end;
    end;

   kStato_TestoRotoScalato: begin
  	 case fasecomando of
  		0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando);    end;
  		1 : begin x2coord := xcoordLast;	y2coord := ycoordLast; inc(fasecomando);    end;
  		2 : begin
        angloc :=  angolo2vertici(x1coord,y1coord,x2coord,y2coord);
        hht    :=  distsempliceFunz(x1coord,y1coord,xcoordLast,ycoordLast) *parahTesto;
        DisegnoVcorrente.faitesto(HHDC,x1coord,y1coord,hht,angloc,testoTxt_InInserimento);
        ridisegna;
        comando00;
       end;
     end;
    end;

    kStato_Simbolo : begin
     if LelisteDefSimboli.count>0 then
      begin
       loclistadefsimboli := Ilprogetto.LelisteDefSimboli.items[0];
       DisegnoVcorrente.faisimbolo(HHDC,xcoordLast,ycoordLast,Form_Simbolo.indicesimbolo, true,
                                  loclistadefsimboli.listaDefinizioni, loclistadefsimboli.nomelista,6.0,0.0);
       ridisegna;
       comando00;
      end;
    end;

    kStato_SimboloRot: begin
  	 case fasecomando of
  		0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando); angloc:=0.0;  end;
  		1 : begin
           angloc :=  angolo2vertici(x1coord,y1coord,xcoordLast,ycoordLast);
           loclistadefsimboli := Ilprogetto.LelisteDefSimboli.items[0];
           DisegnoVcorrente.faisimbolo(HHDC,x1coord,y1coord,Form_Simbolo.indicesimbolo, true,
                                       loclistadefsimboli.listaDefinizioni, loclistadefsimboli.nomelista,6.0,angloc);
         ridisegna;
         comando00;
       end;
     end;
    end;

    kStato_SimboloRotSca : begin
  	 case fasecomando of
  		0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando); angloc:=0.0;  end;
  		1 : begin x2coord := xcoordLast;	y2coord := ycoordLast; inc(fasecomando);    end;
  		2 : begin
           angloc :=  angolo2vertici(x1coord,y1coord,x2coord,y2coord);
           hht    :=  distsempliceFunz(x1coord,y1coord,xcoordLast,ycoordLast);
           loclistadefsimboli := Ilprogetto.LelisteDefSimboli.items[0];
           DisegnoVcorrente.faisimbolo(HHDC,x1coord,y1coord,Form_Simbolo.indicesimbolo, true,
                                       loclistadefsimboli.listaDefinizioni, loclistadefsimboli.nomelista,hht,angloc);
         ridisegna;
         comando00;
       end;
     end;
    end;

    kStato_Civico : begin
  	 case fasecomando of
  		0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; inc(fasecomando); angloc:=0.0;  end;
  		1 : begin x2coord := xcoordLast;	y2coord := ycoordLast; inc(fasecomando);    end;
  		2 : begin x3coord := xcoordLast;	y3coord := ycoordLast;
           Form_txtCivico.inedit:= false;
           if Form_txtCivico.showmodal = id_ok then
            begin

             if Form_txtCivico.Edit_nrCiv.Text<>'' then
                DisegnoVcorrente.faiCivico(HHDC,x1coord,y1coord,x2coord,y2coord,x3coord,y3coord,Form_txtCivico.Edit_nrCiv.Text)
               else
                DisegnoVcorrente.faiCivico(HHDC,x1coord,y1coord,x2coord,y2coord,x3coord,y3coord,'#');
             if CivicoinEdit<>nil then begin cercastradaBattente_CivicoinEdit; end;

             ridisegna;
            end;
         comando00;
       end;
     end;
    end;

    kStato_txtstradale : begin
     intoduciBattente_nomestrada;
    end;

  end;

 (*

  	switch ([varbase comando]) {

  /////

  		case kStato_Simbolo:
  			[[varbase DisegnoVcorrente] faisimbolo   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase indicecurrentsimbolo] :NO: [varbase ListaDefSimboli] : [varbase MUndor] ];
  			[varbase comando00];		break;
  		case kStato_SimboloFisso:
  			[[varbase DisegnoVcorrente] faisimbolo   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase indicecurrentsimbolo] :YES: [varbase ListaDefSimboli] : [varbase MUndor] ];
  			[varbase comando00];		break;
  		case kStato_SimboloRot:
  			switch ([varbase fasecomando]) {
  				case 0 :[[varbase DisegnoVcorrente] faisimbolo   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase indicecurrentsimbolo] :NO: [varbase ListaDefSimboli] : [varbase MUndor] ];
  						 varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast;
  						[varbase setfasecomandopiu1];
  					break;
  			    case 1 :
  					hhang =  angolo2vertici   ( varbase.d_x1coord  , varbase.d_y1coord  ,varbase.d_xcoordLast , varbase.d_ycoordLast );
  					[[varbase DisegnoVcorrente] ruotasimbolo  :hdc : hhang];
  					[varbase comando00]; 	[self display]; break;
  			}
  			break;

  		case kStato_SimboloRotSca:
  			switch ([varbase fasecomando]) {
  				case 0 : [[varbase DisegnoVcorrente] faisimbolo   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase indicecurrentsimbolo] :NO: [varbase ListaDefSimboli] : [varbase MUndor] ];
  					 varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast;
  					 [varbase setfasecomandopiu1]; 	break;
  			    case 1 :
  					hhang =  angolo2vertici   ( varbase.d_x1coord  , varbase.d_y1coord  ,varbase.d_xcoordLast , varbase.d_ycoordLast );
  					[[varbase DisegnoVcorrente] ruotasimbolo  :hdc : hhang];
  					[varbase setfasecomandopiu1];  break;
  				case 2 :
  					hht = scala2verticischermo   (varbase.d_x1coord  , varbase.d_y1coord  ,varbase.d_xcoordLast , varbase.d_ycoordLast,[LeInfo dimxVista]*[LeInfo scalaVista] );
  					[[varbase DisegnoVcorrente] scalasimbolo:hdc : hht];
                      [varbase comando00];
  					[self display];           break;
  			}
  			break;
  /////
  		case kStato_Cerchio:
  			switch ([varbase fasecomando]) {
  				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; 	break;
  			    case 1 : [[varbase DisegnoVcorrente] faicerchio  :hdc : varbase.d_x1coord : varbase.d_y1coord: varbase.d_xcoordLast : varbase.d_ycoordLast :[varbase MUndor]];
  					[varbase comando00];  break;
  			}
  			break;
  		case kStato_Testo:
  			hht = [[varbase FieldAltezzaTesto] doubleValue];
  			if (hht<=0) {hht = 10; }
   			[[varbase DisegnoVcorrente] faitesto  :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : hht : 0 :[[varbase FieldTxtTesto] stringValue]: [varbase MUndor]];
  			[varbase comando00];
  			[self display];
  			break;
  		case kStato_TestoRot:
  			switch ([varbase fasecomando]) {
  				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
  				case 1 :
  					hht = [[varbase FieldAltezzaTesto] doubleValue];
  					double ttdx,ttdy;
  					ttdx = varbase.d_xcoordLast-varbase.d_x1coord;	ttdy = varbase.d_ycoordLast-varbase.d_y1coord;
  					if ((ttdx==0)  & (ttdy==0)) return;
  					if (ttdx==0) { hhang = M_PI/2;   if (ttdy <0) hhang += M_PI;  }
  					else 	{ hhang = atan( ttdy / ttdx );  if (ttdx <0) hhang = M_PI+hhang; if (hhang<0) hhang += 2*M_PI;	}
  					[[varbase DisegnoVcorrente] faitesto  :hdc : varbase.d_x1coord : varbase.d_y1coord : hht : hhang:[[varbase FieldTxtTesto] stringValue]: [varbase MUndor]];
  					[varbase comando00];
  					[self display];
  					break;

  			}
  			break;
  		case kStato_TestoRotSca:
  			switch ([varbase fasecomando]) {
  				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
  				case 1 : varbase.d_x2coord = varbase.d_xcoordLast;	varbase.d_y2coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
  				case 2 :
  					hht = hypot( (varbase.d_xcoordLast-varbase.d_x1coord), (varbase.d_ycoordLast-varbase.d_y1coord) );

  					double ttdx,ttdy;
  					ttdx = varbase.d_x2coord-varbase.d_x1coord;	ttdy = varbase.d_y2coord-varbase.d_y1coord;
  					if ((ttdx==0)  & (ttdy==0)) return;
  					if (ttdx==0) { hhang = M_PI/2;   if (ttdy <0) hhang += M_PI;  }
  					else 	{ hhang = atan( ttdy / ttdx );  if (ttdx <0) hhang = M_PI+hhang; if (hhang<0) hhang += 2*M_PI;	}

  					[[varbase DisegnoVcorrente] faitesto  :hdc : varbase.d_x1coord : varbase.d_y1coord : hht : hhang:[[varbase FieldTxtTesto] stringValue]: [varbase MUndor]];
  					[varbase comando00];
  					[self display];
  					break;
  			}
  			break;


  		case kStato_CatPoligono:
  			if (  [theEvent modifierFlags ]  & NSControlKeyMask) {
  				[[varbase DisegnoVcorrente] faiplinea  :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando]: [varbase MUndor]];
  				[varbase setfasecomandopiu1]; 			[self ricordasfondo ];  NSBeep();
  			}
  			else {
  			 for (int i=0; i<[varbase ListaVector].count; i++) {
  				locdisvet= [[varbase ListaVector] objectAtIndex:i];
  				didded= ([[varbase DisegnoVcorrente] faiCatpoligono:hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando]:locdisvet]) ;
  				if (didded)	break;
  			 }
  				// riportare x1virt e y1virt a ultimo vertice polyincostruzione.
  			 if (didded) {
  				varbase.d_xcoordLast=[LeInfo xsnap];  varbase.d_ycoordLast=[LeInfo ysnap];
  			    varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista];
  			    varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista];
  			    [varbase setfasecomandopiu1];
  			    [self ricordasfondo ];
  			 }
  			}

  		 break;

  		case kStato_RettangoloStampa:
  		case kStato_RettangoloDoppioStampa:
  			switch ([varbase fasecomando]) {
  			 case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
  			 case 1 :
  					[progdialogs TogliRettangoloStampa:self];
  					double dxs= fabs(varbase.d_xcoordLast-varbase.d_x1coord);
  					double dys= fabs(varbase.d_ycoordLast-varbase.d_y1coord);
  					if ((dxs/dys)>(783.0/559.0)) { dys = (559.0/783.0)*dxs;
  						if (varbase.d_ycoordLast>varbase.d_y1coord) varbase.d_ycoordLast=varbase.d_y1coord+dys;
  															 else   varbase.d_ycoordLast=varbase.d_y1coord-dys;	}
  					                        else { dxs = (783.0/559.0)*dys;
  						if (varbase.d_xcoordLast>varbase.d_x1coord) varbase.d_xcoordLast=varbase.d_x1coord+dxs;
  						                                     else   varbase.d_xcoordLast=varbase.d_x1coord-dxs;	}
  					[varbase iniziarettangolostampa];
  					[[varbase rettangoloStampa] addvertexUp:varbase.d_x1coord    : varbase.d_y1coord];
  					[[varbase rettangoloStampa] addvertex  :varbase.d_xcoordLast : varbase.d_y1coord    :0];
  					[[varbase rettangoloStampa] addvertex  :varbase.d_xcoordLast : varbase.d_ycoordLast :0];
  					[[varbase rettangoloStampa] addvertex  :varbase.d_x1coord    : varbase.d_ycoordLast :0];
  					[[varbase rettangoloStampa] addvertex  :varbase.d_x1coord    : varbase.d_y1coord    :0];
  					if ([varbase comando]==kStato_RettangoloStampa) rettangoloStampaSingolo=YES; else rettangoloStampaSingolo=NO;
  					[varbase comando00];
  					[self display];
  					break;
  			}
  		break;
  	}
  }
*)
end;

procedure TProgetto.mouseComandiSelezionanti     (HHDC : TImage32);
var loctestoedit : TTesto;
begin
  case comando of
   kStato_Seleziona    : begin Seleziona(xcoordLast,ycoordLast); ridisegna;             end;  //  disegnaselezionati(HHDC);

   kStato_Match        : begin Match_conPt;             end;  //  disegnaselezionati(HHDC);
   kStato_Info         : begin selezInfo_conPt(xcoordLast,ycoordLast);  ridisegna;     end;
   kStato_InfoConcessione : begin LeconcessioniV.SelezionaPtInternoConcessione(xcoordLast,ycoordLast);  ridisegna;     end;

   kStato_InfoEdificio :
    begin
     IlCatastoV.SelezionaPtInternoFabbricato(xcoordLast,ycoordLast);
  //   IlCatastoV.disegnaselezionatiFabbricati(HHDC);
     IlCatastoV.FiltraImmobiliDaticonNuovaListaFabbricati(GliImmobiliDati.listaFabbricatiFiltrata);
     if GliImmobiliDati.listaFabbricatiFiltrata.count>0 then
      begin
        Dlg_InfoTerreno.Hide;
        Form_FabbricatoSingolo.mododisegna:=1;
        Form_FabbricatoSingolo.show;
        Form_FabbricatoSingolo.disegna;
      end
      else Form_FabbricatoSingolo.Hide;

     if GliImmobiliDati.listaFabbricatiFiltrata.count= 0 then
      begin
       IlCatastoV.SelezionaPtInternoTerreno(xcoordLast,ycoordLast);
       IlCatastoV.FiltraImmobiliDaticonNuovaListaTerreni(GliImmobiliDati.listaTerreniFiltrata);
     //  showmessage(intTostr(GliImmobiliDati.listaTerreniFiltrata.count));
       if GliImmobiliDati.listaTerreniFiltrata.count>0 then
        begin
         Form_TerrenoSingolo.show;
         Form_TerrenoSingolo.disegna;
        end
        else  Form_TerrenoSingolo.Hide;
      end;

     ridisegna;
     // mostra dialog filtrata degli eidifici
    end;

    kstato_editText : begin
     loctestoedit := SelezionaTesto (xcoordLast,ycoordLast);
     if loctestoedit<>nil then
      begin
       Form_editTesto.edit1.text:= loctestoedit.scritta;
        if Form_editTesto.showmodal=idOk then
         begin
          loctestoedit.scritta := Form_editTesto.edit1.text;
          ridisegna;
         end;
      end;
    end;


		kStato_SpostaSelected:  begin
			case fasecomando of
			 0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; setfasecomandopiu1; xprecVirt := x1coord; yprecVirt := y1coord; end;
			 1 : begin x2coord := xcoordLast;	y2coord := ycoordLast;  SpostaSelezionati;    comando00; ridisegna; end;
      end;
     end;
		kStato_CopiaSelected:  begin
      case fasecomando of
			  0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; setfasecomandopiu1; xprecVirt := x1coord; yprecVirt := y1coord; end;
			  1 : begin x2coord := xcoordLast;	y2coord := ycoordLast;  CopiaSelezionati; 	comando00; ridisegna; end;
      end;
     end;
		kStato_RuotaSelected:  begin
      case fasecomando of
				0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; setfasecomandopiu1;  xprecVirt := x1coord; yprecVirt := y1coord; end;
			  1 : begin x2coord := xcoordLast;	y2coord := ycoordLast;  RuotaSelezionati;   comando00; ridisegna;  end;
      end;

     end;
		kStato_ScalaSelected:  begin
      case fasecomando of
			  0 : begin x1coord := xcoordLast;	y1coord := ycoordLast; setfasecomandopiu1; xprecVirt := x1coord; yprecVirt := y1coord;  end;
			  1 : begin x2coord := xcoordLast;	y2coord := ycoordLast;  ScalaSelezionati;   comando00; ridisegna;  end;
      end;
     end;


  end;
end;



procedure   TProgetto.MouseMove(HHDC : TImage32; Sh: TShiftState; X,Y : Integer);
var dx, dy : Integer;
    dc : HDC;
    xcord,ycord : Real;
    angloc,scaloc : real;
    dd : Real;
    x1virt,y1virt,x2virt,y2virt,x3virt,y3virt,x4virt,y4virt : real;
    xcentroschermo,ycentroschermo : Real;
begin

 	xcord := xorigineVista+x*scalaVista;
 	ycord := yorigineVista+y*scalaVista;

  case comando of

   kstato_pan : begin
	   if (fasecomando>0)  then begin
        xorigineVista:=xOriginePrePan-(X-xIPan)*scalavista;
        yorigineVista:=yOriginePrePan-(Y-yIPan)*scalavista;
        ridisegna;
     end;
   end;

   kStato_Polilinea,  kStato_Poligono, kStato_Regione,kStato_Civico,kStato_scalarighello:    begin
   		if (fasecomando>0)  then begin
        dc  := HHDC.Bitmap.Handle;                                                          setrop2(dc,r2_not);
        movetoEx(dc,xclickdown,hSchermo-yclickdown,nil); lineto(dc,xmom,hSchermo-ymom);     xmom:=x;   ymom:=y;
        movetoEx(dc,xclickdown,hSchermo-yclickdown,nil); lineto(dc,X,hSchermo-Y);           setrop2(dc,r2_copypen);
        HHDC.Repaint;
      end;
   end;

   kStato_DistRighello : begin
   		if (fasecomando>0)  then begin
        dc  := HHDC.Bitmap.Handle;                                                          setrop2(dc,r2_not);
        movetoEx(dc,xclickdown,hSchermo-yclickdown,nil); lineto(dc,xmom,hSchermo-ymom);     xmom:=x;   ymom:=y;
        movetoEx(dc,xclickdown,hSchermo-yclickdown,nil); lineto(dc,X,hSchermo-Y);           setrop2(dc,r2_copypen);
        HHDC.Repaint;
        dd := distsemplicefunz(xcord,ycord,xcoordLast,ycoordLast);
         Mainform.BotMsg1.Caption:='Distanza in metri : '+FormatFloat('0.##', dd);
      end;
   end;

   kStato_rotoscalaraster : begin
   		case fasecomando of
       1, 3 :
       begin
        dc  := HHDC.Bitmap.Handle;                                                          setrop2(dc,r2_not);
        movetoEx(dc,xclickdown,hSchermo-yclickdown,nil); lineto(dc,xmom,hSchermo-ymom);     xmom:=x;   ymom:=y;
        movetoEx(dc,xclickdown,hSchermo-yclickdown,nil); lineto(dc,X,hSchermo-Y);           setrop2(dc,r2_copypen);
        HHDC.Repaint;
       end;
      end;

   end;


   kStato_Rettangolo, kStato_CropRasterRettangolo, kStato_zoomWindow :  begin
   		if (fasecomando>0)  then begin
         dc  := HHDC.Bitmap.Handle;                                                          setrop2(dc,r2_not);
        movetoEx(dc,xclickdown,hSchermo-yclickdown,nil);
        lineto(dc,xmom,hSchermo-yclickdown);
        lineto(dc,xmom,hSchermo-ymom);
        lineto(dc,xclickdown,hSchermo-ymom);
        lineto(dc,xclickdown,hSchermo-yclickdown);
         xmom:=x;   ymom:=y;
        movetoEx(dc,xclickdown,hSchermo-yclickdown,nil);
        lineto(dc,X,hSchermo-yclickdown);
        lineto(dc,X,hSchermo-Y);
        lineto(dc,xclickdown,hSchermo-Y);
        lineto(dc,xclickdown,hSchermo-yclickdown);
         setrop2(dc,r2_copypen);
        HHDC.Repaint;
      end;
   end;

   kStato_Cerchio : begin
   		if (fasecomando>0)  then begin
         dc  := HHDC.Bitmap.Handle;                                                          setrop2(dc,r2_not);
         disegnacerchiovirtuale(dc,xclickdown,hSchermo-yclickdown,xmom,hSchermo-ymom);
         xmom:=x;   ymom:=y;
         disegnacerchiovirtuale(dc,xclickdown,hSchermo-yclickdown,xmom,hSchermo-ymom);

         setrop2(dc,r2_copypen);
        HHDC.Repaint;
      end;
   end;


   kStato_spostaRaster_uno:
		if (fasecomando>0)  then begin
     dx := x- xclickdown;  dy := y- yclickdown;
     GRCorrente.sposta(dx*scalavista,dy*scalavista);
      xclickdown :=x;	yclickdown := y;
		 ridisegna;
    end;

	 kStato_SpostaVertice    : begin
    if (fasecomando>0) then
      begin
       dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not);
        DisDoppiaVirtual (dc,1, xmom , ymom); xmom:=x;   ymom:=y;  DisDoppiaVirtual (dc,1, xmom , ymom);
       setrop2(dc,r2_copypen);
       HHDC.Repaint;
      end;
    end;

	 kStato_SpostaPosCivico    : begin
    if (fasecomando>0) then
      begin

         dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not);
          DisDoppiaVirtualCivico (dc,modoeditcivico, xmom , ymom); xmom:=x;   ymom:=y;  DisDoppiaVirtualCivico (dc,modoeditcivico, xmom , ymom);
         setrop2(dc,r2_copypen);
         HHDC.Repaint;
      end;
    end;


	 kStato_InserisciVertice : begin if (fasecomando>0) then
      begin
       dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not);
        DisDoppiaVirtual (dc,2, xmom , ymom); xmom:=x;   ymom:=y;  DisDoppiaVirtual (dc,2, xmom , ymom);
       setrop2(dc,r2_copypen);
       HHDC.Repaint;
      end;
   end;

		kStato_SpostaSelected:  begin if (fasecomando>0) then
      begin
       dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not);
       DisSpostaVirtuale(dc,xcoordLast,ycoordLast, xprecVirt,yprecVirt );
        xprecVirt:=xcord; yprecVirt :=ycord;
       DisSpostaVirtuale(dc,xcoordLast,ycoordLast, xprecVirt,yprecVirt );
       setrop2(dc,r2_copypen);
       HHDC.Repaint;
      end;
     end;
		kStato_CopiaSelected:  begin if (fasecomando>0) then
      begin
       dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not);
       DisCopiaVirtuale(dc,xcoordLast,ycoordLast, xprecVirt,yprecVirt );
        xprecVirt:=xcord; yprecVirt :=ycord;
       DisCopiaVirtuale(dc,xcoordLast,ycoordLast, xprecVirt,yprecVirt );
       setrop2(dc,r2_copypen);
       HHDC.Repaint;
      end;
     end;
		kStato_RuotaSelected:  begin if (fasecomando>0) then
      begin
       dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not);
       DisRuotaVirtuale(dc,xcoordLast,ycoordLast, xprecVirt,yprecVirt );
        xprecVirt:=xcord; yprecVirt :=ycord;
       DisRuotaVirtuale(dc,xcoordLast,ycoordLast, xprecVirt,yprecVirt );
       setrop2(dc,r2_copypen);
       HHDC.Repaint;
      end;
     end;
		kStato_ScalaSelected:  begin if (fasecomando>0) then
      begin
       dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not);
       DisScalaVirtuale(dc,xcoordLast,ycoordLast, xprecVirt,yprecVirt );
        xprecVirt:=xcord; yprecVirt :=ycord;
       DisScalaVirtuale(dc,xcoordLast,ycoordLast, xprecVirt,yprecVirt );
       setrop2(dc,r2_copypen);
       HHDC.Repaint;

      end;
     end;

     kStato_Testo,kStato_TestoRuotato,kStato_TestoRotoScalato : begin
      case fasecomando of
       0 : begin
        dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not); DisTestoVirtuale(dc,0,xprecVirt,yprecVirt,1.0,0.0);
         xprecVirt := xcord;    yprecVirt := ycord;
         DisTestoVirtuale(dc,0,xprecVirt,yprecVirt,1.0,0.0);
          setrop2(dc,r2_copypen);
        HHDC.Repaint;
       end;
       1 : begin
        angloc :=  angolo2vertici(x1coord,y1coord,xcord,ycord);
        dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not); DisTestoVirtuale(dc,0,x1coord,y1coord,1.0,angmom);
        angmom := angloc;
          DisTestoVirtuale(dc,0,x1coord,y1coord,1.0,angloc);
           setrop2(dc,r2_copypen);
        HHDC.Repaint;
       end;
       2 : begin
        angloc :=  angolo2vertici(x1coord,y1coord,x2coord,y2coord);
        scaloc :=  parahTesto*distsemplicefunz(x1coord,y1coord,xcord,ycord)/ altezzatesto_InInserimento;
        dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not); DisTestoVirtuale(dc,0,x1coord,y1coord,scamom,angmom);
        scamom := scaloc;
          DisTestoVirtuale(dc,0,x1coord,y1coord,scamom,angloc);
           setrop2(dc,r2_copypen);
        HHDC.Repaint;
       end;
      end;
     end;

       kStato_Simbolo, kStato_SimboloRot,  kStato_SimboloRotSca    : begin
        case fasecomando of
         0 : begin
            dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not); DisSimboloVirtuale(dc,0,xprecVirt,yprecVirt,1.0,0.0);
             xprecVirt := xcord;    yprecVirt := ycord;
             DisSimboloVirtuale(dc,0,xprecVirt,yprecVirt,1.0,0.0);
             setrop2(dc,r2_copypen);
            HHDC.Repaint;
         end;
         1 : begin
          angloc :=  angolo2vertici(x1coord,y1coord,xcord,ycord);
            dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not); DisSimboloVirtuale(dc,0,x1coord,y1coord,1.0,angmom);
             angmom := angloc;
             DisSimboloVirtuale(dc,0,x1coord,y1coord,1.0,angmom);
             setrop2(dc,r2_copypen);
            HHDC.Repaint;
         end;
         2 : begin
          angloc :=  angolo2vertici(x1coord,y1coord,x2coord,y2coord);
          scaloc :=  distsemplicefunz(x1coord,y1coord,xcord,ycord)/8;
            dc  := HHDC.Bitmap.Handle; setrop2(dc,r2_not); DisSimboloVirtuale(dc,0,x1coord,y1coord,scamom,angmom);
            scamom := scaloc;
            DisSimboloVirtuale(dc,0,x1coord,y1coord,scamom,angmom);
             setrop2(dc,r2_copypen);
            HHDC.Repaint;
         end;
        end;
       end;

        kStato_DefStampa : begin
          if  primovirtRetstampa then
           begin xmom:=x;   ymom:=y;  primovirtRetstampa := false; end
            else
           begin
            dc  := HHDC.Bitmap.Handle;                                                        setrop2(dc,r2_not);
            xcentroschermo := xOrigineVista +Xmom*scalavista ;
            ycentroschermo := yOrigineVista +Ymom*scalavista ;
            x1virt := Xinschermo(xcentroschermo-dimxStampaVir/2);    y1virt := Yinschermo(ycentroschermo-dimyStampaVir/2);
            x2virt := Xinschermo(xcentroschermo+dimxStampaVir/2);    y2virt := Yinschermo(ycentroschermo-dimyStampaVir/2);
            x3virt := Xinschermo(xcentroschermo+dimxStampaVir/2);    y3virt := Yinschermo(ycentroschermo+dimyStampaVir/2);
            x4virt := Xinschermo(xcentroschermo-dimxStampaVir/2);    y4virt := Yinschermo(ycentroschermo+dimyStampaVir/2);
            movetoEx(dc,round(x1virt),round(y1virt),nil); lineto(dc,round(x2virt),round(y2virt));
            lineto(dc,round(x3virt),round(y3virt)); lineto(dc,round(x4virt),round(y4virt));
            lineto(dc,round(x1virt),round(y1virt));
            xmom:=x;   ymom:=y;
            xcentroschermo := xOrigineVista +Xmom*scalavista ;
            ycentroschermo := yOrigineVista +Ymom*scalavista ;
            x1virt := Xinschermo(xcentroschermo-dimxStampaVir/2);    y1virt := Yinschermo(ycentroschermo-dimyStampaVir/2);
            x2virt := Xinschermo(xcentroschermo+dimxStampaVir/2);    y2virt := Yinschermo(ycentroschermo-dimyStampaVir/2);
            x3virt := Xinschermo(xcentroschermo+dimxStampaVir/2);    y3virt := Yinschermo(ycentroschermo+dimyStampaVir/2);
            x4virt := Xinschermo(xcentroschermo-dimxStampaVir/2);    y4virt := Yinschermo(ycentroschermo+dimyStampaVir/2);
            movetoEx(dc,round(x1virt),round(y1virt),nil); lineto(dc,round(x2virt),round(y2virt));
            lineto(dc,round(x3virt),round(y3virt)); lineto(dc,round(x4virt),round(y4virt));
            lineto(dc,round(x1virt),round(y1virt));
            setrop2(dc,r2_copypen);
            HHDC.Repaint;
           end;
        end;



  end;
end;


procedure   TProgetto.caricadefsimboli;
var locListaDefSimboli : TListaDefSimboli;
begin
  if FileExists('.\setup\DefSymbols.dxf') then
   begin
    locListaDefSimboli := TListaDefSimboli.create;
//    locListaDefSimboli.nomelista:=Uppercase('DefSymbols');
    LelisteDefSimboli.add(locListaDefSimboli);
    locListaDefSimboli.apri('.\setup\DefSymbols.dxf');
 //   showmessage(IntToStr(locListaDefSimboli.listaDefinizioni.Count));
   end;
end;


procedure   TProgetto.IniziaComando (newcomando :  Tipocomando);
begin
//  AzzeraComandoPrecedente;
  comando := newcomando;   fasecomando :=0;
  AggiornaInterfaceComandoAzione(comando,fasecomando);
end;

function   TProgetto.DisegnoVCorrente: TDisegnoV;
var resulta : TDisegnoV;
begin
 resulta := nil;
 if ((indDisVcorrente>=0) and (indDisVcorrente<ListadisegniV.count)) then
  begin  resulta := ListadisegniV.Items[indDisVcorrente]; end;
 result := resulta;
end;

function   TProgetto.DisegnoRCorrente: TDisegnoR;
var resulta : TDisegnoR;
begin
 resulta := nil;
// if ((indDisRCorrente>=0) and (indDisRcorrente<ListadisegniR.count)) then
//  begin  resulta := ListadisegniR.Items[indDisRcorrente]; end;
 result := resulta;
end;

function   TProgetto.PianoVCorrente: TPiano;
var resulta : TPiano;
    locdisV : TDisegnoV;
begin
 resulta := nil;
 locdisV := DisegnoVCorrente;
 if locdisV<>nil then
  begin
   if ((locdisV.indPianocorrente>=0) and (locdisV.indPianocorrente<locdisV.ListaPiani.Count)) then
    begin resulta  := locdisV.ListaPiani.Items[locdisV.indPianocorrente];  end;
  end;
 result := resulta;
end;


procedure  TProgetto.cambiadisegnocorrente(indice : Integer);
begin
 indDisVcorrente := indice;
// VCorrente := DisegnoVCorrente;
 if DisegnoVCorrente.indPianocorrente<DisegnoVCorrente.ListaPiani.count then
  PianoCorrente := DisegnoVCorrente.ListaPiani[DisegnoVCorrente.indPianocorrente];
 ridisegnaInterfaccia;
end;

procedure  TProgetto.cambiaPianocorrente(indice : Integer);
var locdis : TDisegnoV;
begin
 locdis := ListadisegniV.Items[indDisVcorrente];
 locdis.indPianocorrente  := indice;
 PianoCorrente := DisegnoVCorrente.ListaPiani[DisegnoVCorrente.indPianocorrente];
 ridisegnaInterfaccia;
end;


procedure   TProgetto.Vista_Zoompiu;
begin
 zoomPiu_Meno_0_1(0);       // uViste;
end;

procedure   TProgetto.Vista_Zoommeno;
begin
 zoomPiu_Meno_0_1(1);       // uViste;
end;



procedure   TProgetto.Vista_ZoomTutto;
var
	    apted : Boolean ;
	    locdisras : TDisegnoGR;
      i : Integer;
  	  locdisvet : TDisegnoV;

      var	x1, y1, x2, y2, dx, dy, scal : Real;
      k : Integer; LocGR : TDisegnoGR;

begin
 apted   := false;       x1:=0; x2 :=0;

  if ((IlCatastoV.QUnione<>nil) and ( (IlCatastoV.vedoQU) or (IlCatastoV.vedoCXF)) ) then
   begin
 	  apted:=true;
  	x1 :=IlCatastoV.QUnione.limx1;
   	y1 :=IlCatastoV.QUnione.limy1;
  	x2 :=IlCatastoV.QUnione.limx2;
  	y2 :=IlCatastoV.QUnione.limy2;
   end;




	for i:=0  to ListaDisegniGR.count-1 do
   begin
    LocGR := IlProgetto.ListaDisegniGR.Items[i];
    if LocGR.IsKool then LocGR.updateLimiti;

		if not(LocGR.visibile) then continue;
		if not(apted) then
     begin
      x1 := LocGR.limx1;  x2 := LocGR.limx2;
      y1 := LocGR.limy1;  y2 := LocGR.limy2;
  	  apted:=true;
     end
      else
     begin
      if x1<LocGR.limx1 then x1 := LocGR.limx1;
      if x2>LocGR.limx2 then x2 := LocGR.limx2;
      if y1<LocGR.limy1 then y1 := LocGR.limy1;
      if y2>LocGR.limy2 then y2 := LocGR.limy2;
     end;
   end;




	for i:=0  to ListaDisegniV.count-1 do begin
		locdisvet := ListaDisegniV.Items[i];
		if not(locdisvet.b_visibile) then continue;
		locdisvet.faiLimiti;
		if not(apted) then begin
			if (locdisvet.limx1<locdisvet.limx2) then
       begin
 			  x1 := locdisvet.limx1;			y1 := locdisvet.limy1;
			  x2 := locdisvet.limx2;			y2 := locdisvet.limy2;
			  apted:=true;
       end;
    end
		 else begin
			if (locdisvet.limx1<locdisvet.limx2) then
       begin
  			if (x1 >locdisvet.limx1)  then    x1 :=locdisvet.limx1;
   			if (y1 >locdisvet.limy1)  then    y1 :=locdisvet.limy1;
  			if (x2 <locdisvet.limx2)  then    x2 :=locdisvet.limx2;
  			if (y2 <locdisvet.limy2)  then    y2 :=locdisvet.limy2;
       end;
    end;
  end;


	for i:=0  to LeConcessioniV.listaDisegni.count-1 do begin
		locdisvet := LeConcessioniV.listaDisegni.Items[i];
		if not(locdisvet.b_visibile) then continue;
		locdisvet.faiLimiti;
		if not(apted) then begin
			if (locdisvet.limx1<locdisvet.limx2) then
       begin
 			  x1 := locdisvet.limx1;			y1 := locdisvet.limy1;
			  x2 := locdisvet.limx2;			y2 := locdisvet.limy2;
			  apted:=true;
       end;
    end
		 else begin
			if (locdisvet.limx1<locdisvet.limx2) then
       begin
  			if (x1 >locdisvet.limx1)  then    x1 :=locdisvet.limx1;
   			if (y1 >locdisvet.limy1)  then    y1 :=locdisvet.limy1;
  			if (x2 <locdisvet.limx2)  then    x2 :=locdisvet.limx2;
  			if (y2 <locdisvet.limy2)  then    y2 :=locdisvet.limy2;
       end;
    end;
  end;

	if (not apted) then
    begin
     if Ilprogetto.vedoterreno then
      begin
      if ((LimTerx1<>limTerx2) and (LimTery1<>limTery2)) then
       begin
        x1 := LimTerx1;  x2 := LimTerx2;
        y1 := LimTery1;  y2 := LimTery2;
       end;
      end else exit;
    end;


 	xprezoomw := xorigineVista;	yprezoomw := yorigineVista;	sprezoomw := scalaVista;
  setLimitiTutto(x1, y1, x2, y2);
  zoomTutto;
end;


procedure   TProgetto.Vista_ZoomTuttosePrimo;
var conta : Integer;
begin
 conta :=0;
 if vedoterreno then inc(conta);
 if ((IlCatastoV.ListaCXF.count>0) or (IlCatastoV.QUnione<>nil)) then inc(conta);
 if (LeConcessioniV.listaDisegni.count>0) then inc(conta);
 conta := conta+ListaDisegniV.count-1;
 conta := conta+ListaDisegniGR.count;
 if conta=1 then Vista_ZoomTutto;
// showmessage(intTostr(conta));
end;


procedure   TProgetto.Vista_ZoomUltima;
begin
 xorigineVista := xprezoomw;
 yorigineVista := yprezoomw;
 scalavista    := sprezoomw;
 ridisegna;
end;

procedure   TProgetto.Vista_ZoomCentro;
begin

end;

procedure   TProgetto.ZoomAllRaster;
begin
 setZoomAllRaster;
 ridisegna;
end;

procedure   TProgetto.ZoomLocRaster;
begin

end;

procedure   TProgetto.ZoomGRCorrente;
var	 dx, dy, scal : Real;
begin
 if GRCorrente= nil then exit;
 GRCorrente.updateLimiti;
	dx  := GRCorrente.limx2-GRCorrente.limx1;	dy  := GRCorrente.limy2-GRCorrente.limy1;
  scalaVista    := dx/ Mainform.BaseSchermo.Width;
  scal          := dy/ Mainform.BaseSchermo.Height;
	set_scalaVista2 (scalaVista,scal);
	setZoomC    (((GRCorrente.limx1+GRCorrente.limx2)/2)  , ((GRCorrente.limy1+GRCorrente.limy2)/2)  );
end;

procedure   TProgetto.ZoomRCorrente;
var	 dx, dy, scal : Real;
begin
 if RCorrente= nil then exit;
 RCorrente.updateLimiti;
	dx  := RCorrente.limx2-RCorrente.limx1;	dy  := RCorrente.limy2-RCorrente.limy1;
  scalaVista    := dx/ Mainform.BaseSchermo.Width;
  scal          := dy/ Mainform.BaseSchermo.Height;
	set_scalaVista2 (scalaVista,scal);
	setZoomC    (((RCorrente.limx1+RCorrente.limx2)/2)  , ((RCorrente.limy1+RCorrente.limy2)/2)  );
end;


procedure   TProgetto.ZoomDisegno;
begin

end;

procedure   TProgetto.ZoomPianoCorrente;
begin

end;

procedure   TProgetto.ZoomAll;
begin

end;

procedure   TProgetto.ZoomC              (newx, newy : Real);
begin

end;

procedure   TProgetto.DisegnaVirtuale                   ( x1, y1, x2, y2 : Integer);
begin

end;

procedure   TProgetto.DisegnaCerchioVirtuale            (dc:hdc; x1, y1, x2, y2 : Integer);
var k : Integer;
    rag : Real;
begin
 rag := distsemplicefunz(x1,y1,x2,y2);
 MoveToEx(dc,x1,round(y1+rag) ,nil);
 for k := 0 to 63 do begin
   Lineto(dc,x1 + round(rag * _sin64[k]), y1+round(rag*_cos64[k]));
 end;
 LineTo(dc,x1,round(y1+rag));
end;

procedure   TProgetto.DisegnaquadroVirtuale             ( x1, y1, x2, y2 : Integer);
begin

end;

procedure   TProgetto.DisegnaPan                        ( dx, dy : real);
begin

end;

Function    TProgetto.SnappaGriglia                     ( xc, yc : real): Boolean;
begin
 result := false;
end;


procedure   TProgetto.DisSpostaVirtuale                 (dc:hdc;  x1, y1 ,xm, ym : real);
var dx,dy : real;
    i : Integer;
    objvector : Tvettoriale;
begin
  	dx := xm-x1;	dy := ym-y1;
  	for i:=0 to ListaSelezionati.count-1 do begin
  		objvector := ListaSelezionati.items[i];
  		objvector.DisegnaAffineSpo(dc,dx,dy);
    end;
end;

procedure   TProgetto.DisCopiaVirtuale                  (dc:hdc; x1, y1 ,xm, ym : real);
var dx,dy : real;
    i : Integer;
    objvector : Tvettoriale;
begin
  	dx := xm-x1;	dy := ym-y1;
  	for i:=0 to ListaSelezionati.count-1 do begin
  		objvector := ListaSelezionati.items[i];
  		objvector.DisegnaAffineSpo(dc,dx,dy);
    end;
end;

procedure   TProgetto.DisRuotaVirtuale                  (dc:hdc; x1, y1 ,xm, ym : real);
var dx,dy,angrot : real;
    i : Integer;
    objvector : Tvettoriale;
begin
	dx := xm-x1;	dy := ym-y1;
	if ((dx=0)  and (dy=0)) then exit;
	if (dx=0) then begin  angrot := PI/2;               if (dy<0) then angrot := angrot+PI;  end
            else begin  angrot := arctan( dy / dx );  if (dx<0) then angrot := PI+angrot; if (angrot<0) then angrot := angrot + 2*PI;	end;
 	for i:=0 to ListaSelezionati.count-1 do begin
 		objvector := ListaSelezionati.items[i];
 		objvector.DisegnaAffineRot(dc,x1,y1,angrot);
  end;
end;



procedure   TProgetto.DisScalaVirtuale                  (dc:hdc; x1, y1 ,xm, ym : real);
var dx,dy, scal , dd : real;
    i : Integer;
    objvector : Tvettoriale;
begin
    dd := distsemplicefunz(x1,y1,xm,ym);
  	if (dd=0) then exit;
  	dd   := (dd / scalaVista);
  	scal := (dd / Hschermo)*10;
  	dx := xm-x1;	dy := ym-y1;
  	for i:=0 to ListaSelezionati.count-1 do begin
  		objvector := ListaSelezionati.items[i];
  		objvector.DisegnaAffineSca(dc,x1,y1,scal);
    end;
end;




procedure   TProgetto.DisSpostaDisegno                  ( x1, y1 ,xm, ym : real);
begin

end;

procedure   TProgetto.DisRuotaDisegno                   ( xc, yc ,xm, ym : real);
begin

end;

procedure   TProgetto.DisScalaDisegno                   ( xc, yc ,xm, ym : real);
begin

end;

procedure   TProgetto.DisSimbolovirtualeang             ( angrot : Real);
begin

end;

procedure   TProgetto.DisSimbolovirtualesca             ( parscal : Real);
begin

end;

procedure   TProgetto.DisSimboloVirtuale                (dc:hdc; fase:integer; xc, yc ,sc, ang : real);
var paralungcar : Real;
    x1,y1 : real;
    x2,y2 : real;
    x3,y3 : real;
    x4,y4 : real;
    xt, yt : Real;
    recSca : Real;
begin
  paralungcar := 8.0;
  recSca := sc ;
  xt := xc+simboloVirtuale.limx1*paralungcar;
  yt := yc+simboloVirtuale.limy1*paralungcar;
  Rotoscalacentra ( xc , yc , Ang, sc, xt, yt, x1, y1 );

  xt := xc+simboloVirtuale.limx2*paralungcar;
  yt := yc+simboloVirtuale.limy1*paralungcar;
  Rotoscalacentra ( xc , yc , Ang, sc, xt, yt, x2, y2 );

  xt := xc+simboloVirtuale.limx2*paralungcar;
  yt := yc+simboloVirtuale.limy2*paralungcar;
  Rotoscalacentra ( xc , yc , Ang, sc, xt, yt, x3, y3 );

  xt := xc+simboloVirtuale.limx1*paralungcar;
  yt := yc+simboloVirtuale.limy2*paralungcar;
  Rotoscalacentra ( xc , yc , Ang, sc, xt, yt, x4, y4 );

  movetoEx(dc,round(Xinschermo(x1)),round(Yinschermo(y1)),nil);
   lineto(dc,round(Xinschermo(x2)),round(Yinschermo(y2)));
   lineto(dc,round(Xinschermo(x3)),round(Yinschermo(y3)));
   lineto(dc,round(Xinschermo(x4)),round(Yinschermo(y4)));
   lineto(dc,round(Xinschermo(x1)),round(Yinschermo(y1)));


end;


procedure   TProgetto.DisTestoVirtuale                  (dc:hdc;fase:integer; xc, yc ,sc, ang : real);
var paralungcar : Real;
    x2,y2 : real;
    x3,y3 : real;
    x4,y4 : real;
    llx , lly : real;
    recSca : Real;
begin
  recSca := sc ;
  paralungcar := length(testoTxt_InInserimento)*0.5;
  llx := paralungcar*(altezzatesto_InInserimento/parahTesto);
  lly := altezzatesto_InInserimento/parahTesto;
  x2 := xc+llx*cos(ang)*recSca;
  y2 := yc+llx*sin(ang)*recSca;

  x3 := x2-lly*sin(ang)*recSca;
  y3 := y2+lly*cos(ang)*recSca;

  x4 := xc-lly*sin(ang)*recSca;
  y4 := yc+lly*cos(ang)*recSca;

  movetoEx(dc,round(Xinschermo(xc)),round(Yinschermo(yc)),nil);
   lineto(dc,round(Xinschermo(x2)),round(Yinschermo(y2)));
   lineto(dc,round(Xinschermo(x3)),round(Yinschermo(y3)));
   lineto(dc,round(Xinschermo(x4)),round(Yinschermo(y4)));
   lineto(dc,round(Xinschermo(xc)),round(Yinschermo(yc)));
end;

procedure   TProgetto.DisDoppiaVirtual                  (dc:hdc;modo : Integer;  xm, ym: Integer);
var	 a, b   : TVertice;
begin
	if (modo=1) then begin a:=ListaEditvt.Items[2]; b:=ListaEditvt.items[3];	end
              else begin a:=ListaEditvt.items[4]; b:=ListaEditvt.items[5];  end;
  movetoEx(dc,round(Xinschermo(a.x)),round(Yinschermo(a.y)),nil); lineto(dc,xmom,hSchermo-ymom);
  if b<>a then begin movetoEx(dc,round(Xinschermo(b.x)),round(Yinschermo(b.y)),nil); lineto(dc,xmom,hSchermo-ymom); end;
end;

procedure   TProgetto.DisDoppiaVirtualCivico             (dc:hdc;modo : Integer;  xm, ym: Integer);
begin
 case modo of
  1 : begin
    movetoEx(dc,round(Xinschermo(CivicoinEdit.x2c)),round(Yinschermo(CivicoinEdit.y2c)),nil); lineto(dc,xmom,hSchermo-ymom);
  end;
  2 :  begin
    movetoEx(dc,round(Xinschermo(CivicoinEdit.x1c)),round(Yinschermo(CivicoinEdit.y1c)),nil); lineto(dc,xmom,hSchermo-ymom);
    movetoEx(dc,round(Xinschermo(CivicoinEdit.x3c)),round(Yinschermo(CivicoinEdit.y3c)),nil); lineto(dc,xmom,hSchermo-ymom);
  end;
  3 : begin
    movetoEx(dc,round(Xinschermo(CivicoinEdit.x2c)),round(Yinschermo(CivicoinEdit.y2c)),nil); lineto(dc,xmom,hSchermo-ymom);
  end;

 end;


end;


procedure   TProgetto.MouseDown(HHDC : TImage32;Button: Integer; Sh: TShiftState; x1,y1 : Integer);
begin
 xmom :=x1; ymom:=y1;
    if Button = 0 then // SX
     begin
       ilProgetto.LeftMouse(HHDC ,Sh   ,X1,Y1);
     end;
    if Button = 1 then  // DX
     begin
       ilProgetto.RigthMouse(HHDC ,Sh   ,X1,Y1);
     end;
    if Button = 2 then   // medio
     begin
      ilProgetto.MiddleMouseDown(HHDC ,Sh   ,X1,Y1);
     end;

  AggiornaInterfaceComandoAzione(comando,fasecomando);

end;


procedure  TProgetto.NuovoDisegno;
var locDisegnoV : TDisegnoV;
begin
 locDisegnoV   := TDisegnoV.create;
 locDisegnoV.nomedisegno := locDisegnoV.nomedisegno+'_'+IntToStr(indDisVcorrente);
 ListaDisegniV.Add(locDisegnoV);
 indDisVcorrente :=ListaDisegniV.count-1;
 cambiadisegnocorrente(indDisVcorrente);
end;


// raster
procedure TProgetto.TogliGRCorrente;
begin
 if IlProgetto.GRCorrente<>nil then
  begin
   if ((indDisGRcorrente>=0) and (indDisGRcorrente<ListaDisegniGR.count)) then
    begin
     GRCorrente := ListaDisegniGR.items[indDisGRcorrente];
     Interf_ToltoDisegnoR(GRCorrente.NomeconDir);
     ListaDisegniGR.delete(indDisGRcorrente);
     GRCorrente.svuota;
     GrCorrente.Free;
     GrCorrente := nil;
     dec(indDisGRcorrente);
     if ((indDisGRcorrente<0) and (ListaDisegniGR.count>0)) then inc(indDisGRcorrente);

     if indDisGRcorrente>=0 then
      begin
       GRCorrente := ListaDisegniGR.items[indDisGRcorrente];
      end;
     ridisegnaInterfaccia;
    end;
  end;
end;

procedure  TProgetto.SalvaInfoCorrenteGR;
begin
 if GRCorrente<>nil then
  begin
   GRCorrente.salvaCollaterale;
  end;
end;


procedure  TProgetto.SalvaInfoTuttiGR;
var k : Integer;
    locGR : TDisegnoGR;
begin
 for k:=0 to ListaDisegniGR.Count-1 do
  begin
   locGR := ListaDisegniGR.items[k];
   locGR.salvaCollaterale;
  end;
end;

procedure  TProgetto.SalvaImmobiliDati;
begin
 if NomefileAnagrafe<>'' then LaAnagrafe.salva(NomefileAnagrafe);
 GliImmobiliDati.salvatutto;
end;


procedure  TProgetto.CambiaGRcorrente(indice:Integer);
begin
   if ((indice>=0) and (indice<ListaDisegniGR.count)) then
    begin
     GRCorrente := ListaDisegniGR.items[indice];
     indDisGRcorrente := indice;
     ridisegnaInterfaccia;
    end;
end;


procedure  TProgetto.updateScalaGR(sca : real);
begin
 if GRCorrente= nil then exit;
 if ((GRCorrente.xcRot=0.0) and (GRCorrente.ycRot= 0.0)) then
  begin  exit; end;
 GRCorrente.scalaGR := sca/1000;
 GRCorrente.elaborataScaAng_012 :=1;
 GRCorrente.updateScalaSubraster;
 ridisegna;
end;

procedure  TProgetto.updateScalaV(sca : Integer);
begin
 if DisegnoVCorrente= nil then exit;
 if ((DisegnoVCorrente.eventuale_xc=0.0) and (DisegnoVCorrente.eventuale_xc= 0.0)) then begin  exit; end;
 DisegnoVCorrente.ScalaDaBarra(sca);
 ridisegna;
end;

procedure  TProgetto.updateDisegnoVRot(newrot : Integer);
begin
 if DisegnoVCorrente= nil then exit;
 if ((DisegnoVCorrente.eventuale_xc=0.0) and (DisegnoVCorrente.eventuale_xc= 0.0)) then begin  exit; end;
 DisegnoVCorrente.RuotaDaBarra(newrot);
 ridisegna;
end;


procedure  TProgetto.updateDisegnoVSpoX(newx : Integer);
begin
 if DisegnoVCorrente= nil then exit;
 if ((DisegnoVCorrente.eventuale_xc=0.0) and (DisegnoVCorrente.eventuale_xc= 0.0)) then begin  exit; end;
 DisegnoVCorrente.SpostaXDaBarra(newX);
 ridisegna;
end;

procedure  TProgetto.updateDisegnoVSpoY(newy : Integer);
begin
 if DisegnoVCorrente= nil then exit;
 if ((DisegnoVCorrente.eventuale_xc=0.0) and (DisegnoVCorrente.eventuale_xc= 0.0)) then begin  exit; end;
 DisegnoVCorrente.SpostaYDaBarra(newY);
 ridisegna;
end;


procedure  TProgetto.RasExParamSca2mezzi(modo : Integer);
var d1,d2 : Integer;
begin
 if GRCorrente= nil then exit;
  with mainform.Gau_ScalaGR do
   begin
    d1  := position-min;    d2  := max-position;
    case modo of
     -1 : begin GrCorrente.minGauSca := position - ((d1*2) div 3);
                GrCorrente.maxGauSca := position + ((d2*2) div 3);  end;
      1 : begin GrCorrente.minGauSca := position - ((d1*3) div 2);
                GrCorrente.maxGauSca := position + ((d2*3) div 2);  end;
    end;
//    if position> GrCorrente.maxGauSca then GrCorrente.maxGauSca:=mainform.Gau_ScalaGR.position;
//    if position< GrCorrente.minGauSca then GrCorrente.minGauSca:=mainform.Gau_ScalaGR.position;
    min := GrCorrente.minGauSca;
    max := GrCorrente.maxGauSca;
   end;
//  ricentraScaGR;
end;

procedure  TProgetto.RasExParamRot2mezzi(modo : Integer);
var d1,d2 : Integer;
begin
 if GRCorrente= nil then exit;
  with mainform.Gau_RotGR do
   begin
    d1  := position-min;    d2  := max-position;
    case modo of
     -1 : begin GrCorrente.minGauRot := position - ((d1*2) div 3);
                GrCorrente.maxGauRot := position + ((d2*2) div 3);  end;
      1 : begin GrCorrente.minGauRot := position - ((d1*3) div 2);
                GrCorrente.maxGauRot := position + ((d2*3) div 2);  end;
    end;
//  if mainform.Gau_RotGR.position> GrCorrente.maxGauRot then GrCorrente.maxGauRot:=mainform.Gau_RotGR.position;
//  if mainform.Gau_RotGR.position< GrCorrente.minGauRot then GrCorrente.minGauRot:=mainform.Gau_RotGR.position;
    min := GrCorrente.minGauRot;
    max := GrCorrente.maxGauRot;
   end;
//  ricentraRotGR;
end;

procedure   TProgetto.VectParamSca2mezzi(modo : Integer);
var d1,d2 : Integer;
    locmin, locmax : Integer;
begin
 if DisegnoVCorrente = nil then exit;
  with mainform.Gau_ScaV do
   begin
    d1  := position-min;    d2  := max-position;
    case modo of
     -1 : begin locmin := position - ((d1*2) div 3);   locmax := position + ((d2*2) div 3);  end;
      1 : begin locmin := position - ((d1*3) div 2);   locmax := position + ((d2*3) div 2);  end;
    end;
    min := locmin;    max := locmax;
   if DisegnoVCorrente<>nil then
    begin
     DisegnoVCorrente.minGauSca := min;
     DisegnoVCorrente.maxGauSca := max;
     DisegnoVCorrente.laPosSca  := position;
    end;
   end;
end;


procedure   TProgetto.VectParamSpoX2mezzi(modo : Integer);
var d1,d2 : Integer;
    locmin, locmax : Integer;
begin
 if DisegnoVCorrente = nil then exit;
  with mainform.Gau_SpoXV do
   begin
    d1  := position-min;    d2  := max-position;
    case modo of
     -1 : begin locmin := position - ((d1*2) div 3);   locmax := position + ((d2*2) div 3);  end;
      1 : begin locmin := position - ((d1*3) div 2);   locmax := position + ((d2*3) div 2);  end;
    end;
    min := locmin;    max := locmax;
   if DisegnoVCorrente<>nil then
    begin
     DisegnoVCorrente.minGauSpoY := min;
     DisegnoVCorrente.maxGauSpoY := max;
     DisegnoVCorrente.laPosSpoY  := position;
    end;
   end;
end;

procedure   TProgetto.VectParamSpoY2mezzi(modo : Integer);
var d1,d2 : Integer;
    locmin, locmax : Integer;
begin
 if DisegnoVCorrente = nil then exit;
  with mainform.Gau_SpoYV do
   begin
    d1  := position-min;    d2  := max-position;
    case modo of
     -1 : begin locmin := position - ((d1*2) div 3);   locmax := position + ((d2*2) div 3);  end;
      1 : begin locmin := position - ((d1*3) div 2);   locmax := position + ((d2*3) div 2);  end;
    end;
    min := locmin;    max := locmax;
   if DisegnoVCorrente<>nil then
    begin
     DisegnoVCorrente.minGauSpoX := min;
     DisegnoVCorrente.maxGauSpoX := max;
     DisegnoVCorrente.laPosSpoX  := position;
    end;
   end;
end;


procedure   TProgetto.VectParamRot2mezzi(modo : Integer);
var d1,d2 : Integer;
    locmin, locmax : Integer;
begin
 if DisegnoVCorrente = nil then exit;
  with mainform.Gau_RotV do
   begin
    d1  := position-min;    d2  := max-position;
    case modo of
     -1 : begin locmin := position - ((d1*2) div 3);   locmax := position + ((d2*2) div 3);  end;
      1 : begin locmin := position - ((d1*3) div 2);   locmax := position + ((d2*3) div 2);  end;
    end;
    min := locmin;    max := locmax;
   if DisegnoVCorrente<>nil then
    begin
     DisegnoVCorrente.minGauRot := min;
     DisegnoVCorrente.maxGauRot := max;
     DisegnoVCorrente.laPosRot  := position;
    end;
   end;
end;


procedure  TProgetto.updateRasExParam;
var d1,d2 : Integer;
begin
 if GRCorrente= nil then exit;

 GRCorrente.elaborataScaAng_012 :=0;

 GrCorrente.UpdateExParam;


  with mainform.Gau_RotGR do
  begin
   d1  := position-min;
   d2  := max-position;
   min := -d1;
   max := d2;
   GrCorrente.angoloGR  := 0.0;
   position             :=   0;
   GrCorrente.minGauRot := min;
   GrCorrente.maxGauRot := max;
   update;
  end;

  with mainform.Gau_ScalaGR do
  begin
   d1  := position-min;
   d2  := max-position;
   min := 1000-d1;
   max := 1000+d2;
   GrCorrente.scalaGR   := 1.0;
   position             := 1000;
   GrCorrente.minGauSca := min;
   GrCorrente.maxGauSca := max;
   update;
  end;

end;


procedure  TProgetto.updateRotGR  (rot : real);
var radRot : Real;
begin
 if GRCorrente= nil then exit;
 if ((GRCorrente.xcRot=0.0) and (GRCorrente.ycRot= 0.0)) then  begin exit; end;

   if GRCorrente.elaborataScaAng_012 = 1 then  begin  updateRasExParam;   end;

   radRot := (rot/1000);
   GRCorrente.angoloGR := radRot;
   GRCorrente.elaborataScaAng_012 :=2;
   GRCorrente.updateRotSubraster;
   GRCorrente.updatelimiti;


 ridisegna;
end;


procedure  TProgetto.OpenInfoTributiAnagrafe;
begin
 OpenAnagrafe;
 GliImmobiliDati.Apri;
end;

procedure  TProgetto.OpenConcessioni;
begin
 if ConcessioniTolfa=nil then
  begin
   ConcessioniTolfa:= TLeConcessioni.create;
  end;
 if Not(ConcessioniTolfa.caricata) then ConcessioniTolfa.apri;
end;


procedure  TProgetto.OpenAnagrafe;
begin
 if Not(LaAnagrafe.caricata) then LaAnagrafe.apri(NomefileAnagrafe);
end;






procedure  TProgetto.deseleziona;
begin
 ListaSelezionati.clear;
end;


procedure   TProgetto.cancellatuttiSelezionati;
var locvet : TVettoriale;
    k : Integer;
begin
 for k:= 0 to ListaSelezionati.count-1 do
  begin
   locvet := ListaSelezionati.items[k];
   locvet.cancella;
  end;
 ListaSelezionati.clear;
end;

procedure  TProgetto.CreareDisegnoStradeDaAnagrafe;
var newdis : TDisegnoV;
    k : integer;
    locfam : TFamiglia;
    x1,y1 : Real;
    locpunto : TPunto;
    newpiano : Tpiano;
begin
 NuovoDisegno;
 newdis := DisegnoVCorrente;
 newdis.nomedisegno := 'Strade_Anagrafe';

 for k:=0 to LaAnagrafe.listaFamiglie.Count-1 do
  begin
   locfam := LaAnagrafe.listaFamiglie.items[k];
   if locfam.Indirizzo<>'' then
    begin
     newdis.addLayerCorrente (locfam.Indirizzo);
     newpiano:= newdis.ListaPiani.Items[newdis.indPianocorrente];
     newpiano.spessoreline :=3 ;
     newpiano.dimpunto :=8 ;
     if locfam.Foglio<>'' then
      begin
       if IlcatastoV.centroedificioFgPart(locfam.Foglio,locfam.Particella, x1 , y1) then
        begin
         locpunto := TPunto.Create;
         locpunto.Initer(newdis,newpiano);
         locpunto.InitPunto(x1,y1);
         newpiano.Listavector.Add(locpunto);
        end;
      end;
    end;
  end;

  newdis.EliminaPuntiDoppiNelPiano;
  newdis.failimiti;
end;


procedure TProgetto.RasterGrUpDownLista(modo,indice : Integer);
var     locGr : TDisegnoGR;
begin
 case modo of
  1 : begin
    ListaDisegniGR.Insert(indice-1,ListaDisegniGR.Items[indice]);
    IlProgetto.ListaDisegniGR.delete(indice+1);
    IlProgetto.CambiaGRcorrente(indice-1);
  end;
  2 : begin
    ListaDisegniGR.Insert(indice+2,ListaDisegniGR.Items[indice]);
    IlProgetto.ListaDisegniGR.delete(indice);
    IlProgetto.CambiaGRcorrente(indice+1);
  end;
 end;
end;

procedure  TProgetto.VectorGrUpDownLista(modo,indice : Integer);
begin
 case modo of
  1 : begin
    ListaDisegniV.Insert(indice-1,ListaDisegniV.Items[indice]);
    IlProgetto.ListaDisegniV.delete(indice+1);
    IlProgetto.cambiadisegnocorrente(indice-1);
  end;
  2 : begin
    ListaDisegniV.Insert(indice+2,ListaDisegniV.Items[indice]);
    IlProgetto.ListaDisegniV.delete(indice);
    IlProgetto.cambiadisegnocorrente(indice+1);
  end;
 end;
end;


procedure TProgetto.Spessore2AiPiani;
var locpiano  : TPiano;
    k : Integer;
begin
 if DisegnoVCorrente<>nil then
  begin
   for k:=0 to DisegnoVCorrente.ListaPiani.Count-1 do
    begin
     locpiano := DisegnoVCorrente.ListaPiani.items[k];
     locpiano.spessoreline := 2;
    end;
  end;
end;



procedure  TProgetto.mettiCiviciCatasto;
var kf ,ks ,j,kc : Integer;

    x1,y1 : Real;
    x2,y2 : Real;
    x3,y3 : Real;
    xt3,yt3 : Real;
    locCiv,locCivT    : TCivico;
    loPiano   : TPiano;
    straPiano : TPiano;
    lastrada : TPolylinea;
    testoCivico : String;
    dd1, ddt : real;
    F : TextFile;
    locfabdat : TFabCatDati;
   locvet     : Tvettoriale;
   locnomestrada : String;

begin
 assignFile(F,'stradeassentiCatasto.txt'); rewrite(F);
 NuovoDisegno;
 DisegnoVCorrente.nomedisegno :='Civici_Catasto';
 loPiano := DisegnoVCorrente.ListaPiani.Items[DisegnoVCorrente.indPianocorrente];
 loPiano._rosso    := 255;
 loPiano._verde    := 0;
 loPiano._Blu      := 255;

 for kf :=0 to GliImmobiliDati.listaFabbricati.Count-1 do
  begin
   locfabdat := GliImmobiliDati.listaFabbricati.items[kf];
   if locfabdat.Residenti.Count>0 then continue;
   if ((locfabdat.Foglio<>'') and (locfabdat.Particella<>'')) then
    begin
     locnomestrada :=locfabdat.Via_Catastale;

     if locfabdat.Civico_Catastale<>'' then testoCivico := locfabdat.Civico_Catastale else testoCivico := '#';
//      begin
       IlCatastoV.centroedificioFgPart(locfabdat.Foglio,locfabdat.Particella,x1,y1);
       locCiv := TCivico.create;
       locCiv.Initer(DisegnoVCorrente,loPiano);

       x3  := x1;   y3  := y1;
       xt3 :=x3;    yt3 := y3;
       if LeStradeV<>nil then
        begin
          for ks:=0 to LestradeV.ListaPiani.Count-1 do
           begin
            straPiano := LestradeV.ListaPiani.items[ks];
            if pos(Uppercase(locfabdat.Via_Catastale),uppercase(straPiano.nomepiano))>0 then
             begin
              for j:=0 to straPiano.Listavector.Count-1 do
               begin
                lastrada := straPiano.Listavector.Items[j];
                if lastrada.tipo=PPlinea then
                 begin
                  lastrada.PosNearesPoly(x1,y1 , xt3, yt3);
                  if ((x3=x1) and (y3=y1)) then
                   begin x3 :=xt3; y3 :=yt3; end else
                   begin
                    dd1 := distsemplicefunz(x1,y1,x3,y3);
                    ddt := distsemplicefunz(x1,y1,xt3,yt3);
                    if (ddt < dd1) then begin  x3 :=xt3; y3 :=yt3; end;
                   end;
                 end;
               end;
             end;
           end;
        end;


      if ((x3=x1) and (y3=y1)) then writeln(F,locfabdat.Via_Catastale);


       x2 := (x1+x3)/2;      y2 := (y1+y3)/2;

       locCiv.InitCivico(x1,y1,x2,y2,x3,y3,testoCivico);
       locCiv.nomestrada := locnomestrada;
       loPiano.Listavector.Add(locCiv);
//      end;
    end;
  end;


// togliciviciDoppi;
 for kc := loPiano.Listavector.Count-1 downto 1 do
  begin
   locvet     := loPiano.Listavector.items[kc];
   if locvet.b_erased then continue;
   if locvet.tipo<>PCivico then continue;
   locCiv := loPiano.Listavector.items[kc];
   for j := kc-1 downto 0 do
    begin
     locvet     := loPiano.Listavector.items[j];
     if locvet.tipo<>PCivico then continue;
     locCivT := loPiano.Listavector.items[j];
     if ( (locCiv.x1c=locCivT.x1c) and  (locCiv.y1c=locCivT.y1c) and
          (locCiv.x2c=locCivT.x2c) and  (locCiv.y2c=locCivT.y2c) and
          (locCiv.x3c=locCivT.x3c) and  (locCiv.y3c=locCivT.y3c) and
          (locCiv.txtciv=locCivT.txtciv) and
          (locCiv.nomestrada=locCivT.nomestrada)
         ) then locCivT.b_erased := true;
    end;
  end;


 DisegnoVCorrente.faiLimiti;
 ridisegnaInterfaccia;
 closefile(F);
end;



procedure  TProgetto.mettiCiviciAnagrafe;
var kf ,ks ,j,kc : Integer;
    locfam : TFamiglia;
    x1,y1 : Real;
    x2,y2 : Real;
    x3,y3 : Real;
    xt3,yt3 : Real;
    locCiv    : TCivico;
    locCivT   : TCivico;
    loPiano   : TPiano;
    straPiano : TPiano;
    lastrada : TPolylinea;
    testoCivico : String;
    dd1, ddt : real;
    F : TextFile;
   locvet     : Tvettoriale;
   locnomestrada : String;

begin
 Form_TestInfo.ListBox1.Clear;
// assignFile(F,'stradeassenti.txt'); rewrite(F);
 NuovoDisegno;
 DisegnoVCorrente.nomedisegno :='Civici';
 DisegnoVCorrente.addLayerCorrente('Anagrafe');
 loPiano := DisegnoVCorrente.ListaPiani.Items[DisegnoVCorrente.indPianocorrente];
 loPiano._rosso    := 255;
 loPiano._verde    := 255;
 loPiano._Blu      := 0;

 cambiadisegnocorrente(indDisVcorrente);


 for kf :=0 to LaAnagrafe.listaFamiglie.Count-1 do
  begin
   locfam := LaAnagrafe.listaFamiglie.items[kf];
   if ((locfam.Foglio<>'') and (locfam.Particella<>'')) then
    begin
     if locfam.civico<>'' then testoCivico := locfam.civico else testoCivico := '#';
//      begin
       IlCatastoV.centroedificioFgPart(locfam.Foglio,locfam.Particella,x1,y1);
       locCiv := TCivico.create;
       locCiv.Initer(DisegnoVCorrente,loPiano);
       locnomestrada :=locfam.Indirizzo;
       x3  := x1;   y3  := y1;
       xt3 :=x3;    yt3 := y3;
       if LeStradeV<>nil then
        begin
          for ks:=0 to LestradeV.ListaPiani.Count-1 do
           begin
            straPiano := LestradeV.ListaPiani.items[ks];
            if pos(Uppercase(locfam.Indirizzo),uppercase(straPiano.nomepiano))>0 then
             begin
              for j:=0 to straPiano.Listavector.Count-1 do
               begin
                lastrada := straPiano.Listavector.Items[j];
                if lastrada.tipo=PPlinea then
                 begin
                  lastrada.PosNearesPoly(x1,y1 , xt3, yt3);
                  if ((x3=x1) and (y3=y1)) then
                   begin x3 :=xt3; y3 :=yt3;  locnomestrada := straPiano.nomepiano; end else
                   begin
                    dd1 := distsemplicefunz(x1,y1,x3,y3);
                    ddt := distsemplicefunz(x1,y1,xt3,yt3);
                    if (ddt < dd1) then begin  x3 :=xt3; y3 :=yt3; locnomestrada :=  straPiano.nomepiano; end;
                   end;
                 end;
               end;
             end;
           end;
        end;


      if ((x3=x1) and (y3=y1)) then showmessage(locfam.Indirizzo);

      if ((x3=x1) and (y3=y1)) then Form_TestInfo.ListBox1.Items.Add(locfam.Indirizzo);

       x2 := (x1+x3)/2;      y2 := (y1+y3)/2;

       locCiv.InitCivico(x1,y1,x2,y2,x3,y3,testoCivico);
       locCiv.nomestrada := locnomestrada;
       loPiano.Listavector.Add(locCiv);
//      end;
    end;
  end;

// togliciviciDoppi;
 for kc := loPiano.Listavector.Count-1 downto 1 do
  begin
   locvet     := loPiano.Listavector.items[kc];
   if locvet.b_erased then continue;
   if locvet.tipo<>PCivico then continue;
   locCiv := loPiano.Listavector.items[kc];
   for j := kc-1 downto 0 do
    begin
     locvet     := loPiano.Listavector.items[j];
     if locvet.tipo<>PCivico then continue;
     locCivT := loPiano.Listavector.items[j];
     if ( (locCiv.x1c=locCivT.x1c) and  (locCiv.y1c=locCivT.y1c) and
          (locCiv.x2c=locCivT.x2c) and  (locCiv.y2c=locCivT.y2c) and
          (locCiv.x3c=locCivT.x3c) and  (locCiv.y3c=locCivT.y3c) and
          (locCiv.txtciv=locCivT.txtciv) and
          (locCiv.nomestrada=locCivT.nomestrada)
         ) then locCivT.b_erased := true;
    end;
  end;

 DisegnoVCorrente.faiLimiti;
 ridisegnaInterfaccia;
// closefile(F);
// Form_TestInfo.show;
end;


procedure  TProgetto.PenDownDiscorrente;
begin
 if DisegnoVCorrente<>nil then DisegnoVCorrente.tuttoPenDownPolyline;
end;


procedure  TProgetto.FaiDisegnoNomiStrade;
var loPiano : TPiano;
    k,j : Integer;
    pianoAdded : TPiano;
    locTesto : TTesto;
    locvector : TVettoriale;
    locPlinea  : TPolylinea;
    vt1 : TVertice;
    xa,ya,xb,yb,x1,y1 : Real;
begin
 if LeStradeV<>nil then
  begin
   NuovoDisegno;
   DisegnoVCorrente.nomedisegno :='Toponomastica';
   pianoAdded := DisegnoVCorrente.listapiani.Items[0];
   for k:= 0 to LeStradeV.listapiani.Count-1 do
    begin
     loPiano:= LeStradeV.listapiani.items[k];
     DisegnoVCorrente.addLayerCorrente(lopiano.nomepiano);
     pianoAdded := DisegnoVCorrente.listapiani.Items[DisegnoVCorrente.ListaPiani.Count-1];
     for j:= 0 to loPiano.Listavector.Count-1 do
      begin
       locvector:=loPiano.Listavector.items[j];
       if locvector.tipo = PPlinea then
        begin
         locPlinea := loPiano.Listavector.items[j];
         vt1 := locPlinea.Spezzata.Items[0];         xa := vt1.x;         ya := vt1.y;
         vt1 := locPlinea.Spezzata.Items[1];         xb := vt1.x;         yb := vt1.y;
         x1 := (xa+xb) /2;    y1 := (ya+yb) /2;

         locTesto := TTesto.Create;
         locTesto.Initer(DisegnoVCorrente,pianoAdded);
         locTesto.initTestoStr(x1,y1,htestostrade,0,loPiano.nomepiano);
         pianoAdded.Listavector.Add(locTesto);

         if locplinea.Spezzata.Count>4 then
          begin
           vt1 := locPlinea.Spezzata.Items[locplinea.Spezzata.Count-2];         xa := vt1.x;         ya := vt1.y;
           vt1 := locPlinea.Spezzata.Items[locplinea.Spezzata.Count-1];         xb := vt1.x;         yb := vt1.y;
           x1 := (xa+xb) /2;    y1 := (ya+yb) /2;
           locTesto := TTesto.Create;
           locTesto.Initer(DisegnoVCorrente,pianoAdded);
           locTesto.initTestoStr(x1,y1,300,0,loPiano.nomepiano);
           pianoAdded.Listavector.Add(locTesto);
          end;

        end;

      end;
    end;
  end;

 DisegnoVCorrente.faiLimiti;
 ridisegnaInterfaccia;
 ridisegna;
end;


procedure  TProgetto.civiciNonAssociati;
var k,j,i : Integer;
    loDis,momdis : TDisegnoV;
    eseguibile : Boolean;
    lopiano : TPiano;
    pianoevid : TPiano;
    locvet    : TVettoriale;
    locCiv : TCivico;
    pianoadd : TPiano;
    locpunto : TPunto;
begin
 eseguibile := false;
 for k:=0 to self.ListaDisegniV.Count-1 do
  begin
   momdis := ListaDisegniV.items[k];
   if Uppercase(momdis.nomedisegno) = 'CIVICI' then
    begin
     eseguibile := true;
     ilProgetto.cambiadisegnocorrente(k);
     loDis := momdis;
     break;
    end;
  end;

  if not(eseguibile) then exit;

  loDis.addLayerCorrente('Evidenziati');

  loDis.setcolorepianorgb(lodis.indPianocorrente,255,0,0);
  loDis.setspessorepiano (lodis.indPianocorrente,3);
  pianoadd:= lodis.ListaPiani.Items[lodis.indPianocorrente];


  for j:=0 to loDis.ListaPiani.Count-1 do
   begin
    lopiano := loDis.ListaPiani.items[j];
      for i :=0 to lopiano.Listavector.Count-1 do
       begin
        locvet := lopiano.Listavector.items[i];
        if locvet.b_erased then continue;
        if locvet.tipo <>PCivico then continue;
        locCiv := lopiano.Listavector.items[i];
        if locCiv.susestesso then
         begin
         	locpunto := TPunto.Create;
          locpunto.Initer(loDis,pianoadd);
          locpunto.InitPunto(locCiv.x1c,locCiv.y1c);
  	      pianoadd.Listavector.Add(locpunto);
         	pianoadd.UpdateLimiti(locCiv.x1c-1,locCiv.y1c-1);
  	      pianoadd.UpdateLimiti(locCiv.x1c+1,locCiv.y1c+1);
         end;
       end;
   end;
end;

procedure  TProgetto.civiciSnc;
var k,j,i : Integer;
    loDis,momdis : TDisegnoV;
    eseguibile : Boolean;
    lopiano : TPiano;
    pianoevid : TPiano;
    locvet    : TVettoriale;
    locCiv : TCivico;
    pianoadd : TPiano;
    locpunto : TPunto;
begin

 eseguibile := false;
 for k:=0 to self.ListaDisegniV.Count-1 do
  begin
   momdis := ListaDisegniV.items[k];
   if Uppercase(ChangeFileExt(momdis.nomedisegno,'')) = 'CIVICI' then
    begin
     eseguibile := true;
     ilProgetto.cambiadisegnocorrente(k);
     loDis := momdis;
     break;
    end;
  end;

  if not(eseguibile) then exit;

  loDis.addLayerCorrente('Anag_snc2');

  loDis.setcolorepianorgb(lodis.indPianocorrente,255,0,0);
  loDis.setspessorepiano (lodis.indPianocorrente,3);
  loDis.setdimPuntopiano (lodis.indPianocorrente,4);

  pianoadd:= lodis.ListaPiani.Items[lodis.indPianocorrente];

  for j:=0 to loDis.ListaPiani.Count-1 do
   begin
    lopiano := loDis.ListaPiani.items[j];
      for i :=0 to lopiano.Listavector.Count-1 do
       begin
        locvet := lopiano.Listavector.items[i];
        if locvet.b_erased then continue;
        if locvet.tipo <>PCivico then continue;
        locCiv := lopiano.Listavector.items[i];
        if ((Uppercase(locCiv.txtciv)='SNC') or (locCiv.txtciv='#'))  then
         begin
         	locpunto := TPunto.Create;
          locpunto.Initer(loDis,pianoadd);
          locpunto.InitPunto(locCiv.x2c-2.0,locCiv.y2c);
  	      pianoadd.Listavector.Add(locpunto);
         	pianoadd.UpdateLimiti(locCiv.x2c-1,locCiv.y2c-1);
  	      pianoadd.UpdateLimiti(locCiv.x2c+1,locCiv.y2c+1);
         end;
       end;
   end;
   ridisegnaInterfaccia;
end;


procedure  TProgetto.impostaTuttiCiviciAlti(newH : Real);
var locdis : TDisegnoV;
    locpia : TPiano;
    locobj : Tvettoriale;
    locCiv : TCivico;
    k,j,m : Integer;
begin
 for k:=0 to listadisegniV.Count-1 do
  begin
   locdis := listadisegniV.items[k];
   for j := 0 to locdis.ListaPiani.count-1 do
    begin
     locpia := locdis.ListaPiani.items[j];
     for m:=0 to locpia.Listavector.Count-1 do
      begin
       locobj := locpia.Listavector.Items[m];
       if locobj.tipo <> PCivico then continue;
       locCiv := locpia.Listavector.Items[m];
       locCiv.altezza := newH;
      end;
    end;
  end;
end;

procedure  TProgetto.impostaAltezzaNomiStrade(newH : Real);
var locdis : TDisegnoV;
    locpia : TPiano;
    locobj : Tvettoriale;
    loctesto : TTesto;
    k,j,m : Integer;
begin
 for k:=0 to listadisegniV.Count-1 do
  begin
   locdis := listadisegniV.items[k];
   for j := 0 to locdis.ListaPiani.count-1 do
    begin
     locpia := locdis.ListaPiani.items[j];
     for m:=0 to locpia.Listavector.Count-1 do
      begin
       locobj := locpia.Listavector.Items[m];
       if locobj.tipo <> PTesto then continue;
       loctesto := locpia.Listavector.Items[m];
       loctesto.altezza := newH;
      end;
    end;
  end;
end;


procedure  TProgetto.ImpostaalfaCatasto(newalfa : integer);
var k : Integer;
    locdisV : TDisegnoV;
begin
    for k:=0 to IlCatastoV.listaCXF.Count-1 do
     begin
      locdisV := IlCatastoV.listaCXF.Items[k];
      locdisV.alfasuperfici :=newAlfa;
      locdisV.alfalinee := newAlfa*3;
      if locdisV.alfalinee>255 then locdisV.alfalinee:=255;
     end;
end;

procedure  TProgetto.ImpostaGrigioCivici(modo : Integer);
var k,j,i : Integer;
    loDis,momdis : TDisegnoV;
    eseguibile : Boolean;
    lopiano : TPiano;
    pianoevid : TPiano;
    locvet    : TVettoriale;
    locCiv : TCivico;
    pianoadd : TPiano;
    locpunto : TPunto;
begin

 eseguibile := false;
 for k:=0 to self.ListaDisegniV.Count-1 do
  begin
   momdis := ListaDisegniV.items[k];
   if Uppercase(ChangeFileExt(momdis.nomedisegno,'')) = 'CIVICI' then
    begin
      for j:=0 to momdis.ListaPiani.Count-1 do
       begin
        lopiano := momdis.ListaPiani.items[j];
        if uppercase(loPiano.nomepiano) = 'ANAGRAFE' then
         begin
          if modo = 0 then begin
           lopiano._rosso := 100;
           lopiano._verde := 100;
           lopiano._blu := 100;
          end
           else
          begin
           lopiano._rosso := 255;
           lopiano._verde := 255;
           lopiano._blu   := 0;
          end;
         end;
       end;
     break;
    end;
  end;

end;

procedure  TProgetto.mettielencociviciSchermo(LaListaCiviciFoglio : TList);
var k,j,i,m : Integer;
    loDis,momdis : TDisegnoV;
    eseguibile : Boolean;
    locpia : TPiano;
    pianoevid : TPiano;
    locobj    : TVettoriale;
    locCiv,locCiv2 : TCivico;
    pianoadd : TPiano;
begin
 for k:=0 to self.ListaDisegniV.Count-1 do
  begin
   momdis := ListaDisegniV.items[k];
   if Uppercase(ChangeFileExt(momdis.nomedisegno,'')) = 'CIVICI' then
    begin
     for j := 0 to momdis.ListaPiani.count-1 do
      begin
       locpia := momdis.ListaPiani.items[j];
       for m:=0 to locpia.Listavector.Count-1 do
        begin
         locobj := locpia.Listavector.Items[m];
         if locobj.tipo <> PCivico then continue;
         locCiv := locpia.Listavector.Items[m];
         if locCiv.inSchermo then LaListaCiviciFoglio.Add(locCiv);
        end;
      end;
    end;
  end;
 // eliminazione doppioni
 for k:=LaListaCiviciFoglio.Count-1 downto 1 do
  begin
   locCiv := LaListaCiviciFoglio.items[k];
   for j := k-1 downto 0 do
    begin
     locCiv2 := LaListaCiviciFoglio.items[j];
     if ((locCiv.nomestrada = locCiv2.nomestrada) and (locCiv.txtciv = locCiv2.txtciv)) then
      begin
       LaListaCiviciFoglio.delete(k);
       break;
      end;
    end;
  end;

end;


procedure  TProgetto.riordinaciviciinLista(var LaListaCiviciFoglio: TList);
var loclista : TList;
    k,j : Integer;
    civ1,civ2 : TCivico;
    candidato : Integer;
    locint1,locint2,coda1,coda2 : Integer;
begin
 loclista := TList.Create;
 for k:=0 to LaListaCiviciFoglio.Count-1 do
  begin
   civ1 := LaListaCiviciFoglio.items[k];
   candidato :=0;
   for j := 0 to loclista.count-1 do
    begin
     civ2 := loclista.items[j];
     if (civ1.nomestrada>civ2.nomestrada) then begin candidato :=j+1; continue; end;
     if (civ1.nomestrada=civ2.nomestrada) then begin
      val (togliletteredanumeroStr(civ1.txtciv), locint1,coda1);
      val (togliletteredanumeroStr(civ2.txtciv), locint2,coda2);
      if ((coda1=0) and (coda2=0)) then
       begin
        if locint1>locint2 then  candidato :=j+1;
       end
      else      begin if civ1.txtciv>civ2.txtciv then  candidato :=j+1;  end;
     end;
    end;
   loclista.Insert(candidato,civ1);
  end;

 LaListaCiviciFoglio.clear;
 for k:=0 to loclista.Count-1 do
  begin
   civ1 := loclista.items[k];
   LaListaCiviciFoglio.add(civ1);
  end;

 loclista.Clear;
 loclista.Free;
end;

procedure  TProgetto.famigliedeiCivici(LaListaCiviciFoglio: TList;var LaListaAnagrafeFoglio: TList);
var k,j : Integer;
    locCiv : TCivico;
    locFam : TFamiglia;
begin
 for k:=0 to LaListaCiviciFoglio.Count-1 do
  begin
   locCiv := LaListaCiviciFoglio.items[k];
   for j:=0 to LaAnagrafe.listaFamiglie.Count-1 do
    begin
     locFam := LaAnagrafe.listaFamiglie.items[j];
     if pos(Uppercase(locfam.Indirizzo),uppercase(locCiv.nomestrada))>0 then
      begin
       if ( (Uppercase(locFam.civico)<>(uppercase(locCiv.txtciv))) and (Not ( (locFam.civico='') and (locCiv.txtciv='#') )) ) then continue;
       if ((locFam.Foglio<>'') and (locFam.Particella<>'')) then LaListaAnagrafeFoglio.Add(locFam);
      end;
    end;
  end;
end;


procedure  TProgetto.stradeschermata(var Listastrade: TList);
var k,j : Integer;
    momdis : TDisegnoV;
    lopiano,lopiano2 : Tpiano;
    resulta : Boolean;
    x1,y1 : Real;
    loclista : TList;
    candidato : Integer;
begin
 for k:=0 to self.ListaDisegniV.Count-1 do
  begin
   momdis := ListaDisegniV.items[k];
   if Uppercase(ChangeFileExt(momdis.nomedisegno,'')) = 'STRADE' then
    begin
      for j:=0 to momdis.ListaPiani.Count-1 do
       begin
        lopiano := momdis.ListaPiani.items[j];
        resulta := true;
        x1 := Xinschermo(lopiano.limx2); if x1 <0 then resulta :=false;
        y1 := Yinschermo(lopiano.limy1); if y1 <0 then resulta :=false;
        x1 := Xinschermo(lopiano.limx1); if x1 >Wschermo then resulta :=false;
        y1 := Yinschermo(lopiano.limy2); if y1 >Hschermo then resulta :=false;
        if resulta then Listastrade.Add(lopiano);
       end;
     break;
    end;
  end;

  loclista := TList.create;
 for k:=0 to Listastrade.Count-1 do
  begin
   lopiano := Listastrade.items[k];
   candidato :=0;
   for j := 0 to loclista.count-1 do
    begin
     lopiano2 := loclista.items[j];
     if (lopiano.nomepiano>lopiano2.nomepiano) then candidato :=j+1;
    end;
   loclista.Insert(candidato,lopiano);
  end;

 Listastrade.clear;
 for k:=0 to loclista.Count-1 do
  begin
   lopiano := loclista.items[k];
   Listastrade.add(lopiano);
  end;



  loclista.Clear; loclista.Free;

end;

procedure  TProgetto.Anagrafesconosciuta(LaListaStradeSchermata : TList ; var LaListaAnagrafeSconosciuti : TList);
var k,j : Integer;
    lopiano : Tpiano;
    locFam  : TFamiglia;
begin
 for k:=0 to LaListaStradeSchermata.count-1 do
  begin
   lopiano := LaListaStradeSchermata.Items[k];
   for j:=0 to LaAnagrafe.listaFamiglie.Count-1 do
    begin
     locFam := LaAnagrafe.listaFamiglie.items[j];
     if pos(Uppercase(locfam.Indirizzo),uppercase(lopiano.nomepiano))>0 then
      begin
       if ((locFam.Foglio='') and (locFam.Particella='')) then LaListaAnagrafeSconosciuti.Add(locFam);
      end;
    end;
  end;
end;

procedure  TProgetto.Stampa(nomefile : String);
var imaginefondo : TCustomBitmap32;
    oldcolorFondo : Tcolor32;
    StampaHHDC : TImage32;
//    dimxstampa_mm, dimystampa_mm : Integer;
    px_al_mm : Real;
    locDimXStampa, locDimYStampa : Real;
    DimXtoPrint, DimYtoPrint     : Real;
     stampadimXpx, stampadimYpx  : Integer;
begin
 //   Mainform.Image32Stampa.Visible:=true;
 // per ora 25 dpi  = 1 px = 1mm
 // per ora 250 dpi = 10 px = 1mm
    px_al_mm := stampadpi/25.4;

    DimXtoPrint   :=  (stampax2origine-stampaxorigine) ;
    DimYtoPrint   :=  (stampay2origine-stampayorigine) ;


    locDimXStampa :=  (stampax2origine-stampaxorigine) ;
    locDimYStampa :=  (stampay2origine-stampayorigine) ;

    stampaScalaOrMap  := locDimXStampa / stampadimXmm;

    stampaScalaOrMap := stampaScalaOrMap/px_al_mm;

    stampadimXpx  := round(stampadimXmm*px_al_mm);
    stampadimYpx  := round(stampadimYmm*px_al_mm);

     EsternostampadimYpx := round(stampadimYpx );


 Mainform.Image32Stampa.Width  := round(stampadimXpx );
 Mainform.Image32Stampa.Height := round(stampadimYpx );
 Mainform.Image32Stampa.update;


 mainform.Image32Stampa.Bitmap.SetSize(mainform.Image32Stampa.Width,mainform.Image32Stampa.Height);


  imaginefondo := TCustomBitmap32.Create;
  imaginefondo := mainform.Image32Stampa.Bitmap;

     oldcolorFondo := ColoreSfondo;
     ColoreSfondo := rgb(255,255,255);

  if ilProgetto<>nil then ilProgetto.Disegna(mainform.Image32Stampa,true);

  imaginefondo.SaveToFile(nomefile);

     ColoreSfondo := oldcolorFondo;
//    Mainform.Image32Stampa.Visible:=false;

// ridisegna;
end;

procedure  TProgetto.StampaRilievo(nomefile : String);
var imaginefondo : TCustomBitmap32;
    oldcolorFondo : Tcolor32;
    oldview1 : Boolean;
    LaListaCiviciFoglio : TList;
    LaListaAnagrafeFoglio : TList;
    LaListaAnagrafeSconosciuti : TList;
    LaListaStradeSchermata : TList;
    nomeassociato : String;
    F : TextFile;
    locCiv : TCivico;
    locFam : TFamiglia;
    locres : TResidente;
    locPiano: TPiano;
    k,cc : Integer;
    lariga : String;
begin
 imaginefondo := TCustomBitmap32.Create;
 imaginefondo := mainform.BaseSchermo.Bitmap;
 oldcolorFondo := ColoreSfondo;
 ColoreSfondo := rgb(255,255,255);
// showmessage(IntTostr(round(scalavista*100)));
 impostaTuttiCiviciAlti(1500.0*scalavista);
 impostaAltezzaNomiStrade(1500.0*scalavista);
// ImpostaalfaCatasto(255);
 impostaGrigioCivici(0);

 ridisegna;
 imaginefondo.SaveToFile(nomefile);

 impostaGrigioCivici(1);
 impostaTuttiCiviciAlti(200.0);
 impostaAltezzaNomiStrade(300.0);
 ColoreSfondo := oldcolorFondo;
 ridisegna;

 nomeassociato := ChangeFileExt(nomefile,'.txt');
 // ora il foglio associato
 LaListaCiviciFoglio    := TList.create;
 LaListaAnagrafeFoglio  := TList.create;
 LaListaStradeSchermata := TList.create;
 LaListaAnagrafeSconosciuti := TList.create;

 Ilprogetto.mettielencociviciSchermo(LaListaCiviciFoglio);
 Ilprogetto.riordinaciviciinLista(LaListaCiviciFoglio);
 Ilprogetto.famigliedeiCivici(LaListaCiviciFoglio,LaListaAnagrafeFoglio);
 Ilprogetto.stradeschermata(LaListaStradeSchermata);
 Ilprogetto.Anagrafesconosciuta(LaListaStradeSchermata,LaListaAnagrafeSconosciuti);



 AssignFile(F,nomeassociato); rewrite(F);

 writeln(F,'Elenco Strade stampate nel foglio : '+ChangeFileExt(extractfilename(nomefile),''));
  for k := 0 to LaListaStradeSchermata.count-1 do
   begin
    locPiano := LaListaStradeSchermata.items[k];
    writeln(F,locPiano.nomepiano);
   end;


 writeln(F,'');
 writeln(F,'Elenco Vie e Civici stampati nel foglio : '+ChangeFileExt(extractfilename(nomefile),''));
 writeln(F,'');



   for k := 0 to LaListaCiviciFoglio.count-1 do
     begin
      locCiv := LaListaCiviciFoglio.items[k];
      writeln(F,locCiv.nomestrada+'  N.  '+locCiv.txtciv);
     end;


    writeln(F,'');
    writeln(F,'');
    writeln(F,'Elenco dei Residenti di cui conosciamo la posizione grafica');
    for k := 0 to LaListaAnagrafeFoglio.count-1 do
     begin
      locFam := LaListaAnagrafeFoglio.items[k];
      locres := locFam.ListaFamiglia.Items[0];
      lariga := locres.Cognome;
      for cc:= 1 to 20-length(locres.Cognome) do lariga:=lariga+' ';
      lariga := lariga + ' '+locres.Nome;
      for cc:= 1 to 20-length(locres.nome) do lariga:=lariga+' ';
      lariga := lariga + ' '+locFam.Indirizzo;
      for cc:= 1 to 20-length(locFam.Indirizzo) do lariga:=lariga+' ';
      lariga := lariga+' N. ' + locFam.civico;

      for cc:= 1 to 6-length(locFam.civico) do lariga:=lariga+' ';
      lariga := lariga+' Fg. ' + locFam.Foglio;
      for cc:= 1 to 4-length(locFam.Foglio) do lariga:=lariga+' ';
      lariga := lariga+' Part. ' + locFam.Particella;
//      for cc:= 1 to 10-length(locFam.Particella) do lariga:=lariga+' ';

      writeln(F,lariga);
     end;

    writeln(F,'');
    writeln(F,'');
    writeln(F,'Elenco dei Residenti che non sappiamo dove sono graficamente');
    for k := 0 to LaListaAnagrafeSconosciuti.count-1 do
     begin
      locFam := LaListaAnagrafeSconosciuti.items[k];
      locres := locFam.ListaFamiglia.Items[0];
      lariga := locres.Cognome;
      for cc:= 1 to 20-length(locres.Cognome) do lariga:=lariga+' ';
      lariga := lariga + ' '+locres.Nome;
      for cc:= 1 to 30-length(locres.nome) do lariga:=lariga+' ';
      lariga := lariga + ' '+locFam.Indirizzo;
      for cc:= 1 to 25-length(locFam.Indirizzo) do lariga:=lariga+' ';
      lariga := lariga+' N. ' + locFam.civico;
      writeln(F,lariga);
     end;


 closeFile(F);


 LaListaAnagrafeFoglio.clear;    LaListaAnagrafeFoglio.Free;
 LaListaCiviciFoglio.clear;      LaListaCiviciFoglio.Free;
 LaListaStradeSchermata.clear;   LaListaStradeSchermata.Free;
 LaListaAnagrafeSconosciuti.clear;   LaListaAnagrafeSconosciuti.Free;

end;


procedure  TProgetto.apriDisegnoConcessioni(modo : Integer; param : String; nomeaz:string);
var searchResult : TSearchRec;
    trovato : Boolean;
    ilDisegno : TDisegnoV;
    ilnome : String;
    ilcoddis : String;
    locdisV : TDisegnoV;
    k : Integer;
    giacaricato : Boolean;
begin
 if dirDisegniConcessioni='' then
  begin showmessage('assente la def dir disegni concessioni'); exit; end;

 trovato := false;
 if FindFirst(dirDisegniConcessioni+'*.macmap', faAnyFile, searchResult) = 0 then
  begin
    repeat
      ilcoddis := prendiNumFinDisegno(searchResult.Name);
      if param = ilcoddis then
       begin
        trovato := true;
        if modo=1 then begin
         giacaricato := false;
          for k:=0 to self.ListaDisegniV.Count-1 do
           begin
            locdisV := self.ListaDisegniV.items[k];
            if (Uppercase(locdisV.nomedisegnoconPath) = uppercase(dirDisegniConcessioni+searchResult.Name)) then
             begin
              giacaricato := true;
              locdisV.b_visibile := true;
              indDisVcorrente := k;
              PianoCorrente := locdisV.ListaPiani.Items[locdisV.indPianocorrente];
              setZoomDisegnoVCorrente;
             end;
           end;
          if not(giacaricato) then
           begin
            apridisegnodiretto(dirDisegniConcessioni+searchResult.Name);
//            LeConcessioniV.AttivavistaNomedisegno(dirDisegniConcessioni+searchResult.Name,true);
            setZoomDisegnoVCorrente;
           end;


        end;
        if modo=2 then
         begin
          for k:=0 to LeConcessioniV.listaDisegni.Count-1 do
           begin
            locdisV := LeConcessioniV.listaDisegni.items[k];
            if (Uppercase(locdisV.nomedisegnoconPath) = uppercase(dirDisegniConcessioni+searchResult.Name)) then
             begin
              LeConcessioniV.AttivavistaNomedisegno(dirDisegniConcessioni+searchResult.Name,false);
              locdisV.b_visibile := false;
             end;
           end;
         end;
       end;
    until FindNext(searchResult) <> 0;

    // Must free up resources used by these successful finds
    FindClose(searchResult);
  end;
  ridisegna;
  ridisegnainterfaccia;

 if not(trovato) then
  begin
   showmessage('genero un nuovo disegno');
   NuovoDisegno;
   ilDisegno := DisegnoVCorrente;
   ilDisegno.addLayerCorrente('Concessione');
   Pianocorrente._rosso    := 255;
   Pianocorrente._verde    := 155;
   Pianocorrente._Blu      := 0;
   ilnome := '#'+param+'#'+mettiundercoreaSpazi(nomeaz)+'.macmap';
   ilDisegno.nomedisegno := ilnome;
   ilDisegno.nomedisegnoconPath:= dirDisegniConcessioni+ilnome;
   ilDisegno.salvaDisegnoMacMac(ilDisegno.nomedisegnoconPath);
   ridisegnainterfaccia;
  end;
end;


procedure  TProgetto.selezionaTerFabSoggetto(modo : Integer; idsog : String);
var    LaListadaprendereDati , Lalistaimmobili: TList;
       locPossesso : TPossesso;
       k,j : Integer;
       locTerdato : TTerCatDati;
begin
 ListaSelezionati.Clear;
 case modo of
  0 : begin LaListadaprendereDati :=  GliImmobiliDati.ListaPossessiTerra;      Lalistaimmobili :=GliImmobilidati.listaTerreni;     end;
  1 : begin LaListadaprendereDati :=  GliImmobiliDati.ListaPossessiFabbricati; Lalistaimmobili :=GliImmobilidati.listaFabbricati;  end;
 end;

  if modo =1 then   showmessage('fab');

 for k:= 0 to LaListadaprendereDati.count-1 do
  begin
   locPossesso := LaListadaprendereDati.items[k];
   if idsog = locPossesso.IdentificativoSoggetto then
    begin

     for j:=0 to Lalistaimmobili.Count-1 do
      begin
       case modo of
        0 : begin
          locTerdato :=  Lalistaimmobili.items[j];
          if (locTerdato.IdentificativoImmobile = locPossesso.IdentificativoImmobile) then
           begin

            IlCatastoV.mettInSelezioneTerrenoFgPart(locTerdato.Foglio,locTerdato.Particella, ListaSelezionati);
           end;

        end;
        1 : begin
        end;
       end;


      end;
    end;
  end;

      showmessage(IntToStr(ListaSelezionati.count));

end;


procedure  TProgetto.TuttidisegniConcessioni;
begin
 LeConcessioniV.ApriConcessioniTutte;
 // showmessage( IntToStr(LeConcessioniV.listaDisegni.Count)  );
 Vista_ZoomTuttosePrimo;
 ridisegna;
end;


procedure  TProgetto.inizializzaVistaDefStampa(xstr,ystr,scastr, dpistr : String );
var dimxcm, dimycm, scastam : Real;
    coda : Integer;
    veraXdim, veraYdim : Real;
    Locx2origineVista,Locy2origineVista : real;
    nuovascala : Real;
begin
  val(xstr,dimxcm,coda);
  if coda <>0 then begin comando00; showmessage('dimensione X scorretta'); exit; end;
  val(ystr,dimycm,coda);
  if coda <>0 then begin comando00; showmessage('dimensione Y scorretta'); exit; end;
  val(scastr,scastam,coda);
  if coda <>0 then begin comando00; showmessage('dimensione Scala scorretta'); exit; end;

  val(dpistr,stampadpi,coda);
  if coda <>0 then begin comando00; showmessage('dimensione dpi scorretta'); exit; end;


  dimxcm := dimxcm/100;    dimycm := dimycm/100;  // sono cm no metri
  veraXdim := dimxcm*scastam;       veraYdim := dimycm*scastam;

  dimxStampaVir := veraXdim;        dimyStampaVir := veraYdim;


    Locx2origineVista  := xOrigineVista+Wschermo*ScalaVista;
    Locy2origineVista  := yOrigineVista+Hschermo*ScalaVista;

    nuovascala := veraXdim / WSchermo;
    nuovascala := nuovascala*1.5;  // sia bene interno allo schermo il rettangolo virtuale

    set_scalaVista  (nuovascala);
    setZoomC        ((Locx2origineVista+xOrigineVista)/2,(Locy2origineVista+yOrigineVista)/2);

    ridisegna;

    stampadimXmm      := dimxcm*1000;
    stampadimYmm      := dimycm*1000;
    stampaScalaStampa := scastam;
//    stampaScalaOrMap  := nuovascala;
//    stampaxorigine    :=
//    stampayorigine    :=

//    showmessage( FloatToStr(stampadimXmm)  );
//    showmessage( FloatToStr(scastam)  );
//    showmessage( FloatToStr(stampaScalaOrMap)  );

end;




procedure  TProgetto.prestamparilievo;
begin
 Ilprogetto.vedoterreno := true;
 mainform.Gau_RasterTerreno.Position:= 45;
 mainform.Bot_Territorio.Down := true;
 if Ilprogetto.vedoterreno then IlProgetto.Vista_ZoomTuttosePrimo;
 ridisegna;
 ridisegnainterfaccia;
end;


procedure   TProgetto.polytoPoligonoDisegno;
var locdis : TDisegnoV;
begin
 locdis := DisegnoVCorrente;
 locdis.PolyToPoligoni;
end;


procedure  TProgetto.eliminaPianiOff;
var locdis : TDisegnoV;
begin
 locdis := DisegnoVCorrente;
 locdis.EliminaPianiOff;
end;

procedure  TProgetto.eliminaPianiON;
var locdis : TDisegnoV;
begin
 locdis := DisegnoVCorrente;
 locdis.EliminaPianiON;
end;

procedure  TProgetto.FondiTuttoPrimoPiano;
var locdis : TDisegnoV;
begin
 locdis := DisegnoVCorrente;
 locdis.FondituttoPrimoPiano;
end;

procedure  TProgetto.Consessioniselezionati;
begin
  LeConcessioniV.togliselezionati;
end;

end.


