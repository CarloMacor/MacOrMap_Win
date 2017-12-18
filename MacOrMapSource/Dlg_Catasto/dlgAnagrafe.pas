unit dlgAnagrafe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFormAnagrafe = class(TForm)
    PanLeft: TPanel;
    PanBottom: TPanel;
    PanTop: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton6: TSpeedButton;
    PanRight: TPanel;
    GrigliaDati: TStringGrid;
    SpeedButton1: TSpeedButton;
    But_Info: TSpeedButton;
    But_Edit: TSpeedButton;
    Bot_export1: TSpeedButton;
    Bot_export2: TSpeedButton;
    SaveDialog1: TSaveDialog;
    but_editVia: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure GrigliaDatiDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GrigliaDatiClick(Sender: TObject);
    procedure But_InfoClick(Sender: TObject);
    procedure But_EditClick(Sender: TObject);
    procedure GrigliaDatiDblClick(Sender: TObject);
    procedure Bot_export1Click(Sender: TObject);
    procedure Bot_export2Click(Sender: TObject);
    procedure but_editViaClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
   mododisegna : Integer;
   procedure svuota;
   function  GetTitolo(colo : Integer) : String;
   procedure disegnaLocale;
    { Public declarations }
  end;

var
  FormAnagrafe: TFormAnagrafe;

implementation

{$R *.dfm}

uses varbase, Anagrafe, Famiglia, Residente,CatastoV,interfaccia,Immobilidati,
  Dlg_FabbricatoSingolo, Dlg_TaresSingola, Dlg_ImuSingola, Dlg_possessiImmobile,
  dlgAnagrafeSingola, dlg_InfoAnagrafe, dlg_EditFgPartSub_Anagrafe,
  dlg_EditIndirizzo_Anagrafe;


procedure TFormAnagrafe.GrigliaDatiClick(Sender: TObject);
var infocell : String;
    locfam : TFamiglia;
begin

 if GrigliaDati.Row = 0 then
  begin
   LaAnagrafe.riordinaModo(GrigliaDati.Col);
   disegnaLocale;
   exit;
  end;

 if GrigliaDati.Col = 0 then
  begin
   infocell := GrigliaDati.Cells[GrigliaDati.Col,GrigliaDati.row];
   if infocell<>'' then
    begin
     LaAnagrafe.FiltraResidentiCodice(infocell);
     Form_AnagrafeSingola.show;
     Form_AnagrafeSingola.disegna;
    end;
  end;


 if GrigliaDati.Col = 8 then
  begin
   infocell := GrigliaDati.Cells[GrigliaDati.Col,GrigliaDati.row];
   if infocell='1' then
    begin
     IlCatastoV.cercaFabbricato(GrigliaDati.Cells[14,GrigliaDati.row],GrigliaDati.Cells[15,GrigliaDati.row]);
     ridisegna;
    end;
  end;

 if GrigliaDati.Col = 9 then
  begin
   IlCatastoV.FiltraImmobiliFgPart(GrigliaDati.Cells[14,GrigliaDati.row],GrigliaDati.Cells[15,GrigliaDati.row],GliImmobiliDati.listaFabbricatiFiltrata);
   Form_FabbricatoSingolo.mododisegna:=1;
   Form_FabbricatoSingolo.show;
   Form_FabbricatoSingolo.disegna;
  end;

 if GrigliaDati.Col = 10 then
  begin
  infocell := GrigliaDati.Cells[GrigliaDati.Col,GrigliaDati.row];
   if infocell<>'' then
    begin
     locfam := LaAnagrafe.FamigliaDaCodice(GrigliaDati.Cells[0,GrigliaDati.row]);
     GliImmobiliDati.filtraPossessiLista(locfam.ListaPossessi);
     Form_PossessiImmobile.modo:=0;
     Form_PossessiImmobile.show;
     Form_PossessiImmobile.disegna;
    end
     else Form_PossessiImmobile.hide;
  end;

 if GrigliaDati.Col = 11 then
  begin
  infocell := GrigliaDati.Cells[GrigliaDati.Col,GrigliaDati.row];
   if infocell<>'' then
    begin
     locfam := LaAnagrafe.FamigliaDaCodice(GrigliaDati.Cells[0,GrigliaDati.row]);
     GliImmobiliDati.filtraImudaLista(locfam.ListaImu);
     Form_Imu_Singola.show;
     Form_Imu_Singola.disegna;
    end
     else Form_Imu_Singola.hide;
  end;

 if GrigliaDati.Col = 12 then
  begin
  infocell := GrigliaDati.Cells[GrigliaDati.Col,GrigliaDati.row];
   if infocell<>'' then
    begin
     locfam := LaAnagrafe.FamigliaDaCodice(GrigliaDati.Cells[0,GrigliaDati.row]);
     GliImmobiliDati.filtraTaresdaLista(locfam.ListaTares);
     Form_TaresSingola.show;
     Form_TaresSingola.disegna;
    end
     else Form_TaresSingola.hide;
  end;


end;

procedure TFormAnagrafe.GrigliaDatiDblClick(Sender: TObject);
begin
 if GrigliaDati.Row=0 then exit;
    case GrigliaDati.col of
     14,15,16 : begin But_EditClick(Sender); end;
     3,4,5    : begin but_editViaClick(Sender); end;
    end;
end;

procedure TFormAnagrafe.GrigliaDatiDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var S: string;
    SavedAlign: word;
    LDelta : Integer;
begin
   if ARow = 0 then begin  // ACol is zero based
 //   S := GrigliaDati.Cells[ACol, ARow]; // cell contents
    case Acol of
     0, 1 ,2,3,4,5,6,13,14,15,16:
      begin
       SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_CENTER);
       GrigliaDati.Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top +4 , GetTitolo(Acol));
       SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
      end;
       7  :  GrigliaDati.Canvas.Draw(Rect.Left, Rect.Top+2, image_family) ;
       8  :  GrigliaDati.Canvas.Draw(Rect.Left, Rect.Top+1, image_map) ;
       9  :  GrigliaDati.Canvas.Draw(Rect.Left, Rect.Top+1, image_casa1) ;
       10 :  GrigliaDati.Canvas.Draw(Rect.Left, Rect.Top+1, image_key) ;
       11 :  GrigliaDati.Canvas.Draw(Rect.Left, Rect.Top+1, image_ici) ;
       12 :  GrigliaDati.Canvas.Draw(Rect.Left, Rect.Top+1, image_dust) ;
    end;
  end
   else
  begin
    case Acol of
      6 : if GrigliaDati.Cells[Acol,aRow] ='1' then  GrigliaDati.Canvas.Draw(Rect.Left,   Rect.Top+4, image_doc_rid) ;
      8 : if GrigliaDati.Cells[Acol,aRow] ='1' then  GrigliaDati.Canvas.Draw(Rect.Left,   Rect.Top+4, image_map_rid) ;
      9 : if GrigliaDati.Cells[Acol,aRow] <>'' then  GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+3, image_casa1_rid) ;
     10 : if GrigliaDati.Cells[Acol,aRow] <>'' then  GrigliaDati.Canvas.Draw(Rect.Left,   Rect.Top+2, image_key_rid) ;
     11 : if GrigliaDati.Cells[Acol,aRow] <>'' then  GrigliaDati.Canvas.Draw(Rect.Left,   Rect.Top+2, image_ici_rid) ;
     12 : if GrigliaDati.Cells[Acol,aRow] <>'' then  GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+2, image_dust_rid) ;


    end;
  end;
end;

procedure TFormAnagrafe.Bot_export1Click(Sender: TObject);
var F : TextFile;
    k : Integer;
begin
 savedialog1.FileName := 'Anag_snc';
 if savedialog1.execute then
  begin
   assignFile(F,savedialog1.FileName); rewrite (F);
    write(F,'cod fam');
    write(F,',cognome');
    write(F,',nome');
    write(F,',top.');
    write(F,',via');
    write(F,',civico');
    write(F,',cod fis');
    write(F,',foglio');
    write(F,',part');
    write(F,',sub');

    writeln(F,'');
    for k:=1 to GrigliaDati.RowCount do
     begin
      if ( ((Uppercase(GrigliaDati.cells[5,k]))<>'SNC') and (GrigliaDati.cells[5,k]<>'')) then
       begin continue; end;

      write(F,GrigliaDati.cells[0,k]); // cod fam
      write(F,','+GrigliaDati.cells[1,k]); // cognome
      write(F,','+GrigliaDati.cells[2,k]); // nome
      write(F,','+GrigliaDati.cells[3,k]); // via viale
      write(F,','+GrigliaDati.cells[4,k]); // nome via
      write(F,','+GrigliaDati.cells[5,k]); // civico
      write(F,','+GrigliaDati.cells[13,k]); // CF
      write(F,','+GrigliaDati.cells[14,k]); // fg
      write(F,','+GrigliaDati.cells[15,k]); // part
      write(F,','+GrigliaDati.cells[16,k]); // sub
      writeln(F,'');
     end;
   closefile(F);
  end;
end;

procedure TFormAnagrafe.Bot_export2Click(Sender: TObject);
var F : TextFile;
    k : Integer;
begin
 savedialog1.FileName := 'Anag_assoc';
 if savedialog1.execute then
  begin
   assignFile(F,savedialog1.FileName); rewrite (F);
    write(F,'cod fam');
    write(F,',cognome');
    write(F,',nome');
    write(F,',top.');
    write(F,',via');
    write(F,',civico');
    write(F,',cod fis');
    write(F,',foglio');
    write(F,',part');
    write(F,',sub');

    writeln(F,'');
    for k:=1 to GrigliaDati.RowCount do
     begin
      if (GrigliaDati.cells[14,k]<>'') then
       begin
        showmessage(GrigliaDati.cells[14,k]);
        break; end;
      write(F,GrigliaDati.cells[0,k]); // cod fam
      write(F,','+GrigliaDati.cells[1,k]); // cognome
      write(F,','+GrigliaDati.cells[2,k]); // nome
      write(F,','+GrigliaDati.cells[3,k]); // via viale
      write(F,','+GrigliaDati.cells[4,k]); // nome via
      write(F,','+GrigliaDati.cells[5,k]); // civico
      write(F,','+GrigliaDati.cells[13,k]); // CF
      write(F,','+GrigliaDati.cells[14,k]); // fg
      write(F,','+GrigliaDati.cells[15,k]); // part
      write(F,','+GrigliaDati.cells[16,k]); // sub
      writeln(F,'');
     end;
   closefile(F);
  end;
end;

procedure TFormAnagrafe.But_EditClick(Sender: TObject);
var preindice : Integer;
begin
 preindice := GrigliaDati.row;
 if GrigliaDati.Row>0 then
  begin
   Form_EditFgAnagrafe.modoFamiglia := mododisegna;
   Form_EditFgAnagrafe.indiceListaAnagrafe := GrigliaDati.Row-1;
   Form_EditFgAnagrafe.showmodal;
   disegnaLocale;
   GrigliaDati.row := preindice;
  end;
end;

procedure TFormAnagrafe.but_editViaClick(Sender: TObject);
var preindice : Integer;
begin
 preindice := GrigliaDati.row;
 if GrigliaDati.Row>0 then
  begin
   Form_editIndirizzoAnagrafe.modoFamiglia := mododisegna;
   Form_editIndirizzoAnagrafe.indiceListaAnagrafe := GrigliaDati.Row-1;
   Form_editIndirizzoAnagrafe.showmodal;
   disegnaLocale;
   GrigliaDati.row := preindice;
  end;
end;

procedure TFormAnagrafe.But_InfoClick(Sender: TObject);
begin
 Form_InfoAnagrafe.show;
end;

procedure TFormAnagrafe.disegnaLocale;
var k : Integer;
    locfam : TFamiglia;
    locres : TResidente;
begin
 svuota;
 case mododisegna of
  0 :
   begin
    GrigliaDati.RowCount:= LaAnagrafe.listaFamiglie.count+1;
    for k:= 0 to LaAnagrafe.listaFamiglie.count-1 do
     begin
      locfam := LaAnagrafe.listaFamiglie.items[k];
      GrigliaDati.Cells[0,k+1]:= locfam.codfamily;
      if locfam.ListaFamiglia.Count>0 then
       begin
        locres :=locfam.ListaFamiglia.Items[0];
        GrigliaDati.Cells[1,k+1] := locres.Cognome;
        GrigliaDati.Cells[2,k+1] := locres.Nome;
//        GrigliaDati.Cells[10,k+1]:= locres.nascita;

       end;
       GrigliaDati.Cells[3,k+1]:= locfam.Toponimo;
       GrigliaDati.Cells[4,k+1]:= locfam.Indirizzo;
       GrigliaDati.Cells[5,k+1]:= locfam.civico;

       if locfam.associato then
        begin
//         if locfam.valAssociazione='10' then GrigliaDati.Cells[6,k+1]:= locfam.valAssociazione;
         if locfam.valAssociazione='14' then GrigliaDati.Cells[6,k+1]:= locfam.valAssociazione;
        end;

       GrigliaDati.Cells[7,k+1]:= IntToStr(locfam.ListaFamiglia.Count);

       if locfam.associato then GrigliaDati.Cells[8,k+1]:= '1';
       if locfam.associato then GrigliaDati.Cells[9,k+1]:= '1';

       if locfam.ListaPossessi.Count>0   then GrigliaDati.Cells[10,k+1]:=  IntToStr(locfam.ListaPossessi.Count);
       if locfam.ListaImu.Count>0        then GrigliaDati.Cells[11,k+1]:=  IntToStr(locfam.ListaImu.Count);
       if locfam.ListaTares.Count>0      then GrigliaDati.Cells[12,k+1]:=  IntToStr(locfam.ListaTares.Count);

       GrigliaDati.Cells[13,k+1]:= locres.CF;
       GrigliaDati.Cells[14,k+1]:= locfam.Foglio;
       GrigliaDati.Cells[15,k+1]:= locfam.Particella;
       GrigliaDati.Cells[16,k+1]:= locfam.Subalterno;
     end;
   end;

  1 :
   begin
    GrigliaDati.RowCount:= LaAnagrafe.listaResidenti.count+1;
    for k:= 0 to LaAnagrafe.listaResidenti.count-1 do
     begin
        locres :=LaAnagrafe.listaResidenti.Items[k];
        GrigliaDati.Cells[0,k+1]:= locres.famer.codfamily;
        GrigliaDati.Cells[1,k+1]:= locres.Cognome;
        GrigliaDati.Cells[2,k+1]:= locres.Nome;
        GrigliaDati.Cells[3,k+1]:= locres.famer.Toponimo;
        GrigliaDati.Cells[4,k+1]:= locres.famer.Indirizzo;
        GrigliaDati.Cells[5,k+1]:= locres.famer.civico;
        if locres.famer.associato then GrigliaDati.Cells[6,k+1]:= '1';
        GrigliaDati.Cells[7,k+1]:= IntToStr(locres.famer.ListaFamiglia.Count);
//        GrigliaDati.Cells[10,k+1]:= locres.nascita;

        if locres.famer.associato then GrigliaDati.Cells[8,k+1]:= '1';
        if locres.famer.associato then GrigliaDati.Cells[9,k+1]:= '1';

        if locres.famer.ListaPossessi.Count>0  then GrigliaDati.Cells[10,k+1]:=  IntToStr(locres.famer.ListaPossessi.Count);
        if locres.famer.ListaImu.Count>0       then GrigliaDati.Cells[11,k+1]:=  IntToStr(locres.famer.ListaImu.Count);
        if locres.famer.ListaTares.Count>0     then GrigliaDati.Cells[12,k+1]:=  IntToStr(locres.famer.ListaTares.Count);

        GrigliaDati.Cells[13,k+1] := locres.CF;
        GrigliaDati.Cells[14,k+1]:= locres.famer.Foglio;
        GrigliaDati.Cells[15,k+1]:= locres.famer.Particella;
        GrigliaDati.Cells[16,k+1]:= locres.famer.Subalterno;
     end;
   end;
 end;

end;



procedure TFormAnagrafe.SpeedButton2Click(Sender: TObject);
var F : TextFile;
    k : Integer;
begin
 savedialog1.FileName := 'Anag_tutta';
 if savedialog1.execute then
  begin
   assignFile(F,savedialog1.FileName); rewrite (F);
    write(F,'cod fam');
    write(F,',cognome');
    write(F,',nome');
    write(F,',top.');
    write(F,',via');
    write(F,',civico');
    write(F,',cod fis');
    write(F,',foglio');
    write(F,',part');
    write(F,',sub');

    writeln(F,'');
    for k:=1 to GrigliaDati.RowCount do
     begin
      write(F,GrigliaDati.cells[0,k]); // cod fam
      write(F,','+GrigliaDati.cells[1,k]); // cognome
      write(F,','+GrigliaDati.cells[2,k]); // nome
      write(F,','+GrigliaDati.cells[3,k]); // via viale
      write(F,','+GrigliaDati.cells[4,k]); // nome via
      write(F,','+GrigliaDati.cells[5,k]); // civico
      write(F,','+GrigliaDati.cells[13,k]); // CF
      write(F,','+GrigliaDati.cells[14,k]); // fg
      write(F,','+GrigliaDati.cells[15,k]); // part
      write(F,','+GrigliaDati.cells[16,k]); // sub
      writeln(F,'');
     end;
   closefile(F);
  end;
end;


procedure TFormAnagrafe.SpeedButton3Click(Sender: TObject);
begin
 mododisegna :=1;
 disegnaLocale;
end;

procedure TFormAnagrafe.SpeedButton6Click(Sender: TObject);
begin
 mododisegna :=0;
 disegnaLocale;
end;

procedure TFormAnagrafe.FormCreate(Sender: TObject);
begin
 mododisegna :=0;
end;

procedure TFormAnagrafe.FormShow(Sender: TObject);
begin
 GrigliaDati.SetFocus;
 disegnaLocale;
end;

function  TFormAnagrafe.GetTitolo(colo : Integer) : String;
begin
 case colo of
  0 : result:='Cod';
  1 : result:='Cognome';
  2 : result:='Nome';
  3 : result:='Via';
  4 : result:='Indirizzo';
  5 : result:='Civico';
  6 : result:='1°';
  10 : result:='Nascita';
  13 : result:='CF';
  14 : result:='fg';
  15 : result:='part';
  16 : result:='sub';
  else result :='';
 end;
end;


procedure  TFormAnagrafe.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;
end;


end.
