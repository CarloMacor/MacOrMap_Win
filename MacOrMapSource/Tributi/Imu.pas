unit Imu;

interface

type
 TImu = class
   associato       : Boolean;
   indice          : String;
   Cognome         : String;
   Nome            : String;
   CFIVA           : String;
   Foglio          : String;
   Particella      : String;
   Subalterno      : String;
   Categoria       : String;
   Indirizzo       : String;
   DataIscStr      : String;
   MqImuStr        : String;
   RenditaStr        : String;
   ValoreStr        : String;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   function    inIndirizzo(seIndi : String) : Boolean;

 end;

implementation

uses sysutils;


Constructor TImu.Create;
begin
 associato := false;
end;

Destructor  TImu.Done;
begin
end;

function TImu.inIndirizzo(seIndi : String) : Boolean;
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
