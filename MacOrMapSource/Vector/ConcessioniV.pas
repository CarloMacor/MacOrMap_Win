unit ConcessioniV;

interface

uses Classes, DisegnoV,sysutils,vcl.dialogs,  GR32, GR32_Image, GR32_Layers;


type
 TConcessioniV = class
  DirConcessioni  : String;
  listaDisegni    : TList;
  ListaSelezionati : TList;

   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   ApriConcessioniTutte;
   procedure   AttivavistaNomedisegno(nomefile : String;visibilita :Boolean);
   procedure   AttDisSoloNomedisegno(nomefile : String);
   function    seVisibiledisegnoV(nomefile : String) : Boolean;
   function    seVisibiledisegnodaCod(cod : String) : Boolean;
   function    Nomedisegnodacod(cod : String) : String;
   procedure   MettivisibiledisCod(cod : String;visibilita :Boolean);
   procedure   AttDisSoloNomedisegnodacod(cod : String);

   function    presentedisegnoV(nomefile : String) : Boolean;
   function    presentedisegnoVdacod(cod : String) : Boolean;


   function    SelezionaPtInternoConcessione(x1,y1: real) : Boolean;
   procedure   disegnaselezionati(HHDC : TImage32);
   procedure   ZoomtuttoilVisibile;


   procedure   vedituttiDisegni;
   procedure   spegnituttiDisegni;
   function    sonotuttion : Boolean;
   procedure   ApridisegnoNome(nomefile : String);
   procedure   apriseassentedaCod(cod : String);
   procedure   ZoomDisdaCod(cod : String);
   procedure   mettiInSelezioneCodRow(cod : string; foglio,part: String);


   procedure   daNomepianoFgpart(nomep : String; var ilFg : String;  var ilPart : String);
   procedure   togliselezionati;

 end;

var LeConcessioniV : TConcessioniV;

implementation

uses varbase,uvector,vettoriale,dlg_contrattoConcessione,Leconcessioni,Funzioni, interfaccia,uviste,PartConc,piano,progetto;

Constructor TConcessioniV.Create;
begin
  listaDisegni := TList.Create;
  ListaSelezionati := TList.Create;
end;

Destructor  TConcessioniV.Done;
begin
end;

procedure   TConcessioniV.ApriConcessioniTutte;
var   searchResult : TSearchRec;
      LocDis : TDisegnoV;
      nomedacercare : String;
      conta : Integer;
      contadis : Integer;
      anchedis : Boolean;
begin
 anchedis := false;
 if ilprogetto.ListaDisegniV.count<2 then anchedis := true;

 conta :=0;
 DirConcessioni := dirDisegniConcessioni;
  if FindFirst(dirDisegniConcessioni+'*.macmap', faAnyFile, searchResult) = 0 then
  begin
    repeat
     nomedacercare := dirDisegniConcessioni+searchResult.Name;
      if Not(LeConcessioniV.presentedisegnoV(nomedacercare)) then
       begin
        LocDis :=  DammiDisegnoAperto(nomedacercare);
        LocDis.faiLimiti;

        LeConcessioniV.listaDisegni.Add(LocDis);

      ////////////////////////////////////////////////////////
 //     if anchedis then  ilprogetto.ListaDisegniV.Add(LocDis);


        inc(conta);
       end
        else
       begin
       end;

    until FindNext(searchResult) <> 0;
    FindClose(searchResult);
  end;
 if conta>0 then vedituttiDisegni else   begin if (sonotuttion) then spegnituttiDisegni else vedituttiDisegni; end;
end;


function  TConcessioniV.presentedisegnoV(nomefile : String) : Boolean;
var k : Integer;
    giapresente : Boolean;
    locdisV : TDisegnoV;
    nomefileristretto : String;
begin
 giapresente := false;
 nomefileristretto := extractfilename(nomefile);
 for k:=0 to listaDisegni.count-1 do
  begin
    locdisV := listaDisegni.Items[k];
    if (nomefileristretto = locdisV.nomedisegno) then
     begin giapresente := true; break; end;
  end;
 result := giapresente;
end;


procedure  TConcessioniV.AttivavistaNomedisegno(nomefile : String;visibilita :Boolean);
var k : Integer;
    giapresente : Boolean;
    locdisV : TDisegnoV;
    nomefileristretto : String;
begin
 nomefileristretto := extractfilename(nomefile);
 for k:=0 to listaDisegni.count-1 do
  begin
    locdisV := listaDisegni.Items[k];
    if (nomefileristretto = locdisV.nomedisegno) then
     begin locdisV.b_visibile:=visibilita;  break; end;
  end;
end;

function   TConcessioniV.seVisibiledisegnoV(nomefile : String) : Boolean;
var resulta : Boolean;
    nomefileristretto : String;
    locdisV : TDisegnoV;
    k : Integer;
begin
 resulta := false;
 nomefileristretto := extractfilename(nomefile);
 for k:=0 to listaDisegni.count-1 do
  begin
    locdisV := listaDisegni.Items[k];
    if (nomefileristretto = locdisV.nomedisegno) then
     begin resulta := locdisV.b_visibile;  break; end;
  end;
result := resulta;
end;

function   TConcessioniV.seVisibiledisegnodaCod(cod : String) : Boolean;
var nomefile : String;
begin
 nomefile := Nomedisegnodacod(cod);
 result := seVisibiledisegnoV(nomefile);
end;

procedure  TConcessioniV.AttDisSoloNomedisegno(nomefile : String);
var pres : Boolean;
    oravisibile : Boolean;
begin
 pres := presentedisegnoV(nomefile);
 oravisibile := seVisibiledisegnoV(nomefile);

 spegnituttiDisegni;
 if (pres) then AttivavistaNomedisegno(nomefile,not(oravisibile))
           else ApridisegnoNome(nomefile);

end;

procedure  TConcessioniV.AttDisSoloNomedisegnodacod(cod : String);
begin
 AttDisSoloNomedisegno(Nomedisegnodacod(cod));
 self.ZoomtuttoilVisibile;
end;


procedure  TConcessioniV.MettivisibiledisCod(cod : String;visibilita :Boolean);
var nomefile : String;
begin
 nomefile := Nomedisegnodacod(cod);
 AttivavistaNomedisegno(nomefile,visibilita);
end;


procedure  TConcessioniV.ZoomtuttoilVisibile;
 var	x1, y1, x2, y2, dx, dy, scal : Real;
      i : Integer;
  	  locdisvet : TDisegnoV;
      apted: Boolean;
begin
 apted := false;
	for i:=0  to LeConcessioniV.listaDisegni.count-1 do begin
		locdisvet := LeConcessioniV.listaDisegni.Items[i];
		if not(locdisvet.b_visibile) then continue;
		locdisvet.faiLimiti;
		if not(apted) then begin
			if (locdisvet.limx1<locdisvet.limx2) then
       begin
 			  x1 := locdisvet.limx1;			y1 := locdisvet.limy1;
			  x2 := locdisvet.limx2;			y2 := locdisvet.limy2;
			  apted:=true;
       end;
    end
		 else begin
			if (locdisvet.limx1<locdisvet.limx2) then
       begin
  			if (x1 >locdisvet.limx1)  then    x1 :=locdisvet.limx1;
   			if (y1 >locdisvet.limy1)  then    y1 :=locdisvet.limy1;
  			if (x2 <locdisvet.limx2)  then    x2 :=locdisvet.limx2;
  			if (y2 <locdisvet.limy2)  then    y2 :=locdisvet.limy2;
       end;
    end;
  end;
  if apted then
  begin
   setLimitiTutto(x1, y1, x2, y2);
   zoomTutto;
  end;
  ridisegna;
end;



function   TConcessioniV.Nomedisegnodacod(cod : String) : String;
var searchResult : TSearchRec;
    ilcoddis : String;
    resulta : String;
begin
 resulta := '';
 if dirDisegniConcessioni='' then begin showmessage('assente la def dir disegni concessioni'); exit; end;
 if FindFirst(dirDisegniConcessioni+'*.macmap', faAnyFile, searchResult) = 0 then
  begin
    repeat
      ilcoddis := prendiNumFinDisegno(searchResult.Name);
      if cod = ilcoddis then
       begin  resulta := dirDisegniConcessioni+searchResult.Name;  end;
     until FindNext(searchResult) <> 0;
    FindClose(searchResult);
  end;
  result := Resulta;
end;


procedure  TConcessioniV.ApridisegnoNome(nomefile : String);
var     locdis : TDisegnoV;
begin
  if Not(LeConcessioniV.presentedisegnoV(nomefile)) then
    begin
        LocDis :=  DammiDisegnoAperto(nomefile);
        LocDis.faiLimiti;
        LeConcessioniV.listaDisegni.Add(LocDis);
    end;
end;

procedure  TConcessioniV.vedituttiDisegni;
var k,conta : Integer;
    locdisV : TDisegnoV;
begin
 for k:=0 to listaDisegni.count-1 do
  begin
    locdisV := listaDisegni.Items[k];
    locdisV.b_visibile := true;
  end;
end;

procedure  TConcessioniV.spegnituttiDisegni;
var k,conta : Integer;
    locdisV : TDisegnoV;
begin
 for k:=0 to listaDisegni.count-1 do
  begin
    locdisV := listaDisegni.Items[k];
    locdisV.b_visibile := false;
  end;
end;

function   TConcessioniV.sonotuttion : Boolean;
var k,conta : Integer;
    locdisV : TDisegnoV;
    resulta : Boolean;
begin
 resulta := false;
 conta :=0;
 for k:=0 to listaDisegni.count-1 do
  begin
    locdisV := listaDisegni.Items[k];
    if locdisV.b_visibile then inc(conta);
  end;
  if (conta= listaDisegni.count) then resulta := true;
  result := resulta;
end;


procedure  TConcessioniV.daNomepianoFgpart(nomep : String; var ilFg : String;  var ilPart : String);
var k :Integer;
    parte1 : Boolean;
    carro : String;
begin
 ilFg :=''; ilPart:=''; parte1 := true;
 for k:=1 to length(nomep) do
  begin
   carro := nomep[k];
   if carro='_' then begin parte1 := false; continue; end;
   if parte1 then ilFg:=ilFg+carro else ilPart := ilPart+carro;
  end;
end;

procedure   TConcessioniV.mettiInSelezioneCodRow(cod : string; foglio,part: String);
var preser : Boolean;
    nomefile : String;
    k,j,m : Integer;
    locdisV : TDisegnoV;
    locpia : TPiano;
    constr : String;
    locvet : Tvettoriale;
begin
 constr := foglio+'_'+part;
 preser := presentedisegnoVdacod(cod);
 nomefile := Nomedisegnodacod(cod);
 if preser then
  begin

   for k:=0 to LeConcessioniV.listaDisegni.Count-1 do
    begin
     locdisV := LeConcessioniV.listaDisegni.Items[k];
     if (locdisV.nomedisegnoconPath = nomefile)  then
      begin
       for j:=0 to locdisV.ListaPiani.Count-1 do
        begin
         locpia := locdisV.ListaPiani.items[j];
         if (locpia.nomepiano = constr) then begin
          for m:=0 to locpia.Listavector.Count-1 do
           begin
            locvet:= locpia.Listavector.items[m];
            LeConcessioniV.ListaSelezionati.Add(locvet);
           end;
         end;
        end;
      end;
    end;
  end;
end;


function   TConcessioniV.SelezionaPtInternoConcessione(x1,y1: real) : Boolean;
var resulta : Boolean;
    k,j : Integer;
    locdisV : TDisegnoV;
    locvet : TVettoriale;
    ilcoddis : String;
    nomepiconc : String;
     locPartConc : TPartConc;
     lFg,lPart : String;
begin
 resulta := false;
 ListaSelezionati.clear;
// for k:=0 to listaDisegni.Count-1 do
 for k:=0 to LeConcessioniV.listaDisegni.Count-1 do
  begin
   locdisV := LeConcessioniV.listaDisegni.Items[k];
   locdisV.seleziona_conPtInterno(x1,y1,ListaSelezionati);
  end;

 if ListaSelezionati.Count>0 then
  begin
   locvet := ListaSelezionati.Items[0];
   locdisV := locvet._disegno;
   ilcoddis := prendiNumFinDisegno(locdisV.nomedisegno);
   nomepiconc := locvet._piano.nomepiano;
   daNomepianoFgpart(nomepiconc,lFg, lPart);
       Form_contrattoConcessione.contrattoinevidenza := ConcessioniTolfa.contrattodaId(ilcoddis);
       Form_contrattoConcessione.GrigliaDati.Col :=0;
       Form_contrattoConcessione.show;
       Form_contrattoConcessione.disegnalocale;

       for j:=0 to Form_contrattoConcessione.contrattoinevidenza.ListaParteParticelle.Count-1 do
        begin
         locPartConc := Form_contrattoConcessione.contrattoinevidenza.ListaParteParticelle.items[j];
         if ((locPartConc.Fg=lFg) and (locPartConc.Part=lPart)) then
          begin
           Form_contrattoConcessione.GrigliaDati.row := j+1;
//           Form_contrattoConcessione.ListBoxPart.ItemIndex :=j;
          end;

//         ListBoxPart.Items.Add('Fg.'+locPartConc.Fg+' Part.'+locPartConc.Part+'  mq:'+locPartConc.Sup
//                          +' Cat.'+locPartConc.categoria+' classe:'+locPartConc.classe +' "'+locPartConc.MioPart+ '"');

        end;
  end
  else Form_contrattoConcessione.Hide;

 // showmessage(intToStr(ListaSelezionati.Count));
 result  := resulta;
end;

function   TConcessioniV.presentedisegnoVdacod(cod : String) : Boolean;
var nomefile : String;
begin
 nomefile := Nomedisegnodacod(cod);
 result   := presentedisegnoV(nomefile);
end;



procedure  TConcessioniV.apriseassentedaCod(cod : String);
var preser : Boolean;
    nomefile : String;
begin
 preser := presentedisegnoVdacod(cod);
 nomefile := Nomedisegnodacod(cod);
 if not(preser) then ApridisegnoNome(nomefile);
end;


procedure  TConcessioniV.ZoomDisdaCod(cod : String);
var preser : Boolean;
    nomefile : String;
    locdis : TDisegnoV;
    k : Integer;
    testdisV : TDisegnoV;
    dx, dy, scal : Real;
begin
 locdis := nil;
 preser := presentedisegnoVdacod(cod);
 if (preser) then begin
 nomefile := Nomedisegnodacod(cod);
  for k:= 0 to listaDisegni.Count-1 do
   begin
    testdisV := listaDisegni.items[k];
    if (testdisV.nomedisegnoconPath =  nomefile) then begin locdis := testdisV; break; end;
   end;
  if locdis = nil then exit;
	if (locdis.limx1 = locdis.limx2) then exit;
	xorigineVista := locdis.limx1;
	yorigineVista := locdis.limy1;
	dx            := locdis.limx2-locdis.limx1;
	dy            := locdis.limy2-locdis.limy1;
  scalaVista    := dx/ Wschermo;
  scal          := dy/ Hschermo;
	set_scalaVista2 (scalaVista , scal);
	setZoomC      ( ((locdis.limx1+locdis.limx2)/2)  , ((locdis.limy1+locdis.limy2)/2)  );
 end;
end;

procedure  TConcessioniV.disegnaselezionati(HHDC : TImage32);
var locvet : TVettoriale;
         k : Integer;
   AColor32   : TColor32;
   AsupColor32: TColor32;
begin
    TColor32Entry(AColor32).A := 255;
    TColor32Entry(AColor32).R := 0;
    TColor32Entry(AColor32).G := 0;
    TColor32Entry(AColor32).B := 125;

    TColor32Entry(AsupColor32).A := 98;
    TColor32Entry(AsupColor32).R := 0;
    TColor32Entry(AsupColor32).G := 0;
    TColor32Entry(AsupColor32).B := 125;

 for k:= 0 to ListaSelezionati.Count-1 do
  begin
   locvet:= ListaSelezionati.items[k];
   locvet.DisegnaConColori(HHDC,AColor32,AsupColor32,1);
  end;
end;

procedure  TConcessioniV.togliselezionati;
begin
 ListaSelezionati.Clear;
end;


end.

