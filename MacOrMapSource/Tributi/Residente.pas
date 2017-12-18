unit Residente;

interface

uses windows,classes,famiglia;

type
 TResidente = class
   Cognome         : String;
   Nome            : String;
   Famiglia        : String;
   CF              : String;
   famer           : Tfamiglia;
   nascita         : String;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
 end;


implementation

Constructor TResidente.Create;
begin
end;

Destructor  TResidente.Done;
begin
end;




end.
