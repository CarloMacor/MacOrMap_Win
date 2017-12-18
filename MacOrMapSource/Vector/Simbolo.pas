unit Simbolo;

interface

uses windows,System.classes,vettoriale,GR32, GR32_Image, GR32_Layers,sysutils,DefSimbolo;


type
 TSimbolo = class(TVettoriale)
   X , Y : Real;
   qualeLista  : string;
	 indLista    : Integer;
	 definizione : TDefSimbolo;
   scalaSimb: real;
   angrot   : real;
	 dimfissa : Boolean;
   procedure   Disegna            (HHDC : TImage32);                                                                     override;
   procedure   DisegnaConColori   (HHDC : TImage32; Color32Bordo   : TColor32; Color32Dentro  : TColor32;spess:Integer); override;

   procedure   DisegnaAffineSpo   (DC : hdc ;  dx,dy : Real);          override;
   procedure   DisegnaAffineRot   (DC : hdc ;  xc,yc,rot : Real);      override;
   procedure   DisegnaAffineSca   (DC : hdc ;  xc,yc,sca : Real);      override;


   procedure   InitSimbolo        (x1,y1 : real; _dimfissa : Boolean; _qualeLista : String;
                                   _indLista:Integer; _definizione:TDefSimbolo; _scalaSimb:real; _angrot:real);
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   Procedure   salvavettorialeMacMap (St : TMemoryStream);                           override;
   Procedure   aprivettorialeMacMap  (St : TMemoryStream);                           override;


   procedure   faiLimiti          ;                                         override;

   procedure   seleziona_conPt    (x1,y1 :Real; ListaSelezionati : TList) ; override;
   Function    Match_conPt        (x1,y1 : Real): Boolean;                  override;
   function    Copia              (dx, dy : Real)  : TVettoriale;           override;
   procedure   Sposta             (dx,dy : Real);                           override;
   procedure   Ruota              (xc , yc , ang  : Real);                  override;
   procedure   Ruotaang           (ang : Real);
   procedure   Scala              (xc , yc , scal : Real);                  override;
   procedure   Scalasc            (scal : Real);


 end;

implementation

uses varbase,funzioni , vcl.dialogs, listaDefSimboli,progetto;

constructor TSimbolo.Create;
 begin
   Inherited Create;
   tipo := PSimbolo;
 end;

Destructor  TSimbolo.Done;
 begin
   Inherited Done;
 end;


procedure   TSimbolo.Disegna(HHDC : TImage32);
var x1, y1 : single;
    vet : TVettoriale;
    k : Integer;
begin
 if b_erased then exit;
  for  k:=0 to definizione.Listavector.count-1 do
   begin
      	vet := definizione.Listavector.Items[k];
        vet.DisegnaSpoRotSca(HHDC,definizione.xc,definizione.yc,angrot,scalaSimb, x,y,_piano.Color32Bordo,_piano.Color32Dentro);
   end;

end;

procedure   TSimbolo.DisegnaConColori(HHDC : TImage32; Color32Bordo   : TColor32; Color32Dentro  : TColor32;spess:Integer);
var paralungcar : Real;
    x1,y1 : real;





























    MoveToF (Xinschermo(x1),Yinschermo(y1));
    LineToFS(Xinschermo(x2),Yinschermo(y2));
    LineToFS(Xinschermo(x3),Yinschermo(y3));
    LineToFS(Xinschermo(x4),Yinschermo(y4));
    LineToFS(Xinschermo(x1),Yinschermo(y1));
  end;
 //  disegna(HHDC);
end;


procedure   TSimbolo.DisegnaAffineSpo   (DC : hdc ;  dx,dy : Real);
var paralungcar : Real;
    x1,y1 : real;





































procedure   TSimbolo.DisegnaAffineRot   (DC : hdc ;  xc,yc,rot : Real);
var
    x1,y1 : real;



































var
    x1,y1 : real;



































procedure   TSimbolo.InitSimbolo        (x1,y1 : real; _dimfissa : Boolean; _qualeLista : String;
                                _indLista:Integer; _definizione:TDefSimbolo; _scalaSimb:real; _angrot:real);
begin
  X := x1;             Y := y1;
  qualeLista  :=_qualeLista;
  indLista    := _indLista;
  definizione :=_definizione;
  scalaSimb   :=_scalaSimb;
  angrot      :=_angrot;
  dimfissa    :=_dimfissa;
end;


procedure   TSimbolo.faiLimiti          ;
begin
  	limx1 := x+definizione.limx1*scalaSimb ;	limx2 := x+definizione.limx2*scalaSimb ;
    limy1 := y+definizione.limy1*scalaSimb ;	limy2 := y+definizione.limy2*scalaSimb ;
end;


procedure   TSimbolo.seleziona_conPt    (x1,y1 :Real; ListaSelezionati : TList) ;
 var dd,off : Real;
   locx1,locy1 : real;
begin
  off  :=  give_offsetmirino ;
  Rotoscalacentra (x, y , -angrot, 1.0, x1,y1,  locx1, locy1  );
  if ( (locx1>(limx1-off)) and  (locx1<(limx2+off)) and  (y1>(limy1-off)) and  (y1<(limy2+off)) ) then  begin ListaSelezionati.Add(self); end;
end;

Function    TSimbolo.Match_conPt        (x1,y1 : Real): Boolean;
 var dd,off : Real;
     resulta : Boolean;

begin
 resulta := false;
  off  :=  give_offsetmirino ;
  Rotoscalacentra (x, y , -angrot, 1.0, x1,y1,  locx1, locy1  );
  if ( (locx1>(limx1-off)) and  (locx1<(limx2+off)) and  (y1>(limy1-off)) and  (y1<(limy2+off)) ) then  begin resulta:=true; end;
  result := resulta;
end;

function    TSimbolo.Copia              (dx, dy : Real)  : TVettoriale;
var newsymb : TSimbolo;
begin
  	newsymb := TSimbolo.Create;
  	newsymb.initer(_disegno,_piano);
    newsymb.InitSimbolo        (x,y,dimfissa,qualeLista,indLista , definizione, scalaSimb, angrot);
  	_piano.Listavector.Add(newsymb);
  	newsymb.Sposta(dx,dy);
  	newsymb.faiLimiti;
 	result:=newsymb;
end;

procedure   TSimbolo.Sposta             (dx,dy : Real);
begin
   x :=x+dx;	 y :=y+dy;
end;

procedure   TSimbolo.Ruota              (xc , yc , ang  : Real);
begin
  Sposta(-xc,-yc);	Ruotaang(ang);	Sposta(xc,yc);  angrot:=angrot+ang;
end;

procedure   TSimbolo.Ruotaang           (ang : Real);
var  locx,locy : Real;
begin
	locx := x*cos(ang) - y*sin(ang);        	locy := x*sin(ang) + y*cos(ang);
	x :=locx;	y :=locy;
end;

procedure   TSimbolo.Scala              (xc , yc , scal : Real);
begin
 Sposta(-xc,-yc);	Scalasc(scal);	Sposta(xc,yc);
end;

procedure   TSimbolo.Scalasc            (scal : Real);
begin
  scalaSimb:=scal*8;
	x:=x*scal;	y:=y*scal;
end;


Procedure   TSimbolo.salvavettorialeMacMap (St : TMemoryStream);
var ll,k : Integer;



 	st.Write(x, sizeof(x));
	st.Write(y, sizeof(y));
	st.Write(indLista, sizeof(indLista));
	st.Write(scalaSimb, sizeof(scalaSimb));
	st.Write(angrot, sizeof(angrot));
	st.Write(dimfissa, sizeof(dimfissa));
  ll := length(qualeLista);
 	st.Write(ll      , sizeof(ll));
  for k:=1 to ll do
   begin cc := qualeLista[k];	st.Write(cc , sizeof(cc)); end;
end;



    cc : char;


 Inherited aprivettorialeMacMap(st);
  qualelista :='';
	st.Read(x, sizeof(x));
	st.Read(y, sizeof(y));
	st.Read(indLista, sizeof(indLista));
	st.Read(scalaSimb, sizeof(scalaSimb));
	st.Read(angrot, sizeof(angrot));
	st.Read(dimfissa, sizeof(dimfissa));
 	st.Read(ll      , sizeof(ll));
  for k:=1 to ll do
   begin st.Read(cc , sizeof(cc));  qualeLista:=qualelista+cc;	end;

  loclistadefsimboli := Ilprogetto.LelisteDefSimboli.items[0];
  definizione :=    loclistadefsimboli.listaDefinizioni[indLista];
end;



end.