unit Funzioni;

interface

uses varbase, sysutils , system.math,vcl.dialogs;

procedure setxysnap(x1,y1 : Real);
function  OrtoInterno(x1,y1,x2,y2,xpt,ypt : Real; var xsn : real; var ysn : real ) : boolean;
function  togliTuttispazi(riga : string ) : string;
function  Xinschermo(x : real) : real;
function  Yinschermo(y : real) : real;
procedure scalacentra     ( xc , yc , scalaatt , scalaprec : real; var xcord :real; var ycord : real);
procedure rotocentra      ( xc , yc , rotatt , rotprec : real;  var xcord : real; var ycord : real  );
procedure Rotoscalacentra ( xc , yc , rot, sca : real; x1,y1 :Real; var xcord : real; var ycord : real );

function  angolo2vertici        (xc, yc, x2, y2: real) : real;
function  scala2verticischermo  (xc, yc, x2, y2, dimscr: real) : real;
function  distsemplicefunz      (x1, y1, x2, y2: real) : real;
function  distasegfunz          (x1, y1, x2, y2, xp, yp : real) : real;
function  xgriglia              (x1, y1, x2, y2, yy: real) : real;
function  ygriglia              (x1, y1, x2, y2, xx : real   ) : real;
function  intersezione          (x1, y1, x2, y2, x3, y3, x4, y4: real; var xcord: real; var ycord: real)  : Integer;
function  letteraKool           (ind: Integer) : String;

function  StrGradidaCoord ( coord : real): String;

procedure SpezzastringaCancelletto(riga : String;var riga1 : String;var riga2 : String);
procedure SpezzaStringaDotcoma(riga : String;var riga1 : String;var riga2 : String);
function  QualitaTerrenodaCod (codice : String) : String;
procedure SpezzastringaBarra(riga : String;var riga1 : String;var riga2 : String);
function  Toglizeroiniziali(riga : String): String;

function  DescrizionePossessoCod (codice : String) : String;
procedure SpezzaCognomenome(riga : String;var riga1 : String;var riga2 : String);

function  interpretaTopoCatastale (codice : String) : String;
function  togliletteredanumeroStr(param : String) : String;

function  mettiundercoreaSpazi(param : String) : String;

function  prendiNumFinDisegno(param : String) : String;


implementation

procedure SpezzastringaCancelletto(riga : String; var riga1 : String;var riga2 : String);
var k : Integer;
    r1,r2 : String;
    parte1 : Boolean;
begin
 r1:='';  r2:=''; parte1 := true;
 if length(riga)>0 then
  begin
   if riga[1]='#' then
    begin
     for k:=2 to length(riga) do
      begin
       if riga[k]='#' then parte1:=false;
       if parte1 then r1:=r1+riga[k] else r2:=r2+riga[k];
      end;
    end;
  end;
 riga1 := r1;
 riga2 := r2;
end;

function  togliletteredanumeroStr(param : String) : String;
var k : Integer;
    r1,r2 : String;
    parte1 : Boolean;
    cc : String;
    valo,coda : Integer;
begin
 r1 := '';
 for k:=1 to length(param) do
  begin
   cc := param[k];
   val(cc,valo,coda);
   if coda<>0 then continue;
   r1:=r1+cc;
  end;
 result := r1;
end;

procedure SpezzastringaBarra(riga : String;var riga1 : String;var riga2 : String);
var k : Integer;
    r1,r2 : String;
    parte1 : Boolean;
begin
 r1:='';  r2:=''; parte1 := true;
 for k:=1 to length(riga) do
   begin
     if ((riga[k]='|') and parte1) then begin parte1:=false; continue; end;
     if parte1 then r1:=r1+riga[k] else r2:=r2+riga[k];
   end;
 riga1 := r1;
 riga2 := r2;
end;


procedure SpezzaStringaDotcoma(riga : String;var riga1 : String;var riga2 : String);
var k : Integer;
    r1,r2 : String;
    parte1 : Boolean;
begin
 r1:='';  r2:=''; parte1 := true;
 for k:=1 to length(riga) do
   begin
     if ((riga[k]=';') and parte1) then begin parte1:=false; continue; end;
     if parte1 then r1:=r1+riga[k] else r2:=r2+riga[k];
   end;
 riga1 := r1;
 riga2 := r2;
end;


function  Toglizeroiniziali(riga : String): String;
var resulta : String;
    parte1 : Boolean;
    k : integer;
begin
 parte1 := true; resulta :='';
 for k := 1 to length(riga) do
  begin
   if riga[k]<>'0' then parte1:=false;
   if ((riga[k]='0') and parte1) then continue;
   resulta := resulta+ riga[k];
  end;
 result := resulta;
end;


procedure setxysnap(x1,y1 : Real);
begin
 xsnap := x1;
 ysnap := y1;
end;




function  OrtoInterno(x1,y1,x2,y2,xpt,ypt : Real; var xsn : real; var ysn : real ) : boolean;
var deno1,xf,yf,xb2,yb2,xj,yj,xj2,yj2,yj3 : Real;
    angolo,	xsnaploc, ysnaploc    : Real;
    orto  : Boolean;
begin
 orto := false;
 xf := x2-x1;  yf := y2-y1;
  if (xf=0)	then begin  if ( ((ypt>y1) and (ypt<y2)) or ((ypt>y2) and (ypt<y1)) ) then orto:=true; 	end;
	if (yf=0) then begin  if ( ((xpt>x1) and (xpt<x2)) or ((xpt>x2) and (xpt<x1)) ) then orto:=true; 	end;

	if ((xf<>0) and (yf<>0)) then
   begin
 	 angolo := arctan2(yf,xf);
	 xj  := sin(angolo)*xf;
	 xb2 := xpt+xj;
	 yj  := cos(angolo)*xf;
	 yb2 := ypt-yj;
	 yj2 := ypt-yb2;
	 yj3 := yf*yj2;
	 xj2 := xb2-xpt;
	 deno1 := -(xf*yj2+xj2*yf);
	 if (deno1<>0) then
     begin
       ysnaploc := ( ((x1*yj3)-(xpt*yj3)-(y1*xf*yj2)-(ypt*xj2*yf)) / deno1);
	     xsnaploc := ((((ysnaploc-y1)*(x2-x1)) / yf)+x1);
     end;
   end
    else
   begin
		if (xf=0) then begin xsnaploc:=x1; ysnaploc:=ypt; end;
		if (yf=0) then begin ysnaploc:=y1; xsnaploc:=xpt; end;
	 end;

	if ( ( ((xsnaploc>=x1) and (xsnaploc<=x2)) or ((xsnaploc<=x1) and (xsnaploc>=x2)) )	and
		 ( ((ysnaploc>=y1) and (ysnaploc<=y2)) or ((ysnaploc<=y1) and (ysnaploc>=y2)) ) ) then
	begin  orto:=true;  end;

 xsn := xsnaploc; ysn := ysnaploc;
 result := orto;
end;

procedure SpezzaCognomenome(riga : String;var riga1 : String;var riga2 : String);
var k : Integer;
    spaziato : Boolean;
    r1,r2 : String;
begin
  r1:='';  r2:='';
 spaziato := false;
  for k:=1 to length(riga) do
   begin
    if riga[k]=' ' then
     begin
      if not(spaziato) then if k>4 then begin  spaziato := true; continue; end;
     end;
     if spaziato then r2 := r2+riga[k] else r1 := r1+riga[k];
   end;
 riga1 := r1;
 riga2 := r2;
end;




function  togliTuttispazi(riga : string ) : string;
begin
 result := StringReplace(riga, ' ', '', [rfReplaceAll, rfIgnoreCase]);
end;

function  Xinschermo(x : real) : real;
begin
	result :=(x-xorigineVista)/scalaVista;
end;

function  Yinschermo(y : real) : real;
begin
	result :=Hschermo-((y-yorigineVista)/scalaVista);
end;


procedure scalacentra ( xc , yc , scalaatt , scalaprec : real; var xcord :real; var ycord : real);
var 	newx , newy  : real;
    	scal         : real;
	    newx1, newy1 : Real;
begin
	newx  := xcord;	newy := ycord;
	scal  := scalaatt / scalaprec;
	newx  := newx-xc;	newy := newy-yc;
	newx1 := newx*scal;
	newy1 := newy*scal;
	newx  := newx1+xc;		newy := newy1+yc;
	xcord := newx;		    ycord := newy;
end;


procedure rotocentra    ( xc , yc , rotatt , rotprec : real;  var xcord : real; var ycord : real  );
var 	newx , newy  : real;    	scal,rot : real;	    newx1, newy1 : Real;   rotRad : real;
begin
	newx := xcord;	newy := ycord;
	rot  := (rotatt-rotprec);
	newx := newx-xc;		newy := newy-yc;
	newx1 := newx*cos(rot)-newy*sin(rot);
	newy1 := newx*sin(rot)+newy*cos(rot);
	newx := newx1+xc;		newy := newy1+yc;
	xcord := newx;		  ycord := newy;
end;


procedure Rotoscalacentra ( xc , yc , rot, sca : real; x1,y1 :Real; var xcord : real; var ycord : real );
var 	newx , newy  : real;    	 newx1, newy1 : Real;
begin
	newx := x1;	newy := y1;
	newx := newx-xc;		newy := newy-yc;
	newx1 := newx*cos(rot)-newy*sin(rot);
	newy1 := newx*sin(rot)+newy*cos(rot);
	newx1 := newx1*sca;
	newy1 := newy1*sca;
	newx := newx1+xc;		newy := newy1+yc;
	xcord := newx;		  ycord := newy;
end;



function  angolo2vertici        (xc, yc, x2, y2: real) : real;
var risulta : real;
	  dx,dy   : real;
begin
	risulta:=0.0;
	dx := x2-xc;	                  dy := y2-yc;
	 if ((dx=0)  and (dy=0)) then risulta:=0
	  else
   begin
 	  if (dx=0) then begin risulta := PI/2;  if (dy <0) then risulta := PI*3/2;  end
	   else
    begin
      risulta := arctan( dy / dx );
      if (dx <0)     then risulta := PI+risulta;
      if (risulta<0) then risulta := risulta+2*PI;
    end;
   end;
 result := risulta;
end;

function  scala2verticischermo  (xc, yc, x2, y2, dimscr: real) : real;
var dx,dy, risulta : Real;
begin
	risulta := 1.0;
	dx := x2-xc;	dy := y2-yc;
	if ((dx=0) and (dy=0)) then risulta := 1.0 else
	  risulta := hypot( dx, dy )/(dimscr/40);
 result :=0.0;
end;


function  distsemplicefunz      (x1, y1, x2, y2: real) : real;
begin
 result := hypot( (x2-x1), (y2-y1) );
end;

function  distasegfunz          (x1, y1, x2, y2, xp, yp : real) : real;
var	ll, ll2 , a, b, c, deno: real;
begin
	x2 := x2-x1;  	y2 := y2-y1;
	xp := xp-x1;  	yp := yp-y1;
	x1 := 0;        y1 := 0;
	a  := y2-y1;     b := x1-x2;   c := x2*y1-x1*y2;

	if	((a=0)	and (b=0)) then begin	ll := distsemplicefunz(x1 ,y1 ,xp ,yp) ;	result:=ll; exit; end;
  if (a=0)	then begin ll := abs(yp-y2); result:=ll; exit; end;
	if (b=0)	then begin ll := abs(xp-x2); result:=ll; exit; end;

	deno := sqrt(a*a+b*b);
	if (deno>0.001) then ll := abs(a*xp+b*yp+c)/deno
	else begin
		ll  :=  distsemplicefunz(x2,y2,xp,yp);
		ll2 :=  distsemplicefunz(x1,y1,xp,yp);
		if (ll>ll2) then ll := ll2;
  end;
	if ( distsemplicefunz(x1,y1,xp,yp)<ll) then ll := distsemplicefunz(x1,y1,xp,yp);
 result := ll;
end;

function  xgriglia              (x1, y1, x2, y2, yy: real) : real;
begin
 result := x1+((x2-x1)/(y2-y1))*(yy-y1);
end;

function  ygriglia              (x1, y1, x2, y2, xx : real   ) : real;
begin
 result := y1+((y2-y1)/(x2-x1))*(xx-x1);
end;

function  intersezione          (x1, y1, x2, y2, x3, y3, x4, y4: real; var xcord: real; var ycord: real)  : Integer;
var risulta : Integer;
    a1,b1,c1,a2,b2,c2 : Real;
    x,y,DD,Dx,Dy : Real;
begin
   risulta :=0;
	 a1 := y2-y1;    b1 := x1-x2;    c1 := x2*y1-x1*y2;
   a2 := y4-y3;    b2 := x3-x4;    c2 := x4*y3-x3*y4;
	 DD := a1*b2-a2*b1;
	if (DD=0) then begin result :=0; exit; end; // le due rette sono parallele.
	 Dx := c2*b1-c1*b2;
	 Dy := c1*a2-c2*a1;

 	x := Dx/DD; y := Dy/DD;
	// vediamo se e' interno
	if (( ((x>x1) and (x<x2)) or ((x>x2) and (x<x1)) )   and   ( ((y>y1) and (y<y2)) or ((y>y2) and (y<y1)) ) ) then
   begin
		if (( ((x>x3) and (x<x4)) or ((x>x4) and (x<x3)) )   and   ( ((y>y3) and (y<y4)) or ((y>y4) and (y<y3)) ) ) then
			risulta := 1;
			xcord := x;	ycord := y; // fisso la intersezione
   end;
 result :=risulta;
end;


function  letteraKool           (ind: Integer) : String;
var resulta : String;
begin
 resulta :='';
 case ind of
       0 : resulta  := 'a';
       1 : resulta  := 'b';
       2 : resulta  := 'c';
       3 : resulta  := 'd';
       4 : resulta  := 'e';
       5 : resulta  := 'f';
       6 : resulta  := 'g';
       7 : resulta  := 'h';
 end;


 result := resulta;
end;


function  StrGradidaCoord ( coord : real): String;
var gr, min : Integer; sec : Real;
 coord2 : Real;
begin
 gr := trunc(coord);
 coord2 := coord-gr;
 coord2 := coord2*60;
 min := trunc(coord2);
 coord2 := coord2-min;
 sec := round(coord2*60*100);
 sec := sec / 100;
 result := IntTostr(gr)+'° '+inttostr(min)+''' '+floatTostr(sec)+'"';
end;

function  QualitaTerrenodaCod (codice : String) : String;
var resulta : String;
    intcod : Integer;
begin
 resulta := '';
  intcod := StrToInt(codice);
  case  intcod of
    1  : resulta:='seminativo';
    2  : resulta:='semin irrig';
    3  : resulta:='semin arbor';
    4  : resulta:='sem arbor irr';
    5  : resulta:='sem irr arbor';
    6  : resulta:='sem pez fos';
    7  : resulta:='sem arbor p f';
    8  : resulta:='prato';
    9  : resulta:='prato irrig';
   10  : resulta:='prato arbor';
   11  : resulta:='prato ir ar';
   12  : resulta:='prato marc';
   13  : resulta:='prato mar ar';
   14  : resulta:='marcita';
   15  : resulta:='risaia';
   16  : resulta:='risaia stab';
   17  : resulta:='orto';
   18  : resulta:='orto irrig';
   19  : resulta:='orto arbor';
   20  : resulta:='orto ar irr';
   21  : resulta:='orto frut';
   22  : resulta:='orto pex fos';
   23  : resulta:='orto fiori';
   24  : resulta:='orto ir fi';
   25  : resulta:='orto viv flo';
   26  : resulta:='vivaio';
   27  : resulta:='viv orn fl';
   28  : resulta:='giardini';
   29  : resulta:='vigneto';
   30  : resulta:='vigneto arb';
   31  : resulta:='vigneto irr';
   32  : resulta:='vig uva tav';
   33  : resulta:='vign frutt';
   34  : resulta:='vign uliv';
   35  : resulta:='vign mandor';
   36  : resulta:='uliveto';
   37  : resulta:='uliv agrum';
   38  : resulta:='uliv fichet';
   39  : resulta:='ul fich man';
   40  : resulta:='uliv frass';

   41  : resulta:='uliv frut';
   42  : resulta:='uliv sommac';
   43  : resulta:='uliv vignet';
   44  : resulta:='uliv sugher';
   45  : resulta:='uliv mandor';
   46  : resulta:='ul man pist ';
   47  : resulta:='frutteto';

   55  : resulta:='canneto';
   59  : resulta:='cast frutto';


   90  : resulta:='sughereto';
   91  : resulta:='pascolo';
   92  : resulta:='pasc arb';
   93  : resulta:='pasc cespug';
   94  : resulta:='pascolo bcg';
   95  : resulta:='pascolo bm';
   96  : resulta:='pascolo ba';
   97  : resulta:='bosco ceduo';
   98  : resulta:='bosco misto';
   99  : resulta:='bosco alto';

  101  : resulta:='incolt prod';
  138  : resulta:='boschi';

  150  : resulta:='incolt ster';
  151  : resulta:='lago pubbl';
  152  : resulta:='laguna';

  180  : resulta:='cava';

  202  : resulta:='autovia sp';
  203  : resulta:='area dem pp';
  204  : resulta:='banchina';
  205  : resulta:='cimitero';
  206  : resulta:='ferrovia sp';
  207  : resulta:='fortificaz';

  271  : resulta:='area fab dm';
  272  : resulta:='area promis';
  273  : resulta:='area rurale';
  274  : resulta:='area urbana';
  275  : resulta:='corte urban';
  276  : resulta:='costr no ab';
  277  : resulta:='fa div sub';
  278  : resulta:='fabb promis';
  279  : resulta:='fab rurale';
  280  : resulta:='fabb diruto';
  281  : resulta:='fr div sub';
  282  : resulta:='ente urbano';

  283  : resulta:='fu d accert';
  284  : resulta:='prz acc fr';
  285  : resulta:='prz acc fu';
  286  : resulta:='porz di fa';

  287  : resulta:='prz di fr';
  288  : resulta:='porz rur fb';
  290  : resulta:='prz di fu';
  300  : resulta:='acque esent';
  301  : resulta:='piazza pubb';
  302  : resulta:='strade pubb';

  350  : resulta:='accesso';
  351  : resulta:='accessorio';
  352  : resulta:='aia';
  353  : resulta:='andito';

  354  : resulta:='androne';
  355  : resulta:='area';

  373  : resulta:='corte';

  376  : resulta:='forno';
  377  : resulta:='frantoio';


  395  : resulta:='passaggio';

  401  : resulta:='porcile';
  402  : resulta:='portico';
  403  : resulta:='portineria';
  404  : resulta:='portone';
  405  : resulta:='pozzo';
  410  : resulta:='scala';

  420  : resulta:='strada priv';
  421  : resulta:='terrazzo';
  422  : resulta:='tettoia';

  453  : resulta:='rel acq es';
  454  : resulta:='relit stad';

  504  : resulta:='incolto';
  505  : resulta:='improdutt';
  506  : resulta:='sentiero';
  507  : resulta:='ponte';
  508  : resulta:='cavalcavia';
  509  : resulta:='casa stalla';
  510  : resulta:='chiesa';

  513  : resulta:='magazzino';
  514  : resulta:='fosso';

  993  : resulta:='modello 26';
  998  : resulta:='soppresso';

  end;

  

 result := resulta;
end;


function  DescrizionePossessoCod (codice : String) : String;
var resulta : String;
begin
 resulta :='';

 if codice = '0' then resulta := 'Assenza di Titolo';
 if codice = '0 ' then resulta := 'Assenza di Titolo';
 if codice = '3 ' then resulta := 'Comproprietario';
 if codice = '4 ' then resulta := 'Comproprietario per';
 if codice = '1s' then resulta := 'proprietà superficiaria';
 if codice = '1t' then resulta := 'proprietà per l''area';
 if codice = '2s' then resulta := 'Nuda proprietà superficiaria';
 if codice = '3s' then resulta := 'Abitazione su proprietà superficiaria';
 if codice = '8a' then resulta := 'Usufrutto con diritto di accrescimento';
 if codice = '8s' then resulta := 'Usufrutto su proprietà superficiaria';

 if (codice = '7 ')  then resulta  := 'comproprietario del fabbricato';
 if (codice = '7s')  then resulta  := 'Uso proprietà superficiaria';
 if (codice = '8 ')  then resulta  := 'comproprietario per l''area';
 if (codice = '8e')  then resulta  := 'usufrutto su enfideusi';
 if (codice = '52 ') then resulta  := 'usuario perpetuo';


 if codice = '10' then resulta := 'Proprietà';
 if codice = '12 ' then resulta := 'Concedente in parte';
 if codice = '15 ' then resulta := 'Usufruttuario parziale per';
 if codice = '20' then resulta := 'Nuda Proprietà';
 if codice = '20 ' then resulta := 'Livellario';
 if codice = '21 ' then resulta := 'Livellario per';
 if codice = '22 ' then resulta := 'Livellario in parte';
 if codice = '30' then resulta := 'Abitazione';
 if codice = '30 ' then resulta := 'Usufruttuario Parziale';
 if codice = '33 ' then resulta := 'Cousufruttuario generale';
 if codice = '37 ' then resulta := 'Usufruttuario parziale di livello';
 if codice = '39 ' then resulta := 'Usufruttuario parziale di enfiteusi';
 if codice = '40' then resulta := 'Diritto del Concedente';
 if codice = '50' then resulta := 'Enfiteusi';
 if codice = '50 ' then resulta := 'Cousufruttuiario per';
 if codice = '60' then resulta := 'Superficie';
 if codice = '70' then resulta := 'Uso';
 if codice = '80' then resulta := 'Usufrutto';
 if codice = '99 ' then resulta := 'Usufrutto';
 if codice = '99 ' then resulta := 'Non Codificato';
 if codice = '100' then resulta := 'Oneri';
 if codice = '990' then resulta := 'Non Codificato';
 if codice = '991' then resulta := 'Non Codificato';

 result := resulta;

end;


function  interpretaTopoCatastale (codice : String) : String;
var resulta : String;
begin
 resulta := codice;

 if codice ='0'   then resulta :='';
 if codice ='130' then resulta :='PIAZZA';

 if codice ='236' then resulta :='VIA';
 if codice ='248' then resulta :='VIA';

 if codice ='238' then resulta :='VIADOTTO';
 if codice ='240' then resulta :='VIALE';
 if codice ='248' then resulta :='VICOLO';

 if codice ='699' then resulta :='VOCABOLO';
 if codice ='86' then resulta :='VOCABOLO';

 result := resulta;
end;


function  mettiundercoreaSpazi(param : String) : String;
var resulta : String;
    k : Integer;
    carro : String;
begin
 resulta := '';
 for k:=1 to length(param) do
  begin
   carro := param[k];
   if carro=' ' then resulta:=resulta+'_' else resulta:=resulta+carro;
  end;
 result := resulta;
end;

function  prendiNumFinDisegno(param : String) : String;
var resulta : String;
    base : String;
    k : Integer;
    carro : String;
    deter : Boolean;
begin
 resulta :='';
 deter := false;
 base := extractFilename(param);
 base := ChangeFileExt(base, '');
 for k:=1 to length(base) do
  begin
   carro := base[k];
   if ((deter) and (carro='#')) then begin break; end;
   if carro='#' then begin deter:= true; continue; end;
   if deter then resulta := resulta+carro;
  end;

 result := resulta;
end;


end.
