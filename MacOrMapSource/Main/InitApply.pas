unit InitApply;

interface

uses
//  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls   , sysutils
//  , Vcl.Forms, Vcl.Dialogs
//  , GR32_Image, Vcl.ExtCtrls
//  Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons
  ;

procedure ridimensionaMessagger;
procedure initApply_create;

implementation


uses main,interfaccia,varbase,progetto;


procedure ridimensionaMessagger;
begin
  Mainform.Panel_messaggi.Width:= Mainform.Panel_top.Width -
             Mainform.Panel_Snap.width  -  Mainform.Panel_Zoom.Width -
             Mainform.Panel_Coord.Width -  Mainform.Panel_kindCoord.Width - Mainform.Panel_griglieon.Width-Mainform.Panel_setscale.width;
  Mainform.BotMsg1.Left:=10;
  Mainform.BotMsg1.Width := ((Mainform.Panel_messaggi.Width-24) div 3);
  Mainform.BotMsg2.Left:=Mainform.BotMsg1.Left+Mainform.BotMsg1.Width+4;
  Mainform.BotMsg2.Width := Mainform.BotMsg1.Width*2;
 // Mainform.Panel_setscale.Left:=Mainform.Panel_Zoom.Left-Mainform.Panel_Zoom.Width;
end;

procedure initApply_create;
begin
  Mainform.baseschermo.Scale:=1.0;
  ilProgetto := TProgetto.Create;
    Mainform.Panel_Top.BevelOuter:=bvNone;
    Mainform.Panel_Snap.BevelOuter:=bvNone;
    Mainform.Panel_Zoom.BevelOuter:=bvNone;
    Mainform.Panel_Coord.BevelOuter:=bvNone;
    Mainform.Panel_kindCoord.BevelOuter:=bvNone;
    Mainform.Panel_messaggi.BevelOuter:=bvNone;
    Mainform.Panel_griglieon.BevelOuter:=bvNone;
    Mainform.Panel_setscale.BevelOuter:=bvNone;
  ridimensionaMessagger;
//  ridisegnaInterfaccia;
  Mainform.OpenRaster.InitialDir := directoryapertura+'\ImgGrandi';


end;



end.
