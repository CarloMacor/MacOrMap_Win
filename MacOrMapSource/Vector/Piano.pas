unit Piano;

interface

uses windows, DisegnoV ,System.classes , GR32, GR32_Image, GR32_Layers  ,sysutils   ,FMX.Dialogs, Vcl.Graphics;



type
 TPiano = class
  _Disegno        : TDisegnoV;
  Listavector    : TList;
  nomepiano      : String;
	commentopiano  : String;
	nomedbase      : String;
	nometavola     : String;
  limx1          : Real;
  limx2          : Real;
  limy1          : Real;
  limy2          : Real;
  b_visibile     : boolean;
	b_editabile    : boolean;
  b_snappabile   : boolean;
	alfalinee      : Integer;
  alfasuperfici  : Integer;

  _rosso,_verde,_blu : Integer;

  Color32Bordo   : TColor32;
  Color32Dentro  : TColor32;

	spessoreline   : Integer;
	i_colore       : Integer;
	i_tratteggio   : Integer;
	i_campitura    : Integer;
	i_Simbolo      : Integer;
	scalatratto    : Real;
  dimpunto       : Integer;
	scalaminvista  : Real;
	scalamaxvista  : Real;

  b_connessodbase : Boolean;
  b_dispallinivt  : Boolean;
  b_dispallinivtfinali : Boolean;

   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   InitPiano(ildis : TDisegnoV);
   procedure   setnomepiano(_nome: String);
   procedure	 setcolorpianorgb(_r,_g,_b : integer);
   function    testinternoschermo : Boolean;


   procedure   Disegna       (HHDC : TImage32; alfaL,alfaS : Integer);
   procedure   DisegnaCatasto(HHDC : TImage32; alfaL,alfaS : Integer ) ;

   procedure   faipunto      (HHDC : TImage32; x1,y1 : Real; Undor : Pointer);
   procedure   faiplinea     (HHDC : TImage32; x1,y1 : Real; var fase : Integer; Undor : Pointer);
   procedure   faicerchio    (HHDC : TImage32; x1,y1,x2,y2 : Real; Undor : Pointer);
   procedure   fairettangolo (HHDC : TImage32; x1,y1,x2,y2 : Real; Undor : Pointer);
   procedure   fairegione    (HHDC : TImage32; x1,y1 : Real; fase ,fasereg: Integer; Undor : Pointer);
   procedure   faiCivico     (HHDC : TImage32; x1 , y1, x2, y2, x3, y3 : real; txtCiv : String);


   procedure   faiLimiti;
   procedure   UpdateLimiti(x,y : Real);

   procedure   dxfinobjexecute(tipoelemento : Integer);
   procedure   dxfinPianoK (FF : TStringList; var IR : Integer ;  tipoelem :Integer);
   procedure   svuotabooldxf;
   procedure   cxfinPiano2 (FF : TStringList; var IR : Integer ; _tt: String);



   procedure   disegnavtpl       (HHDC : TImage32);
   procedure   disegnavtfinalipl (HHDC : TImage32);
   procedure   disegnailpianino  (HHDC : TImage32);

   function    snapFine          ( x1, y1 : Real) : Boolean;
   function    snapVicino        ( x1, y1 : Real) : Boolean;
   procedure   ortosegmenta      ( x1, y1 : Real);

   procedure   mettitratteggio   (HHDC : TImage32; tipotratt : Integer);

   function    nomeFogliopiano      : String;
   function    nomepianoNoPlus      : String;
   function    NumObjpianoNotErased : Integer;
   function    pianoPlus            : Boolean;
   function    isTerreno            : Boolean;



   procedure   SpostaPiano          (dx, dy : Real);
   procedure   RuotaPiano           (dx, dy, angrot : Real);
   procedure   ScalaPiano           (dx, dy, scal   : Real);


   procedure   seleziona_conPt         (x1,y1 : Real;  _LSelezionati: TList);
   procedure   seleziona_conPtInterno  (x1,y1 : Real;  _LSelezionati: TList);
   function    selezionaCivicoEditPt   (xc, yc : real) : Boolean;

   function    Match_conPt             (x1, y1: Real) : Boolean;
   function    selezionaVtconPt        (x1, y1 : Real;  _LSelezionati: TList) : Boolean;


   procedure  DisSpostaPiano   (HHDC : TImage32; dx,dy : Real);
   procedure  DisRuotaPiano    (HHDC : TImage32; xc,yc,ang: real);
   procedure  DisScalaPiano    (HHDC : TImage32; xc,yc,scal: real);
   procedure  Distxtvirtual    (HHDC : TImage32; xc,yc,ang,scal: real);
   procedure  settacolorepiano (HHDC : TImage32; alfaL , alfaS : Integer);
   function   dispallinivt     : Boolean;
   function   dispallinivtfinali : Boolean;

   procedure  faisimbolo       (HHDC : TImage32; x1 , y1 : real; indice  : Integer; dimfissa : Boolean;
                                listadefinizioni: TList; nomelista: String;  _scalaSimb:real; _angrot:real);
   procedure  ruotasimbolo     (HHDC : TImage32; rot : Real);
   procedure  scalasimbolo     (HHDC : TImage32; sca : Real);
   procedure  faitesto         (HHDC : TImage32; x1,y1,ht,ang : real;  txttesto : String);
   procedure  releasetestoincostruzione;
   procedure  faitestovirtuale (ht,ang : Real;  txttesto : String);
   procedure  faicolorepianoint(_value : integer);
   procedure  finitaPolilinea  (HHDC : TImage32);
   procedure  chiudipoligono   (HHDC : TImage32);
   procedure  updateEventualeRegione (HHDC : TImage32);
   procedure  BackPlineaAdded;
   procedure  cancellaultimovt;
   procedure  salvapianoMacMap     (_data : TmemoryStream);
   procedure  apripianoMacMap      (_data : TmemoryStream);
   procedure  cambianomedbase   (_newtext : String);
   procedure  cambianomeTavola  (_newtext : String);

   procedure  shpin              (_nomedisegno : String);
   procedure  creadefsimbolo     (listadefsimboli : TList; indice : integer);
   procedure  salvadxf;
   procedure  settratteggio      (indtratto : integer);
   procedure  setCampitura       (indcamp   : Integer);
   procedure  svuota;
   procedure  smemora;
   procedure  CatToUtm;
   procedure  TestoAltoQU        (toLayer : Tpiano);

   procedure  EliminaPuntiDoppiNelPiano;
   function   quantiNonCancellati : Integer;

   procedure  tuttoPenDownPolyline;
   function   nomepianovicinopt(xa,ya : Real) : String;

   procedure  PolyToPoligoni;

 end;

var ilPiano       : TPiano;
    Pianocorrente : TPiano;

implementation

uses Vettoriale   , proiezioni
, Punto ,Polylinea, varbase, Testo  , cerchio , simbolo ,Civico
;

var  dxf_01, dxf_02 : String;

     dxf_10, dxf_20, dxf_30 : real;
     dxf_11, dxf_21, dxf_31 : real;
     dxf_40, dxf_41, dxf_42 : real;
     dxf_50, dxf_51, dxf_70 : real;
     dxf_73 : real;
     b_dxf_10, b_dxf_20, b_dxf_30 : boolean;
     b_dxf_40 : boolean;



Constructor  TPiano.Create;
begin
  _Disegno        := nil;
  Listavector    := TList.Create;
	nomepiano      := '';
	commentopiano  := '';
	nomedbase      := '';
	nometavola     := '';
  limx1          :=0.0;
  limx2          :=0.0;
  limy1          :=0.0;
  limy2          :=0.0;
  b_visibile     :=true;
	b_editabile    :=true;
  b_snappabile   :=true;
	alfalinee      :=130;
  alfasuperfici  :=125;
  _rosso         :=0;
  _verde         :=0;
  _blu           :=0;

	spessoreline   :=1;
	i_colore       :=0;
	i_tratteggio   :=0;
	i_campitura    :=0;
	i_Simbolo      :=0;
	scalatratto    :=1.0;
  dimpunto       :=3;
	scalaminvista  :=0.0;
	scalamaxvista  :=100000;

  b_connessodbase :=false;
  b_dispallinivt  :=false;
  b_dispallinivtfinali :=false;

end;


Destructor  TPiano.Done;
begin
end;


procedure   TPiano.setnomepiano(_nome: String);
begin
  nomepiano := _nome;
end;

procedure	 TPiano.setcolorpianorgb(_r,_g,_b : integer);
begin
  _rosso      :=_r;
  _verde      :=_g;
  _blu        :=_b;
end;


procedure   TPiano.InitPiano(ildis : TDisegnoV);
begin
 _Disegno := ildis ;
end;

function    TPiano.testinternoschermo : Boolean;
var locres : Boolean;
begin
	locres := True;
	if (limx2<xOrigineVista) then locres := false;
	if (limx1>x2OrigineVista) then locres := false;
	if (limy1>y2OrigineVista) then locres := false;
	if (limy2<yOrigineVista) then locres := false;
	result := locres;
end;

procedure   TPiano.DisegnaCatasto(HHDC : TImage32; alfaL,alfaS : Integer ) ;
var  locvector : TVettoriale;
     i : Integer;
     AColor32: TColor32;
begin
	if not(b_visibile) then exit;
  if not(testinternoschermo) then exit;
    TColor32Entry(AColor32).A := (alfaL*alfalinee) div 255;
    TColor32Entry(AColor32).R := _rosso;
    TColor32Entry(AColor32).G := _verde;
    TColor32Entry(AColor32).B := _blu;
    TColor32Entry(Color32Bordo).A := (alfaL*alfalinee) div 255;
    TColor32Entry(Color32Bordo).R := _rosso;
    TColor32Entry(Color32Bordo).G := _verde;
    TColor32Entry(Color32Bordo).B := _blu;
    TColor32Entry(Color32Dentro).A := (alfaS*alfasuperfici) div 255;
    TColor32Entry(Color32Dentro).R := _rosso;
    TColor32Entry(Color32Dentro).G := _verde;
    TColor32Entry(Color32Dentro).B := _blu;
 HHDC.Bitmap.Canvas.Pen.Color:=RGB(_rosso,_verde,_blu) ;
 HHDC.Bitmap.Canvas.Font.Color:=RGB(_rosso,_verde,_blu) ;
 HHDC.Bitmap.Canvas.Brush.Style:=bsClear;
//  HHDC.Bitmap.canvas.pen.style := psDot;

 HHDC.Bitmap.Canvas.Pen.Width :=spessoreline;

	for i:=0 to Listavector.count-1 do
   begin
		locvector  :=  Listavector.Items[i];
    if locvector.b_erased then continue;
		if not (locvector.testinternoschermo) then begin continue; end;
    if not(TxtCatastoOnOff) then begin if locvector.tipo=PTesto then continue;  end;
		locvector.disegna(HHDC);
   end;
end;

procedure   TPiano.Disegna(HHDC : TImage32; alfaL,alfaS : Integer ) ;
var  locvector : TVettoriale;
     i : Integer;
     AColor32: TColor32;
begin

	if not(b_visibile) then exit;
  if not(testinternoschermo) then exit;

    TColor32Entry(AColor32).A := (alfaL*alfalinee) div 255;
    TColor32Entry(AColor32).R := _rosso;
    TColor32Entry(AColor32).G := _verde;
    TColor32Entry(AColor32).B := _blu;

    TColor32Entry(Color32Bordo).A := (alfaL*alfalinee) div 255;
    TColor32Entry(Color32Bordo).R := _rosso;
    TColor32Entry(Color32Bordo).G := _verde;
    TColor32Entry(Color32Bordo).B := _blu;

    TColor32Entry(Color32Dentro).A := (alfaS*alfasuperfici) div 255;
    TColor32Entry(Color32Dentro).R := _rosso;
    TColor32Entry(Color32Dentro).G := _verde;
    TColor32Entry(Color32Dentro).B := _blu;

 HHDC.Bitmap.Canvas.Pen.Color:=RGB(_rosso,_verde,_blu) ;
 HHDC.Bitmap.Canvas.Font.Color:=RGB(_rosso,_verde,_blu) ;
 HHDC.Bitmap.Canvas.Brush.Style:=bsClear;
//  HHDC.Bitmap.canvas.pen.style := psDot;

 HHDC.Bitmap.Canvas.Pen.Width :=spessoreline;

	for i:=0 to Listavector.count-1 do
   begin
		locvector  :=  Listavector.Items[i];
    if locvector.b_erased then continue;
		if not (locvector.testinternoschermo) then continue;
		locvector.disegna(HHDC);
   end;
end;


procedure   TPiano.disegnailpianino (HHDC : TImage32);
var  locvector : TVettoriale;
     i : Integer;
begin
(*
  	[self settacolorepiano :hdc :1.0 : 1.0];
  // qui creare un nuovo info da passare con origine e scala modificata
  // superflui in info i 3 parametri vettorino aggiunti
  	InfoObj  *IlloInfo = [InfoObj alloc];
  	[self faiLimiti];
  	[IlloInfo  setLimitiDisV :limx1 : limy1 : limx2 : limy2];
  	[IlloInfo setZoomAllVector];

  	[IlloInfo set_origineVista:limx1 :limy1 ];
  	double locscal,locscal2;
  	locscal  = (limx2-limx1)/fondo.size.width;
  	locscal2 = (limy2-limy1)/fondo.size.height;
      if (locscal<locscal2) locscal=locscal2;
  	[IlloInfo set_scalaVista  :locscal ];
*)

 	for i:=0 to Listavector.count-1 do
   begin
		locvector  :=  Listavector.Items[i];
		if not (locvector.testinternoschermo) then continue;
		locvector.disegna(HHDC);
   end;

end;








procedure   TPiano.faipunto(HHDC : TImage32; x1,y1 : Real; Undor : Pointer);
var locpunto : TPunto;
begin
	locpunto := TPunto.Create;
  locpunto.Initer(self._Disegno,self);
  locpunto.InitPunto(x1,y1);
	Listavector.Add(locpunto);

	self.UpdateLimiti(x1-1,y1-1);
	self.UpdateLimiti(x1+1,y1+1);

//	[self settacolorepiano :hdc :[_disegno alphaline] : [_disegno alphasup] ];
//	CGContextSetLineWidth(hdc, [self getspessore ] );
	locpunto.Disegna(HHDC); // :info];
  HHDC.Repaint;
//	[[Undor prepareWithInvocationTarget:locpunto] cancella];
end;

procedure   TPiano.faiCivico     (HHDC : TImage32; x1 , y1, x2, y2, x3, y3 : real; txtCiv : String);
var locCivico : TCivico;
begin
	locCivico := TCivico.Create;
  locCivico.Initer(self._Disegno,self);
  locCivico.InitCivico(x1,y1,x2,y2,x3,y3,txtCiv);
	Listavector.Add(locCivico);

	self.UpdateLimiti(x1,y1);
	self.UpdateLimiti(x2,y2);
	self.UpdateLimiti(x3,y3);

	locCivico.Disegna(HHDC);
  CivicoinEdit := locCivico;
  HHDC.Repaint;
end;



procedure   TPiano.faiplinea(HHDC : TImage32; x1,y1 : Real; var fase : Integer; Undor : Pointer);
begin
 case fase of
  0 : begin
		Polyincostruzione := nil;
		Polyincostruzione := TPolylinea.Create;
    Polyincostruzione.initer(self._Disegno,self);
    Polyincostruzione.InitPolilinea(false);
    inc(fase);
  end;
  1 : begin
	  Listavector.Add(Polyincostruzione);
    inc(fase);
  end;
 end;

	Polyincostruzione.addvertex(x1,y1);
 	self.UpdateLimiti(x1,y1);
  _Disegno.UpdateLimiti(x1,y1);

  Polyincostruzione.Disegna(HHDC);
//	CGContextSetLineWidth(hdc, [self getspessore ]  );
//	[self settacolorepiano :hdc :[_disegno alphaline] : [_disegno alphasup] ];
//	Polyincostruzione. Disegna:hdc :info];

		//	[[Undor prepareWithInvocationTarget:Polyincostruzione] cancellaultimovt];


end;


procedure   TPiano.fairegione    (HHDC : TImage32; x1,y1 : Real; fase ,fasereg: Integer; Undor : Pointer);
begin
	if (fase=0) then
   begin
    Polyincostruzione := TPolylinea.create; 	Polyincostruzione.initer(_disegno,self); Polyincostruzione.InitPolilinea(true);
   end;
	if (fase=1) then Listavector.Add(Polyincostruzione);
	if (fase=0) then Polyincostruzione.addvertex(x1,y1) else
   begin
//	  if (fasereg=1) then Polyincostruzione.addvertex(x1,y1)
//                   else
    Polyincostruzione.addvertex(x1,y1);
   end;
	fasereg:=0;
 	self.UpdateLimiti(x1,y1);
 //	Polyincostruzione.Disegna(HHDC);
end;



procedure   TPiano.faicerchio    (HHDC : TImage32; x1,y1,x2,y2 : Real; Undor : Pointer);
var loccerchio : TCerchio;
begin
	loccerchio := Tcerchio.Create;	loccerchio.Initer(_disegno,self);
	loccerchio.InitCerchio(x1,y1,x2,y2);
	Listavector.add(loccerchio);
	_disegno.faiLimiti;
	loccerchio.Disegna(HHDC);
//	[[MUndor prepareWithInvocationTarget:loccerchio] cancella];
end;

procedure   TPiano.fairettangolo (HHDC : TImage32; x1,y1,x2,y2 : Real; Undor : Pointer);
begin
  Polyincostruzione := TPolylinea.create;
  Polyincostruzione.Initer(_disegno,self);
  Polyincostruzione.InitPolilinea(true);
	Listavector.Add(Polyincostruzione);
	Polyincostruzione.addvertexUp(x1,y1);
	Polyincostruzione.addvertex(x2,y1);
	Polyincostruzione.addvertex(x2,y2);
	Polyincostruzione.addvertex(x1,y2);
	Polyincostruzione.addvertex(x1,y1);
	_disegno.faiLimiti;
	Polyincostruzione.Disegna(HHDC);
//	[[MUndor prepareWithInvocationTarget:Polyincostruzione] cancella];

end;




procedure   TPiano.faiLimiti;
var 	vet      : TVettoriale;
      iniziato : Boolean;
      i : Integer;
begin
  limx1:=0; limx2:=0; limy1:=0;  limy2:=0;
  iniziato := false;
	for i:=0 to Listavector.count-1 do begin
    vet := Listavector.Items[i];
    if (vet.cancellato) then continue;
    vet.faiLimiti;
  if not(iniziato) then
   begin
    limx1 :=vet.limx1;	   limx2 := vet.limx2; 	   limy1 := vet.limy1;	   limy2 :=vet.limy2;  iniziato := true;
   end
   else
   begin
    if (limx1>vet.limx1) then limx1:=vet.limx1;
    if (limy1>vet.limy1) then limy1:=vet.limy1;
    if (limx2<vet.limx2) then limx2:=vet.limx2;
    if (limy2<vet.limy2) then limy2:=vet.limy2;
   end;
  end;
end;


procedure   TPiano.UpdateLimiti(x,y : Real);
begin
 if limx1=0.0 then limx1:=x; if limx2=0.0 then limx2:=x;
 if limy1=0.0 then limy1:=y; if limy2=0.0 then limy2:=y;
 if limx1>x  then limx1:=x;
 if limx2<x  then limx2:=x;
 if limy1>y  then limy1:=y;
 if limy2<y  then limy2:=y;
 if _disegno<>nil then _disegno.UpdateLimiti(x,y);
end;




procedure TPiano.dxfinobjexecute(tipoelemento : Integer);
var  locpunto : TPunto;
     loccerchio : TCerchio;
//	Testo *loctesto;
//	Cerchio *loccerchio;
//	Simbolo *locsimbolo;
//	Arco    *locarco;
begin
 //  if not(b_dxf_10 and b_dxf_20) then exit;

 case  tipoelemento of
	 1: begin
       locpunto := TPunto.Create;	locpunto.initer(_disegno,self);
			 locpunto.InitPunto(dxf_10,dxf_20);		Listavector.Add(locpunto);
      end;
	 4: begin
       if (b_dxf_10 and b_dxf_20) then
        begin
         locpunto := TPunto.Create;	locpunto.initer(_disegno,self);
  			 locpunto.InitPunto(dxf_10,dxf_20);		Listavector.Add(locpunto);
        end;
      end;

   5 : begin
       if (b_dxf_10 and b_dxf_20 and b_dxf_40) then
        begin
         loccerchio := Tcerchio.Create;	loccerchio.initer(_disegno,self);
  			 loccerchio.InitCerchio(dxf_10,dxf_20,dxf_10,dxf_20+dxf_40);		Listavector.Add(loccerchio);
        end;
   end;


  20: begin
 		   Polyincostruzione := TPolylinea.Create; 	Polyincostruzione.initer(_disegno,self);  Polyincostruzione.InitPolilinea(false);
			 Listavector.Add(Polyincostruzione);
  		 Polyincostruzione.addvertex(dxf_10,dxf_20);
  		 Polyincostruzione.addvertex(dxf_11,dxf_21);
      end;
 101 : begin Polyincostruzione.addvertex(dxf_10,dxf_20);end;
   2 : begin
  		  Polyincostruzione := TPolylinea.Create;
  		  Polyincostruzione.initer(_disegno,self);
  		  Polyincostruzione.InitPolilinea(false);
  			if ((dxf_70=1) or (dxf_70=3) or  (dxf_70=9) or (dxf_70=17) or (dxf_70=33) or (dxf_70=65) or (dxf_70=129)) then
         begin
  			  Polyincostruzione. polyinpoligono;
         end;
  	     Listavector.Add(Polyincostruzione);
       end;
  end;
 svuotabooldxf;
end;


procedure TPiano.svuotabooldxf;
begin
   b_dxf_10 := false;
   b_dxf_20 := false;
   b_dxf_30 := false;
   b_dxf_40 := false;
   dxf_50 :=0;
 //  tipoelemento := -1;
end;


(*



  	switch  {

  		case 6:
  			loctesto = [Testo alloc];
  			[loctesto Init:_disegno : self];
  			[loctesto InitTestoStr:dxf_10 : dxf_20 : dxf_40 : dxf_50 :dxf_01];
  			[Listavector addObject:loctesto];
  			break;
  		case 3:

  			break;

          case 7:
  			locarco = [Arco alloc];
  			[locarco Init:_disegno : self];
  		    [locarco InitArco:dxf_10:dxf_20:dxf_40:dxf_50:dxf_51];
  			[Listavector addObject:locarco];
  			break;
  		case 5:
  			loccerchio = [Cerchio alloc];	[loccerchio Init:_disegno : self];
  			[loccerchio InitCerchio:dxf_10:dxf_20:dxf_10:dxf_20+dxf_40];
  			[Listavector addObject:loccerchio];
  			break;
          case 21:
  	        [Polyincostruzione addvertex:dxf_10:dxf_20:0 ]; break;
  		default:	break;
  	}

  }


*)

(*
  	 if ([tt isEqualToString:@"POINT"])      { tipoelemento= 1;  }
  	 if ([tt isEqualToString:@"INSERT"])     { tipoelemento= 4;  }
  	 if ([tt isEqualToString:@"LINE"])       { tipoelemento=20;  }
  	 if ([tt isEqualToString:@"VERTEX"])     { tipoelemento=101;  }
  	 if ([tt isEqualToString:@"POLYLINE"])   { tipoelemento= 2;  }
  	 if ([tt isEqualToString:@"CIRCLE"])     { tipoelemento= 5;  }
  	 if ([tt isEqualToString:@"SEQEND"])     { tipoelemento= 3;  }
  	 if ([tt isEqualToString:@"TEXT"])       { tipoelemento= 6;  }
  	 if ([tt isEqualToString:@"ARC"])        { tipoelemento= 7;  }
  	 if ([tt isEqualToString:@"LWPOLYLINE"]) { tipoelemento= 1000;  }
  	 if ([tt isEqualToString:@"HATCH"])      { tipoelemento= 1001;  }
*)



procedure   TPiano.dxfinPianoK (FF : TStringList; var IR : Integer ;  tipoelem :Integer);
var numgiri : Integer;
    tt, _tt : String;
 	  numvtlwpoly,flag70,flag72 : Integer;
    doit  : Boolean;
  	x1star , y1star : Real;
    i : Integer;
    primovt : Boolean;
    newx1, newy1 : Real;
    formatSettings : TFormatSettings;
begin
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, formatSettings);

// ShowMessage(CurrToStrF(1234.56, ffCurrency, 4, formatSettings));
// exit;
  tt := '';
  doit := false;
    case tipoelem of
        1  , 4 , 20 ,  2,  101 , 5 , 3 ,  6 ,  7,  1000, 1001
        : doit := true;
        else      begin  doit := false;   end;
    end;

    if not(doit) then exit;

    while (doit) do
     begin
   //     if IR>= FF.Count-1 then exit;
      if ((tipoelem<1000) and (tipoelem<>5))  then  // 5 = cerchio
       begin
        _tt := FF[IR]; inc(IR);
    		 if (( _tt ='  0') or  (_tt = '   0') ) then
         begin
          dec(IR);
          dxfinobjexecute(tipoelem); doit:=false; continue;
         end;
  		  if ( _tt ='  1') then begin  dxf_01 := FF[IR]; inc(IR);     end;
  		  if ( _tt ='  2') then begin  dxf_02 := FF[IR]; inc(IR);     end;
  		  if ( _tt =' 10') then begin  _tt    := FF[IR]; inc(IR); dxf_10 := strToFloat(_tt); b_dxf_10:=true;   end;
  		  if ( _tt =' 20') then begin  _tt    := FF[IR]; inc(IR); dxf_20 := strToFloat(_tt); b_dxf_20:=true;   end;
  		  if ( _tt =' 30') then begin  _tt    := FF[IR]; inc(IR); dxf_30 := strToFloat(_tt);    end;
  		  if ( _tt =' 40') then begin  _tt    := FF[IR]; inc(IR); dxf_40 := strToFloat(_tt);    end;
  		  if ( _tt =' 50') then begin  _tt    := FF[IR]; inc(IR); dxf_50 := strToFloat(_tt);    end;
  		  if ( _tt =' 70') then begin  _tt    := FF[IR]; inc(IR); dxf_70 := strToFloat(_tt);    end;
  		  if ( _tt =' 11') then begin  _tt    := FF[IR]; inc(IR); dxf_11 := strToFloat(_tt);    end;
  		  if ( _tt =' 21') then begin  _tt    := FF[IR]; inc(IR); dxf_21 := strToFloat(_tt);    end;
  		  if ( _tt =' 31') then begin  _tt    := FF[IR]; inc(IR); dxf_31 := strToFloat(_tt);    end;
  		  if ( _tt =' 41') then begin  _tt    := FF[IR]; inc(IR); dxf_41 := strToFloat(_tt);    end;
  		  if ( _tt =' 51') then begin  _tt    := FF[IR]; inc(IR); dxf_51 := strToFloat(_tt);    end;
  		  if ( _tt =' 42') then begin  _tt    := FF[IR]; inc(IR); dxf_42 := strToFloat(_tt);    end;
       end;

   		 if (tipoelem = 5) then
       begin
        _tt := FF[IR]; inc(IR);
  		  if ( _tt =' 10') then begin  _tt    := FF[IR]; inc(IR); dxf_10 := strToFloat(_tt); b_dxf_10:=true;   end;
  		  if ( _tt =' 20') then begin  _tt    := FF[IR]; inc(IR); dxf_20 := strToFloat(_tt); b_dxf_20:=true;   end;
  		  if ( _tt =' 40') then begin  _tt    := FF[IR]; inc(IR); dxf_40 := strToFloat(_tt); b_dxf_40:=true;   end;


    		 if (( _tt ='  0') or  (_tt = '   0') ) then
         begin dec(IR);  dxfinobjexecute(tipoelem);

          doit:=false; continue;  end;

       end;

   		 if (tipoelem = 1000) then
       begin
  			flag70 :=0;
  			Polyincostruzione := TPolylinea.create;
  			Polyincostruzione.initer(_disegno,self);
  			Polyincostruzione.InitPolilinea(false);
  			Listavector.Add(Polyincostruzione);
        tt := FF[IR]; inc(IR);
        OutputDebugString(pchar(tt));

  			while not(tt =' 90') do  begin
         tt := FF[IR]; inc(IR);
        end;
        tt := FF[IR]; inc(IR);
  			numvtlwpoly := StrToInt(tt);
   //     showmessage(tt);
   //     OutputDebugString(pchar('_'+tt));

  			while (numvtlwpoly>0) do
         begin
          tt := FF[IR]; inc(IR);
  				if (tt ='ENDSEC') then break;

  				if (tt = ' 70')then begin
            tt := FF[IR]; inc(IR);
  					flag70 :=  strToInt(tt);
  					if ((flag70=1) or (flag70=3) or  (flag70=9) or (flag70=17) or (flag70=33) or (flag70=65) or (flag70=129))
  					then Polyincostruzione.polyinpoligono;
          end;
  				if (tt =' 10') then begin
            tt := FF[IR]; inc(IR);
  					dxf_10 := strToFloat(tt);
          end;
  				if (tt = ' 20')  then
           begin
            tt := FF[IR]; inc(IR);
  					dxf_20 := strToFloat(tt);
  					Polyincostruzione.addvertex(dxf_10,dxf_20);		dec(numvtlwpoly);
           end;
         end;
     		svuotabooldxf;
        doit:=false;
  		 end;


   		 if (tipoelem =1001) then
       begin

  			numgiri := 1;		flag70  :=0;
        tt := FF[IR]; inc(IR);


  			while not(tt = ' 91') do begin tt := FF[IR]; inc(IR); end;
        tt := FF[IR]; inc(IR);
  			numgiri := StrToInt(tt);

  			Polyincostruzione := TPolYlinea.create;
  			Polyincostruzione.initer(_disegno,self);
  			Polyincostruzione.InitPolilinea(true);
  			Listavector.Add(Polyincostruzione);
//  			if (numgiri>1) then Polyincostruzione.set setregione : YES];

  //      showmessage(IntTostr(numgiri));


  			for i:=0 to numgiri-1 do
         begin
  				primovt := true;
  				flag72 :=1;
  				while not (tt=' 93') do begin tt := FF[IR]; inc(IR);  end;
          tt := FF[IR]; inc(IR);
  				numvtlwpoly := StrToInt(tt);

//          showmessage('Giro :'+IntTostr(i)+' vt = '+IntTostr(numvtlwpoly));

  				while (numvtlwpoly>0) do
           begin
            tt := FF[IR]; inc(IR);
  					if (tt =' 70') then begin tt := FF[IR]; inc(IR); flag70 :=  StrToInt(tt); end;
  					if (tt =' 72') then begin tt := FF[IR]; inc(IR); flag72 :=  StrToInt(tt); end;
  					if (tt =' 10') then begin tt := FF[IR]; inc(IR); dxf_10 :=  StrToFloat(tt); end;
  					if (tt =' 20') then
            begin
             tt := FF[IR]; inc(IR); dxf_20 :=  StrToFloat(tt);
  					 if (flag72 <>2) then
              begin
  							if (primovt) then begin  if (i>0) then Polyincostruzione.addvertexUp(dxf_10,dxf_20);  end;
                x1star := dxf_10; y1star := dxf_20; primovt:=false;
  							Polyincostruzione.addvertex(dxf_10,dxf_20);
               	dec(numvtlwpoly);
              end;

(*
    					 if (flag72=2) then
                begin
      				  	if (tt =' 40') then begin tt := FF[IR]; inc(IR);  dxf_40 :=  StrToFloat(tt); end;
      				  	if (tt =' 50') then begin tt := FF[IR]; inc(IR);  dxf_50 :=  StrToFloat(tt); end;
      				  	if (tt =' 51') then begin tt := FF[IR]; inc(IR);  dxf_51 :=  StrToFloat(tt); end;

      					  if (tt =' 73') then begin tt := FF[IR]; inc(IR);  dxf_73 :=  StrToFloat(tt);
    						  	dxf_50 := dxf_50*PI/180;                   dxf_51 := dxf_51*PI/180;
    							if (dxf_73=0) then begin dxf_50 := - dxf_50;  dxf_51 := -dxf_51;  end;

    							newx1 := dxf_40*cos(dxf_50);           newy1 := dxf_40*sin(dxf_50);
    							if (primovt) then
                   begin
                     if (i>0)  then begin Polyincostruzione.addvertexUp(dxf_10+newx1+newy1,dxf_20); end;
                   end;
     								x1star := dxf_10+newx1; y1star := dxf_20+newy1; primovt:=false;
                   end;
    							Polyincostruzione.addvertex(dxf_10+newx1,dxf_20+newy1);
    							newx1 := dxf_40*cos(dxf_51);           newy1 := dxf_40*sin(dxf_51);
    							Polyincostruzione.addvertex(dxf_10+newx1,dxf_20+newy1);
    							dec(numvtlwpoly);
                end;
             end;

                *)



            end;
           end;
         end;

//  				[Polyincostruzione addvertex:x1star:y1star:0 ];
//  			if (numgiri>1)then begin Polyincostruzione.addvertexUpHereToStart;  Polyincostruzione.updateRegione;  end;

        doit:=false;
   		  svuotabooldxf;
       end;

     end;
end;


procedure   TPiano.disegnavtpl       (HHDC : TImage32);
var  objvector :	TVettoriale; i : Integer;
begin
	if (Not b_visibile) then exit;
	for i:=0 to  Listavector.count-1 do
   begin
		objvector  :=  Listavector.Items[i];
		if (objvector.cancellato) then continue;
		if Not(objvector.testinternoschermo) then 	continue;
		objvector.DisegnaVtTutti(HHDC);
   end;
end;

procedure   TPiano.disegnavtfinalipl (HHDC : TImage32);
var  objvector :	TVettoriale; i : Integer;
begin
	if (Not b_visibile) then exit;
	for i:=0 to  Listavector.count-1 do
   begin
		objvector  :=  Listavector.Items[i];
		if (objvector.cancellato) then continue;
		if Not(objvector.testinternoschermo) then 	continue;
		objvector.DisegnaVtFinali(HHDC);
   end;
end;


function   TPiano.snapFine          ( x1, y1 : Real) : Boolean;
var locres : Boolean;
    objvector :	TVettoriale; i : Integer;
begin
	locres  := false;
	if (not b_visibile)    then begin result := locres; exit; end;
//  if (not b_snappabile)  then begin result := locres; exit; end;
	for i:=0 to Listavector.count-1 do
   begin
		objvector := Listavector.Items[i];
		locres    := objvector.SnapFine(x1,y1);
		if (locres) then break;
   end;
  result := locres;
end;

function    TPiano.snapVicino        ( x1, y1 : Real) : Boolean;
var locres : Boolean;
    objvector :	TVettoriale; i : Integer;
begin
	locres  := false;
	if (not b_visibile)    then begin result := locres; exit; end;
  if (not b_snappabile)  then begin result := locres; exit; end;
	for i:=0 to Listavector.count-1 do
   begin
		objvector := Listavector.Items[i];
		locres    := objvector.SnapVicino(x1,y1);
		if (locres) then break;
   end;
  result := locres;
end;

procedure   TPiano.ortosegmenta      ( x1, y1 : Real);
begin
//	[Polyincostruzione ortosegmenta:info: x1 :y1];
end;


procedure   TPiano.mettitratteggio   (HHDC : TImage32; tipotratt : Integer);
begin
 i_tratteggio:=tipotratt;
(*
  - (void) mettitratteggio  : (CGContextRef) hdc : (int) tipotratt {

  	if (tipotratt==1)  {	const CGFloat mypar[2] = {2,2 };    CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==2)  {	const CGFloat mypar[2] = {1,10};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==3)  {	const CGFloat mypar[2] = {1,15};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==4)  {	const CGFloat mypar[2] = {1,20};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==5)  {	const CGFloat mypar[2] = {1,30};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}

  	if (tipotratt==6)  {	const CGFloat mypar[2] = {5 ,1};    CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==7)  {	const CGFloat mypar[2] = {10,1};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==8)  {	const CGFloat mypar[2] = {15,1};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==9)  {	const CGFloat mypar[2] = {20,1};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==10) {	const CGFloat mypar[2] = {30,1};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}

  	if (tipotratt==11) {	const CGFloat mypar[2] = {5,5};	    CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==12) {	const CGFloat mypar[2] = {5,10};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==13) {	const CGFloat mypar[2] = {5,15};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==14) {	const CGFloat mypar[2] = {5,20};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==15) {	const CGFloat mypar[2] = {5,30};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}

  	if (tipotratt==16) {	const CGFloat mypar[2] = {5 ,5};    CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==17) {	const CGFloat mypar[2] = {10,5};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==18) {	const CGFloat mypar[2] = {15,5};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==19) {	const CGFloat mypar[2] = {20,5};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}
  	if (tipotratt==20) {	const CGFloat mypar[2] = {30,5};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}


  }
*)


end;


function    TPiano.nomepianoNoPlus      : String;
var risulta : String;
begin
 if (self.pianoPlus) then begin risulta :=  copy(nomepiano,1,length(nomepiano)-1); end
  else risulta := nomepiano;
	result := risulta;
end;

function    TPiano.nomeFogliopiano      : String;
var risulta : String; k : Integer;
    locC : String;
    trovato : Boolean;
begin
 risulta := ''; trovato := false;
  if length(nomepiano)>7 then
    begin
     risulta := 'Foglio : ';
     for k:=7 to length(nomepiano)-2 do
      begin
        locC := nomepiano[k];
        if ( (locC='0') and (not(trovato)) ) then continue;
         risulta :=risulta+locC;
         trovato:= true;
      end;
    end
   else risulta := nomepiano;

	result := risulta;
end;


function    TPiano.NumObjpianoNotErased : Integer;
var risulta : integer;
    objvector :	TVettoriale; i : Integer;
begin
	risulta:=0;
	for i:=0 to Listavector.count-1 do begin
		objvector := Listavector.items[i];
		if ( not objvector.cancellato) then inc(risulta);
  end;
	result :=risulta;
end;


function    TPiano.pianoPlus : Boolean;
var locres : Boolean;
     ttcar : String;
begin
	locres   := false ;
  ttcar := copy(nomepiano,length(nomepiano), 1);
  if ttcar = '+' then locres := true;
 result := locres;
end;

function    TPiano.isTerreno            : Boolean;
var locres : Boolean;
begin
 locres   := true;
// if self.nomepiano = 'ACQUA' then locres := false;
 if self.nomepiano = 'Fiduciale' then locres := false;
 if self.nomepiano = 'Linea' then locres := false;
 if self.nomepiano = 'STRADA' then locres := false;
 if self.nomepiano = 'Simboli' then locres := false;
 if self.nomepiano = 'Testo' then locres := false;
// if pianoPlus then locres := false;
 result := locres;
end;


procedure   TPiano.SpostaPiano          (dx, dy : Real);
var    objvector :	TVettoriale; i : Integer;
begin
	for i:=0 to Listavector.count-1 do
   begin
		objvector := Listavector.items[i];
		objvector.Sposta(dx,dy);
   end;
      limx1 := limx1+ dx; limx2 := limx2 + dx;
      limy1 := limy1+ dy; limy2 := limy2 + dy;
end;


procedure   TPiano.RuotaPiano           (dx, dy, angrot : Real);
var    objvector :	TVettoriale; i : Integer;
begin
	for i:=0 to Listavector.count-1 do
   begin
		objvector := Listavector.items[i];
		objvector.Ruota(dx,dy,angrot);
   end;
end;


procedure   TPiano.ScalaPiano           (dx, dy, scal   : Real);
var    objvector :	TVettoriale; i : Integer;
begin
	for i:=0 to Listavector.count-1 do
   begin
		objvector := Listavector.items[i];
		objvector.Scala(dx,dy,scal);
   end;
end;


procedure   TPiano.seleziona_conPt         (x1,y1 : Real;  _LSelezionati: TList);
var objvector,objcomp :	TVettoriale; i,j : Integer;
	  NotinList : Boolean;
begin
	if (not b_visibile)    then begin  exit; end;
//  if (not b_editabile)   then begin  exit; end;
	for i:=0 to Listavector.count-1 do begin
		objvector := Listavector.Items[i];
		if (objvector.cancellato) then continue;
		NotinList := true;
		for j:=0  to _LSelezionati.count -1 do
     begin
 		  objcomp := _LSelezionati.Items[j];
      if (objcomp=objvector) then	NotinList := false;
     end;
		if (NotinList) then objvector.seleziona_conPt(x1,y1,_LSelezionati);
  end;
end;

function    TPiano.selezionaCivicoEditPt   (xc, yc : real) : Boolean;
var locres : Boolean;
    objvector : TVettoriale;
    locCivico : TCivico;
    i : Integer;
    valsel : Integer;
begin
 locres := false;
	for i:=0 to Listavector.count-1 do begin
		objvector := Listavector.Items[i];
		if (objvector.cancellato) then continue;
		if (objvector.tipo<>PCivico) then continue;
    locCivico :=  Listavector.Items[i];
    valsel := locCivico.selezionami(xc,yc);
    if valsel>0 then
     begin
      CivicoinEdit := locCivico;
      modoeditcivico := valsel;
      locres := true;
      break;
     end;
  end;
 result := locres;
end;


procedure   TPiano.seleziona_conPtInterno  (x1,y1 : Real;  _LSelezionati: TList);
var objvector,objcomp :	TVettoriale; i,j : Integer;
	  NotinList : Boolean;
begin
	if (not b_visibile)    then begin  exit; end;
//  if (not b_editabile)   then begin  exit; end;
	for i:=0 to Listavector.count-1 do begin
		objvector := Listavector.Items[i];
		if (objvector.cancellato) then continue;
		NotinList := true;
		for j:=0  to _LSelezionati.count -1 do
     begin
 		  objcomp := _LSelezionati.Items[j];
      if (objcomp=objvector) then	NotinList := false;
     end;
		if (NotinList) then objvector.seleziona_conPtInterno(x1,y1,_LSelezionati);

  end;
end;

function    TPiano.Match_conPt             (x1, y1: Real) : Boolean;
var locres : Boolean;
    objvector,objcomp :	TVettoriale; i,j : Integer;
begin
 locres := false;
	if (not b_visibile)    then begin  exit; end;
  if (not b_editabile)   then begin  exit; end;
	for i:=0 to Listavector.count-1 do begin
		objvector := Listavector.Items[i];
		if (objvector.cancellato) then continue;
		if objvector.Match_conPt(x1,y1) then begin locres:=true; break; end;
  end;
 result := locres;
end;

function    TPiano.selezionaVtconPt        (x1, y1 : Real;  _LSelezionati: TList) : Boolean;
var locres : Boolean;
    objvector,objcomp :	TVettoriale; i,j : Integer;
begin
 locres := false;
	if (not b_visibile)    then begin  exit; end;
//  if (not b_editabile)   then begin  exit; end;
	for i:=0 to Listavector.count-1 do begin
		objvector := Listavector.Items[i];
		if (objvector.cancellato) then continue;
		if objvector.selezionaVtconPt(x1,y1,_LSelezionati) then begin locres:=true; break; end;
  end;
 result := locres;
end;


procedure   TPiano.cxfinPiano2 (FF : TStringList; var IR : Integer ; _tt: String);
 var indrigaris  : Integer;
	   x1,y1,x2,y2 : Real;
     tomakeup    : Boolean;
 	   xback,yback : Real;
  	 nvt         : Integer;
	   tt ,illascritta         : String;
     locpunto    : TPunto;
     locTesto    : TTesto;
     i,j         : Integer;
 		 nisole      : Integer;
 	   vtisole     : array[0..1000] of Integer;
     sommavtisole : Integer;
     backvtisola  : Integer;
     htestoLoc : Real;
begin
  htestoLoc := 400.0;
  tomakeup    := false;
	if (_tt = 'BORDO') then
   begin
	  for i:=0 to 1  do begin  tt := FF[IR]; inc(IR);   end;
    tt := FF[IR]; inc(IR);		x1 := StrToFloat(tt);
    tt := FF[IR]; inc(IR);   y1 := StrToFloat(tt);
    tt := FF[IR]; inc(IR);		x2 := StrToFloat(tt);
    tt := FF[IR]; inc(IR);		y2 := StrToFloat(tt);
//    loctesto := nil;
//    showmessage(_tt);
		catastotoutm (x1,y1);		catastotoutm (x2,y2);
 // locpunto := TPunto.Create;           listavector.Add(locpunto);          locpunto.initPunto(x1,y1);
 locTesto := TTesto.Create;                         locTesto.initer(_disegno, self);
 locTesto.initTestoStr (x1,y1,htestoLoc,0.0,nomepianoNoPlus);  listavector.Add(locTesto);

		if ((not(nomepiano = 'STRADA'))  and  (Not (nomepiano = 'ACQUA')))  then begin
(*
  			NSRange myrange;	myrange.location=[nomepiano length]-1;    myrange.length = 1;
  			if ([nomepiano compare:@"+" options:NSCaseInsensitiveSearch range:myrange] ==0)    {
  			} else	{
  				loctesto = [Testo alloc];		[loctesto Init:_disegno : self];
  			    [loctesto InitTestoStr:x1 : y1 : 6 : 0 :nomepiano];
  				[Listavector addObject:loctesto];
  			}
*)
      end;

      tt  := FF[IR]; inc(IR);    nisole := StrToInt(tt);
      tt  := FF[IR]; inc(IR);    nvt    := StrToInt(tt);
  		Polyincostruzione := nil;
  		Polyincostruzione := TPolylinea.Create; 	Polyincostruzione.initer(_disegno, self);
      Polyincostruzione.InitPolilinea(true);
  	  Listavector.Add(Polyincostruzione);
//  		if (nisole>0) [Polyincostruzione setregione:YES];
  		for i:=0 to nisole-1  do  begin tt := FF[IR]; inc(IR); vtisole[i] := StrToInt(tt); end;
  		sommavtisole := 0;

  		for i:=0 to nisole-1 do begin
        sommavtisole := sommavtisole +vtisole[i];
      end;
  		for i:=0 to nisole-1 do begin
        backvtisola := vtisole[i];	vtisole[i]:=nvt-sommavtisole;	sommavtisole := sommavtisole-backvtisola;
      end;
	    for i:=0 to  nvt-1 do begin
        tt  := FF[IR]; inc(IR);    dxf_10    := StrToFloat(tt);
        tt  := FF[IR]; inc(IR);    dxf_20    := StrToFloat(tt);
 		    catastotoutm (dxf_10 ,dxf_20);
  			if (nisole>0) then begin
         if (i=vtisole[0]-1) then begin xback:=dxf_10;	  yback:=dxf_20;  end;
        end;
  			tomakeup:=false;
  			for j:=0 to nisole-1 do begin if (i=vtisole[j]) then tomakeup:=true;	  end;
   			if (tomakeup) then begin Polyincostruzione.addvertexUp(dxf_10,dxf_20); end
 		              	else begin Polyincostruzione.addvertex(dxf_10,dxf_20);    end;
      end;

(*

  		double supPol = [Polyincostruzione superficie];
  		if (supPol>0) {
  			if (supPol<3000) {	if (loctesto!=nil)	[loctesto cambiaaltezza : 2.0];	}
  			if (supPol>20000) {	if (loctesto!=nil)	[loctesto cambiaaltezza : 8.0];	}
  			if (supPol>30000) {	if (loctesto!=nil)	[loctesto cambiaaltezza : 10.0];	}
  		}

*)
//		exit;
   end; // bordo





	if ((_tt = 'LINEA') or (_tt = 'LINEA\\')) then
   begin
    tt := FF[IR]; inc(IR);
    tt := FF[IR]; inc(IR); nvt := StrToInt(tt);
		Polyincostruzione := nil;
		Polyincostruzione := TPolylinea.create; 	Polyincostruzione.initer(_disegno,self);  Polyincostruzione.InitPolilinea(false);
		Listavector.Add(Polyincostruzione);
		for i:=0 to nvt-1 do begin
      tt := FF[IR]; inc(IR);    dxf_10 := strToFloat(tt);
      tt := FF[IR]; inc(IR);    dxf_20 := strToFloat(tt);
			catastotoutm(dxf_10,dxf_20);
 			Polyincostruzione.addvertex(dxf_10,dxf_20);
   //    locpunto := TPunto.Create;    listavector.Add(locpunto);           locpunto.initPunto(dxf_10,dxf_20);
   //   beep();
    end;

   end;

  	if ( (_tt = 'TESTO') or (_tt = 'TESTO\\') ) then
     begin
      tt := FF[IR]; inc(IR);  // il testo
      illascritta:= tt;
      tt := FF[IR]; inc(IR);    dxf_50 := strToFloat(tt); // altezza
      tt := FF[IR]; inc(IR);    dxf_51 := strToFloat(tt); // inclinazione
      tt := FF[IR]; inc(IR);    dxf_10 := strToFloat(tt);

      tt := FF[IR]; inc(IR);    dxf_20 := strToFloat(tt);

			catastotoutm(dxf_10,dxf_20);


 locTesto := TTesto.Create;                         locTesto.initer(_disegno, self);
 locTesto.initTestoStr (dxf_10,dxf_20,htestoLoc,0.0,illascritta);  listavector.Add(locTesto);

//      locpunto := TPunto.Create;   locpunto.initer(_disegno, self);    Listavector.Add(locpunto);          locpunto.initPunto(dxf_10,dxf_20);
//            locpunto.initPunto(2000000.00,4000000.00);
//      showmessage(floattostr(dxf_10));      showmessage(floattostr(dxf_20));
     end;
    {
  		NSString *tttesto= [self prendirigapulita : indriga :listarighe];


  	  tt = [self prendirigapulita : indriga :listarighe];   		double htxt = [tt doubleValue];
  		tt = [self prendirigapulita : indriga :listarighe];  		double angtxt = [tt doubleValue];
  		tt = [self prendirigapulita : indriga :listarighe];         dxf_10= [tt doubleValue];
  	    tt = [self prendirigapulita : indriga :listarighe];         dxf_20= [tt doubleValue];
  		[info catastotoutm : &dxf_10 : &dxf_20 ];
  		Testo *loctesto;
  		loctesto = [Testo alloc];		[loctesto Init:_disegno : self];	[loctesto InitTestoStr:dxf_10 : dxf_20 : htxt : angtxt :tttesto];
  		[Listavector addObject:loctesto];
  	}

(*

  	if ( [_tt isEqualToString:@"FIDUCIALE"] ) {
  		NSString *tttesto=	[self prendirigapulita : indriga :listarighe];
  		tt = [self prendirigapulita : indriga :listarighe];  		 // codice simbolo
  		Polyincostruzione = nil;
  		Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:NO];
  		[Listavector addObject:Polyincostruzione];
  		tt = [self prendirigapulita : indriga :listarighe];    dxf_10= [tt doubleValue];
          tt = [self prendirigapulita : indriga :listarighe];    dxf_20= [tt doubleValue];
  		[info catastotoutm : &dxf_10 : &dxf_20 ];
  		[ Polyincostruzione addvertex:dxf_10:dxf_20:0 ];
  		tt = [self prendirigapulita : indriga :listarighe];    dxf_10= [tt doubleValue];
          tt = [self prendirigapulita : indriga :listarighe];    dxf_20= [tt doubleValue];
  		[info catastotoutm : &dxf_10 : &dxf_20 ];
  		[ Polyincostruzione addvertex:dxf_10:dxf_20:0 ];
  		Testo *loctesto;
  		loctesto = [Testo alloc];		[loctesto Init:_disegno : self];	[loctesto InitTestoStr:dxf_10 : dxf_20 : 10 : 0 :tttesto];
  		[Listavector addObject:loctesto];
  	}


  	if ( [_tt isEqualToString:@"SIMBOLO"] ) {
          tt = [self prendirigapulita : indriga :listarighe];    	 // codice simbolo
  		int codsim = [tt intValue];
          tt = [self prendirigapulita : indriga :listarighe];    	 // angolo simbolo
  		double angsim = [tt doubleValue];
          tt = [self prendirigapulita : indriga :listarighe];       dxf_10= [tt doubleValue];
          tt = [self prendirigapulita : indriga :listarighe];      dxf_20= [tt doubleValue];
  		[info catastotoutm : &dxf_10 : &dxf_20 ];
  			//		codsim =0;
  		Simbolo * locsimb = [Simbolo alloc];
  		[locsimb Init:_disegno : self];
  		[locsimb InitSimbolo:dxf_10:dxf_20:codsim : defsimbol ];
  		[Listavector addObject:locsimb];
  		[locsimb ruotasimbolo :angsim ];
  	}


*)

end;



procedure  TPiano.DisSpostaPiano (HHDC : TImage32; dx,dy : Real);
var objvector :	TVettoriale; i : Integer;
begin
(*
  	settacolorepiano( HHDC , 255 , 10 );
  	for i:=0 to Listavector.count-1 do begin
  		objvector := Listavector.Items[i];
  		objvector.DisegnaAffineSpo(HHDC,dx,dy);
    end;
*)
end;

procedure  TPiano.DisRuotaPiano  (HHDC : TImage32; xc,yc,ang: real);
var objvector :	TVettoriale; i : Integer;
begin
(*
  	settacolorepiano( HHDC , 255 , 10 );
  	for i:=0 to Listavector.count-1 do begin
  		objvector := Listavector.Items[i];
  		objvector.DisegnaAffineRot(HHDC,xc,yc,ang);
    end;
*)
end;

procedure  TPiano.DisScalaPiano  (HHDC : TImage32; xc,yc,scal: real);
var objvector :	TVettoriale; i : Integer;
begin
(*
  	settacolorepiano( HHDC , 255 , 10 );
  	for i:=0 to Listavector.count-1 do begin
  		objvector := Listavector.Items[i];
  		objvector.DisegnaAffineSca(HHDC,xc,yc,scal);
    end;
*)
end;

procedure  TPiano.Distxtvirtual  (HHDC : TImage32; xc,yc,ang,scal: real);
var objvector :	TVettoriale; i : Integer;
begin
//	Testoincostruzione.DisegnaSpoRotSca : hdc : info : xc : yc : ang : scal];
end;

procedure  TPiano.settacolorepiano (HHDC: TImage32; alfaL , alfaS : Integer);
var       AColor32: TColor32;
begin
    TColor32Entry(AColor32).A := alfaL;
    TColor32Entry(AColor32).R := _rosso;
    TColor32Entry(AColor32).G := _verde;
    TColor32Entry(AColor32).B := _blu;

    TColor32Entry(Color32Bordo).A := alfaL;
    TColor32Entry(Color32Bordo).R := _rosso;
    TColor32Entry(Color32Bordo).G := _verde;
    TColor32Entry(Color32Bordo).B := _blu;

    TColor32Entry(Color32Dentro).A := (alfaS*alfasuperfici) div 255;
    TColor32Entry(Color32Dentro).R := _rosso;
    TColor32Entry(Color32Dentro).G := _verde;
    TColor32Entry(Color32Dentro).B := _blu;

    HHDC.Bitmap.PenColor:=AColor32;


//	CGContextSetRGBStrokeColor (hdc, f_rosso, f_verde, f_blu, ( f_alfalineepiano     * _alfal ));
//	CGContextSetRGBFillColor   (hdc, f_rosso, f_verde, f_blu, ( f_alfasuperficipiano * alfas  ));

//	if (info.instampa) begin
//		if ((f_rosso==1.0) & (f_verde==1.0) & (f_blu==1.0) ){
//			CGContextSetRGBStrokeColor (hdc, 0.0, 0.0, 0.0,  ( f_alfalineepiano     * _alfal ) );	}
//  end;

end;


function   TPiano.dispallinivt       : Boolean;
begin

end;

function   TPiano.dispallinivtfinali : Boolean;
begin

end;



procedure  TPiano.faisimbolo       (HHDC : TImage32; x1 , y1 : real; indice  : Integer; dimfissa : Boolean;
                                    listadefinizioni: TList; nomelista: String;  _scalaSimb:real; _angrot:real);
var locsimbolo : TSimbolo;
begin
	locsimbolo := TSimbolo.Create;
  locsimbolo.Initer(self._Disegno,self);
  locsimbolo.InitSimbolo(x1,y1,dimfissa,nomelista, indice ,  listadefinizioni.items[indice]  , _scalaSimb,_angrot);
	Listavector.Add(locsimbolo);
  locsimbolo._disegno.faiLimiti;
	locsimbolo.Disegna(HHDC); // :info];
end;

procedure  TPiano.ruotasimbolo     (HHDC : TImage32; rot : Real);
begin

end;

procedure  TPiano.scalasimbolo     (HHDC : TImage32; sca : Real);
begin

end;

procedure  TPiano.faitesto         (HHDC : TImage32; x1,y1,ht,ang : real;  txttesto : String);
var locTesto : TTesto;
begin
	locTesto := TTesto.Create;
  locTesto.Initer(self._Disegno,self);
  locTesto.initTestoStr(x1,y1,ht,ang,txttesto);
	Listavector.Add(locTesto);
  locTesto._disegno.faiLimiti;
	locTesto.Disegna(HHDC); // :info];
end;

procedure  TPiano.releasetestoincostruzione;
begin

end;

procedure  TPiano.faitestovirtuale (ht,ang : Real;  txttesto : String);
begin

end;

procedure  TPiano.faicolorepianoint(_value : integer);
begin

end;


procedure  TPiano.finitaPolilinea  (HHDC : TImage32);
begin

end;

procedure  TPiano.chiudipoligono   (HHDC : TImage32);
begin

end;

procedure  TPiano.updateEventualeRegione (HHDC : TImage32);
begin

end;

procedure  TPiano.BackPlineaAdded;
begin

end;

procedure  TPiano.cancellaultimovt;
begin

end;

function TPiano.quantiNonCancellati : Integer;
var k,conta : Integer;
    locvet : Tvettoriale;
begin
  conta :=0 ;
  for k := 0 to Listavector.Count-1 do
   begin
    locvet := Listavector.items[k];
    if not( locvet.b_erased ) then inc(conta);
   end;
   result := conta;
end;

procedure  TPiano.EliminaPuntiDoppiNelPiano;
var k,j : Integer;
    locvet : Tvettoriale;
    locvet2 : Tvettoriale;
    punto1,punto2 : TPunto;
begin
  for k := Listavector.Count-1 downto 1 do
   begin
    locvet := Listavector.items[k];
    if locvet.tipo = PPunto then
     begin
      punto1 := Listavector.items[k];
      for j := k-1 downto 0 do
       begin
        locvet2 := Listavector.items[j];
        if locvet.tipo = PPunto then
         begin
          punto2 := Listavector.items[j];
          if ((punto1.x=punto2.X) and (punto1.y=punto2.y)) then
           begin
            Listavector.delete(k); punto1.Free; break;
           end;
         end;
       end;
     end;
   end;
end;



procedure  TPiano.salvapianoMacMap     (_data : TMemoryStream);
var ll,k : Integer;
    caro : Char;
    locvet : Tvettoriale;
begin
 ll := length(nomepiano);             _data.Write(ll,sizeof(ll));
 for k := 1 to length(nomepiano) do
  begin  caro := nomepiano[k];  _data.Write(caro,sizeof(caro));  end;

 ll := length(commentopiano);         _data.Write(ll,sizeof(ll));
 for k := 1 to length(commentopiano) do
  begin  caro := commentopiano[k];  _data.Write(caro,sizeof(caro));  end;

  _data.Write(b_visibile   , sizeof(b_visibile));
  _data.Write(b_editabile  , sizeof(b_editabile));
  _data.Write(b_snappabile , sizeof(b_snappabile));

  _data.Write(alfalinee     , sizeof(alfalinee));
  _data.Write(alfasuperfici , sizeof(alfasuperfici));

  _data.Write(spessoreline , sizeof(spessoreline));
  _data.Write(scalatratto  , sizeof(scalatratto));
  _data.Write(dimpunto     , sizeof(dimpunto));

  _data.Write(_rosso       , sizeof(_rosso));
  _data.Write(_verde       , sizeof(_verde));
  _data.Write(_blu         , sizeof(_blu));

  ll := quantiNonCancellati;    _data.Write(ll,sizeof(ll));
  for k := 0 to Listavector.Count-1 do
   begin
    locvet := Listavector.items[k];
    if locvet.b_erased then continue;
    _data.Write(locvet.tipo  , sizeof(locvet.tipo));
    locvet.salvavettorialeMacMap(_data);
   end;

end;

procedure  TPiano.apripianoMacMap      (_data : TMemoryStream);
var ll,k       : Integer;
    caro       : Char;
    locvet     : Tvettoriale;
    loctipo    : Tipovector;
    locpunto   : TPunto;
    locCerchio : TCerchio;
    locTesto   : TTesto;
    locsimb    : TSimbolo;
    locpline   : TPolylinea;
    locCivico  : TCivico;
    tt   : Integer;
begin
 _data.Read(ll,sizeof(ll));
 for k := 1 to ll do
  begin _data.Read(caro,sizeof(caro)); nomepiano := nomepiano + caro;  end;

 _data.Read(ll,sizeof(ll));
 for k := 1 to ll do
  begin _data.Read(caro,sizeof(caro)); commentopiano := commentopiano + caro;  end;

  _data.Read(b_visibile   , sizeof(b_visibile));
  _data.Read(b_editabile  , sizeof(b_editabile));
  _data.Read(b_snappabile , sizeof(b_snappabile));

  _data.Read(alfalinee     , sizeof(alfalinee));
  _data.Read(alfasuperfici , sizeof(alfasuperfici));

  _data.Read(spessoreline , sizeof(spessoreline));
  _data.Read(scalatratto  , sizeof(scalatratto));
  _data.Read(dimpunto     , sizeof(dimpunto));

  _data.Read(_rosso       , sizeof(_rosso));
  _data.Read(_verde       , sizeof(_verde));
  _data.Read(_blu         , sizeof(_blu));

  _data.Read(ll,sizeof(ll));
  for k := 1 to ll do
   begin
    _data.Read(loctipo         , sizeof(loctipo));

    case loctipo of
     PPunto :
      begin
       locpunto := TPunto.Create;   locpunto.initer(_disegno,self); Listavector.Add(locpunto);
       locpunto.aprivettorialeMacMap(_data);
      end;
     PCerchio :
      begin
       locCerchio := TCerchio.Create;   locCerchio.initer(_disegno,self); Listavector.Add(locCerchio);
       locCerchio.aprivettorialeMacMap(_data);
      end;
      PTesto :
      begin
       locTesto := TTesto.Create;   locTesto.initer(_disegno,self); Listavector.Add(locTesto);
       locTesto.aprivettorialeMacMap(_data);
      end;
      PSimbolo :
      begin
       locsimb := TSimbolo.Create;   locsimb.initer(_disegno,self); Listavector.Add(locsimb);
       locsimb.aprivettorialeMacMap(_data);
      end;
      PPlinea :
      begin
       locpline := TPolylinea.Create;  locpline.InitPolilinea(false);
       locpline.initer(_disegno,self); Listavector.Add(locpline);
       locpline.aprivettorialeMacMap(_data);
      end;
      PPoligono :
      begin
       locpline := TPolylinea.Create;  locpline.InitPolilinea(true);
       locpline.initer(_disegno,self); Listavector.Add(locpline);
       locpline.aprivettorialeMacMap(_data);
      end;
      PCivico :
      begin
       locCivico := TCivico.Create;
       locCivico.initer(_disegno,self); Listavector.Add(locCivico);
       locCivico.aprivettorialeMacMap(_data);
      end;

    end;

//    locvet := TVettoriale.create;
//    locvet.initer(_Disegno,self);
//    locvet.aprivettorialeMacMap(_data);

   end;
end;

procedure  TPiano.cambianomedbase   (_newtext : String);
begin

end;

procedure  TPiano.cambianomeTavola  (_newtext : String);
begin

end;


procedure  TPiano.shpin              (_nomedisegno : String);
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
  Passareal               : Real;
begin
	posdata  := 0;
	posparti := 0;

	_data := TMemoryStream.Create;
  _data.LoadFromFile(_nomedisegno);
	posdata :=32;
  _data.Seek(32,1);

  _data.Read(Tiposhp,sizeof(Tiposhp));

//    showmessage(intToStr(Tiposhp));

  _data.Read(x1lim,sizeof(x1lim));
  _data.Read(y1lim,sizeof(y1lim));
  _data.Read(x2lim,sizeof(x2lim));
  _data.Read(y2lim,sizeof(y2lim));

  _data.position :=108;

//  showmessage(intTostr(tiposhp));

  case tiposhp of
   1 : begin  // Punti
(*
    			while ([_data length]>=(posdata+1)) {
    				[_data getBytes:&recnum  range:NSMakeRange (posdata, sizeof(recnum)) ];     posdata +=sizeof(recnum);
    				[_data getBytes:&x1lim   range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
    				[_data getBytes:&y1lim   range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
    				locpunto = [Punto alloc];	[locpunto Init:_disegno : self];
    			    [locpunto InitPunto: x1lim : y1lim];		[Listavector addObject:locpunto];
    				posdata +=8;
    			}
    			break; // caso 1 Punti

*)
   end;


   3 : begin // Polilinee
  			while (_data.Size>=_data.Position) do
         begin
          _data.Read(recnum,sizeof(recnum));
          _data.Read(x1lim,sizeof(x1lim));
          _data.Read(y1lim,sizeof(y1lim));
          _data.Read(x2lim,sizeof(x2lim));
          _data.Read(y2lim,sizeof(y2lim));
          _data.Read(Numparts ,sizeof(Numparts));
          _data.Read(NumPoints,sizeof(NumPoints));

  				if  (Numparts = 1) then begin
  					Polyincostruzione := TPolylinea.create; 	Polyincostruzione.initer(_disegno,self);  Polyincostruzione.InitPolilinea(false);
  					Listavector.Add(Polyincostruzione);
            _data.Read(parts,sizeof(parts));
  					for i:=0 to NumPoints-1 do begin
             _data.Read(x1lim,sizeof(x1lim));
             _data.Read(y1lim,sizeof(y1lim));
             Polyincostruzione.addvertex(x1lim,y1lim);
            end;
           end
           else
          begin
  					Polyincostruzione := TPolylinea.create; 	Polyincostruzione.initer(_disegno,self);  Polyincostruzione.InitPolilinea(false);
  					Listavector.Add(Polyincostruzione);
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
  					Polyincostruzione := TPolylinea.create; 	Polyincostruzione.initer(_disegno,self);  Polyincostruzione.InitPolilinea(true);
  					Listavector.Add(Polyincostruzione);
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
  					Polyincostruzione := TPolylinea.create; 	Polyincostruzione.initer(_disegno,self);  Polyincostruzione.InitPolilinea(false);
  					Listavector.Add(Polyincostruzione);
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

     15 :
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
  				if  (Numparts = 1) then begin
  					Polyincostruzione := TPolylinea.create; 	Polyincostruzione.initer(_disegno,self);  Polyincostruzione.InitPolilinea(true);
  					Listavector.Add(Polyincostruzione);
            _data.Read(parts,sizeof(parts));
  					for i:=0 to NumPoints-1 do begin
             _data.Read(x1lim,sizeof(x1lim));
             _data.Read(y1lim,sizeof(y1lim));
             Polyincostruzione.addvertex(x1lim,y1lim);
            end;

             _data.Read(Passareal,sizeof(Passareal));
             _data.Read(Passareal,sizeof(Passareal));
  					for i:=0 to NumPoints-1 do begin _data.Read(Passareal,sizeof(Passareal)); end;
             _data.Read(Passareal,sizeof(Passareal));
             _data.Read(Passareal,sizeof(Passareal));
  					for i:=0 to NumPoints-1 do begin _data.Read(Passareal,sizeof(Passareal)); end;
            Polyincostruzione.chiudiSeChiusa;
           end
            else
           begin
  					Polyincostruzione := TPolylinea.create; 	Polyincostruzione.initer(_disegno,self);  Polyincostruzione.InitPolilinea(false);
  					Listavector.Add(Polyincostruzione);
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
     end; // poligoni Z


  end;


end;


(*


  	int recnum ;
  	int Numparts,NumPoints ;
  	int parts ;
  	int parts1,parts2 ;

  	Punto *locpunto;


  	switch (Tiposhp) {

  		case 5 : // Poligoni
  			while ([_data length]>=(posdata+1)) {
  				[_data getBytes:&recnum  range:NSMakeRange (posdata, sizeof(recnum)) ];      posdata +=sizeof(recnum);
  				[_data getBytes:&x1lim   range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
  				[_data getBytes:&y1lim   range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
  				[_data getBytes:&x2lim   range:NSMakeRange (posdata, sizeof(x2lim)) ];      posdata +=sizeof(x2lim);
  				[_data getBytes:&y2lim   range:NSMakeRange (posdata, sizeof(y2lim)) ];      posdata +=sizeof(y2lim);
  				[_data getBytes:&Numparts    range:NSMakeRange (posdata, sizeof(Numparts)) ];      posdata +=sizeof(Numparts);
  				[_data getBytes:&NumPoints   range:NSMakeRange (posdata, sizeof(NumPoints)) ];     posdata +=sizeof(NumPoints);
  				if (Numparts==1) {
  					Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:YES];
  					[Listavector addObject:Polyincostruzione];
  					[_data getBytes:&parts    range:NSMakeRange (posdata, sizeof(parts)) ];      posdata +=sizeof(parts);
  					for (int i=0; i<NumPoints; i++) {
  						[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
  						[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
   					  [Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
  					}
  				}
  				else {
  					Polyincostruzione = [Polilinea alloc]; [Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:YES];
  					[Polyincostruzione setregione:YES];
  					[Listavector addObject:Polyincostruzione];
  					posparti=posdata;
  					for (int kpa=0; kpa<(Numparts-1); kpa++) {
  						posdata = posparti+kpa*4;
  						[_data getBytes:&parts1    range:NSMakeRange (posdata, sizeof(parts1)) ];      posdata +=sizeof(parts1);
  						[_data getBytes:&parts2    range:NSMakeRange (posdata, sizeof(parts2)) ];
  						posdata = posparti+Numparts*4+parts1*16;
  						if (kpa<(Numparts-1)) {
  						  for (int kv=parts1; kv<parts2; kv++) {
  							[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
  							[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
  						    if (kv==parts1) [Polyincostruzione addvertexUp:x1lim:y1lim]; else
  								[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
  						  }
  						}
            	            else {
  						 for (int kv=parts2; kv<NumPoints; kv++) {
  								[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
  								[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
  								if (kv==parts2) [Polyincostruzione addvertexUp:x1lim:y1lim]; else
  									[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
  						 }
  						}
  					}
  					posdata = posparti+Numparts*4+NumPoints*16;
  				}
  				posdata +=8;
  			}
  			break; // qua 5 dei Poligoni e Regioni

  		case 15 : // Poligoni	Z



  			while ([_data length]>=(posdata+1)) {
  				laposizione0 = posdata;

  					//				Double[4] Box // Bounding Box
  				[_data getBytes:&recnum  range:NSMakeRange (posdata, sizeof(recnum))];      posdata +=sizeof(recnum);
  				[_data getBytes:&x1lim   range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
  				[_data getBytes:&y1lim   range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
  				[_data getBytes:&x2lim   range:NSMakeRange (posdata, sizeof(x2lim)) ];      posdata +=sizeof(x2lim);
  				[_data getBytes:&y2lim   range:NSMakeRange (posdata, sizeof(y2lim)) ];      posdata +=sizeof(y2lim);
  					//	Integer NumParts // Number of Parts
  				[_data getBytes:&Numparts    range:NSMakeRange (posdata, sizeof(Numparts)) ];      posdata +=sizeof(Numparts);
  					//	Integer NumPoints // Total Number of Points
  				[_data getBytes:&NumPoints   range:NSMakeRange (posdata, sizeof(NumPoints)) ];     posdata +=sizeof(NumPoints);

  					//			NSLog(@"Tipo %d",recnum);
  				if (Numparts==1) {
  					Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:YES];
  					[Listavector addObject:Polyincostruzione];
  					[_data getBytes:&parts    range:NSMakeRange (posdata, sizeof(parts)) ];      posdata +=sizeof(parts);
  					for (int i=0; i<NumPoints; i++) {
  						[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
  						[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
  						[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
  					}

  					laposizione = laposizione0 + 44 + (4 * Numparts)  + (16 * NumPoints);
  					posdata = posparti+Numparts*4+NumPoints*16;
  					posdata = laposizione + 24 + (8 *	 NumPoints);


  				} else {
  					Polyincostruzione = [Polilinea alloc]; [Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:YES];
  					[Polyincostruzione setregione:YES];
  					[Listavector addObject:Polyincostruzione];
  					posparti=posdata;
  					for (int kpa=0; kpa<(Numparts-1); kpa++) {
  						posdata = posparti+kpa*4;
  					    [_data getBytes:&parts1    range:NSMakeRange (posdata, sizeof(parts1)) ];      posdata +=sizeof(parts1);
  						[_data getBytes:&parts2    range:NSMakeRange (posdata, sizeof(parts2)) ];
  						posdata = posparti+Numparts*4+parts1*16;
  						if (kpa<(Numparts-1)) {
  						for (int kv=parts1; kv<parts2; kv++) {
  							[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
  							[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
  						    if (kv==parts1) [Polyincostruzione addvertexUp:x1lim:y1lim]; else
  								[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
  						 }
  						}
  					  else {
  						for (int kv=parts1; kv<NumPoints; kv++) {
  							[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
  							[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
  							if (kv==parts1) [Polyincostruzione addvertexUp:x1lim:y1lim]; else
  								[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
  						}
  					  }
  					}


  					laposizione = laposizione0 + 44 + (4 * Numparts)  + (16 * NumPoints);
  					posdata = posparti+Numparts*4+NumPoints*16;
  					posdata = laposizione + 24 + (8 *	 NumPoints);

  				  }

  				}

  			break;

      }


  		//	[_data release];




  }
    _data.free;
  end;

*)
procedure  TPiano.creadefsimbolo     (listadefsimboli : TList; indice : integer);
begin

end;

procedure  TPiano.salvadxf;
begin

end;

procedure  TPiano.settratteggio      (indtratto : integer);
begin

end;

procedure  TPiano.setCampitura       (indcamp   : Integer);
begin

end;

procedure  TPiano.svuota;
begin

end;

procedure  TPiano.smemora;
begin

end;

procedure  TPiano.CatToUtm;
begin

end;

procedure  TPiano.TestoAltoQU        (toLayer : Tpiano);
begin

end;

procedure  TPiano.tuttoPenDownPolyline;
var k : Integer;
    locvector : Tvettoriale;
    lapoly : TPolylinea;
begin
 for k:=0 to Listavector.count-1 do
  begin
   locvector := Listavector.items[k];
   if locvector.tipo = PPlinea then
    begin
     lapoly := Listavector.items[k];
     lapoly.tuttoPenDownPolyline;
    end;
  end;
end;



function   TPiano.nomepianovicinopt(xa,ya : Real) : String;
var k : Integer;
    locvector : Tvettoriale;
    lapoly : TPolylinea;
    resulta : String;
    LaLista : TList;
begin
 resulta :='';
 LaLista := TList.create;
 for k:=0 to Listavector.count-1 do
  begin
   locvector := Listavector.items[k];
   if locvector.tipo = PPlinea then
    begin
     lapoly := Listavector.items[k];
     lapoly.seleziona_conPt(xa,ya, LaLista);
     if LaLista.Count>0 then
      begin
       resulta := self.nomepiano;
       break;
      end;
    end;
  end;
  LaLista.clear;
  LaLista.Free;
  result := resulta;
end;

procedure  TPiano.PolyToPoligoni;
var k : Integer;
    locvector : Tvettoriale;
    lapoly : TPolylinea;
begin
 for k:=0 to Listavector.count-1 do
  begin
   locvector := Listavector.items[k];
   if locvector.tipo = PPlinea then
    begin
     lapoly := Listavector.items[k];
     lapoly.polyinpoligono;
    end;
  end;
end;


end.
