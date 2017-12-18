unit uVector;

interface

uses GR32,  GR32_Image, FMX.Dialogs, Graphics,   System.classes,
  WinTypes, WinProcs, Messages,
  SysUtils , testo , disegnoV
  ;

procedure ApriDisegnodaDialog;
procedure ApriDisegnoDiretto(nome:String);
procedure ApriDisegnoDaBottone(nome:String);
procedure DisegnaGriglia                    ( HHDC : TImage32);
procedure apriCatasto;
procedure apriQUCatasto;
procedure Seleziona                    (x1,y1 : real);
procedure selezInfo_conPt              (x1,y1 : real);
function  SelezionaTesto               (x1,y1 : real) : TTesto;
function  selezionaVtconPt             : Boolean;
function  selezionaCivicoPosconPt      : Boolean;
procedure SpostaVerticeSelezionato     (newx,newy : Real);
procedure InserisciVerticeSelezionato  (newx,newy : Real);
procedure CancellaVerticeSelezionato;
procedure Match_conPt;
procedure SpostaSelezionati;
procedure CopiaSelezionati;
procedure RuotaSelezionati;
procedure ScalaSelezionati;

procedure salvadisegnocondialog;
procedure swdis(ind : Integer);

procedure FondiDisegni;
procedure ApriStrade(nome:String);
procedure risistemaNomiStrade;
procedure cercastradaBattente_CivicoinEdit;
procedure intoduciBattente_nomestrada;

// selezionati
procedure CopiaSelezionatialPianoCorrente;
procedure CopiaParticelleinConcessione;

function  presentedisegnoV(nomefile : String) : Boolean;
function  DammiDisegnoAperto(nome:String) : TDisegnoV;


implementation

uses main,progetto, varbase, funzioni, Dlg_griglia, proiezioni,
     CatastoV,uviste,Vettoriale,dlg_Info,interfaccia,piano,civico,ContrattoConcessione
     , partconc, ImmobiliDati,TercatDati
     ;



procedure salvadisegnocondialog;
begin
 if Ilprogetto.DisegnoVCorrente<> nil then
  begin
   Mainform.SaveVector.FileName := Ilprogetto.DisegnoVCorrente.nomedisegnoconPath;
   if Mainform.SaveVector.FileName = '' then Mainform.SaveVector.FileName :='NoName';
   if Mainform.SaveVector.Execute then
    begin
     Ilprogetto.DisegnoVCorrente.salvaDisegnoMacMac(Mainform.SaveVector.FileName);
    end;
  end;
end;

procedure ApriDisegnodaDialog;
var locdisV : TDisegnoV;
begin
 if Mainform.openvector.Execute then
  begin
   apridisegnodiretto (Mainform.openvector.FileName);
  end;
end;


procedure ApriStrade(nome:String);
var k : Integer;
    giapresente : Boolean;
    locdisV : TDisegnoV;
    nomefileristretto : String;
begin
 giapresente := false;
 nomefileristretto := extractfilename(nome);
 for k:=0 to ilprogetto.ListaDisegniV.count-1 do
  begin
    locdisV := ilprogetto.ListaDisegniV.Items[k];
    if (nomefileristretto = locdisV.nomedisegno) then
     begin giapresente := true; swdis(k); end;
  end;
 if not(giapresente) then begin apridisegnodiretto(nome); LeStradeV:=IlProgetto.DisegnoVCorrente;    IlProgetto.Vista_ZoomTuttosePrimo; end;
end;

procedure risistemaNomiStrade;
var locPiano : TPiano;
    k, conta : Integer;
begin
  conta:=9;
 if LeStradeV<>nil then
  begin
   LeStradeV.EliminaPianiVuoti;
   for k:=0 to LeStradeV.ListaPiani.Count-1 do
    begin
     locPiano := LeStradeV.ListaPiani.items[k];
     if locPiano.nomepiano='' then begin
       inc(conta);
       locPiano.nomepiano := '#'+intToStr(conta);
      end;
    end;

  end;

end;

procedure ApriDisegnoDaBottone(nome:String);
var k : Integer;
    giapresente : Boolean;
    locdisV : TDisegnoV;
    nomefileristretto : String;
begin
 giapresente := false;
 nomefileristretto := extractfilename(nome);
 for k:=0 to ilprogetto.ListaDisegniV.count-1 do
  begin
    locdisV := ilprogetto.ListaDisegniV.Items[k];
    if (nomefileristretto = locdisV.nomedisegno) then
     begin giapresente := true; swdis(k); end;
  end;
 if not(giapresente) then begin apridisegnodiretto(nome);    IlProgetto.Vista_ZoomTuttosePrimo; end;
end;

function  presentedisegnoV(nomefile : String) : Boolean;
var k : Integer;
    giapresente : Boolean;
    locdisV : TDisegnoV;
    nomefileristretto : String;
begin
 giapresente := false;
 nomefileristretto := extractfilename(nomefile);
 for k:=0 to ilprogetto.ListaDisegniV.count-1 do
  begin
    locdisV := ilprogetto.ListaDisegniV.Items[k];
    if (nomefileristretto = locdisV.nomedisegno) then
     begin giapresente := true; break; end;
  end;
 result := giapresente;
end;


procedure swdis(ind : Integer);
var   locdisV : TDisegnoV;
begin
   if ind<=(ilprogetto.ListaDisegniV.count-1) then
    begin
     locdisV :=ilprogetto.ListaDisegniV.items[ind];
     locdisV.b_visibile := not(locdisV.b_visibile);
    end;
end;


procedure apriCatasto;
begin
 if DirCXFComune<>''    then begin IlCatastoV.DirListaCXF:=DirCXFComune; end;
 if NomefileQUnione<>'' then begin IlCatastoV.NomefileQUnione:=NomefileQUnione; end;
 IlCatastoV.ApriQU;

 if IlCatastoV.listaCXF.Count=0 then
   begin IlCatastoV.ApriCXF;  IlCatastoV.vedoCXF := true; end
   else IlCatastoV.vedoCXF := not(IlCatastoV.vedoCXF);

end;

procedure apriQUCatasto;
begin

 if NomefileQUnione<>'' then begin IlCatastoV.NomefileQUnione:=NomefileQUnione; end;
 if IlCatastoV.QUnione = nil then
  begin IlCatastoV.ApriQU; IlCatastoV.vedoQU:=true;  end
   else
  begin IlCatastoV.vedoQU := not(IlCatastoV.vedoQU); end;
// showmessage(Format('%10f',[ IlCatastoV.QUnione.limx2]));

end;




procedure ApriDisegnoDiretto(nome:String);
var locdisV : TDisegnoV;
begin
   locdisV      := TDisegnoV.Create;
   ilprogetto.ListaDisegniV.Add(locdisV);
   ilprogetto.indDisVcorrente:=ilprogetto.ListaDisegniV.Count-1;
//   ilprogetto.VCorrente :=ilprogetto.ListaDisegniV[ilprogetto.indDisVcorrente];
   locdisV.Apri(nome);
   ilprogetto.PianoCorrente := locdisV.ListaPiani.Items[locdisV.indPianocorrente];
   ridisegnaInterfaccia;
end;

function DammiDisegnoAperto(nome:String) : TDisegnoV;
var locdisV : TDisegnoV;
begin
   locdisV      := TDisegnoV.Create;
   locdisV.Apri(nome);
   result := locdisV;
end;




procedure DisegnaGriglia                    ( HHDC : TImage32);
var 	troppebarre  : Integer;
      scelta1: Boolean;
      xstart , ystart, xend,yend : Real;
      offerGr : real;
      numbarre : Integer;
      x1,y1 ,x2,y2 : single;
      x1r,y1r ,x2r,y2r : real;

      AColor32: TColor32;
      xstartwhile, ystartwhile : Real;
      x1g,y1g  : Real;
      x2g,y2g  : Real;
      alfaGriglia : Integer;
      DeltaX : Real;
      LimBarreAuto : Integer;
begin

  alfaGriglia :=255;

  troppebarre  := 40;
  LimBarreAuto := 30;

	if (B_Griglia_Utm84) then
   begin
    TColor32Entry(AColor32).A := alfaGriglia;
    TColor32Entry(AColor32).R := GetRValue(GridColor1);
    TColor32Entry(AColor32).G := GetGValue(GridColor1);
    TColor32Entry(AColor32).B := GetBValue(GridColor1);
    HHDC.Bitmap.PenColor:= AColor32;
	  xstart := xorigineVista; 	  xend   := xorigineVista+HHDC.Width*scalaVista;
	  ystart := yorigineVista; 	  yend   := yorigineVista+HHDC.Height*scalaVista;
    offerGr := 100.0;
    case opzioneGr1 of
		 0:
      begin
       DeltaX := xend-xstart;
       if (DeltaX / 100) < LimBarreAuto then begin offerGr := 100; end else
         begin
          if (DeltaX / 1000) < LimBarreAuto then begin offerGr := 1000; end else
            begin offerGr := 10000; end;
         end;
      end;
		 1:	offerGr := 100;
		 2:	offerGr := 1000;
		 3:	offerGr := 10000;
    end;
	  xstart := (trunc(xstart/offerGr)*offerGr);	ystart :=(trunc(ystart/offerGr)*offerGr);
		numbarre := round((xend-xstart)/offerGr);
   	if (numbarre>troppebarre) then begin xstart := xend; ystart :=yend;	end;
	   while (xstart<xend) do
      begin
   	 	 x1 := Xinschermo(xstart);
       HHDC.Bitmap.MoveToF(x1,0.0);   HHDC.Bitmap.LineToFS(x1,hschermo);
       xstart :=xstart+offerGr;
      end;
     while (ystart<yend) do
      begin
   	  	y1 := Yinschermo(ystart);
       HHDC.Bitmap.MoveToF(0.0,y1);   HHDC.Bitmap.LineToFS(wschermo,y1);
   	  	ystart := ystart+offerGr;
      end;
 	 end; // gr_b1 utmwgs84





  if (B_Griglia_Sfer84) then
   begin
    TColor32Entry(AColor32).A := alfaGriglia;
    TColor32Entry(AColor32).R := GetRValue(GridColor2);
    TColor32Entry(AColor32).G := GetGValue(GridColor2);
    TColor32Entry(AColor32).B := GetBValue(GridColor2);
    HHDC.Bitmap.PenColor:= AColor32;
	  xstart := xorigineVista; 	  xend   := xorigineVista+(HHDC.Width+100)*scalaVista;
	  ystart := yorigineVista; 	  yend   := yorigineVista+HHDC.Height*scalaVista;

    UtmTolatlon(xstart ,ystart) ;
    UtmTolatlon(xend   ,yend) ;

    offerGr := 10.0/3600.0;
    case opzioneGr2 of
		 0:
      begin
       DeltaX := xend-xstart;
       if (DeltaX / (10.0/3600.0)) < LimBarreAuto then begin offerGr := 10.0/3600.0; end else
         begin
          if (DeltaX / (30.0/3600.0)) < LimBarreAuto then begin offerGr := 30.0/3600.0; end else
            begin
             if (DeltaX / (1.0/60.0)) < LimBarreAuto then begin offerGr := 1.0/60.0; end else
              begin
               offerGr := 5.0/60.0;
              end;
            end;
         end;
      end;
		 1:	offerGr := 10.0/3600.0;
		 2:	offerGr := 30.0/3600.0;
		 3:	offerGr := 1.0/60.0;
		 4:	offerGr := 5.0/60.0;
    end;

    xstart := ((trunc(xstart/offerGr))*offerGr) -offerGr ;   		ystart := ((trunc(ystart/offerGr))*offerGr);
 		numbarre := round((xend-xstart)/offerGr);
    if (numbarre>troppebarre) then begin xstart := xend; ystart:=yend;  end;

  	xstartwhile := xstart;
  	while (xstartwhile<xend) do begin
    		x1r:=xstartwhile; y1r:=ystart;  x2r:=xstartwhile;   y2r:=yend;
     		latlonToUtm (x1r ,y1r);
     		latlonToUtm (x2r ,y2r) ;
         x1g := Xinschermo(x1r);      x2g := Xinschermo(x2r);
         y1g := Yinschermo(y1r);      y2g := Yinschermo(y2r);
         HHDC.Bitmap.MoveToF(x1g,y1g);   HHDC.Bitmap.LineToFS(x2g,y2g);
  		xstartwhile := xstartwhile+offerGr;
    end;
    ystartwhile := ystart;
    while (ystartwhile<yend) do begin
    			y1r:=ystartwhile; x1r:=xstart;  y2r:=ystartwhile;   x2r:=xend;
    			latlonToUtm(x1r ,y1r) ;
    			latlonToUtm(x2r ,y2r) ;
          x1 := Xinschermo(x1r);      x2 := Xinschermo(x2r);
          y1 := Yinschermo(y1r);      y2 := Yinschermo(y2r);
          HHDC.Bitmap.MoveToF(x1,y1);   HHDC.Bitmap.LineToFS(x2,y2);
    			ystartwhile := ystartwhile+offerGr;
    end;
   end;
    // gr_b2 globo wgs





   if (B_Griglia_Utm50) then begin // D50
      TColor32Entry(AColor32).A := alfaGriglia;
      TColor32Entry(AColor32).R := GetRValue(GridColor3);
      TColor32Entry(AColor32).G := GetGValue(GridColor3);
      TColor32Entry(AColor32).B := GetBValue(GridColor3);
      HHDC.Bitmap.PenColor:= AColor32;
  	  xstart := xorigineVista; 	  xend   := xorigineVista+HHDC.Width*scalaVista;
  	  ystart := yorigineVista; 	  yend   := yorigineVista+HHDC.Height*scalaVista;
      offerGr := 100.0;
       case opzioneGr3 of
    		 0:
         begin
          DeltaX := xend-xstart;
          if (DeltaX / 100) < LimBarreAuto then begin offerGr := 100; end else
            begin
             if (DeltaX / 1000) < LimBarreAuto then begin offerGr := 1000; end else
               begin offerGr := 10000; end;
            end;
         end;
    		 1:	offerGr := 100;
    		 2:	offerGr := 1000;
    		 3:	offerGr := 10000;
       end;
  		xstart := (trunc(xstart/offerGr)*offerGr);	ystart := (trunc(ystart/offerGr)*offerGr);
  		xstart := xstart-69;		ystart := ystart-192;  // qui la modifica tra wgs84 e D50

  		numbarre := round((xend-xstart)/offerGr);
 		if (numbarre>troppebarre) then begin  xstart:= xend; ystart:=yend;	end;

  		while (xstart<xend) do begin
        x1 := Xinschermo(xstart);
        HHDC.Bitmap.MoveToF(x1,0.0);   HHDC.Bitmap.LineToFS(x1,hschermo);
        xstart :=xstart+offerGr;
      end;
  		while (ystart<yend) do begin
        y1 := Yinschermo(ystart);
        HHDC.Bitmap.MoveToF(0.0,y1);   HHDC.Bitmap.LineToFS(wschermo,y1);
        ystart:=ystart+offerGr;
      end;
   end;
  	 // gr_b3 utmwgs50



   if (B_Griglia_Sfer50) then begin // globo D50
      TColor32Entry(AColor32).A := alfaGriglia;
      TColor32Entry(AColor32).R := GetRValue(GridColor4);
      TColor32Entry(AColor32).G := GetGValue(GridColor4);
      TColor32Entry(AColor32).B := GetBValue(GridColor4);
      HHDC.Bitmap.PenColor:= AColor32;

  		xstart := xorigineVista; 	  xend   := xorigineVista+(HHDC.Width+100)*scalaVista;
  		ystart := yorigineVista; 	  yend   := yorigineVista+HHDC.Height*scalaVista;
  		offerGr := 10.0/3600.0;
       case opzioneGr4 of
         0 :
          begin
           DeltaX := xend-xstart;
           if (DeltaX / (10.0/3600.0)) < LimBarreAuto then begin offerGr := 10.0/3600.0; end else
             begin
              if (DeltaX / (30.0/3600.0)) < LimBarreAuto then begin offerGr := 30.0/3600.0; end else
                begin
                 if (DeltaX / (1.0/60.0)) < LimBarreAuto then begin offerGr := 1.0/60.0; end else
                  begin offerGr := 5.0/60.0; end;
                end;
             end;
          end;
    		 1:	offerGr := 10.0/3600.0;
    		 2:	offerGr := 30.0/3600.0;
    		 3:	offerGr := 1.0/60.0;
    		 4:	offerGr := 5.0/60.0;
       end;


  		utmtolatlon50(xstart,ystart);
  		utmtolatlon50(xend  ,yend);


 	    xstart := ((trunc(xstart/offerGr))*offerGr)-offerGr;
  		ystart := ((trunc(ystart/offerGr))*offerGr);


  		numbarre := round((xend-xstart)/offerGr);
  		if (numbarre>troppebarre) then begin  xstart := xend; ystart := yend;	 end;
  		xstartwhile := xstart;
		//		while (xstartwhile<xend) {
      		while (true) do begin
      			x1r := xstartwhile; y1r := ystart;  x2r := xstartwhile;   y2r := yend;
      			latlon50ToUtm(x1r,y1r);
      			latlon50ToUtm(x2r,y2r);
            x1g := Xinschermo(x1r);          x2g := Xinschermo(x2r);
            y1g := Yinschermo(y1r);          y2g := Yinschermo(y2r);
            HHDC.Bitmap.MoveToF(x1g,y1g);   HHDC.Bitmap.LineToFS(x2g,y2g);
      			xstartwhile := xstartwhile+offerGr;
      			if ((x1g>wschermo) and (x2g>wschermo)) then break;
          end;
// mainform.ListBox1.Clear;
     		ystartwhile := ystart;
      			//		while (ystartwhile<yend) {
     			while (ystartwhile<yend) do begin
      			y1r := ystartwhile; x1r := xstart;  y2r := ystartwhile;   x2r := xend;
      			latlon50ToUtm(x1r,y1r) ;
      			latlon50ToUtm(x2r,y2r) ;
            x1g := Xinschermo(x1r);          x2g := Xinschermo(x2r);
            y1g := Yinschermo(y1r);          y2g := Yinschermo(y2r);
            HHDC.Bitmap.MoveToF(x1g,y1g);   HHDC.Bitmap.LineToFS(x2g,y2g);
      			ystartwhile := ystartwhile+offerGr;
      			if ((y1g<0) and (y2g<0)) then  break;
          end;

  	end;
     // gr_b4 globo D50


  	if (B_Griglia_cassini) then begin   // Cassini-Soldner
     TColor32Entry(AColor32).A := alfaGriglia;
      TColor32Entry(AColor32).R := GetRValue(GridColor5);
      TColor32Entry(AColor32).G := GetGValue(GridColor5);
      TColor32Entry(AColor32).B := GetBValue(GridColor5);
      HHDC.Bitmap.PenColor:= AColor32;
  	  xstart := xorigineVista; 	  xend   := xorigineVista+HHDC.Width*scalaVista;
  	  ystart := yorigineVista; 	  yend   := yorigineVista+HHDC.Height*scalaVista;
      offerGr := 100.0;
       case opzioneGr1 of
    		 0:
         begin
          DeltaX := xend-xstart;
          if (DeltaX / 100) < LimBarreAuto then begin offerGr := 100; end else
            begin
             if (DeltaX / 1000) < LimBarreAuto then begin offerGr := 1000; end else
               begin offerGr := 10000; end;
            end;
         end;
    		 1:	offerGr := 100;
    		 2:	offerGr := 1000;
    		 3:	offerGr := 10000;
       end;
  		utmtocatasto(xstart,ystart);
  		utmtocatasto(xend,yend);

  		xstart := (trunc(xstart/offerGr)*offerGr)-offerGr;	ystart := (trunc(ystart/offerGr)*offerGr)-offerGr;
  		xend := xend+offerGr;  yend:=yend+offerGr;
  		numbarre := round((xend-xstart)/offerGr);
  		if (numbarre>troppebarre) then begin  xstart := xend; ystart := yend;	end;
  		xstartwhile := xstart;
      Mainform.ListBox1.clear;
  		while (xstartwhile<xend)  do begin
  			x1r:=xstartwhile; y1r:=ystart;  x2r:=xstartwhile;   y2r:=yend;
  			catastotoutm(x1r,y1r) ;
  			catastotoutm(x2r,y2r) ;
        x1 := Xinschermo(x1r);        x2 := Xinschermo(x2r);
        y1 := Yinschermo(y1r);        y2 := Yinschermo(y2r);
        HHDC.Bitmap.MoveToF(x1,y1);   HHDC.Bitmap.LineToFS(x2,y2);
  			xstartwhile := xstartwhile+offerGr;
      end;
  		ystartwhile := ystart;
  		while (ystartwhile<yend) do begin
  			y1r:=ystartwhile; x1r:=xstart;  y2r:=ystartwhile;   x2r:=xend;
  			catastotoutm(x1r,y1r) ;
  			catastotoutm(x2r,y2r) ;
        x1 := Xinschermo(x1r);        x2 := Xinschermo(x2r);
        y1 := Yinschermo(y1r);        y2 := Yinschermo(y2r);
        HHDC.Bitmap.MoveToF(x1,y1);   HHDC.Bitmap.LineToFS(x2,y2);
  			ystartwhile := ystartwhile+offerGr;
      end;
    end;    // Cassini-Soldner
end;

procedure Seleziona                    (x1,y1 : real);
var k : Integer;
    locdisV: TDisegnoV;
begin
  for k:=0 to IlProgetto.ListadisegniV.Count-1 do
    begin
     locdisV := IlProgetto.ListadisegniV.Items[k];
     locdisV.seleziona_conPt(x1,y1,IlProgetto.ListaSelezionati);
    end;
end;

function SelezionaTesto                    (x1,y1 : real) : TTesto;
var k,j,m : Integer;
    locdisV: TDisegnoV;
    resulta : TTesto;
    locpiano : TPiano;
    locobj : TVettoriale;
    loctesto : TTesto;
    ListaSelezionati : TList;
begin
 ListaSelezionati := TList.Create;
 resulta := nil;
  for k:=0 to IlProgetto.ListadisegniV.Count-1 do
    begin
     locdisV := IlProgetto.ListadisegniV.Items[k];
     for j:= 0 to locdisV.ListaPiani.Count-1 do
      begin
       locpiano := locdisV.ListaPiani.items[j];
        for m:= 0 to locpiano.Listavector.Count-1 do
         begin
          locobj := locpiano.Listavector.items[m];
          if locobj.tipo<>PTesto then continue;
          loctesto := locpiano.Listavector.items[m];
          loctesto.seleziona_conPt(x1,y1,ListaSelezionati);
         end;
      end;
    end;
 if ListaSelezionati.count>0 then resulta := ListaSelezionati.items[0];
 ListaSelezionati.clear;
 ListaSelezionati.free;
 result := resulta;
end;


procedure selezInfo_conPt              (x1,y1 : real);
var k : Integer;
    locdisV: TDisegnoV;
begin
 IlProgetto.ListaInfo.clear;
  for k:=0 to IlProgetto.ListadisegniV.Count-1 do
    begin
     locdisV := IlProgetto.ListadisegniV.Items[k];
     locdisV.seleziona_conPt(x1,y1,IlProgetto.ListaInfo);
    end;

   if catastoselezonabile then
    begin
     for k:=0 to IlCatastoV.listaCXF.Count-1 do
      begin
       locdisV := IlCatastoV.listaCXF.Items[k];
       locdisV.seleziona_conPt(x1,y1,IlProgetto.ListaInfo);
      end;
    end;

  {
     if ILCatastoV.QUnione <> nil then
       begin
        ILCatastoV.QUnione.seleziona_conPt(x1,y1,IlProgetto.ListaInfo);
       end;
 }

  if IlProgetto.ListaInfo.count>0 then begin
   Ilprogetto.indToshow :=0;  Form_Info.show;  Form_Info.disegnacorrenteindice;
  end else
  begin Form_Info.hide;  end;
end;



function  selezionaVtconPt             : Boolean;
var locres : Boolean;
    off : real;
  	locdisvet : TDisegnoV;
    i : Integer;
begin
 locres := false;
 IlProgetto.ListaEditvt.Clear;
 off := give_offsetmirino;
 for i:=0 to IlProgetto.ListaDisegniV.Count-1 do
  begin
   locdisvet := IlProgetto.ListaDisegniV.items[i];
   if not (locdisvet.b_visibile) then continue;
	 if locdisvet.selezionaVtconPt(xcoordLast, ycoordLast, IlProgetto.ListaEditvt) then
    begin locres:=true; break; end;
  end;
 result := locres;
end;


function  selezionaCivicoPosconPt      : Boolean;
var locres : Boolean;
    off : real;
  	locdisvet : TDisegnoV;
    i : Integer;
begin
 locres := false;
 CivicoinEdit := nil;
 off := give_offsetmirino;
 for i:=0 to IlProgetto.ListaDisegniV.Count-1 do
  begin
   locdisvet := IlProgetto.ListaDisegniV.items[i];
	 if locdisvet.selezionaCivicoEditPt(xcoordLast, ycoordLast) then
    begin
     if CivicoinEdit<>nil then
      begin
       locres:=true;
       break;
      end;
    end;
  end;
 result := locres;
end;

procedure SpostaVerticeSelezionato   (newx,newy : Real);
var objvector: TVettoriale;
begin
 if IlProgetto.ListaEditvt.count>0 then
  begin
   objvector := IlProgetto.ListaEditvt.Items[0];
   objvector.SpostaVerticeSelezionato(IlProgetto.ListaEditvt,newx,newy);
  end;
end;



procedure InserisciVerticeSelezionato (newx,newy : Real);
var objvector: TVettoriale;
begin
 if IlProgetto.ListaEditvt.count>0 then
  begin
   objvector := IlProgetto.ListaEditvt.Items[0];
   objvector.InserisciVerticeSelezionato(IlProgetto.ListaEditvt,newx,newy);
  end;
end;





procedure CancellaVerticeSelezionato;
var objvector: TVettoriale;
begin
 if IlProgetto.ListaEditvt.count>0 then
  begin
   objvector := IlProgetto.ListaEditvt.Items[0];
   objvector.CancellaVerticeSelezionato(IlProgetto.ListaEditvt);
  end;
end;

procedure Match_conPt;
var locdis : TDisegnoV;
    i : Integer;
begin
	for i:=0 to IlProgetto.ListaDisegniV.Count-1 do
   begin
		locdis  := IlProgetto.ListaDisegniV.Items[i];
    if not(locdis.b_visibile) then continue;
    if locdis.Match_conPt(xcoordLast,ycoordLast) then begin IlProgetto.cambiadisegnocorrente(i); 	 break;  end;
   end;
end;


procedure SpostaSelezionati;
var i : Integer;
  	objvector : TVettoriale;
begin
	for i:=0 to IlProgetto.ListaSelezionati.count-1 do
    begin
  		objvector := IlProgetto.ListaSelezionati.Items[i];
  		objvector.Sposta(x2coord-x1coord,y2coord-y1coord);
    end;
end;

procedure CopiaSelezionati;
var i : Integer;
  	objvector : TVettoriale;
begin
	for i:=0 to IlProgetto.ListaSelezionati.count-1 do
    begin
  		objvector := IlProgetto.ListaSelezionati.Items[i];
  		objvector.Copia(x2coord-x1coord,y2coord-y1coord);
    end;
end;


procedure RuotaSelezionati;
var i : Integer;
  	objvector : TVettoriale;
  	angrot, dx, dy : Real;
begin
  	dx := x2coord-x1coord;	dy := y2coord-y1coord;
  	if ((dx=0) and (dy=0)) then exit;
  	if (dx=0) then begin angrot := PI/2;                if (dy<0) then angrot := angrot + PI;  end
              else
               begin
                angrot := arctan( dy / dx );
                if (dx<0)     then angrot := PI+angrot;
                if (angrot<0) then angrot := angrot + 2*PI;
               end;

	for i:=0 to IlProgetto.ListaSelezionati.count-1 do
    begin
  		objvector := IlProgetto.ListaSelezionati.Items[i];
  		objvector.Ruota(x1coord,y1coord,angrot);
    end;
end;


procedure ScalaSelezionati;
var i : Integer;
  	objvector : TVettoriale;
    scal, dx,dy,dd : Real;
begin
    dd := distsemplicefunz(x1coord,y1coord,x2coord,y2coord);
  	if (dd=0) then exit;
  	dd   := (dd / scalaVista);
  	scal := (dd / Hschermo)*10;

	for i:=0 to IlProgetto.ListaSelezionati.count-1 do
    begin
  		objvector := IlProgetto.ListaSelezionati.Items[i];
  		objvector.Scala(x1coord,y1coord,scal);
    end;
end;


procedure FondiDisegni;
var disbase , dis2 : TDisegnoV;
    k,j : Integer;
    locpiano : TPiano;
begin
 disbase := IlProgetto.ListaDisegniV.Items[0];
 for k:=1 to IlProgetto.ListaDisegniV.count-1 do
  begin
   dis2 := IlProgetto.ListaDisegniV.Items[k];
   for j:=1 to dis2.ListaPiani.Count-1 do
    begin
     locpiano:=dis2.ListaPiani.items[j];
     disbase.ListaPiani.Add(locpiano);
    end;
  end;
end;

procedure cercastradaBattente_CivicoinEdit;
var locdisV : TDisegnoV;
    k : Integer;
    locnom : String;
begin
 if  CivicoinEdit= nil then exit;
 for k:=0 to Ilprogetto.ListaDisegniV.Count-1 do
  begin
   locdisV:= Ilprogetto.ListaDisegniV.items[k];
   if (uppercase(locdisV.nomedisegnoconPath)=uppercase(NomefileStrade)) then
    begin
     locnom :=   locdisV.nomepianovicinopt(CivicoinEdit.x3c,CivicoinEdit.y3c);
     if locnom ='' then  locdisV.nomepianovicinopt(CivicoinEdit.x1c,CivicoinEdit.y1c);
     CivicoinEdit.nomestrada := locnom;
     break;
    end;
  end;
end;


procedure intoduciBattente_nomestrada;
var locdisV : TDisegnoV;
    k : Integer;
    locnom : String;
    locTesto : TTesto;
    disToPut : TDisegnoV;
    lopianotoPut : TPiano;
    indico: Integer;
begin
 disToPut :=  nil;
 if NomefileToponomastica= '' then begin showmessage('Definire nome dis Toponomastica');  exit; end;
 ApriDisegnoDaBottone(NomefileToponomastica);
 for k:=0 to ilprogetto.ListaDisegniV.count-1 do
  begin
    locdisV := ilprogetto.ListaDisegniV.Items[k];
    if (NomefileToponomastica = locdisV.nomedisegnoconPath) then
     begin disToPut := locdisV; end;
  end;

 if (disToPut =  nil) then begin showmessage('Assente dis Toponomastica'); exit; end;

 if not(disToPut.b_visibile) then disToPut.b_visibile:= true;


 for k:=0 to Ilprogetto.ListaDisegniV.Count-1 do
  begin
   locdisV:= Ilprogetto.ListaDisegniV.items[k];
   if (uppercase(locdisV.nomedisegnoconPath)=uppercase(NomefileStrade)) then
    begin
     locnom :=   locdisV.nomepianovicinopt(xcoordLast,ycoordLast);
     if locnom <>'' then
      begin
       locTesto := TTesto.Create;

       indico := disToPut.indicePianoconNome(locnom);
       if indico<0 then begin
        disToPut.addLayerCorrente(locnom);
        indico := disToPut.indPianocorrente;
       end;
       lopianotoPut :=disToPut.ListaPiani.items[indico];

       locTesto.Initer(disToPut,lopianotoPut);
       locTesto.initTestoStr(xcoordLast,ycoordLast,htestostrade,0.0,locnom);
       lopianotoPut.Listavector.Add(locTesto);
       locTesto._disegno.faiLimiti;
       ridisegna;
      end;
     break;
    end;
  end;
end;


procedure CopiaSelezionatialPianoCorrente;
var k : Integer;
    locvet,locvetcopia : Tvettoriale;
begin
 for k:=0 to IlProgetto.ListaSelezionati.Count-1 do
  begin
   locvet := IlProgetto.ListaSelezionati.items[k];
   locvetcopia := locvet.copiapura;
   locvetcopia.initer(IlProgetto.DisegnoVCorrente,IlProgetto.PianoVCorrente);
   IlProgetto.PianoVCorrente.Listavector.Add(locvetcopia);
  end;
  IlProgetto.DisegnoVCorrente.faiLimiti;
end;

procedure  CopiaParticelleinConcessione;
var k : Integer;
    locvet,locvetcopia : Tvettoriale;
    illodis : TDisegnoV;
    illopia : TPiano;
    locPartConc : TPartConc;
    nomefoglio : String;
    locterDato : TTercatDati;
begin
 illodis := IlProgetto.DisegnoVCorrente;
 for k:=0 to IlProgetto.ListaSelezionati.Count-1 do
  begin
   locvet := IlProgetto.ListaSelezionati.items[k];
   locvetcopia := locvet.copiapura;

   illodis.addLayerCorrente(locvet._disegno.nomeFoglioCXF+'_'+locvet._piano.nomepiano);
   illopia := illodis.ListaPiani.Items[illodis.indPianocorrente];

   illopia.setcolorpianorgb(230,160,0);
   locvetcopia.initer(illodis,illopia);
   illopia.Listavector.Add(locvetcopia);

   locPartConc := TPartConc.create;
   ContrattoCorrente.ListaParteParticelle.Add(locPartConc);
   locPartConc.idparticella:=IntTostr(illodis.ListaPiani.count);
   locPartConc.idcontratto := ContrattoCorrente.idcontratto;
//   showmessage(locvet._disegno.nomedisegno);
//   showmessage(locvet._disegno.nomeFoglioCXF);
   locPartConc.Fg   := locvet._disegno.nomeFoglioCXF;
//   showmessage('Memo '+locPartConc.Fg);
   locPartConc.Part := locvet._piano.nomepiano;
   locPartConc.MioPart    :='';

   locterDato := GliImmobiliDati.TerDatoFgPart(locvet._disegno.nomeFoglioCXF,locvet._piano.nomepiano);

   if locterDato <>nil then
    begin
     locPartConc.Sup        := IntToStr(locterDato.Superficie);
     locPartConc.Categoria  := locterDato.Qualita;
     locPartConc.classe     := locterDato.Classe;
    end;

   locPartConc.loctributo :='';


  end;
  illodis.faiLimiti;
  Ilprogetto.ListaSelezionati.clear;
  ridisegna;
  ridisegnainterfaccia;
  updateNumSelezionati;
end;


end.





