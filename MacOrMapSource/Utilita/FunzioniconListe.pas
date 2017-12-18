unit FunzioniconListe;

interface

uses classes, windows, sysutils, soggetto;

function soggettodaId(idsog : String; ListaRicerca:TList) : TSoggetto;


implementation


uses vcl.dialogs;

function soggettodaId(idsog : String; ListaRicerca:TList) : TSoggetto;
var resulta : Tsoggetto;
    k : integer;
    locsog    :  TSoggetto;
begin
 resulta := nil;
// showmessage(idsog);
// showmessage(IntToStr(ListaRicerca.count));
 for k:=0 to ListaRicerca.count-1 do
  begin
   locsog := ListaRicerca.items[k];
   if locsog.Identificativo = idsog then begin resulta := locsog;  break; end;
  end;
 result := resulta;
end;


end.
