unit dlg_contrattoConcessione;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,contrattoconcessione,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids;

type
  TForm_contrattoConcessione = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Edit_concessonario: TEdit;
    ListBoxPart: TListBox;
    But_cancPart: TSpeedButton;
    Bot_editPart: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Panel1: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    SpeedButton1: TSpeedButton;
    Lab_nContratto: TLabel;
    Edit_dataContratto: TEdit;
    Edit_tributo: TEdit;
    Edit_dataDecorrenza: TEdit;
    Edit_DataScadenza: TEdit;
    Edit_Delibera: TEdit;
    Edit_Legge: TEdit;
    Edit_DataDelibera: TEdit;
    Edit_Info: TEdit;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    GrigliaDati: TStringGrid;
    Bot_NonAssociati: TSpeedButton;
    Label11: TLabel;
    Label12: TLabel;
    EditSupTot: TEdit;
    Checksupforf: TCheckBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure But_cancPartClick(Sender: TObject);
    procedure Bot_editPartClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure GrigliaDatiDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GrigliaDatiClick(Sender: TObject);
    procedure Bot_NonAssociatiClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
   contrattoinevidenza : TcontrattoConcessione;
   totalmenteaperta : Boolean;
   procedure disegnalocale;
   procedure impostadimensione;
   procedure svuota;
   function  GetTitolo(colo : Integer) : String;
    { Public declarations }
  end;

var
  Form_contrattoConcessione: TForm_contrattoConcessione;

implementation

{$R *.dfm}
uses LeConcessioni, PartConc, dlg_particellaConcessione, varbase,interfaccia, concessioniV;

procedure TForm_contrattoConcessione.FormCreate(Sender: TObject);
begin
 totalmenteaperta := false;
end;

procedure TForm_contrattoConcessione.FormShow(Sender: TObject);
begin
 impostadimensione;
end;


procedure TForm_contrattoConcessione.impostadimensione;
begin
 if totalmenteaperta   then width := 800 else width := 370;
 disegnalocale;
end;


procedure TForm_contrattoConcessione.SpeedButton1Click(Sender: TObject);
begin
 Edit_Legge.Text          := 'DGRL n.6796 del 30/10/1997';
 Edit_Info.Text           := 'giusto contratto';
end;

procedure TForm_contrattoConcessione.SpeedButton2Click(Sender: TObject);
begin
 totalmenteaperta := not totalmenteaperta;
 impostadimensione;
end;

procedure TForm_contrattoConcessione.SpeedButton3Click(Sender: TObject);
var k : Integer;
    locPartConc : TPartConc;
    locsup : integer;
    totsup : integer;
    totsupstr : String;
begin
 totsup :=0;
 if (contrattoinevidenza.supforfettaria=0) then
  begin
   for k:=0 to contrattoinevidenza.ListaParteParticelle.Count-1 do
    begin
     locPartConc := contrattoinevidenza.ListaParteParticelle.items[k];
     if locPartConc.Sup<>'' then locsup := strtoint(locPartConc.Sup) else locsup:=0;
     totsup := totsup + locsup;
    end;
    totsupstr := inttostr(totsup);
    EditSupTot.text := totsupstr;
  end;
end;

procedure TForm_contrattoConcessione.SpeedButton4Click(Sender: TObject);
var k : Integer;
    locPartConc : TPartConc;
begin
   for k:=0 to contrattoinevidenza.ListaParteParticelle.Count-1 do
    begin
     locPartConc := contrattoinevidenza.ListaParteParticelle.items[k];
     locPartConc.Sup:='0';
    end;
  disegnalocale;
end;

procedure TForm_contrattoConcessione.SpeedButton5Click(Sender: TObject);
begin
  contrattoinevidenza.superficietotale := EditSupTot.text;
  if Checksupforf.Checked then contrattoinevidenza.supforfettaria := 1
                          else contrattoinevidenza.supforfettaria := 0;
end;

procedure TForm_contrattoConcessione.BitBtn1Click(Sender: TObject);
begin
 close;
end;

procedure TForm_contrattoConcessione.BitBtn2Click(Sender: TObject);
begin
  contrattoinevidenza.datacontratto  := Edit_dataContratto.Text;
  contrattoinevidenza.datadecorrenza := Edit_dataDecorrenza.Text;
  contrattoinevidenza.datascadenza   := Edit_DataScadenza.Text;
  contrattoinevidenza.infocontratto  := Edit_Info.Text;
  contrattoinevidenza.rifDelibera    := Edit_Delibera.Text;
  contrattoinevidenza.datadelibera   := Edit_DataDelibera.Text;
  contrattoinevidenza.rifLegge       := Edit_Legge.Text;
  contrattoinevidenza.tributo        := Edit_tributo.Text;
  contrattoinevidenza.superficietotale := EditSupTot.text;

  if Checksupforf.Checked then contrattoinevidenza.supforfettaria := 1
                          else contrattoinevidenza.supforfettaria := 0;
  close;
end;

procedure TForm_contrattoConcessione.Bot_editPartClick(Sender: TObject);
begin
// if ListBoxPart.ItemIndex>=0 then
 if GrigliaDati.row >0 then
  begin
   PartConcessioneCorrente := contrattoinevidenza.ListaParteParticelle.items[GrigliaDati.row-1];
   Form_editPartConc.disegnalocale;
   Form_editPartConc.showmodal;
   disegnalocale;
  end;
end;

procedure TForm_contrattoConcessione.Bot_NonAssociatiClick(Sender: TObject);
begin
 ConcessioniTolfa.salva;
end;

procedure TForm_contrattoConcessione.But_cancPartClick(Sender: TObject);
begin
 if GrigliaDati.row >0 then
// if ListBoxPart.ItemIndex>=0 then
  begin
   contrattoinevidenza.ListaParteParticelle.delete(GrigliaDati.row-1);
   disegnalocale;
  end;
end;

procedure TForm_contrattoConcessione.disegnalocale;
var k : integer;
    locPartConc : TPartConc;
    lastrow : Integer;
begin
 ListBoxPart.Clear;

 if contrattoinevidenza <> nil then
  begin
   Edit_concessonario.Text  :=   ConcessioniTolfa.descrizioneSoggettoId(contrattoinevidenza.idConcessonario);
   Edit_dataContratto.Text  :=   contrattoinevidenza.datacontratto;
   Edit_dataDecorrenza.Text :=   contrattoinevidenza.datadecorrenza;
   Edit_DataScadenza.Text   :=   contrattoinevidenza.datascadenza;
   Edit_Info.Text           :=   contrattoinevidenza.infocontratto;
   Edit_Delibera.Text       :=   contrattoinevidenza.rifDelibera;
   Edit_DataDelibera.Text   :=   contrattoinevidenza.datadelibera;
   Edit_Legge.Text          :=   contrattoinevidenza.rifLegge;
   Edit_tributo.Text        :=   contrattoinevidenza.tributo;

   for k:=0 to contrattoinevidenza.ListaParteParticelle.Count-1 do begin
    locPartConc := contrattoinevidenza.ListaParteParticelle.items[k];
    ListBoxPart.Items.Add('Fg.'+locPartConc.Fg+' Part.'+locPartConc.Part+'  mq:'+locPartConc.Sup
                          +' Cat.'+locPartConc.categoria+' classe:'+locPartConc.classe +' "'+locPartConc.MioPart+ '"');
   end;

   EditSupTot.text :=  contrattoinevidenza.superficietotale;
   if (contrattoinevidenza.supforfettaria=1) then Checksupforf.Checked:=true
                                             else  Checksupforf.Checked:=false;

  end
   else
  begin
   Edit_concessonario.Text  := '';
   Edit_dataContratto.Text  := '';
   Edit_dataDecorrenza.Text := '';
   Edit_DataScadenza.Text   := '';
   Edit_Info.Text           := '';
   Edit_Delibera.Text       := '';
   Edit_DataDelibera.Text   := '';
   Edit_Legge.Text          := '';
   Edit_tributo.Text        := '';
  end;

  // -----------------
  svuota;
    GrigliaDati.RowCount:= contrattoinevidenza.ListaParteParticelle.count+1;

end;


procedure  TForm_contrattoConcessione.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;
end;

function  TForm_contrattoConcessione.GetTitolo(colo : Integer) : String;
begin
 case colo of
  0 : result:='Fg';
  1 : result:='Part';
  2 : result:='Mia';
  3 : result:='Sup.';
  4 : result:='Cat.';
  5 : result:='Cl.';
  else result :='';
 end;
end;

procedure TForm_contrattoConcessione.GrigliaDatiClick(Sender: TObject);
var locPartConc : TPartConc;
begin
 if GrigliaDati.row = 0 then exit;

 if GrigliaDati.Col = 6 then
  begin
   LeConcessioniV.apriseassentedaCod(contrattoinevidenza.idcontratto);
   LeConcessioniV.MettivisibiledisCod(contrattoinevidenza.idcontratto,true);
   LeConcessioniV.ZoomDisdaCod(contrattoinevidenza.idcontratto);
//   IlCatastoV.cercaFabbricato(GrigliaDati.Cells[1,GrigliaDati.row],GrigliaDati.Cells[2,GrigliaDati.row]);
   LeConcessioniV.ListaSelezionati.clear;
   locPartConc := contrattoinevidenza.ListaParteParticelle.items[GrigliaDati.Row-1];
   LeConcessioniV.mettiInSelezioneCodRow(contrattoinevidenza.idcontratto, locPartConc.Fg, locPartConc.Part);
   ridisegna;
  end;
end;

procedure TForm_contrattoConcessione.GrigliaDatiDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var S: string;
    SavedAlign: word;
    LDelta : Integer;
    locint : real;
    locPartConc : TPartConc;

begin
   if ARow = 0 then begin  // ACol is zero based
    case Acol of
     0, 1,2,3,4,5 :
      begin
       SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_CENTER);
       GrigliaDati.Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top +2 , GetTitolo(Acol));
       SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
      end;
      6 :  GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+2, image_map) ;
    end;
  end
     else
   begin
    if ARow=GrigliaDati.row then GrigliaDati.Canvas.Font.Color := clBlue   else   GrigliaDati.Canvas.Font.Color := clBlack;
    locPartConc := contrattoinevidenza.ListaParteParticelle.items[ARow-1];
    case Acol of
     0 :
      begin
       SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_CENTER);
       GrigliaDati.Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top +2 , locPartConc.Fg);
       SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
      end;
      1 : begin
       SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_CENTER);
       GrigliaDati.Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top +2 , locPartConc.Part);
       SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
      end;
      2 : begin
       SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_CENTER);
       GrigliaDati.Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top +2 , locPartConc.MioPart);
       SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
      end;
      3 : begin
       SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_RIGHT);
       if locPartConc.Sup<>'' then  locint := StrTofloat(locPartConc.Sup) else locint:=0;
       GrigliaDati.Canvas.TextRect(Rect, Rect.Right-2 , Rect.Top +2 , FloatToStrF(locint,ffNumber,10,0 ));
       SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
      end;
      4 :
      begin
       SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_RIGHT);
       GrigliaDati.Canvas.TextRect(Rect, Rect.Right-2 , Rect.Top +2 , locPartConc.categoria);
       SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
      end;
      5 : begin
       SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_CENTER);
       GrigliaDati.Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top +2 , locPartConc.classe);
       SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
      end;
      6 :  GrigliaDati.Canvas.Draw(Rect.Left+4, Rect.Top+4, image_Mappe_UltRid) ;
    end;
   end;

end;

end.
