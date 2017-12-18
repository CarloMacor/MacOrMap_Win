unit Dlg_Raster;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Buttons, AdvScrollBox,
  GR32_RangeBars;

type
  TForm_GestRaster = class(TForm)
    Pannello: TAdvScrollBox;
    AdvScrollBox1: TAdvScrollBox;
    But_Up: TSpeedButton;
    But_Down: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddedButtonClick(Sender: TObject);
    procedure gauAddedChange(Sender: TObject);
    procedure But_UpClick(Sender: TObject);
    procedure But_DownClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    LocListaBottoniAdded : TList;
    LocListaBottoni2Added : TList;
    LocListaGaugeAdded   : TList;
    procedure Localridisegna;
    procedure svuota;
  end;

var
  Form_GestRaster: TForm_GestRaster;

implementation

{$R *.dfm}

uses Progetto,DisegnoGR,interfaccia,varbase;


procedure TForm_GestRaster.But_DownClick(Sender: TObject);
var k,j : Integer;
    locInd : Integer;
    locGr : TDisegnoGR;
begin
 locInd:= IlProgetto.indDisGRcorrente;
 if locInd<IlProgetto.ListaDisegniGR.count-1 then
  begin
    IlProgetto.RasterGrUpDownLista(2,locInd);
    LocalRidisegna;
    ridisegna;
  end;
end;

procedure TForm_GestRaster.But_UpClick(Sender: TObject);
var locInd : Integer;
begin
 locInd:= IlProgetto.indDisGRcorrente;
 if locInd>0 then
  begin
    IlProgetto.RasterGrUpDownLista(1,locInd);
    LocalRidisegna;
    ridisegna;
  end;
end;

procedure TForm_GestRaster.FormCreate(Sender: TObject);
begin
 LocListaBottoniAdded  := TList.create;
 LocListaBottoni2Added := TList.create;
 LocListaGaugeAdded    := TList.create;
end;

procedure TForm_GestRaster.FormShow(Sender: TObject);
begin
 LocalRidisegna;
end;

procedure TForm_GestRaster.LocalRidisegna;
var contaBut : Integer;
    k        : Integer;
    locras   : TDisegnoGR;
    btnAdded : TSpeedButton;
    gauAdded : TGaugeBar;
    offy : Integer;
begin
 svuota;
 contaBut :=0;
 offy     := 25;

 for k:=0 to Ilprogetto.ListaDisegniGR.Count-1 do
  begin
   locras := Ilprogetto.ListaDisegniGR.items[k];
   inc(contaBut);
   btnAdded := TSpeedButton.Create(Self);
   LocListaBottoniAdded.add(btnAdded);
   btnAdded.Name := 'btnAddedRaster'+IntToStr(contaBut);
   btnAdded.Parent := self.Pannello;
   btnAdded.GroupIndex := 2000;
   btnAdded.AllowAllUp := true;
   btnAdded.Left:=10;
   btnAdded.Top:=10+k*offy;
   btnAdded.Height:=20;
   btnAdded.Width:=120;
   btnAdded.Caption:=locras.Nome;
   btnAdded.OnClick := btnAddedButtonClick;
   if k = IlProgetto.indDisGRcorrente then  btnAdded.Down:=true else btnAdded.Down:=false;


   btnAdded := TSpeedButton.Create(Self);
   LocListaBottoni2Added.add(btnAdded);
   btnAdded.Name := 'btnAdded2Raster'+IntToStr(contaBut);
   btnAdded.Parent := self.Pannello;
   btnAdded.GroupIndex := 3000+contaBut;
   btnAdded.AllowAllUp := true;
   btnAdded.Left:=135;
   btnAdded.Top:=9+k*offy;
   btnAdded.Height:=22;
   btnAdded.Width:=22;
   btnAdded.Caption:='';
   btnAdded.Glyph:=image_Lanpadina;
   btnAdded.OnClick := btnAddedButtonClick;
   if locras.visibile then btnAdded.Down:=true else btnAdded.Down:=false;

   gauAdded := TGaugeBar.Create(self);
   LocListaGaugeAdded.add(gauAdded);
   gauAdded.Name := 'gauAddedRaster'+IntToStr(contaBut);
   gauAdded.Parent := self.Pannello;
   gauAdded.Left:=10+155;
   gauAdded.Top:=10+k*offy;
   gauAdded.Height:=20;
   gauAdded.Width:=180;
   gauAdded.min:=0;
   gauAdded.max:=255;
   gauAdded.OnChange := gauAddedChange;
   gauAdded.Position := locras.alpha;
  end;
end;


procedure TForm_GestRaster.Svuota;
var k : Integer;
    btnAdded : TSpeedButton;
    gauAdded : TGaugeBar;
begin
 for k:= LocListaGaugeAdded.Count-1 downto 0 do
  begin gauAdded:=LocListaGaugeAdded.items[k];    LocListaGaugeAdded.Delete(k); gauAdded.Parent:=nil; gauAdded.Free; end;
 for k:= LocListaBottoniAdded.Count-1 downto 0 do
  begin btnAdded:=LocListaBottoniAdded.items[k];  LocListaBottoniAdded.Delete(k); btnAdded.parent :=nil;  btnAdded.Free; end;
 for k:= LocListaBottoni2Added.Count-1 downto 0 do
  begin btnAdded:=LocListaBottoni2Added.items[k]; LocListaBottoni2Added.Delete(k); btnAdded.parent :=nil; btnAdded.Free; end;
end;

procedure TForm_GestRaster.btnAddedButtonClick(Sender: TObject);
var partenome: String;
    codnome : String;
    Intcode : Integer;
    locGR   : TDisegnoGR;
begin
 if Sender is TSpeedButton then
  begin
   partenome := copy(TSpeedButton(Sender).Name,1,14);
   if partenome = 'btnAddedRaster' then
    begin
     codnome := copy(TSpeedButton(Sender).Name,15,length(TSpeedButton(Sender).Name)-14);
     IntCode := strToInt(codnome)-1;
     IlProgetto.CambiaGRcorrente(IntCode);
    end;

   partenome := copy(TSpeedButton(Sender).Name,1,15);
   if partenome = 'btnAdded2Raster' then
    begin
     codnome := copy(TSpeedButton(Sender).Name,16,length(TSpeedButton(Sender).Name)-15);
     IntCode := strToInt(codnome)-1;
     locGR := IlProgetto.ListaDisegniGR.Items[IntCode];
     locGR.visibile := Not(locGR.visibile);
     ridisegna;
    end;
  end;

  ridisegnaInterfaccia;
end;


procedure TForm_GestRaster.gauAddedChange(Sender: TObject);
var partenome: String;
    codnome : String;
    Intcode : Integer;
    locGR   : TDisegnoGR;
begin
 if Sender is TGaugeBar then
  begin
   partenome := copy(TGaugeBar(Sender).Name,1,14);
   if partenome = 'gauAddedRaster' then
    begin
     codnome := copy(TSpeedButton(Sender).Name,15,length(TSpeedButton(Sender).Name)-14);
     IntCode := strToInt(codnome)-1;
     locGR := IlProgetto.ListaDisegniGR.Items[IntCode];
     locGR.alpha := TGaugeBar(Sender).Position;
     ridisegna;
    end;
  end;
  ridisegnaInterfaccia;
end;


end.
