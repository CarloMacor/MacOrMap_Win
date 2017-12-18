unit Dlg_Tares;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Vcl.Buttons;

type
  TForm_Tares = class(TForm)
    PanTop: TPanel;
    PanLeft: TPanel;
    GrigliaDati: TStringGrid;
    PanRight: TPanel;
    PanBottom: TPanel;
    Bot_Associati: TSpeedButton;
    Bot_NonAssociati: TSpeedButton;
    procedure GrigliaDatiDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
   procedure svuota;
   procedure disegna;
  end;

var
  Form_Tares: TForm_Tares;

implementation

{$R *.dfm}

uses ImmobiliDati,tares,varbase;

procedure TForm_Tares.disegna;
var k : Integer;
  loctares : TTares;
  LaListadaprendereDati : TList;
begin
 svuota;

  LaListadaprendereDati := GliImmobiliDati.listaTares;

      GrigliaDati.RowCount:= LaListadaprendereDati.count+1;
       GrigliaDati.Cells[1,0]:= 'Cognome';
       GrigliaDati.Cells[2,0]:= 'Nome';
       GrigliaDati.Cells[3,0]:= 'Indirizzo';
       GrigliaDati.Cells[4,0]:= 'Fg';
       GrigliaDati.Cells[5,0]:= 'Part';
       GrigliaDati.Cells[6,0]:= 'Sub';
       GrigliaDati.Cells[7,0]:= 'mq';
       GrigliaDati.Cells[8,0]:= 'Cod Fisc';

      for k:= 0 to LaListadaprendereDati.count-1 do
       begin
        loctares := LaListadaprendereDati.items[k];
        if loctares.associato then GrigliaDati.Cells[0,k+1]:= '1' else GrigliaDati.Cells[0,k+1]:= '';
          GrigliaDati.Cells[1,k+1]:= loctares.Cognome;
          GrigliaDati.Cells[2,k+1]:= loctares.Nome;
          GrigliaDati.Cells[3,k+1]:= loctares.Indirizzo;

          GrigliaDati.Cells[4,k+1]:= loctares.Foglio;
          GrigliaDati.Cells[5,k+1]:= loctares.Particella;
          GrigliaDati.Cells[6,k+1]:= loctares.Subalterno;

          GrigliaDati.Cells[7,k+1]:= loctares.MqTarsuStr;
          GrigliaDati.Cells[8,k+1]:= loctares.CFIVA;

(*
     Categoria       : String;
     DataIscStr      : String;
     MqCatacStr      : String;
*)


      end;

end;


procedure TForm_Tares.GrigliaDatiDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
   if ARow = 0 then begin  // ACol is zero based
    case Acol of
       0 :  GrigliaDati.Canvas.Draw(Rect.Left-3, Rect.Top+4, image_tarsu2) ;
    end;
   end
    else
   begin
    case Acol of
       0 : if  GrigliaDati.cells[acol,arow]='1' then
            GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+5, image_tarsu_rid) ;

    end;
   end;
end;

procedure TForm_Tares.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;   GrigliaDati.Row:=0;
end;

end.
