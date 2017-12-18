unit dlgAnagrafeEdificio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls;

type
  TForm_anagEdificio = class(TForm)
    PanLeft: TPanel;
    PanBottom: TPanel;
    PanTop: TPanel;
    PanRight: TPanel;
    GrigliaDati: TStringGrid;
    procedure GrigliaDatiDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    function  GetTitolo(colo : Integer) : String;
    procedure disegna;
    procedure svuota;
  end;

var
  Form_anagEdificio: TForm_anagEdificio;

implementation

{$R *.dfm}

uses Famiglia,residente,Anagrafe;

procedure TForm_anagEdificio.disegna;
var k : Integer;
    locfam : TFamiglia;
    locres : TResidente;
begin
   svuota;
    GrigliaDati.RowCount:= LaAnagrafe.listafameigliedificio.count+1;
    for k:= 0 to LaAnagrafe.listafameigliedificio.count-1 do
     begin
      locfam := LaAnagrafe.listafameigliedificio.items[k];
      locres := locfam.ListaFamiglia.Items[0];
      GrigliaDati.Cells[0,k+1] := locres.famer.codfamily;
      GrigliaDati.Cells[1,k+1] := locres.Cognome;
      GrigliaDati.Cells[2,k+1] := locres.Nome;
      GrigliaDati.Cells[3,k+1] := locres.famer.Toponimo;
      GrigliaDati.Cells[4,k+1] := locres.famer.Indirizzo ;
      GrigliaDati.Cells[5,k+1] := locres.famer.civico;
      GrigliaDati.Cells[6,k+1] := locres.CF;
     end;

end;



procedure TForm_anagEdificio.GrigliaDatiDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var S: string;
    SavedAlign: word;
    LDelta : Integer;
begin
   if ARow = 0 then begin  // ACol is zero based
 //   S := GrigliaDati.Cells[ACol, ARow]; // cell contents
    case Acol of
     0, 1 ,2,3,4,5,6:
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

procedure  TForm_anagEdificio.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;
end;


function  TForm_anagEdificio.GetTitolo(colo : Integer) : String;
begin
 case colo of
  0 : result:='Cod';
  1 : result:='Cognome';
  2 : result:='Nome';
  3 : result:='Via';
  4 : result:='Indirizzo';
  5 : result:='Civico';
  6 : result:='CF';
  else result :='';
 end;
end;


end.
