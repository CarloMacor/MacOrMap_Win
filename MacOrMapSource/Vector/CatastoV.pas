unit CatastoV;

interface

uses Classes, DisegnoV,sysutils,vcl.dialogs,  GR32, GR32_Image, GR32_Layers;

type
 TCatastoV = class
  NomefileQUnione : String;
  DirListaCXF     : String;
  QUnione         : TDisegnoV;
  listaCXF        : TList;
  ListaFabbricatiSelezionati : TList;
  ListaTerreniSelezionati    : TList;
  vedoQU          : Boolean;
  vedoCXF         : Boolean;
  vedoterreni     : boolean;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   ApriQU;
   procedure   ApriCXF;
   procedure   cambiavedoterreni;
   procedure   cercaFabbricato(_FG,_Part : String);
   procedure   cercaTerreno(_FG,_Part : String);
   procedure   cercaFoglio(FG : String);
   function    SelezionaPtInternoFabbricato(x1,y1: real) : Boolean;
   function    SelezionaPtInternoTerreno(x1,y1: real) : Boolean;
   procedure   disegnaselezionatiFabbricati(HHDC : TImage32);
   procedure   disegnaselezionatiTerreni(HHDC : TImage32);
   procedure   FiltraImmobiliDaticonNuovaListaFabbricati(ListaImmobiliDati_daAggiornare: TList);
   procedure   FiltraImmobiliDaticonNuovaListaTerreni(ListaImmobiliDati_daAggiornare: TList);
   procedure   FiltraImmobiliFgPart(fg,part : String;ListaImmobiliDati_daAggiornare: TList);

   procedure   QuadroOnOff(stato : Boolean);
   Function    centroedificioFgPart(fg,part : String; var x1 : real; var y1 : real): Boolean;
   procedure   mettInSelezioneTerrenoFgPart(fg,part : String; inLista : TList);
   procedure   vedotuttifogli;
   procedure   vedosolofoglio(_fg : String);
   procedure   toglifabterselezionati;
 end;

var IlCatastoV : TcatastoV;

implementation


uses Piano,uviste,uvector, vettoriale, Immobilidati, fabCatDati, varbase, testo,interfaccia;

Constructor TCatastoV.Create;
begin
  QUnione := nil;
  vedoQU  := false;
  vedoCXF := false;
  vedoterreni := true;
  listaCXF   := TList.Create;
  ListaFabbricatiSelezionati := TList.Create;
  ListaTerreniSelezionati    := TList.Create;

end;

Destructor  TCatastoV.Done;
begin
end;

procedure   TCatastoV.ApriQU;
begin
 if QUnione = nil then
  begin
   QUnione      := TDisegnoV.Create;
   QUnione.Apri(NomefileQUnione);
   QUnione.faiLimiti;
  end;
end;

procedure   TCatastoV.ApriCXF;
var searchResult : TSearchRec;
    locdisV : TDisegnoV;
begin
  if DirListaCXF<>'' then
   begin
    if FindFirst(DirListaCXF+'*.cxf', faAnyFile, searchResult) = 0 then
     begin
      repeat
       begin
        locdisV      := TDisegnoV.Create;
        locdisV.Apri(DirListaCXF+searchResult.Name);
        listaCXF.Add(locdisV);
       end;
      until FindNext(searchResult) <> 0;
      FindClose(searchResult);
     end;
   end;
end;

procedure   TCatastoV.cambiavedoterreni;
var locdisV : TDisegnoV;
 k : Integer;
begin
 vedoterreni := not(vedoterreni);
 for k:=0 to listaCXF.Count-1 do
  begin
   locdisV := listaCXF.Items[k];
   if vedoterreni then locdisV.layerscatastaliOnOff(1) else locdisV.layerscatastaliOnOff(2);
  end;
end;


procedure   TCatastoV.cercaFabbricato(_FG,_Part : String);
var locdisV : TDisegnoV;
    k,j,h : Integer;
    locpiano : TPiano;
    dx,dy,scal : real;
    trovato : Boolean;
    locvet : TVettoriale;
begin
 trovato := false;
 if ilCatastoV.listaCXF.Count=0 then apriCatasto;
 for k:=0 to listaCXF.Count-1 do
  begin
   locdisV := listaCXF.Items[k];
   if locdisV.nomeFoglioCXF = _FG then
    begin
     for j:=0 to locdisV.ListaPiani.Count-1 do
      begin
       locpiano := locdisV.ListaPiani.Items[j];
       if locpiano.pianoPlus then
        begin
         if locpiano.nomepianoNoPlus= _Part then
          begin
           ListaFabbricatiSelezionati.Clear;
           for h := 0 to locpiano.Listavector.Count-1 do
            begin
             locvet := locpiano.Listavector[h];
              begin if (locvet.tipo = PPoligono) then ListaFabbricatiSelezionati.Add(locvet); end;
            end;
           setZoom4vt(locpiano.limx1,locpiano.limy1,locpiano.limx2,locpiano.limy2,8);
           trovato := true;
          end;
        end;
      end;

     if not(trovato) then begin
      for j:=0 to locdisV.ListaPiani.Count-1 do
      begin
       locpiano := locdisV.ListaPiani.Items[j];
         if locpiano.nomepianoNoPlus= _Part then
          begin
           ListaTerreniSelezionati.Clear;
           for h := 0 to locpiano.Listavector.Count-1 do
            begin
             locvet := locpiano.Listavector[h];
              begin if (locvet.tipo = PPoligono) then ListaTerreniSelezionati.Add(locvet); end;
            end;
           setZoom4vt(locpiano.limx1,locpiano.limy1,locpiano.limx2,locpiano.limy2,8);
           trovato := true;
          end;
      end;
     end;

    end;
  end;
end;

procedure TcatastoV.cercaTerreno(_FG,_Part : String);
var locdisV : TDisegnoV;
    k,j,h : Integer;
    locpiano : TPiano;
    dx,dy,scal : real;
    trovato : Boolean;
    locvet : TVettoriale;

begin
 trovato := false;
 if ilCatastoV.listaCXF.Count=0 then apriCatasto;
 for k:=0 to listaCXF.Count-1 do
  begin
   locdisV := listaCXF.Items[k];
   if locdisV.nomeFoglioCXF = _FG then
    begin
     for j:=0 to locdisV.ListaPiani.Count-1 do
      begin
       locpiano := locdisV.ListaPiani.Items[j];
         if locpiano.nomepiano= _Part then
          begin
           ListaTerreniSelezionati.Clear;
           for h := 0 to locpiano.Listavector.Count-1 do
            begin
             locvet := locpiano.Listavector[h];
              begin if (locvet.tipo = PPoligono) then ListaTerreniSelezionati.Add(locvet); end;
            end;
           setZoom4vt(locpiano.limx1,locpiano.limy1,locpiano.limx2,locpiano.limy2,8);
           trovato := true;
          end;
      end;
    end;
  end;
end;


procedure TcatastoV.cercaFoglio(FG : String);
var locdisV : TDisegnoV;
    k,j,h : Integer;
    locpiano : TPiano;
    dx,dy,scal : real;
    trovato : Boolean;
    locvet : TVettoriale;
begin
 trovato := false;
 if ilCatastoV.listaCXF.Count=0 then apriCatasto;
 for k:=0 to listaCXF.Count-1 do
  begin
   locdisV := listaCXF.Items[k];
   if locdisV.nomeFoglioCXF = FG then
    begin
           setZoom4vt(locdisV.limx1,locdisV.limy1,locdisV.limx2,locdisV.limy2,1);
           trovato := true;
    end;
  end;
end;


function  TcatastoV.SelezionaPtInternoFabbricato(x1,y1: real) : Boolean;
var resulta : Boolean;
    k : Integer;
    locdisV : TDisegnoV;
begin
 resulta := false;
 ListaFabbricatiSelezionati.clear;
 for k:=0 to listaCXF.Count-1 do
  begin
   locdisV := listaCXF.Items[k];
   locdisV.seleziona_conPtInterno(x1,y1,ListaFabbricatiSelezionati);
  end;
//  if ListaFabbricatiSelezionati.Count>0 then showmessage(intToStr(ListaFabbricatiSelezionati.Count));
 result  := resulta;
end;

function  TcatastoV.SelezionaPtInternoTerreno(x1,y1: real) : Boolean;
var resulta : Boolean;
    k : Integer;
    locdisV : TDisegnoV;
begin
 resulta := false;
 ListaTerreniSelezionati.clear;
 for k:=0 to listaCXF.Count-1 do
  begin
   locdisV := listaCXF.Items[k];
   locdisV.seleziona_conPtInterno(x1,y1,ListaTerreniSelezionati);
  end;
 result  := resulta;
end;



procedure   TcatastoV.disegnaselezionatiFabbricati(HHDC : TImage32);
var locvet : TVettoriale;
         k : Integer;
   AColor32   : TColor32;
   AsupColor32: TColor32;
begin
    TColor32Entry(AColor32).A := 255;
    TColor32Entry(AColor32).R := 0;
    TColor32Entry(AColor32).G := 0;
    TColor32Entry(AColor32).B := 255;

    TColor32Entry(AsupColor32).A := 98;
    TColor32Entry(AsupColor32).R := 0;
    TColor32Entry(AsupColor32).G := 0;
    TColor32Entry(AsupColor32).B := 255;

 for k:= 0 to ListaFabbricatiSelezionati.Count-1 do
  begin
   locvet:= ListaFabbricatiSelezionati.items[k];
   locvet.DisegnaConColori(HHDC,AColor32,AsupColor32,1);
  end;
end;

procedure   TcatastoV.disegnaselezionatiTerreni(HHDC : TImage32);
var locvet : TVettoriale;
         k : Integer;
   AColor32   : TColor32;
   AsupColor32: TColor32;
begin
    TColor32Entry(AColor32).A := 255;
    TColor32Entry(AColor32).R := 90;
    TColor32Entry(AColor32).G := 255;
    TColor32Entry(AColor32).B := 90;

    TColor32Entry(AsupColor32).A := 98;
    TColor32Entry(AsupColor32).R := 0;
    TColor32Entry(AsupColor32).G := 255;
    TColor32Entry(AsupColor32).B := 0;

 for k:= 0 to ListaTerreniSelezionati.Count-1 do
  begin
   locvet:= ListaTerreniSelezionati.items[k];
   locvet.DisegnaConColori(HHDC,AColor32,AsupColor32,1);
  end;
end;



procedure   TcatastoV.FiltraImmobiliDaticonNuovaListaFabbricati(ListaImmobiliDati_daAggiornare: TList);
var k : Integer;
    locfabV : Tvettoriale;
    locfabdato : TFabCatDati;
    locfabtest : TFabCatDati;
begin
 ListaImmobiliDati_daAggiornare.clear;
 for k:= 0 to ListaFabbricatiSelezionati.count-1 do
  begin
   locfabV := ListaFabbricatiSelezionati.items[k];
   GliImmobiliDati.AddLista_FabDatoFgPart(ListaImmobiliDati_daAggiornare,locfabV._disegno.nomeFoglioCXF,locfabV._piano.nomepianoNoPlus);
  end;
end;

procedure   TcatastoV.FiltraImmobiliFgPart(fg,part : String; ListaImmobiliDati_daAggiornare: TList);
begin
 ListaImmobiliDati_daAggiornare.clear;
 GliImmobiliDati.AddLista_FabDatoFgPart(ListaImmobiliDati_daAggiornare,fg,part);
end;


procedure   TcatastoV.FiltraImmobiliDaticonNuovaListaTerreni(ListaImmobiliDati_daAggiornare: TList);
var k : Integer;
    locfabV : Tvettoriale;
    locfabdato : TFabCatDati;
begin
 ListaImmobiliDati_daAggiornare.clear;
 for k:= 0 to ListaTerreniSelezionati.count-1 do
  begin
   locfabV := ListaTerreniSelezionati.items[k];
   GliImmobiliDati.AddLista_TerDatoFgPart(ListaImmobiliDati_daAggiornare,locfabV._disegno.nomeFoglioCXF,locfabV._piano.nomepianoNoPlus);
  end;
end;


procedure   TcatastoV.QuadroOnOff(stato : Boolean);
begin
 vedoQU := stato;
 QUnione.b_visibile := vedoQU;
end;


Function    TcatastoV.centroedificioFgPart(fg,part : String; var x1 : real; var y1 : real): Boolean;
var resulta : Boolean;
    k, j,h: Integer;
    locdisV: TDisegnoV;
    locpiano : TPiano;
    locvet : TVettoriale;
    loctesto : TTesto;
begin
 resulta := false;
 if ilCatastoV.listaCXF.Count=0 then apriCatasto;
 for k:=0 to listaCXF.Count-1 do
  begin
   locdisV := listaCXF.Items[k];
   if locdisV.nomeFoglioCXF = fg then
    begin
     for j:=0 to locdisV.ListaPiani.Count-1 do
      begin
       locpiano := locdisV.ListaPiani.Items[j];
       if locpiano.pianoPlus then
        begin
         if locpiano.nomepianoNoPlus= Part then
          begin
           for h := 0 to locpiano.Listavector.Count-1 do
            begin
             locvet := locpiano.Listavector[h];
              begin if (locvet.tipo = PTesto) then
               begin
                loctesto := locpiano.Listavector[h];
                x1 := loctesto.x; y1 := loctesto.y; resulta := true;
               end;
              end;
            end;
          end;
        end;
      end;

     if not(resulta) then begin
      for j:=0 to locdisV.ListaPiani.Count-1 do
      begin
       locpiano := locdisV.ListaPiani.Items[j];
         if locpiano.nomepianoNoPlus= Part then
          begin
           ListaTerreniSelezionati.Clear;
           for h := 0 to locpiano.Listavector.Count-1 do
            begin
             locvet := locpiano.Listavector[h];
              begin if (locvet.tipo = PTesto) then
               begin
                loctesto := locpiano.Listavector[h];
                x1 := loctesto.x; y1 := loctesto.y; resulta := true;
               end;
              end;
            end;
           resulta := true;
          end;
      end;
     end;
    end;
  end;

 result := resulta;
end;

procedure TcatastoV.mettInSelezioneTerrenoFgPart(fg,part : String; inLista : TList);
var k,j,h : Integer;
    locdisV: TDisegnoV;
    locpiano: TPiano;
    locvet : TVettoriale;
begin

 if ilCatastoV.listaCXF.Count=0 then apriCatasto;
 for k:=0 to listaCXF.Count-1 do
  begin
   locdisV := listaCXF.Items[k];
   if locdisV.nomeFoglioCXF = fg then
    begin
     for j:=0 to locdisV.ListaPiani.Count-1 do
      begin
       locpiano := locdisV.ListaPiani.Items[j];
         if locpiano.nomepiano= part then
          begin
           for h := 0 to locpiano.Listavector.Count-1 do
            begin
             locvet := locpiano.Listavector[h];
              begin if (locvet.tipo = PPoligono) then inLista.Add(locvet); end;
            end;
          end;
      end;
    end;
  end;
end;


procedure  TcatastoV.vedotuttifogli;
var k,j,h : Integer;
    locdisV: TDisegnoV;
begin
 if ilCatastoV.listaCXF.Count=0 then apriCatasto;
 for k:=0 to listaCXF.Count-1 do
  begin
   locdisV := listaCXF.Items[k];
   locdisV.b_visibile := true;
  end;
  ridisegna;
end;

procedure  TcatastoV.vedosolofoglio(_fg : String);
var k,j,h : Integer;
    locdisV: TDisegnoV;
begin
 if ilCatastoV.listaCXF.Count=0 then apriCatasto;
 for k:=0 to listaCXF.Count-1 do
  begin
   locdisV := listaCXF.Items[k];
   if (locdisV.nomeFoglioCXF=_fg) then locdisV.b_visibile := true else locdisV.b_visibile := false;
  end;
  ridisegna;
end;


procedure  TcatastoV.toglifabterselezionati;
begin
 ListaFabbricatiSelezionati.clear;
 ListaTerreniSelezionati.Clear;
end;


end.
