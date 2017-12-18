unit LeConcessioni;

interface

uses windows,classes,SoggettoConcessione,contrattoConcessione, sysutils,VCL.dialogs ;

type
 TLeConcessioni = class
   ListaContratti : TList;
   ListaSoggettiConcessioni : TList;
   ListaContrattiFiltrata : TList;
   ListaContrattiDisegniFiltrata : TList;
   ultimoIdSoggetto  : Integer;
   ultimoIdContratto : Integer;
   caricata     : Boolean;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   Apri;
   procedure   Salva;
   function    descrizioneSoggettoId(param : String) : String;
   function    descrizioneattivo(param : Integer) : String;
   function    PIvaSoggettoId(param : String) : String;
   function    contrattodaId(param : String)  : TContrattoConcessione;
   procedure   FiltraContratti(param : String);
   procedure   FiltraContrattiDisegni(param : String);
   procedure   RiordinaAlfabeticamenteSoggerri;
 end;

var ConcessioniTolfa : TLeConcessioni;

implementation

uses varbase;


Constructor TLeConcessioni.Create;
begin
 ListaContratti             := TList.Create;
 ListaSoggettiConcessioni   := TList.Create;
 ListaContrattiFiltrata     := TList.Create;
 ListaContrattiDisegniFiltrata := TList.Create;
 caricata                   := false;
 ultimoIdSoggetto           := 0;
 ultimoIdContratto          := 0;
end;

Destructor  TLeConcessioni.Done;
begin
end;


function    TLeConcessioni.contrattodaId(param : String)  : TContrattoConcessione;
var resulta : TContrattoConcessione;
   k : Integer;
   loccontratto  : TContrattoConcessione;
begin
 resulta := nil;
 for k:=0 to ListaContratti.Count-1 do
  begin
   loccontratto := ListaContratti.Items[k];
   if (loccontratto.idcontratto = param) then
    begin
      resulta := loccontratto;
    end;
  end;
 result := resulta;
end;


procedure   TLeConcessioni.Apri;
var locsoggetto  : TSoggettoConcessione;
    loccontratto : TContrattoConcessione;
    ST : TStringList;
    nrsog : Integer;
    k,j : Integer;
begin
 if not FileExists(NomeFileSoggettiConcessioni) then exit;

 caricata := true;
 ST := TStringList.Create;
 ST.LoadFromFile(NomeFileSoggettiConcessioni);
 if ST.Count>0 then
  begin
   ST.Delete(0); // ultimoIdSoggetto
   ultimoIdSoggetto:=StrToInt(ST.Strings[0]); ST.Delete(0);
   ST.Delete(0); // ultimoIdContratto
   ultimoIdContratto:=StrToInt(ST.Strings[0]); ST.Delete(0);
   ST.Delete(0); // numero dei concessonari info string
   nrsog:=StrToInt(ST.Strings[0]); ST.Delete(0);

   for k:=1 to nrsog do
    begin
     locsoggetto := TSoggettoConcessione.Create;
     ListaSoggettiConcessioni.Add(locsoggetto);
     locsoggetto.apri(ST);

     for j:=0 to locsoggetto.elencoContratti.Count-1 do
      begin
       loccontratto := locsoggetto.elencoContratti.items[j];
       ListaContratti.Add(loccontratto);
      end;

    end;
  end;
 ST.Free;
end;

procedure   TLeConcessioni.Salva;
var ST : TStringList;
    k : Integer;
    locsoggetto  : TSoggettoConcessione;
begin
 ST := TStringList.Create;
  ST.Add('ultimoIdSoggetto');  ST.Add(IntToStr(ultimoIdSoggetto));
  ST.Add('ultimoIdContratto'); ST.Add(IntToStr(ultimoIdContratto));
  ST.Add('Num Concessionari');
  ST.Add(IntToStr(ListaSoggettiConcessioni.Count));
  for k:=0 to ListaSoggettiConcessioni.Count-1 do
   begin
    locsoggetto := ListaSoggettiConcessioni.Items[k];
    locsoggetto.salva(ST);
   end;

  ST.SaveToFile(NomeFileSoggettiConcessioni);
 ST.Free;
end;


function    TLeConcessioni.descrizioneSoggettoId(param : String) : String;
var resulta : String;
    k : Integer;
    locsoggetto  : TSoggettoConcessione;
begin
 resulta :='';
 for k:=0 to ListaSoggettiConcessioni.Count-1 do
  begin
   locsoggetto := ListaSoggettiConcessioni.Items[k];
   if (locsoggetto.id = param) then
    begin
      resulta := locsoggetto.descrizione;
    end;
  end;
 result := resulta;
end;

function  TLeConcessioni.descrizioneattivo(param : Integer) : String;
var resulta : String;
begin
 resulta :='';
  if param = 0 then resulta := 'Attivo';
  if param = 1 then resulta := 'Disattivo';
 result := resulta;
end;


function  TLeConcessioni.PIvaSoggettoId(param : String) : String;
var resulta : String;
    k : Integer;
    locsoggetto  : TSoggettoConcessione;
begin
 resulta :='';
 for k:=0 to ListaSoggettiConcessioni.Count-1 do
  begin
   locsoggetto := ListaSoggettiConcessioni.Items[k];
   if (locsoggetto.id = param) then
    begin
      resulta := locsoggetto.CFIVA;
    end;
  end;
 result := resulta;
end;


procedure  TLeConcessioni.FiltraContratti(param : String);
var k : Integer;
    loccontratto  : TContrattoConcessione;
begin
 ListaContrattiFiltrata.Clear;
 for k:=0 to ListaContratti.Count-1 do
  begin
   loccontratto := ListaContratti.Items[k];
   if (loccontratto.idConcessonario = param) then
    begin
     ListaContrattiFiltrata.Add(loccontratto);
    end;
  end;
end;

procedure  TLeConcessioni.FiltraContrattiDisegni(param : String);
var k : Integer;
    loccontratto  : TContrattoConcessione;
begin
 ListaContrattiDisegniFiltrata.Clear;
 for k:=0 to ListaContratti.Count-1 do
  begin
   loccontratto := ListaContratti.Items[k];
   if (loccontratto.idConcessonario = param) then
    begin
     ListaContrattiDisegniFiltrata.Add(loccontratto);
    end;
  end;
end;


procedure  TLeConcessioni.RiordinaAlfabeticamenteSoggerri;
var passaLista : TList;
    k, j, indo : integer;
    locsoggetto , testsoggetto : TSoggettoConcessione;
begin
 passalista := TList.Create;

   locsoggetto := ListaSoggettiConcessioni.Items[0];
   passalista.Add(locsoggetto);


 for k:=1 to ListaSoggettiConcessioni.Count-1 do
  begin
   locsoggetto := ListaSoggettiConcessioni.Items[k];
     indo:=0;

       for j:=0 to passalista.Count-1 do begin
        testsoggetto := passalista.items[j];
        if (CompareStr(uppercase(locsoggetto.descrizione),Uppercase(testsoggetto.descrizione)))<0 then begin  break; end;
        indo := j+1;
       end;


    passalista.Insert(indo,locsoggetto);
  end;

 ListaSoggettiConcessioni.Clear;

   for k:=0 to passalista.Count-1 do
    begin
     locsoggetto := passalista.Items[k];
     ListaSoggettiConcessioni.Add(locsoggetto);
    end;

 passalista.Free;
end;

end.
