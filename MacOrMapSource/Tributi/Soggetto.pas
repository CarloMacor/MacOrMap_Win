unit Soggetto;

interface

uses windows,classes,famiglia;

type
 TSoggetto = class
  CodiceAmministrativo : String;
  Sezione              : String;
  Identificativo       : String;
  TipoSoggetto         : String;
  Cognome              : String;
  Nome                 : String;
  CodSesso             : String;
  DataNascitaStr       : String;
  LuogoNascita         : String;
  CodiceFiscale        : String;
  DenominazioneAzienda : String;
  CodiceSedeAzienda    : String;
  CFAzienda            : String;
  nrpossessi           : Integer;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
 end;


implementation

Constructor TSoggetto.Create;
begin
 nrpossessi :=0;
end;

Destructor  TSoggetto.Done;
begin
end;

end.
