unit proprietario;

interface

uses Soggetto, System.classes ,possesso ;

type
 TProprietario = class
   IlSoggetto    : TSoggetto;
   ListaPossessi : TList;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
 end;

implementation


Constructor TProprietario.Create;
begin
 ListaPossessi := TList.Create;
end;

Destructor  TProprietario.Done;
begin
end;




end.


