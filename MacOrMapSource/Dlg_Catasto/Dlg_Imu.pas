unit Dlg_Imu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Buttons, Vcl.ExtCtrls;

type
  TForm_Imu = class(TForm)
    PanTop: TPanel;
    Bot_Associati: TSpeedButton;
    Bot_NonAssociati: TSpeedButton;
    PanLeft: TPanel;
    GrigliaDati: TStringGrid;
    PanRight: TPanel;
    PanBottom: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
   procedure svuota;
   procedure disegna;
  end;

var
  Form_Imu: TForm_Imu;

implementation

{$R *.dfm}

uses Imu,ImmobiliDati;


procedure TForm_Imu.disegna;
var k : Integer;
  locImu : TImu;
  LaListadaprendereDati : TList;
begin
 svuota;

  LaListadaprendereDati := GliImmobiliDati.listaImu;

      GrigliaDati.RowCount:= LaListadaprendereDati.count+1;
       GrigliaDati.Cells[1,0]:= 'Cognome';
       GrigliaDati.Cells[2,0]:= 'Nome';
       GrigliaDati.Cells[3,0]:= 'Indirizzo';
       GrigliaDati.Cells[4,0]:= 'Fg';
       GrigliaDati.Cells[5,0]:= 'Part';
       GrigliaDati.Cells[6,0]:= 'Sub';
       GrigliaDati.Cells[7,0]:= 'Cat';
       GrigliaDati.Cells[8,0]:= 'Rendita';
       GrigliaDati.Cells[9,0]:= 'Valore';
       GrigliaDati.Cells[10,0]:= 'Cod Fisc';

      for k:= 0 to LaListadaprendereDati.count-1 do
       begin
        locImu := LaListadaprendereDati.items[k];
        if locImu.associato then GrigliaDati.Cells[0,k+1]:= '1' else GrigliaDati.Cells[0,k+1]:= '';
          GrigliaDati.Cells[1,k+1]:= locImu.Cognome;
          GrigliaDati.Cells[2,k+1]:= locImu.Nome;
          GrigliaDati.Cells[3,k+1]:= locImu.Indirizzo;

          GrigliaDati.Cells[4,k+1]:= locImu.Foglio;
          GrigliaDati.Cells[5,k+1]:= locImu.Particella;
          GrigliaDati.Cells[6,k+1]:= locImu.Subalterno;

          GrigliaDati.Cells[7,k+1]:= locImu.Categoria;
          GrigliaDati.Cells[8,k+1]:= locImu.RenditaStr;
          GrigliaDati.Cells[9,k+1]:= locImu.ValoreStr;
          GrigliaDati.Cells[10,k+1]:= locImu.CFIVA;
      end;

end;



procedure TForm_Imu.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;   GrigliaDati.Row:=0;
end;

end.
