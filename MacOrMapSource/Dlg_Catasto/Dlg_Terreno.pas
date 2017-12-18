unit Dlg_Terreno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TDlg_InfoTerreno = class(TForm)
    PanTop: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    PanLeft: TPanel;
    PanRight: TPanel;
    PanBottom: TPanel;
    GrigliaDati: TStringGrid;
    Bot_Export: TSpeedButton;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure GrigliaDatiDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GrigliaDatiClick(Sender: TObject);
    procedure Bot_ExportClick(Sender: TObject);
  private
    function  GetTitolo(colo : Integer) : String;
  public
    mododisegna : Integer;
    procedure svuota;
    procedure disegna;
  end;

var
  Dlg_InfoTerreno: TDlg_InfoTerreno;

implementation

{$R *.dfm}
uses varbase,  TerCatDati, CatastoV,interfaccia, immobiliDati,
  Dlg_possessiImmobile;


procedure  TDlg_InfoTerreno.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;   GrigliaDati.Row:=0;
end;

procedure TDlg_InfoTerreno.FormCreate(Sender: TObject);
begin
 mododisegna :=0;
end;

procedure TDlg_InfoTerreno.GrigliaDatiClick(Sender: TObject);
var infocell : String;
begin

 if GrigliaDati.row= 0  then
  begin
    if ((GrigliaDati.Col = 1) or (GrigliaDati.Col = 2) ) then
     begin GliImmobiliDati.RiordinaTerreni(1,1); disegna;  end;

    if (GrigliaDati.Col = 3)  then
     begin GliImmobiliDati.RiordinaTerreni(1,2); disegna;  end;
    if (GrigliaDati.Col = 4)  then
     begin GliImmobiliDati.RiordinaTerreni(1,3); disegna;  end;
    if (GrigliaDati.Col = 5)  then
     begin GliImmobiliDati.RiordinaTerreni(1,4); disegna;  end;
    if (GrigliaDati.Col = 6)  then
     begin GliImmobiliDati.RiordinaTerreni(1,5); disegna;  end;
    if (GrigliaDati.Col = 7)  then
     begin GliImmobiliDati.RiordinaTerreni(1,6); disegna;  end;

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

procedure TDlg_InfoTerreno.GrigliaDatiDrawCell(Sender: TObject; ACol,
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

procedure TDlg_InfoTerreno.Bot_ExportClick(Sender: TObject);
var F : TextFile;
    k : Integer;
begin
   savedialog1.FileName := 'Terreni';
   if savedialog1.execute then
    begin
     assignFile(F,savedialog1.FileName); rewrite (F);
      write(F,'Foglio');
      write(F,',Part');
      write(F,',Qualita');
      write(F,',Classe');
      write(F,',Superf.');
      write(F,',Rend Agraria');
      write(F,',Rend Domenicale');
      writeln(F,'');
      for k:=1 to GrigliaDati.RowCount do
       begin
        write(F,GrigliaDati.cells[1,k]); // Foglio
        write(F,','+GrigliaDati.cells[2,k]); // Particella
        write(F,','+GrigliaDati.cells[3,k]); // Qualita
        write(F,','+GrigliaDati.cells[4,k]); // Classe
        write(F,','+GrigliaDati.cells[5,k]); // Superficie
        write(F,','+GrigliaDati.cells[6,k]); // RenditaAgrariaStrEuro
        write(F,','+GrigliaDati.cells[7,k]); // RenditaDomenicaleStrEuro
        writeln(F,'');
       end;
     closefile(F);
    end;
end;

procedure TDlg_InfoTerreno.disegna;
var k : Integer;
   locterdata : TTerCatDati;
   LaListadaprendereDati : TList;
begin
// DisIntestazione;
 svuota;

 case mododisegna of
  0 : LaListadaprendereDati := GliImmobiliDati.listaterreni;
  1 : LaListadaprendereDati := GliImmobiliDati.listaTerreniFiltrata;
 end;

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


function  TDlg_InfoTerreno.GetTitolo(colo : Integer) : String;
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



end.
