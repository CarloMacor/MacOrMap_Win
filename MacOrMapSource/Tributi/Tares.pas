unit Tares;

interface

type
 TTares = class
   associato       : Boolean;
   indice          : String;
   Cognome         : String;
   Nome            : String;
   CFIVA           : String;
   Indirizzo       : String;
   Foglio          : String;
   Particella      : String;
   Subalterno      : String;
   Categoria       : String;
   DataIscStr      : String;
   MqTarsuStr      : String;
   MqCatacStr      : String;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   function inIndirizzo(seIndi : String) : Boolean;
 end;

implementation

 uses sysutils, vcl.dialogs;

Constructor TTares.Create;
begin
 associato := false;
end;

Destructor  TTares.Done;
begin
end;

function TTares.inIndirizzo(seIndi : String) : Boolean;
var resulta : Boolean;
begin
//  showmessage('-'+seIndi+'-');
 resulta := false;
 if (Pos ('GIUGNO',seindi)>0) then
  begin
   if (Pos ('GIUGNO',uppercase(Indirizzo))>0) then resulta:=true;
  end;

 if Pos( uppercase(seIndi),uppercase(Indirizzo))>0 then
  begin
   resulta := true;
  end;



 result := resulta;
end;


end.
