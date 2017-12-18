unit Dlg_TaresSingola;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Buttons, Vcl.ExtCtrls;

type
  TForm_TaresSingola = class(TForm)
    PanTop: TPanel;
    PanLeft: TPanel;
    GrigliaDati: TStringGrid;
    PanRight: TPanel;
    PanBottom: TPanel;
    procedure GrigliaDatiDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    function  GetTitolo(colo : Integer) : String;
    procedure disegna;
    procedure svuota;
  end;

var
  Form_TaresSingola: TForm_TaresSingola;

implementation

{$R *.dfm}

 uses tares,Immobilidati;

procedure TForm_TaresSingola.GrigliaDatiDrawCell(Sender: TObject; ACol,
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
  end;
end;

procedure TForm_TaresSingola.disegna;
var k : Integer;
    loctares : TTares;
begin
   svuota;
    GrigliaDati.RowCount:= GliImmobiliDati.ListaTaresFiltrata.count+1;
    for k:= 0 to GliImmobiliDati.ListaTaresFiltrata.count-1 do
     begin
      loctares := GliImmobiliDati.ListaTaresFiltrata.items[k];
      GrigliaDati.Cells[0,k+1]:= loctares.Cognome;
      GrigliaDati.Cells[1,k+1]:= loctares.Nome;
      GrigliaDati.Cells[2,k+1]:= loctares.Indirizzo;
      GrigliaDati.Cells[3,k+1]:= loctares.Foglio;
      GrigliaDati.Cells[4,k+1]:= loctares.Particella;
      GrigliaDati.Cells[5,k+1]:= loctares.Subalterno;
      GrigliaDati.Cells[6,k+1]:= loctares.MqTarsuStr;
      GrigliaDati.Cells[7,k+1]:= loctares.CFIVA;
     end;
end;



procedure  TForm_TaresSingola.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;
end;

function  TForm_TaresSingola.GetTitolo(colo : Integer) : String;
begin
 case colo of
  0 : result:='Cognome';
  1 : result:='Nome';
  2 : result:='Indirizzo';
  3 : result:='Fg';
  4 : result:='Part';
  5 : result:='Sub';
  6 : result:='mq';
  7 : result:='Cod Fisc';
  else result :='';
 end;
end;


end.
