unit Cerchio;

interface

uses windows,System.classes,System.Math, vettoriale,GR32, GR32_Image, GR32_Layers,sysutils;

type
 TCerchio = class(TVettoriale)
   X , Y, R : Real;

   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;

   Procedure   salvavettorialeMacMap (St : TMemoryStream);                  override;
   Procedure   aprivettorialeMacMap  (St : TMemoryStream);                  override;
   procedure   Disegna            (HHDC : TImage32);                        override;
   procedure   DisegnaConColori   (HHDC : TImage32; Color32Bordo   : TColor32; Color32Dentro  : TColor32;spess:Integer); override;
   procedure   DisegnaAffineSpo   (DC : hdc ; dx,dy : Real);          override;
   procedure   DisegnaAffineRot   (DC : hdc ;  xc,yc,rot : Real);      override;
   procedure   DisegnaAffineSca   (DC : hdc ;  xc,yc,sca : Real);      override;
   procedure   DisegnaSpoRotSca   (HHDC : TImage32;  xc,yc,rot,sca : Real;xp,yp : real;ColBordo,ColDentro : Tcolor32);  override;
   procedure   InitCerchio        (x1,y1,x2,y2 : real);
   procedure   faiLimiti          ;                                         override;
   function    Copia              (dx, dy : Real)  : TVettoriale;           override;
   function    copiaPura          : TCerchio;
   procedure   CopiainLista       (lista : TList);
   procedure   Sposta             ( dx,dy : Real);                          override;
   procedure   Ruota              ( xc , yc , ang  : Real);                 override;
   procedure   Ruotaang           ( ang : Real);
   procedure   Scala              ( xc , yc , scal : Real);                 override;
   procedure   Scalasc            ( scal : Real);



   procedure   seleziona_conPt    (x1,y1 : Real; _LSelezionati : Tlist);  override;
   Function    Match_conPt        (x1, y1 : Real): Boolean;               override;

{



     procedure   Ruotaang           ( ang : Real);
     procedure   Scalasc            ( scal : Real);
     Function    SnapFine           (x1, y1 : Real): Boolean;
     Function    SnapVicino         (x1, y1 : Real): Boolean;

}

  end;


 var ilCerchio : TCerchio;


implementation

uses varbase, funzioni,graphics,costanti,GR32_Polygons;

constructor TCerchio.Create;
 begin
   Inherited Create;
   tipo := PCerchio;
 end;

Destructor  TCerchio.Done;
 begin
   Inherited Done;
 end;




procedure   TCerchio.Disegna            (HHDC : TImage32);
var x1, y1, rag : single;
    k,a1 ,b1,a2,b2 : Integer;
        Polygon: TPolygon32;
begin
	if (b_erased) then exit;
	x1 :=  Xinschermo(x);
	y1 :=  Yinschermo(y);

  rag := r /scalaVista;
  if rag<1 then exit;

  Polygon := TPolygon32.Create;
  Polygon.Antialiased := true;
  Polygon.AntialiasMode := TAntialiasMode(0);
  Polygon.closed :=true;

    if rag<2 then
     begin
      for k := 0 to 3 do begin
        Polygon.Add(GR32.FixedPoint(x1 + round(rag * _sin4[k]), y1+round(rag*_cos4[k])));
      end;
     end
      else
      if rag<5 then
       begin
        for k := 0 to 7 do begin
          Polygon.Add(GR32.FixedPoint(x1 + round(rag * _sin8[k]), y1+round(rag*_cos8[k])));
        end;
       end else
        if rag<7 then
         begin
          for k := 0 to 15 do begin
            Polygon.Add(GR32.FixedPoint(x1 + round(rag * _sin16[k]), y1+round(rag*_cos16[k])));
          end;
         end else
         if rag<9 then
          begin
           for k := 0 to 31 do begin
             Polygon.Add(GR32.FixedPoint(x1 + round(rag * _sin32[k]), y1+round(rag*_cos32[k])));
           end;
          end
           else
          begin
           for k := 0 to 63 do begin
             Polygon.Add(GR32.FixedPoint(x1 + round(rag * _sin64[k]), y1+round(rag*_cos64[k])));
           end;
          end;
   Polygon.DrawEdge(HHDC.Bitmap, _piano.Color32Bordo);
  Polygon.free;
end;

procedure   TCerchio.DisegnaConColori   (HHDC : TImage32; Color32Bordo   : TColor32; Color32Dentro  : TColor32;spess:Integer);
var x1, y1, rag : single;
    k,a1 ,b1,a2,b2 : Integer;
    Polygon: TPolygon32;
    TmpPoly: TPolygon32;
    Outline: TPolygon32;
begin
	if (b_erased) then exit;
	x1 :=  Xinschermo(x);
	y1 :=  Yinschermo(y);
  rag := r /scalaVista;
  if rag<1 then exit;

  Polygon := TPolygon32.Create;
  Polygon.Antialiased := true;
  Polygon.AntialiasMode := TAntialiasMode(0);
  Polygon.closed :=true;
  for k := 0 to 63 do begin
    Polygon.Add(GR32.FixedPoint(x1 + round(rag * _sin64[k]), y1+round(rag*_cos64[k])));
  end;

  TmpPoly := Polygon.Outline;
  Outline := TmpPoly.Grow(Fixed(spess),0.0);
  Outline.Draw(HHDC.Bitmap, Color32Bordo, Color32Dentro, nil);
  TmpPoly.Free;
  Outline.free;
  Polygon.free;
end;


procedure   TCerchio.DisegnaAffineSpo   (DC : hdc ; dx,dy : Real);
var x1, y1, rag : single;
    a1 ,b1,a2,b2 : Integer;
begin
	x1 :=  Xinschermo(x+dx);
	y1 :=  Yinschermo(y+dy);
	rag := r /scalaVista;;
  a1 := round(x1-rag);  b1 := round(y1-rag);
  a2 := round(x1+rag);  b2 := round(y1+rag);
  Arc(dc, a1,b1,a2,b2,a1,b1,a1,b1);
end;

procedure   TCerchio.DisegnaAffineRot   (DC : hdc ;  xc,yc,rot : Real);
var x1,y1,rag : Real;
	  locx,locy : Real;
    a1 ,b1,a2,b2 : Integer;
begin
	x1 := x-xc;	y1 := y-yc;
	locx := x1*cos(rot) - y1*sin(rot);        	locy := x1*sin(rot) + y1*cos(rot);
	x1   :=locx+xc;	y1 :=locy+yc;
	x1   := Xinschermo(x1);
	y1   := Yinschermo(y1);
	rag  := r /scalaVista;
  a1 := round(x1-rag);  b1 := round(y1-rag);
  a2 := round(x1+rag);  b2 := round(y1+rag);
  Arc(dc, a1,b1,a2,b2,a1,b1,a1,b1);
end;

procedure   TCerchio.DisegnaAffineSca   (DC : hdc ;  xc,yc,sca : Real);
var x1,y1,rag : Real;
	  locx,locy : Real;
    a1 ,b1,a2,b2 : Integer;
begin
  	x1:=x-xc; 	  y1:=y-yc;
  	locx := x1*sca;        	locy := y1*sca;
  	x1:=locx+xc;	y1:=locy+yc;
  	x1 :=  Xinschermo(x1);
   	y1 :=  Yinschermo(y1);
  	rag := (r*sca) /scalaVista;
    a1 := round(x1-rag);  b1 := round(y1-rag);
    a2 := round(x1+rag);  b2 := round(y1+rag);
    Arc(dc, a1,b1,a2,b2,a1,b1,a1,b1);
end;

procedure   TCerchio.DisegnaSpoRotSca   (HHDC : TImage32;  xc,yc,rot,sca : Real;xp,yp : real;ColBordo,ColDentro : Tcolor32);
begin

end;

procedure   TCerchio.InitCerchio        (x1,y1,x2,y2 : real);
begin
	b_erased := false;	b_selected  := false;
	x := x1;  	y := y1;
	r := hypot((x2-x1), (y2-y1));
	self.faiLimiti;
end;


Procedure   TCerchio.salvavettorialeMacMap (St : TMemoryStream);
begin
 Inherited salvavettorialeMacMap(st);
 	st.Write(x, sizeof(x));
	st.Write(y, sizeof(y));
	st.Write(r, sizeof(r));
end;


Procedure   TCerchio.aprivettorialeMacMap  (St : TMemoryStream);
begin
 Inherited aprivettorialeMacMap(st);
 	st.Read(x, sizeof(x));
	st.Read(y, sizeof(y));
	st.Read(r, sizeof(r));
end;

Procedure   TCerchio.faiLimiti;
begin
	limx1 := x-r ;	limx2 := x+r ;	limy1 := y-r ;	limy2 := y+r ;
end;


function    TCerchio.Copia              (dx, dy : Real)  : TVettoriale;
var newcer : Tcerchio;
begin
	newcer := TCerchio.Create;
  newcer.initer(_disegno,_piano);
	newcer.InitCerchio(x, y,(x+r),y);
	_piano.Listavector.add(newcer);
	self.Sposta(dx,dy);
	faiLimiti;
	result := newcer;
end;


function    TCerchio.copiaPura          : TCerchio;
var newcer : Tcerchio;
begin
	newcer := TCerchio.Create;
  newcer.initer(_disegno,_piano);
	newcer.InitCerchio(x, y,(x+r),y);
	faiLimiti;
	result := newcer;
end;


procedure   TCerchio.CopiainLista       (lista : TList);
var newcer : Tcerchio;
begin
	newcer := TCerchio.Create;
  newcer.initer(_disegno,_piano);
	newcer.InitCerchio(x, y,(x+r),y);
	faiLimiti;
	lista.add(newcer);
end;


procedure   TCerchio.seleziona_conPt    (x1,y1 : Real; _LSelezionati : Tlist);
var dd,off : Real;
begin
  off  :=  give_offsetmirino ;
  dd   :=  distsemplicefunz(x,y,x1,y1) - r ;
  if (dd<off) then begin _LSelezionati.Add(self); end;
end;


procedure   TCerchio.Sposta             ( dx,dy : Real);
begin
  	x := x+dx;	y := y+dy;	faiLimiti;
end;


procedure   TCerchio.Ruota              ( xc , yc , ang : Real);
begin
  Sposta(-xc,-yc);	Ruotaang(ang);	Sposta(xc,yc);
end;

procedure   TCerchio.Ruotaang   ( ang : Real);
var  locx,locy : real;
begin
	locx := x*cos(ang) - y*sin(ang);        	locy := x*sin(ang) + y*cos(ang);
 	x:=locx;	y:=locy;
end;


procedure   TCerchio.Scala              ( xc , yc , scal : Real);
begin
 Sposta(-xc,-yc);	Scalasc(scal);	Sposta(xc,yc);
end;

procedure   TCerchio.Scalasc   ( scal : Real);
begin
	x:=x*scal;	y:=y*scal;  R := R*scal;
end;








Function    TCerchio.Match_conPt        (x1, y1 : Real): Boolean;
var locres : Boolean;
    dd,off : Real;
begin
  locres :=false;
  off  :=  give_offsetmirino ;
	dd   :=  distsemplicefunz(x,y,x1,y1) - r ;
  if (dd<off)  then locres := true;
  result := locres;

end;



end.
