unit Vettoriale;

interface

uses windows, System.classes, varbase, piano ,GR32, GR32_Image, GR32_Layers, DisegnoV,Vertice
;

//vettoriale,GR32, GR32_Image, GR32_Layers, vertice, sysutils,FMX.Dialogs;

type
 TVettoriale = class
   tipo      : Tipovector;  //  Tipovector = (NNulla, PPunto, PPlinea, PPoligono, RRegione, CCerchio, TTesto, SSimbolo, AArco);
 	 limx1, limx2, limy1, limy2 : Real;
   b_erased, b_selected   : Boolean;
   _disegno               : TDisegnoV;
	 _piano                 : TPiano;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   initer(dis : TDisegnoV; pian : TPiano);
   procedure   Disegna(HHDC : TImage32);                 virtual;
   procedure   DisegnaSelected              (HHDC : TImage32);                                          virtual;
   procedure   DisegnaConColori(HHDC : TImage32; Color32Bordo   : TColor32; Color32Dentro  : TColor32;spess:Integer); virtual;
   procedure   DisegnaAffineSpo     (DC : hdc ;  xc,yc : real);          virtual;
   procedure   DisegnaAffineRot     (DC : hdc ;   xc,yc,rot : real);      virtual;
   procedure   DisegnaAffineSca     (DC : hdc ;  xc,yc,sca : real);      virtual;
   procedure   DisegnaSpoRotSca     (HHDC : TImage32; xc,yc,rot,sca : real;xp,yp : real;ColBordo,ColDentro : Tcolor32);  virtual;
   procedure   disegnadef           (HHDC : TImage32; Xlim,Ylim,sca: Real);     virtual;
   procedure   faiLimiti;                                                       virtual;
   Function    inSchermo: Boolean;                                              virtual;
   function    cancellato : Boolean;
   function    testinternoschermo : Boolean;
   procedure   DisegnaVtTutti       (HHDC : TImage32);                          virtual;
   procedure   DisegnaVtFinali      (HHDC : TImage32);                          virtual;

   function    SnapFine             (x1,y1 : Real) : Boolean;                   virtual;
   function    SnapVicino           (x1,y1 : Real) : Boolean;                   virtual;

   procedure   Sposta               (x1,y1 : Real);                             virtual;
   function    Copia                (x1,y1 : Real): TVettoriale;                virtual;
   procedure   Ruota                (x1,y1,ang : Real);                         virtual;
   procedure   Ruotaang             (ang : Real);                               virtual;
   procedure   Scala                (x1,y1,scal : Real);                        virtual;
   procedure   Scalasc              (scal : Real);                              virtual;

   procedure   seleziona_conPt              (x1,y1 : real; _LSelezionati : Tlist);    virtual;
   procedure   seleziona_conPtInterno       (x1,y1 : real; _LSelezionati : Tlist);                     virtual;
   function    Match_conPt                  (x1,y1 : Real): Boolean;                                   virtual;
   function    selezionaVtconPt             (x1,y1 : real; _LSelezionati : Tlist):boolean;    virtual;
   procedure   SpostaVerticeSelezionato     (_LSelezionati : Tlist; newx,newy : real);                 virtual;
   procedure   InserisciVerticeSelezionato  (_LSelezionati : Tlist; newx,newy : Real);                 virtual;
   procedure   CancellaVerticeSelezionato   (_LSelezionati : Tlist);                                   virtual;
   procedure   EditVerticeSelezionato       (_LSelezionati : Tlist; newx,newy : Real);                 virtual;

  // -----------
   function    SnapCat              (x1,y1 : Real)                                      : Integer;
   function    ptInterno            (x1,y1 : Real)                                      : Boolean;     virtual;
   function    verticeN             (ind   : Integer)                                   : TVertice;
   function    addCatVertici        (x1,y1 : Real;  objvect : TVettoriale)              : Boolean;
   Procedure   CopiainLista         (inlista : TList);
   Procedure   cancella;
   Procedure   Decancella;
   function    dimmitipo                                                                : Integer;
   function    dimmitipostr                                                             : String;
   function    lunghezza                                                                : Real;
   function    superficie                                                               : Real;
   function    lunghezzastr                                                             : String;
   function    pianostr                                                                 : String;
   function    disegnostr                                                               : String;
   function    nvtstr                                                                   : String;
   function    supstr                                                                   : String;
   Procedure   chiudiSeChiusa ;                                                                        virtual;
   Procedure   Cambia1PoligonoaRegione;
   Procedure   salvavettorialeMacMap   (St : TMemoryStream);                                           virtual;
   Procedure   aprivettorialeMacMap    (St : TMemoryStream);                                           virtual;
   function    numvt                                                                    : Integer;
   Procedure   CatToUtm;
   Procedure   TestoAltoQU;
//   Procedure   salvadxf;
   Procedure   svuota;
   function    copiaPura                                                               : TVettoriale;  virtual;
   function    copiaPuraNoaDisegno                                                     : TVettoriale;
   Function    caratteritesto                                                          : String;
   Function    altezzatesto                                                            : Real;






  end;


 var ilVettoriale : TVettoriale;

implementation



Constructor TVettoriale.Create;
begin
  tipo := NNulla;
 	 limx1:=0.0; limx2:=0.0; limy1:=0.0; limy2:=0.0;
   b_erased     := false;
   b_selected   := false;
	 _piano       := nil;
end;

Destructor  TVettoriale.Done;
begin
end;

procedure   TVettoriale.faiLimiti;
begin
end;

Function    TVettoriale.inSchermo: Boolean;
begin
 result := true;
end;

function    TVettoriale.cancellato : Boolean;
begin
  result:= b_erased;
end;


procedure   TVettoriale.initer(dis : TDisegnoV; pian : TPiano);
begin
   _disegno := dis;
	 _piano   := pian;
end;

procedure   TVettoriale.Disegna(HHDC : TImage32);
begin
end;

procedure   TVettoriale.DisegnaAffineSpo     (DC : hdc ;  xc,yc : real);
begin
end;

procedure   TVettoriale.DisegnaAffineRot     (DC : hdc ;  xc,yc,rot : real);
begin
end;

procedure   TVettoriale.DisegnaAffineSca     (DC : hdc ;  xc,yc,sca : real);
begin
end;

procedure   TVettoriale.DisegnaSpoRotSca     (HHDC : TImage32;  xc,yc,rot,sca : real;xp,yp : real;ColBordo,ColDentro : Tcolor32);
begin
end;

procedure   TVettoriale.disegnadef           (HHDC : TImage32; Xlim,Ylim,sca: Real);
begin

end;




function    TVettoriale.testinternoschermo : Boolean;
var locres : Boolean;
begin
	locres := True;
	if (limx2<xOrigineVista)  then locres := false;
	if (limx1>x2OrigineVista) then locres := false;
	if (limy1>y2OrigineVista) then locres := false;
	if (limy2<yOrigineVista)  then locres := false;

	result := locres;
end;

procedure   TVettoriale.DisegnaVtTutti       (HHDC : TImage32);
begin
end;


procedure   TVettoriale.DisegnaVtFinali      (HHDC : TImage32);
begin
end;


function    TVettoriale.SnapFine             (x1,y1 : Real): Boolean;
begin
 result := false;
end;

function    TVettoriale.SnapVicino           (x1,y1 : Real): Boolean;
begin
 result := false;
end;



procedure   TVettoriale.Sposta               (x1,y1 : Real);
begin

end;

function    TVettoriale.Copia                (x1,y1 : Real): TVettoriale;
begin
 result := nil;
end;


procedure   TVettoriale.Ruota                (x1,y1,ang : Real);
begin

end;

procedure   TVettoriale.Ruotaang             (ang : Real);
begin

end;

procedure   TVettoriale.Scala                (x1,y1,scal : Real);
begin

end;

procedure   TVettoriale.Scalasc              (scal : Real);
begin

end;

procedure   TVettoriale.seleziona_conPt              (x1,y1 : real; _LSelezionati : Tlist);
begin

end;

procedure   TVettoriale.seleziona_conPtInterno       (x1,y1 : real; _LSelezionati : Tlist);
begin
end;

function   TVettoriale.Match_conPt                  (x1,y1 : Real): boolean;
begin
 result:=false;
end;

function   TVettoriale.selezionaVtconPt             (x1,y1 : real; _LSelezionati : Tlist): boolean;
begin

end;

procedure   TVettoriale.SpostaVerticeSelezionato     (_LSelezionati : Tlist; newx,newy : real);
begin

end;

procedure   TVettoriale.InserisciVerticeSelezionato  (_LSelezionati : Tlist; newx,newy : Real);
begin

end;

procedure   TVettoriale.CancellaVerticeSelezionato   (_LSelezionati : Tlist);
begin

end;

procedure   TVettoriale.EditVerticeSelezionato       (_LSelezionati : Tlist; newx,newy : Real);
begin

end;


procedure   TVettoriale.DisegnaSelected  (HHDC : TImage32);
begin

end;

procedure   TVettoriale.DisegnaConColori(HHDC : TImage32; Color32Bordo   : TColor32; Color32Dentro  : TColor32;spess:Integer);
begin

end;



  // -----------
function    TVettoriale.SnapCat              (x1,y1 : Real): Integer;
begin
     result :=-1;
end;

function    TVettoriale.ptInterno            (x1,y1 : Real): Boolean;
begin
  result := false;
end;

function    TVettoriale.verticeN             (ind   : Integer): TVertice;
begin
  result := nil;
end;

function    TVettoriale.addCatVertici        (x1,y1 : Real;  objvect : TVettoriale)            : Boolean;
begin
  result := false;
end;

Procedure   TVettoriale.CopiainLista         (inlista : TList);
begin

end;

Procedure   TVettoriale.cancella;
begin
 b_erased := true;
end;

Procedure   TVettoriale.Decancella;
begin

end;


function    TVettoriale.dimmitipo                                                               : Integer;
begin
  result := 0;
end;

function    TVettoriale.dimmitipostr                                                            : String;
begin
  result := '';
end;

function    TVettoriale.lunghezza                                                               : Real;
begin
  result := 0.0;
end;

function    TVettoriale.superficie                                                              : Real;
begin
  result := 0.0;
end;

function    TVettoriale.lunghezzastr                                                            : String;
begin
  result := '';
end;

function    TVettoriale.pianostr                                                                : String;
begin
  result := '';
end;

function    TVettoriale.disegnostr                                                              : String;
begin
  result := '';
end;

function    TVettoriale.nvtstr                                                                  : String;
begin
  result := '';
end;

function    TVettoriale.supstr                                                                  : String;
begin
  result := '';
end;

Procedure   TVettoriale.chiudiSeChiusa ;
begin

end;

Procedure   TVettoriale.Cambia1PoligonoaRegione;
begin

end;

Procedure   TVettoriale.salvavettorialeMacMap    (St : TMemoryStream);
begin
 if b_erased then exit;
 st.Write(tipo , sizeof(tipo));
end;

Procedure   TVettoriale.aprivettorialeMacMap     (St : TMemoryStream );
begin
	st.Read(tipo , sizeof(tipo));
end;


function    TVettoriale.numvt                                                                   : Integer;
begin
  result := 0;
end;

Procedure   TVettoriale.CatToUtm;
begin

end;

Procedure   TVettoriale.TestoAltoQU;
begin

end;

//   Procedure   salvadxf;
Procedure   TVettoriale.svuota;
begin

end;

function    TVettoriale.copiaPura                                                              : TVettoriale;
begin
  result := nil;
end;

function    TVettoriale.copiaPuraNoaDisegno                                                    : TVettoriale;
begin
  result := nil;
end;

Function    TVettoriale.caratteritesto                                                         : String;
begin
  result := '';
end;

Function    TVettoriale.altezzatesto                                                           : Real;
begin
  result := 0.0;
end;







end.
