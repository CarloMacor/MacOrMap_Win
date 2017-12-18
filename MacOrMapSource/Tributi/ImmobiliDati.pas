unit ImmobiliDati;

interface
 uses Classes,vcl.dialogs,SysUtils,soggetto,FabCatDati,TerCatDati  ;

type
 TImmobiliDati = class
  listaFabbricati          : TList;
  listaTerreni             : TList;
  listaFabbricatiFiltrata  : TList;
  listaFabbricatiFiltrataCase  : TList;
  listaTerreniFiltrata     : TList;
  caricata                 : Boolean;

  ListaProprietariTerra     : TList;
  ListaProprietariFabbricati: TList;

  ListaPossessiTerra       : TList;
  ListaPossessiTerraFiltrata       : TList;
  ListaPossessiFabbricati  : TList;
  ListaPossessiFabbricatiFiltrata  : TList;
  ListaPossessiPrimaCasa   : TList;

  ListaTares               : TList;
  ListaTaresFiltrata       : TList;

  ListaImu                 : TList;
  ListaImuFiltrata         : TList;

   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   Aprifabbricati;
   procedure   salvafabbricati(nomefile: String);
   procedure   ApriTerreni;
   procedure   salvaTerreni(nomefile: String);
   procedure   ApriProprietariterreni;
   procedure   ApriProprietariFabbricati;
   procedure   SalvaProprietari(Modo : Integer; nomefile: String);
   procedure   ApriPossessiTerreni;
   procedure   ApriPossessiFabbricati;
   procedure   SalvaTitoloProp(Modo : Integer; nomefile: String);
   procedure   AssociaPossessi(Modo : Integer);
   procedure   salvaInfoAnagrafe(nomefile: String);
   procedure   ApriInfoAnagrafe;


   procedure   ApriTares;
   procedure   SalvaTares(nomefile: String);

   procedure   ApriImu;
   procedure   SalvaImu(nomefile: String);

   function    AddLista_FabDatoFgPart(ListaImmobiliDati_daAggiornare: TList; Fg,part : String) : boolean;
   function    AddLista_TerDatoFgPart(ListaImmobiliDati_daAggiornare: TList; Fg,part : String) : boolean;
   function    FabDatoFgPartSub(Fg,part,sub : String) : TFabCatDati;
   function    TerDatoFgPart(Fg,part : String) : TTerCatDati;
   function    FabDatoFgPart_primo(Fg,part : String) : TFabCatDati;
   function    FabDatodaId(Id : String) : TFabCatDati;

   procedure   Apri;
   procedure   SalvaTutto;

   procedure   filtraTaresFgPartSub ( fg,part,sub : String);
   procedure   filtraTaresdaLista (lista :TList);
   procedure   filtraImuFgPartSub ( fg,part,sub : String);
   procedure   filtraImudaLista (lista :TList);
   procedure   filtraPrimacasaFgPartSub( fg,part,sub : String; listaFam : Tlist);
   procedure   filtraEdificioFgPartSub( fg,part,sub : String);
   procedure   filtraTerrenoFgPartSub( fg,part,sub : String);

   procedure   filtraPossessiLista (lista :TList);

   procedure   RiordinaFabbricati( listmodo,modo : Integer);
   procedure   RiordinaTerreni( listmodo,modo : Integer);
   procedure   togliterreni0Sup;
   function    dammiproprietarioCF(id : String): TSoggetto;

   procedure   disassociaFamiglia(indfam : String);
   function    associaFamiglia(codfamily , Foglio, Particella, Subalterno : String): Boolean;

   procedure   riordinaSoggettiModo(mododisegna ,colonna : Integer );
 end;

var   GliImmobiliDati : TImmobilidati;

implementation

// uses Famiglia, Residente;
uses  funzioni, Proprietario,Possesso, anagrafe, famiglia, residente,tares, varbase, Imu;

function  FabCatdaFgPartSub( fg,part,sub : String; ListaRicerca:TList ): TFabCatDati;
var resulta : TFabCatDati;
    k : integer;
    locf    :  TFabCatDati;
begin
 resulta := nil;
 for k:=0 to Listaricerca.count-1 do
  begin
   locf := Listaricerca.items[k];
   if ((locf.Foglio=fg) and (locf.Particella=part) and (locf.Subalterno=sub)) then begin resulta:=locf; break; end;
  end;
 result := resulta;
end;

function  TerCatdaFgPartSub( fg,part : String; ListaRicerca:TList ): TTerCatDati;
var resulta : TTerCatDati;
    k : integer;
    locf    :  TTerCatDati;
begin
 resulta := nil;
 for k:=0 to Listaricerca.count-1 do
  begin
   locf := Listaricerca.items[k];
   if ((locf.Foglio=fg) and (locf.Particella=part) ) then begin resulta:=locf; break; end;
  end;
 result := resulta;
end;


function soggettodaId(idsog : String; ListaRicerca:TList) : TSoggetto;
var resulta : Tsoggetto;
    k : integer;
    locsog    :  TSoggetto;
begin
 resulta := nil;
 for k:=0 to ListaRicerca.count-1 do
  begin
   locsog := ListaRicerca.items[k];
   if locsog.Identificativo = idsog then begin resulta := locsog;  break; end;
  end;
 result := resulta;
end;



Constructor TImmobiliDati.Create;
begin
  caricata                    := false;
  listaFabbricati             := TList.Create;
  listaTerreni                := TList.Create;
  listaFabbricatiFiltrata     := TList.Create;
  listaFabbricatiFiltrataCase := TList.Create;
  listaTerreniFiltrata        := TList.Create;
  ListaProprietariTerra       := TList.Create;
  ListaProprietariFabbricati  := TList.Create;
  ListaPossessiTerra          := TList.Create;
  ListaPossessiFabbricati     := TList.Create;
  ListaTares                  := TList.Create;
  ListaTaresFiltrata          := TList.Create;
  ListaPossessiFabbricatiFiltrata := TList.Create;
  ListaPossessiPrimaCasa      := TList.Create;
  ListaPossessiTerraFiltrata  := TList.Create;
  ListaImu                    := TList.Create;
  ListaImuFiltrata            := TList.Create;
end;

Destructor  TImmobiliDati.Done;
begin
end;


procedure   TImmobiliDati.Apri;
begin
  if caricata then exit;

  ApriTares;
  ApriImu;
  ApriPossessiFabbricati;
  ApriPossessiTerreni;

  ApriFabbricati;
  ApriTerreni;
  ApriProprietariterreni;
  ApriProprietariFabbricati;

  ApriInfoAnagrafe;

  caricata := true;
end;




procedure  TImmobiliDati.salvaTerreni(nomefile: String);
var listarighe : TStringList;
    k,j : Integer;
    locTerdato : TTerCatDati;
    nnn: Integer;
    locfam : TFamiglia;
    loctares : TTares;
    locIMu   : TImu;
    locposs : TPossesso;
    into , coda , locnum: Integer;
begin
   listarighe := TStringList.Create;

   listarighe.Add(IntToStr(listaTerreni.count));

   for k:=0 to listaTerreni.count-1 do
    begin
     locTerdato := listaTerreni.items[k];
     listarighe.Add('Terreno');

     listarighe.Add(locTerdato.codiceamministrativo);

     listarighe.Add(locTerdato.sezione);
     listarighe.Add(locTerdato.IdentificativoImmobile);
     listarighe.Add(locTerdato.Foglio);
     listarighe.Add(locTerdato.Particella);
     listarighe.Add(locTerdato.Subalterno);
     listarighe.Add(locTerdato.edificabile);

     listarighe.Add(locTerdato.QualitaCod);
     listarighe.Add(locTerdato.Qualita);

     listarighe.Add(locTerdato.Classe);

//     listarighe.Add(locTerdato.ettari);
//     listarighe.Add(locTerdato.are);
//     listarighe.Add(locTerdato.centiare);
     val(locTerdato.ettari,into,coda);     if coda =0 then locTerdato.Superficie := into*10000;
     val(locTerdato.are,into,coda);        if coda =0 then locTerdato.Superficie := locTerdato.Superficie+into*100;
     val(locTerdato.centiare,into,coda);   if coda =0 then locTerdato.Superficie := locTerdato.Superficie+into;

     listarighe.Add(IntToStr(locTerdato.Superficie));


     listarighe.Add(locTerdato.RenditaDomenicaleStrEuro);
     listarighe.Add(locTerdato.RenditaAgrariaStrEuro);



     locnum    := locTerdato.Possessi.count;
     listarighe.Add(IntToStr(locnum));

     for j:=0 to locTerdato.Possessi.count-1 do
      begin    //   possessi
       locposs := locTerdato.Possessi.items[j];
       listarighe.Add(locposs.IdPossesso);
      end;

     nnn := locTerdato.ICI_paganti.count;
     listarighe.Add(IntToStr(nnn));
     for j:=0 to locTerdato.ICI_paganti.count-1 do
      begin    //   ICI_paganti       : cf PIva del pagamento
       locIMu := locTerdato.ICI_paganti.Items[j];
       listarighe.Add(locIMu.indice);
      end;

     nnn := locTerdato.TARES_paganti.count;
     listarighe.Add(IntToStr(nnn));
     for j:=0 to locTerdato.TARES_paganti.count-1 do
      begin   //   TARES_paganti       : indice tares
       locTares := locTerdato.TARES_paganti.Items[j];
       listarighe.Add(locTares.indice);
      end;



    end;
   listarighe.SaveToFile(nomefile);
   listarighe.Free;
end;


procedure  TImmobiliDati.salvaInfoAnagrafe(nomefile: String);
var F : TextFile;
    k,j : Integer;
    locfam : TFamiglia;
    loctares : TTares;
    locImu   : TImu;
    locposs  : TPossesso;
begin
 assignFile(F,nomefile); rewrite(F);

 writeln(F,IntTostr(LaAnagrafe.listaFamiglie.Count));
 for k :=0 to LaAnagrafe.listaFamiglie.Count-1 do
  begin
   locfam := LaAnagrafe.listaFamiglie.items[k];
   writeln(F,'Famiglia');
   writeln(F,locfam.codfamily);

   writeln(F,locfam.ListaTares.Count);
   for j:=0 to locfam.ListaTares.Count-1 do
    begin
     loctares := locfam.ListaTares.Items[j];
     writeln(F,loctares.indice);
    end;

   writeln(F,locfam.ListaImu.Count);
   for j:=0 to locfam.ListaImu.Count-1 do
    begin
     locImu := locfam.ListaImu.Items[j];
     writeln(F,locImu.indice);
    end;

   writeln(F,locfam.ListaPossessi.Count);
   for j:=0 to locfam.ListaPossessi.Count-1 do
    begin
     locposs := locfam.ListaPossessi.Items[j];
     writeln(F,locposs.IdPossesso);
    end;
  end;

 closefile(F);
end;


procedure TImmobiliDati.ApriInfoAnagrafe;
var listarighe : TStringList;
    rgt : Integer;
    nFam : Integer;
    k,j : Integer;
    riga : String;
    codfam : String;
    ntares,nImu,nPoss : Integer;
    intRiga : Integer;
    lafamiglia : TFamiglia;
begin
 if Not( fileExists(NomefileAnagrafeInfo)) then exit;
   listarighe := TStringList.Create;
   listarighe.LoadFromFile(NomefileAnagrafeInfo);
   rgt :=0;
   nFam := StrToInt(listarighe[rgt]);    inc(rgt);
   for k:=1 to nFam do
    begin
      riga   := listarighe[rgt];    inc(rgt); //'Famiglia');
      codfam := listarighe[rgt];    inc(rgt); // cod famiglia

      lafamiglia := LaAnagrafe.FamigliaDaCodice(codfam);

      ntares := StrToInt(listarighe[rgt]);   inc(rgt);
      for j:= 1 to ntares do
       begin
        intRiga := StrToInt(listarighe[rgt]);    inc(rgt);
        if lafamiglia<>nil then lafamiglia.ListaTares.Add(ListaTares.Items[intRiga] );
       end;

      nImu := StrToInt(listarighe[rgt]);     inc(rgt);
      for j:= 1 to nImu do
       begin
        intRiga := StrToInt(listarighe[rgt]);    inc(rgt);
        if lafamiglia<>nil then lafamiglia.ListaImu.Add(ListaImu.Items[intRiga] );
       end;

      nPoss := StrToInt(listarighe[rgt]);    inc(rgt);
      for j:= 1 to nPoss do
       begin
        intRiga := StrToInt(listarighe[rgt]);    inc(rgt);
        if lafamiglia<>nil then lafamiglia.ListaPossessi.Add(ListaPossessiFabbricati.Items[intRiga] );
       end;



    end;
end;


procedure  TImmobiliDati.salvafabbricati(nomefile: String);
var listarighe : TStringList;
    k,j : Integer;
    locFabdato : TFabCatDati;
    nnn: Integer;
    locfam : TFamiglia;
    loctares : TTares;
    locposs : TPossesso;
    locIMu : TImu;
begin
   listarighe := TStringList.Create;

   listarighe.Add(IntToStr(listaFabbricati.count));

   for k:=0 to listaFabbricati.count-1 do
    begin
     locFabdato := listaFabbricati.items[k];
     listarighe.Add('Fabbricato');
     listarighe.Add(locFabdato.codiceamministrativo);
     listarighe.Add(locFabdato.sezione);
     listarighe.Add(locFabdato.IdentificativoImmobile);
     listarighe.Add(locFabdato.Foglio);
     listarighe.Add(locFabdato.Particella);
     listarighe.Add(locFabdato.Subalterno);
     listarighe.Add(locFabdato.Foglio2);
     listarighe.Add(locFabdato.Particella2);
     listarighe.Add(locFabdato.Subalterno2);
     listarighe.Add(locFabdato.Categoria);
     listarighe.Add(locFabdato.Classe);
     listarighe.Add(locFabdato.Consistenza);
     listarighe.Add(locFabdato.superficie);
     listarighe.Add(locFabdato.RenditaStrEuro);
     listarighe.Add(locFabdato.codicestrada);
     listarighe.Add(locFabdato.PrimaAbitazione0123);
     listarighe.Add(locFabdato.Topo_Catastale);
     listarighe.Add(locFabdato.Via_Catastale);
     listarighe.Add(locFabdato.Civico_Catastale);
     listarighe.Add(locFabdato.Topo_Anagrafe);
     listarighe.Add(locFabdato.Via_Anagrafe);
     listarighe.Add(locFabdato.Civico_Anagrafe);
     listarighe.Add(locFabdato.Topo_Corretta);
     listarighe.Add(locFabdato.Via_Corretta);
     listarighe.Add(locFabdato.Civico_Corretta);
     listarighe.Add(locFabdato.piano);
     listarighe.Add(locFabdato.Interno);

     nnn := locFabdato.Residenti.count;
     listarighe.Add(IntToStr(nnn));
     for j:=0 to locFabdato.Residenti.count-1 do
      begin   //   Residenti       : TList;  le famiglie codice
       locfam := locFabdato.Residenti.Items[j];
       listarighe.Add(locfam.codfamily);
      end;

     nnn := locFabdato.Possessi.count;
     listarighe.Add(IntToStr(nnn));
     for j:=0 to locFabdato.Possessi.count-1 do
      begin   //   Possessi       : cf del possesso
       locposs := locFabdato.Possessi.items[j];
       listarighe.Add(locposs.IdPossesso);
      end;

     nnn := locFabdato.ICI_paganti.count;
     listarighe.Add(IntToStr(nnn));
     for j:=0 to locFabdato.ICI_paganti.count-1 do
      begin    //   ICI_paganti       : cf PIva del pagamento
       locIMu := locFabdato.ICI_paganti.Items[j];
       listarighe.Add(locIMu.indice);
      end;

     nnn := locFabdato.TARES_paganti.count;
     listarighe.Add(IntToStr(nnn));
     for j:=0 to locFabdato.TARES_paganti.count-1 do
      begin    //   TARES_paganti       : indice tares
       locTares := locFabdato.TARES_paganti.Items[j];
       listarighe.Add(locTares.indice);
      end;

    end;
   listarighe.SaveToFile(nomefile);

   listarighe.Free;

end;

procedure  TImmobiliDati.aprifabbricati;
var listarighe : TStringList;
    nFab : Integer;
    rgt  : Integer;
    locFabdato : TFabCatDati;
    k , j ,f: Integer;
    locnum : Integer;
    locriga : String;
    locfam : TFamiglia;
    loctares : TTares;
    locposs : TPossesso;
    intlocriga : Integer;
    locImu : TImu;
begin
 if Not( fileExists(NomefileFabbricatidati)) then exit;
   listarighe := TStringList.Create;
   listarighe.LoadFromFile(NomefileFabbricatidati);
   rgt :=0;
   nFab := StrToInt(listarighe[rgt]);    inc(rgt);
   for k := 1 to nfab do
    begin
     inc(rgt); // Fabbricato

     locFabdato := TFabCatDati.Create;  listaFabbricati.Add(locFabdato);

     locFabdato.codiceamministrativo := listarighe[rgt]; inc(rgt);
     locFabdato.sezione          := listarighe[rgt]; inc(rgt);
     locFabdato.IdentificativoImmobile := listarighe[rgt]; inc(rgt);
     locFabdato.Foglio           := listarighe[rgt]; inc(rgt);
     locFabdato.Particella       := listarighe[rgt]; inc(rgt);
     locFabdato.Subalterno       := listarighe[rgt]; inc(rgt);
     locFabdato.Foglio2          := listarighe[rgt]; inc(rgt);
     locFabdato.Particella2      := listarighe[rgt]; inc(rgt);
     locFabdato.Subalterno2      := listarighe[rgt]; inc(rgt);
     locFabdato.Categoria        := listarighe[rgt]; inc(rgt);
     locFabdato.Classe           := listarighe[rgt]; inc(rgt);
     locFabdato.Consistenza      := listarighe[rgt]; inc(rgt);
     locFabdato.superficie       := listarighe[rgt]; inc(rgt);
     locFabdato.RenditaStrEuro   := listarighe[rgt]; inc(rgt);
     locFabdato.codicestrada     := listarighe[rgt]; inc(rgt);
     locFabdato.PrimaAbitazione0123   := listarighe[rgt]; inc(rgt);
     locFabdato.Topo_Catastale   := listarighe[rgt]; inc(rgt);
     locFabdato.Via_Catastale    := listarighe[rgt]; inc(rgt);
     locFabdato.Civico_Catastale := listarighe[rgt]; inc(rgt);
     locFabdato.Topo_Anagrafe    := listarighe[rgt]; inc(rgt);
     locFabdato.Via_Anagrafe     := listarighe[rgt]; inc(rgt);
     locFabdato.Civico_Anagrafe  := listarighe[rgt]; inc(rgt);
     locFabdato.Topo_Corretta    := listarighe[rgt]; inc(rgt);
     locFabdato.Via_Corretta     := listarighe[rgt]; inc(rgt);
     locFabdato.Civico_Corretta  := listarighe[rgt]; inc(rgt);
     locFabdato.piano            := listarighe[rgt]; inc(rgt);
     locFabdato.Interno          := listarighe[rgt]; inc(rgt);

     locnum    := StrToInt(listarighe[rgt]); inc(rgt);
     for j:=1 to locnum do
      begin   //   Residenti       : TList;  le famiglie codice
       locriga    := listarighe[rgt]; inc(rgt);
       for f :=0 to LaAnagrafe.listaFamiglie.Count-1 do
        begin
         locfam := LaAnagrafe.listaFamiglie.Items[f];
         if locfam.codfamily = locriga then begin locFabdato.Residenti.add(locfam);    end;
        end;
      end;

     locnum    := StrToInt(listarighe[rgt]); inc(rgt);
     for j:=1 to locnum do
      begin    //   Possessi       : cf del possesso
       locriga    := listarighe[rgt]; inc(rgt);
       intlocriga := strToInt(locriga);
       if ((intlocriga>=0) and (intlocriga<ListaPossessiFabbricati.Count)) then
        begin
         locposs := ListaPossessiFabbricati.Items[intlocriga];
         locFabdato.Possessi.add(locposs);
        end;
      end;

     locnum    := StrToInt(listarighe[rgt]); inc(rgt);
     for j:=1 to locnum do
      begin    //   ICI_paganti       : cf PIva del pagamento
        locriga    := listarighe[rgt]; inc(rgt);
        intlocriga := StrToInt(locriga);
//        if ((intlocriga>=0) and (intlocriga<ListaImu.Count)) then
         begin  locImu := ListaImu.Items[intlocriga];  locFabdato.ICI_paganti.add(locImu); end;
      end;

     locnum    := StrToInt(listarighe[rgt]); inc(rgt);
     for j:=1 to locnum do
      begin    //   TARES_paganti       : indice tares
        locriga    := listarighe[rgt]; inc(rgt);
        intlocriga := StrToInt(locriga);
//        if ((intlocriga>=0) and (intlocriga<ListaTares.Count)) then
         begin locTares := ListaTares.Items[intlocriga]; locFabdato.TARES_paganti.add(loctares); end;
      end;


    end;


   listarighe.Free;
// caricatiedifici := true;
end;







procedure  TImmobiliDati.ApriTerreni;
var listarighe : TStringList;
    nTer : Integer;
    rgt  : Integer;
    locTerdato : TTerCatDati;
    locSog     : TSoggetto;
    locPoss    : TPossesso;
    locImu     : TImu;
    locTares   : TTares;
    k , j,f: Integer;
    locnum : Integer;
    locriga : String;
    into,coda,intlocriga : Integer;
begin
 if Not( fileExists(NomefileTerrenidati)) then exit;
   listarighe := TStringList.Create;
   listarighe.LoadFromFile(NomefileTerrenidati);
   rgt :=0;
   nTer := StrToInt(listarighe[rgt]);    inc(rgt);
   for k := 1 to nTer do
    begin
     inc(rgt); // Terreno solo scritta

     locTerdato := TTerCatDati.Create;  listaTerreni.Add(locTerdato);


     locTerdato.codiceamministrativo := listarighe[rgt]; inc(rgt);
     locTerdato.sezione          := listarighe[rgt]; inc(rgt);
     locTerdato.IdentificativoImmobile := listarighe[rgt]; inc(rgt);
     locTerdato.Foglio           := listarighe[rgt]; inc(rgt);
     locTerdato.Particella       := listarighe[rgt]; inc(rgt);
     locTerdato.Subalterno       := listarighe[rgt]; inc(rgt);
     locTerdato.edificabile      := listarighe[rgt]; inc(rgt);
     locTerdato.QualitaCod       := listarighe[rgt]; inc(rgt);
     locTerdato.Qualita          := listarighe[rgt]; inc(rgt);
      if locTerdato.Qualita ='' then begin showmessage(locTerdato.QualitaCod); exit; end;



     locTerdato.Classe           := listarighe[rgt]; inc(rgt);
//     locTerdato.ettari           := listarighe[rgt]; inc(rgt);
//     locTerdato.are              := listarighe[rgt]; inc(rgt);
//     locTerdato.centiare         := listarighe[rgt]; inc(rgt);
     locTerdato.Superficie         := StrToInt(listarighe[rgt]); inc(rgt);

     locTerdato.RenditaDomenicaleStrEuro       := listarighe[rgt]; inc(rgt);
     locTerdato.RenditaAgrariaStrEuro          := listarighe[rgt]; inc(rgt);




    {
       val(locTerdato.ettari,into,coda);     if coda =0 then locTerdato.Superficie := into*10000;
         val(locTerdato.are,into,coda);        if coda =0 then locTerdato.Superficie := locTerdato.Superficie+into*100;
         val(locTerdato.centiare,into,coda);   if coda =0 then locTerdato.Superficie := locTerdato.Superficie+into;
  }


     locnum    := StrToInt(listarighe[rgt]); inc(rgt);

     for j:=1 to locnum do
      begin    //   possessi
       locriga    := listarighe[rgt]; inc(rgt);
       intlocriga := strToInt(locriga);
       if ((intlocriga>=0) and (intlocriga<ListaPossessiTerra.Count)) then
        begin
         locposs := ListaPossessiTerra.Items[intlocriga];
         locTerdato.Possessi.add(locposs);
        end;
      end;

     locnum    := StrToInt(listarighe[rgt]); inc(rgt);
     for j:=1 to locnum do
      begin    //   ICI_paganti       : cf PIva del pagamento
        locriga    := listarighe[rgt]; inc(rgt);
        for f :=0 to ListaImu.Count-1 do
         begin
          locImu := ListaImu.Items[f];
          if locImu.indice = locriga then begin locTerdato.ICI_paganti.add(locImu);    end;
         end;
      end;

     locnum    := StrToInt(listarighe[rgt]); inc(rgt);
     for j:=1 to locnum do
      begin    //   TARES_paganti       : indice tares
        locriga    := listarighe[rgt]; inc(rgt);
        for f :=0 to ListaTares.Count-1 do
         begin
          locTares := ListaTares.Items[f];
          if loctares.indice = locriga then begin locTerdato.TARES_paganti.add(loctares);    end;
         end;
      end;





      if locTerdato.QualitaCod='998' then begin      // soppresso
       listaTerreni.Delete(listaTerreni.count-1);
       locTerdato.Free;
      end;



    end;
   listarighe.Free;


end;


procedure  TImmobiliDati.SalvaProprietari(Modo : Integer; nomefile: String);
var listarighe : TStringList;
    k,j : Integer;
    locSog : TSoggetto;
begin
  listarighe := TStringList.Create;

  case modo of
   1 :
    begin
     listarighe.Add(IntToStr(ListaProprietariFabbricati.count));
      for k:=0 to ListaProprietariFabbricati.count-1 do
       begin
        locSog := ListaProprietariFabbricati.items[k];
         listarighe.Add('Soggetto');
         listarighe.Add(locSog.CodiceAmministrativo);
         listarighe.Add(locSog.Sezione);
         listarighe.Add(locSog.Identificativo);
         listarighe.Add(locSog.TipoSoggetto);
         listarighe.Add(locSog.Cognome);
         listarighe.Add(locSog.Nome);
         listarighe.Add(locSog.CodSesso);
         listarighe.Add(locSog.DataNascitaStr);
         listarighe.Add(locSog.LuogoNascita);
         listarighe.Add(locSog.CodiceFiscale);
         listarighe.Add(locSog.DenominazioneAzienda);
         listarighe.Add(locSog.CodiceSedeAzienda);
         listarighe.Add(locSog.CFAzienda);
       end;
    end;

   2 : begin
     listarighe.Add(IntToStr(ListaProprietariTerra.count));
      for k:=0 to ListaProprietariTerra.count-1 do
       begin
        locSog := ListaProprietariTerra.items[k];
         listarighe.Add('Soggetto');
         listarighe.Add(locSog.CodiceAmministrativo);
         listarighe.Add(locSog.Sezione);
         listarighe.Add(locSog.Identificativo);
         listarighe.Add(locSog.TipoSoggetto);
         listarighe.Add(locSog.Cognome);
         listarighe.Add(locSog.Nome);
         listarighe.Add(locSog.CodSesso);
         listarighe.Add(locSog.DataNascitaStr);
         listarighe.Add(locSog.LuogoNascita);
         listarighe.Add(locSog.CodiceFiscale);
         listarighe.Add(locSog.DenominazioneAzienda);
         listarighe.Add(locSog.CodiceSedeAzienda);
         listarighe.Add(locSog.CFAzienda);
       end;
   end;
  end;

  listarighe.SaveToFile(nomefile);
  listarighe.Free;
end;



procedure  TImmobiliDati.ApriProprietariterreni;
var listarighe : TStringList;
    nTer : Integer;
    rgt  : Integer;
    locTerdato : TTerCatDati;
    locSog     : TSoggetto;
  //  locPoss    : TPossesso;
    k , j: Integer;
    locnum : Integer;
    locriga : String;
    into,coda : Integer;
begin
 if ( fileExists(NomefileProprietariTerra)) then
  begin
   listarighe := TStringList.Create;
   listarighe.LoadFromFile(NomefileProprietariTerra);
   rgt :=0;
   nTer := StrToInt(listarighe[rgt]);    inc(rgt);
   for k := 1 to nTer do
    begin
     inc(rgt); // SOGGEETO solo scritta
     locSog := TSoggetto.Create;  ListaProprietariTerra.Add(locSog);
     locSog.CodiceAmministrativo := listarighe[rgt]; inc(rgt);
     locSog.Sezione              := listarighe[rgt]; inc(rgt);
     locSog.Identificativo       := listarighe[rgt]; inc(rgt);
     locSog.TipoSoggetto         := listarighe[rgt]; inc(rgt);
     locSog.Cognome              := listarighe[rgt]; inc(rgt);
     locSog.Nome                 := listarighe[rgt]; inc(rgt);
     locSog.CodSesso             := listarighe[rgt]; inc(rgt);
     locSog.DataNascitaStr       := listarighe[rgt]; inc(rgt);
     locSog.LuogoNascita         := listarighe[rgt]; inc(rgt);
     locSog.CodiceFiscale        := listarighe[rgt]; inc(rgt);
     locSog.DenominazioneAzienda := listarighe[rgt]; inc(rgt);
     locSog.CodiceSedeAzienda    := listarighe[rgt]; inc(rgt);
     locSog.CFAzienda            := listarighe[rgt]; inc(rgt);
    end;
   listarighe.Free;
  end;
end;


procedure  TImmobiliDati.ApriProprietariFabbricati;
var listarighe : TStringList;
    nTer : Integer;
    rgt  : Integer;
    locTerdato : TTerCatDati;
    locSog     : TSoggetto;
    locPoss    : TPossesso;
    k , j: Integer;
    locnum : Integer;
    locriga : String;
    into,coda : Integer;
begin
 if ( fileExists(NomefileProprietariEdifici)) then
  begin
   listarighe := TStringList.Create;
   listarighe.LoadFromFile(NomefileProprietariEdifici);
   rgt :=0;
   nTer := StrToInt(listarighe[rgt]);    inc(rgt);
   for k := 1 to nTer do
    begin
     inc(rgt); // SOGGEETO solo scritta
     locSog := TSoggetto.Create;  ListaProprietariFabbricati.Add(locSog);
     locSog.CodiceAmministrativo    := listarighe[rgt]; inc(rgt);
     locSog.Sezione              := listarighe[rgt]; inc(rgt);
     locSog.Identificativo       := listarighe[rgt]; inc(rgt);
     locSog.TipoSoggetto         := listarighe[rgt]; inc(rgt);
     locSog.Cognome              := listarighe[rgt]; inc(rgt);
     locSog.Nome                 := listarighe[rgt]; inc(rgt);
     locSog.CodSesso             := listarighe[rgt]; inc(rgt);
     locSog.DataNascitaStr       := listarighe[rgt]; inc(rgt);
     locSog.LuogoNascita         := listarighe[rgt]; inc(rgt);
     locSog.CodiceFiscale        := listarighe[rgt]; inc(rgt);
     locSog.DenominazioneAzienda := listarighe[rgt]; inc(rgt);
     locSog.CodiceSedeAzienda    := listarighe[rgt]; inc(rgt);
     locSog.CFAzienda            := listarighe[rgt]; inc(rgt);
    end;
   listarighe.Free;
  end;
end;

procedure  TImmobiliDati.ApriTares;
var listarighe : TStringList;
    nTer : Integer;
    rgt  : Integer;
    locTares : TTares;
    k , j: Integer;
    locnum : Integer;
    locriga : String;
    into,coda : Integer;
begin
 if Not( fileExists(Nomefiletares)) then exit;
   listarighe := TStringList.Create;
   listarighe.LoadFromFile(Nomefiletares);
   rgt :=0;
   nTer := StrToInt(listarighe[rgt]);    inc(rgt);
   for k := 1 to nTer do
    begin
     inc(rgt); // TRIBUTO solo scritta
     locTares := TTares.Create;  listaTares.Add(locTares);
     locriga                 :=   listarighe[rgt]; inc(rgt);
     if locriga='1' then loctares.associato:= true else loctares.associato:= false;
     locTares.indice         := listarighe[rgt]; inc(rgt);
     locTares.Cognome        := listarighe[rgt]; inc(rgt);
     locTares.Nome           := listarighe[rgt]; inc(rgt);
     locTares.CFIVA          := listarighe[rgt]; inc(rgt);
     locTares.Indirizzo      := listarighe[rgt]; inc(rgt);
     locTares.Foglio         := listarighe[rgt]; inc(rgt);
     locTares.Particella     := listarighe[rgt]; inc(rgt);
     locTares.Subalterno     := listarighe[rgt]; inc(rgt);
     locTares.Categoria      := listarighe[rgt]; inc(rgt);
     locTares.DataIscStr     := listarighe[rgt]; inc(rgt);
     locTares.MqTarsuStr     := listarighe[rgt]; inc(rgt);
    end;
   listarighe.Free;
end;

procedure  TImmobiliDati.SalvaTares(nomefile: String);
var F : TextFile;
    k : Integer;
    locTares: TTares;
begin
 assignFile(F,Nomefile); rewrite(F);
  writeln(F,listaTares.Count);
   for k := 0 to listaTares.Count-1 do
    begin
     writeln(F,'TRIBUTO');
     locTares := listaTares.items[k];
     if loctares.associato then writeln(F,'1') else writeln(F,'0');
     writeln(F,locTares.indice);
     writeln(F,locTares.Cognome);
     writeln(F,locTares.Nome);
     writeln(F,locTares.CFIVA);
     writeln(F,locTares.Indirizzo);
     writeln(F,locTares.Foglio);
     writeln(F,locTares.Particella);
     writeln(F,locTares.Subalterno);
     writeln(F,locTares.Categoria);
     writeln(F,locTares.DataIscStr);
     writeln(F,locTares.MqTarsuStr);
    end;
  closefile(F);
end;


procedure  TImmobiliDati.ApriImu;
var listarighe : TStringList;
    nTer : Integer;
    rgt  : Integer;
    locImu : TImu;
    k , j: Integer;
    locnum : Integer;
    locriga : String;
    into,coda : Integer;
begin
 if Not( fileExists(NomefileImu)) then exit;
   listarighe := TStringList.Create;
   listarighe.LoadFromFile(NomefileImu);
   rgt :=0;
   nTer := StrToInt(listarighe[rgt]);    inc(rgt);
   for k := 1 to nTer do
    begin
     inc(rgt); // TRIBUTO solo scritta
     locImu := TImu.Create;  listaImu.Add(locImu);
     locriga                 :=   listarighe[rgt]; inc(rgt);
     if locriga='1' then locImu.associato:= true else locImu.associato:= false;
     locImu.indice         := listarighe[rgt]; inc(rgt);
     locImu.Cognome        := listarighe[rgt]; inc(rgt);
     locImu.Nome           := listarighe[rgt]; inc(rgt);
     locImu.CFIVA          := listarighe[rgt]; inc(rgt);
     locImu.Indirizzo      := listarighe[rgt]; inc(rgt);
     locImu.Foglio         := listarighe[rgt]; inc(rgt);
     locImu.Particella     := listarighe[rgt]; inc(rgt);
     locImu.Subalterno     := listarighe[rgt]; inc(rgt);
     locImu.Categoria      := listarighe[rgt]; inc(rgt);
     locImu.DataIscStr     := listarighe[rgt]; inc(rgt);
     locImu.MqImuStr       := listarighe[rgt]; inc(rgt);
     locImu.RenditaStr     := listarighe[rgt]; inc(rgt);
     locImu.ValoreStr      := listarighe[rgt]; inc(rgt);
    end;
   listarighe.Free;
end;


procedure  TImmobiliDati.SalvaTutto;
begin
 if NomefileFabbricatidati<>''     then salvafabbricati(NomefileFabbricatidati);
 if NomefileTerrenidati<>''        then salvaTerreni(NomefileTerrenidati);
 if NomefileTares<>''              then SalvaTares(NomefileTares);
 if NomefileImu<>''                then SalvaImu(NomefileImu);
 if NomefileProprietariEdifici<>'' then  SalvaProprietari(1, NomefileProprietariEdifici);
 if NomefilePossessiEdifici<>''    then  SalvaTitoloProp (1, NomefilePossessiEdifici);
 if NomefileProprietariTerra<>''   then  SalvaProprietari(2, NomefileProprietariTerra);
 if NomefilePossessiTerreni<>''    then  SalvaTitoloProp (2, NomefilePossessiTerreni);
 if NomefileAnagrafeInfo<>''       then  SalvaInfoAnagrafe(NomefileAnagrafeInfo);
//   ;

end;


procedure  TImmobiliDati.SalvaImu(nomefile: String);
var F : TextFile;
    k : Integer;
    locImu: TImu;
begin
 assignFile(F,Nomefile); rewrite(F);
  writeln(F,listaImu.Count);
   for k := 0 to listaImu.Count-1 do
    begin
     writeln(F,'TRIBUTO');
     locImu := listaImu.items[k];
     if locImu.associato then writeln(F,'1') else writeln(F,'0');
     writeln(F,locImu.indice);
     writeln(F,locImu.Cognome);
     writeln(F,locImu.Nome);
     writeln(F,locImu.CFIVA);
     writeln(F,locImu.Indirizzo);
     writeln(F,locImu.Foglio);
     writeln(F,locImu.Particella);
     writeln(F,locImu.Subalterno);
     writeln(F,locImu.Categoria);
     writeln(F,locImu.DataIscStr);
     writeln(F,locImu.MqImuStr);
     writeln(F,locImu.RenditaStr);
     writeln(F,locImu.ValoreStr);
    end;
  closefile(F);
end;



procedure  TImmobiliDati.ApriPossessiTerreni;
var listarighe : TStringList;
    nTer : Integer;
    rgt  : Integer;
    locTerdato : TTerCatDati;
    locSog     : TSoggetto;
    locPoss    : TPossesso;
    k , j: Integer;
    locnum : Integer;
    locriga : String;
    into,coda : Integer;
begin
   if ( fileExists(nomefilePossessiTerreni))    then
    begin
     listarighe := TStringList.Create;
     listarighe.LoadFromFile(nomefilePossessiTerreni);
     rgt :=0;
     nTer := StrToInt(listarighe[rgt]);    inc(rgt);
     for k := 1 to nTer do
      begin
       inc(rgt); // POSSESSO solo scritta
       locPoss := TPossesso.Create;  ListaPossessiTerra.Add(locPoss);
       locPoss.IdPossesso             := listarighe[rgt]; inc(rgt);
       locPoss.CodiceAmministrativo   := listarighe[rgt]; inc(rgt);
       locPoss.Sezione                := listarighe[rgt]; inc(rgt);
       locPoss.IdentificativoSoggetto := listarighe[rgt]; inc(rgt);
       locPoss.TipoSoggetto           := listarighe[rgt]; inc(rgt);
       locPoss.IdentificativoImmobile := listarighe[rgt]; inc(rgt);
       locPoss.TipoImmobile           := listarighe[rgt]; inc(rgt);
       locPoss.CodiceDiritto          := listarighe[rgt]; inc(rgt);
       locPoss.TitoloNonCodificato    := listarighe[rgt]; inc(rgt);
       locPoss.QuotaNumeratore        := listarighe[rgt]; inc(rgt);
       locPoss.QuotaDenominatore      := listarighe[rgt]; inc(rgt);
       locPoss.Regime                 := listarighe[rgt]; inc(rgt);
       locPoss.DatavaliditaStr        := listarighe[rgt]; inc(rgt);
      end;
     listarighe.Free;
    end;
//    showmessage(intToStr(ListaPossessiTerra.count));
end;


procedure  TImmobiliDati.ApriPossessiFabbricati;
var listarighe : TStringList;
    nTer : Integer;
    rgt  : Integer;
    k , j: Integer;
    locnum : Integer;
    locriga : String;
    locPoss    : TPossesso;
begin
 if Not( fileExists(NomefilePossessiEdifici)) then exit;
   listarighe := TStringList.Create;
   listarighe.LoadFromFile(NomefilePossessiEdifici);
   rgt :=0;
   nTer := StrToInt(listarighe[rgt]);    inc(rgt);
   for k := 1 to nTer do
    begin
     inc(rgt); // POSSESSO solo scritta
     locPoss := TPossesso.Create;  ListaPossessiFabbricati.Add(locPoss);
     locPoss.IdPossesso             := listarighe[rgt]; inc(rgt);
     locPoss.CodiceAmministrativo   := listarighe[rgt]; inc(rgt);
     locPoss.Sezione                := listarighe[rgt]; inc(rgt);
     locPoss.IdentificativoSoggetto := listarighe[rgt]; inc(rgt);
     locPoss.TipoSoggetto           := listarighe[rgt]; inc(rgt);
     locPoss.IdentificativoImmobile := listarighe[rgt]; inc(rgt);
     locPoss.TipoImmobile           := listarighe[rgt]; inc(rgt);
     locPoss.CodiceDiritto          := listarighe[rgt]; inc(rgt);
     locPoss.TitoloNonCodificato    := listarighe[rgt]; inc(rgt);
     locPoss.QuotaNumeratore        := listarighe[rgt]; inc(rgt);
     locPoss.QuotaDenominatore      := listarighe[rgt]; inc(rgt);
     locPoss.Regime                 := listarighe[rgt]; inc(rgt);
     locPoss.DatavaliditaStr        := listarighe[rgt]; inc(rgt);
    end;
   listarighe.Free;

end;

procedure  TImmobiliDati.SalvaTitoloProp(Modo : Integer; nomefile: String);
var listarighe : TStringList;
    k,j : Integer;
    locPoss    : TPossesso;
    LaLista : TList;
begin
  listarighe := TStringList.Create;
  case modo of
   1 :
    begin
     LaLista := ListaPossessiFabbricati;
    end;
   2 :
    begin
     LaLista := ListaPossessiTerra;
    end;
  end;


     listarighe.Add(IntToStr(LaLista.count));
      for k:=0 to LaLista.count-1 do
       begin
        locPoss := LaLista.items[k];
         listarighe.Add('Possesso');
         listarighe.Add(locPoss.IdPossesso);
         listarighe.Add(locPoss.CodiceAmministrativo);
         listarighe.Add(locPoss.Sezione);
         listarighe.Add(locPoss.IdentificativoSoggetto);
         listarighe.Add(locPoss.TipoSoggetto);
         listarighe.Add(locPoss.IdentificativoImmobile);
         listarighe.Add(locPoss.TipoImmobile);
         listarighe.Add(locPoss.CodiceDiritto);
         listarighe.Add(locPoss.TitoloNonCodificato);
         listarighe.Add(locPoss.QuotaNumeratore);
         listarighe.Add(locPoss.QuotaDenominatore);
         listarighe.Add(locPoss.Regime);
         listarighe.Add(locPoss.DatavaliditaStr);
       end;



  listarighe.SaveToFile(nomefile);
  listarighe.Free;


end;

procedure   TImmobiliDati.AssociaPossessi(Modo : Integer);
var listarighe : TStringList;
    k,j : Integer;
    locPoss    : TPossesso;
    LaListaPossessi : TList;
    locTerdato : TTerCatDati;
    locFabdato : TFabCatDati;

begin
  case modo of
   1 : // fabbricati
    begin
     LaListaPossessi := ListaPossessiFabbricati;
 //    showmessage('Fabbricati:'+IntToStr(listaFabbricati.count) +' Possessi: '+IntToStr(ListaPossessiFabbricati.count));

     for k:=0 to listaFabbricati.Count-1 do
      begin
       locFabdato := listaFabbricati.items[k];
        for j:=0 to ListaPossessiFabbricati.Count-1 do
         begin
          locPoss := ListaPossessiFabbricati.items[j];
          if (locFabdato.IdentificativoImmobile = LocPoss.IdentificativoImmobile) then
           begin
            locFabdato.Possessi.Add(locposs);
           end;
         end;
      end;
    end;
   2 :  // terreni
    begin
     LaListaPossessi := ListaPossessiTerra;
     for k:=0 to listaTerreni.Count-1 do
      begin
       locTerdato := listaTerreni.items[k];
        for j:=0 to ListaPossessiTerra.Count-1 do
         begin
          locPoss := ListaPossessiTerra.items[j];
          if (locTerdato.IdentificativoImmobile = LocPoss.IdentificativoImmobile) then
           begin
            locTerdato.Possessi.Add(locposs);
           end;
         end;
      end;
    end;
  end;
end;


function   TImmobiliDati.AddLista_FabDatoFgPart(ListaImmobiliDati_daAggiornare: TList; Fg,part : String) : boolean;
var k,j : Integer;
    locfabdati,locfabtest : TFabCatDati;
    resulta  : Boolean;
    presente : boolean;
begin
 resulta := false;
 for k:=0 to listaFabbricati.Count-1 do
  begin
   locfabdati := listaFabbricati.items[k];
   if ((locfabdati.Foglio=Fg) and (locfabdati.Particella= part)) then
    begin
     presente := false;
     for j:= 0 to ListaImmobiliDati_daAggiornare.Count-1 do
      begin
       locfabtest := ListaImmobiliDati_daAggiornare.Items[j];
       if locfabtest= locfabdati then presente := true;
      end;
      if not ( presente) then ListaImmobiliDati_daAggiornare.Add(locfabdati);
    end;
  end;
 if ListaImmobiliDati_daAggiornare.count>0 then resulta := true;
 result := resulta;
end;

function  TImmobiliDati.FabDatoFgPartSub(Fg,part,sub : String) : TFabCatDati;
var k,j : Integer;
    locfabdati,locfabtest : TFabCatDati;
    resulta  : TFabCatDati;
    presente : boolean;
begin
 resulta := nil;
  if ((Fg='') or (part='')) then
   begin end
    else
   begin
    for k:=0 to listaFabbricati.Count-1 do
     begin
      locfabdati := listaFabbricati.items[k];
      if ((locfabdati.Foglio=Fg) and (locfabdati.Particella= part) and (locfabdati.Subalterno= sub) ) then
       begin
        resulta := locfabdati;
        break;
       end;
     end;
   end;
 result := resulta;
end;


function   TImmobiliDati.TerDatoFgPart(Fg,part : String) : TTerCatDati;
var k,j : Integer;
    locterdati,loctertest : TTerCatDati;
    resulta  : TTerCatDati;
    presente : boolean;
begin
 resulta := nil;
  if ((Fg='') or (part='')) then
   begin end
    else
   begin
    for k:=0 to listaterreni.Count-1 do
     begin
      locterdati := listaterreni.items[k];
      if ((locterdati.Foglio=Fg) and (locterdati.Particella= part) ) then
       begin
        resulta := locterdati;
        break;
       end;
     end;
   end;
 result := resulta;
end;


function  TImmobiliDati.FabDatoFgPart_primo(Fg,part : String) : TFabCatDati;
var k,j : Integer;
    locfabdati,locfabtest : TFabCatDati;
    resulta  : TFabCatDati;
    presente : boolean;
begin
 resulta := nil;
  if ((Fg='') or (part='')) then
   begin end
    else
   begin
    for k:=0 to listaFabbricati.Count-1 do
     begin
      locfabdati := listaFabbricati.items[k];
      if ((locfabdati.Foglio=Fg) and (locfabdati.Particella= part) ) then
       begin
        resulta := locfabdati;
        break;
       end;
     end;
   end;
 result := resulta;
end;

function   TImmobiliDati.FabDatodaId(Id : String) : TFabCatDati;
var k : Integer;
    locfabdati : TfabCatDati;
    resulta : TFabCatDati;
begin
 resulta := nil;
 for k:=0 to listaFabbricati.Count-1 do
  begin
   locfabdati := listaFabbricati.items[k];
   if (id= locfabdati.IdentificativoImmobile ) then begin resulta := locfabdati; break; end;

  end;
 result := resulta;
end;



function   TImmobiliDati.AddLista_TerDatoFgPart(ListaImmobiliDati_daAggiornare: TList; Fg,part : String) : boolean;
var k : Integer;
    locterdati : TTerCatDati;
    resulta : Boolean;
begin
 resulta := false;
 for k:=0 to listaTerreni.Count-1 do
  begin
   locterdati := listaTerreni.items[k];
   if ((locterdati.Foglio=Fg) and (locterdati.Particella= part)) then
     ListaImmobiliDati_daAggiornare.Add(locterdati);
  end;
 if ListaImmobiliDati_daAggiornare.count>0 then resulta := true;
 result := resulta;
end;

procedure  TImmobiliDati.filtraTaresFgPartSub ( fg,part,sub : String);
var K , j : Integer;
    loctares : TTares;
begin
 ListaTaresFiltrata.Clear;
 for k:=0 to ListaTares.Count-1 do
  begin
   loctares := ListaTares.items[k];
   if ((loctares.Foglio=fg) and (loctares.Particella=part) and (loctares.Subalterno =sub) ) then
    begin  ListaTaresFiltrata.Add(loctares);  end;
  end;
end;

procedure  TImmobiliDati.filtraTaresdaLista (lista :TList);
var K : Integer;
    loctares : TTares;
begin
 ListaTaresFiltrata.Clear;
 for k:=0 to lista.Count-1 do
  begin
   loctares := lista.items[k];
   ListaTaresFiltrata.Add(loctares);
  end;
end;

procedure  TImmobiliDati.filtraImudaLista (lista :TList);
var K : Integer;
    locImu : TImu;
begin
 ListaImuFiltrata.Clear;
 for k:=0 to lista.Count-1 do
  begin
   locImu := lista.items[k];
   ListaImuFiltrata.Add(locImu);
  end;
end;

procedure  TImmobiliDati.filtraPossessiLista (lista :TList);
var K : Integer;
    locPoss : TPossesso;
begin
 ListaPossessiFabbricatiFiltrata.Clear;
 for k:=0 to lista.Count-1 do
  begin
   locPoss := lista.items[k];
   ListaPossessiFabbricatiFiltrata.Add(locPoss);
  end;
end;


procedure  TImmobiliDati.filtraImuFgPartSub ( fg,part,sub : String);
var K , j : Integer;
    locImu : TImu;
begin
 ListaImuFiltrata.Clear;
 for k:=0 to ListaImu.Count-1 do
  begin
   locImu := ListaImu.items[k];
   if ((locImu.Foglio=fg) and (locImu.Particella=part) and (locImu.Subalterno =sub) ) then
    begin  ListaImuFiltrata.Add(locImu);  end;
  end;
end;

procedure  TImmobiliDati.filtraPrimacasaFgPartSub( fg,part,sub: String; listaFam : Tlist);
var K , j , h : Integer;
    locpos : TPossesso;
    illofab : TFabCatDati;
    deter : Boolean;
    locfam : TFamiglia;
    locres : Tresidente;
    locsog : TSoggetto;
begin
 ListaPossessiPrimaCasa.Clear;
 illofab := FabCatdaFgPartSub(fg,part,sub,listaFabbricati);
 if illofab<> nil then
  begin
   for k:=0 to ListaPossessiFabbricati.Count-1 do
    begin
     locpos := ListaPossessiFabbricati.items[k];
     locsog := soggettodaId(locpos.IdentificativoSoggetto,ListaProprietariFabbricati );
     if locsog= nil then continue;
     if (locpos.IdentificativoImmobile= illofab.IdentificativoImmobile) then
      begin
       deter := false;
       for j:=0 to Listafam.count-1 do
        begin
         locfam := Listafam.items[j];
         for h:=0 to locfam.ListaFamiglia.Count-1 do
          begin
           locres := locfam.ListaFamiglia.items[h];
           if locres.CF = locsog.CodiceFiscale then deter := true;
          end;
        end;

       if deter then ListaPossessiPrimaCasa.Add(locpos);
      end;
    end;
  end;

end;

procedure  TImmobiliDati.filtraEdificioFgPartSub( fg,part,sub : String);
var K , j : Integer;
    locpos : TPossesso;
    illofab : TFabCatDati;
begin
 ListaPossessiFabbricatiFiltrata.Clear;
 illofab := FabCatdaFgPartSub(fg,part,sub,listaFabbricati);
 if illofab<> nil then
  begin
   for k:=0 to ListaPossessiFabbricati.Count-1 do
    begin
     locpos := ListaPossessiFabbricati.items[k];
     if (locpos.IdentificativoImmobile= illofab.IdentificativoImmobile) then  ListaPossessiFabbricatiFiltrata.Add(locpos);
    end;
  end;
end;

procedure  TImmobiliDati.filtraTerrenoFgPartSub( fg,part,sub : String);
var K , j : Integer;
    locpos : TPossesso;
    illoter : TTerCatDati;
begin
 ListaPossessiTerraFiltrata.Clear;
 illoter := TerCatdaFgPartSub(fg,part,listaTerreni);
 if illoter<> nil then
  begin
{
     for k:=0 to ListaPossessiTerra.Count-1 do
      begin
       locpos := ListaPossessiTerra.items[k];
       if (locpos.IdentificativoImmobile= illoter.IdentificativoImmobile) then  ListaPossessiTerraFiltrata.Add(locpos);
      end;
}

   for k:=0 to illoter.Possessi.Count-1 do
    begin
     locpos := illoter.Possessi.items[k];
     ListaPossessiTerraFiltrata.Add(locpos);
    end;


  end;
end;


procedure TImmobiliDati.RiordinaFabbricati( listmodo,modo : Integer);
var LaLista : TList;
    PassaLista : TList;
    locfk,locfj :  TFabCatDati;
    k,j,pos : Integer;
begin
 case listmodo of
  1 : LaLista:=listaFabbricati;
  2 : LaLista:=listaFabbricatiFiltrata;
 end;

 PassaLista := TList.Create;

 for k:=0 to LaLista.Count-1 do
  begin
   locfk := LaLista.items[k];      pos :=0;
   for j:=0 to PassaLista.Count-1 do
    begin
     pos := j;
     locfj := PassaLista.items[j];
      case modo of
       1 : if locfk.OrdineFgPartSub(locfj)=0 then  break;
       2 : if locfk.OrdineCategoria(locfj)=0 then  break;
       4 : if locfk.ICI_paganti.Count> locfj.ICI_paganti.Count then break;
       5 : if locfk.TARES_paganti.Count> locfj.TARES_paganti.Count then break;
       6 : if locfk.Residenti.Count> locfj.Residenti.Count then break;
       7 : if locfk.Possessi.Count> locfj.Possessi.Count then break;

       8 : if locfk.superficie         > locfj.superficie then break;
       9 : if locfk.RenditaStrEuro     > locfj.RenditaStrEuro then break;

       20 : if locfk.Topo_Catastale    < locfj.Topo_Catastale   then break;
       21 : if locfk.Via_Catastale     < locfj.Via_Catastale    then break;
       22 : if locfk.Civico_Catastale  < locfj.Civico_Catastale then break;

       23 : if locfk.Topo_Anagrafe     < locfj.Topo_Anagrafe    then break;
       24 : if locfk.Via_Anagrafe      < locfj.Via_Anagrafe     then break;
       25 : if locfk.Civico_Anagrafe   < locfj.Civico_Anagrafe  then break;

       26 : if locfk.Topo_Corretta     < locfj.Topo_Corretta    then break;
       27 : if locfk.Via_Corretta      < locfj.Via_Corretta     then break;
       28 : if locfk.Civico_Corretta   < locfj.Civico_Corretta  then break;


      end;
     pos := j+1;
    end;
   PassaLista.insert(pos,locfk);
  end;

 LaLista.clear;
 for k:=0 to PassaLista.Count-1 do
  begin locfk := PassaLista.items[k]; LaLista.Add(locfk); end;
 PassaLista.Clear;
 PassaLista.free;
end;

procedure  TImmobiliDati.RiordinaTerreni( listmodo,modo : Integer);
var LaLista     : TList;
    PassaLista  : TList;
    locTk,locTj : TTerCatDati;
    k,j,pos : Integer;
begin
 case listmodo of
  1 : LaLista:=listaTerreni;
  2 : LaLista:=listaTerreniFiltrata;
 end;
 PassaLista := TList.Create;

for k:=0 to LaLista.Count-1 do
  begin
   locTk := LaLista.items[k];      pos :=0;
   for j:=0 to PassaLista.Count-1 do
    begin
     pos := j;
     locTj := PassaLista.items[j];
      case modo of
       1 : if locTk.OrdineFgPart(locTj)=0      then  break;
       2 : if locTk.OrdineQualita(locTj)=0     then  break;
       3 : if locTk.OrdineClasse(locTj)=0      then  break;
       4 : if locTk.OrdineSuperficie(locTj)=0  then  break;
       5 : if locTk.OrdineAgraria(locTj)=0     then  break;
       6 : if locTk.OrdineDomenicale(locTj)=0  then  break;
      end;
     pos := j+1;
    end;
   PassaLista.insert(pos,locTk);
  end;


 LaLista.clear;
 for k:=0 to PassaLista.Count-1 do
  begin locTk := PassaLista.items[k]; LaLista.Add(locTk); end;
 PassaLista.Clear;
 PassaLista.free;

end;


procedure  TImmobiliDati.togliterreni0Sup;
var    locT : TTerCatDati;
       k : Integer;
begin
for k:=listaTerreni.Count-1 downto 0 do
  begin
   locT := listaTerreni.items[k];
   if locT.Superficie=0 then listaTerreni.delete(k);
  end;
end;

function   TImmobiliDati.dammiproprietarioCF(id : String): TSoggetto;
var k,j : Integer;
    locposs : Tpossesso;
    locsogg : TSoggetto;
    resulta : TSoggetto;
begin
 resulta:= nil;
 for k:=0 to ListaPossessiFabbricati.Count-1 do
  begin
   locposs := ListaPossessiFabbricati.items[k];
   if (locposs.IdPossesso = id) then
    begin
     for j :=0 to ListaProprietariFabbricati.Count-1 do
      begin
       locsogg:= ListaProprietariFabbricati.items[j];
       if locsogg.Identificativo = locposs.IdentificativoSoggetto then
        begin
         resulta := locsogg;
         break;
        end;
      end;
    end;
  end;
  result := resulta;
end;


procedure TImmobiliDati.disassociaFamiglia (indfam : String);
var k ,j  : integer;
    locFabdato : TFabCatDati;
    locfam : TFamiglia;
begin
  for k:=0 to listaFabbricati.Count-1 do
   begin
     locFabdato := listaFabbricati.items[k];
     for j:=locFabdato.Residenti.Count-1 downto 0 do
      begin
       locfam:= locFabdato.Residenti.items[j];
       if locfam.codfamily = indfam then locFabdato.Residenti.delete(j);
      end;
   end;
end;

function  TImmobiliDati.associaFamiglia(codfamily , Foglio, Particella, Subalterno : String): Boolean;
var k ,j  : integer;
    locFabdato : TFabCatDati;
    locfam : TFamiglia;
    locres : Boolean;
begin
 locres := false;
 locfam := LaAnagrafe.FamigliaDaCodice(codfamily);
 if locfam<>nil then
  begin
   for k:=0 to listaFabbricati.Count-1 do
    begin
     locFabdato := listaFabbricati.items[k];
     if ((locFabdato.Foglio = Foglio) and (locFabdato.Particella = Particella) and (locFabdato.Subalterno = Subalterno)) then
      begin
       locFabdato.residenti.Add(locfam); locres := true;
      end;
    end;
   end;
  result := locres;
end;


procedure  TImmobiliDati.riordinaSoggettiModo(mododisegna ,colonna : Integer );
var k : Integer;
   locsoggetto ,compsoggetto: TSoggetto;
   LaListadaprendereDati : TList;
   PassaLista : TList;
   j,loK,loJ : Integer;
begin
 case mododisegna of
  0 : LaListadaprendereDati := GliImmobiliDati.ListaProprietariTerra;
  1 : LaListadaprendereDati := GliImmobiliDati.ListaProprietariFabbricati;
 end;

 PassaLista := TList.Create;

   for k:=0 to LaListadaprendereDati.count-1 do
    begin
     locsoggetto:=LaListadaprendereDati.items[k];
     loJ :=PassaLista.count;
      for j:=0 to PassaLista.count-1 do
       begin
        compsoggetto:=PassaLista.items[j];
        case colonna of
         1 : begin  //      Nome
           if locsoggetto.Nome >=compsoggetto.Nome then continue;
           loJ:=j;
           break;
         end;
         2 : begin  //      Cognome
           if locsoggetto.Cognome >=compsoggetto.Cognome then continue;
           loJ:=j;
           break;
         end;
         7 : begin  //      nr possessi
           if locsoggetto.nrpossessi >=compsoggetto.nrpossessi then continue;
           loJ:=j;
           break;
         end;
        end;

       end;
      PassaLista.Insert(loJ,locsoggetto);
    end;

   case colonna of
     1,2,7 :
      begin
       LaListadaprendereDati.clear;
        for k:=0 to PassaLista.count-1 do
         begin locsoggetto:=PassaLista.items[k]; LaListadaprendereDati.add(locsoggetto); end;
      end;
    end;

 PassaLista.clear; PassaLista.Free;

end;


end.






