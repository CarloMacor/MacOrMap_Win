unit DisegnoGR;

interface

uses  System.classes, GR32,  GR32_Image, GR32_Layers, Vcl.Controls ,FMX.Dialogs ,sysutils ,strutils, graphics;

type
 TDisegnoGR = class
  scalaGR                    : Real;
  angoloGR                   : Real;
	limx1, limy1, limx2, limy2 : Real;
	xorigine,    yorigine      : Real;
	dimx,	     dimy            : integer;
  alpha                      : Integer;
	visibile                   : boolean;
	Escala , Exorigine, Eyorigine, Eanglerot  : Real;
	Nome                       : string;
	NomeconDir                 : string;
  listaDisegniR              : TList;
  indDisRCorrente            : Integer;
  xcRot,ycRot                : real;
  minScRasInterface          : Integer;
  maxScRasInterface          : Integer;
  elaborataScaAng_012        : Integer;
  minGauSca,maxGauSca        : integer;
  minGauRot,maxGauRot        : integer;
  Livellokool                : Integer;
  IsKool                     : Boolean;
  scalaKool0                 : real;
	limx1K, limy1K             : Real;
  limx2K, limy2K             : Real;
  dimPicK                    : integer;
  maxLevK                    : Integer;
  directoryKool              : String;
  angoloKool                 : real;
  formatoKool                : String;

   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   svuota;
   procedure   Disegna(HHDC : TImage32) ;
   procedure   DisegnaTumbnail;
   procedure   updateLimiti;
   procedure   UpdateTerritorio;
   procedure   updateScalaGR(sca: real);
   procedure   updateRotGR(rot : real);
   procedure   updateScalaSubraster;
   procedure   updateRotSubraster;

   procedure   UpdateExParam;
   procedure   rotoscala (i_x1coord , i_y1coord, i_x2coord, i_y2coord, i_x3coord , i_y3coord, i_x4coord, i_y4coord: Real);
   procedure   setangolorot_0;
   procedure   setScala_1;
   procedure   sposta(dx,dy : Real);
   procedure   CropRettangolo(x1, y1, x2, y2 : Real);
   procedure   rotocentroSubRaster(xcRot,ycRot,angoloGR : Real);
   procedure   scalacentroSubRaster(xcRot,ycRot,scalaGR : Real);



   // specifiche per il territorio
   procedure   scaricaNonInSchermo;
   procedure   CaricaTerrenoInSchermo;
   procedure   CaricaKoolInSchermo;
   procedure   scaricaTuttiSubRater;
   function    TestPresenteNomeFile(nome : String): Boolean;
   procedure   scaricaNonInKool;
   procedure   salvaCollaterale;

   procedure   addsottoimmagine(nomefile : String);

   procedure   spostaKool(dx,dy : Real);

 end;


implementation

 uses DisegnoR,varbase,main,funzioni,math, costanti;

Constructor TDisegnoGR.Create;
begin
  scalaGR         := 1.0;
  angoloGR        := 0.0;
	xorigine        := 0.0;
  yorigine        := 0.0;
	alpha           := 255;
	visibile        := true;
	Escala          := 1.0;
  Exorigine       := 0.0;
  Eyorigine       := 0.0;
  Eanglerot       := 0.0;
	Nome            :=  '';
  listaDisegniR   := TList.Create;
  indDisRCorrente :=  -1;
  xcRot           := 0.0;
  ycRot           := 0.0;
  elaborataScaAng_012 :=0;

  minGauSca       := 10;
  maxGauSca       := 2000;
  minGauRot       := minRotRasGauge;
  maxGauRot       := maxRotRasGauge;
  Livellokool     := 0;
  IsKool          := false;
  scalaKool0      := 1.0;
  angoloKool      := 0.0;
  formatoKool     :='.JPG';
end;

Destructor  TDisegnoGR.Done;
var locr : TDisegnoR;
    k    : Integer;
begin
 for k := listaDisegniR.count-1 downto 0 do
  begin
   locr := listaDisegniR.items[k];
   listaDisegniR.delete(k);
   locr.laBitmap.Free;
   locr.free;
  end;
 listaDisegniR.free;
end;

procedure   TDisegnoGR.svuota;
begin
end;


procedure   TDisegnoGR.DisegnaTumbnail;
var    locdisR : TDisegnoR;
begin
 if iskool then begin Mainform.Tumbnail.Bitmap.Clear(ColoreSfondo); exit; end;

 if ((indDisRCorrente>=0) and (indDisRCorrente<listaDisegniR.count)) then
   begin
    locdisR := listaDisegniR.Items[indDisRCorrente];
    locdisR.DisegnaTumbnail;
   end;
end;


procedure   TDisegnoGR.Disegna(HHDC : TImage32) ;
var k : integer;
    locdisR : TDisegnoR;
begin
 if iskool then begin UpdateTerritorio; end;

 if not(visibile) then exit;;
 for k:=0 to listaDisegniR.Count-1 do
  begin
   locdisR := listaDisegniR.Items[k];
   if not(locdisR.b_visibile) then continue;
   locdisR.Disegna(HHDC,alpha);
  end;
end;


procedure   TDisegnoGR.updateLimiti;
var k : integer;
    locdisR : TDisegnoR;
begin
 if iskool then
  begin
  	limx1:=limx1K;      limy1:=limy1K;
    limx2:=limx2K;      limy2:=limy2K;
   exit;
  end;

 for k:=0 to listaDisegniR.Count-1 do
  begin
   locdisR := listaDisegniR.Items[k];
   locdisR.updateLimiti;
   if k=0 then begin
     	limx1:=locdisR.limx1;      limy1:=locdisR.limy1;
      limx2:=locdisR.limx2;      limy2:=locdisR.limy2;
    end
     else
    begin
      if limx1>locdisR.limx1  then limx1:=locdisR.limx1;
      if limy1>locdisR.limy1  then limy1:=locdisR.limy1;
      if limx2<locdisR.limx2  then limx2:=locdisR.limx2;
      if limy2<locdisR.limy2  then limy2:=locdisR.limy2;
    end;
  end;
end;


procedure   TDisegnoGR.UpdateTerritorio;
var  locdisR : TDisegnoR;
     k : integer;
     parscalkool : real;
begin
 parscalkool := scalaKool0;
 if (scalaVista<=(parscalkool*1.0)) then Livellokool:=0;
 if (scalaVista>(parscalkool*1.0) ) then Livellokool:=1;
 if (scalaVista>(parscalkool*2) )   then Livellokool:=2;
 if (scalaVista>(parscalkool*4) )   then Livellokool:=3;
 if (scalaVista>(parscalkool*8) )   then Livellokool:=4;
 if (scalaVista>(parscalkool*16) )  then Livellokool:=5;
 if (scalaVista>(parscalkool*32) )  then Livellokool:=6;
 if (scalaVista>(parscalkool*64) )  then Livellokool:=7;
 if Livellokool> maxLevK then Livellokool := maxLevK;

//  Mainform.listbox1.clear;
//   Mainform.listbox1.items.Add(IntToStr(Livellokool));
//   Mainform.listbox1.items.Add(IntToStr(listaDisegniR.count));


  scaricaNonInKool;
  scaricaNonInSchermo;
  CaricaKoolInSchermo;

//   Mainform.listbox1.items.Add(IntToStr(listaDisegniR.count));


end;


procedure   TDisegnoGR.updateScalaGR(sca: real);
var k : Integer;  locdisR : TDisegnoR;
begin
 for k:=0 to listaDisegniR.Count-1 do
  begin
   locdisR := listaDisegniR.Items[k];
   locdisR.updateScala(sca);
  end;

end;


procedure   TDisegnoGR.updateScalaSubraster;
var k : Integer;  locdisR : TDisegnoR;
begin
 for k:=0 to listaDisegniR.Count-1 do
  begin
   locdisR := listaDisegniR.Items[k];
   locdisR.updateScalaCent(scalaGR,xcRot,ycRot);
  end;
end;

procedure   TDisegnoGR.updateRotGR(rot : real);
begin
  angoloGR := ((rot/100)*pi) / 180;
end;

procedure   TDisegnoGR.updateRotSubraster;
var k : Integer;  locdisR : TDisegnoR;
begin
 for k:=0 to listaDisegniR.Count-1 do
  begin
   locdisR := listaDisegniR.Items[k];
   locdisR.updateRotCent(angoloGR,xcRot,ycRot);
  end;
end;


procedure   TDisegnoGR.UpdateExParam;
var k : Integer;  locdisR : TDisegnoR;
begin
 for k:=0 to listaDisegniR.Count-1 do
  begin
   locdisR := listaDisegniR.Items[k];
   locdisR.UpdateExParam;
  end;
end;

procedure   TDisegnoGR.rotoscala (i_x1coord , i_y1coord, i_x2coord, i_y2coord, i_x3coord , i_y3coord, i_x4coord, i_y4coord: Real);
var k : Integer;  locdisR : TDisegnoR;
begin
 for k:=0 to listaDisegniR.Count-1 do
  begin
   locdisR := listaDisegniR.Items[k];
   locdisR.rotoscala (i_x1coord , i_y1coord, i_x2coord, i_y2coord, i_x3coord , i_y3coord, i_x4coord, i_y4coord, scalaGR);
  end;
end;


procedure   TDisegnoGR.scaricaNonInSchermo;
var k : Integer;  locdisR : TDisegnoR;
begin
 for k:=listaDisegniR.Count-1 downto 0 do
  begin
   locdisR := listaDisegniR.Items[k];
   if Not(locdisR.TestinScermo) then
    begin listaDisegniR.Delete(k); locdisR.laBitmap.free; locdisR.Free; end;
  end;
end;

procedure   TDisegnoGR.scaricaNonInKool;
var k : Integer;  locdisR : TDisegnoR; charKool : String;
begin
 charKool := letteraKool(Livellokool);
 for k:=listaDisegniR.Count-1 downto 0 do
  begin
   locdisR := listaDisegniR.Items[k];
   if (copy(locdisR.SoloNomefile,1,1)<>charKool) then
    begin listaDisegniR.Delete(k); locdisR.laBitmap.free;   locdisR.Free; end;
  end;
end;


procedure   TDisegnoGR.CaricaKoolInSchermo;
var xstart , ystart : Integer;
    xend   , yend   : Integer;
    offsx1 , offsy1 : real;
    offsx2 , offsy2 : real;
    dimxRealeTer , dimyRealeTer : real;
    k, j : Integer;
    nomefile : String;
    locdisR : TDisegnoR;
    paramlivK : Integer;
    loc_yOrigineVista : Real;
    loc_y2OrigineVista : Real;
    loc_xOrigineVista : Real;
    loc_x2OrigineVista : Real;
    dx,dy : real;
begin


  paramlivK := round(power(2,Livellokool));
  dimxRealeTer := dimPicK*scalaKool0*(paramlivK);  dimyRealeTer := dimPicK*scalaKool0*(paramlivK);
  dy := y2OrigineVista - limy1K;                   dx := x2OrigineVista - limx1K;


  offsx1:=xOrigineVista-limx1K ;         offsy1:=limy2K - y2origineVista ;
  if offsx1<0 then xstart:=0 else begin xstart := trunc(offsx1/dimxRealeTer);  end;
  if offsy1<0 then ystart:=0 else begin ystart := trunc(offsy1/dimyRealeTer); end;

  offsx2:=x2origineVista-limx1K;                   offsy2:=limy2K-yOrigineVista;

  if offsx2<0 then xend:=0   else begin xend   := trunc(offsx2/dimxRealeTer); end;
  if offsy2<0 then yend:=0   else begin yend   := trunc(offsy2/dimyRealeTer);   end;

(*
     Mainform.ListBox1.clear;
      Mainform.ListBox1.Items.Add('Xstart : '+IntToStr(xstart));
      Mainform.ListBox1.Items.Add('Xend   : '+IntToStr(xend));
      Mainform.ListBox1.Items.Add('Ystart : '+IntToStr(ystart));
      Mainform.ListBox1.Items.Add('Yend   : '+IntToStr(yend));

*)

  for k:=xstart to xend do
   begin
    for j:=ystart to yend do begin
     nomefile := directoryKool+letteraKool(Livellokool)+Format('%.3d',[k])+'_'+Format('%.3d',[j])+formatokool;
       if Fileexists(nomefile) then
        begin
         if not(TestPresenteNomeFile(nomefile)) then
          begin
           locdisR      := TDisegnoR.Create;
           listaDisegniR.Add(locdisR);
           locdisR.Apri (nomefile,scalaGR);
          end;
        end;
//         else showmessage(nomefile);
    end;
   end;



end;




procedure   TDisegnoGR.CaricaTerrenoInSchermo;
var xstart , ystart : Integer;
    xend   , yend   : Integer;
    offsx1 , offsy1 : real;
    dimxRealeTer , dimyRealeTer : real;
    k, j : Integer;
    nomefile : String;
    locdisR : TDisegnoR;
    paramlivK : Integer;

    loc_yOrigineVista : Real;
    loc_y2OrigineVista : Real;
    loc_xOrigineVista : Real;
    loc_x2OrigineVista : Real;
    dx,dy : real;

begin

  formatokool :='.bmp';

  paramlivK := round(power(2,Livellokool));
  dimxRealeTer := dimPicTer*scalater*(paramlivK);  dimyRealeTer := dimPicTer*scalater*(paramlivK);

  dy := y2OrigineVista-LimTery1;  dx := xOrigineVista-LimTerx1;

  offsx1:=xOrigineVista-LimTerx1;
  offsy1:=LimTery2 - y2origineVista;

  if offsx1<0 then xstart:=0 else begin xstart := trunc(offsx1/dimxRealeTer); end;
  if offsy1<0 then ystart:=0 else begin ystart := trunc(offsy1/dimyRealeTer); end;

  offsx1:=x2origineVista-LimTerx1;
  offsy1:=(LimTery2+dimPicTer*scalater)-yOrigineVista;

  if offsx1<0 then xend:=0 else begin xend := trunc(offsx1/dimxRealeTer); end;

  if offsy1<0 then yend:=0 else begin yend := trunc(offsy1/dimyRealeTer); end;


  (*
      Mainform.ListBox1.clear;
       Mainform.ListBox1.Items.Add('Xstart : '+IntToStr(xstart));
       Mainform.ListBox1.Items.Add('Xend   : '+IntToStr(xend));
       Mainform.ListBox1.Items.Add('Ystart : '+IntToStr(ystart));
       Mainform.ListBox1.Items.Add('Yend   : '+IntToStr(yend));

 *)


  for k:=xstart to xend do
   begin
    for j:=ystart to yend do begin
     nomefile := DirDatiFotoAeree+letteraKool(Livellokool)+Format('%.3d',[k])+'_'+Format('%.3d',[j])+formatokool;

 //    Mainform.ListBox1.Items.Add(letteraKool(Livellokool)+Format('%.3d',[k])+'_'+Format('%.3d',[j]));

     if Fileexists(nomefile) then
      begin
       if not(TestPresenteNomeFile(nomefile)) then
        begin
         locdisR      := TDisegnoR.Create;
         listaDisegniR.Add(locdisR);
         locdisR.Apri (nomefile,scalaGR);
        end;
      end;
    end;
   end;
end;

procedure  TDisegnoGR.scaricaTuttiSubRater;
var    k :  Integer; locdisR : TDisegnoR;
begin
 for k:=listaDisegniR.Count-1 downto 0 do
  begin
   locdisR := listaDisegniR.Items[k];
   listaDisegniR.Delete(k);
   locdisR.labitmap.Free;
   locdisR.Free;
  end;
end;


function   TDisegnoGR.TestPresenteNomeFile(nome : String) : Boolean;
var resulta : Boolean;
    k :  Integer; locdisR : TDisegnoR;
begin
 resulta := false;
 for k:=listaDisegniR.Count-1 downto 0 do
  begin
   locdisR := listaDisegniR.Items[k];
   if locdisR.NomefileRaster = nome then resulta := true;
  end;
 result := resulta;
end;

procedure  TDisegnoGR.setangolorot_0;
var k :  Integer; locdisR : TDisegnoR;
begin
 angoloGR:=0.0;
 for k:=listaDisegniR.Count-1 downto 0 do
  begin
   locdisR := listaDisegniR.Items[k]; locdisR.anglerot :=0.0;
  end;
end;

procedure  TDisegnoGR.setScala_1;
var k :  Integer; locdisR : TDisegnoR;
begin
 scalaGR:=1.0;
 for k:=listaDisegniR.Count-1 downto 0 do
  begin
   locdisR := listaDisegniR.Items[k]; locdisR.scala:=1.0;
  end;
end;

procedure   TDisegnoGR.sposta(dx,dy : Real);
var k :  Integer; locdisR : TDisegnoR;
begin
 scalaGR:=1.0;
 for k:=listaDisegniR.Count-1 downto 0 do
  begin
   locdisR := listaDisegniR.Items[k];
   locdisR.xorigine := locdisR.xorigine +dx;
   locdisR.yorigine := locdisR.yorigine +dy;
   locdisR.updateLimiti;
  end;
 updateLimiti;
end;

procedure  TDisegnoGR.spostaKool(dx,dy : Real);
var dirDeiFiles : String;
    nomefilelimiti  : String;
    nomefilelimiti2 : String;
    F,G : TextFile;
    riga : String;
    x1, y1 : real;
    searchResult : TSearchRec;
    nomeloc : String;
begin
  if iskool then begin
   dirDeiFiles:= NomeconDir;
   nomefilelimiti := dirDeiFiles+'LimitiTerritorio.txt';
   nomefilelimiti2 := dirDeiFiles+'LimitiTerritorio2.txt';
   if fileexists(nomefilelimiti) then begin
     assignfile(F,nomefilelimiti); reset(F);     assignfile(G,nomefilelimiti2); rewrite(G);
      readln(F,x1);      writeln(G,Format ('%1.2f',[x1+dx]));
      readln(F,y1);      writeln(G,Format ('%1.2f',[y1+dy]));
      readln(F,x1);      writeln(G,Format ('%1.2f',[x1+dx]));
      readln(F,y1);      writeln(G,Format ('%1.2f',[y1+dy]));
      while (not (eof(F))) do begin   readln(F,riga);  writeln(G,riga);   end;
     closefile(F);                               closefile(G);
     erase(F);  rename(G,nomefilelimiti);
   end;

   // Try to find regular files matching Unit1.d* in the current dir
   if FindFirst(dirDeiFiles+'*.bmw', faAnyFile, searchResult) = 0 then
    begin
     repeat
      if searchResult.Name[1]='.' then nomeloc := copy(searchResult.Name,2,length(searchResult.Name)-1)
                                  else nomeloc := searchResult.Name;
      if (nomeloc[1]<>'_') then
       begin
        if fileexists(dirDeiFiles+nomeloc) then
         begin
          assignfile(F,dirDeiFiles+nomeloc); reset(F);     assignfile(G,dirDeiFiles+nomeloc+'k'); rewrite(G);
           readln(F,x1);      writeln(G,Format ('%1.2f',[x1+dx]));
           readln(F,y1);      writeln(G,Format ('%1.2f',[y1+dy]));
           while (not (eof(F))) do begin   readln(F,riga);  writeln(G,riga);   end;
          closefile(F);                               closefile(G);
          erase(F);  rename(G,dirDeiFiles+nomeloc);
        end;
       end;

     until FindNext(searchResult) <> 0;
      FindClose(searchResult);
    end;



  end;
end;


procedure   TDisegnoGR.rotocentroSubRaster(xcRot,ycRot,angoloGR : Real);
var k :  Integer; locdisR : TDisegnoR;
begin
 for k:=listaDisegniR.Count-1 downto 0 do
  begin
   locdisR := listaDisegniR.Items[k];
   locdisR.anglerot := angoloGr;
   rotocentra( xcrot , ycrot , angoloGr, locdisR.Eanglerot, locdisR.xorigine, locdisR.yorigine);
//   locdisR.updateLimiti;
  end;
end;

procedure   TDisegnoGR.scalacentroSubRaster(xcRot,ycRot,scalaGR : Real);
var k :  Integer; locdisR : TDisegnoR;
begin
 for k:=listaDisegniR.Count-1 downto 0 do
  begin
   locdisR := listaDisegniR.Items[k];
//   showmessage( floatTostr(locdisR.scala) );

//   xc , yc , scalaatt , scalaprec : real; var xcord :real; var ycord : real);
     scalacentra( xcrot , ycrot , scalaGR*locdisR.scala, locdisR.scala, locdisR.xorigine, locdisR.yorigine);
     locdisR.scala       := scalaGR*locdisR.scala;
//   locdisR.xorigine := locdisR.xorigine +dx;
//   locdisR.yorigine := locdisR.yorigine +dy;
//   locdisR.updateLimiti;
  end;
end;



procedure   TDisegnoGR.CropRettangolo(x1, y1, x2, y2 : Real);
var k :  Integer; locdisR : TDisegnoR;
    newscala : Real;
    dx,dy : Real;
    newbitmap : TBitmap32 ;
    dxInt , dyInt : Integer;
    dxIntR , dyIntR : Integer;
    R1,R2 : TRect;
    x1o,y1o,x2o,y2o : Real;
    dxo,dyo : Real;
    xmin,ymin,xmax,ymax : Real;
    Xleft , xRight  : real;
    Ytop  , YBottom : real;
    F : TextFile;
    nometfw : String;
    _scala : Real;
    _xorigine , _yorigine : Real;
    _dimx,_dimy : Integer;
begin
 dx := abs(x2-x1); dy := abs(y2-y1);
 xmin := x1;   ymin := y1;    xmax := x1;   ymax := y1;
 if x2<x1 then xmin := x2;  if x2>x1 then xmax := x2;
 if y2<y1 then ymin := y2;  if y2>y1 then ymax := y2;

 _xorigine :=  xmin ; _yorigine :=  ymin ;

 if listaDisegniR.Count>0 then
  begin
   locdisR := listaDisegniR.Items[0];
   newscala := locdisR.scala;
   _scala := newscala;
   newbitmap := TBitmap32.create;
   dxInt := round(dx/newscala);  dyInt := round(dy/newscala);
   newbitmap.SetSize(dxInt, dyInt);
    _dimx:=dxInt; _dimy:=dyInt;


   for k:=0 to listaDisegniR.Count-1 do
    begin
     locdisR := listaDisegniR.Items[k];
     if (xmin> (locdisR.xorigine+locdisR.dimx*locdisR.scala)) then continue;
     if (xmax< locdisR.xorigine)                              then continue;
     if (ymin> (locdisR.yorigine+locdisR.dimy*locdisR.scala)) then continue;
     if (ymax< locdisR.yorigine)                              then continue;

     Xleft   := xmin-locdisR.xorigine;
     Xright  := xmax-locdisR.xorigine;
     Ybottom := ymin-locdisR.yorigine;
     Ytop    := ymax-locdisR.yorigine;
     dx      := Xright- Xleft;
     dy      := Ytop- Ybottom;

     if Xleft>0 then begin R2.Left := 0;        R1.Left := trunc(Xleft/locdisR.scala);  end
                else begin R2.Left := trunc((abs(Xleft))/locdisR.scala); R1.Left := 0;  end;

     if Xright<(locdisR.dimx*locdisR.scala) then
      begin
       if Xleft>0 then
        begin R1.Width:=Trunc((Xright-Xleft)/locdisR.scala); R2.Width:=R1.Width; end
         else
        begin R1.Width:=Trunc(Xright/locdisR.scala); R2.Width:=R1.Width;         end;
      end
       else
      begin
       if Xleft>0 then
        begin R1.Width:=locdisR.dimx-Trunc(Xleft/locdisR.scala); R2.Width:=R1.Width; end
         else
        begin R1.Width:=locdisR.dimx; R2.Width:=R1.Width;   end;
      end;


     if Ytop<(locdisR.dimy*locdisR.scala) then
        begin R1.top:=trunc(((locdisR.dimy*locdisR.scala)-Ytop)/locdisR.scala);  R2.top:=0; end
         else
        begin R1.top:=0;  R2.top:= trunc( (Ytop-(locdisR.dimy*locdisR.scala)) /locdisR.scala); end;

     if Ytop<(locdisR.dimy*locdisR.scala) then
      begin
       if Ybottom>0 then
        begin R1.Height:=dyInt;  R2.Height:=R1.Height; end
         else
        begin R1.Height:=dyInt-trunc(Ybottom/locdisR.scala);  R2.Height:=R1.Height;  end;
      end
       else
      begin
       if Ybottom>0 then
        begin R1.Height:=dyInt-trunc(Ytop/locdisR.scala);  R2.Height:=R1.Height;    end
         else
        begin R1.Height:=locdisR.dimy; R2.Height:=R1.Height; end;
      end;
      newbitmap.Draw(r2, r1, locdisR.laBitmap);
    end;


   if Mainform.SaveRaster.Execute then
    begin
     newbitmap.SaveToFile(Mainform.SaveRaster.filename);

       nometfw  := Mainform.SaveRaster.filename;
       nometfw[length(nometfw)]  := 'w';

       assignFile(F,nometfw); rewrite(F);
        writeln(F,_xorigine:0:2);
        writeln(F,_yorigine:0:2);
        writeln(F,_scala);
        writeln(F,_scala);
        writeln(F,'0.0');
        writeln(F,_dimx);
        writeln(F,_dimy);
       closefile(F);
    end;

   newbitmap.Free;
  end;
end;

procedure TDisegnoGR.salvaCollaterale;
var k :  Integer; locdisR : TDisegnoR;
begin
 if (IsKool and salvarotTerritorioAttivo) then
  begin

  end;

 for k:=listaDisegniR.Count-1 downto 0 do
  begin
   locdisR := listaDisegniR.Items[k];
   locdisR.salvacollaterale;
  end;
end;


procedure  TDisegnoGR.addsottoimmagine(nomefile : String);
var locdisR  : TDisegnoR;
begin
 locdisR      := TDisegnoR.Create;
 listaDisegniR.Add(locdisR);
 locdisR.Apri (nomefile,scalaGR);
 updateLimiti;
end;

end.
