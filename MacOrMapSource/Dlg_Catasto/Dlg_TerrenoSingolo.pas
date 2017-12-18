unit Dlg_TerrenoSingolo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm_TerrenoSingolo = class(TForm)
    PanTop: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    PanLeft: TPanel;
    PanRight: TPanel;
    PanBottom: TPanel;
    GrigliaDati: TStringGrid;
    procedure GrigliaDatiDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GrigliaDatiClick(Sender: TObject);
  private
    function  GetTitolo(colo : Integer) : String;
  public
    { Public declarations }
    procedure svuota;
    procedure disegna;
  end;

var
  Form_TerrenoSingolo: TForm_TerrenoSingolo;

implementation

{$R *.dfm}

uses varbase,  TerCatDati, CatastoV,interfaccia, immobiliDati,
  Dlg_possessiImmobile;


procedure TForm_TerrenoSingolo.disegna;
var k : Integer;
   locterdata : TTerCatDati;
   LaListadaprendereDati : TList;
begin
// DisIntestazione;
 svuota;

  LaListadaprendereDati := GliImmobiliDati.listaTerreniFiltrata;

      GrigliaDati.RowCount:= LaListadaprendereDati.count+1;
      for k:= 0 to LaListadaprendereDati.count-1 do
       begin
        locterdata := LaListadaprendereDati.items[k];
        GrigliaDati.Cells[0,k+1]:= IntToStr(k+1);
        GrigliaDati.Cells[1,k+1]:= locterdata.Foglio;
        GrigliaDati.Cells[2,k+1]:= locterdata.Particella;
        GrigliaDati.Cells[3,k+1]:= locterdata.Qualita;
        GrigliaDati.Cells[4,k+1]:= locterdata.Classe;
        GrigliaDati.Cells[5,k+1]:= Format('%.d', [locTerdata.Superficie]);
        GrigliaDati.Cells[6,k+1]:= locterdata.RenditaAgrariaStrEuro;
        GrigliaDati.Cells[7,k+1]:= locterdata.RenditaDomenicaleStrEuro;
        if locterdata.Possessi.Count>0 then  GrigliaDati.Cells[8,k+1]:= IntToStr(locterdata.Possessi.Count)
                                       else  GrigliaDati.Cells[8,k+1]:= '';
      end;
end;


function  TForm_TerrenoSingolo.GetTitolo(colo : Integer) : String;
begin
 case colo of
  0 : result:=' ';
  1 : result:='Fg.';
  2 : result:='Part.';
  3 : result:='Qualità';
  4 : result:='Cl';
  5 : result:='Sup. mq';
  6 : result:='Agraria €';
  7 : result:='Domenicale €';
  else result :='';
 end;
end;

procedure TForm_TerrenoSingolo.GrigliaDatiClick(Sender: TObject);
begin

 if GrigliaDati.row= 0  then
  begin
   exit;
  end;

 if GrigliaDati.Col = 8 then
  begin
     GliImmobiliDati.filtraTerrenoFgPartSub(GrigliaDati.Cells[1,GrigliaDati.row],GrigliaDati.Cells[2,GrigliaDati.row],GrigliaDati.Cells[3,GrigliaDati.row]);
    Form_PossessiImmobile.modo:=1;
    Form_PossessiImmobile.show;
    Form_PossessiImmobile.disegna;
  end;

 if GrigliaDati.Col = 9 then
  begin
   IlCatastoV.cercaTerreno(GrigliaDati.Cells[1,GrigliaDati.row],GrigliaDati.Cells[2,GrigliaDati.row]);
   ridisegna;
  end;

end;

procedure TForm_TerrenoSingolo.GrigliaDatiDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var S: string;
    SavedAlign: word;
    LDelta : Integer;
    primarigaInd : Integer;
    LaListadaprendereDati : TList;
begin
   if ARow = 0 then begin  // ACol is zero based
    case Acol of
     0, 1 ,2,3,4,5,6,7:
      begin
       SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_CENTER);
       GrigliaDati.Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top +4 , GetTitolo(Acol));
       SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
      end;
     8 :  GrigliaDati.Canvas.Draw(Rect.Left, Rect.Top+2, image_key) ;
     9 :  GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+2, image_map) ;
    end;
  end else
  begin
   case Acol of
    1, 2, 3,4 : begin
      S := GrigliaDati.Cells[ACol, ARow]; // cell contents
      SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_CENTER);
      GrigliaDati.Canvas.TextRect(Rect,
      Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top + 5, S);
      SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
    end;
    5, 6, 7 : begin
      S := GrigliaDati.Cells[ACol, ARow]; // cell contents
      SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_RIGHT);
      GrigliaDati.Canvas.TextRect(Rect, Rect.Right -4, Rect.Top + 5, S);
      SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
    end;
     8 : begin if GrigliaDati.Cells[Acol,Arow]<>'' then GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+4, image_key_rid) ;  end;

//     8 :  GrigliaDati.Canvas.Draw(Rect.Left+4, Rect.Top+4, image_propr_rid) ;
     9 :  GrigliaDati.Canvas.Draw(Rect.Left+4, Rect.Top+4, image_map_rid) ;
   end;

  end;
end;

procedure  TForm_TerrenoSingolo.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;   GrigliaDati.Row:=0;
end;


end.
