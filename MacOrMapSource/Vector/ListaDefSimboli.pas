unit ListaDefSimboli;
interface

uses windows,System.classes,vettoriale,GR32, GR32_Image, GR32_Layers,sysutils,DefSimbolo;

type
 TListaDefSimboli = class
   nomelista           : string;
   listaDefinizioni    : TList;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   apri (nomefile : String);
 end;


implementation

uses DisegnoV,piano, varbase, Punto;

constructor TListaDefSimboli.Create;
 begin
   listaDefinizioni := TList.create;
 end;

Destructor  TListaDefSimboli.Done;
 begin

 end;


procedure   TListaDefSimboli.apri (nomefile : String);
var locdis : TdisegnoV;
    locpiano : Tpiano;
    locvet : Tvettoriale;
    k,j : Integer;
    inizatosymb : Boolean;
    locdef : TDefSimbolo;
    locpunto : TPunto;
begin


 locdis := TdisegnoV.create;
 locdis.Apri(nomefile);
  for k:=0 to locdis.ListaPiani.Count-1 do
   begin
    locpiano := locdis.ListaPiani.Items[k];
    inizatosymb := false;
    for j:= 0 to locpiano.Listavector.Count-1 do
     begin
      locvet := locpiano.Listavector.items[j];
       if locvet.tipo = PPunto then
        begin
          locpunto := locpiano.Listavector.items[j];
          locvet.b_erased := true;
          inizatosymb := true;
          locdef := TDefSimbolo.Create;
          listaDefinizioni.Add(locdef);
          locdef.nome:=locpiano.nomepiano;
          locdef.xc := locpunto.X;   locdef.yc := locpunto.Y;
          break;
        end;
     end;
       if inizatosymb then
          begin
           for j:= 0 to locpiano.Listavector.Count-1 do
            begin
             locvet := locpiano.Listavector.items[j];
             if locvet.b_erased then continue;
             locdef.Listavector.Add(locvet);
             locvet.Sposta(-locdef.xc,-locdef.yc);
            end;
            locdef.xc := 0.0;   locdef.yc := 0.0;
            locdef.faiLimiti;
          end;
  end;
 locdis.Free;

end;

end.

