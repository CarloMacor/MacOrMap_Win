unit uRaster;

interface

uses  Vcl.Controls
  ,GR32, GR32_Image, GR32_Layers, GR32_RangeBars,
  GR32_Filters, GR32_Transforms, GR32_Resamplers  , vcl.dialogs  , windows
  ;

procedure ApriImmaginedaDialog;
procedure ApriImmagineKool(nomeDir:String);
procedure ApriTerritorioKool(nomeDir:String);
procedure ApriImmagineDiretta(nome:String);
procedure ApriImmagineDaBottone(nome:String);
procedure swimg(ind : Integer);
procedure ImpostaAlfa(ind : Integer; alfa : integer);
procedure spostaterritorio(xorig,yorig: real;xdestStr,ydestStr : String);


implementation

uses main,sysutils, disegnoGR, disegnoR,progetto, varbase, dlg_spostaterritorio, Interfaccia;

procedure ApriImmaginedaDialog;
var k : Integer;
begin
 // Mainform.openraster.InitialDir := DirDatiFotoAeree;

 if Mainform.openraster.Execute then
  begin

   for k:=0 to Mainform.openraster.Files.Count-1 do
    begin
//     ShowMessage(openDialog.Files[i]);
     if k=0 then begin
        ApriImmagineDiretta(Mainform.openraster.Files[k]);
        IlProgetto.indDisGRcorrente := ilprogetto.ListaDisegniGR.Count-1;
        ilProgetto.GRCorrente:= ilprogetto.ListaDisegniGR.items[IlProgetto.indDisGRcorrente];
      end
      else
       begin
        ilProgetto.GRCorrente.addsottoimmagine(Mainform.openraster.Files[k]);
       end;
//    OutputDebugString(PChar(Mainform.openraster.FileName+ ' -----------------            Passa     -------------     '));
    end;
  end;
  ridisegnaInterfaccia
end;

procedure ApriTerritorioKool(nomeDir:String);
var nomefilelimiti : String;
    F : TextFile;
    locdisGR : TDisegnoGR;
    riga : String;
begin
 nomefilelimiti := nomedir+'LimitiTerritorio.txt';
 if not(fileexists(nomefilelimiti)) then
  begin showmessage(' non trovato file LimitiTerritorio.txt in '+nomedir); exit; end;

   Ilprogetto.TerrenoGR := TDisegnoGR.Create;
   Ilprogetto.TerrenoGR.IsKool := True;
   Ilprogetto.TerrenoGR.nome:=ExtractFilename(ExtractFileDir(nomeDir));
   Ilprogetto.TerrenoGR.directoryKool := nomedir;
   Ilprogetto.TerrenoGR.alpha :=122;

 assignFile(F,nomefilelimiti); reset(F);
  readln(F, Ilprogetto.TerrenoGR.limx1K);
  readln(F, Ilprogetto.TerrenoGR.limy1K);
  readln(F, Ilprogetto.TerrenoGR.limx2K);
  readln(F, Ilprogetto.TerrenoGR.limy2K);
  readln(F, Ilprogetto.TerrenoGR.scalaKool0);
  readln(F, Ilprogetto.TerrenoGR.dimPicK);
  readln(F,riga);
  readln(F, Ilprogetto.TerrenoGR.maxLevK);
 closefile(F);

 Ilprogetto.TerrenoGR.angoloKool := 0.03;

end;


procedure ApriImmagineKool(nomeDir:String);
var nomefilelimiti : String;
    F : TextFile;
    locdisGR : TDisegnoGR;
    riga : String;

    k : Integer;
    giapresente : Boolean;
    nomefileristretto : String;
begin
 nomefilelimiti := nomedir+'LimitiTerritorio.txt';
 if not(fileexists(nomefilelimiti)) then
  begin showmessage(' non trovato file LimitiTerritorio.txt in '+nomedir); exit; end;

   giapresente := false;
   nomefileristretto := ExtractFilename(ExtractFileDir(nomeDir));
    for k:=0 to ilprogetto.ListaDisegniGR.count-1 do
     begin
      locdisGR := ilprogetto.ListaDisegniGR.Items[k];
      if (nomefileristretto = locdisGR.Nome) then begin
       giapresente := true; swimg(k); end;
    end;
   if (giapresente) then exit;


   locdisGR := TDisegnoGR.Create;
   ilprogetto.ListaDisegniGR.Add(locdisGR);
   locdisGR.IsKool := True;
   ilprogetto.indDisGRcorrente:=ilprogetto.ListaDisegniGR.count-1;
   ilprogetto.GRCorrente := locdisGR;

   locdisGR.nome:=ExtractFilename(ExtractFileDir(nomeDir));


   locdisGR.NomeconDir:=nomeDir;


   locdisGR.directoryKool := nomedir;
   locdisGR.alpha :=128;

 assignFile(F,nomefilelimiti); reset(F);
  readln(F,locdisGR.limx1K);
  readln(F,locdisGR.limy1K);
  readln(F,locdisGR.limx2K);
  readln(F,locdisGR.limy2K);
  readln(F,locdisGR.scalaKool0);
  readln(F,locdisGR.dimPicK);
  readln(F,riga);
  readln(F,locdisGR.maxLevK);
  if not(eof(F)) then begin readln(F,locdisGR.formatoKool);    end;
 closefile(F);

   ridisegnaInterfaccia;
  IlProgetto.Vista_ZoomTuttosePrimo;


end;

procedure ApriImmagineDiretta(nome:String);
var locdisR  : TDisegnoR;
    locdisGR : TDisegnoGR;
begin
 if fileexists(nome) then
  begin
   if (extractFilename(nome)='LimitiTerritorio.txt') then
    begin
      ApriImmagineKool(extractFilePath(nome));
    end
     else
    begin
     locdisGR := TDisegnoGR.Create;
     ilprogetto.ListaDisegniGR.Add(locdisGR);
     locdisR      := TDisegnoR.Create;
     locdisGR.listaDisegniR.Add(locdisR);
     locdisGR.indDisRCorrente:=locdisGR.listaDisegniR.count-1;
     locdisGR.nome:=ExtractFilename(nome);
     locdisGR.NomeconDir:=nome;
     locdisR.Apri (nome,locdisGR.scalaGR);
     locdisGR.updateLimiti;
     locdisGR.alpha :=128;
     ilprogetto.indDisGRcorrente:=ilprogetto.ListaDisegniGR.count-1;
     ilprogetto.GRCorrente := locdisGR;
     ridisegnaInterfaccia;
    end;
  end;
end;

procedure ApriImmagineDaBottone(nome:String);
var k : Integer;
    giapresente : Boolean;
    locdisGR : TDisegnoGR;
    nomefileristretto : String;
begin
 giapresente := false;
 nomefileristretto := extractfilename(nome);
 for k:=0 to ilprogetto.ListaDisegniGR.count-1 do
  begin
    locdisGR := ilprogetto.ListaDisegniGR.Items[k];
    if (nomefileristretto = locdisGR.Nome) then begin
     giapresente := true; swimg(k); end;
  end;
 if not(giapresente) then begin ApriImmagineDiretta(nome);  IlProgetto.Vista_ZoomTuttosePrimo; end;
end;


procedure swimg(ind : Integer);
var locdisGR : TDisegnoGR;
begin
   if ind<=(ilprogetto.ListaDisegniGR.count-1) then
    begin
     locdisGR :=ilprogetto.ListaDisegniGR.items[ind];
     locdisGR.visibile := not(locdisGR.visibile);
    end;
end;

procedure ImpostaAlfa(ind : Integer; alfa : integer);
var locdisR : TDisegnoR;
begin
{
   if ind<=(ilprogetto.ListaDisegniR.count-1) then
    begin
     locdisR :=ilprogetto.ListaDisegniR.items[ind];
     locdisR.alpha := alfa;
    end;
}
end;

procedure spostaterritorio(xorig,yorig: real;xdestStr,ydestStr : String);
var xdest, ydest : Real;
    offx , offy  : Real;
    searchResult : TSearchRec;
    F : TextFile;
    r1,r2,r3,r4,r5,r6,r7,r8 : String;
    val1,val2 : Real;
begin
  xdest := StrToFloat(xdestStr);  ydest := StrToFloat(ydestStr);
  offx := xdest-xorig;            offy := ydest-yorig;

  if FindFirst(DirDatiFotoAeree+'*.*w', faAnyFile, searchResult) = 0 then
  begin
    repeat
     assignFile(F,DirDatiFotoAeree+searchResult.Name);   reset(F);
     if not(eof(F)) then readln(F,R1);
     if not(eof(F)) then readln(F,R2);
     if not(eof(F)) then readln(F,R3);
     if not(eof(F)) then readln(F,R4);
     if not(eof(F)) then readln(F,R5);
     if not(eof(F)) then readln(F,R6);
     if not(eof(F)) then readln(F,R7);
     closefile(F);
     val1 := StrToFloat(R1);     val2 := StrToFloat(R2);
     val1 := val1+offx;          val2 := val2+offy;
     rewrite(F);
      writeln(F,val1:0:4);
      writeln(F,val2:0:4);
      writeln(F,R3);
      writeln(F,R4);
      writeln(F,R5);
      writeln(F,R6);
      writeln(F,R7);
     closefile(F);
    until FindNext(searchResult) <> 0;
  end;
  FindClose(searchResult);
  if fileexists(DirDatiFotoAeree+'LimitiTerritorio.txt') then
   begin
     assignFile(F,DirDatiFotoAeree+'LimitiTerritorio.txt');   reset(F);
     if not(eof(F)) then readln(F,R1);
     if not(eof(F)) then readln(F,R2);
     if not(eof(F)) then readln(F,R3);
     if not(eof(F)) then readln(F,R4);
     if not(eof(F)) then readln(F,R5);
     if not(eof(F)) then readln(F,R6);
     if not(eof(F)) then readln(F,R7);
     if not(eof(F)) then readln(F,R8);
     closefile(F);
     rewrite(F);
      val1 := StrToFloat(R1);     val2 := StrToFloat(R2);
      val1 := val1+offx;          val2 := val2+offy;
      writeln(F,val1:0:4);
      writeln(F,val2:0:4);
      val1 := StrToFloat(R3);     val2 := StrToFloat(R4);
      val1 := val1+offx;          val2 := val2+offy;
      writeln(F,val1:0:4);
      writeln(F,val2:0:4);
      writeln(F,R5);
      writeln(F,R6);
      writeln(F,R7);
      writeln(F,R8);
     closefile(F);
   end;
end;


end.






















