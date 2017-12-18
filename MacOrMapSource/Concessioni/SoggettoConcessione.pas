unit SoggettoConcessione;

interface

uses windows,classes, disegnoV, sysutils;

type
 TSoggettoConcessione = class
   id              : string;
   descrizione     : String;
   CFIVA           : String;
   elencoContratti : TList;
   elencoTributi   : TList;
   Constructor Create;        virtual;
   Destructor  Done;          virtual;
   procedure   salva (ST : TStringList);
   procedure   apri  (ST : TStringList);
 end;

var SoggettoConcessionarioCorrente : TSoggettoConcessione;

implementation

uses ContrattoConcessione;

Constructor TSoggettoConcessione.Create;
begin
 elencoContratti := TList.Create;
 elencoTributi   := TList.Create;
end;

Destructor  TSoggettoConcessione.Done;
begin
end;

procedure  TSoggettoConcessione.salva (ST : TStringList);
var k : Integer;
    locContratto : TContrattoConcessione;
begin
 ST.Add('SOGGETTO');
 ST.Add('Id');
 ST.Add(Id);
 ST.Add('descrizione');
 ST.Add(descrizione);
 ST.Add('CFIVA');
 ST.Add(CFIVA);
 ST.Add('nrcontratti');
 ST.Add(IntToStr(elencoContratti.Count));
  for k:=0 to elencoContratti.Count-1 do
   begin
    locContratto := elencoContratti.items[k];
    locContratto.salva(ST);
   end;
 ST.Add('nrtributi');
 ST.Add(IntToStr(elencoTributi.Count));
end;


procedure  TSoggettoConcessione.apri  (ST : TStringList);
var nrcont,nrtrib,k : Integer;
    locContratto : TContrattoConcessione;
begin
 ST.Delete(0); // ST.Add('SOGGETTO');
 ST.Delete(0); // ST.Add('Id');
 id := ST.Strings[0];  ST.Delete(0);
 ST.Delete(0); // ST.Add('descrizione');
 descrizione := ST.Strings[0];  ST.Delete(0);
 ST.Delete(0); // ST.Add('CFIVA');
 CFIVA       := ST.Strings[0];  ST.Delete(0);
 ST.Delete(0); // ST.Add('nrcontratti');
 nrcont      := StrToInt(ST.Strings[0]);  ST.Delete(0);
  for k:=1 to nrcont do
   begin
     locContratto := TContrattoConcessione.Create;
     elencoContratti.Add(locContratto);
     locContratto.apri(ST);
   end;

 ST.Delete(0); // ST.Add('nrtributi');
 nrtrib      := StrToInt(ST.Strings[0]);  ST.Delete(0);
  for k:=1 to nrtrib do
   begin



   end;

end;


end.