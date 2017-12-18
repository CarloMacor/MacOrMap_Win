unit UViste;

interface

uses  Classes,sysutils,FMX.Dialogs, GR32,  GR32_Image;

procedure zoomPiu_Meno_0_1(code : Integer);
procedure zoomTutto;
procedure setLimitiTutto (_x1, _y1, _x2, _y2 : Real);
procedure setLimitiDisR  (_x1, _y1, _x2, _y2 : Real);
procedure setLimitiRas   (_x1, _y1, _x2, _y2 : Real);
procedure setLimitiDisV  (_x1, _y1, _x2, _y2 : Real);
procedure setLimitiPiano (_x1, _y1, _x2, _y2 : Real);


procedure set_scalaVista2 (value1, value2    : Real);
procedure set_scalaVista  (value   : Real);
procedure setZoomC        (x1,y1 : Real);

procedure setZoomW        (x1,y1,x2,y2 : Real);

// attuazzione degli zoom
//- (void)   setZoomAll;
procedure setZoomAllRaster;
procedure setZoomLocRaster;
procedure setZoomAllVector;
procedure setZoomPianoVector;
procedure setZoomDisegnoVCorrente;
procedure setZoomQuadroUnione;
procedure riaggiornax2y2;
procedure riaggiornax2y2stampa;
procedure setZoom4vt(x1,y1,x2,y2,param: Real);




procedure MyMouseMove(HHDC : TImage32; Sh: TShiftState; X,Y : Integer);
procedure MyMouseWeel(WheelDelta: Integer; Sh: TShiftState; X,Y : Integer);

procedure MyTestMove(X,Y : Integer);

procedure ScalaSchermo(scaloscr, newscale : Real);



const  parametrozoom = 1.41;
var sonoinridisegna : Boolean;


implementation

uses main, Interfaccia, varbase,funzioni,proiezioni , disegnoGR, progetto,catastoV;

procedure ScalaSchermo(scaloscr, newscale : Real);
var exdx,exdy : real;
    newdx,newdy : real;
    offdx,offdy : real;
begin
 exdx := MainForm.BaseSchermo.Width  * ScalaVista;
 exdy := MainForm.BaseSchermo.Height * ScalaVista;

 scalavista := ((newscale/scaloscr)  /(Hschermo))/10;

 newdx := MainForm.BaseSchermo.Width  * ScalaVista;
 newdy := MainForm.BaseSchermo.Height * ScalaVista;
 offdx := (newdx-exdx)/2;
 offdy := (newdy-exdy)/2;
 xOrigineVista := xOrigineVista-offdx;
 yOrigineVista := yOrigineVista-offdy;
 riaggiornax2y2;
 ridisegna;
end;


procedure MyMouseWeel(WheelDelta: Integer; Sh: TShiftState; X,Y : Integer);
var yr : integer;
    oldxpos,oldypos : Real;
    parametrozoom, para   : Real;
    newxpos,newypos , offdx,offdy : Real;
begin
  if WheelDelta = 0 then exit;
  if sonoinridisegna then begin exit ; showmessage('alt'); end;

  X := xmouseI;
  Y := ymouseI;


	oldxpos := x*scalaVista;
	oldypos := y*scalaVista;
	parametrozoom   := 1;

	para := WheelDelta/1000;

	if (para<0) then parametrozoom:=1+para else parametrozoom:=1/(1-para);
	scalaVista :=scalaVista*parametrozoom;

	newxpos := X*scalaVista;
	newypos := Y*scalaVista;

  offdx   := newxpos - oldxpos;
	offdy   := newypos - oldypos;

	xorigineVista := xorigineVista - offdx;
  yorigineVista := yorigineVista - offdy;


//	varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista] ;
//	varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista] ;
//  showmessage(Inttostr(WheelDelta));
  sonoinridisegna := true;
  ridisegna;
  sonoinridisegna := false;

end;

procedure MyTestMove(X,Y : Integer);
begin
  mainform.Info_XMouse.Text := IntToStr(X);
  mainform.Info_YMouse.Text := IntToStr(Y);
end;



procedure MyMouseMove(HHDC : TImage32; Sh: TShiftState; X,Y : Integer);
begin
 xmouseI := X;
 ymouseI := Y;

 xmouse := xoriginevista+X*ScalaVista;
 ymouse := yoriginevista+Y*ScalaVista;
 // qui i comandi anche quelli trasparenti

 Trasformacoord(xmouse,ymouse,xmouseProj,ymouseProj,ProiezioneCorrente);
// ridisegnaCoordinateMouse; // Interfaccia

 if ssMiddle in Sh  then begin // siamo in fase Pan
  if mouseMiddleIsDown then
   begin
    xorigineVista:=xOriginePrePan-(X-xstMiddleI)*scalavista;
    yorigineVista:=yOriginePrePan-(Y-ystMiddleI)*scalavista;
    ridisegna;
   end else
   begin
    xstMiddleI := x; ystMiddleI := y;
    xOriginePrePan := xOrigineVista; yOriginePrePan := yOrigineVista;
    mouseMiddleIsDown :=true;
   end;
 end else   mouseMiddleIsDown :=false;

 ridisegnaCoordinateMouse; // Interfaccia

 if not(mouseMiddleIsDown) then
  begin
   IlProgetto.MouseMove(HHDC,Sh,X,Y);
  end;

end;


procedure setZoomW        (x1,y1,x2,y2 : Real);
var dx,dy , scal: Real;
begin
 if x1 <x2 then xOrigineVista := x1 else xOrigineVista := x2;
 if y1 <y2 then yOrigineVista := y1 else yOrigineVista := y2;

	dx  := x2-x1;	dy  := y2-y1;
  scalaVista    := dx/ Mainform.BaseSchermo.Width;
  scal          := dy/ Mainform.BaseSchermo.Height;
	set_scalaVista2 (scalaVista,scal);
// xOrigineVista := xOrigineVista-offdx;
// yOrigineVista := yOrigineVista-offdy;

 ridisegna;
end;

procedure zoomPiu_Meno_0_1(code : Integer);
var exdx,exdy : real;
    newdx,newdy : real;
    offdx,offdy : real;
begin
 exdx := MainForm.BaseSchermo.Width  * ScalaVista;
 exdy := MainForm.BaseSchermo.Height * ScalaVista;
 case code of
  0 :  ScalaVista := ScalaVista/parametrozoom;
  1 :  ScalaVista := ScalaVista*parametrozoom;
 end;
 newdx := MainForm.BaseSchermo.Width  * ScalaVista;
 newdy := MainForm.BaseSchermo.Height * ScalaVista;
 offdx := (newdx-exdx)/2;
 offdy := (newdy-exdy)/2;
 xOrigineVista := xOrigineVista-offdx;
 yOrigineVista := yOrigineVista-offdy;
 ridisegna;
end;


procedure riaggiornax2y2;
begin
	x2origineVista := xorigineVista + MainForm.BaseSchermo.Width*scalaVista;
	y2origineVista := yorigineVista + MainForm.BaseSchermo.Height*scalaVista;
end;

procedure riaggiornax2y2stampa;
begin
	x2origineVista := xorigineVista + MainForm.Image32Stampa.Width*scalaVista;
	y2origineVista := yorigineVista + MainForm.Image32Stampa.Height*scalaVista;
end;


procedure set_scalaVista (value   : Real);
begin
	scalaVista   := value;
	riaggiornax2y2;
end;


procedure set_scalaVista2 (value1, value2    : Real);
var value : Real;
begin
	value:=value1;
	if (value2>value1) then value:=value2;
	if (value=0) then value:=1.0;
	set_scalaVista(value);
end;



procedure zoomTutto;
var	dx, dy, d_scal : Real;
begin
	xorigineVista := limx1Tutto;
	yorigineVista := limy1Tutto;
	dx            := limx2Tutto-limx1Tutto;
	dy            := limy2Tutto-limy1Tutto;
  scalaVista    := dx/Mainform.BaseSchermo.Width;
  d_scal        := dy/Mainform.BaseSchermo.Height;


	set_scalaVista2(scalaVista, d_scal);
	setZoomC      (((limx1Tutto+limx2Tutto)/2), ((limy1Tutto+limy2Tutto)/2) ) ;
// ridisegna;

// showmessage(IntTostr(round(xorigineVista)));

end;

procedure  setZoomC          (x1,y1 : Real);
var	dx, dy : Real;
begin
	dx :=     scalaVista*Mainform.BaseSchermo.Width;
  dy :=     scalaVista*Mainform.BaseSchermo.Height;
	xorigineVista := x1-dx/2;
	yorigineVista := y1-dy/2;
	riaggiornax2y2;
end;

procedure setLimitiTutto  (_x1, _y1, _x2, _y2 : Real);
begin
	limx1Tutto :=_x1;		limx2Tutto:=_x2;		limy1Tutto:=_y1;		limy2Tutto:=_y2;
end;

procedure setLimitiDisR  (_x1, _y1, _x2, _y2 : Real);
begin
	limx1DisR:=_x1;		limx2DisR:=_x2;		limy1DisR:=_y1;		limy2DisR:=_y2;
end;

procedure setLimitiRas   (_x1, _y1, _x2, _y2 : Real);
begin
	limx1Ras:=_x1;		limx2Ras:=_x2;		limy1Ras:=_y1;		limy2Ras:=_y2;
end;

procedure setLimitiDisV  (_x1, _y1, _x2, _y2 : Real);
begin
	limx1DisV:=_x1;		limx2DisV:=_x2;		limy1DisV:=_y1;		limy2DisV:=_y2;
end;

procedure setLimitiPiano (_x1, _y1, _x2, _y2 : Real);
begin
	limx1Piano:=_x1;	limx2Piano:=_x2;	limy1Piano:=_y1;	limy2Piano:=_y2;
end;


procedure setZoomAllRaster;
var	x1, y1, x2, y2, dx, dy, scal : Real;
    k : Integer; LocGR : TDisegnoGR;
begin
 for k:= 0 to IlProgetto.ListaDisegniGR.Count-1 do
  begin
   LocGR := IlProgetto.ListaDisegniGR.Items[k];
   if k=0 then
    begin
     x1 := LocGR.limx1;  x2 := LocGR.limx2;
     y1 := LocGR.limy1;  y2 := LocGR.limy2;
    end
     else
    begin
     if x1<LocGR.limx1 then x1 := LocGR.limx1;
     if x2>LocGR.limx2 then x2 := LocGR.limx2;
     if y1<LocGR.limy1 then y1 := LocGR.limy1;
     if y2>LocGR.limy2 then y2 := LocGR.limy2;
    end;
  end;

	if (x1 = x2) then exit;
	xorigineVista := x1;
	yorigineVista := y1;
	dx  := x2-x1;	dy  := y2-y1;
  scalaVista    := dx/ Mainform.BaseSchermo.Width;
  scal          := dy/ Mainform.BaseSchermo.Height;
	set_scalaVista2 (scalaVista,scal);
	setZoomC    (((x1+x2)/2)  , ((y1+y2)/2)  );
end;


procedure setZoomLocRaster;
var  dx, dy, scal : Real;
begin
	if (limx1Ras = limx2Ras) then exit;
	xorigineVista := limx1Ras;  	    yorigineVista := limy1Ras;
	dx            := limx2Ras-limx1Ras;
	dy            := limy2Ras-limy1Ras;
  scalaVista    := dx/ Mainform.BaseSchermo.Width;
  scal          := dy/ Mainform.BaseSchermo.Height;
	set_scalaVista2 (scalaVista , scal);




	setZoomC      ( ((limx1Ras+limx2Ras)/2)  , ((limy1Ras+limy2Ras)/2)  );
end;

procedure setZoomAllVector;
var  dx, dy, scal : Real;
begin
	if (limx1DisV = limx2DisV) then exit;
	xorigineVista := limx1DisV;
	yorigineVista := limy1DisV;
	dx            := limx2DisV-limx1DisV;
	dy            := limy2DisV-limy1DisV;
  scalaVista    := dx/ Mainform.BaseSchermo.Width;
  scal          := dy/ Mainform.BaseSchermo.Height;
	set_scalaVista2 (scalaVista , scal );
	setZoomC      ( ((limx1DisV+limx2DisV)/2)  , ((limy1DisV+limy2DisV)/2)  );
end;

procedure setZoomPianoVector;
var  dx, dy, scal : Real;
begin
	if (ilprogetto.PianoCorrente.limx1 = ilprogetto.PianoCorrente.limx2) then exit;
	xorigineVista := ilprogetto.PianoCorrente.limx1;
	yorigineVista := ilprogetto.PianoCorrente.limy1;
	dx            := ilprogetto.PianoCorrente.limx2-ilprogetto.PianoCorrente.limx1;
	dy            := ilprogetto.PianoCorrente.limy2-ilprogetto.PianoCorrente.limy1;
  scalaVista    := dx/ Mainform.BaseSchermo.Width;
  scal          := dy/ Mainform.BaseSchermo.Height;
	set_scalaVista2 (scalaVista , scal);
	setZoomC      ( ((ilprogetto.PianoCorrente.limx1+ilprogetto.PianoCorrente.limx2)/2)  ,
                  ((ilprogetto.PianoCorrente.limy1+ilprogetto.PianoCorrente.limy2)/2)  );
end;

procedure setZoomDisegnoVCorrente;
var  dx, dy, scal : Real;
begin
	if (ilprogetto.DisegnoVCorrente.limx1 = ilprogetto.DisegnoVCorrente.limx2) then exit;
	xorigineVista := ilprogetto.DisegnoVCorrente.limx1;
	yorigineVista := ilprogetto.DisegnoVCorrente.limy1;
	dx            := ilprogetto.DisegnoVCorrente.limx2-ilprogetto.DisegnoVCorrente.limx1;
	dy            := ilprogetto.DisegnoVCorrente.limy2-ilprogetto.DisegnoVCorrente.limy1;
  scalaVista    := dx/ Mainform.BaseSchermo.Width;
  scal          := dy/ Mainform.BaseSchermo.Height;
	set_scalaVista2 (scalaVista , scal);
	setZoomC      ( ((ilprogetto.DisegnoVCorrente.limx1+ilprogetto.DisegnoVCorrente.limx2)/2)  , ((ilprogetto.DisegnoVCorrente.limy1+ilprogetto.DisegnoVCorrente.limy2)/2)  );
end;


procedure setZoomQuadroUnione;
var  dx, dy, scal : Real;
begin
  if IlCatastoV.QUnione= nil then exit;
	if (IlCatastoV.QUnione.limx1 = IlCatastoV.QUnione.limx2) then exit;
	xorigineVista := IlCatastoV.QUnione.limx1;
	yorigineVista := IlCatastoV.QUnione.limy1;
	dx            := IlCatastoV.QUnione.limx2-IlCatastoV.QUnione.limx1;
	dy            := IlCatastoV.QUnione.limy2-IlCatastoV.QUnione.limy1;
  scalaVista    := dx/ Mainform.BaseSchermo.Width;
  scal          := dy/ Mainform.BaseSchermo.Height;
	set_scalaVista2 (scalaVista , scal);
	setZoomC      ( ((IlCatastoV.QUnione.limx1+IlCatastoV.QUnione.limx2)/2)  , ((IlCatastoV.QUnione.limy1+IlCatastoV.QUnione.limy2)/2)  );
end;

procedure setZoom4vt(x1,y1,x2,y2,param: Real);
var  dx, dy, scal : Real;
begin
	xorigineVista := x1;
	yorigineVista := y1;
	dx            := x2-x1;
	dy            := y2-y1;
  scalaVista    := dx/ Mainform.BaseSchermo.Width;
  scal          := dy/ Mainform.BaseSchermo.Height;
	set_scalaVista2 (scalaVista*param , scal*param);
	setZoomC      ( ((x1+x2)/2)  , ((y1+y2)/2)  );
end;


end.




