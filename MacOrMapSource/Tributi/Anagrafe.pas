unit Anagrafe;

interface
 uses Classes, DisegnoV, vcl.dialogs,SysUtils,Famiglia;

type
 TAnagrafe = class
  listaFamiglie          : TList;
  listaFamiglieFiltrata  : TList;
  listaResidentiFiltrata : TList;
  listafamigliePrimaCasa : TList;
  listaResidenti         : TList;
  listafameigliedificio  : TList;

  caricata               : Boolean;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   Apri(nomefile : String);
   procedure   Salva(nomefile : String);
   procedure   filtraFgPartSub ( fg,part,sub : String);
   procedure   filtraFam1casaFgPartSub ( fg,part,sub : String);
   procedure   riordinaModo(modo: Integer);
   function    FamigliaDaCodice(code : String): TFamiglia;
   procedure   FiltraResidentiCodice(codice: string);
   procedure   faifamiglieedificio(_fg,_part : String);

 end;

var LaAnagrafe : TAnagrafe;

implementation

uses  Residente, Tares;

Constructor TAnagrafe.Create;
begin
  listaFamiglie          := TList.Create;
  listaFamiglieFiltrata  := TList.Create;
  listaResidentiFiltrata := TList.Create;
  listaResidenti         := TList.Create;
  listafamigliePrimaCasa := TList.Create;
  listafameigliedificio  := TList.Create;
  caricata               := false;
end;

Destructor  TAnagrafe.Done;
begin
end;

procedure   TAnagrafe.FiltraResidentiCodice(codice: string);
var k : Integer;
    locres : Tresidente;
    locfam : TFamiglia;
begin
 listaResidentiFiltrata.Clear;
 for k:= 0 to ListaResidenti.Count-1 do
  begin
   locres:= ListaResidenti.items[k];
   if locres.famer.codfamily=codice then listaResidentiFiltrata.add(locres);
  end;

 listaFamiglieFiltrata.Clear;
 for k:= 0 to listaFamiglieFiltrata.Count-1 do
  begin
   locfam:= listaFamiglieFiltrata.items[k];
   if locfam.codfamily=codice then listaFamiglieFiltrata.add(locfam);
  end;

end;

procedure   TAnagrafe.Apri(nomefile : String);
var listarighe : TStringList;
    nFam : Integer;
    rgt  : Integer;
    locFam : TFamiglia;
    locRes : Tresidente;
    k,j : Integer;
    locnumfam : Integer;
begin
 if Not( fileExists(nomefile)) then exit;
   listarighe := TStringList.Create;
   listarighe.LoadFromFile(nomefile);
   rgt :=0;
   nFam := StrToInt(listarighe[rgt]);    inc(rgt);
//   showmessage(listarighe[0]);
   for k := 1 to nfam do
    begin
     inc(rgt); // Family
     locFam := TFamiglia.Create;  listaFamiglie.Add(locFam);
     if listarighe[rgt]='1' then locFam.associato:=true else locFam.associato:=false;
     inc(rgt); // associato
     locFam.valAssociazione := listarighe[rgt]; inc(rgt);
     locFam.codfamily := listarighe[rgt]; inc(rgt);
     locFam.Toponimo  := listarighe[rgt]; inc(rgt);
     locFam.Indirizzo := listarighe[rgt]; inc(rgt);
     locFam.civico    := listarighe[rgt]; inc(rgt);
     locFam.Foglio    := listarighe[rgt]; inc(rgt);
     locFam.Particella:= listarighe[rgt]; inc(rgt);
     locFam.Subalterno:= listarighe[rgt]; inc(rgt);
     locFam.Categoria := listarighe[rgt]; inc(rgt);
     locFam.primacasa := listarighe[rgt]; inc(rgt);
     locnumfam        := StrToInt(listarighe[rgt]);    inc(rgt);
      for j:= 1 to locnumfam do
       begin
        locRes := TResidente.Create;
        locFam.ListaFamiglia.Add(locres);   listaResidenti.Add(locres);
        locRes.famer := locFam;
        inc(rgt); // Residente
        locRes.Cognome := listarighe[rgt]; inc(rgt);
        locRes.Nome    := listarighe[rgt]; inc(rgt);
        locRes.CF      := listarighe[rgt]; inc(rgt);
        locRes.nascita := listarighe[rgt]; inc(rgt);
       end;
    end;
   listarighe.Free;
 caricata := true;
end;

procedure   TAnagrafe.Salva(nomefile : String);
var F : TextFile;
    nfam : Integer;
    k,j : Integer;
    locfam : TFamiglia;
    locres : TResidente;
    loctares : TTares;
begin
 assignFile(F,nomefile); rewrite(F);
  nfam := listaFamiglie.count;
  writeln(F,nfam);
  for k:= 0 to nfam-1 do
   begin
    locfam:= listaFamiglie.Items[k];
    writeln(F,'FAMIGLIA');
    if locfam.associato then writeln(F,'1') else  writeln(F,'0');
    writeln(F,locfam.valAssociazione);
    writeln(F,locfam.codfamily);
    writeln(F,locfam.Toponimo);
    writeln(F,locfam.Indirizzo);
    writeln(F,locfam.civico);
    writeln(F,locfam.Foglio);
    writeln(F,locfam.Particella);
    writeln(F,locfam.Subalterno);
    writeln(F,locfam.Categoria);
    writeln(F,locfam.primacasa);
    writeln(F,locfam.ListaFamiglia.count);
    for j:= 0 to locfam.ListaFamiglia.count-1 do
     begin
      locres:=locfam.ListaFamiglia.items[j];
      writeln(F,'RESIDENTE');
      writeln(F,locRes.Cognome);
      writeln(F,locRes.Nome   );
      writeln(F,locRes.CF     );
      writeln(F,locRes.nascita);
     end;


   end;
 closefile(F);
end;



procedure   TAnagrafe.filtraFgPartSub ( fg,part,sub : String);
var K , j : Integer;
    locfam : TFamiglia;
    locres : TResidente;
begin
 listaFamiglieFiltrata.Clear;
 listaResidentiFiltrata.Clear;

 for k:=0 to listaFamiglie.Count-1 do
  begin
   locfam := listaFamiglie.items[k];
   if ((locfam.Foglio=fg) and (locfam.Particella=part) and (locfam.Subalterno =sub) ) then
    begin
     for j:=0 to locfam.ListaFamiglia.Count-1 do
      begin
       locres := locfam.ListaFamiglia.items[j];
       listaResidentiFiltrata.Add(locres);
      end;
    end;
  end;
end;


procedure   TAnagrafe.filtraFam1casaFgPartSub ( fg,part,sub : String);
var K , j : Integer;
    locfam : TFamiglia;
begin
 listafamigliePrimaCasa.Clear;
 for k:=0 to listaFamiglie.Count-1 do
  begin
   locfam := listaFamiglie.items[k];
   if ((locfam.Foglio=fg) and (locfam.Particella=part) and (locfam.Subalterno =sub) ) then
    begin
     listafamigliePrimaCasa.Add(locfam);
    end;
  end;
end;

function   TAnagrafe.FamigliaDaCodice(code : String): TFamiglia;
var K , j : Integer;
    locfam : TFamiglia;
    resulta : TFamiglia;
begin
 resulta := nil;
 for k:=0 to listaFamiglie.Count-1 do
  begin
   locfam := listaFamiglie.items[k];
   if locfam.codfamily = code then resulta := locfam;
  end;
  result := resulta;
end;



procedure  TAnagrafe.riordinaModo(modo: Integer);
var PassaListaFam ,PassaListaRes : TList;
    k,j,loK,loJ : Integer;
    locfam,famComp : TFamiglia;
    locres,rescomp : Tresidente;
    coda1,coda2 : Integer;
    locint1,locint2 : Integer;

    fgInt1,fgInt2 : Integer;
    fgPart1,fgPart2 : Integer;
    fgSub1,fgSub2 : Integer;
    c1,c2 : String;
begin
 PassaListaFam := TList.Create;
 PassaListaRes := TList.Create;

   for k:=0 to listaFamiglie.count-1 do
    begin
     locfam:=listaFamiglie.items[k];
     locres := locfam.ListaFamiglia.Items[0];
     loJ :=PassaListaFam.count;
      for j:=0 to PassaListaFam.count-1 do
       begin
        famComp:=PassaListaFam.items[j];
        resComp := famComp.ListaFamiglia.Items[0];
        case modo of
         0 : begin  //     cod fam
           if locfam.codfamily >=famComp.codfamily then continue;
           loJ:=j;  break;
         end;
         1 : begin  //     1 COGNOME
           if locres.Cognome>resComp.Cognome then continue;
           if locres.Cognome=resComp.Cognome then
            begin
             if locres.Nome>=resComp.Nome then continue;
            end;
           loJ:=j;  break;
         end;
         2 : begin  //     NOME
           if locres.Nome>resComp.Nome then continue;
           if locres.Nome=resComp.Nome then
            begin
             if locres.Cognome>=resComp.Cognome then continue;
            end;
           loJ:=j;  break;
         end;
         3 : begin  //     TOPO
           if locfam.Toponimo>famComp.Toponimo then continue;
           if locfam.Toponimo=famComp.Toponimo then
            begin
             if locfam.Indirizzo>famComp.indirizzo then continue;
             if locfam.Indirizzo=famComp.indirizzo then
              begin
               if locfam.civico>=famComp.civico then continue;
              end;
            end;
           loJ:=j;  break;
         end;
         4 : begin  //     VIA
           if locfam.Indirizzo > famComp.Indirizzo then continue;
           if locfam.Indirizzo = famComp.Indirizzo then
            begin
               if locfam.civico>=famComp.civico then continue;
            end;
           loJ:=j;  break;
         end;
         5 : begin  //     civico
          val (locfam.civico,locint1,coda1);
          val (famComp.civico,locint2,coda2);
          if ((coda1=0) and (coda2=0)) then begin
           if locint1>=locint2 then continue;
          end
           else
          begin
            if uppercase(locfam.civico)='SNC'  then c1 := '' else c1 := locfam.civico;
            if uppercase(famComp.civico)='SNC' then c2 := '' else c2 := famComp.civico;
           if c1>=c2 then continue;
          end;
           loJ:=j;  break;
         end;
         6 : begin  //     casa conosciuta
           if locfam.associato>=famComp.associato then continue;
           loJ:=j;  break;
         end;
         7 : begin  //     Num Fam
           if locfam.ListaFamiglia.Count >=famComp.ListaFamiglia.Count then continue;
           loJ:=j;  break;
         end;
         8,9 : begin  //
           if locfam.associato >=famComp.associato then continue;
           loJ:=j;  break;
         end;
         10 : begin  //     Possessi
           if locfam.ListaPossessi.Count>= famComp.ListaPossessi.Count then continue;
           loJ:=j;  break;
         end;
         11 : begin  //     IMU
           if locfam.ListaImu.Count>= famComp.ListaImu.Count then continue;
           loJ:=j;  break;
         end;
         12 : begin  //     Tares
           if locfam.ListaTares.Count>= famComp.ListaTares.Count then continue;
           loJ:=j;  break;
         end;

         13 : begin  //     CF
           if locres.CF >=resComp.CF then continue;
           loJ:=j;  break;
         end;
         14,15,16 : begin  //    fg, part sub
           if locfam.Foglio=''  then fgInt1 := 0 else fgInt1 := StrToInt(locfam.Foglio);
           if famComp.Foglio='' then fgInt2 := 0 else fgInt2 := StrToInt(famComp.Foglio);
           if fgInt1>fgInt2 then continue;
           if fgInt1=fgInt2 then
            begin
              val(locfam.Particella,fgPart1,coda1);
              if coda1=0 then
               begin
                val(famComp.Particella,fgPart2,coda2);
                if coda2=0 then
                 begin
                  if fgPart1>fgPart2 then continue;
                  if fgPart1=fgPart2 then
                   begin
                     val(locfam.Subalterno,fgSub1,coda1);
                     val(famComp.Subalterno,fgSub2,coda2);
                     if ((coda1=0) and (coda2=0)) then
                       begin
                        if fgSub1>fgSub2 then continue;
                       end;
                   end;
                 end;

               end
             else
              begin
               if (locfam.Particella>famComp.Particella) then continue;
              end;
            end;
           loJ:=j;  break;
         end;


         else begin end; // loj:=J;
        end;
       end;
     PassaListaFam.Insert(loJ,locfam);
    end;

   listaFamiglie.clear;
   for k:=0 to PassaListaFam.count-1 do
    begin locfam:=PassaListaFam.items[k]; listaFamiglie.add(locfam); end;

   ///////////////  ora i residenti

   for k:=0 to listaResidenti.count-1 do
    begin
     locres := listaResidenti.items[k];
     locfam := locres.famer;
     loJ :=PassaListaRes.count;
      for j:=0 to PassaListaRes.count-1 do
       begin
        resComp := PassaListaRes.items[j];
        famComp := resComp.famer;
        case modo of
         0 : begin  //     cod fam
           if locfam.codfamily >=famComp.codfamily then continue;
           loJ:=j;  break;
         end;
         1 : begin  //     1 COGNOME
           if locres.Cognome>resComp.Cognome then continue;
           if locres.Cognome=resComp.Cognome then
            begin
             if locres.Nome>=resComp.Nome then continue;
            end;
           loJ:=j;  break;
         end;
         2 : begin  //     NOME
           if locres.Nome>resComp.Nome then continue;
           if locres.Nome=resComp.Nome then
            begin
             if locres.Cognome>=resComp.Cognome then continue;
            end;
           loJ:=j;  break;
         end;
         3 : begin  //     TOPO
           if locfam.Toponimo>famComp.Toponimo then continue;
           if locfam.Toponimo=famComp.Toponimo then
            begin
             if locfam.Indirizzo>famComp.indirizzo then continue;
             if locfam.Indirizzo=famComp.indirizzo then
              begin
               if locfam.civico>=famComp.civico then continue;
              end;
            end;
           loJ:=j;  break;
         end;
         4 : begin  //     VIA
           if locfam.Indirizzo > famComp.Indirizzo then continue;
           if locfam.Indirizzo = famComp.Indirizzo then
            begin
               if locfam.civico>=famComp.civico then continue;
            end;
           loJ:=j;  break;
         end;
         5 : begin  //     civico
          val (locfam.civico,locint1,coda1);
          val (famComp.civico,locint2,coda2);
          if ((coda1=0) and (coda2=0)) then begin
           if locint1>=locint2 then continue;
          end
           else
          begin
           if locfam.civico>=famComp.civico then continue;
          end;
           loJ:=j;  break;
         end;
        6 : begin  //     casa conosciuta
           if locfam.associato>=famComp.associato then continue;
           loJ:=j;  break;
         end;
         7 : begin  //     Num Fam
           if locfam.ListaFamiglia.Count >=famComp.ListaFamiglia.Count then continue;
           loJ:=j;  break;
         end;
         8,9 : begin  //
           if locfam.associato >=famComp.associato then continue;
           loJ:=j;  break;
         end;
         10 : begin  //     Possessi
           if locfam.ListaPossessi.Count>= famComp.ListaPossessi.Count then continue;
           loJ:=j;  break;
         end;
         11 : begin  //     IMU
           if locfam.ListaImu.Count>= famComp.ListaImu.Count then continue;
           loJ:=j;  break;
         end;
         12 : begin  //     Tares
           if locfam.ListaTares.Count>= famComp.ListaTares.Count then continue;
           loJ:=j;  break;
         end;

         13 : begin  //     CF
           if locres.CF >=resComp.CF then continue;
           loJ:=j;  break;
         end;
         14,15,16 : begin  //    fg, part sub
           if locfam.Foglio=''  then fgInt1 := 0 else fgInt1 := StrToInt(locfam.Foglio);
           if famComp.Foglio='' then fgInt2 := 0 else fgInt2 := StrToInt(famComp.Foglio);
           if fgInt1>fgInt2 then continue;
           if fgInt1=fgInt2 then
            begin
              val(locfam.Particella,fgPart1,coda1);
              if coda1=0 then
               begin
                val(famComp.Particella,fgPart2,coda2);
                if coda2=0 then
                 begin
                  if fgPart1>fgPart2 then continue;
                  if fgPart1=fgPart2 then
                   begin
                     val(locfam.Subalterno,fgSub1,coda1);
                     val(famComp.Subalterno,fgSub2,coda2);
                     if ((coda1=0) and (coda2=0)) then
                       begin
                        if fgSub1>fgSub2 then continue;
                       end;
                   end;
                 end;

               end
             else
              begin
               if (locfam.Particella>famComp.Particella) then continue;
              end;
            end;
           loJ:=j;  break;
         end;

         else begin end; // loj:=J;
        end;
       end;
     PassaListaRes.Insert(loJ,locres);
    end;
   listaResidenti.clear;
   for k:=0 to PassaListaRes.count-1 do
    begin locres:=PassaListaRes.items[k]; listaResidenti.add(locres); end;
//////////////
 PassaListaFam.clear; PassaListaFam.Free;
 PassaListaRes.clear; PassaListaRes.Free;
end;


procedure  TAnagrafe.faifamiglieedificio(_fg,_part : String);
var K , j : Integer;
    locfam : TFamiglia;
begin
 listafameigliedificio.clear;
 for k:=0 to listaFamiglie.Count-1 do
  begin
   locfam := listaFamiglie.items[k];
   if ((locfam.Foglio=_fg) and (locfam.Particella=_part) ) then listafameigliedificio.Add(locfam);
  end;

end;

end.
