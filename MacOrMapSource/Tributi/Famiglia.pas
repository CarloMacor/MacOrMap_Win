unit Famiglia;

interface

uses windows,classes;

type
 TFamiglia = class
   associato       : Boolean;
   valAssociazione : String;
   codfamily       : String;
   Toponimo        : String;
   Indirizzo       : String;
   civico          : String;
   Foglio          : String;
   Particella      : String;
   Subalterno      : String;
   Categoria       : String;
   primacasa       : String;
   ListaFamiglia   : TList;
   ListaTares      : TList;
   ListaImu        : TList;
   ListaPossessi   : TList;

   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   function infamigliaCF(CF : String) : Boolean;
 end;

var famigliacorrente : TFamiglia;


implementation

uses Residente;

Constructor TFamiglia.Create;
begin
 associato := false;
 ListaFamiglia := TList.create;
 ListaTares    := TList.create;
 ListaImu      := TList.create;
 ListaPossessi := TList.create;
end;

Destructor  TFamiglia.Done;
begin
end;

function TFamiglia.infamigliaCF(CF : String) : Boolean;
var resulta : Boolean;
    k : Integer;
    locresidente : Tresidente;
begin
 resulta := false;
 for k:=0 to Listafamiglia.Count-1 do begin
  locresidente := Listafamiglia.items[k];
  if locresidente.CF = CF then resulta := true;
 end;
 result := resulta;
end;


end.
