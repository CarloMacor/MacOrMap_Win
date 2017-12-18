unit Punto;

interface

uses windows,System.classes,vettoriale,GR32, GR32_Image, GR32_Layers,sysutils , vcl.graphics;

type
 TPunto = class(TVettoriale)
   X , Y, Z : Real;

   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   Disegna            (HHDC : TImage32);                        override;
   procedure   DisegnaConColori   (HHDC : TImage32; Color32Bordo   : TColor32; Color32Dentro  : TColor32;spess:Integer); override;

   procedure   DisegnaAffineSpo   (DC : hdc ;  dx,dy : Real);          override;
   procedure   DisegnaAffineRot   (DC : hdc ;  xc,yc,rot : Real);      override;
   procedure   DisegnaAffineSca   (DC : hdc ;  xc,yc,sca : Real);      override;
   procedure   DisegnaSpoRotSca   (HHDC : TImage32;  xc,yc,rot,sca : Real;xp,yp : real;ColBordo,ColDentro : Tcolor32);  override;
   procedure   disegnadef         (HHDC : TImage32; Xlim,Ylim,sca: Real); override;

   Function    inSchermo: Boolean;                                          override;

   procedure   initPunto          (x1,y1 : Real);
   Procedure   salvavettorialeMacMap (St : TMemoryStream);                  override;
   Procedure   aprivettorialeMacMap  (St : TMemoryStream);                  override;

   procedure   faiLimiti          ;                                         override;
   function    Copia              (dx, dy : Real)  : TVettoriale;           override;
   function    copiaPura          : TVettoriale;
   procedure   Sposta             ( dx,dy : Real);                          override;
   procedure   Ruota              ( xc , yc , ang : Real);                  override;
   procedure   Ruotaang           ( ang : Real);
   procedure   Scala              ( xc , yc , scal : Real);                 override;
   procedure   Scalasc            ( scal : Real);
   Function    SnapFine           (x1, y1 : Real): Boolean;                 override;
   Function    SnapVicino         (x1, y1 : Real): Boolean;                 override;
   procedure   seleziona_conPt    (x1, y1 : Real; _LSelezionati : Tlist);   override;
   Function    Match_conPt        (x1, y1 : Real): Boolean;                 override;
   procedure   CatToUtm;


  end;


 var ilPunto : TPunto;



implementation

uses varbase,funzioni;


constructor TPunto.Create;
 begin
   Inherited Create;
   tipo := PPunto;
 end;

Destructor  TPunto.Done;
 begin
   Inherited Done;
 end;


procedure   TPunto.Disegna(HHDC : TImage32);
var x1, y1 : single;
    hdc : Thandle;
    penna : TPen;
begin
   if Not(inSchermo) then exit;
//    HHDC.Bitmap.Canvas.Pen :=  penna;
 //   HHDC.Bitmap.Canvas.Pen.Color := clRed;
    hdc:= HHDC.Bitmap.Canvas.Handle;

 if b_erased then exit;
 	x1 :=  Xinschermo(x);
	y1 :=  Yinschermo(y);
 with HHDC.Bitmap do
  begin
    MoveToEx(Hdc, round(x1-(_piano.dimpunto)), round(y1), nil);    LineTo(HDC, round(x1+(_piano.dimpunto+1)), round(y1));
    MoveToEx(Hdc, round(x1), round(y1-(_piano.dimpunto)), nil);    LineTo(HDC, round(x1), round(y1+(_piano.dimpunto+1)));
 //   MoveToF (x1-(_piano.dimpunto), y1);  LineToFS(x1+(_piano.dimpunto+1), y1);
 //   MoveToF (x1, y1-(_piano.dimpunto));  LineToFS(x1,  y1+(_piano.dimpunto+1));
  end;
end;


procedure   TPunto.disegnadef(HHDC : TImage32; Xlim,Ylim,sca: Real);
begin

end;

Function    TPunto.inSchermo: Boolean;
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



procedure   TPunto.DisegnaConColori(HHDC : TImage32; Color32Bordo   : TColor32; Color32Dentro  : TColor32;spess:Integer);
var x1, y1 : single;
begin
  if Not(inSchermo) then exit;

  HHDC.Bitmap.PenColor:=Color32Bordo;
  if b_erased then exit;

   x1 :=  Xinschermo(x);
   y1 :=  Yinschermo(y);
 with HHDC.Bitmap do
  begin
    MoveToF (x1-2, y1-1);    LineToFS(x1+3, y1-1);   MoveToF (x1-1,   y1-2);  LineToFS(x1-1,  y1+3);
    MoveToF (x1-2, y1+1);    LineToFS(x1+3, y1+1);   MoveToF (x1+1,   y1-2);  LineToFS(x1+1,  y1+3);
    MoveToF (x1-2, y1);    LineToFS(x1+3, y1);   MoveToF (x1,   y1-2);  LineToFS(x1,  y1+3);
  end;
 // disegna(HHDC);
end;


procedure   TPunto.DisegnaAffineSpo   (DC : hdc ;  dx,dy : Real);
var x1, y1 : single;
begin
 if b_erased then exit;
 	x1 :=  Xinschermo(x+dx);
	y1 :=  Yinschermo(y+dy);
  movetoex(dc,round(x1-3), round(y1)  ,nil);  lineto(dc,round(x1+3), round(y1));
  movetoex(dc,round(x1)  , round(y1-3),nil);  lineto(dc,round(x1)  , round(y1+3));
end;

procedure   TPunto.DisegnaAffineRot   (DC : hdc ;  xc,yc,rot : Real);
var x1, y1 : single;
	  locx,locy : single;
begin
 if b_erased then exit;
	x1 :=x-xc;               y1 :=y-yc;
	locx := x1*cos(rot) - y1*sin(rot);        	locy := x1*sin(rot) + y1*cos(rot);
	x1:=locx+xc;           	y1:=locy+yc;
 	x1 :=  Xinschermo(x1);	y1 :=  Yinschermo(y1);
  movetoex(dc,round(x1-3), round(y1)  ,nil);  lineto(dc,round(x1+3), round(y1));
  movetoex(dc,round(x1)  , round(y1-3),nil);  lineto(dc,round(x1)  , round(y1+3));
end;

procedure   TPunto.DisegnaAffineSca   (DC : hdc ;  xc,yc,sca : Real);
var x1, y1 : single;
	  locx,locy : single;
begin
	if (b_erased) then exit;
	x1 :=x-xc; 	     y1 :=y-yc;
	locx := x1*sca;        	locy := y1*sca;
	x1 :=locx+xc;	   y1:=locy+yc;
 	x1 :=  Xinschermo(x1); y1 :=  Yinschermo(y1);
  movetoex(dc,round(x1-3), round(y1)  ,nil);  lineto(dc,round(x1+3), round(y1));
  movetoex(dc,round(x1)  , round(y1-3),nil);  lineto(dc,round(x1)  , round(y1+3));
end;


procedure   TPunto.DisegnaSpoRotSca   (HHDC : TImage32;  xc,yc,rot,sca : Real;xp,yp : real;ColBordo,ColDentro : Tcolor32);
var x1, y1 : single;
	  locx,locy : single;
begin
	if (b_erased) then exit;
	x1 :=x-xc; 	  y1 :=y-yc;
	locx := x1*cos(rot) - y1*sin(rot);        	locy := x1*sin(rot) + y1*cos(rot);
	locx := locx*sca;        	locy := locy*sca;
	x1 :=locx+xc;	y1:=locy+yc;

 	x1 :=  Xinschermo(x1);	y1 :=  Yinschermo(y1);
(*

   with HHDC.Bitmap do
    begin
      MoveToF (x1-3, y1);    LineToFS(x1+3, y1);
      MoveToF (x1  , y1-3);  LineToFS(x1  , y1+3);
    end;
*)
end;







procedure   TPunto.initPunto(x1,y1 : Real);
begin
 X := x1;     Y := y1;  Z :=0;
 failimiti;
end;

procedure   TPunto.faiLimiti ;
begin
	limx1 := x-1 ;	limx2 := x+1 ;	limy1 := y-1 ;	limy2 := y+1 ;
end;


procedure   TPunto.Sposta    (dx,dy : Real);
begin
  x :=x+dx;	 y :=y+dy;
end;


procedure   TPunto.Ruota     ( xc , yc , ang : Real);
begin
 Sposta(-xc,-yc);	Ruotaang(ang);	Sposta(xc,yc);
end;

procedure   TPunto.Ruotaang  ( ang : Real);
var  locx,locy : Real;
begin
	locx := x*cos(ang) - y*sin(ang);        	locy := x*sin(ang) + y*cos(ang);
	x :=locx;	y :=locy;
end;

procedure   TPunto.Scala     ( xc , yc , scal : Real);
begin
 Sposta(-xc,-yc);	Scalasc(scal);	Sposta(xc,yc);
end;

procedure   TPunto.Scalasc   ( scal : Real);
begin
	x:=x*scal;	y:=y*scal;
end;




function    TPunto.Copia     (dx, dy : Real)  : TVettoriale;
var newpt : TPunto;
begin
  	newpt := TPunto.Create;
  	newpt.initer(_disegno,_piano);
  	newpt.initPunto(x,y);
  	_piano.Listavector.Add(newpt);
  	newpt.Sposta(dx,dy);
  	newpt.faiLimiti;
 	result:=newpt;
end;


function    TPunto.copiaPura : TVettoriale;
var newpt : TPunto;
begin
  	newpt := TPunto.Create;
  	newpt.initer(_disegno,_piano);
  	newpt.initPunto(x,y);
  	newpt.faiLimiti;
  	result:=newpt;
end;


Function    TPunto.SnapFine           (x1, y1 : Real): Boolean;
var resulta : Boolean;
    off , dx,dy : real;
begin
 resulta := false;
	off  := give_offsetmirino;
	dx   := abs(x1-x); 	dy   :=  abs(y1-y);
	if ((dx<off) and (dy<off)) then begin setxysnap(x,y);  resulta:= true;  end;
  result := resulta;
end;

Function    TPunto.SnapVicino         (x1, y1 : Real): Boolean;
var resulta : Boolean;
    off , dx,dy : real;
begin
 resulta := false;
	off  := give_offsetmirino;
	dx   := abs(x1-x); 	dy   :=  abs(y1-y);
	if ((dx<off) and (dy<off)) then begin setxysnap(x,y);  resulta:= true;  end;
  result := resulta;
end;

procedure   TPunto.seleziona_conPt    (x1,y1 : Real; _LSelezionati : Tlist);
var off ,dx,dy : real;
begin
	off  := give_offsetmirino;
	dx   := abs(x1-x); 	dy   :=  abs(y1-y);
	if ((dx<off) and (dy<off)) then  _LSelezionati.Add(self);
end;

Function    TPunto.Match_conPt        (x1, y1 : Real): Boolean;
var resulta : Boolean;
    off , dx,dy : real;
begin
 resulta := false;
	off    := give_offsetmirino;
	dx   := abs(x1-x); 	dy   :=  abs(y1-y);
	if ((dx<off) and (dy<off)) then resulta := true;
 result := resulta;
end;


procedure   TPunto.CatToUtm;
begin
// 	catastotoutm ( x ,y);
end;



Procedure   TPunto.salvavettorialeMacMap   (St : TMemoryStream);
begin
  Inherited salvavettorialeMacMap(st);
	st.Write(x, sizeof(x));
	st.Write(y, sizeof(y));
	st.Write(z, sizeof(z));
end;


Procedure   TPunto.aprivettorialeMacMap    (St : TMemoryStream);
begin
  Inherited aprivettorialeMacMap(st);
	st.Read(x, sizeof(x));
	st.Read(y, sizeof(y));
	st.Read(z, sizeof(z));
end;





end.
