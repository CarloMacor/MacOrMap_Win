unit ContrattoConcessione;

interface

uses windows,classes, sysutils;

type
 TContrattoConcessione = class
   idcontratto : String;
   idConcessonario : String;
   attivo           : Integer;
   tributo          : String;
   datadecorrenza   : String;
   datascadenza     : String;
   datadelibera     : String;
   rifDelibera      : String;
   rifLegge         : String;
   datacontratto    : String;
   infocontratto    : String;
   superficietotale : String;
   supforfettaria   : Integer;
   ListaParteParticelle  : TList;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;

   procedure   calcolasup;

   procedure   salva (ST : TStringList);
   procedure   apri  (ST : TStringList);
 end;

 var ContrattoCorrente : TContrattoConcessione;

implementation

uses PartConc;

Constructor TContrattoConcessione.Create;
begin
 ListaParteParticelle  := TList.Create;
 attivo :=0;
 supforfettaria   :=0;
end;

Destructor  TContrattoConcessione.Done;
begin
end;


procedure  TContrattoConcessione.calcolasup;
var k : Integer;
    locPartConc : TPartConc;
    locsup : integer;
    totsup : integer;
    totsupstr : String;
begin
 totsup :=0;
 if (supforfettaria=0) then
  begin
   for k:=0 to ListaParteParticelle.Count-1 do
    begin
     locPartConc := ListaParteParticelle.items[k];
     if locPartConc.Sup<>'' then locsup := strtoint(locPartConc.Sup) else locsup:=0;
     totsup := totsup + locsup;
    end;
    totsupstr := inttostr(totsup);
    superficietotale := totsupstr;
  end;
end;


procedure  TContrattoConcessione.salva (ST : TStringList);
var k : Integer;
 locPartConc : TPartConc;
begin
 ST.Add('CONCESSIONE');
 ST.Add('idcontratto');         ST.Add(idcontratto);
 ST.Add('idConcessonario');     ST.Add(idConcessonario);
 ST.Add('attivo');              ST.Add(IntToStr(attivo));

 ST.Add('tributo');             ST.Add(tributo);
 ST.Add('datadecorrenza');      ST.Add(datadecorrenza);
 ST.Add('datascadenza');        ST.Add(datascadenza);
 ST.Add('datadelibera');        ST.Add(datadelibera);
 ST.Add('rifDelibera');         ST.Add(rifDelibera);
 ST.Add('rifLegge');            ST.Add(rifLegge);
 ST.Add('datacontratto');       ST.Add(datacontratto);
 ST.Add('infocontratto');       ST.Add(infocontratto);
 ST.Add('superficietotale');    ST.Add(superficietotale);
 ST.Add('supforfettaria');      ST.Add(IntToStr(supforfettaria));

 ST.Add('nrparticelle');
 ST.Add(IntToStr(ListaParteParticelle.Count));

  for k:=0 to ListaParteParticelle.Count-1 do
   begin
    locPartConc := ListaParteParticelle.items[k];
    locPartConc.salva(ST);
   end;

end;


procedure  TContrattoConcessione.apri  (ST : TStringList);
var nrcont,nrtrib,k : Integer;
    locPartConc : TPartConc;
begin
 ST.Delete(0); // ST.Add('CONCESSIONE');
 ST.Delete(0); // ST.Add('idcontratto');
 idcontratto     := ST.Strings[0];                ST.Delete(0);
  ST.Delete(0); // ST.Add('idConcessonario');
 idConcessonario := ST.Strings[0];                ST.Delete(0);
  ST.Delete(0); // ST.Add('attivo');
 attivo          := StrToInt(ST.Strings[0]);      ST.Delete(0);
  ST.Delete(0); // ST.Add('tributo');
 tributo     := ST.Strings[0];                ST.Delete(0);
  ST.Delete(0); // ST.Add('datadecorrenza');
 datadecorrenza     := ST.Strings[0];                ST.Delete(0);
  ST.Delete(0); // ST.Add('datascadenza');
 datascadenza     := ST.Strings[0];                ST.Delete(0);
  ST.Delete(0); // ST.Add('datadelibera');
 datadelibera     := ST.Strings[0];                ST.Delete(0);
  ST.Delete(0); // ST.Add('rifDelibera');
 rifDelibera     := ST.Strings[0];                ST.Delete(0);
  ST.Delete(0); // ST.Add('rifLegge');
 rifLegge     := ST.Strings[0];                ST.Delete(0);
  ST.Delete(0); // ST.Add('datacontratto');
 datacontratto     := ST.Strings[0];                ST.Delete(0);
  ST.Delete(0); // ST.Add('infocontratto');
 infocontratto     := ST.Strings[0];                ST.Delete(0);

  ST.Delete(0); // ST.Add('superficietotale');
 superficietotale     := ST.Strings[0];                ST.Delete(0);
  ST.Delete(0); // ST.Add('supforfettaria');
 supforfettaria     :=  StrToInt(ST.Strings[0]);                ST.Delete(0);



 ST.Delete(0); // ST.Add('nrparticelle');
 nrcont      := StrToInt(ST.Strings[0]);  ST.Delete(0);
  for k:=1 to nrcont do
   begin
     locPartConc := TPartConc.Create;
     ListaParteParticelle.Add(locPartConc);
     locPartConc.apri(ST);
   end;


end;




end.