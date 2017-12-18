unit FabCatDati;

interface

uses System.classes,System.SysUtils  ;

type
 TFabCatDati = class
   codiceamministrativo   : String;
   sezione                : string;
   IdentificativoImmobile : String;
   Foglio          : String;
   Particella      : String;
   Subalterno      : String;
   Foglio2         : String;
   Particella2     : String;
   Subalterno2     : String;
   Categoria       : String;
   Classe          : String;
   Consistenza     : String;
   superficie      : String;
   RenditaStrEuro  : String;
   codicestrada    : String;
   PrimaAbitazione0123 : String; // 0 non so 1 1° casa oppure 2 2° casa 3 = affittata
   Topo_Catastale  : String;
   Topo_Anagrafe   : String;
   Topo_Corretta   : String;
   Via_Catastale   : String;
   Via_Anagrafe    : String;
   Via_Corretta    : String;
   Civico_Catastale: String;
   Civico_Anagrafe : String;
   Civico_Corretta : String;
   piano           : String;
   Interno         : String;
   ICI_paganti     : TList;
   TARES_paganti   : TList;
   Residenti       : TList;
   Possessi        : TList;
   toErase         : Boolean;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   function iscasa : Boolean;
   function OrdineFgPartSub(fabComp : TFabCatDati) : Integer;
   function OrdineCategoria(fabComp : TFabCatDati) : Integer;
 end;


var FabCatDatiCorrente : TFabCatDati;

implementation

Constructor TFabCatDati.Create;
begin
   ICI_paganti     := TList.Create;
   TARES_paganti   := TList.Create;
   Residenti       := TList.Create;
   Possessi        := TList.Create;
   toErase         := false;
end;

Destructor  TFabCatDati.Done;
begin
end;

function TFabCatDati.iscasa : Boolean;
var resulta : Boolean;
begin
 resulta := false;
  if Categoria[1] = 'A' then resulta :=true;
 result := resulta;
end;

function TFabCatDati.OrdineFgPartSub(fabComp : TFabCatDati) : Integer;
var resulta : Integer;
    fgInt1,fgInt2 : Integer;
    fgPart1,fgPart2 : Integer;
    fgSub1,fgSub2 : Integer;
    coda,coda2 : Integer;
begin
 resulta :=0;
 fgInt1 := StrToInt(self.Foglio);
 fgInt2 := StrToInt(fabComp.Foglio);
 if fgInt1>fgInt2 then resulta := 1;
 if fgInt1=fgInt2 then
  begin
    val(self.Particella,fgPart1,coda);
    if coda=0 then
     begin
      val(fabComp.Particella,fgPart2,coda);
      if coda=0 then
       begin
        if fgPart1>fgPart2 then resulta := 1;
        if fgPart1=fgPart2 then
         begin
          val(self.Subalterno,fgSub1,coda);
          val(fabComp.Subalterno,fgSub2,coda2);
          if ((coda=0) and (coda2=0)) then
           begin
            if fgSub1>fgSub2 then resulta := 1;
           end;
         end;
       end;
     end
      else
     begin
      if (self.Particella>fabComp.Particella) then resulta := 1;
     end;
  end;
 result := resulta;
end;

function TFabCatDati.OrdineCategoria(fabComp : TFabCatDati) : Integer;
var resulta : Integer;
begin
 resulta :=0;
 if (self.Categoria>=fabComp.Categoria) then resulta := 1;
 result := resulta;
end;


end.


