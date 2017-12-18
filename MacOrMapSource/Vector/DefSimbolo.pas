unit DefSimbolo;

interface

uses System.classes, varbase, piano ,GR32, GR32_Image, GR32_Layers,vettoriale;

type
 TDefSimbolo = class
	 indice : Integer;
	 xc, yc : Real;
	 Listavector : TList;
   nome   : String;
	 limx1, limx2, limy1, limy2 : Real;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   disegnadef  ( HHDC : TImage32);
   procedure   faiLimiti;
 end;


var SimboloVirtuale : TDefSimbolo;

implementation

Constructor TDefSimbolo.Create;
begin
 Listavector := TList.Create;
end;

Destructor  TDefSimbolo.Done;
begin
end;

procedure   TDefSimbolo.faiLimiti;
var  vet : TVettoriale;
     i : Integer;
begin
  limx1 := 0.0; limx2 := 0.0; limy1 := 0.0;  limy2 := 0.0;
  for  i:=0 to Listavector.count-1 do
   begin
  	vet := Listavector.Items[i];      vet.faiLimiti;
  	if (i=0) then begin limx1 :=vet.limx1;	   limx2:=vet.limx2; 	   limy1 :=vet.limy1;	   limy2:=vet.limy2; end
             else
     begin
  			if (limx1>vet.limx1) then   limx1:=vet.limx1;
  			if (limy1>vet.limy1) then   limy1:=vet.limy1;
  			if (limx2<vet.limx2) then   limx2:=vet.limx2;
  			if (limy2<vet.limy2) then   limy2:=vet.limy2;
     end;
   end;
end;






procedure TDefSimbolo.disegnadef  ( HHDC : TImage32);
var  vet : TVettoriale;
     i : Integer;
     sca,sca1 : real;
begin
   faiLimiti;
  HHDC.Bitmap.Clear(ColoreSfondo);
   sca := (((limx2-limx1)+1)/ hhdc.Width);
   sca1:= (((limy2-limy1)+1)/ hhdc.Height);
   if sca<sca1 then sca := sca1;
   for  i:=0 to Listavector.count-1 do
   begin
  	vet := Listavector.Items[i];
    vet.disegnadef(HHDC,limx1-0.5,limy1-0.5,sca);
   end;
  HHDC.Repaint;
end;





end.
