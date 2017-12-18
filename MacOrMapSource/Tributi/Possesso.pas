unit Possesso;

interface

uses  System.classes  ;

type
 TPossesso = class
 IdPossesso             : String;
 CodiceAmministrativo   : String;
 Sezione                : String;
 IdentificativoSoggetto : String;
 TipoSoggetto           : String;
 IdentificativoImmobile : String;
 TipoImmobile           : String;
 CodiceDiritto          : String;
 TitoloNonCodificato    : String;
 QuotaNumeratore        : String;
 QuotaDenominatore      : String;
 Regime                 : String;
 IdSoggettoRiferimento  : String;
 DatavaliditaStr        : String;
 toerase                : Boolean;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
 end;

implementation


Constructor TPossesso.Create;
begin
 toerase := false;
end;

Destructor  TPossesso.Done;
begin
end;
end.
