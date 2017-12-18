unit Polylinea;

interface

uses windows,System.classes,vettoriale,GR32, GR32_Image, GR32_Layers, vertice, sysutils,FMX.Dialogs;

type
 TPolylinea = class(TVettoriale)
	Spezzata    : TList;
//	NSMutableArray *BacksInfo;
	b_chiusa    : Boolean;
//	b_regione   : Boolean;
//	Vertice *lastVtUp;

   lastVtUp : TVertice;


   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   Disegna              (HHDC : TImage32);                          override;
   procedure   DisegnaConColori(HHDC : TImage32; Color32Bordo   : TColor32; Color32Dentro  : TColor32;spess:Integer); override;
   procedure   DisegnaSelected      (HHDC : TImage32);                          override;

   procedure   DisegnaAffineSpo     (DC : hdc ;   dx,dy : real);          override;
   procedure   DisegnaAffineRot     (DC : hdc ;   xc,yc,rot : real);      override;
   procedure   DisegnaAffineSca     (DC : hdc ;   xc,yc,sca : real);      override;
   procedure   DisegnaSpoRotSca     (HHDC : TImage32;   xc,yc,rot,sca : real;xp,yp : real;ColBordo,ColDentro : Tcolor32);  override;
   procedure   disegnadef         (HHDC : TImage32; Xlim,Ylim,sca: Real); override;


   procedure   DisegnaVtTutti       (HHDC : TImage32);
   procedure   DisegnaVtFinali      (HHDC : TImage32);

   function    SnapFine             (x1,y1 : Real) : Boolean;                   override;
   function    SnapVicino           (x1,y1 : Real) : Boolean;                   override;
   Function    SnapCat              (HHDC : TImage32; x1,y1 : Real): Integer;
   Procedure   Ortosegmenta         (HHDC : TImage32; x1,y1 : Real);



   procedure   InitPolilinea(sechiusa : Boolean);

   procedure   faiLimiti;                                                       override;
   Function    inSchermo: Boolean;                                              override;


   procedure   addvertex            (x1,y1 : real);
   procedure   addvertexnoUpdate    (x1,y1 : real);
   procedure   addvertexUp          (x1,y1 : real);
   procedure   addvertexUpnoUpdate  (x1,y1 : real);

   procedure   seleziona_conPt         (x1,y1 :Real; _LSelezionati : TList) ;                   override;
   procedure   seleziona_conPtInterno  (x1,y1 :Real; ListaSelezionati : TList) ;                   override;
   Function    Match_conPt             (x1,y1 : Real): Boolean;                                    override;
   Function    selezionaVtconPt        (x1,y1 :Real; ListaSelezionati : TList) : Boolean;          override;
   procedure   SpostaVerticeSelezionato    (_LSelezionati : TList ; newx , newy : Real);           override;
   procedure   InserisciVerticeSelezionato (_LSelezionati : TList ; newx , newy : Real);           override;
   procedure   CancellaVerticeSelezionato  (_LSelezionati : TList);                                override;
   procedure   EditVerticeSelezionato      (_LSelezionati : TList ; newx , newy : Real);

   procedure   cancellaultimovt;

   procedure   Sposta          (dx,dy : Real);                    override;
   function    Copia           (dx,dy : Real): TVettoriale;       override;
   function    copiapura                     : TVettoriale;       override;
   procedure   Ruota           (xc,yc,ang : Real);                override;
   procedure   Ruotaang        (ang : real);
   procedure   Scala           (xc,yc, scal : Real);              override;
   procedure   Scalasc         (scal : Real);
   procedure   CopiainLista    (inlista : TList);

   procedure   polyinpoligono;
   function    ptInterno       (x1,y1 : Real) : Boolean;

   procedure   aggiungiUltimoPuntoUp(HHDC : TImage32);
   procedure   chiudiSeChiusa;                                                                     override;
   procedure   chiudiconUltimoUp;

   Procedure   salvavettorialeMacMap (St : TMemoryStream);                           override;
   Procedure   aprivettorialeMacMap  (St : TMemoryStream);                           override;

   Procedure   PosNearesPoly(x1,y1 : Real; var xv : Real; var yv : Real);

   Procedure   tuttoPenDownPolyline;

   Procedure   taglia3Vt(vtprimoTaglio,vtsecondoTaglio,locvt : TVertice);


  end;


 var ilPolylinea       : TPolylinea;
     Polyincostruzione : TPolylinea;
     Poligonointaglio  : TPolylinea;

implementation

uses varbase,funzioni,GR32_Polygons;



constructor TPolylinea.Create;
 begin
   Inherited Create;
   tipo := PPlinea;
 end;

Destructor  TPolylinea.Done;
 begin
   Inherited Done;
 end;


procedure   TPolylinea.Disegna(HHDC : TImage32);
var k : Integer;
    a,a0 : Tvertice;
    ddx,ddy : real;
    Polygon: TPolygon32;
    x1,y1 : single;
    x1I, y1I : Integer;
     hdc : Thandle;
begin
 if b_erased then exit;
  ddx := abs(limx2-limx1)/scalaVista;
  ddy := abs(limy2-limy1)/scalaVista;
 	if ((ddx<2) and (ddy<2)) then begin	exit;    end;
  if Not(inSchermo) then exit;

  if (b_chiusa or (self._piano.spessoreline<=1)) then
   begin
           Polygon := TPolygon32.Create;
           Polygon.Antialiased := true;
           Polygon.AntialiasMode := TAntialiasMode(0);
           Polygon.closed :=b_chiusa;
           for k:=0 to spezzata.Count-1 do
            begin
             a := spezzata.Items[k];
             if a.up then begin Polygon.newline; continue; end;
             x1 := Xinschermo(a.x);
             y1 := Yinschermo(a.y);
             Polygon.Add(GR32.FixedPoint(x1, y1));
            end;
           if  b_chiusa then Polygon.Draw(HHDC.Bitmap, _piano.Color32Bordo, _piano.Color32Dentro, nil)
                        else Polygon.DrawEdge(HHDC.Bitmap, _piano.Color32Bordo);
           Polygon.free;

   end
    else
   begin
     hdc:= HHDC.Bitmap.Canvas.Handle;
        for k:=0 to spezzata.Count-1 do
          begin
           a := spezzata.Items[k];
           x1I := round(Xinschermo(a.x));
           y1I := round(Yinschermo(a.y));
           if (a.up or (k=0)) then begin  MoveToEx(Hdc, (x1I-(_piano.dimpunto)), y1I, nil); continue; end;
           LineTo(HDC, x1I+(_piano.dimpunto+1), y1I);
          end;
   end;

  if  vedopallinivertici       then begin DisegnaVtTutti(HHDC); end;
  if  vedopalliniverticiFinali then begin DisegnaVtFinali(HHDC); end;


end;


procedure   TPolylinea.DisegnaConColori(HHDC : TImage32; Color32Bordo   : TColor32; Color32Dentro  : TColor32;spess:Integer);
var k : Integer;
    a,a0 : Tvertice;
    ddx,ddy : real;
    Polygon: TPolygon32;
    x1,y1 : single;
    TmpPoly: TPolygon32;
    Outline: TPolygon32;
begin
 if b_erased then exit;
  ddx := abs(limx2-limx1)/scalaVista;
  ddy := abs(limy2-limy1)/scalaVista;
 	if ((ddx<1) and (ddy<1)) then begin	exit;    end;
         Polygon := TPolygon32.Create;
         Polygon.Antialiased := true;
         Polygon.AntialiasMode := TAntialiasMode(0);
         Polygon.closed :=b_chiusa;
         for k:=0 to spezzata.Count-1 do
          begin
           a := spezzata.Items[k];
           if a.up then begin Polygon.newline; continue; end;
           x1 := Xinschermo(a.x);
           y1 := Yinschermo(a.y);
           Polygon.Add(GR32.FixedPoint(x1, y1));
          end;
         if  b_chiusa then begin
                       Polygon.Draw(HHDC.Bitmap, Color32Bordo, Color32Dentro, nil);
                       TmpPoly := Polygon.Outline;
                       Outline := TmpPoly.Grow(Fixed(spess),0.0);
                       Outline.Draw(HHDC.Bitmap, Color32Bordo, Color32Dentro, nil);
                       TmpPoly.Free;
                       Outline.free;
                      end
                      else
                      begin
                       TmpPoly := Polygon.Outline;
                       Outline := TmpPoly.Grow(Fixed(spess),0.0);
                       Outline.Draw(HHDC.Bitmap, Color32Bordo, Color32Dentro, nil);
//                       Outline.FillMode := pfWinding;
                       TmpPoly.Free;
                       Outline.free;
//                       Polygon.DrawEdge(HHDC.Bitmap, Color32Bordo);
                      end;

         Polygon.free;
end;


procedure    TPolylinea.DisegnaAffineSpo     (DC : hdc ;   dx,dy : real);
var k : Integer;
    a,a0 : Tvertice;
    isdown : Boolean;
    ddx,ddy : real;
begin
 if b_erased then exit;
 isdown :=false;
  ddx := abs(limx2-limx1)/scalaVista;
  ddy := abs(limy2-limy1)/scalaVista;
 	if ((ddx<1) and (ddy<1)) then begin	exit; end;
   for k:=0 to spezzata.Count-1 do
    begin
     a := spezzata.Items[k];
     if k=0 then begin a.movetoSpo(DC,dx,dy); isdown:=true; a0:=a; continue; end;
  	 ddx := abs((a.x-a0.x)/scalaVista);
  	 ddy := abs((a.y-a0.y)/scalaVista);
  	 if ((ddx<1.0) and (ddy<1.0)) then continue;
     a0:=a;
     if a.up then a.movetoSpo(DC,dx,dy) else a.linetoSpo(DC,dx,dy);
    end;
  	if ((b_chiusa) and (Spezzata.count>0)) then
     begin a :=Spezzata.Items[0]; a.linetospo(DC,dx,dy);  end;
end;

procedure    TPolylinea.DisegnaAffineRot     (DC : hdc ;   xc,yc,rot : real);
var k : Integer;
    a,a0 : Tvertice;
    isdown : Boolean;
    ddx,ddy : real;
begin
 if b_erased then exit;
 isdown :=false;
  ddx := abs(limx2-limx1)/scalaVista;
  ddy := abs(limy2-limy1)/scalaVista;
 	if ((ddx<1) and (ddy<1)) then begin	exit;      end;
   for k:=0 to spezzata.Count-1 do
    begin
     a := spezzata.Items[k];
     if k=0 then begin a.movetoRot(DC,xc,yc,rot); isdown:=true; a0:=a; continue; end;
  	 ddx := abs((a.x-a0.x)/scalaVista);
  	 ddy := abs((a.y-a0.y)/scalaVista);
  	 if ((ddx<1.0) and (ddy<1.0)) then continue;
     a0:=a;
     if a.up then a.movetoRot(DC,xc,yc,rot) else a.linetoRot(DC,xc,yc,rot);
    end;
  	if ((b_chiusa) and (Spezzata.count>0)) then
     begin a :=Spezzata.Items[0]; a.linetorot(DC,xc,yc,rot);  end;

end;


procedure    TPolylinea.DisegnaAffineSca     (DC : hdc ;   xc,yc,sca : real);
var k : Integer;
    a,a0 : Tvertice;
    isdown : Boolean;
    ddx,ddy : real;
begin
 if b_erased then exit;
 isdown :=false;
  ddx := abs(limx2-limx1)/scalaVista;
  ddy := abs(limy2-limy1)/scalaVista;
 	if ((ddx<1) and (ddy<1)) then begin	exit; end;
   for k:=0 to spezzata.Count-1 do
     begin
      a := spezzata.Items[k];
      if k=0 then begin a.movetoSca(DC,xc,yc,sca); isdown:=true; a0:=a; continue; end;
   	 ddx := abs((a.x-a0.x)/scalaVista);
   	 ddy := abs((a.y-a0.y)/scalaVista);
   	 if ((ddx<1.0) and (ddy<1.0)) then continue;
      a0:=a;
      if a.up then a.movetoSca(DC,xc,yc,sca) else a.linetoSca(DC,xc,yc,sca);
     end;
   	if ((b_chiusa) and (Spezzata.count>0)) then
      begin a :=Spezzata.Items[0]; a.linetoSca(DC,xc,yc,sca);  end;
end;



procedure    TPolylinea.DisegnaSpoRotSca     (HHDC : TImage32;   xc,yc,rot,sca : real;xp,yp : real;ColBordo,ColDentro : Tcolor32);
var k : Integer;
    a,a0 : Tvertice;
    ddx,ddy : real;
    Polygon: TPolygon32;
    x1,y1 : real;
    x1s,y1s : real;
begin
 if b_erased then exit;
    Polygon := TPolygon32.Create;
      Polygon.Antialiased := true;
      Polygon.AntialiasMode := TAntialiasMode(0);
      Polygon.closed :=b_chiusa;
        for k:=0 to spezzata.Count-1 do
         begin
             a := spezzata.Items[k];
             if a.up then begin Polygon.newline; continue; end;
             Rotoscalacentra ( xc , yc , rot, sca, a.x,a.y, x1s, y1s);
             x1s := x1s+xp;
             y1s := y1s+yp;
             x1 := Xinschermo(x1s);
             y1 := Yinschermo(y1s);
             Polygon.Add(GR32.FixedPoint(x1, y1));
         end;
      if  b_chiusa then Polygon.Draw(HHDC.Bitmap,ColBordo, ColDentro, nil)
                   else Polygon.DrawEdge(HHDC.Bitmap, ColBordo);

    Polygon.free;
end;


procedure   TPolylinea.disegnadef         (HHDC : TImage32; Xlim,Ylim,sca: Real);
var k : Integer;
    a,a0 : Tvertice;
    ddx,ddy : real;
    Polygon: TPolygon32;
    x1,y1 : single;
    AColor32: TColor32;
begin

    TColor32Entry(AColor32).A := 180;
    TColor32Entry(AColor32).R := 0;
    TColor32Entry(AColor32).G := 0;
    TColor32Entry(AColor32).B := 0;
         Polygon := TPolygon32.Create;
         Polygon.Antialiased := true;
         Polygon.AntialiasMode := TAntialiasMode(0);
         Polygon.closed :=b_chiusa;
         for k:=0 to spezzata.Count-1 do
          begin
           a := spezzata.Items[k];
           if a.up then begin Polygon.newline; continue; end;
           x1 := (a.x-Xlim)/sca;
           y1 := HHDC.Height-((a.y-ylim)/sca);
           Polygon.Add(GR32.FixedPoint(x1, y1));
          end;
         if  b_chiusa then Polygon.Draw(HHDC.Bitmap,AColor32, AColor32, nil)
                      else Polygon.DrawEdge(HHDC.Bitmap, AColor32);
         Polygon.free;
end;

procedure   TPolylinea.DisegnaSelected      (HHDC : TImage32);
var    AColor32: TColor32;
begin

    TColor32Entry(AColor32).A := 255;
    TColor32Entry(AColor32).R := 255;
    TColor32Entry(AColor32).G := 0;
    TColor32Entry(AColor32).B := 0;

 HHDC.Bitmap.PenColor:=AColor32;
 Disegna(HHDC);
end;


procedure   TPolylinea.DisegnaVtTutti       (HHDC : TImage32);
var a : Tvertice; k : Integer;
begin
 if b_erased then exit;
 for k:=0 to spezzata.Count-1 do
  begin
   a := spezzata.Items[k];   a.dispallino(HHDC);
  end;
end;

procedure   TPolylinea.DisegnaVtFinali      (HHDC : TImage32);
var a : Tvertice; k : Integer;
begin
 if b_erased then exit;
	if (Spezzata.count<=0) then exit;
	a := Spezzata.Items[0];	                a.dispallinofinale(HHDC);
	a := Spezzata.Items[Spezzata.count-1];	a.dispallinofinale(HHDC);
end;

Function    TPolylinea.SnapFine             (x1,y1 : Real): Boolean;
var locres : Boolean;i : Integer;
  	dx, dy , off: real;
    a : Tvertice;
begin
	locres := false;
	off  :=  give_offsetmirino;
	for i:=0 to  Spezzata.count-1 do
   begin
		a  := Spezzata.Items[i];
	  dx := abs(x1-a.x); 	dy := abs(y1-a.y);
		if ((dx<off) and (dy<off)) then
     begin
      setxysnap(a.x, a.y); locres := true; break;
     end;
	 end;
	result:=locres;
end;

Function    TPolylinea.SnapVicino           (x1,y1 : Real): Boolean;
var locres : Boolean;
  	dx, dy , dd,  off: real;
    a,b : Tvertice;
    i : Integer;
    xsn,ysn : Real;
begin
 locres := false;
  off  := give_offsetmirino;
	for i:=1 to  Spezzata.count-1 do
   begin
 		a := Spezzata.Items[i-1];
 		b := Spezzata.Items[i];
		if b.up then continue;
 		dd := distasegfunz (a.x, a.y, b.x, b.y , x1 , y1 );
 		if (dd<off) then begin
			if OrtoInterno(a.x, a.y , b.x, b.y, x1, y1,xsn,ysn) then begin setxysnap (xsn, ysn);  locres :=true; break; end
 			 else
        begin
  			 dx := x1-a.x; 	dy :=  y1 - a.y;
  			 if (dx<0) then dx := -dx;
         if (dy<0) then dy := -dy;
         if ((dx<off) and (dy<off)) then
          begin
          	setxysnap (a.x, a.y);  locres := true; break;
          end;
  			 dx   :=  abs(x1 - b.x); 	dy   :=  abs(y1-b.y);
  			 if ((dx<off) and (dy<off)) then
          begin
          	setxysnap ( b.x, b.y);  locres:=true; break;
  			  end;
        end;
    end;
	 end;
	result:=locres;
end;




Function    TPolylinea.SnapCat              (HHDC : TImage32; x1,y1 : Real): Integer;
begin

(*
  	int locres=-1;	double dd;  double dx,dy;
  	Vertice *a, *b;
  	double off  =  [ _info give_offsetmirino ];
  	for (int i=1; i<Spezzata.count; i++) {
  		a= [Spezzata objectAtIndex:(i-1)];
  		b= [Spezzata objectAtIndex:i];
  		if ([b givemeifup]) continue;
  		dd = [self distaptseg : [a xpos]: [a ypos]: [b xpos]:[b ypos]: x1 : y1 ];
  			// calcolare dist segmento   // se poi orto allora ... altrimenti il finale
  		if (dd<off) {
  			if ([self OrtoInterno: _info:[a xpos]:[a ypos]:[b xpos]:[b ypos]: x1 : y1 ]) {
  				if ((distsemplicefunz(x1, y1, [a xpos], [a ypos])<(distsemplicefunz(x1, y1, [b xpos], [b ypos]))))
  					locres=i-1; else locres=i;
  				break;}  // DeltaVicinoInterno:=True;
  			else  {
  				dx   =  (x1-[a xpos]); 	dy   =  (y1-[a ypos]);
  				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
  				if ((dx<off) & (dy<off)) {	[_info setxysnap : [a xpos] : [a ypos]];  locres=i-1; break;}
  				dx   =  (x1-[b xpos]); 	dy   =  (y1-[b ypos]);
  				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
  				if ((dx<off) & (dy<off)) {	[_info setxysnap : [b xpos] : [b ypos]];  locres=i; break;}
  			}
  		}
  	}
  	return locres;


*)
end;

Procedure   TPolylinea.Ortosegmenta         (HHDC : TImage32; x1,y1 : Real);
begin

end;



procedure   TPolylinea.InitPolilinea(sechiusa : Boolean);
begin
  b_chiusa := sechiusa;
 	if not(b_chiusa) then tipo  := PPlinea else tipo  := PPoligono;
	Spezzata := TList.Create;
end;

procedure   TPolylinea.faiLimiti;
var 	a : TVertice; i : Integer;
begin
 //	if (Spezzata.count=0) then begin self.cancella; exit; end;
	for i:=0 to Spezzata.count-1 do
   begin
		a := Spezzata.Items[i];
		if (i=0) then begin
		 limx1 := a.x;     limy1 := a.y;
		 limx2 := limx1;	 limy2 := limy1;
    end
		 else
		begin
		 if (limx1>a.x) then limx1 := a.x;
		 if (limy1>a.y) then limy1 := a.y;
		 if (limx2<a.x) then limx2 := a.x;
		 if (limy2<a.y) then limy2 := a.y;
    end;
   end;
end;

Function    TPolylinea.inSchermo: Boolean;
var resulta : Boolean;
    x1,y1 : Single;
begin
 resulta:= true;
  x1 := Xinschermo(limx2); if x1 <0 then resulta :=false;
  y1 := Yinschermo(limy1); if y1 <0 then resulta :=false;
  x1 := Xinschermo(limx1); if x1 >Wschermo then resulta :=false;
  y1 := Yinschermo(limy2); if y1 >Hschermo then resulta :=false;
 result := resulta;
end;

procedure   TPolylinea.addvertex          (x1,y1 : real);
var a : TVertice;
begin
	a := TVertice.Create;	a.InitVertice(x1,y1);	Spezzata.Add(a);
  faiLimiti;
end;

procedure   TPolylinea.addvertexnoUpdate  (x1,y1 : real);
var a : TVertice;
begin
	a := TVertice.Create;	a.InitVertice(x1,y1);	Spezzata.Add(a);
end;


procedure   TPolylinea.addvertexUp          (x1,y1 : real);
var a : TVertice;
begin
	a := TVertice.Create;	a.InitVerticeUp(x1,y1);	Spezzata.Add(a);	lastVtUp := a;
	faiLimiti;
end;


procedure   TPolylinea.addvertexUpnoUpdate  (x1,y1 : real);
var a : TVertice;
begin
	a := TVertice.Create;	a.InitVerticeUp(x1,y1);	Spezzata.Add(a);	lastVtUp := a;
end;

procedure   TPolylinea.seleziona_conPt         (x1,y1 :Real; _LSelezionati : TList) ;
var a,b : Tvertice;
  	off : real;
  	locres : Boolean;
  	dd, dx,dy , xsn,ysn: real;
    i : Integer;
begin
 locres := false;

 off := give_offsetmirino;

  for i:=1 to Spezzata.count-1 do
   begin
		a:= Spezzata.Items[i-1];
 		b:= Spezzata.items[i];
  	if (b.up) then continue;
  	dd :=  distasegfunz(a.x,a.y,b.x,b.y, x1 , y1 );
 		if (dd<off) then
     begin
  	  if (OrtoInterno (a.x , a.y , b.x , b.y , x1 , y1,xsn,ysn )) then begin locres:=true; break; end
  			else begin
  				dx :=  abs(x1-a.x); 	dy := abs(y1-a.y);
  				if ((dx<off) and (dy<off)) then begin locres:=true; break; end;
  				dx :=  abs(x1-b.x); 	dy := abs(y1-b.y);
  				if ((dx<off) and (dy<off)) then begin locres:=true; break; end;
        end;
     end;
   end;
 	if (locres) then _LSelezionati.add(self);
  if not(locres) then seleziona_conPtInterno  (x1,y1,_LSelezionati) ;
end;


procedure   TPolylinea.seleziona_conPtInterno  (x1,y1 :Real; ListaSelezionati : TList) ;
begin
 if (ptInterno(x1,y1)) then ListaSelezionati.add(self);
end;



Function    TPolylinea.Match_conPt             (x1,y1 : Real): Boolean;
var a,b : Tvertice;
  	off : real;
  	locres : Boolean;
  	dd, dx,dy,xsn,ysn : real;
    i : Integer;
begin
 locres := false;
 off := give_offsetmirino;
  for i:=1 to Spezzata.count-1 do
   begin
		a:= Spezzata.Items[i-1];
 		b:= Spezzata.items[i];
  	if (b.up) then continue;
  	dd :=  distasegfunz(a.x,a.y,b.x,b.y, x1 , y1 );
 		if (dd<off) then
     begin
  	  if (OrtoInterno (a.x , a.y , b.x , b.y , x1 , y1 ,xsn,ysn)) then begin locres:=true; break; end
  			else begin
  				dx :=  abs(x1-a.x); 	dy := abs(y1-a.y);
  				if ((dx<off) and (dy<off)) then begin locres:=true; break; end;
  				dx :=  abs(x1-b.x); 	dy := abs(y1-b.y);
  				if ((dx<off) and (dy<off)) then begin locres:=true; break; end;
        end;
     end;
   end;
 result := locres;
end;


Function    TPolylinea.selezionaVtconPt        (x1,y1 :Real; ListaSelezionati : TList) : Boolean;
var locres : Boolean;
  	dd, dx, dy,xsn,ysn : Real;
  	a, b, c1, c2, c3 : Tvertice;
    off : real;
  	indselected , i: Integer;
begin
  locres := false;
   off := give_offsetmirino;
  if (Spezzata.count>=2) then
   begin
//  	if (b_chiusa )	[self   chiudiconVtDown];
  	indselected := 0;

  	for i:=1 to Spezzata.count-1 do
     begin
  		a := Spezzata.Items[i-1];
  		b := Spezzata.Items[i];
  		if (b.up) then continue;
  		dd := distasegfunz( a.x, a.y, b.x,b.y, x1,y1);
  		if (dd<off) then
       begin
  			if (OrtoInterno( a.x,a.y,b.x,b.y,x1,y1,xsn,ysn)) then
         begin
          locres :=true;
  				if (distsemplicefunz(a.x,a.y,x1,y1) < distsemplicefunz(b.x,b.y,x1,y1)) then indselected:=i-1 else indselected:=i;
          break;
         end;
       end
  		  else
       begin
				dx   :=  abs(x1-a.x); 	dy   :=  abs(y1-a.y);
 				if ((dx<off) and (dy<off)) then
         begin
         	setxysnap (a.x, a.y);  locres:=true; indselected:=i-1;
          break;
         end;
 				dx   :=  abs(x1-b.x); 	dy   :=  abs(y1-b.y);
 				if ((dx<off) and (dy<off)) then
         begin
        	setxysnap (b.x,b.y);  locres:=true; indselected:=i;
          break;
         end;
       end;
     end;  // fine spezzata








  	if (locres) then
     begin
      ListaSelezionati.Add(self);
  		c1 := Spezzata.Items[indselected]; ListaSelezionati.Add(c1);
      if ((indselected=0) or (indselected=(Spezzata.count-1))) then
       begin
        if (indselected=0) then
         begin
       		c2:=Spezzata.Items[1];      ListaSelezionati.add(c2);
          if b_chiusa then begin c2:=Spezzata.Items[Spezzata.count-1]; end;
          ListaSelezionati.add(c2);
         end;
        if (indselected=(Spezzata.count-1)) then
         begin
       		c2:=Spezzata.Items[Spezzata.count-2];      ListaSelezionati.add(c2);
          if b_chiusa then begin c2:=Spezzata.Items[0]; end;
          ListaSelezionati.add(c2);
         end;
       end
        else
       begin
    		c2:=Spezzata.Items[indselected-1];      ListaSelezionati.add(c2);
    		c3:=Spezzata.Items[indselected+1];      ListaSelezionati.add(c3);
       end;

      ListaSelezionati.Add(a);
      ListaSelezionati.Add(b);
     end;
   end;
 result := locres;
end;

procedure   TPolylinea.SpostaVerticeSelezionato    (_LSelezionati : TList ; newx , newy : Real);
var  a, b, c : Tvertice;
  	 xold,yold : Real;
  	 trovaindice, k : Integer;
begin
  	a := _LSelezionati.Items[1];
  	xold := a.x;	yold := a.y;
  	trovaindice := 0;
  	for k:=0 to Spezzata.Count-1 do begin
  	  if (a = Spezzata.Items[k])  then
       begin
    	    trovaindice:=k;  break;    //  [self ImpostaBack     : 1 : trovaindice : xold : yold ];
       end;
    end;
  	a.x:=newx; 	a.y:=newy;  faiLimiti;
end;

procedure   TPolylinea.InserisciVerticeSelezionato (_LSelezionati : TList ; newx , newy : Real);
var  a, b, c,d : Tvertice;
     i : Integer;
begin
  a := _LSelezionati.Items[4];
 	for i:=0 to Spezzata.count-1 do
   begin
     b := Spezzata.Items[i];
  	 if (a=b) then
      begin
       c := TVertice.Create; c.InitVertice(newx,newy);	Spezzata.Insert(i+1,c);
       break;
      end;
   end;
  faiLimiti;
end;

procedure   TPolylinea.CancellaVerticeSelezionato  (_LSelezionati : TList);
var  a, b, c,d : Tvertice;
     i : Integer;
     i_ultra : Integer;
     ancheult : Boolean;
begin
 ancheult := false;
 	a :=  _LSelezionati.items[1];
 	for i:=0 to Spezzata.count-1 do begin
    b:= Spezzata.items[i];
  		if (a=b) then begin

        if b_chiusa then begin
         if i=0 then begin
          c:= Spezzata.items[Spezzata.count-1];
          if ((c.x=a.x) and (c.y=a.y)) then begin ancheult:=true; i_ultra := Spezzata.count-1;   end;
         end;
         if i=Spezzata.count-1 then begin
          c:= Spezzata.items[0];
          if ((c.x=a.x) and (c.y=a.y)) then begin ancheult:=true; i_ultra := 0;   end;
         end;
        end;

         if (ancheult and (i_ultra>0))  then begin Spezzata.delete(i_ultra);   end;
         Spezzata.delete(i);	b.free;
         if (ancheult and (i_ultra=0))  then begin Spezzata.delete(i_ultra);   end;

         if ancheult then begin c.free; chiudiSeChiusa;  end;
    		break;
      end;
  end;
 	if (Spezzata.count<2) then b_erased:=true;
  faiLimiti;
end;

procedure   TPolylinea.EditVerticeSelezionato      (_LSelezionati : TList ; newx , newy : Real);
var a,b,c  :   	TVertice; i : Integer;
begin
 	a := _LSelezionati.items[1];
	for i:=0 to Spezzata.count-1 do
   begin
  	b := Spezzata.Items[i];
		if (a=b) then begin
      b.x:=newx;
      b.y:=newy;
			break;
    end;
   end;
  faiLimiti;
end;


procedure   TPolylinea.cancellaultimovt;
var 	a : TVertice; i : Integer;
begin
 if Spezzata.count<1 then exit;
	a := Spezzata.items[Spezzata.count-1];
  Spezzata.Delete(Spezzata.count-1);
  a.Free;
 	faiLimiti;
end;


procedure   TPolylinea.Sposta          (dx,dy : Real);
var 	a : TVertice; i : Integer;
begin
 	if (Spezzata.count<2) then b_erased :=true;
  for i:=0 to Spezzata.count-1 do begin  a := Spezzata.Items[i];   a.Sposta(dx,dy);  end;
	faiLimiti;
end;

function    TPolylinea.Copia           (dx,dy : Real): TVettoriale;
var   newpl : TPolylinea;
  	  a, b  : Tvertice;
      i : Integer;
begin
  	newpl := TPolylinea.create;
  	newpl.initer(_disegno, _piano);
  	newpl.InitPolilinea(self.b_chiusa);
  	_piano.Listavector.Add(newpl);
  	for i:=0  to Spezzata.count-1 do begin
  	 a := Spezzata.Items[i];
  	 b := TVertice.create;
   	 b.CopiaconVt(a);
  	 newpl.Spezzata.Add(b);
    end;
  	newpl.faiLimiti;
  	newpl.Sposta(dx,dy);
  	result := newpl;
end;

function   TPolylinea.copiapura : TVettoriale;
var   newpl : TPolylinea;
  	  a, b  : Tvertice;
      i : Integer;
begin
  	newpl := TPolylinea.create;
  	newpl.initer(_disegno, _piano);
  	newpl.InitPolilinea(self.b_chiusa);
  	for i:=0  to Spezzata.count-1 do begin
  	 a := Spezzata.Items[i];
  	 b := TVertice.create;
   	 b.CopiaconVt(a);
  	 newpl.Spezzata.Add(b);
    end;
  	newpl.faiLimiti;
  	result := newpl;
end;



procedure   TPolylinea.Ruota           (xc,yc,ang : Real);
begin
	Sposta(-xc,-yc);	Ruotaang(ang);	Sposta(xc,yc);
end;

procedure   TPolylinea.Ruotaang        (ang :real);
var	a : TVertice ; i : Integer;
begin
	for i:=0 to Spezzata.count-1 do begin  a :=Spezzata.Items[i];  a.Ruotaang(ang);  end;
end;

procedure   TPolylinea.Scala           (xc,yc, scal : Real);
begin
  Sposta(-xc,-yc);	Scalasc(scal); Sposta(xc,yc);
end;

procedure   TPolylinea.Scalasc         (scal : Real);
var	a : TVertice ; i : Integer;
begin
	for i:=0 to Spezzata.count-1 do begin  a :=Spezzata.Items[i];  a.Scalasc(scal);  end;
end;

procedure   TPolylinea.CopiainLista    (inlista : TList);
var 	newpl : TPolylinea;
     	a,b : TVertice;
      i : Integer;
begin
	newpl := TPolylinea.Create;	 newpl.initer(_disegno,_piano);	newpl.InitPolilinea(b_chiusa);
  inlista.Add(newpl);
	for i:=0 to Spezzata.count-1 do
   begin
		a := Spezzata.Items[i];
		b := TVertice.create;
		b.CopiaconVt(a);
		newpl.Spezzata.Add(b);
	  newpl.faiLimiti;
   end;
end;


procedure   TPolylinea.polyinpoligono;
begin
	tipo  := PPoligono;
	b_chiusa := true;
end;

function    TPolylinea.ptInterno       (x1,y1 : Real) : Boolean;
var resulta : Boolean;
	  yover, dy  : real;
	  a, b : TVertice;
    numint , i: Integer;

begin
 resulta := false;
  if ((x1<limx1) or (x1>limx2) or (y1<limy1) or (y1>limy2)  )  then
   begin result:=resulta; exit; end;
  numint := 0;

(*
  	if (b_regione) {
  		for (int i=1; i<Spezzata.count; i++) {
  			a= [Spezzata objectAtIndex:i-1];			b= [Spezzata objectAtIndex:i];
              if ( [b givemeifup] ) {
  				while (numint>1) {numint=numint-2; }  if (numint==1) locres=!locres;
                  numint=0;
  				continue;
  			}
  			if ( ((x1>[a xpos]) &  (x1<=[b xpos])) | ((x1>[b xpos]) &  (x1<=[a xpos])) ) {
  				dy = (([b ypos]-[a ypos]) * (x1-[a xpos])) / ([b xpos]-[a xpos]  );
  				yover = [a ypos]+dy;
  				if (yover>y1) numint++;	}  }
  		while (numint>1) {numint=numint-2; }  if (numint==1) locres=!locres;
  	}

  	else
*)
  begin
	 if (b_chiusa) then
    begin
		 for i:=1 to Spezzata.count-1 do
      begin
       a := Spezzata.Items[i-1];			b := Spezzata.Items[i];
       if b.up then continue;
			 if ( ((x1>a.x) and  (x1<=b.x)) or ((x1>=b.x) and  (x1<a.x)) ) then
        begin
				 dy := ((b.y-a.y) * (x1-a.x)) / (b.x-a.x);
				 yover := a.y+dy;
         if (yover>y1) then inc(numint);
        end;
      end;
    end;
    if odd(numint) then resulta:= true;
	end;


 result := resulta;
end;


procedure   TPolylinea.aggiungiUltimoPuntoUp(HHDC : TImage32);
var k : Integer;
     a, b : TVertice;
begin
 for k:= Spezzata.count-1  downto 0 do
  begin
   a := Spezzata.items[k];
   if ((a.up) or (k=0)) then
    begin
     b := TVertice.Create;
     b.InitVerticeUp(a.x,a.y);	Spezzata.Add(b);
     disegna(HHDC);

     break;
    end;
  end;
end;

procedure   TPolylinea.chiudiSeChiusa;
var     a, b ,c: TVertice;
begin
  if spezzata.count<2 then exit;
  b_chiusa := true;
  a := spezzata.items[0];
  b := spezzata.items[spezzata.count-1];
  if ((a.x<>b.x) or (a.y<>b.y)) then
   begin
     c := TVertice.Create; c.InitVertice(a.x,a.y);	Spezzata.Add(c);
   end;
end;

procedure   TPolylinea.chiudiconUltimoUp;
var     a, b ,c: TVertice;
begin
  if spezzata.count<2 then exit;
  if lastVtUp=nil then exit;
  b_chiusa := true;
  a := lastVtUp;
  b := spezzata.items[spezzata.count-1];
  if ((a.x<>b.x) or (a.y<>b.y)) then
   begin
     c := TVertice.Create; c.InitVertice(a.x,a.y);	Spezzata.Add(c);
   end;
end;


Procedure   TPolylinea.salvavettorialeMacMap (St : TMemoryStream);
var ll,k : Integer;
    locvt : Tvertice;
begin
 Inherited salvavettorialeMacMap(st);
 st.Write(b_chiusa, sizeof(b_chiusa));
 ll := Spezzata.count;
 st.Write(ll, sizeof(ll));
 for k:=0 to spezzata.count-1 do
  begin
   locvt := spezzata.items[k];
   locvt.salvavettorialeMacMap(St);
  end;
end;

Procedure   TPolylinea.aprivettorialeMacMap  (St : TMemoryStream);
var ll,k : Integer;
    locvt : Tvertice;
begin
 Inherited aprivettorialeMacMap(st);
 st.read(b_chiusa, sizeof(b_chiusa));
 st.Read(ll, sizeof(ll));
 for k:=1 to ll do
  begin
   locvt := TVertice.create;
   spezzata.Add(locvt);
   locvt.aprivettorialeMacMap(St);
  end;
end;


Procedure  TPolylinea.PosNearesPoly(x1,y1 : Real; var xv : Real; var yv : Real);
var ll,k : Integer;
    locvt : Tvertice;
    locvt2 : Tvertice;
    dd,ddmin : real;
    xsn ,ysn : real;
begin
  ddmin := 1000000;
  for k:=0 to spezzata.Count-1 do
   begin
     locvt := spezzata.items[k];
     dd := distsemplicefunz(x1,y1,locvt.x,locvt.y);
     if dd<ddmin then begin
       xv := locvt.x;
       yv := locvt.y;
       ddmin:=dd;
     end;
   end;
  for k:=1 to spezzata.Count-1 do
   begin
     locvt := spezzata.items[k];     locvt2:= spezzata.items[k-1];
     if OrtoInterno(locvt.x,locvt.y,locvt2.x,locvt2.y,  x1,y1 , xsn ,ysn  ) then
      begin
       dd := distsemplicefunz(xsn,ysn,x1,y1);
       if dd<ddmin then begin
         xv := xsn;
         yv := ysn;
         ddmin:=dd;
       end;
      end;
   end;
end;


Procedure  TPolylinea.tuttoPenDownPolyline;
var k : Integer;
    locvt : Tvertice;
begin
  for k:=0 to spezzata.Count-1 do
   begin
     locvt := spezzata.items[k];
     locvt.up := false;
   end;
end;


Procedure   TPolylinea.taglia3Vt(vtprimoTaglio,vtsecondoTaglio,locvt : TVertice);
var ind1,ind2, ind3 : Integer;
    locer : TVertice;
    k,j : Integer;
    contavt: Integer;
    indmax,indmin : Integer;
begin
 contavt :=0;
 for k:=0 to Spezzata.count-1 do
  begin
   locer := Spezzata.items[k];
   if (locer= vtprimoTaglio)   then begin ind1:=k; inc(contavt); end;
   if (locer= vtsecondoTaglio) then begin ind2:=k; inc(contavt); end;
   if (locer= locvt)           then begin ind3:=k; inc(contavt); end;
  end;

   if (contavt=3) then
    begin
     if ind1>ind2 then begin indmax:=ind1; indmin:=ind2; end
                  else begin indmax:=ind2; indmin:=ind1; end;
      if ( ((ind3>ind1) and (ind3>ind2)) or  ((ind3<ind1) and (ind3<ind2)) ) then
       begin
        for j:= Spezzata.count-1 downto (indmax+1) do begin Spezzata.delete(j); end;
        for j:= 0 to (indmin-1) do begin Spezzata.delete(0); end;
       end
        else
       begin
        for j:= 1 to ((indmax-indmin)-1) do begin Spezzata.delete(indmin+1); end;
       end;
    end;
 chiudiSeChiusa;

end;


end.
