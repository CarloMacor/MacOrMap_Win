unit DisegnoR;

interface

uses  System.classes,System.Math, GR32,  GR32_Image, GR32_Layers, Vcl.Controls ,FMX.Dialogs ,sysutils ,strutils, graphics,GR32_Resamplers;

type
 TDisegnoR = class
  scala                      : Real;
	limx1, limy1, limx2, limy2 : Real;
	xorigine,    yorigine      : Real;
	dimx,	     dimy            : integer;
	anglerot                   : real;
	alpha                      : Integer;
	b_visibile                 : boolean;
	Escala , Exorigine, Eyorigine, Eanglerot  : Real;
  laBitmap                   : TBitmap32;
	NomefileRaster             : string;
	coef                       : array[0..8] of real;

   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   Disegna       (HHDC : TImage32;alfaGR : integer) ;
   procedure   DisegnaRuotato(HHDC : TImage32;alfaGR : integer) ;
   procedure   DisegnaTumbnail;
   procedure   Apri(nomefile : String; sca : real);
   procedure   updateLimiti;
   procedure   updateScala(newscala : real);
   procedure   updateScalaCent(scalaGR,xcRot,ycRot : real);
   procedure   updateRotCent(rotGR,xcRot,ycRot : real);
   procedure   UpdateExParam;
   procedure   rotoscala (i_x1coord , i_y1coord, i_x2coord, i_y2coord, i_x3coord , i_y3coord, i_x4coord, i_y4coord, sca: Real);
   Function    SoloNomefile : String;
   function    TestinScermo : Boolean;
   procedure   salvacollaterale;
 end;

implementation

uses varbase, main, funzioni,GR32_Transforms,GR32_Math,JPEG, GR32_Blend, GR32_Polygons;


Constructor TDisegnoR.Create;
begin
  scala           := 1.0;
	xorigine        := 0.0;
  yorigine        := 0.0;
	anglerot        := 0.0;
	alpha           := 255;
	b_visibile      := true;
	Escala          := 1.0;
  Exorigine       := 0.0;
  Eyorigine       := 0.0;
  Eanglerot       := 0.0;
	NomefileRaster  := '';
end;

Destructor  TDisegnoR.Done;
begin
 // laBitmap.Destroy;
 // laBitmap.Free;
end;


procedure   TDisegnoR.DisegnaTumbnail;
var      R1,R2 : TRect;
   rapx , rapy : real;
   dimer : integer;
begin
   r2.Left:=0;   r2.top:=0;
   r2.Width  := Mainform.Tumbnail.Width;
   r2.Height := Mainform.Tumbnail.Height;

   r1.Left:=0;   r1.top:=0;
   r1.Width  := dimx;
   r1.Height := dimy;

   rapx := dimx / Mainform.Tumbnail.Width;
   rapy := dimy / Mainform.Tumbnail.height;

   if rapx>rapy then
    begin dimer := round(Mainform.Tumbnail.height*(rapy/rapx));
          r2.top:= (Mainform.Tumbnail.height-dimer) div 2;
          r2.height:= dimer;
          end     else
    begin dimer  := round(Mainform.Tumbnail.Width*(rapx/rapy));
          r2.left:= (Mainform.Tumbnail.Width-dimer) div 2;
          r2.width:= dimer; end;

   Mainform.Tumbnail.Bitmap.Draw(r2, r1, laBitmap);

end;


procedure   TDisegnoR.Disegna(HHDC : TImage32; alfaGR : integer) ;
var  W, H: Single;
     xr1,xr2,yr1,yr2 : single;
     R1,R2 : TRect;
     xp,yp : real;

     x1, y1 : single;
     locmasteralpha : TColor;
     alfostr : String;
     alfo : Integer;
//        Polygon: TPolygon32;
//        AColor32: TColor32;
begin

 if anglerot<>0.0 then
  begin
   DisegnaRuotato(HHDC , alfaGR ) ;
  end
   else
  begin
 	 xr1 :=  (xorigine - xOrigineVista)/ scalaVista ;
 	  yr2 :=  HHDC.height-((yorigine - yorigineVista)/ scalaVista) ;
 	  xr2 :=  xr1 + (dimx * scala) / scalaVista;
    yr1 :=  yr2 - (dimy * scala) / scalaVista;
   R1.Left:=0;       R1.top:=0;   R1.Width :=dimx;   R1.Height:=dimy;
   R2.left:=round(xr1);             R2.top:=round(yr1);
   R2.Width:=round(xr2-xr1)+1;      R2.Height:=round(yr2-yr1)+1;
// impostare che se e' fuori schermo fare saltare il disegno
                     laBitmap.DrawMode    := dmBlend;  // dmCustom; // dmOpaque, //  dmBlend;
                     laBitmap.CombineMode := cmBlend; // , cmMerge);
                     alfostr := IntToStr(alfaGR);  alfo    := strToInt(alfostr);
                     laBitmap.MasterAlpha := alfo; // MainForm.Gau_RasterGR.Position;    // alfaGR; //  255; //
//                     laBitmap.CombineMode := cmCustom; // , );
//                     alfostr := IntToStr(alfaGR);  alfo    := strToInt(alfostr);
//                     laBitmap.MasterAlpha := alfo; // MainForm.Gau_RasterGR.Position;    // alfaGR; //  255; //
  //   LaBitmap.OnPixelCombine :=  ColorMin(F, B);
   HHDC.Bitmap.Draw(r2, r1, laBitmap);
  end;

(*

          TColor32Entry(AColor32).A := 255;
          TColor32Entry(AColor32).R := 255;
          TColor32Entry(AColor32).G := 255;
          TColor32Entry(AColor32).B := 0;
               Polygon := TPolygon32.Create;
               Polygon.Antialiased := true;
               Polygon.AntialiasMode := TAntialiasMode(0);
               Polygon.Add(GR32.FixedPoint(xr1, yr1));
               Polygon.Add(GR32.FixedPoint(xr2, yr1));
               Polygon.Add(GR32.FixedPoint(xr2, yr2));
               Polygon.Add(GR32.FixedPoint(xr1, yr2));
               Polygon.Add(GR32.FixedPoint(xr1, yr1));

               Polygon.DrawEdge(HHDC.Bitmap,AColor32 );
               Polygon.free;



*)

end;


procedure   TDisegnoR.DisegnaRuotato(HHDC : TImage32; alfaGR : integer) ;
var SrcR: Integer;
  SrcB: Integer;
  T: TAffineTransformation;
  Sn, Cn: TFloat;
  Sx, Sy, Scale: Single;
  Alpha : Real;

  xr1,xr2,yr1,yr2 : single;
  deltax,deltay   : real;
  offx , offy     : Real;

       Polygon: TPolygon32;
       AColor32: TColor32;

begin
  	xr1 := Xinschermo(xorigine);
 	  yr2 :=  HHDC.height-((yorigine - yorigineVista)/ scalaVista) ;
 	  xr2 :=  xr1 + (dimx * scala) / scalaVista;
    yr1 :=  yr2 - (dimy * scala) / scalaVista;
    deltax := xr2-xr1;  deltay := yr2-yr1;
    Scale := deltay/dimy;
  SrcR := laBitmap.Width - 1;  SrcB := laBitmap.Height - 1;
  T := TAffineTransformation.Create;
  T.SrcRect := FloatRect(0, 0, SrcR + 1, SrcB + 1);
  try
    T.Clear;
    Alpha := anglerot*180/pi;
    T.Scale(Scale);
    T.Rotate(0, 0, Alpha); // anglerot
   // get the width and height of rotated image (without scaling)
    Alpha := Alpha * PI / 180;
    GR32_Math.SinCos(Alpha, Sn, Cn);
    offx := 0; offy :=0;
    offx := Sn*deltay; offy:= deltay*(1-Cn);
    T.Translate(xr1-offx,yr1+offy);

                     laBitmap.DrawMode    := dmBlend; // dmOpaque,
                     laBitmap.CombineMode := cmBlend; // , cmMerge);
                     laBitmap.MasterAlpha := alfaGR;

    Transform(HHDC.Bitmap, laBitmap, T);
  finally
    T.Free;
  end;
(*

      TColor32Entry(AColor32).A := 255;
      TColor32Entry(AColor32).R := 255;
      TColor32Entry(AColor32).G := 255;
      TColor32Entry(AColor32).B := 0;
           Polygon := TPolygon32.Create;
           Polygon.Antialiased := true;
           Polygon.AntialiasMode := TAntialiasMode(0);
           Polygon.Add(GR32.FixedPoint(xr1, yr1));
           Polygon.Add(GR32.FixedPoint(xr2, yr1));
           Polygon.Add(GR32.FixedPoint(xr2, yr2));
           Polygon.Add(GR32.FixedPoint(xr1, yr2));
           Polygon.Add(GR32.FixedPoint(xr1, yr1));

           Polygon.DrawEdge(HHDC.Bitmap,AColor32 );
           Polygon.free;


*)

end;



procedure   TDisegnoR.Apri(nomefile : String; sca : real);
var
     F : TextFile;
     nometfw : String;
     rig1,rig2,rig3,rig4,rig5,rig6,rig7  : String;
     valore : Real; coda : Integer;
     valInt : Integer;
begin
  laBitmap := TBitmap32.Create;
  laBitmap.LoadFromFile(nomefile);
   NomefileRaster              := nomefile;

   nometfw  := nomefile;
   nometfw[length(nometfw)]  := 'w';

 //   showmessage(nomefile);
//    showmessage(nometfw);


   if fileexists(nometfw) then
    begin
     assignFile(F,nometfw); reset(F);
      if not(eof(F)) then begin readln(F,xorigine); end;
      if not(eof(F)) then begin readln(F,yorigine); end;
      if not(eof(F)) then begin readln(F,scala);    end;
      if not(eof(F)) then begin readln(F,rig4);     end;
      if not(eof(F)) then begin readln(F,anglerot); end;
      if not(eof(F)) then begin readln(F,dimx);     end;
      if not(eof(F)) then begin readln(F,dimy);     end;
     closefile(F);
    end;


   dimx                        := laBitmap.Width;
   dimy                        := laBitmap.Height;

    Escala    := scala;
    Exorigine := xorigine;
    Eyorigine := yorigine;
    Eanglerot := anglerot;
 //  xOrigineVista :=xorigine;
 //  yOrigineVista :=yorigine;
 //  ScalaVista    :=scala*4;
   updatelimiti;
end;

procedure  TDisegnoR.salvacollaterale;
var  F : TextFile;
     nometfw : String;
     momanglerot : Real;
begin
   nometfw  := NomefileRaster;
   nometfw[length(NomefileRaster)]  := 'w';
   assignFile(F,nometfw); rewrite(F);
      writeln(F,xorigine:0:2);
      writeln(F,yorigine:0:2);
      writeln(F,scala:0:8);
      writeln(F,scala:0:8);
//      momanglerot := anglerot*180/M_Pi;
      momanglerot := anglerot;
      writeln(F,momanglerot:0:8);
      writeln(F,dimx);
      writeln(F,dimy);
     closefile(F);
end;


procedure  TDisegnoR.updateLimiti;
var locx1 , locy1 , locx2 , locy2 , locx3 , locy3 : Real;
    rad_angolo : real;
begin
	limx1 := xorigine;            	limy1 := yorigine;
	limx2 := xorigine;            	limy2 := yorigine;
  if anglerot=0.0 then
   begin
  	limx2 := xorigine+dimx*scala;
    limy2 := yorigine+dimy*scala;
   end
    else
   begin
//    rad_angolo:=anglerot*pi/180;
    rad_angolo:=anglerot;
    if anglerot<0 then
     begin
       rad_angolo:=-rad_angolo;
      	limx2 := xorigine+dimx*scala*cos(rad_angolo)+dimy*scala*sin(rad_angolo) ;
      	limy1 := yorigine-dimx*scala*sin(rad_angolo);
      	limy2 := yorigine+dimy*scala*cos(rad_angolo);
     end
      else
     begin
      	limx1 := xorigine-dimy*scala*sin(rad_angolo) ;
      	limx2 := xorigine+dimx*scala*cos(rad_angolo);
      	limy2 := yorigine+dimy*scala*cos(rad_angolo)+dimx*scala*sin(rad_angolo);
     end;
   end;
end;


procedure  TDisegnoR.updateScalaCent(scalaGR,xcRot,ycRot : real);
begin
 scala    := Escala*scalaGR;
 xorigine := Exorigine;
 yorigine := Eyorigine;
 scalacentra ( xcrot , ycrot , scala , Escala, xorigine, yorigine);
end;

procedure  TDisegnoR.updateScala(newscala : real);
begin
 scala    := newscala*scala;
 updateLimiti;
end;



procedure  TDisegnoR.updateRotCent(rotGR,xcRot,ycRot : real);
begin
 anglerot := Eanglerot+rotGR;
 xorigine := Exorigine;
 yorigine := Eyorigine;
 rotocentra    ( xcrot , ycrot , anglerot , Eanglerot, xorigine, yorigine );
end;

procedure  TDisegnoR.UpdateExParam;
begin
 Exorigine := xorigine;
 Eyorigine := yorigine;
 Escala    := scala;
 Eanglerot := anglerot;
end;


procedure  TDisegnoR.rotoscala (i_x1coord , i_y1coord, i_x2coord, i_y2coord, i_x3coord , i_y3coord, i_x4coord, i_y4coord, sca: Real);
var	offx1, offy1, offx2, offy2 : Real;
    newx, newy,backangolo : real;
	  dxold, dyold, alfaold : real;
    dxnew,dynew, alfanew  : real;
    alfare : Real;
    LLOld, LLNew, para, scala_raster_x1_new, scala_raster_y1_new : Real;
	  ofdx,ofdy : real;
begin
	// se ruotato riaggiornare i punti sulla immagine x1,y1 e x2,y2

	if (anglerot <>0.0) then begin
	 offx1 := i_x1coord-xorigine;		offy1 := i_y1coord-yorigine;
	 offx2 := i_x2coord-xorigine;		offy2 := i_y2coord-yorigine;
   backangolo :=-anglerot;
	 newx  := offx1*cos(backangolo)-offy1*sin(backangolo);
	 newy  := offx1*sin(backangolo)+offy1*cos(backangolo);
   i_x1coord := newx+xorigine;		i_y1coord := newy+yorigine;
   newx  := offx2*cos(backangolo)-offy2*sin(backangolo);
	 newy  := offx2*sin(backangolo)+offy2*cos(backangolo);
   i_x2coord :=newx+xorigine;		  i_y2coord := newy+yorigine;
  end;

	dxold := i_x2coord-i_x1coord;
	dyold := i_y2coord-i_y1coord;

	if (dxold=0) then  begin if (dyold>0) then alfaold := PI/2 else  alfaold := - PI/2; end
               else alfaold := arctan2(dyold,dxold);

	dxnew := i_x4coord-i_x3coord;
	dynew := i_y4coord-i_y3coord;
  if (dxnew=0) then begin
    if (dynew>0) then  alfanew := PI/2 else  alfanew := - PI/2; end else alfanew := arctan2(dynew,dxnew);


	alfare   := alfanew-alfaold;
//	anglerot := alfare*180/pi;
	anglerot := alfare;
	LLOld    := hypot(dxold , dyold);
	LLNew    := hypot(dxnew , dynew);
	para     := LLNew/LLOld;
	scala_raster_x1_new := scala*para;
	scala_raster_y1_new := scala*para;

	ofdx := (i_x1coord-xorigine)*scala_raster_x1_new;
	ofdy := (i_y1coord-yorigine)*scala_raster_y1_new;

	ofdx := (i_x1coord-xorigine)*para;
	ofdy := (i_y1coord-yorigine)*para;

	xorigine := (i_x3coord-ofdx*cos(alfare))+ofdy*sin(alfare);
	yorigine := (i_y3coord-ofdy*cos(alfare))-ofdx*sin(alfare);
	scala := scala_raster_x1_new;
//	scalay = scala_raster_y1_new;


   updateLimiti;
end;


Function    TDisegnoR.SoloNomefile : String;
begin
 result := ExtractFileName(NomefileRaster);
end;

function    TDisegnoR.TestinScermo : Boolean;
var xr1,xr2,yr1,yr2 : single;
    resulta : Boolean;
begin
 resulta := true;
   	xr1 :=  Xinschermo(xorigine);
   	yr2 :=  Yinschermo(yorigine);
 	  xr2 :=  xr1 + (dimx * scala) / scalaVista;
    yr1 :=  yr2 - (dimy * scala) / scalaVista;
    if xr2<0        then resulta := false;
    if xr1>Wschermo then resulta := false;

    if yr2<0        then resulta := false;
    if yr1>HSchermo then resulta := false;

  result := resulta;
end;




end.
