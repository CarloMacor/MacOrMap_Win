unit Vertice;

interface

uses windows, System.classes, GR32,  GR32_Image, GR32_Layers, Vcl.Controls ,FMX.Dialogs ,sysutils ;

type
 TVertice = class
 	x  : Real;
	y  : Real;
	z  : Real;
	up : Boolean;

   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   Procedure   InitVertice   (x1,y1 : Real);
   Procedure   InitVerticeUp (x1,y1 : Real);
   Procedure   salvavettorialeMacMap   (St : TMemoryStream);
   Procedure   aprivettorialeMacMap    (St : TMemoryStream);

   Procedure   setVtUp;
   Procedure   setVtDown;
   Procedure   moveto        (HHDC : TImage32);
   Procedure   lineto_        (HHDC : TImage32);
   Procedure   Sposta        (dx,dy : Real);
   Procedure   Ruotaang      (ang   : real);
   Procedure   Scalasc       (scal  : real);
   Procedure   CatToUtm;

   Procedure   movetoSpo         (DC : hdc ;  dx,dy : real);
   Procedure   linetoSpo         (DC : hdc ;  dx,dy : real);
   Procedure   movetoRot         (DC : hdc ;  xc,yc,rot : real);
   Procedure   linetoRot         (DC : hdc ;  xc,yc,rot : real);
   Procedure   movetoSca         (DC : hdc ;  xc,yc,sca : real);
   Procedure   linetoSca         (DC : hdc ;  xc,yc,sca : real);
   Procedure   movetoRotSca      (HHDC : TImage32 ;  xc,yc,rot,sca : real);
   Procedure   linetoRotSca      (HHDC : TImage32 ;  xc,yc,rot,sca : real);

   Procedure   discroce          (HHDC : TImage32);
   Procedure   dispallino        (HHDC : TImage32);
   Procedure   dispallinofinale  (HHDC : TImage32);



   Procedure   CopiaconVt    (VT : TVertice);

  end;


 var ilVertice : TVertice;
     vtprimoTaglio   : TVertice;
     vtsecondoTaglio : TVertice;


implementation

uses varbase,proiezioni;


constructor TVertice.Create;
 begin
 end;

Destructor  TVertice.Done;
 begin
 end;


Procedure   TVertice.InitVertice   (x1,y1 : Real);
begin
 x := x1;	y := y1; up := false;
end;

Procedure   TVertice.InitVerticeUp (x1,y1 : Real);
begin
 x := x1;	y := y1; up := true;
end;


Procedure   TVertice.setVtUp;
begin
 up := true;
end;

Procedure   TVertice.setVtDown;
begin
 up := false;
end;


Procedure   TVertice.moveto(HHDC : TImage32);
var x1,y1 : single;
begin
	x1 := (x-xOrigineVista)/ScalaVista;
	y1 := (y-yOrigineVista)/ScalaVista;
  y1 := Hschermo-y1;
  HHDC.Bitmap.MoveToF(x1,y1);
end;



Procedure   TVertice.lineto_(HHDC : TImage32);
var x1,y1 : single;
begin
	x1 := (x-xOrigineVista)/ScalaVista;
	y1 := (y-yOrigineVista)/ScalaVista;
  y1 := Hschermo-y1;
  HHDC.Bitmap.LineToFS(x1,y1);
end;

Procedure   TVertice.Sposta        (dx,dy : Real);
begin
  	x:=x+dx;	y:=y+dy;
end;

Procedure   TVertice.Ruotaang      (ang   : real);
var  locx,locy : real;
begin
	locx := x*cos(ang) - y*sin(ang);
  locy := x*sin(ang) + y*cos(ang);
	x:=locx;	y:=locy;
end;

Procedure   TVertice.Scalasc       (scal  : real);
var  locx,locy : real;
begin
	locx := x*scal;      locy := y*scal;
	x := locx;           y := locy;
end;

Procedure   TVertice.CatToUtm;
begin
  catastotoutm(x,y);
end;



Procedure   TVertice.movetoSpo         (DC : hdc ;  dx,dy : real);
var x1,y1 : single;
begin
	x1 := ((x+dx)-xOrigineVista)/ScalaVista;
	y1 := ((y+dy)-yOrigineVista)/ScalaVista;
  y1 := Hschermo-y1;
  MoveToex(dc,round(x1),round(y1),nil);
end;

Procedure   TVertice.linetoSpo         (DC : hdc ;  dx,dy : real);
var x1,y1 : single;
begin
	x1 := ((x+dx)-xOrigineVista)/ScalaVista;
	y1 := ((y+dy)-yOrigineVista)/ScalaVista;
  y1 := Hschermo-y1;
  lineto(dc  ,round(x1),round(y1));
end;

Procedure   TVertice.movetoRot         (DC : hdc ;  xc,yc,rot : real);
var x1,y1     : single;
 	  locx,locy : single;
begin
	x1 :=x-xc;
	y1 :=y-yc;
	locx := x1*cos(rot) - y1*sin(rot);        	locy := x1*sin(rot) + y1*cos(rot);
	x1 :=locx+xc;	y1 :=locy+yc;
	x1 :=(x1-xorigineVista)/scalaVista;
	y1 :=(y1-yorigineVista)/scalaVista;
  y1 := Hschermo-y1;
  MoveToex(dc,round(x1),round(y1),nil);
end;

Procedure   TVertice.linetoRot         (DC : hdc ;  xc,yc,rot : real);
var x1,y1     : single;
 	  locx,locy : single;
begin
	x1 :=x-xc;
	y1 :=y-yc;
	locx := x1*cos(rot) - y1*sin(rot);        	locy := x1*sin(rot) + y1*cos(rot);
	x1 :=locx+xc;	y1 :=locy+yc;
	x1 :=(x1-xorigineVista)/scalaVista;
	y1 :=(y1-yorigineVista)/scalaVista;
  y1 := Hschermo-y1;
  lineto(dc  ,round(x1),round(y1));
end;


Procedure   TVertice.movetoSca         (DC : hdc ;  xc,yc,sca : real);
var x1,y1     : single;
 	  locx,locy : single;
begin
	x1 :=x-xc;
	y1 :=y-yc;
	locx := x1*sca;        	locy := y1*sca;
	x1 :=locx+xc;	y1 :=locy+yc;
	x1 :=(x1-xorigineVista)/scalaVista;
	y1 :=(y1-yorigineVista)/scalaVista;
  y1 := Hschermo-y1;
  MoveToex(dc,round(x1),round(y1),nil);
end;


Procedure   TVertice.linetoSca         (DC : hdc ;  xc,yc,sca : real);
var x1,y1     : single;
 	  locx,locy : single;
begin
	x1 :=x-xc;
	y1 :=y-yc;
	locx := x1*sca;        	locy := y1*sca;
	x1 :=locx+xc;	y1 :=locy+yc;
	x1 :=(x1-xorigineVista)/scalaVista;
	y1 :=(y1-yorigineVista)/scalaVista;
  y1 := Hschermo-y1;
  lineto(dc  ,round(x1),round(y1));
end;


Procedure   TVertice.movetoRotSca      (HHDC : TImage32 ;  xc,yc,rot,sca : real);
var x1,y1     : single;
 	  locx,locy : single;
begin
	x1 :=x-xc;              	y1   :=y-yc;
	locx := x1*cos(rot) - y1*sin(rot);        	locy := x1*sin(rot) + y1*cos(rot);
	locx := locx*sca;        	locy := locy*sca;
	x1 := locx+xc;            y1   := locy+yc;
	x1 :=(x1-xorigineVista)/scalaVista;
	y1 :=(y1-yorigineVista)/scalaVista;
  y1 := Hschermo-y1;
  HHDC.Bitmap.MoveToF(x1,y1);
end;


Procedure   TVertice.linetoRotSca      (HHDC : TImage32 ;  xc,yc,rot,sca : real);
var x1,y1     : single;
 	  locx,locy : single;
begin
	x1 :=x-xc;              	y1   :=y-yc;
	locx := x1*cos(rot) - y1*sin(rot);        	locy := x1*sin(rot) + y1*cos(rot);
	locx := locx*sca;        	locy := locy*sca;
	x1 := locx+xc;            y1   := locy+yc;
	x1 :=(x1-xorigineVista)/scalaVista;
	y1 :=(y1-yorigineVista)/scalaVista;
  y1 := Hschermo-y1;
  HHDC.Bitmap.LineToFS(x1,y1);
end;

Procedure   TVertice.discroce          (HHDC : TImage32);
var x1,y1     : single;
begin
	x1 := (x-xorigineVista)/scalaVista;
	y1 := (y-yorigineVista)/scalaVista;
  y1 := Hschermo-y1;
  HHDC.Bitmap.MoveToF(x1-2,y1-2);
  HHDC.Bitmap.LineToFS(x1+2,y1-2);
  HHDC.Bitmap.LineToFS(x1+2,y1+2);
  HHDC.Bitmap.LineToFS(x1-2,y1+2);
  HHDC.Bitmap.LineToFS(x1-2,y1-2);
end;



Procedure   TVertice.dispallino        (HHDC : TImage32);
var x1,y1     : single;
    k : Integer;
begin
	x1 := (x-xorigineVista)/scalaVista;
	y1 := (y-yorigineVista)/scalaVista;
  y1 := Hschermo-y1;
  discroce(HHDC);
//  HHDC.Bitmap.
//  CGContextAddArc (hdc, x1, y1 , 1, 0, 2*M_PI, 0);
//  CGContextStrokePath(hdc);


end;




Procedure   TVertice.dispallinofinale  (HHDC : TImage32);
var x1,y1     : single;
begin
	x1 := (x-xorigineVista)/scalaVista;
	y1 := (y-yorigineVista)/scalaVista;
  y1 := Hschermo-y1;
  discroce(HHDC);

{
  		CGContextAddArc (hdc, x1, y1 , 3, 0, 2*M_PI, 0);
  		CGContextFillPath(hdc);
  		CGContextAddArc (hdc, x1, y1 , 5, 0, 2*M_PI, 0);
  		CGContextStrokePath(hdc);

}

end;




Procedure   TVertice.CopiaconVt    (VT : TVertice);
begin
	x  := vt.x;
	y  := vt.y;
	z  := vt.z;
	up := vt.up;
end;



Procedure   TVertice.salvavettorialeMacMap   (St : TMemoryStream);
begin
	st.Write(x, sizeof(x));
	st.Write(y, sizeof(y));
	st.Write(z, sizeof(z));
	st.Write(Up, sizeof(Up));
end;


Procedure   TVertice.aprivettorialeMacMap    (St : TMemoryStream);
begin
	st.Read(x, sizeof(x));
	st.Read(y, sizeof(y));
	st.Read(z, sizeof(z));
	st.Read(Up, sizeof(Up));
end;





end.
