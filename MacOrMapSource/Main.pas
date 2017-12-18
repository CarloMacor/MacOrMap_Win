unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GR32_Image, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons
   ,GR32_Layers, GR32_RangeBars, Vcl.ComCtrls, Vcl.Imaging.pngimage, GR32,
  Vcl.ExtDlgs, Vcl.Samples.Spin

   ,  GR32_Resamplers, GR32_LowLevel, GR32_Blend
  ;

type
  TMainForm = class(TForm)
    Panel_Right: TPanel;
    MainMenu1: TMainMenu;
    Panel_Top: TPanel;
    Panel_Snap: TPanel;
    Panel_Zoom: TPanel;
    Bot_snapFine: TSpeedButton;
    Bot_snapVicino: TSpeedButton;
    Bot_snapOrto: TSpeedButton;
    Bot_snapOrtoseg: TSpeedButton;
    Bot_snapGriglia: TSpeedButton;
    Bot_snapOff: TSpeedButton;
    MacOrMap1: TMenuItem;
    File1: TMenuItem;
    Raster1: TMenuItem;
    Vettoriale1: TMenuItem;
    Viste1: TMenuItem;
    Vettoriale2: TMenuItem;
    Snap1: TMenuItem;
    SnapFine1: TMenuItem;
    SnapVicino1: TMenuItem;
    SnapOrto1: TMenuItem;
    SnaportoUltimoseg1: TMenuItem;
    SnapGriglia1: TMenuItem;
    N1: TMenuItem;
    ogliSnapeOrto1: TMenuItem;
    Bot_ZoomLast: TSpeedButton;
    Bot_ZoomPan: TSpeedButton;
    Bot_ZoomWindow: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Bot_ZoomPiu: TSpeedButton;
    Bot_ZoomTutto: TSpeedButton;
    Panel_setscale: TPanel;
    Panel_Coord: TPanel;
    Info_YMouse: TEdit;
    Info_XMouse: TEdit;
    Panel_kindCoord: TPanel;
    Bot_Coord5: TSpeedButton;
    Bot_Coord4: TSpeedButton;
    Bot_Coord1: TSpeedButton;
    Bot_Coord2: TSpeedButton;
    Bot_Coord3: TSpeedButton;
    Panel_griglieon: TPanel;
    Bot_Griglia: TSpeedButton;
    Bot_GrigliaSetUp: TSpeedButton;
    Opzioni1: TMenuItem;
    UTMWgs841: TMenuItem;
    GEOWgs841: TMenuItem;
    UTM501: TMenuItem;
    Geo501: TMenuItem;
    CassiniSoldner1: TMenuItem;
    OpenRaster: TOpenDialog;
    BaseSchermo: TImage32;
    OpenVector: TOpenDialog;
    BitmapList: TBitmap32List;
    Panel4: TPanel;
    Label5: TLabel;
    SpeedButton39: TSpeedButton;
    Gau_SupDisV: TGaugeBar;
    Gau_LineDisV: TGaugeBar;
    But_Aprivett: TSpeedButton;
    But_TogliDisvett: TSpeedButton;
    ListBoxDis: TComboBox;
    Bot_DisSnappabile: TSpeedButton;
    Bot_DisEditabile: TSpeedButton;
    Bot_VisibileDisV: TSpeedButton;
    Bot_zoomVDisegno: TSpeedButton;
    Panel_Raster: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Bot_FixCentroCalRas: TSpeedButton;
    Bot_resetScalaGR: TSpeedButton;
    Bot_resetRotGR: TSpeedButton;
    Gau_ScalaGR: TGaugeBar;
    Gau_RotGR: TGaugeBar;
    Panel1: TPanel;
    Label6: TLabel;
    But_openRaster: TSpeedButton;
    But_TogliRaster: TSpeedButton;
    But_vedoGR: TSpeedButton;
    But_ZoomGR: TSpeedButton;
    ListBoxRastGR: TComboBox;
    Gau_RasterGR: TGaugeBar;
    Sviluppo1: TMenuItem;
    SpostaTerritorioPteCoord1: TMenuItem;
    Spin_rotGr: TSpinButton;
    Spin_ScaGR: TSpinButton;
    SpeedButton1: TSpeedButton;
    Bot_saveGR: TSpeedButton;
    Panel_Comune: TPanel;
    Panel15: TPanel;
    Bot_TabellaFabbricati: TSpeedButton;
    Bot_TabellaTerreni: TSpeedButton;
    ListBox1: TListBox;
    Panel9: TPanel;
    Bot_Territorio: TSpeedButton;
    Gau_RasterTerreno: TGaugeBar;
    Image1: TImage;
    Image2: TImage;
    Panel5: TPanel;
    Panel8: TPanel;
    Label2: TLabel;
    Bot_Pianoeditabile: TSpeedButton;
    Bot_PianoSnappabile: TSpeedButton;
    Bot_VisibilePiano: TSpeedButton;
    Bot_zoomPiano: TSpeedButton;
    Bot_NuovoPiano: TSpeedButton;
    Image3: TImage;
    Image4: TImage;
    ListBoxPian: TComboBox;
    Gau_SupPiano: TGaugeBar;
    Gau_LinePiano: TGaugeBar;
    Pan_ComVector: TPanel;
    Bot_CPunto: TSpeedButton;
    Bot_CPLinea: TSpeedButton;
    Bot_CPoligono: TSpeedButton;
    Bot_CRegione: TSpeedButton;
    Bot_Simbolo: TSpeedButton;
    Bot_rettangolo: TSpeedButton;
    Bot_CCerchio: TSpeedButton;
    Bot_Testo: TSpeedButton;
    Label1: TLabel;
    Panel7: TPanel;
    Bot_Seleziona: TSpeedButton;
    SpeedButton50: TSpeedButton;
    Bot_informsel: TSpeedButton;
    But_SpostaSelected: TSpeedButton;
    But_CopiaSelected: TSpeedButton;
    But_RuotaSelected: TSpeedButton;
    But_ScalaSelected: TSpeedButton;
    Label8: TLabel;
    But_Match: TSpeedButton;
    Bot_cancsel: TSpeedButton;
    Bot_SpostaVertice: TSpeedButton;
    Bot_InsVert: TSpeedButton;
    Bot_cancellaVt: TSpeedButton;
    Panel6: TPanel;
    But_FixCentroVet: TSpeedButton;
    but_ScaDisegno: TSpeedButton;
    but_RuotaDisegno: TSpeedButton;
    but_SpoXDisegno: TSpeedButton;
    but_SpoYDisegno: TSpeedButton;
    Gau_ScaV: TGaugeBar;
    Gau_RotV: TGaugeBar;
    Gau_SpoXV: TGaugeBar;
    Gau_SpoYV: TGaugeBar;
    CheckBox1: TCheckBox;
    Spin_ScaVet: TSpinButton;
    SpinButton1: TSpinButton;
    SpinButton2: TSpinButton;
    SpinButton3: TSpinButton;
    Panel_tributi: TPanel;
    SaveRaster: TSaveDialog;
    SaveVector: TSaveDialog;
    LabRotRas: TLabel;
    Ck_CalTerritorio: TSpeedButton;
    LabScaRas: TLabel;
    errenoGrCoorente1: TMenuItem;
    Pan_Conf1: TPanel;
    Bot_Anagrafe: TSpeedButton;
    Bot_QUnione: TSpeedButton;
    But_openCatasto: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Bot_terreniOn: TSpeedButton;
    ColorDialog1: TColorDialog;
    Panel_ColorPiano: TPanel;
    Lab_Vsca: TLabel;
    Lab_Vrot: TLabel;
    Lab_VspoX: TLabel;
    Lab_VspoY: TLabel;
    SalvaInfocorrente1: TMenuItem;
    SalvaInfoaTutti1: TMenuItem;
    Bot_SpstaVectorDlg: TSpeedButton;
    edit_Fittizio: TEdit;
    Lac_titoloComune: TLabel;
    Bot_Proprietari: TSpeedButton;
    Bot_Tares: TSpeedButton;
    Bot_IMU: TSpeedButton;
    But_PossessiTutti: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    N2: TMenuItem;
    GeneraDisegnoStradeAnagrafe1: TMenuItem;
    But_TrovaFoglio: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SetUp1: TMenuItem;
    olfa1: TMenuItem;
    MaglianoSabina1: TMenuItem;
    N3: TMenuItem;
    ImportStradeMagliano1: TMenuItem;
    N4: TMenuItem;
    SalvaDatiImmobili1: TMenuItem;
    N5: TMenuItem;
    Fondidisegni1: TMenuItem;
    But_GestRaster: TSpeedButton;
    But_GestVett: TSpeedButton;
    Spessore2atuttiipiani1: TMenuItem;
    vedopallinivertici1: TMenuItem;
    VedopalliniverticiFinali1: TMenuItem;
    Bot_CivOnOff: TSpeedButton;
    Bot_CCivico: TSpeedButton;
    mettiCivici1: TMenuItem;
    RiordinoNomeStrade1: TMenuItem;
    N6: TMenuItem;
    PolyTuttopenDown1: TMenuItem;
    RiordinoAlfabeticodisegno1: TMenuItem;
    NomigraficiaStrade1: TMenuItem;
    MettiCivici2: TMenuItem;
    But_editTesto: TSpeedButton;
    But_spostacivico: TSpeedButton;
    Panel10: TPanel;
    Tumbnail: TImage32;
    Lab_dimxR: TLabel;
    Lab_dimyR: TLabel;
    Panel12: TPanel;
    Bot_SpostaRaster: TSpeedButton;
    Bot_SpstaRasterDlg: TSpeedButton;
    Bot_RighelloRaster: TSpeedButton;
    Bot_Raster2Segmenti: TSpeedButton;
    Bot_Rot0: TSpeedButton;
    Bot_Sca1: TSpeedButton;
    Bot_CropRaster: TSpeedButton;
    Bot_RasterCrocicchi: TSpeedButton;
    Label7: TLabel;
    ListBoxSubRastGR: TComboBox;
    But_vedoR: TSpeedButton;
    SpeedButton20: TSpeedButton;
    Pan_Conf2: TPanel;
    Bot_CivDisassociati: TSpeedButton;
    Bot_stradaletxt: TSpeedButton;
    Bot_Rilievo: TSpeedButton;
    SaveRilievo: TSaveDialog;
    Stampa1: TMenuItem;
    StampaRilevo1: TMenuItem;
    Panel_Moreno: TPanel;
    Bot_contratti: TSpeedButton;
    Bot_Concessioni: TSpeedButton;
    bot_Concessionidis: TSpeedButton;
    SpeedButton16: TSpeedButton;
    N7: TMenuItem;
    catastoselezionabileInfo1: TMenuItem;
    Selezionati1: TMenuItem;
    CopiaalPianoCorrente1: TMenuItem;
    But_makePartContratto: TSpeedButton;
    Lab_numsel: TLabel;
    edit1: TMenuItem;
    agliaPoligono1: TMenuItem;
    But_T_Contratti: TSpeedButton;
    But_clearTer: TSpeedButton;
    InproduzionedisConcessioni1: TMenuItem;
    But_Righello: TSpeedButton;
    StampaAreainScala1: TMenuItem;
    Panel_messaggi: TPanel;
    BotMsg1: TSpeedButton;
    BotMsg2: TSpeedButton;
    ComboScala: TComboBox;
    SpeedButton6: TSpeedButton;
    Image32Stampa: TImage32;
    SaveStampa: TSaveDialog;
    N8: TMenuItem;
    SpostaTerritorioconptcoordattivo1: TMenuItem;
    salvaterritoriorot1: TMenuItem;
    PolyinPoligonialDisCorrente1: TMenuItem;
    Piani1: TMenuItem;
    EliminapianiOff1: TMenuItem;
    EliminaPianiOn1: TMenuItem;
    N9: TMenuItem;
    FondiTuttoalPrimoPiano1: TMenuItem;
    SpeedButton7: TSpeedButton;
    BotTestCV: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure Bot_snapFineClick(Sender: TObject);
    procedure Bot_snapOrtoClick(Sender: TObject);
    procedure Bot_snapOrtosegClick(Sender: TObject);
    procedure Bot_snapGrigliaClick(Sender: TObject);
    procedure Bot_snapOffClick(Sender: TObject);
    procedure Bot_snapVicinoClick(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Bot_ZoomPiuClick(Sender: TObject);
    procedure BaseSchermoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure BaseSchermoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure ImgView321MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormResize(Sender: TObject);
    procedure Bot_Coord3Click(Sender: TObject);
    procedure Bot_Coord4Click(Sender: TObject);
    procedure Bot_Coord5Click(Sender: TObject);
    procedure Bot_Coord1Click(Sender: TObject);
    procedure Bot_Coord2Click(Sender: TObject);
    procedure But_openRasterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BaseSchermoResize(Sender: TObject);
    procedure BaseSchermoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure Bot_CPuntoClick(Sender: TObject);
    procedure Bot_CPLineaClick(Sender: TObject);
    procedure Bot_CPoligonoClick(Sender: TObject);
    procedure Bot_CRegioneClick(Sender: TObject);
    procedure But_AprivettClick(Sender: TObject);
    procedure ListBoxDisChange(Sender: TObject);
    procedure ListBoxPianChange(Sender: TObject);
    procedure Bot_ZoomTuttoClick(Sender: TObject);
    procedure Bot_ZoomWindowClick(Sender: TObject);
    procedure Bot_ZoomLastClick(Sender: TObject);
    procedure Bot_ZoomPanClick(Sender: TObject);
    procedure But_TogliDisvettClick(Sender: TObject);
    procedure Gau_SupDisVChange(Sender: TObject);
    procedure Gau_LineDisVChange(Sender: TObject);
    procedure Bot_VisibileDisVClick(Sender: TObject);
    procedure Bot_DisEditabileClick(Sender: TObject);
    procedure Bot_DisSnappabileClick(Sender: TObject);
    procedure Bot_zoomVDisegnoClick(Sender: TObject);
    procedure SpeedButton39Click(Sender: TObject);
    procedure Bot_VisibilePianoClick(Sender: TObject);
    procedure Bot_zoomPianoClick(Sender: TObject);
    procedure Bot_NuovoPianoClick(Sender: TObject);
    procedure Bot_PianoeditabileClick(Sender: TObject);
    procedure Bot_PianoSnappabileClick(Sender: TObject);
    procedure Gau_SupPianoChange(Sender: TObject);
    procedure Gau_LinePianoChange(Sender: TObject);
    procedure But_TogliRasterClick(Sender: TObject);
    procedure ListBoxRastGRChange(Sender: TObject);
    procedure But_vedoGRClick(Sender: TObject);
    procedure But_ZoomGRClick(Sender: TObject);
    procedure Gau_RasterGRChange(Sender: TObject);
    procedure But_vedoRClick(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure Bot_FixCentroCalRasClick(Sender: TObject);
    procedure Gau_ScalaGRChange(Sender: TObject);
    procedure Bot_resetScalaGRClick(Sender: TObject);
    procedure Gau_RotGRChange(Sender: TObject);
    procedure Bot_resetRotGRClick(Sender: TObject);
    procedure Gau_ScalaGRMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Gau_RotGRMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Bot_SpostaRasterClick(Sender: TObject);
    procedure Bot_Raster2SegmentiClick(Sender: TObject);
    procedure Bot_TerritorioClick(Sender: TObject);
    procedure Gau_RasterTerrenoChange(Sender: TObject);
    procedure SpostaTerritorioPteCoord1Click(Sender: TObject);
    procedure Bot_TabellaFabbricatiClick(Sender: TObject);
    procedure Bot_GrigliaClick(Sender: TObject);
    procedure Bot_GrigliaSetUpClick(Sender: TObject);
    procedure Spin_rotGrUpClick(Sender: TObject);
    procedure Spin_rotGrDownClick(Sender: TObject);
    procedure Spin_ScaGRUpClick(Sender: TObject);
    procedure Spin_ScaGRDownClick(Sender: TObject);
    procedure Bot_RighelloRasterClick(Sender: TObject);
    procedure Bot_Rot0Click(Sender: TObject);
    procedure Bot_Sca1Click(Sender: TObject);
    procedure Bot_SpstaRasterDlgClick(Sender: TObject);
    procedure Bot_RasterCrocicchiClick(Sender: TObject);
    procedure Bot_CropRasterClick(Sender: TObject);
    procedure Bot_rettangoloClick(Sender: TObject);
    procedure Bot_CCerchioClick(Sender: TObject);
    procedure Bot_saveGRClick(Sender: TObject);
    procedure Ck_CalTerritorioClick(Sender: TObject);
    procedure errenoGrCoorente1Click(Sender: TObject);
    procedure But_openCatastoClick(Sender: TObject);
    procedure Bot_AnagrafeClick(Sender: TObject);
    procedure Bot_QUnioneClick(Sender: TObject);
    procedure Bot_terreniOnClick(Sender: TObject);
    procedure Bot_SelezionaClick(Sender: TObject);
    procedure SpeedButton50Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure Bot_TestoClick(Sender: TObject);
    procedure Panel_ColorPianoClick(Sender: TObject);
    procedure Bot_cancselClick(Sender: TObject);
    procedure Bot_SpostaVerticeClick(Sender: TObject);
    procedure Bot_InsVertClick(Sender: TObject);
    procedure Bot_cancellaVtClick(Sender: TObject);
    procedure But_MatchClick(Sender: TObject);
    procedure But_SpostaSelectedClick(Sender: TObject);
    procedure But_CopiaSelectedClick(Sender: TObject);
    procedure But_RuotaSelectedClick(Sender: TObject);
    procedure But_ScalaSelectedClick(Sender: TObject);
    procedure But_FixCentroVetClick(Sender: TObject);
    procedure but_ScaDisegnoClick(Sender: TObject);
    procedure but_RuotaDisegnoClick(Sender: TObject);
    procedure but_SpoXDisegnoClick(Sender: TObject);
    procedure but_SpoYDisegnoClick(Sender: TObject);
    procedure Spin_ScaVetDownClick(Sender: TObject);
    procedure Spin_ScaVetUpClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
    procedure SpinButton3DownClick(Sender: TObject);
    procedure SpinButton3UpClick(Sender: TObject);
    procedure Gau_ScaVChange(Sender: TObject);
    procedure Gau_RotVChange(Sender: TObject);
    procedure Gau_SpoXVChange(Sender: TObject);
    procedure Gau_SpoYVChange(Sender: TObject);
    procedure Bot_informselClick(Sender: TObject);
    procedure Bot_SimboloClick(Sender: TObject);
    procedure SalvaInfocorrente1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Bot_SpstaVectorDlgClick(Sender: TObject);
    procedure ListBoxRastGRMouseLeave(Sender: TObject);
    procedure Bot_TabellaTerreniClick(Sender: TObject);
    procedure Bot_ProprietariClick(Sender: TObject);
    procedure Bot_TaresClick(Sender: TObject);
    procedure Bot_IMUClick(Sender: TObject);
    procedure But_PossessiTuttiClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure GeneraDisegnoStradeAnagrafe1Click(Sender: TObject);
    procedure But_TrovaFoglioClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure olfa1Click(Sender: TObject);
    procedure MaglianoSabina1Click(Sender: TObject);
    procedure ImportStradeMagliano1Click(Sender: TObject);
    procedure SalvaDatiImmobili1Click(Sender: TObject);
    procedure Fondidisegni1Click(Sender: TObject);
    procedure But_GestRasterClick(Sender: TObject);
    procedure But_GestVettClick(Sender: TObject);
    procedure Spessore2atuttiipiani1Click(Sender: TObject);
    procedure vedopallinivertici1Click(Sender: TObject);
    procedure VedopalliniverticiFinali1Click(Sender: TObject);
    procedure Bot_CivOnOffClick(Sender: TObject);
    procedure Bot_CCivicoClick(Sender: TObject);
    procedure mettiCivici1Click(Sender: TObject);
    procedure RiordinoNomeStrade1Click(Sender: TObject);
    procedure PolyTuttopenDown1Click(Sender: TObject);
    procedure RiordinoAlfabeticodisegno1Click(Sender: TObject);
    procedure NomigraficiaStrade1Click(Sender: TObject);
    procedure MettiCivici2Click(Sender: TObject);
    procedure But_spostacivicoClick(Sender: TObject);
    procedure Bot_CivDisassociatiClick(Sender: TObject);
    procedure Bot_stradaletxtClick(Sender: TObject);
    procedure But_editTestoClick(Sender: TObject);
    procedure Bot_RilievoClick(Sender: TObject);
    procedure Bot_ConcessioniClick(Sender: TObject);
    procedure Bot_contrattiClick(Sender: TObject);
    procedure catastoselezionabileInfo1Click(Sender: TObject);
    procedure CopiaalPianoCorrente1Click(Sender: TObject);
    procedure But_makePartContrattoClick(Sender: TObject);
    procedure agliaPoligono1Click(Sender: TObject);
    procedure But_clearTerClick(Sender: TObject);
    procedure bot_ConcessionidisClick(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure InproduzionedisConcessioni1Click(Sender: TObject);
    procedure But_RighelloClick(Sender: TObject);
    procedure StampaAreainScala1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpostaTerritorioconptcoordattivo1Click(Sender: TObject);
    procedure salvaterritoriorot1Click(Sender: TObject);
    procedure PolyinPoligonialDisCorrente1Click(Sender: TObject);
    procedure EliminapianiOff1Click(Sender: TObject);
    procedure EliminaPianiOn1Click(Sender: TObject);
    procedure FondiTuttoalPrimoPiano1Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure BotTestCVClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

var
  ColorAlgebraReg: TBlendReg;


implementation

{$R *.dfm}

uses   InitApply,varbase,Interfaccia, uviste,uRaster,uVector,progetto , disegnoR,
  DisegnoV, Dlg_Fabbricato , proiezioni, funzioni, dlgAnagrafe  ,CatastoV   , piano ,SoggettoConcessione


 , Dlg_Griglia, Dlg_Crocicchi, Dlg_Testo, Dlg_Simbolo, Dlg_Terreno,
  Dlg_Soggetti, Dlg_Tares, Dlg_possessiTutti, Dlg_TrovaFoglioParticella,
  Dlg_ImportTracciato, Dlg_Imu, Dlg_Raster, Dlg_Vector, dlg_soggettiConcessioni,
  dlg_contrattiConcessioni, Dlg_stampa;




procedure TMainForm.agliaPoligono1Click(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_TagliaPoligono);
end;

procedure TMainForm.BaseSchermoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
  var bot : Integer;
begin
  case Button of
    mbLeft    : bot := 0;
    mbRight   : bot := 1;
    mbMiddle  : bot := 2;
  end;
   ilProgetto.mouseDown(BaseSchermo ,Bot,Shift   ,X,Baseschermo.Height-Y);
end;

procedure TMainForm.BaseSchermoMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
begin
 MyMouseMove(Baseschermo, Shift, X,Baseschermo.Height-Y);
// label2.Caption := floatTostr(yoriginevista);

// MyTestMove(X,Baseschermo.Height-Y);
end;

procedure TMainForm.BaseSchermoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin

  if Button = mbMiddle then
   begin
    ilProgetto.MiddleMouseUp(BaseSchermo ,Shift   ,X,Baseschermo.Height-Y);
   end;
end;

procedure TMainForm.BaseSchermoResize(Sender: TObject);
begin
 Baseschermo.Bitmap.SetSize(Baseschermo.Width,Baseschermo.Height);
 Hschermo :=baseschermo.Height;
 Wschermo :=baseschermo.Width;
end;

procedure TMainForm.Bot_snapFineClick(Sender: TObject);
begin
 sw_snapFine; // interfaccia
end;

procedure TMainForm.Fondidisegni1Click(Sender: TObject);
begin
 FondiDisegni;
end;

procedure TMainForm.FondiTuttoalPrimoPiano1Click(Sender: TObject);
begin
 Ilprogetto.FondiTuttoPrimoPiano;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  faseAperturaProgramma:=true;
 DecimalSeparator :='.';

 directoryapertura :=      ExtractFilePath(Application.ExeName);
 initvarbase;
 initApply_create;
 windowState:=wsMaximized;
 baseschermo.SetupBitmap;
 tumbnail.SetupBitmap;
 BaseSchermoResize(sender);
 ridisegnaInterfaccia;
  faseAperturaProgramma:=False;
 caricaInterfacciaPersonalizzata;
// showmessage(DirImmaginiComune);
end;


procedure TMainForm.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if MousePos.X<BaseSchermo.Width then MyMouseWeel(WheelDelta,Shift,MousePos.X,(height-16)-MousePos.Y);
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
 ridimensionaMessagger;
 if ilProgetto<>nil then ilProgetto.Disegna(baseschermo,false);
 Hschermo :=baseschermo.Height;
 Wschermo :=baseschermo.Width;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
 if ilProgetto<>nil then
  begin
   ilProgetto.Disegna(baseschermo,false);
   if (IlProgetto.TerrenoGR= nil) then IlProgetto.CaricaTerritorio;
  end;
 Hschermo :=baseschermo.Height;

//  Dlg_InfoFabbricato.show;
    Edit_Fittizio.SetFocus;

end;

procedure TMainForm.Gau_RasterGRChange(Sender: TObject);
begin
 if ilProgetto.GRCorrente=nil then exit;
 ilProgetto.GRCorrente.alpha:= Gau_RasterGR.Position;
 ridisegna;
end;

procedure TMainForm.Gau_RasterTerrenoChange(Sender: TObject);
begin
 if ilProgetto.TerrenoGR=nil then exit;
 ilProgetto.TerrenoGR.alpha:= Gau_RasterTerreno.Position;
 ridisegna;
end;

procedure TMainForm.Gau_RotGRChange(Sender: TObject);
begin
 ilProgetto.updateRotGR(Gau_RotGR.Position);
 LabRotRas.Caption:=IntTostr(Gau_RotGR.Position);
end;

procedure TMainForm.Gau_RotGRMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if IlProgetto.GRCorrente= nil then exit;
 if IlProgetto.GRCorrente.elaborataScaAng_012 = 1 then begin IlProgetto.updateRasExParam; end;
end;

procedure TMainForm.Gau_RotVChange(Sender: TObject);
begin
 ilProgetto.updateDisegnoVRot(Gau_RotV.Position);
 Lab_Vrot.Caption:= IntToStr(Gau_RotV.Position);
end;

procedure TMainForm.Gau_LineDisVChange(Sender: TObject);
begin
 ilProgetto.DisegnoVCorrente.alfalinee:= Gau_LineDisV.Position;
 ridisegna;
end;

procedure TMainForm.Gau_LinePianoChange(Sender: TObject);
begin
 ilProgetto.PianoCorrente.alfalinee:= Gau_LinePiano.Position;
 ridisegna;
end;

procedure TMainForm.Gau_ScalaGRChange(Sender: TObject);
begin
 ilProgetto.updateScalaGR(Gau_ScalaGR.Position);
 LabScaRas.Caption:= IntToStr(Gau_ScalaGR.Position);
end;

procedure TMainForm.Gau_ScalaGRMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if IlProgetto.GRCorrente= nil then exit;
 if IlProgetto.GRCorrente.elaborataScaAng_012 = 2 then begin IlProgetto.updateRasExParam; end;
end;

procedure TMainForm.Gau_ScaVChange(Sender: TObject);
begin
 ilProgetto.updateScalaV(Gau_ScaV.Position);
 Lab_Vsca.Caption:= IntToStr(Gau_ScaV.Position);
end;

procedure TMainForm.Gau_SpoXVChange(Sender: TObject);
begin
 ilProgetto.updateDisegnoVSpoX(Gau_SpoXV.Position);
 Lab_VspoX.Caption:= IntToStr(Gau_SpoXV.Position);
end;

procedure TMainForm.Gau_SpoYVChange(Sender: TObject);
begin
 ilProgetto.updateDisegnoVSpoY(Gau_SpoYV.Position);
 Lab_VspoY.Caption:= IntToStr(Gau_SpoYV.Position);
end;

procedure TMainForm.Gau_SupDisVChange(Sender: TObject);
begin
 ilProgetto.DisegnoVCorrente.alfasuperfici:= Gau_SupDisV.Position;
 ridisegna;
end;

procedure TMainForm.Gau_SupPianoChange(Sender: TObject);
begin
 ilProgetto.PianoCorrente.alfasuperfici:= Gau_SupPiano.Position;
 ridisegna;
end;

procedure TMainForm.GeneraDisegnoStradeAnagrafe1Click(Sender: TObject);
begin
  IlProgetto.CreareDisegnoStradeDaAnagrafe;
  ridisegnainterfaccia;
  ridisegna;
end;

procedure TMainForm.ImgView321MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
 // beep;
end;

procedure TMainForm.ImportStradeMagliano1Click(Sender: TObject);
begin
 aprostradeMagliano:= true;
 But_AprivettClick(sender);
 aprostradeMagliano:= false;
end;

procedure TMainForm.InproduzionedisConcessioni1Click(Sender: TObject);
begin
 Inconcessioniproduction := not(Inconcessioniproduction);
end;

procedure TMainForm.ListBoxDisChange(Sender: TObject);
begin
 ilProgetto.cambiadisegnocorrente(ListBoxDis.ItemIndex);
end;

procedure TMainForm.ListBoxPianChange(Sender: TObject);
begin
  ilProgetto.cambiaPianoCorrente(ListBoxPian.ItemIndex);
  ridisegnaInterfaccia;
end;

procedure TMainForm.ListBoxRastGRChange(Sender: TObject);
begin
 ilProgetto.cambiaGRcorrente(ListBoxRastGR.ItemIndex);
end;

procedure TMainForm.ListBoxRastGRMouseLeave(Sender: TObject);
begin
 Edit_Fittizio.SetFocus;
end;

procedure TMainForm.MaglianoSabina1Click(Sender: TObject);
begin
 ImpostaComuneSetUp(1);
end;

procedure TMainForm.mettiCivici1Click(Sender: TObject);
begin
 apriCatasto;
 IlProgetto.Vista_ZoomTuttosePrimo;
 Bot_terreniOnClick(sender);
 Ilprogetto.OpenInfoTributiAnagrafe;
 ApriStrade ('D:\Magliano_Sabina\Dati\DisegniV\strade.macmap');
 IlProgetto.mettiCiviciAnagrafe;
 ridisegnaInterfaccia;
 ridisegna;
end;

procedure TMainForm.MettiCivici2Click(Sender: TObject);
begin
 apriCatasto;
 IlProgetto.Vista_ZoomTuttosePrimo;
 Bot_terreniOnClick(sender);
 Ilprogetto.OpenInfoTributiAnagrafe;
 ApriStrade ('D:\Magliano_Sabina\Dati\DisegniV\strade.macmap');
 IlProgetto.mettiCiviciCatasto;
 ridisegna;
end;

procedure TMainForm.NomigraficiaStrade1Click(Sender: TObject);
begin
 ApriStrade ('D:\Magliano_Sabina\Dati\DisegniV\strade.macmap');
 IlProgetto.FaiDisegnoNomiStrade;
end;

procedure TMainForm.olfa1Click(Sender: TObject);
begin
 ImpostaComuneSetUp(2);
end;

procedure TMainForm.Panel_ColorPianoClick(Sender: TObject);
var pianocorrente : TPiano;
begin
 ColorDialog1.Color:=   Panel_ColorPiano.Color;
 if ColorDialog1.Execute then
  begin
   Panel_ColorPiano.Color := ColorDialog1.Color;
   if IlProgetto.PianoCorrente <>nil then begin
    IlProgetto.Pianocorrente._rosso    := Panel_ColorPiano.Color and $ff;
    IlProgetto.Pianocorrente._verde    := (Panel_ColorPiano.Color and $ff00) shr 8;
    IlProgetto.Pianocorrente._Blu      := (Panel_ColorPiano.Color and $ff0000) shr 16;
    ridisegna;
   end;
  end;
end;

procedure TMainForm.PolyinPoligonialDisCorrente1Click(Sender: TObject);
begin
   Ilprogetto.polytoPoligonoDisegno;
end;

procedure TMainForm.PolyTuttopenDown1Click(Sender: TObject);
begin
 IlProgetto.PenDownDiscorrente;
end;

procedure TMainForm.RiordinoAlfabeticodisegno1Click(Sender: TObject);
begin
 ApriStrade ('D:\Magliano_Sabina\Dati\DisegniV\strade.macmap');
 LeStradeV := IlProgetto.ListaDisegniV.Items[IlProgetto.ListaDisegniV.count-1];
   LeStradeV.RiordinaPianiAlfateticamente;
end;

procedure TMainForm.RiordinoNomeStrade1Click(Sender: TObject);
begin
 ApriStrade ('D:\Magliano_Sabina\Dati\DisegniV\strade.macmap');
 risistemaNomiStrade; // uvector
 ridisegna;
end;

procedure TMainForm.Bot_Coord5Click(Sender: TObject);
begin
 CambiaProiezione(5);
end;

procedure TMainForm.Bot_CPLineaClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_Polilinea);
end;

procedure TMainForm.Bot_CPoligonoClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_Poligono);
end;

procedure TMainForm.Bot_CPuntoClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_Punto);
end;

procedure TMainForm.Bot_CRegioneClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_Regione);
end;

procedure TMainForm.Bot_DisEditabileClick(Sender: TObject);
begin
 ilProgetto.DisegnoVCorrente.b_editabile := Not(Bot_DisEditabile.Down);
end;

procedure TMainForm.Bot_DisSnappabileClick(Sender: TObject);
begin
 ilProgetto.DisegnoVCorrente.b_snappabile := Not(Bot_DisSnappabile.Down);
end;

procedure TMainForm.Bot_NuovoPianoClick(Sender: TObject);
begin
  IlProgetto.DisegnoVCorrente.addLayerCorrente('#_'+IntTostr(IlProgetto.DisegnoVCorrente.ListaPiani.count));
  ridisegnaInterfaccia;
end;

procedure TMainForm.Bot_PianoeditabileClick(Sender: TObject);
begin
 ilProgetto.PianoCorrente.b_editabile := Not(Bot_Pianoeditabile.Down);
end;

procedure TMainForm.Bot_PianoSnappabileClick(Sender: TObject);
begin
 ilProgetto.PianoCorrente.b_snappabile := Not(Bot_PianoSnappabile.Down);
end;

procedure TMainForm.Bot_ProprietariClick(Sender: TObject);
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
//   Form_Soggetti.mododisegna :=1;
   Form_Soggetti.show;
   Form_Soggetti.disegnalocale;
end;

procedure TMainForm.Bot_QUnioneClick(Sender: TObject);
begin
 apriQUCatasto;
 IlProgetto.Vista_ZoomTuttosePrimo;
 ridisegna;
end;

procedure TMainForm.Bot_Coord4Click(Sender: TObject);
begin
 CambiaProiezione(4);
end;

procedure TMainForm.Bot_AnagrafeClick(Sender: TObject);
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
 formAnagrafe.show;
end;

procedure TMainForm.Bot_cancellaVtClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_CancellaVertice);
end;

procedure TMainForm.Bot_CCerchioClick(Sender: TObject);
begin
  ilProgetto.IniziaComando(kStato_Cerchio);
end;

procedure TMainForm.Bot_CCivicoClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_Civico);
end;

procedure TMainForm.Bot_CivDisassociatiClick(Sender: TObject);
begin
// IlProgetto.civiciNonAssociati;
 IlProgetto.civiciSnc;
 ridisegna;
end;

procedure TMainForm.Bot_CivOnOffClick(Sender: TObject);
begin
 TxtCatastoOnOff := not(TxtCatastoOnOff);
 ridisegna;
end;

procedure TMainForm.Bot_Coord1Click(Sender: TObject);
begin
 CambiaProiezione(1);
end;

procedure TMainForm.Bot_Coord2Click(Sender: TObject);
begin
 CambiaProiezione(2);
end;

procedure TMainForm.Bot_Coord3Click(Sender: TObject);
begin
 CambiaProiezione(3);
end;

procedure TMainForm.But_openCatastoClick(Sender: TObject);
begin
 apriCatasto;
 IlProgetto.Vista_ZoomTuttosePrimo;
 Bot_terreniOnClick(sender);
// ridisegna;
end;

procedure TMainForm.But_openRasterClick(Sender: TObject);
begin
 ApriImmaginedaDialog;
 IlProgetto.Vista_ZoomTuttosePrimo;
// IlProgetto.ZoomGRCorrente;
// ridisegnaInterfaccia;
 ridisegna;
end;

procedure TMainForm.But_PossessiTuttiClick(Sender: TObject);
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
 Form_PossessiTutti.mododisegna:=1;
   Form_PossessiTutti.show;
   Form_PossessiTutti.disegna;
end;

procedure TMainForm.But_RighelloClick(Sender: TObject);
begin
  ilProgetto.IniziaComando(kStato_DistRighello);
end;

procedure TMainForm.but_RuotaDisegnoClick(Sender: TObject);
begin
  ricentraRotV;
end;

procedure TMainForm.But_RuotaSelectedClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_RuotaSelected);
end;

procedure TMainForm.but_ScaDisegnoClick(Sender: TObject);
begin
 ricentraScaV;
end;

procedure TMainForm.But_vedoRClick(Sender: TObject);
begin
 ilProgetto.RCorrente.b_visibile := Not(But_vedoR.Down);
 ridisegna;
end;

procedure TMainForm.Bot_ZoomLastClick(Sender: TObject);
begin
 IlProgetto.Vista_ZoomUltima;
end;


function ColorAlgebraEx(F, B, M: TColor32): TColor32;
begin
  // Call the coloralgebra routine in action, restore foreground alpha and blend
  Result := BlendRegEx(ColorAlgebraReg(F, B) and $FFFFFF or F and $FF000000, B, M);
end;

procedure TMainForm.But_AprivettClick(Sender: TObject);
begin
 ApriDisegnodaDialog; // uVector
// IlProgetto.Vista_ZoomTutto;
 IlProgetto.Vista_ZoomTuttosePrimo;
 ridisegnaInterfaccia;
 ridisegna;
end;

procedure TMainForm.But_clearTerClick(Sender: TObject);
begin
 IlCatastoV.toglifabterselezionati;
 ridisegna;
end;

procedure TMainForm.But_CopiaSelectedClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_CopiaSelected);
end;

procedure TMainForm.But_editTestoClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kstato_editText);
end;

procedure TMainForm.But_GestRasterClick(Sender: TObject);
begin
 Form_GestRaster.showmodal;
end;

procedure TMainForm.But_GestVettClick(Sender: TObject);
begin
 Form_GestVettoriale.show;
end;

procedure TMainForm.But_TogliDisvettClick(Sender: TObject);
var locdisv: TDisegnoV;
begin
// se confermato
 if Ilprogetto.ListaDisegniV.Count>1 then
  begin
   locdisV := Ilprogetto.ListaDisegniV[Ilprogetto.indDisVcorrente];
   Interf_ToltoDisegnoV(locdisV.nomedisegnoconPath);
   Ilprogetto.ListaDisegniV.delete(Ilprogetto.indDisVcorrente);
   if Ilprogetto.indDisVcorrente>0 then dec(Ilprogetto.indDisVcorrente);
//  if Ilprogetto.ListaDisegniV.Count>0 then ilprogetto.DisegnoVCorrente :=ilprogetto.ListaDisegniV[ilprogetto.indDisVcorrente]
//                                       else  ilprogetto.VCorrente := nil;
   locdisV.svuota;
   locdisV.Free;
   ridisegnaInterfaccia;
   ridisegna;
  end
   else
  begin
   if Ilprogetto.ListaDisegniV.Count=1 then
    begin
     locdisV := Ilprogetto.ListaDisegniV[Ilprogetto.indDisVcorrente];
     locdisV.riazzera;
     ridisegnaInterfaccia;
     ridisegna;
    end;
  end;
end;

procedure TMainForm.Bot_Rot0Click(Sender: TObject);
begin
 if IlProgetto.GRCorrente<> nil then begin IlProgetto.GRCorrente.setangolorot_0; ridisegna; ridisegnainterfaccia; end;
end;

procedure TMainForm.Bot_saveGRClick(Sender: TObject);
begin
 if Ilprogetto.GrCorrente<>nil then Ilprogetto.GrCorrente.salvaCollaterale;
end;

procedure TMainForm.Bot_Sca1Click(Sender: TObject);
begin
 if IlProgetto.GRCorrente<> nil then begin IlProgetto.GRCorrente.setScala_1; ridisegna; ridisegnainterfaccia; end;
end;

procedure TMainForm.SalvaDatiImmobili1Click(Sender: TObject);
begin
 IlProgetto.SalvaImmobiliDati;
end;

procedure TMainForm.SalvaInfocorrente1Click(Sender: TObject);
begin
  IlProgetto.SalvaInfoCorrenteGR;
end;

procedure TMainForm.salvaterritoriorot1Click(Sender: TObject);
begin
  salvarotTerritorioAttivo := true;
end;

procedure TMainForm.Bot_ConcessioniClick(Sender: TObject);
begin
 Ilprogetto.OpenConcessioni;
 Form_sogConc.show;
end;

procedure TMainForm.But_FixCentroVetClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_FixCentroRotVettoriale);
end;

procedure TMainForm.Bot_SimboloClick(Sender: TObject);
begin
 Form_Simbolo.show;
end;

procedure TMainForm.Bot_rettangoloClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_Rettangolo);
end;

procedure TMainForm.bot_ConcessionidisClick(Sender: TObject);
begin
 Ilprogetto.OpenConcessioni;
 Ilprogetto.TuttidisegniConcessioni;
end;

procedure TMainForm.Bot_TestoClick(Sender: TObject);
begin
  Form_Text.ShowModal;
end;

procedure TMainForm.SpeedButton16Click(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_InfoConcessione);
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
 salvadisegnocondialog;
end;

procedure TMainForm.Bot_CropRasterClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_CropRasterRettangolo);
end;

procedure TMainForm.SpeedButton20Click(Sender: TObject);
begin
 IlProgetto.ZoomRCorrente;
 ridisegna;
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
var oldview : Boolean;
begin
  oldview := Panel_Right.visible;
  Panel_Comune.Visible := false;
  Panel_Right.visible :=false;
  Panel_Right.visible :=oldview;
  Panel_Raster.Visible:= not Panel_Raster.Visible;
  Panel_Comune.Visible := true;
  ridisegna;
end;

procedure TMainForm.Bot_RasterCrocicchiClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_Calibraraster);
 Form_Crocicchi.svuota;
// Form_Crocicchi.showmodal;
end;

procedure TMainForm.Bot_Raster2SegmentiClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_rotoscalaraster);
end;

procedure TMainForm.Bot_FixCentroCalRasClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_FixCentroRot);
end;

procedure TMainForm.Bot_GrigliaClick(Sender: TObject);
begin
    IlProgetto.vedogriglia := not(IlProgetto.vedogriglia);
    ridisegna;
end;

procedure TMainForm.Bot_GrigliaSetUpClick(Sender: TObject);
begin
 if not(Bot_griglia.Down) then
   begin Bot_griglia.Down:=true; Bot_GrigliaClick(Sender); end;
 Form_Griglia.show;
end;

procedure TMainForm.Bot_resetRotGRClick(Sender: TObject);
begin
  ricentraRotGR;
end;

procedure TMainForm.Bot_resetScalaGRClick(Sender: TObject);
begin
 ricentraScaGR;
end;

procedure TMainForm.SpeedButton39Click(Sender: TObject);
begin
 ilProgetto.NuovoDisegno;
end;

procedure TMainForm.SpeedButton3Click(Sender: TObject);
var oldview : Boolean;
begin
  oldview := Panel_Raster.visible;
  Panel_Comune.Visible := false;
  Panel_Raster.visible :=false;
  Panel_Right.visible := not Panel_Right.visible;
  Panel_Raster.visible :=oldview;
  Panel_Comune.Visible := true;
 ridisegna;
end;

procedure TMainForm.Bot_SelezionaClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_Seleziona);
end;

procedure TMainForm.SpeedButton4Click(Sender: TObject);
begin
  Form_Tracciato.show;
end;

procedure TMainForm.Bot_ZoomPanClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_Pan);
end;

procedure TMainForm.Bot_zoomPianoClick(Sender: TObject);
begin
 setZoomPianoVector;
 ridisegna;
end;

procedure TMainForm.Bot_ZoomWindowClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_zoomWindow);
end;

procedure TMainForm.SpeedButton50Click(Sender: TObject);
begin
 ilProgetto.deseleziona;
 updateNumSelezionati;
 ridisegna;
end;

procedure TMainForm.Bot_informselClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_Info);
end;

procedure TMainForm.But_ScalaSelectedClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_ScalaSelected);
end;

procedure TMainForm.But_SpostaSelectedClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_SpostaSelected);
end;

procedure TMainForm.but_SpoXDisegnoClick(Sender: TObject);
begin
  ricentraSpoXV;
end;

procedure TMainForm.but_SpoYDisegnoClick(Sender: TObject);
begin
  ricentraSpoYV;
end;

procedure TMainForm.But_MatchClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_Match);
end;

procedure TMainForm.Bot_cancselClick(Sender: TObject);
begin
 IlProgetto.cancellatuttiSelezionati;
 ridisegna;
end;

procedure TMainForm.SpeedButton5Click(Sender: TObject);
begin
 ilProgetto.Vista_Zoommeno;
end;

procedure TMainForm.SpeedButton6Click(Sender: TObject);
var
  DC: THandle; // display context
  Bits: integer; // bits per pixel
  HRes: integer; // horizontal resolution
  VRes: integer; // vertical resolution
  HResmm: integer; // horizontal resolution
  VResmm: integer; // vertical resolution
  scaloscr : Real;
  newscale : Real;
  coda : Integer;
begin
  DC := GetDC(Handle);
    Bits := GetDeviceCaps(DC, BITSPIXEL);
    HRes := GetDeviceCaps(DC, HORZRES);
    VRes := GetDeviceCaps(DC, VERTRES);
    HResmm := GetDeviceCaps(DC, HORZSIZE);
    VResmm := GetDeviceCaps(DC, VERTSIZE);
  ReleaseDC(Handle, DC); // Show all modes available ModeNum := 0; // The 1st one
    scaloscr := HResmm/HRes;
    val (ComboScala.Text,newscale, coda);
    ScalaSchermo(scaloscr,newscale);
    Edit_Fittizio.SetFocus;
end;

procedure TMainForm.SpeedButton7Click(Sender: TObject);
begin
 IlProgetto.Consessioniselezionati;
 ridisegna;
end;

procedure TMainForm.BotTestCVClick(Sender: TObject);
begin
 Panel_Tributi.Visible := not(Panel_Tributi.Visible);
 Pan_Conf1.Visible := not(Pan_Conf1.Visible);
end;

procedure TMainForm.But_makePartContrattoClick(Sender: TObject);
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
 CopiaParticelleinConcessione;
end;

procedure TMainForm.Bot_contrattiClick(Sender: TObject);
begin
 Ilprogetto.OpenConcessioni;
 SoggettoConcessionarioCorrente := nil;
 Form_contrattiConcessioni.infiltro :=false;
 Form_contrattiConcessioni.show;
 Form_contrattiConcessioni.disegnaLocale;
end;

procedure TMainForm.Bot_SpostaVerticeClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_SpostaVertice);
end;

procedure TMainForm.Bot_IMUClick(Sender: TObject);
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
   Form_Imu.show;
   Form_Imu.disegna;
end;

procedure TMainForm.Bot_InsVertClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_InserisciVertice);
end;

procedure TMainForm.But_TogliRasterClick(Sender: TObject);
begin
  IlProgetto.TogliGRCorrente;
  ridisegna;
end;

procedure TMainForm.But_TrovaFoglioClick(Sender: TObject);
begin
 Form_TrovaFoglioParticella.show;
end;

procedure TMainForm.But_vedoGRClick(Sender: TObject);
begin
 if ilProgetto.GRCorrente<>nil then
  begin
   ilProgetto.GRCorrente.visibile := But_vedoGR.Down;
   ridisegna;
  end;
end;

procedure TMainForm.But_ZoomGRClick(Sender: TObject);
begin
 IlProgetto.ZoomGRCorrente;
 ridisegna;
end;

procedure TMainForm.catastoselezionabileInfo1Click(Sender: TObject);
begin
 catastoselezonabile := not catastoselezonabile;
end;

procedure TMainForm.Ck_CalTerritorioClick(Sender: TObject);
begin
 IlProgetto.GRCorrente:= IlProgetto.TerrenoGR;
end;

procedure TMainForm.CopiaalPianoCorrente1Click(Sender: TObject);
begin
 CopiaSelezionatialPianoCorrente;
end;

procedure TMainForm.EliminapianiOff1Click(Sender: TObject);
begin
 IlProgetto.eliminaPianiOff;
 ridisegna;
 ridisegnaInterfaccia;
end;

procedure TMainForm.EliminaPianiOn1Click(Sender: TObject);
begin
 IlProgetto.eliminaPianiON;
 ridisegna;
 ridisegnaInterfaccia;
end;

procedure TMainForm.errenoGrCoorente1Click(Sender: TObject);
begin
 IlProgetto.GRCorrente := IlProgetto.TerrenoGR;
end;

procedure TMainForm.Bot_TerritorioClick(Sender: TObject);
begin
 Ilprogetto.vedoterreno := Not(Ilprogetto.vedoterreno);
 if Ilprogetto.vedoterreno then IlProgetto.Vista_ZoomTuttosePrimo;
 ridisegna;
end;

procedure TMainForm.But_spostacivicoClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_SpostaPosCivico);
end;

procedure TMainForm.SpeedButton9Click(Sender: TObject);
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
 ilProgetto.IniziaComando(kStato_InfoEdificio);
end;

procedure TMainForm.Spessore2atuttiipiani1Click(Sender: TObject);
begin
 IlProgetto.Spessore2AiPiani;
end;

procedure TMainForm.Bot_RighelloRasterClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_scalarighello);
end;

procedure TMainForm.Bot_RilievoClick(Sender: TObject);
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
 if SaveRilievo.Execute then IlProgetto.StampaRilievo(  SaveRilievo.FileName);
end;

procedure TMainForm.SpinButton1DownClick(Sender: TObject);
begin
 IlProgetto.VectParamRot2mezzi(-1);
end;

procedure TMainForm.SpinButton1UpClick(Sender: TObject);
begin
 IlProgetto.VectParamRot2mezzi(1);
end;

procedure TMainForm.SpinButton2DownClick(Sender: TObject);
begin
 IlProgetto.VectParamSpoX2mezzi(-1);
end;

procedure TMainForm.SpinButton2UpClick(Sender: TObject);
begin
 IlProgetto.VectParamSpoX2mezzi(1);
end;

procedure TMainForm.SpinButton3DownClick(Sender: TObject);
begin
 IlProgetto.VectParamSpoY2mezzi(-1);
end;

procedure TMainForm.SpinButton3UpClick(Sender: TObject);
begin
 IlProgetto.VectParamSpoY2mezzi(1);
end;

procedure TMainForm.Spin_rotGrDownClick(Sender: TObject);
begin
 IlProgetto.RasExParamRot2mezzi(-1);
end;

procedure TMainForm.Spin_rotGrUpClick(Sender: TObject);
begin
 IlProgetto.RasExParamRot2mezzi(1);
end;

procedure TMainForm.Spin_ScaGRDownClick(Sender: TObject);
begin
 IlProgetto.RasExParamSca2mezzi(-1);
end;

procedure TMainForm.Spin_ScaGRUpClick(Sender: TObject);
begin
 IlProgetto.RasExParamSca2mezzi(1);
end;

procedure TMainForm.Spin_ScaVetDownClick(Sender: TObject);
begin
 IlProgetto.VectParamSca2mezzi(-1);
end;

procedure TMainForm.Spin_ScaVetUpClick(Sender: TObject);
begin
 IlProgetto.VectParamSca2mezzi(1);
end;

procedure TMainForm.SpostaTerritorioconptcoordattivo1Click(Sender: TObject);
begin
 spostoTerritorioAttivo := true;
end;

procedure TMainForm.SpostaTerritorioPteCoord1Click(Sender: TObject);
begin
 ilProgetto.IniziaComando(kstato_spostaTerritorioPrCoord);
end;

procedure TMainForm.StampaAreainScala1Click(Sender: TObject);
begin
 Form_Stampa.showmodal;
end;

procedure TMainForm.vedopallinivertici1Click(Sender: TObject);
begin
   vedopallinivertici       := not (vedopallinivertici);
  ridisegna;
end;

procedure TMainForm.VedopalliniverticiFinali1Click(Sender: TObject);
begin
  vedopalliniverticiFinali := not(vedopalliniverticiFinali);
  ridisegna;
end;

procedure TMainForm.Bot_TabellaFabbricatiClick(Sender: TObject);
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
 Dlg_InfoFabbricato.mododisegna:=0;
 Dlg_InfoFabbricato.show;
 Dlg_InfoFabbricato.disegna;
end;

procedure TMainForm.Bot_TabellaTerreniClick(Sender: TObject);
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
   Dlg_InfoTerreno.mododisegna:=0;
   Dlg_InfoTerreno.show;
   Dlg_InfoTerreno.disegna;
end;

procedure TMainForm.Bot_TaresClick(Sender: TObject);
begin
 Ilprogetto.OpenInfoTributiAnagrafe;
   Form_Tares.show;
   Form_Tares.disegna;
end;

procedure TMainForm.Bot_SpostaRasterClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_spostaRaster_uno);
end;

procedure TMainForm.Bot_SpstaRasterDlgClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_spostaRaster2pt_tutti);
end;

procedure TMainForm.Bot_SpstaVectorDlgClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_SpostaDisegnoptDlg);
end;

procedure TMainForm.Bot_stradaletxtClick(Sender: TObject);
begin
 ilProgetto.IniziaComando(kStato_txtstradale);
end;

procedure TMainForm.Bot_terreniOnClick(Sender: TObject);
begin
 IlCatastoV.cambiavedoterreni;
 ridisegna;
end;

procedure TMainForm.Bot_ZoomPiuClick(Sender: TObject);
begin
 ilProgetto.Vista_Zoompiu;
end;

procedure TMainForm.Bot_ZoomTuttoClick(Sender: TObject);
begin
 IlProgetto.Vista_ZoomTutto;
 ridisegna;
end;

procedure TMainForm.Bot_zoomVDisegnoClick(Sender: TObject);
begin
 setZoomDisegnoVCorrente;
 ridisegna;
end;

procedure TMainForm.Bot_snapOrtoClick(Sender: TObject);
begin
 sw_snapOrto; // interfaccia
end;

procedure TMainForm.Bot_snapOrtosegClick(Sender: TObject);
begin
 sw_snaportoSeg; // interfaccia
end;

procedure TMainForm.Bot_snapVicinoClick(Sender: TObject);
begin
 sw_snapVicino; // Interface
end;

procedure TMainForm.Bot_VisibileDisVClick(Sender: TObject);
begin
 ilProgetto.DisegnoVCorrente.b_visibile := Bot_VisibileDisV.Down;
 ridisegna;
end;

procedure TMainForm.Bot_VisibilePianoClick(Sender: TObject);
begin
 ilProgetto.PianoCorrente.b_visibile := Not(Bot_VisibilePiano.Down);
 ridisegna;
end;

procedure TMainForm.Bot_snapGrigliaClick(Sender: TObject);
begin
  sw_snapGriglia // Interfaccia
end;

procedure TMainForm.Bot_snapOffClick(Sender: TObject);
begin
  sw_snapAllOff // Interfaccia
end;

end.

//    OutputDebugString(PChar(Mainform.openraster.FileName+ ' -----------------            Passa     -------------     '));

