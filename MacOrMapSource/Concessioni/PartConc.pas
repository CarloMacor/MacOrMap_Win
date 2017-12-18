unit PartConc;

interface

uses windows,classes, sysutils;

type
 TPartConc = class
   idparticella : String;
   idcontratto  : String;
   Fg           : String;
   Part         : String;
   MioPart      : String;
   Sup          : String;
   categoria    : String;
   classe       : String;
   loctributo   : String;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   salva (ST : TStringList);
   procedure   apri  (ST : TStringList);
  end;


var PartConcessioneCorrente : TPartConc;

implementation

Constructor TPartConc.Create;
begin
end;

Destructor  TPartConc.Done;
begin
end;

procedure  TPartConc.salva (ST : TStringList);
var k : Integer;
begin
 ST.Add('PARTICELLA');
 ST.Add('idparticella');           ST.Add(idparticella);
 ST.Add('idcontratto');            ST.Add(idcontratto);
 ST.Add('Fg');                     ST.Add(Fg);
 ST.Add('Part');                   ST.Add(Part);
 ST.Add('MioPart');                ST.Add(MioPart);
 ST.Add('Sup');                    ST.Add(Sup);
 ST.Add('categoria');              ST.Add(categoria);
 ST.Add('classe');                 ST.Add(classe);
 ST.Add('loctributo');             ST.Add(loctributo);
end;


procedure  TPartConc.apri  (ST : TStringList);
var nrcont,nrtrib,k : Integer;
begin
 ST.Delete(0); // ST.Add('PARTICELLA');
 ST.Delete(0); // ST.Add('idparticella');
 idparticella     := ST.Strings[0];               ST.Delete(0);
 ST.Delete(0); // ST.Add('idcontratto');
 idcontratto      := ST.Strings[0];               ST.Delete(0);
 ST.Delete(0); // ST.Add('Fg');
 Fg               := ST.Strings[0];               ST.Delete(0);
 ST.Delete(0); // ST.Add('Part');
 Part             := ST.Strings[0];               ST.Delete(0);
 ST.Delete(0); // ST.Add('MioPart');
 MioPart          := ST.Strings[0];               ST.Delete(0);
 ST.Delete(0); // ST.Add('Sup');
 Sup              := ST.Strings[0];               ST.Delete(0);
 ST.Delete(0); // ST.Add('categoria');
 categoria        := ST.Strings[0];               ST.Delete(0);
 ST.Delete(0); // ST.Add('classe');
 classe           := ST.Strings[0];               ST.Delete(0);
 ST.Delete(0); // ST.Add('loctributo');
 loctributo       := ST.Strings[0];               ST.Delete(0);
end;



end.
