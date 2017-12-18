unit dlg_contrattiConcessioni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Buttons, Vcl.ExtCtrls;

type
  TForm_contrattiConcessioni = class(TForm)
    PanTop: TPanel;
    Bot_Add: TSpeedButton;
    Bot_NonAssociati: TSpeedButton;
    PanLeft: TPanel;
    GrigliaDati: TStringGrid;
    PanRight: TPanel;
    PanBottom: TPanel;
    procedure FormShow(Sender: TObject);
    procedure GrigliaDatiDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GrigliaDatiClick(Sender: TObject);
    procedure GrigliaDatiDblClick(Sender: TObject);
    procedure Bot_AddClick(Sender: TObject);
    procedure Bot_NonAssociatiClick(Sender: TObject);
  private
    { Private declarations }
  public
    infiltro : Boolean;
    procedure  svuota;
    procedure  disegnaLocale;
    function   GetTitolo(colo : Integer) : String;
  end;

var
  Form_contrattiConcessioni: TForm_contrattiConcessioni ;

implementation

{$R *.dfm}

uses ContrattoConcessione,Leconcessioni,varbase, dlg_contrattoConcessione,progetto,soggettoconcessione,ConcessioniV, PartConc;

function  TForm_contrattiConcessioni.GetTitolo(colo : Integer) : String;
begin
 case colo of
  0 : result:='id';
  1 : result:='Concessionario ';
  2 : result:='CF_IVA';
  3 : result:='rif';
  4 : result:='Fg.';
 // 5 : result:='Attivo';
  6 : result:='Cont.';
  7 : result:='Dis.';

  else result :='';
 end;
end;


procedure TForm_contrattiConcessioni.GrigliaDatiClick(Sender: TObject);
var infocell : String;
begin
 if GrigliaDati.row > 0  then
  begin
   if GrigliaDati.Col = 6 then
   begin
    infocell := GrigliaDati.Cells[0,GrigliaDati.row];
    if infocell<>'' then
     begin
       Form_contrattoConcessione.contrattoinevidenza := ConcessioniTolfa.contrattodaId(infocell);
       Form_contrattoConcessione.show;
       Form_contrattoConcessione.disegnalocale;
     end  else Form_contrattoConcessione.hide;
   end;
   if GrigliaDati.Col = 7 then
   begin
    infocell := GrigliaDati.Cells[0,GrigliaDati.row];
    if infocell<>'' then
     begin
      if Inconcessioniproduction then IlProgetto.apriDisegnoConcessioni(1,infocell,GrigliaDati.Cells[1,GrigliaDati.row])
                                 else begin LeConcessioniV.AttDisSoloNomedisegnodacod(infocell); end;
     end;
    ContrattoCorrente := ConcessioniTolfa.contrattodaId(infocell);
   end;

  end;
end;

procedure TForm_contrattiConcessioni.GrigliaDatiDblClick(Sender: TObject);
var infocell : String;
begin

exit;

 if GrigliaDati.row > 0  then
  begin
   if GrigliaDati.Col = 7 then
   begin
    infocell := GrigliaDati.Cells[0,GrigliaDati.row];
    if infocell<>'' then
     begin
      IlProgetto.apriDisegnoConcessioni(2,infocell,GrigliaDati.Cells[1,GrigliaDati.row]);
     end;
   end;
  end;
end;

procedure TForm_contrattiConcessioni.GrigliaDatiDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var S: string;
    SavedAlign: word;
    LDelta : Integer;
begin
   if ARow = 0 then begin  // ACol is zero based
 //   S := GrigliaDati.Cells[ACol, ARow]; // cell contents
    case Acol of
     0, 1 ,2,3,4,5,6,7:
      begin
       SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_CENTER);
       GrigliaDati.Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top +4 , GetTitolo(Acol));
       SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
      end;
    end;
  end
   else
  begin
    case Acol of
      6 :
       begin
        GrigliaDati.Canvas.Draw(Rect.Left+4, Rect.Top+2, image_doc_rid) ;
       end;
      7 :
       begin
        GrigliaDati.Canvas.Draw(Rect.Left+4, Rect.Top+2, image_map) ;
       end;
    end;
  end;
end;

procedure TForm_contrattiConcessioni.FormShow(Sender: TObject);
begin
 GrigliaDati.SetFocus;
 disegnaLocale;
end;

procedure  TForm_contrattiConcessioni.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;
end;

procedure TForm_contrattiConcessioni.Bot_AddClick(Sender: TObject);
var  loccontratto : TContrattoConcessione;
begin
 if SoggettoConcessionarioCorrente<>nil then
  begin
   inc(ConcessioniTolfa.ultimoIdContratto);
   loccontratto := TContrattoConcessione.Create;

    loccontratto.idcontratto          := IntToStr(ConcessioniTolfa.ultimoIdContratto);
    loccontratto.idConcessonario      := SoggettoConcessionarioCorrente.id;
    loccontratto.datacontratto        := '';
    loccontratto.tributo              := '0.0';



   SoggettoConcessionarioCorrente.elencoContratti.Add(loccontratto);
   ConcessioniTolfa.ListaContratti.add(loccontratto);
   ConcessioniTolfa.ListaContrattiFiltrata.Add(loccontratto);
   disegnaLocale;
  end;
end;

procedure TForm_contrattiConcessioni.Bot_NonAssociatiClick(Sender: TObject);
var indico, k,j : Integer;
    loccontratto : TContrattoConcessione;
    CompContratto : TContrattoConcessione;
    LaLista : TList;
    LocSoggettoConcessionario : TSoggettoConcessione;
begin
 indico := GrigliaDati.Row;
 if indico<=1 then exit;
 if infiltro then LaLista := ConcessioniTolfa.ListaContrattiFiltrata
             else LaLista := ConcessioniTolfa.ListaContratti;

  loccontratto :=  LaLista.items[indico-1];

  if infiltro then begin ConcessioniTolfa.ListaContrattiFiltrata.Delete(indico-1);  end
              else begin ConcessioniTolfa.ListaContratti.Delete(indico-1);  end;

  for k:=0 to ConcessioniTolfa.ListaSoggettiConcessioni.count-1 do
   begin
    LocSoggettoConcessionario := ConcessioniTolfa.ListaSoggettiConcessioni.Items[k];
    for j:= LocSoggettoConcessionario.elencoContratti.Count-1 downto 0 do
     begin
      CompContratto := LocSoggettoConcessionario.elencoContratti.items[j];
      if (CompContratto = loccontratto) then LocSoggettoConcessionario.elencoContratti.delete(j);
     end;
   end;


  disegnalocale;

end;

procedure TForm_contrattiConcessioni.disegnaLocale;
var k : Integer;
  loccontratto : TContrattoConcessione;
  LaLista : TList;
  illofg  : String;
  lapart  : TPartConc;

begin
 svuota;
  if infiltro then LaLista := ConcessioniTolfa.ListaContrattiFiltrata
              else LaLista := ConcessioniTolfa.ListaContratti;

      GrigliaDati.RowCount:= LaLista.count+1;
      for k:= 0 to LaLista.count-1 do
       begin
        loccontratto := LaLista.items[k];
        GrigliaDati.Cells[0,k+1]:= loccontratto.idcontratto;
        GrigliaDati.Cells[1,k+1]:= ConcessioniTolfa.descrizioneSoggettoId(loccontratto.idConcessonario);
        GrigliaDati.Cells[2,k+1]:= ConcessioniTolfa.PIvaSoggettoId(loccontratto.idConcessonario);
 //       GrigliaDati.Cells[4,k+1]:= loccontratto.datacontratto;
        if loccontratto.ListaParteParticelle.Count>0 then
         begin
          lapart := loccontratto.ListaParteParticelle.items[0];
          GrigliaDati.Cells[4,k+1]:= lapart.Fg;
         end;
 //       GrigliaDati.Cells[5,k+1]:= ConcessioniTolfa.descrizioneattivo(loccontratto.attivo);
       end;

end;


end.
