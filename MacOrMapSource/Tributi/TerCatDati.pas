unit TerCatDati;

interface

uses System.classes ,System.SysUtils ,vcl.dialogs  ;

type
 TTerCatDati = class
   codiceamministrativo   : String;
   sezione                : string;
   IdentificativoImmobile : String;
   Foglio          : String;
   Particella      : String;
   Subalterno      : String;
   Edificabile     : String;
   Qualita         : String;
   QualitaCod      : String;
   Classe          : String;
   RenditaAgrariaStrEuro     : String;
   RenditaDomenicaleStrEuro  : String;
   Superficie      : Integer;
   ettari          : String;
   are             : String;
   centiare        : String;
   ICI_paganti     : TList;
   TARES_paganti   : TList;
   Possessi        : TList;
   toErase         : Boolean;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   function OrdineFgPart(TerComp : TTerCatDati)        : Integer;
   function OrdineQualita(TerComp : TTerCatDati)       : Integer;
   function OrdineClasse(TerComp : TTerCatDati)        : Integer;
   function OrdineSuperficie(TerComp : TTerCatDati)    : Integer;
   function OrdineAgraria(TerComp : TTerCatDati)       : Integer;
   function OrdineDomenicale(TerComp : TTerCatDati)    : Integer;


 end;


var TerCatDatiCorrente : TTerCatDati;


implementation

Constructor TTerCatDati.Create;
begin
   Possessi        := TList.Create;
   ICI_paganti     := TList.Create;
   TARES_paganti   := TList.Create;
   toErase         := false;
end;

Destructor  TTerCatDati.Done;
begin
end;

function TTerCatDati.OrdineFgPart(TerComp : TTerCatDati) : Integer;
var resulta : Integer;
    fgInt1,fgInt2 : Integer;
    fgPart1,fgPart2 : Integer;
    fgSub1,fgSub2 : Integer;
    coda,coda2 : Integer;
begin
 resulta :=0;
 fgInt1 := StrToInt(self.Foglio);
 fgInt2 := StrToInt(TerComp.Foglio);
 if fgInt1>fgInt2 then resulta := 1;
 if fgInt1=fgInt2 then
  begin
    val(self.Particella,fgPart1,coda);
    if coda=0 then
     begin
      val(TerComp.Particella,fgPart2,coda);
      if coda=0 then
       begin
        if fgPart1>fgPart2 then resulta := 1;
        if fgPart1=fgPart2 then
         begin
          val(self.Subalterno,fgSub1,coda);
          val(TerComp.Subalterno,fgSub2,coda2);
          if ((coda=0) and (coda2=0)) then
           begin
            if fgSub1>fgSub2 then resulta := 1;
           end;
         end;
       end;
     end
      else
     begin
      if (self.Particella>TerComp.Particella) then resulta := 1;
     end;
  end;
 result := resulta;
end;

function TTerCatDati.OrdineQualita(TerComp : TTerCatDati) : Integer;
var resulta : Integer;
begin
 resulta :=0;
 if (self.Qualita>=TerComp.Qualita) then resulta := 1;
 result := resulta;
end;

function TTerCatDati.OrdineClasse(TerComp : TTerCatDati) : Integer;
var resulta : Integer;
begin
 resulta :=0;
 if (self.Classe>=TerComp.Classe) then resulta := 1;
 result := resulta;
end;

function TTerCatDati.OrdineSuperficie(TerComp : TTerCatDati)    : Integer;
var resulta : Integer;
begin
 resulta :=0;
 if (self.Superficie>=TerComp.Superficie) then resulta := 1;
 result := resulta;
end;


function TTerCatDati.OrdineAgraria(TerComp : TTerCatDati)       : Integer;
var resulta : Integer;
    V1,V2 : Real;
    coda1,coda2 : Integer;
    formatSettings : TFormatSettings;
begin
 resulta :=0;
 val(self.RenditaAgrariaStrEuro,V1,coda1);
 val(TerComp.RenditaAgrariaStrEuro,V2,coda2);
 if ((coda1=0) and (coda2=0)) then
  begin
   if (V1>=V2) then resulta := 1;
  end;
 result := resulta;
end;


function TTerCatDati.OrdineDomenicale(TerComp : TTerCatDati)    : Integer;
var resulta : Integer;
    V1,V2 : Real;
    coda1,coda2 : Integer;
begin
 resulta :=0;
 val(self.RenditaDomenicaleStrEuro,V1,coda1);
 val(TerComp.RenditaDomenicaleStrEuro,V2,coda2);
 if ((coda1=0) and (coda2=0)) then
  begin
   if (V1>=V2) then resulta := 1;
  end;
 result := resulta;
end;


end.
