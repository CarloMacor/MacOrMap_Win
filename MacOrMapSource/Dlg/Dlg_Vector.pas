unit Dlg_Vector;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  GR32_RangeBars, AdvScrollBox;

type
  TForm_GestVettoriale = class(TForm)
    Panel1: TPanel;
    But_UpDis: TSpeedButton;
    But_DownDis: TSpeedButton;
    Panel3: TPanel;
    But_UpPiano: TSpeedButton;
    But_DownPiano: TSpeedButton;
    PanelPiani: TAdvScrollBox;
    Pannello: TAdvScrollBox;
    ColorDialog1: TColorDialog;
    List_Piani: TListBox;
    Label1: TLabel;
    Edit_Nomepiano: TEdit;
    Bot_rename: TSpeedButton;
    Bot_CancellaPiano: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Gauge_punto: TGaugeBar;
    Gauge_spessore: TGaugeBar;
    Bot_VisibileDisP: TSpeedButton;
    But_TuttiOn: TSpeedButton;
    But_TuttiOff: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddedButtonClick(Sender: TObject);
    procedure gauAddedChange(Sender: TObject);
    procedure ComAddedChanged(Sender: TObject);
    procedure List_PianiClick(Sender: TObject);
    procedure Bot_renameClick(Sender: TObject);
    procedure Gauge_spessoreChange(Sender: TObject);
    procedure Gauge_puntoChange(Sender: TObject);
    procedure Bot_CancellaPianoClick(Sender: TObject);
    procedure But_UpDisClick(Sender: TObject);
    procedure But_DownDisClick(Sender: TObject);
    procedure Bot_VisibileDisPClick(Sender: TObject);
    procedure But_TuttiOnClick(Sender: TObject);
    procedure But_TuttiOffClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ListaBotDisNome  : TList;
    ListaBotDisOnOff : TList;
    ListaBotDisEdit  : TList;
    ListaBotDisSnap  : TList;
    ListaGauDisLine  : TList;
    ListaGauDisSup   : TList;

    ListaBotPiaNome  : TList;
    ListaBotPiaColor : TList;
    ListaBotPiaOnOff : TList;
    ListaBotPiaEdit  : TList;
    ListaBotPiaSnap  : TList;
    ListaGauPiaLine  : TList;

    ListaCombPiaPt   : TList;
    ListaCombPiaSpe  : TList;
    ListaCombPiaTrat : TList;


    inesecuzione     : Boolean;

    procedure Localridisegna;
    procedure NuovoDisegnaPiano;

    procedure LocalridisegnaPiano;
    procedure svuota;
    procedure svuotaPiano;
    procedure ridisegnaInfoPiano;
    procedure ImpostaComboPt(ilcombo : TComboBox);

  end;

var
  Form_GestVettoriale: TForm_GestVettoriale;

implementation

{$R *.dfm}
uses disegnoV,piano,progetto,interfaccia, varbase;

procedure TForm_GestVettoriale.FormCreate(Sender: TObject);
begin
    ListaBotDisNome  := TList.create;
    ListaBotDisOnOff := TList.create;
    ListaBotDisEdit  := TList.create;
    ListaBotDisSnap  := TList.create;
    ListaGauDisLine  := TList.create;
    ListaGauDisSup   := TList.create;

    ListaBotPiaNome  := TList.create;
    ListaBotPiaColor := TList.create;
    ListaBotPiaOnOff := TList.create;
    ListaBotPiaEdit  := TList.create;
    ListaBotPiaSnap  := TList.create;
    ListaGauPiaLine  := TList.create;

    ListaCombPiaPt   := TList.create;
    ListaCombPiaSpe  := TList.create;
    ListaCombPiaTrat := TList.create;


end;

procedure TForm_GestVettoriale.FormShow(Sender: TObject);
begin
 inesecuzione := false;
 Localridisegna;
 inesecuzione := true;

end;


procedure TForm_GestVettoriale.NuovoDisegnaPiano;
var k : Integer;
    locdisv : TDisegnoV;
    locpia : TPiano;
begin
  List_Piani.Clear;
  locdisV := ilProgetto.DisegnoVCorrente;
  if locdisV<>nil then
   begin
    for k:=0 to locdisV.ListaPiani.Count-1 do
     begin
      locpia := locdisV.ListaPiani.Items[k];
      List_Piani.Items.Add(locpia.nomepiano);
     end;
    List_Piani.ItemIndex:=locdisV.indPianocorrente;
   end;
  ridisegnaInfoPiano;
end;

procedure TForm_GestVettoriale.LocalridisegnaPiano;
var contaBut    : Integer;
    k           : Integer;
    locdis      : TDisegnoV;
    locpia      : TPiano;
    btnAdded    : TSpeedButton;
    gauAdded    : TGaugeBar;
    PanAdded    : TPanel;
    combAdded   : TComboBox;
    offy,starty : Integer;
begin
  locdis := Ilprogetto.DisegnoVCorrente;
  contaBut := 0;
  offy     := 25;
  starty   := 40;

  for k:=0 to locdis.ListaPiani.Count-1 do
   begin
    locpia := locdis.ListaPiani.items[k];
    inc(contaBut);

    btnAdded := TSpeedButton.Create(Self);
    ListaBotPiaNome.add(btnAdded);
    btnAdded.Name := 'btnAddPiaNome'+IntToStr(contaBut);
    btnAdded.Parent := self.PanelPiani;
    btnAdded.GroupIndex := 7000;
    btnAdded.AllowAllUp := true;
    btnAdded.Left:=10;
    btnAdded.Top:=starty+k*offy;
    btnAdded.Height:=20;
    btnAdded.Width:=120;
    btnAdded.Caption:=locpia.nomepiano;
    btnAdded.OnClick := btnAddedButtonClick;
    if (k = locdis.IndicePianocorrente) then btnAdded.Down:=true else btnAdded.Down:=false;



    PanAdded := TPanel.Create(Self);
    ListaBotPiaColor.add(PanAdded);
    PanAdded.Name := 'panAddPiaColor'+IntToStr(contaBut);
    PanAdded.Parent := self.PanelPiani;
    PanAdded.Left:=135;
    PanAdded.Top:=starty+k*offy;
    PanAdded.parentcolor :=false;
    PanAdded.Color := RGB(locpia._rosso, locpia._verde,locpia._blu);
    PanAdded.Height:=20;
    PanAdded.Width:=20;
    PanAdded.Caption:='';
    PanAdded.OnClick := btnAddedButtonClick;


    btnAdded := TSpeedButton.Create(Self);
    ListaBotPiaOnOff.add(btnAdded);
    btnAdded.Name := 'btnAddPiaOnOff'+IntToStr(contaBut);
    btnAdded.Parent := self.PanelPiani;
    btnAdded.GroupIndex := 8000+contaBut;
    btnAdded.AllowAllUp := true;
    btnAdded.Left:=160;
    btnAdded.Top:=starty+k*offy;
    btnAdded.Height:=20;
    btnAdded.Width:=20;
    btnAdded.Caption:='';
    btnAdded.OnClick := btnAddedButtonClick;
    if locpia.b_visibile then btnAdded.Down:=true else btnAdded.Down:=false;

    gauAdded := TGaugeBar.Create(self);
    ListaGauPiaLine.add(gauAdded);
    gauAdded.Name := 'gauPiaLine'+IntToStr(contaBut);
    gauAdded.Parent := self.PanelPiani;
    gauAdded.Left:=190;
    gauAdded.Top:=starty+k*offy;
    gauAdded.Height:=20;
    gauAdded.Width:=120;
    gauAdded.min:=0;
    gauAdded.max:=255;
    gauAdded.Position := locpia.alfalinee;
    gauAdded.OnChange := gauAddedChange;

    btnAdded := TSpeedButton.Create(Self);
    ListaBotPiaEdit.add(btnAdded);
    btnAdded.Name := 'btnAddPiaEdit'+IntToStr(contaBut);
    btnAdded.Parent := self.PanelPiani;
    btnAdded.GroupIndex := 8000+contaBut;
    btnAdded.AllowAllUp := true;
    btnAdded.Left:=325;
    btnAdded.Top:=starty+k*offy;
    btnAdded.Height:=20;
    btnAdded.Width:=20;
    btnAdded.Caption:='';
    btnAdded.OnClick := btnAddedButtonClick;
    if locpia.b_editabile then btnAdded.Down:=true else btnAdded.Down:=false;

    btnAdded := TSpeedButton.Create(Self);
    ListaBotPiaSnap.add(btnAdded);
    btnAdded.Name := 'btnAddPiaSnap'+IntToStr(contaBut);
    btnAdded.Parent := self.PanelPiani;
    btnAdded.GroupIndex := 9000+contaBut;
    btnAdded.AllowAllUp := true;
    btnAdded.Left:=355;
    btnAdded.Top:=starty+k*offy;
    btnAdded.Height:=20;
    btnAdded.Width:=20;
    btnAdded.Caption:='';
    btnAdded.OnClick := btnAddedButtonClick;
    if locpia.b_snappabile then btnAdded.Down:=true else btnAdded.Down:=false;


    combAdded := TComboBox.Create(Self);
    ListaCombPiaPt.add(combAdded);
    combAdded.Name := 'comAddPiaPt'+IntToStr(contaBut);
    combAdded.Parent := self.PanelPiani;
    combAdded.Left:=380;
    combAdded.Top:=starty+k*offy;
    combAdded.Height:=20;
    combAdded.Width:=30;
    ImpostaComboPt(combAdded);
    combAdded.ItemIndex := locpia.dimpunto-1;
    combAdded.OnChange := ComAddedChanged;

    combAdded := TComboBox.Create(Self);
    ListaCombPiaSpe.add(combAdded);
    combAdded.Name := 'comAddPiaSpe'+IntToStr(contaBut);
    combAdded.Parent := self.PanelPiani;
    combAdded.Left:=415;
    combAdded.Top:=starty+k*offy;
    combAdded.Height:=20;
    combAdded.Width:=30;
    ImpostaComboPt(combAdded);
    combAdded.ItemIndex := locpia.spessoreline-1;
    combAdded.OnChange := ComAddedChanged;

//    combAdded.Caption:='';
//    combAdded.OnClick := btnAddedButtonClick;


//    ListaCombPiaPt   := TList.create;
//    ListaCombPiaSpe  := TList.create;
//    ListaCombPiaTrat := TList.create;


   end;
end;

procedure TForm_GestVettoriale.ImpostaComboPt(ilcombo : TComboBox);
begin
 ilcombo.Items.Clear;
 ilcombo.Items.add('1');
 ilcombo.Items.add('2');
 ilcombo.Items.add('3');
 ilcombo.Items.add('4');
 ilcombo.Items.add('5');
 ilcombo.Items.add('6');
 ilcombo.Items.add('7');
end;


procedure TForm_GestVettoriale.ridisegnaInfoPiano;
begin
 Edit_Nomepiano.Text := IlProgetto.PianoCorrente.nomepiano;
 gauge_spessore.Position := IlProgetto.PianoCorrente.spessoreline;
 gauge_punto.Position    := IlProgetto.PianoCorrente.dimpunto;

end;

procedure TForm_GestVettoriale.List_PianiClick(Sender: TObject);
begin
  ilProgetto.cambiaPianoCorrente(List_Piani.ItemIndex);
  ridisegnaInterfaccia;
  ridisegnaInfoPiano;
end;

procedure TForm_GestVettoriale.Localridisegna;
var contaBut : Integer;
    k        : Integer;
    locdis   : TDisegnoV;
    locpia   : TPiano;
    btnAdded : TSpeedButton;
    gauAdded : TGaugeBar;
    offy,starty : Integer;
begin
 svuota;
 contaBut :=0;
 offy     := 25;
 starty   :=10;

 for k:=0 to Ilprogetto.ListaDisegniV.Count-1 do
  begin
   locdis := Ilprogetto.ListaDisegniV.items[k];
   inc(contaBut);
   btnAdded := TSpeedButton.Create(Self);
   ListaBotDisNome.add(btnAdded);
   btnAdded.Name := 'btnAddDisNome'+IntToStr(contaBut);
   btnAdded.Parent := self.Pannello;
   btnAdded.GroupIndex := 2000;
   btnAdded.AllowAllUp := true;
   btnAdded.Left:=10;
   btnAdded.Top:=starty+k*offy;
   btnAdded.Height:=20;
   btnAdded.Width:=120;
   btnAdded.Caption:=locdis.nomedisegno;
   btnAdded.OnClick := btnAddedButtonClick;
   if k = IlProgetto.indDisVcorrente then  btnAdded.Down:=true else btnAdded.Down:=false;


   btnAdded := TSpeedButton.Create(Self);
   ListaBotDisOnOff.add(btnAdded);
   btnAdded.Name := 'btnAddDisOnOff'+IntToStr(contaBut);
   btnAdded.Parent := self.Pannello;
   btnAdded.GroupIndex := 3000+contaBut;
   btnAdded.AllowAllUp := true;
   btnAdded.Left:=135;
   btnAdded.Top:=starty+k*offy-1;
   btnAdded.Height:=22;
   btnAdded.Width:=22;
   btnAdded.Caption:='';
   btnAdded.Glyph:=image_Lanpadina;
   btnAdded.OnClick := btnAddedButtonClick;
   if locdis.b_visibile then btnAdded.Down:=true else btnAdded.Down:=false;

   gauAdded := TGaugeBar.Create(self);
   ListaGauDisLine.add(gauAdded);
   gauAdded.Name := 'gauDisLine'+IntToStr(contaBut);
   gauAdded.Parent := self.Pannello;
   gauAdded.Left:=10+155;
   gauAdded.Top:=starty+k*offy;
   gauAdded.Height:=20;
   gauAdded.Width:=120;
   gauAdded.min:=0;
   gauAdded.max:=255;
   gauAdded.OnChange := gauAddedChange;
   gauAdded.Position := locdis.alfalinee;


   btnAdded := TSpeedButton.Create(Self);
   ListaBotDisOnOff.add(btnAdded);
   btnAdded.Name := 'btnAddDisEdit'+IntToStr(contaBut);
   btnAdded.Parent := self.Pannello;
   btnAdded.GroupIndex := 4000+contaBut;
   btnAdded.AllowAllUp := true;
   btnAdded.Left:=300;
   btnAdded.Top:=starty+k*offy-1;
   btnAdded.Height:=22;
   btnAdded.Width:=22;
   btnAdded.Caption:='';
   btnAdded.Glyph:=image_editabile;
   btnAdded.OnClick := btnAddedButtonClick;
   if locdis.b_editabile then btnAdded.Down:=true else btnAdded.Down:=false;

   btnAdded := TSpeedButton.Create(Self);
   ListaBotDisOnOff.add(btnAdded);
   btnAdded.Name := 'btnAddDisSnap'+IntToStr(contaBut);
   btnAdded.Parent := self.Pannello;
   btnAdded.GroupIndex := 5000+contaBut;
   btnAdded.AllowAllUp := true;
   btnAdded.Left:=330;
   btnAdded.Top:=starty+k*offy-1;
   btnAdded.Height:=22;
   btnAdded.Width:=22;
   btnAdded.Caption:='';
   btnAdded.Glyph:=image_snapfine;
   btnAdded.OnClick := btnAddedButtonClick;
   if locdis.b_snappabile then btnAdded.Down:=true else btnAdded.Down:=false;


  end;

  NuovoDisegnaPiano;
 // LocalridisegnaPiano;

end;

procedure TForm_GestVettoriale.svuota;
var k : Integer;
    btnAdded : TSpeedButton;
    gauAdded : TGaugeBar;
begin
 for k:= ListaBotDisNome.Count-1 downto 0 do
  begin btnAdded:=ListaBotDisNome.items[k];  ListaBotDisNome.Delete(k); btnAdded.parent :=nil;  btnAdded.Free; end;
 for k:= ListaBotDisOnOff.Count-1 downto 0 do
  begin btnAdded:=ListaBotDisOnOff.items[k]; ListaBotDisOnOff.Delete(k); btnAdded.parent :=nil; btnAdded.Free; end;
 for k:= ListaBotDisEdit.Count-1 downto 0 do
  begin btnAdded:=ListaBotDisEdit.items[k];  ListaBotDisEdit.Delete(k); btnAdded.parent :=nil; btnAdded.Free; end;
 for k:= ListaBotDisSnap.Count-1 downto 0 do
  begin btnAdded:=ListaBotDisSnap.items[k];  ListaBotDisSnap.Delete(k); btnAdded.parent :=nil; btnAdded.Free; end;
 for k:= ListaGauDisLine.Count-1 downto 0 do
  begin gauAdded:=ListaGauDisLine.items[k];   ListaGauDisLine.Delete(k); gauAdded.Parent:=nil; gauAdded.Free; end;
 for k:= ListaGauDisSup.Count-1 downto 0 do
  begin gauAdded:=ListaGauDisSup.items[k];    ListaGauDisSup.Delete(k); gauAdded.Parent:=nil; gauAdded.Free; end;

 svuotaPiano;

end;


procedure TForm_GestVettoriale.svuotaPiano;
var k : Integer;
    btnAdded : TSpeedButton;
    gauAdded : TGaugeBar;
    PanAdded : TPanel;
    CombAdded : TComboBox;
begin
 for k:= ListaBotPiaNome.Count-1 downto 0 do
  begin btnAdded:=ListaBotPiaNome.items[k];    ListaBotPiaNome.Delete(k); btnAdded.parent :=nil;  btnAdded.Free; end;
 for k:= ListaBotPiaColor.Count-1 downto 0 do
  begin PanAdded:=ListaBotPiaColor.items[k];   ListaBotPiaColor.Delete(k); PanAdded.parent :=nil;  PanAdded.Free; end;
 for k:= ListaBotPiaOnOff.Count-1 downto 0 do
  begin btnAdded:=ListaBotPiaOnOff.items[k];   ListaBotPiaOnOff.Delete(k); btnAdded.parent :=nil; btnAdded.Free; end;
 for k:= ListaBotPiaEdit.Count-1 downto 0 do
  begin btnAdded:=ListaBotPiaEdit.items[k];    ListaBotPiaEdit.Delete(k); btnAdded.parent :=nil; btnAdded.Free; end;
 for k:= ListaBotPiaSnap.Count-1 downto 0 do
  begin btnAdded:=ListaBotPiaSnap.items[k];    ListaBotPiaSnap.Delete(k); btnAdded.parent :=nil; btnAdded.Free; end;
 for k:= ListaGauPiaLine.Count-1 downto 0 do
  begin gauAdded:=ListaGauPiaLine.items[k];    ListaGauPiaLine.Delete(k); gauAdded.Parent:=nil; gauAdded.Free; end;
 for k:= ListaCombPiaPt.Count-1 downto 0 do
  begin CombAdded:=ListaCombPiaPt.items[k];    ListaCombPiaPt.Delete(k); CombAdded.Parent:=nil; CombAdded.Free; end;
 for k:= ListaCombPiaSpe.Count-1 downto 0 do
  begin CombAdded:=ListaCombPiaSpe.items[k];   ListaCombPiaSpe.Delete(k); CombAdded.Parent:=nil; CombAdded.Free; end;
 for k:= ListaCombPiaTrat.Count-1 downto 0 do
  begin CombAdded:=ListaCombPiaTrat.items[k];  ListaCombPiaTrat.Delete(k); CombAdded.Parent:=nil; CombAdded.Free; end;
end;



procedure TForm_GestVettoriale.Bot_CancellaPianoClick(Sender: TObject);
var k : Integer;
    illodis : TDisegnoV;
    lopiano : TPiano;
begin
 illodis := IlProgetto.ListaDisegniV.Items[IlProgetto.indDisVcorrente];
 k :=  illodis.indPianocorrente;
 if k=0 then exit;
 lopiano:= illodis.ListaPiani.Items[k];
 illodis.ListaPiani.delete(k);
 ilProgetto.cambiaPianoCorrente(k-1);
 lopiano.free;
 ridisegna;
 ridisegnainterfaccia;
 Localridisegna;
end;

procedure TForm_GestVettoriale.Bot_renameClick(Sender: TObject);
begin
 if Edit_Nomepiano.Text<> '' then IlProgetto.PianoCorrente.nomepiano := Edit_Nomepiano.Text;
 NuovoDisegnaPiano;
 ridisegnainterfaccia;
end;

procedure TForm_GestVettoriale.Bot_VisibileDisPClick(Sender: TObject);
begin
 ilProgetto.PianoCorrente.b_visibile := not(ilProgetto.PianoCorrente.b_visibile);
 ridisegna;
 ridisegnaInterfaccia;
end;

procedure TForm_GestVettoriale.btnAddedButtonClick(Sender: TObject);
var    locdis   : TDisegnoV;
       locpia : TPiano;
       partenome : String;
       codnome : String;
       intCode : Integer;
begin
  if Sender is TSpeedButton then
  begin
   partenome := copy(TSpeedButton(Sender).Name,1,13);
   if partenome = 'btnAddDisNome' then
    begin
     codnome := copy(TSpeedButton(Sender).Name,14,length(TSpeedButton(Sender).Name)-13);
     IntCode := strToInt(codnome)-1;
     IlProgetto.cambiadisegnocorrente(IntCode);
//     svuotaPiano;
     NuovoDisegnaPiano;
//     LocalridisegnaPiano;
    end;

   partenome := copy(TSpeedButton(Sender).Name,1,14);
   if partenome = 'btnAddDisOnOff' then
    begin
     codnome := copy(TSpeedButton(Sender).Name,15,length(TSpeedButton(Sender).Name)-14);
     IntCode := strToInt(codnome)-1;
     locdis := IlProgetto.ListaDisegniV.Items[IntCode];
     locdis.b_visibile := Not(locdis.b_visibile);
     ridisegna;
    end;

   partenome := copy(TSpeedButton(Sender).Name,1,13);
   if partenome = 'btnAddDisEdit' then
    begin
     codnome := copy(TSpeedButton(Sender).Name,14,length(TSpeedButton(Sender).Name)-13);
     IntCode := strToInt(codnome)-1;
     locdis := IlProgetto.ListaDisegniV.Items[IntCode];
     locdis.b_editabile := Not(locdis.b_editabile);
    end;

   partenome := copy(TSpeedButton(Sender).Name,1,13);
   if partenome = 'btnAddDisSnap' then
    begin
     codnome := copy(TSpeedButton(Sender).Name,14,length(TSpeedButton(Sender).Name)-13);
     IntCode := strToInt(codnome)-1;
     locdis := IlProgetto.ListaDisegniV.Items[IntCode];
     locdis.b_snappabile := Not(locdis.b_snappabile);
    end;

   // piani

   partenome := copy(TSpeedButton(Sender).Name,1,13);
   if partenome = 'btnAddPiaNome' then
    begin
     codnome := copy(TSpeedButton(Sender).Name,14,length(TSpeedButton(Sender).Name)-13);
     IntCode := strToInt(codnome)-1;
     IlProgetto.cambiaPianocorrente(IntCode);
    end;

   partenome := copy(TSpeedButton(Sender).Name,1,14);
   if partenome = 'btnAddPiaOnOff' then
    begin
     codnome := copy(TSpeedButton(Sender).Name,15,length(TSpeedButton(Sender).Name)-14);
     IntCode := strToInt(codnome)-1;
     locpia := IlProgetto.DisegnoVCorrente.ListaPiani.Items[IntCode];
     locpia.b_visibile := Not(locpia.b_visibile);
     ridisegna;
    end;

   partenome := copy(TSpeedButton(Sender).Name,1,13);
   if partenome = 'btnAddPiaEdit' then
    begin
     codnome := copy(TSpeedButton(Sender).Name,14,length(TSpeedButton(Sender).Name)-13);
     IntCode := strToInt(codnome)-1;
     locpia := IlProgetto.DisegnoVCorrente.ListaPiani.Items[IntCode];
     locpia.b_editabile := Not(locpia.b_editabile);
    end;

   partenome := copy(TSpeedButton(Sender).Name,1,13);
   if partenome = 'btnAddPiaSnap' then
    begin
     codnome := copy(TSpeedButton(Sender).Name,14,length(TSpeedButton(Sender).Name)-13);
     IntCode := strToInt(codnome)-1;
     locpia := IlProgetto.DisegnoVCorrente.ListaPiani.Items[IntCode];
     locpia.b_snappabile := Not(locpia.b_snappabile);
    end;
  end;

  if Sender is TPanel then
  begin
   partenome := copy(TPanel(Sender).Name,1,14);
   if partenome = 'panAddPiaColor' then
    begin
     codnome := copy(TSpeedButton(Sender).Name,15,length(TSpeedButton(Sender).Name)-14);
     IntCode := strToInt(codnome)-1;
     locpia := IlProgetto.DisegnoVCorrente.ListaPiani.Items[IntCode];
     ColorDialog1.Color:=  RGB(locpia._rosso, locpia._verde,locpia._blu);
     if ColorDialog1.Execute then
      begin
       locpia._rosso    := ColorDialog1.Color and $ff;
       locpia._verde    := (ColorDialog1.Color and $ff00) shr 8;
       locpia._Blu      := (ColorDialog1.Color and $ff0000) shr 16;
      ridisegna;
     end;
    end;
  end;

 if inesecuzione then  ridisegnaInterfaccia;
end;

procedure TForm_GestVettoriale.But_DownDisClick(Sender: TObject);
var k,j : Integer;
    locInd : Integer;
begin
 locInd:= IlProgetto.indDisVcorrente;
 if locInd<IlProgetto.ListaDisegniV.count-1 then
  begin
    IlProgetto.VectorGrUpDownLista(2,locInd);
    LocalRidisegna;
    ridisegna;
  end;
end;

procedure TForm_GestVettoriale.But_TuttiOffClick(Sender: TObject);
begin
 ilProgetto.DisegnoVCorrente.PianiTuttiOff;
 ridisegna;
 ridisegnaInterfaccia;
end;

procedure TForm_GestVettoriale.But_TuttiOnClick(Sender: TObject);
begin
 ilProgetto.DisegnoVCorrente.PianiTuttiON;
 ridisegna;
 ridisegnaInterfaccia;
end;

procedure TForm_GestVettoriale.But_UpDisClick(Sender: TObject);
var locInd : Integer;
begin
 locInd:= IlProgetto.indDisVcorrente;
 if locInd>0 then
  begin
    IlProgetto.VectorGrUpDownLista(1,locInd);
    LocalRidisegna;
    ridisegna;
  end;
end;


procedure TForm_GestVettoriale.gauAddedChange(Sender: TObject);
var partenome: String;
    codnome : String;
    Intcode : Integer;
    locdis   : TDisegnoV;
    locpia : TPiano;
    IlloNome : String;
begin
 if Sender is TGaugeBar then
  begin
   IlloNome := TGaugeBar(Sender).Name;
   partenome := copy(IlloNome,1,10);
   if partenome = 'gauDisLine' then
    begin
     codnome := copy(IlloNome,11,length(IlloNome)-10);
     IntCode := strToInt(codnome)-1;
     locdis := IlProgetto.ListaDisegniV.Items[IntCode];
     locdis.alfalinee     := TGaugeBar(Sender).Position;
     locdis.alfasuperfici := TGaugeBar(Sender).Position;
     ridisegna;
    end;

   if partenome = 'gauPiaLine' then
    begin
     codnome := copy(IlloNome,11,length(IlloNome)-10);
     IntCode := strToInt(codnome)-1;
     locpia := IlProgetto.DisegnoVCorrente.ListaPiani.Items[IntCode];
     locpia.alfalinee     := TGaugeBar(Sender).Position;
     locpia.alfasuperfici := TGaugeBar(Sender).Position;
     ridisegna;
    end;

  end;
  ridisegnaInterfaccia;
end;

procedure TForm_GestVettoriale.Gauge_puntoChange(Sender: TObject);
begin
 IlProgetto.PianoCorrente.dimpunto := gauge_punto.Position;
 ridisegna;
end;

procedure TForm_GestVettoriale.Gauge_spessoreChange(Sender: TObject);
begin
 IlProgetto.PianoCorrente.spessoreline := gauge_spessore.Position;
 ridisegna;
end;

procedure TForm_GestVettoriale.ComAddedChanged(Sender: TObject);
var partenome: String;
    codnome : String;
    Intcode : Integer;
    locdis   : TDisegnoV;
    locpia : TPiano;
    IlloNome : String;
begin
 if Sender is TComboBox then
  begin
   IlloNome := TComboBox(Sender).Name;

   partenome := copy(IlloNome,1,11);
   if partenome = 'comAddPiaPt' then
    begin
     codnome := copy(IlloNome,12,length(IlloNome)-11);
     IntCode := strToInt(codnome)-1;
     locpia := IlProgetto.DisegnoVCorrente.ListaPiani.Items[IntCode];
     locpia.dimpunto := TComboBox(Sender).ItemIndex+1;
     ridisegna;
    end;

   partenome := copy(IlloNome,1,12);
   if partenome = 'comAddPiaSpe' then
    begin
     codnome := copy(IlloNome,13,length(IlloNome)-12);
     IntCode := strToInt(codnome)-1;
     locpia := IlProgetto.DisegnoVCorrente.ListaPiani.Items[IntCode];
     locpia.spessoreline := TComboBox(Sender).ItemIndex+1;
     ridisegna;
    end;

  end;
  ridisegnaInterfaccia;
end;


end.
