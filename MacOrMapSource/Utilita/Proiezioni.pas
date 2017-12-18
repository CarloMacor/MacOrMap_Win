unit Proiezioni;

interface

procedure Trasformacoord(xmo,ymo : Real; var xmoProj : real;var ymoProj : Real; Proiez: Integer);


procedure UtmToLatlon2 (x1,y1 : Real; var xcord : real;var ycord : Real);


procedure utmtocatasto  (var x1 : Real; var y1 : real);
procedure utmtolatlon   (var x1 : Real; var y1 : real);
procedure utmtoGBoaga   (var x1 : Real; var y1 : real);
procedure utmtoutm50    (var x1 : Real; var y1 : real);
procedure utmtolatlon50 (var x1 : Real; var y1 : real);

procedure catastotoutm  (var x1 : Real; var y1 : real);
procedure latlonToUtm   (var x1 : Real; var y1 : real);
procedure GBoagaToUtm   (var x1 : Real; var y1 : real);
procedure latlon50ToUtm (var x1 : Real; var y1 : real);
procedure utm50toutm    (var x1 : Real; var y1 : real);

function  ingradi ( valore : Real) : String;

var     offsetCxfX,offsetCxfY : real;




implementation


uses Math,sysutils,main,varbase;

procedure Trasformacoord(xmo,ymo : Real; var xmoProj : real; var ymoProj : Real; Proiez: Integer);
begin
    case Proiez of
         2 : begin UtmToLatlon   (xmo,ymo); end;  // globo WGS84
  		   3 : begin utmtoutm50    (xmo,ymo); end;  // qui la modifica tra wgs84 e D50
  		   4 : begin utmtolatlon50 (xmo,ymo); end;  // globo D50
  		   5 : begin utmtocatasto  (xmo,ymo); end;  // Cassini
         6 : begin utmtoGBoaga   (xmo,ymo); end;  // Gauss-Boaga
     else begin   end;
    end;
  xmoProj :=xmo;  ymoProj :=ymo;
end;


procedure UtmToLatlon2 (x1,y1 : Real; var xcord : real;var ycord : Real);
var a , f, drad, k0, b, e,esq,e0sq  : extended;
    utmz : Integer;
    x,y : extended;
    zcm, e1, M0,M, mu,phi1, C1, T1, N1, R1, D : extended;
    MMD1k0,XMMD1k0 : extended;
    esiner, phi,lng,lngd : extended;
begin
	a    := 6378137.0;                    // equatorial radius, meters.
	f    := 1.0/298.2572236;              // polar flattening.
	drad := PI/180.0;                     // Convert degrees to radians)
	k0   := 0.9996;                       // scale on central meridian
	b    := a*(1-f);                      // polar axis.
	e    := sqrt(1 - (b/a)*(b/a));        // eccentricity
	esq  := (1.0 - (b/a)*(b/a));          // e squared for use in expansions
	e0sq := e*e/(1.0-e*e);                // e0 squared - always even powers
	utmz := 33;
	x    := x1-(utmz-31)*1010000;
  y    :=y1;
  zcm  := 3.0 + 6.0*(utmz-1.0) - 180.0;                        //Central meridian of zone
	e1   := (1.0 - sqrt(1.0 - e*e))/(1.0 + sqrt(1.0 - e*e));     //Called e1 in USGS PP 1395 also
	M0   := 0;                                                   //In case origin other than zero lat - not needed for standard UTM
	M    := M0 + y/k0;                                           //Arc length along standard meridian.
	mu   := M/(a*(1.0 - esq*(1.0/4.0 + esq*(3.0/64.0 + 5.0*esq/256.0))));
	phi1 := mu + e1*(3.0/2.0 - 27.0*e1*e1/32.0)*sin(2*mu) + e1*e1*(21.0/16.0 -55.0*e1*e1/32.0)*sin(4*mu);//Footprint Latitude
	phi1 := phi1 + e1*e1*e1*(sin(6.0*mu)*151.0/96.0 + e1*sin(8.0*mu)*1097.0/512.0);
	C1   := e0sq*  (cos(phi1)*cos(phi1));  // ex Pow 2 in mac
	T1   := tan(phi1)*tan(phi1);   // ex Pow 2
  esiner := e*sin(phi1);
	N1   := a/sqrt(1-esiner*esiner);
	R1   := N1*(1-e*e)/(1-esiner*esiner );
   MMD1k0 := (N1*k0);
   XMMD1k0 := x-500000;
	D    := XMMD1k0 / MMD1k0;
	phi  := (D*D)*(1.0/2.0 - D*D*(5.0 + 3.0*T1 + 10.0*C1 - 4.0*C1*C1 - 9.0*e0sq)/24.0);
	phi  := phi + (D*D*D*D*D*D)*(61.0 + 90.0*T1 + 298.0*C1 + 45.0*T1*T1 -252.0*e0sq - 3.0*C1*C1)/720.0;
	phi  := phi1 - (N1*tan(phi1)/R1)*phi;
		//Longitude
	lng  := D*(1.0 + D*D*((-1.0 -2.0*T1 -C1)/6.0 + D*D*(5.0 - 2.0*C1 + 28.0*T1 - 3.0*C1*C1 +8.0*e0sq + 24.0*T1*T1)/120.0))/cos(phi1);
	lngd := zcm+lng/drad;
	xcord := lngd;
	ycord := phi/drad;
end;



procedure utmtocatasto  (var x1 : Real; var y1 : real);
var angrot , xc, yc: Real;
    locx,locy : real;
begin
	angrot := (1.42/180)*PI; // 0.02959;
		// centro di rotazione civitavecchia piazzola aurelia
	xc := 2307568;	yc := 4776590;
	x1 := x1-xc;            	y1 := y1-yc;
	locx := x1 * cos(angrot) - y1*sin(angrot);
	locy := x1 * sin(angrot) + y1*cos(angrot);
	x1 :=locx+xc;            	y1 :=locy+yc;
	x1 :=x1-(2348220);   	  y1 :=y1-(4775242);
end;

procedure utmtolatlon   (var x1 : Real; var y1 : real);
var  xcord ,ycord : Real;
begin
  UtmToLatlon2 (x1,y1 , xcord ,ycord );
	x1 := xcord;	y1 := ycord;
end;

procedure utmtoGBoaga   (var x1 : Real; var y1 : real);
begin
       x1 := x1+12;    y1 := y1+10;
end;

procedure utmtoutm50    (var x1 : Real; var y1 : real);
begin
	x1 := x1+69;    y1 := y1+192;
end;

procedure utmtolatlon50 (var x1 : Real; var y1 : real);
begin
  utmtolatlon(x1, y1);
  x1 := x1+ 3.3/3600.0; y1 := y1+ 3.6/3600.0;
end;


procedure catastotoutm  (var x1 : Real; var y1 : real);
var angrot , xc, yc: Real;
    locx,locy : real;
    offx,offy : real;
begin
 case ProiezioneCatastale of
  1 : begin  // Magliano Sabina
    angrot := 1.00*pi/180.0+1/1000;
    offx   := 2391822.0;         offy   := 4680867.40;
    x1     := x1+offx;           y1     := y1+offy;
   	xc     := 2312738.0;         yc     := 4693038.0;
    x1     := x1-xc;             y1     := y1-yc;
    locx   := x1*cos(-angrot) - y1*sin(-angrot);
    locy   := x1*sin(-angrot) + y1*cos(-angrot);
    x1     :=locx+xc;            y1     :=locy+yc;
    X1:=X1+2.5;  Y1:=Y1+10;
  end;
  2 :
   begin  // Tolfa
    angrot := 0.02959;
    offx   := 2309451.4;         offy   := 4646172.0;
    x1     := x1+offx;           y1     := y1+offy;
   	xc     := 2254082.0;         yc     := 4670053.0;
    x1     := x1-xc;             y1     := y1-yc;
    locx   := x1*cos(-angrot) - y1*sin(-angrot);
    locy   := x1*sin(-angrot) + y1*cos(-angrot);
    x1     :=locx+xc;            y1     :=locy+yc;
    X1:=X1+5.8;  Y1:=Y1-9.2;
  end;
 end;

end;





procedure latlonToUtm   (var x1 : Real; var y1 : real);
var  xcord ,ycord : extended;
     a,f,drad : extended;
     k0,b,e,latd : Extended;
     lngd,phi : Extended;
     utmz,zcm,esq,e0sq : Extended;
     M,M0,N,T,C,AA : Extended;
     x,y : Extended;
begin

		//Convert Latitude and Longitude to UTM
	a := 6378137.0;//equatorial radius, meters.
	f := 1.0/298.2572236;//polar flattening.
	drad := PI/180.0;//Convert degrees to radians)
	k0 := 0.9996;//scale on central meridian
	b  := a*(1-f);//polar axis.
	e  := sqrt(1 - (b/a)*(b/a));//eccentricity
  latd := y1;
	lngd := x1;
	phi := latd*drad;//Convert latitude to radians
	utmz := 1.0 + floor((lngd+180.0)/6.0) ;//calculate utm zone
	utmz := 33.0;
	zcm  := 3.0 + 6.0*(utmz-1) - 180.0;//Central meridian of zone
	esq  := (1.0 - (b/a)*(b/a));//e squared for use in expansions
	e0sq := e*e/(1.0-e*e);// e0 squared - always even powers
  N    := a/sqrt(1.0-Power(e*sin(phi),2));
	T    := Power(tan(phi),2);
	C    := e0sq*Power(cos(phi),2);
	AA   := (lngd-zcm)*drad*cos(phi);
	M    := phi*(1.0 - esq*((1.0/4.0) + esq*((3.0/64.0) + ((5.0*esq)/256.0))));
	M    := M - sin(2*phi)*(esq*(3.0/8.0 + esq*(3.0/32.0 + 45.0*esq/1024.0)));
	M    := M + sin(4*phi)*(esq*esq*(15.0/256.0 + esq*45.0/1024.0));
	M    := M - sin(6*phi)*(esq*esq*esq*(35.0/3072.0));
	M    := M*a;//Arc length along standard meridian
	M0   := 0.0;//M0 is M for some origin latitude other than zero. Not needed for standard UTM
	x    := k0*N*AA*(1 + AA*AA*((1.0-T+C)/6.0 + AA*AA*(5.0 - 18.0*T + T*T + 72.0*C -58.0*e0sq)/120.0));//Easting relative to CM
	x    := x+500000;//Easting standard
	y    := k0*(M - M0 + N*tan(phi)*(AA*AA*(1.0/2.0 + AA*AA*((5.0 - T + 9.0*C + 4.0*C*C)/24.0 + AA*AA*(61.0 - 58.0*T + T*T + 600.0*C - 330.0*e0sq)/720.0))));//Northing from equator
  x1   := x+(utmz-31)*1010000.0;
	y1   := y;
end;





procedure GBoagaToUtm   (var x1 : Real; var y1 : real);
begin
	x1 := x1-12;    y1 := y1-10;
end;

procedure latlon50ToUtm (var x1 : Real; var y1 : real);
begin
	x1 := x1 - 3.3/3600.0;
	y1 := y1 - 3.6/3600.0;
	latlonToUtm  (x1,y1);
end;

procedure utm50toutm    (var x1 : Real; var y1 : real);
begin
	x1 := x1-69;    y1 := y1-192;
end;


function ingradi ( valore : Real) : String;
var negativo : Boolean;
	  locvalore : Real;
	  Gradi,  Minuti : Integer;
begin
	negativo  := false;
	locvalore := valore;
	if (locvalore<0) then begin	locvalore :=-locvalore; negativo := true ; end;

	Gradi  := trunc(locvalore);			locvalore := (locvalore - Gradi)*60.0;

	if (locvalore>=60) then begin Gradi := Gradi+1;  locvalore := locvalore-60.0;  end;
	Minuti := trunc(locvalore);		    locvalore := (locvalore -Minuti)*60.0;
	if (locvalore>=59.99) then begin  Minuti := Minuti+1; locvalore :=0.0;	 end;
	if (negativo) then result := '-'+IntToStr(Gradi)+'° '+IntToStr(Minuti)+''' '+FloatToStrF(locvalore, ffNumber, 12, 2)
                else result := '-'+IntToStr(Gradi)+'° '+IntToStr(Minuti)+''' '+FloatToStrF(locvalore, ffNumber, 12, 2);
end;




end.
