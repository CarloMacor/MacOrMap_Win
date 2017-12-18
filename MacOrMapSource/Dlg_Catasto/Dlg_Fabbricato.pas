unit Dlg_Fabbricato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvShapeButton, W7Classes, W7Buttons,
  AdvSmoothButton, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, tmsAdvGridExcel,
  AdvSmoothToggleButton, AdvGlowButton, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Samples.Spin, Vcl.Imaging.jpeg;

type
  TDlg_InfoFabbricato = class(TForm)
    PanTop: TPanel;
    Bot_filtraNoCase: TSpeedButton;
    Bot_filtraCase: TSpeedButton;
    PanLeft: TPanel;
    PanRight: TPanel;
    PanBottom: TPanel;
    Bot_ExtraInfo: TSpeedButton;
    Pan_Extra: TPanel;
    GrigliaDati: TStringGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PanCenterExtra: TPanel;
    Image1: TImage;
    GridExtra: TStringGrid;
    MemoNote: TMemo;
    Image2: TImage;
    Image3: TImage;
    Bot_vedoIndirizzoCatastale: TSpeedButton;
    Bot_vedoIndirizzoAnagrafe: TSpeedButton;
    Bot_vedoIndirizzoCorretto: TSpeedButton;
    Bot_vedoValori: TSpeedButton;
    Bot_Export: TSpeedButton;
    SaveDialog1: TSaveDialog;
    ButTest: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure GrigliaDatiDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure GrigliaDatiClick(Sender: TObject);
    procedure Bot_filtraCaseClick(Sender: TObject);
    procedure Bot_ExtraInfoClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Bot_vedoIndirizzoCatastaleClick(Sender: TObject);
    procedure Bot_vedoIndirizzoAnagrafeClick(Sender: TObject);
    procedure Bot_vedoIndirizzoCorrettoClick(Sender: TObject);
    procedure Bot_vedoValoriClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Bot_ExportClick(Sender: TObject);
    procedure ButTestClick(Sender: TObject);
  private
    function  GetTitolo(colo : Integer) : String;
    procedure DisIntestazione;
  public
    { Public declarations }
    d_C1,d_C2,d_C3 : Integer;
    d_d1,d_d2,d_d3 : Integer;
    d_A1,d_A2,d_A3 : Integer;
    d_v1,d_v2,d_v3,d_v4 : Integer;
    d_CV1,d_CV2,d_CV3,d_CV4 : Integer;
    mododisegna : Integer;
    filtroAttivo : Integer;
    listraFiltrataCase : TList;
    extraInfoVisibili  : Boolean;
    firstshow  : Boolean;
    procedure svuota;
    procedure svuotaExtra;
    procedure disegna;
    procedure disegnaExtra;
    procedure realizzaListacase(modo : Integer; listaorigine : Tlist);
    procedure vedifoto(cod : Integer);
  end;

var
  Dlg_InfoFabbricato: TDlg_InfoFabbricato;

implementation

{$R *.dfm}

uses varbase,  FabCatDati, CatastoV,interfaccia, immobiliDati,Dlg_FotoFabbricato, dlgAnagrafeSingola,anagrafe,
  Dlg_TaresSingola, Dlg_FabbricatoSingolo,Dlg_possessoPrimaCasa,   funzioni,
  Dlg_possessiImmobile,Dlg_ImuSingola; //, Main;

procedure TDlg_InfoFabbricato.FormCreate(Sender: TObject);
begin
 mododisegna :=0;
 filtroAttivo :=0;
 extraInfoVisibili := false;
 listraFiltrataCase := TList.Create;
 firstshow := true;
end;

procedure TDlg_InfoFabbricato.FormMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
// showmessage('a');
//  if MousePos.X<BaseSchermo.Width then MyMouseWeel(WheelDelta,Shift,MousePos.X,(height-16)-MousePos.Y);

end;

procedure TDlg_InfoFabbricato.FormShow(Sender: TObject);
begin
 svuota;
 if firstshow then begin
  Bot_filtraCase.Glyph:=image_casaverde;
  Bot_filtraNoCase.Glyph:=image_c6;
  Bot_ExtraInfo.Glyph:=image_pdf;
  Bot_vedoIndirizzoCatastaleClick(sender);
  Bot_vedoIndirizzoAnagrafeClick(sender);
  Bot_vedoIndirizzoCorrettoClick(sender);
  ButTestClick(sender);
  firstshow :=false;
 end;

// test.Glyph.LoadFromResourceName(HInstance, 'Bit_Casaverde');
end;


procedure TDlg_InfoFabbricato.realizzaListacase(modo : Integer; listaorigine : Tlist);
var   locfabdata : TFabCatDati;
      k : Integer;
begin
 listraFiltrataCase.clear;
 for k:=0 to listaorigine.count-1 do
  begin
   locfabdata := listaorigine.items[k];
   case modo of
    1 : if locfabdata.iscasa       then listraFiltrataCase.Add(locfabdata);
    2 : if not( locfabdata.iscasa) then listraFiltrataCase.Add(locfabdata);
   end;


  end;

end;


procedure TDlg_InfoFabbricato.Bot_vedoIndirizzoAnagrafeClick(Sender: TObject);
begin
 if Bot_vedoIndirizzoAnagrafe.Down then
  begin
  d_A1 := GrigliaDati.ColWidths[7];  d_A2 := GrigliaDati.ColWidths[8];  d_A3 := GrigliaDati.ColWidths[9];
  GrigliaDati.ColWidths[7]:= 0;      GrigliaDati.ColWidths[8]:= 0;      GrigliaDati.ColWidths[9]:= 0;
   width := width - (d_a1+d_a2+d_a3);
  end
   else
  begin
   width := width + (d_a1+d_a2+d_a3);
   GrigliaDati.ColWidths[7]:= d_A1;      GrigliaDati.ColWidths[8]:= d_A2;      GrigliaDati.ColWidths[9]:= d_A3;
  end;
end;

procedure TDlg_InfoFabbricato.Bot_vedoIndirizzoCatastaleClick(Sender: TObject);
begin
 if Bot_vedoIndirizzoCatastale.Down then
  begin
  d_C1 := GrigliaDati.ColWidths[4];  d_C2 := GrigliaDati.ColWidths[5];  d_C3 := GrigliaDati.ColWidths[6];
  GrigliaDati.ColWidths[4]:= 0;      GrigliaDati.ColWidths[5]:= 0;      GrigliaDati.ColWidths[6]:= 0;
   width := width - (d_c1+d_c2+d_c3);
  end
   else
  begin
   width := width + (d_c1+d_c2+d_c3);
   GrigliaDati.ColWidths[4]:= d_C1;      GrigliaDati.ColWidths[5]:= d_C2;      GrigliaDati.ColWidths[6]:= d_C3;
  end;
end;

procedure TDlg_InfoFabbricato.Bot_vedoIndirizzoCorrettoClick(Sender: TObject);
begin
 if Bot_vedoIndirizzoCorretto.Down then
  begin
  d_d1 := GrigliaDati.ColWidths[10];  d_d2 := GrigliaDati.ColWidths[11];  d_d3 := GrigliaDati.ColWidths[12];
  GrigliaDati.ColWidths[10]:= 0;      GrigliaDati.ColWidths[11]:= 0;      GrigliaDati.ColWidths[12]:= 0;
   width := width - (d_d1+d_d2+d_d3);
  end
   else
  begin
   width := width + (d_d1+d_d2+d_d3);
   GrigliaDati.ColWidths[10]:= d_d1;      GrigliaDati.ColWidths[11]:= d_d2;      GrigliaDati.ColWidths[12]:= d_d3;
  end;

end;

procedure TDlg_InfoFabbricato.Bot_vedoValoriClick(Sender: TObject);
begin
 if ButTest.Down then
  begin
  d_v1 := GrigliaDati.ColWidths[21];  d_v2 := GrigliaDati.ColWidths[22];  d_v3 := GrigliaDati.ColWidths[23];  d_v4 := GrigliaDati.ColWidths[24];
  GrigliaDati.ColWidths[21]:= 0;  GrigliaDati.ColWidths[22]:= 0;  GrigliaDati.ColWidths[23]:= 0;  GrigliaDati.ColWidths[24]:= 0;
   width := width - (d_v1+d_v2+d_v3+d_v4);
  end
   else
  begin
   width := width + (d_v1+d_v2+d_v3+d_v4);
   GrigliaDati.ColWidths[21]:= d_v1;      GrigliaDati.ColWidths[22]:= d_v2;      GrigliaDati.ColWidths[23]:= d_v3;  GrigliaDati.ColWidths[24]:= d_v4;
  end;

end;

procedure TDlg_InfoFabbricato.ButTestClick(Sender: TObject);
begin
if ButTest.Down then
  begin
  d_Cv1 := GrigliaDati.ColWidths[14];  d_Cv2 := GrigliaDati.ColWidths[15];  d_Cv3 := GrigliaDati.ColWidths[16];  d_Cv4 := GrigliaDati.ColWidths[17];
  GrigliaDati.ColWidths[14]:= 0;  GrigliaDati.ColWidths[15]:= 0;  GrigliaDati.ColWidths[16]:= 0;  GrigliaDati.ColWidths[17]:= 0;
   width := width - (d_Cv1+d_Cv2+d_Cv3+d_Cv4);
  end
   else
  begin
   width := width + (d_Cv1+d_Cv2+d_Cv3+d_Cv4);
   GrigliaDati.ColWidths[14]:= d_Cv1;      GrigliaDati.ColWidths[15]:= d_Cv2;      GrigliaDati.ColWidths[16]:= d_Cv3;  GrigliaDati.ColWidths[17]:= d_Cv4;
  end;
end;

procedure TDlg_InfoFabbricato.GrigliaDatiClick(Sender: TObject);
var infocell : String;
begin

//   showmessage(intToStr(GrigliaDati.Col));


 if GrigliaDati.row= 0  then
  begin
    if ((GrigliaDati.Col = 1) or (GrigliaDati.Col = 2) or (GrigliaDati.Col = 3)) then
     begin GliImmobiliDati.RiordinaFabbricati(1,1); disegna;  end;

    if (GrigliaDati.Col = 4)   then begin GliImmobiliDati.RiordinaFabbricati(1,20); disegna; end;
    if (GrigliaDati.Col = 5)   then begin GliImmobiliDati.RiordinaFabbricati(1,21); disegna; end;
    if (GrigliaDati.Col = 6)   then begin GliImmobiliDati.RiordinaFabbricati(1,22); disegna; end;

    if (GrigliaDati.Col = 13)  then begin GliImmobiliDati.RiordinaFabbricati(1,2); disegna; end;
    if (GrigliaDati.Col = 15)  then begin GliImmobiliDati.RiordinaFabbricati(1,4); disegna; end;
    if (GrigliaDati.Col = 16)  then begin GliImmobiliDati.RiordinaFabbricati(1,5); disegna; end;
    if (GrigliaDati.Col = 17)  then begin GliImmobiliDati.RiordinaFabbricati(1,6); disegna; end;
    if (GrigliaDati.Col = 18)  then begin GliImmobiliDati.RiordinaFabbricati(1,7); disegna; end;
    if (GrigliaDati.Col = 21)  then begin GliImmobiliDati.RiordinaFabbricati(1,8); disegna; end;
    if (GrigliaDati.Col = 22)  then begin GliImmobiliDati.RiordinaFabbricati(1,9); disegna; end;
   exit;
  end;



 if GrigliaDati.Col = 14 then
  begin
   infocell := GrigliaDati.Cells[GrigliaDati.Col,GrigliaDati.row];
   if infocell='1' then
    begin
     LaAnagrafe.filtraFam1casaFgPartSub(GrigliaDati.Cells[1,GrigliaDati.row],GrigliaDati.Cells[2,GrigliaDati.row],GrigliaDati.Cells[3,GrigliaDati.row]);
     GliImmobiliDati.filtraPrimacasaFgPartSub(GrigliaDati.Cells[1,GrigliaDati.row],GrigliaDati.Cells[2,GrigliaDati.row],GrigliaDati.Cells[3,GrigliaDati.row],LaAnagrafe.listafamigliePrimaCasa);
     Form_PossessoPrimaCasa.show;
     Form_PossessoPrimaCasa.disegna;
    end  else Form_PossessoPrimaCasa.hide;
  end;


 if GrigliaDati.Col = 15 then
  begin
   infocell := GrigliaDati.Cells[GrigliaDati.Col,GrigliaDati.row];
   if infocell<>'' then
    begin
     GliImmobiliDati.filtraImuFgPartSub(GrigliaDati.Cells[1,GrigliaDati.row],GrigliaDati.Cells[2,GrigliaDati.row],GrigliaDati.Cells[3,GrigliaDati.row]);
     Form_Imu_Singola.show;
     Form_Imu_Singola.disegna;
    end
     else Form_TaresSingola.hide;
  end;


 if GrigliaDati.Col = 16 then
  begin
   infocell := GrigliaDati.Cells[GrigliaDati.Col,GrigliaDati.row];
   if infocell<>'0' then
//   if infocell='1' then
    begin
     GliImmobiliDati.filtraTaresFgPartSub(GrigliaDati.Cells[1,GrigliaDati.row],GrigliaDati.Cells[2,GrigliaDati.row],GrigliaDati.Cells[3,GrigliaDati.row]);
     Form_TaresSingola.show;
     Form_TaresSingola.disegna;
    end
     else Form_TaresSingola.hide;
  end;


 if GrigliaDati.Col = 17 then
  begin
   infocell := GrigliaDati.Cells[GrigliaDati.Col,GrigliaDati.row];
//   showmessage(infocell);
   if infocell<>'0' then
    begin
     LaAnagrafe.filtraFgPartSub(GrigliaDati.Cells[1,GrigliaDati.row],GrigliaDati.Cells[2,GrigliaDati.row],GrigliaDati.Cells[3,GrigliaDati.row]);
     Form_AnagrafeSingola.show;
     Form_AnagrafeSingola.disegna;
    end
     else Form_AnagrafeSingola.hide;
  end;

 if GrigliaDati.Col = 18 then
  begin
     GliImmobiliDati.filtraEdificioFgPartSub(GrigliaDati.Cells[1,GrigliaDati.row],GrigliaDati.Cells[2,GrigliaDati.row],GrigliaDati.Cells[3,GrigliaDati.row]);
    Form_PossessiImmobile.modo:=0;
    Form_PossessiImmobile.show;
    Form_PossessiImmobile.disegna;
  end;


 if GrigliaDati.Col = 19 then
  begin
   IlCatastoV.cercaFabbricato(GrigliaDati.Cells[1,GrigliaDati.row],GrigliaDati.Cells[2,GrigliaDati.row]);
//   GrigliaDati.Col :=22;
   ridisegna;
//   Mainform.Baseschermo.setfocus;
  end;

 if GrigliaDati.Col = 20 then
  begin
   IlCatastoV.FiltraImmobiliFgPart(GrigliaDati.Cells[1,GrigliaDati.row],GrigliaDati.Cells[2,GrigliaDati.row],GliImmobiliDati.listaFabbricatiFiltrata);
        Form_FabbricatoSingolo.mododisegna:=1;
        Form_FabbricatoSingolo.show;
        Form_FabbricatoSingolo.disegna;
  end;

end;

procedure TDlg_InfoFabbricato.GrigliaDatiDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var S: string;
    SavedAlign: word;
    LDelta : Integer;
    primarigaInd : Integer;
    LaListadaprendereDati : TList;
begin
   if ARow = 0 then begin  // ACol is zero based
    case Acol of
     0, 1 ,2,3,4,5,6,7,8,9,10,11,12,14,21,22,23,24:
      begin
       SavedAlign := SetTextAlign(GrigliaDati.Canvas.Handle, TA_CENTER);
       GrigliaDati.Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top +4 , GetTitolo(Acol));
       SetTextAlign(GrigliaDati.Canvas.Handle, SavedAlign);
      end;
        13 :  GrigliaDati.Canvas.Draw(Rect.Left, Rect.Top+2, image_casaverde) ;
        15 :  GrigliaDati.Canvas.Draw(Rect.Left, Rect.Top+2, image_ici) ;
        16 :  GrigliaDati.Canvas.Draw(Rect.Left, Rect.Top+2, image_dust) ;
        17 :  GrigliaDati.Canvas.Draw(Rect.Left, Rect.Top+2, image_family) ;
        18 :  GrigliaDati.Canvas.Draw(Rect.Left, Rect.Top+2, image_key) ;
        19 :  GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+2, image_map) ;
        20 :  GrigliaDati.Canvas.Draw(Rect.Left-4, Rect.Top+2, image_casa1) ;
    end;
  end else
  begin
    case Acol of


     14 : begin if GrigliaDati.Cells[Acol,Arow]<>'' then GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+4, image_doc_rid) ;    end;
     15 : begin if GrigliaDati.Cells[Acol,Arow]<>'' then GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+4, image_ici_rid) ;    end;
     16 : begin if GrigliaDati.Cells[Acol,Arow]<>'' then GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+4, image_dust_rid) ;    end;
     17 :
       begin
         if GrigliaDati.Cells[Acol,Arow]<>''   then
          begin
           if GrigliaDati.Cells[Acol,Arow]='1'   then GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+4, image_Family_rid)
                                                 else  GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+4, image_FamMult_rid)
          end;
       end;
     18 : begin if GrigliaDati.Cells[Acol,Arow]<>'' then GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+4, image_key_rid) ;  end;
     19 :  GrigliaDati.Canvas.Draw(Rect.Left+4, Rect.Top+4, image_map_rid) ;
     20 :  GrigliaDati.Canvas.Draw(Rect.Left-2, Rect.Top+4, image_casa1_rid) ;
    end;
  end;
end;


procedure TDlg_InfoFabbricato.Image1Click(Sender: TObject);
begin
 vediFoto(1);
end;

procedure TDlg_InfoFabbricato.Image2Click(Sender: TObject);
begin
 vediFoto(2);
end;

procedure TDlg_InfoFabbricato.Image3Click(Sender: TObject);
begin
 vediFoto(3);
end;

procedure TDlg_InfoFabbricato.Bot_ExportClick(Sender: TObject);
var F : TextFile;
    k : Integer;
begin

   savedialog1.FileName := 'Fabbricati';
   if savedialog1.execute then
    begin
     assignFile(F,savedialog1.FileName); rewrite (F);
      write(F,'Foglio');
      write(F,',Part');
      write(F,',Sub');
      write(F,',Toponimo Catastale');
      write(F,',via');
      write(F,',civico');
      write(F,',Toponimo Anagrafe');
      write(F,',via');
      write(F,',civico');

      write(F,',categoria');  // 13
      write(F,',Superficie');
      write(F,',Rendita');
      write(F,',Piano');
      write(F,',Interno');

      writeln(F,'');
      for k:=1 to GrigliaDati.RowCount do
       begin
        write(F,GrigliaDati.cells[1,k]); // Foglio
        write(F,','+GrigliaDati.cells[2,k]); // Particella
        write(F,','+GrigliaDati.cells[3,k]); // Subalterno

        write(F,','+GrigliaDati.cells[4,k]); // Top cat
        write(F,','+GrigliaDati.cells[5,k]); // via
        write(F,','+GrigliaDati.cells[6,k]); // civico cat

        write(F,','+GrigliaDati.cells[7,k]); // Top Anag
        write(F,','+GrigliaDati.cells[8,k]); // via
        write(F,','+GrigliaDati.cells[9,k]); // civico cat

        write(F,','+GrigliaDati.cells[13,k]); // categoria

        write(F,','+GrigliaDati.cells[21,k]); // sup
        write(F,','+GrigliaDati.cells[22,k]); // rend
        write(F,','+GrigliaDati.cells[23,k]); // piano
        write(F,','+GrigliaDati.cells[24,k]); // interno
        writeln(F,'');
       end;
     closefile(F);
    end;
end;

procedure TDlg_InfoFabbricato.Bot_ExtraInfoClick(Sender: TObject);
begin
 extraInfoVisibili := not (extraInfoVisibili);
 Pan_Extra.Visible :=extraInfoVisibili;
end;

procedure TDlg_InfoFabbricato.Bot_filtraCaseClick(Sender: TObject);
begin
 if  Bot_filtraCase.Down then begin filtroAttivo :=1 ; end
  else
   if  Bot_filtraNoCase.Down then begin filtroAttivo :=2 ; end
    else filtroAttivo :=0 ;
 disegna;
end;

procedure TDlg_InfoFabbricato.disegna;
var k : Integer;
   locfabdata : TFabCatDati;
   LaListadaprendereDati : TList;
   loctopo : String;
begin
 svuota;
 svuotaExtra;
 disegnaExtra;
 case mododisegna of
  0 : LaListadaprendereDati := GliImmobiliDati.listaFabbricati;
  1 : LaListadaprendereDati := GliImmobiliDati.listaFabbricatiFiltrata;
 end;

 // label per indicare se tutto o solo elemento
 case mododisegna of
  0 : begin caption :='Intera Tabella di tutti i Fabbricati'; end;
  1 : begin caption :='Info Edificio'; end;
 end;



 case filtroAttivo of
  0 : begin end;
  1 : begin realizzaListacase(1,LaListadaprendereDati);  LaListadaprendereDati := listraFiltrataCase;  end;
  2 : begin realizzaListacase(2,LaListadaprendereDati);  LaListadaprendereDati := listraFiltrataCase; end;
 end;


      GrigliaDati.RowCount:= LaListadaprendereDati.count+1;
      for k:= 0 to LaListadaprendereDati.count-1 do
       begin
        locfabdata := LaListadaprendereDati.items[k];
        GrigliaDati.Cells[0,k+1]:= IntToStr(k+1);
        GrigliaDati.Cells[1,k+1]:= locfabdata.Foglio;
        GrigliaDati.Cells[2,k+1]:= locfabdata.Particella;
        GrigliaDati.Cells[3,k+1]:= locfabdata.Subalterno;

        loctopo := interpretaTopoCatastale(locfabdata.Topo_Catastale);
        GrigliaDati.Cells[4,k+1]:= loctopo;
        GrigliaDati.Cells[5,k+1]:= locfabdata.Via_Catastale;
        GrigliaDati.Cells[6,k+1]:= locfabdata.Civico_Catastale;

        GrigliaDati.Cells[7,k+1]:= locfabdata.Topo_Anagrafe;
        GrigliaDati.Cells[8,k+1]:= locfabdata.Via_Anagrafe;
        GrigliaDati.Cells[9,k+1]:= locfabdata.Civico_Anagrafe;

        GrigliaDati.Cells[10,k+1]:= locfabdata.Topo_Corretta;
        GrigliaDati.Cells[11,k+1]:= locfabdata.Via_Corretta;
        GrigliaDati.Cells[12,k+1]:= locfabdata.Civico_Corretta;

        GrigliaDati.Cells[13,k+1]:= locfabdata.Categoria;
        if locfabdata.PrimaAbitazione0123<>'0' then
         GrigliaDati.Cells[14,k+1]:= locfabdata.PrimaAbitazione0123;


        if locfabdata.ICI_paganti.Count>0 then GrigliaDati.Cells[15,k+1]:= IntTostr(locfabdata.ICI_paganti.Count)
                                            else GrigliaDati.Cells[15,k+1]:='';

        if locfabdata.TARES_paganti.Count>0 then GrigliaDati.Cells[16,k+1]:= IntTostr(locfabdata.TARES_paganti.Count)
                                            else GrigliaDati.Cells[16,k+1]:='';

        if locfabdata.Residenti.Count>0 then GrigliaDati.Cells[17,k+1]:= IntTostr(locfabdata.Residenti.Count)
                                        else GrigliaDati.Cells[17,k+1]:='';

        if locfabdata.Possessi.Count>0 then GrigliaDati.Cells[18,k+1]:= IntTostr(locfabdata.Possessi.Count)
                                        else GrigliaDati.Cells[18,k+1]:='';


//        if locfabdata.Possessi.Count>0 then GrigliaDati.Cells[18,k+1]:= IntTostr(locfabdata.Possessi.Count)
//                                        else GrigliaDati.Cells[18,k+1]:='';

        if locfabdata.superficie='' then
          begin
           if locfabdata.Consistenza<>'' then  GrigliaDati.Cells[21,k+1]:= 'vani '+locfabdata.Consistenza;
          end
                                    else GrigliaDati.Cells[21,k+1]:= 'mq. '+ locfabdata.superficie;
        GrigliaDati.Cells[22,k+1]:= locfabdata.RenditaStrEuro;
        GrigliaDati.Cells[23,k+1]:= locfabdata.piano;
        GrigliaDati.Cells[24,k+1]:= locfabdata.Interno;

      end;
end;

procedure TDlg_InfoFabbricato.disegnaExtra;
begin
  GridExtra.Cells[0,0]:= 'P. Ter.';
  GridExtra.Cells[1,0]:= 'P. Res.';
  GridExtra.Cells[2,0]:= 'Uso';
  GridExtra.Cells[3,0]:= 'Uso Ter.';
  GridExtra.Cells[4,0]:= 'Q. Amb.';
  GridExtra.Cells[5,0]:= 'Q. Fab.';
  GridExtra.Cells[6,0]:= 'Sup L.';
  GridExtra.Cells[7,0]:= 'Vol Tot';
  GridExtra.Cells[8,0]:= 'Vol Res';
  GridExtra.Cells[9,0]:= 'Vol altre';

  GridExtra.Cells[0,1]:= '';
  GridExtra.Cells[1,1]:= '1';
  GridExtra.Cells[2,1]:= 'rrr';
  GridExtra.Cells[3,1]:= 'rrr';
  GridExtra.Cells[4,1]:= 'bbb';
  GridExtra.Cells[5,1]:= 'bbb';
  GridExtra.Cells[6,1]:= '80.84';
  GridExtra.Cells[7,1]:= '224.45';
  GridExtra.Cells[8,1]:= '224.45';
  GridExtra.Cells[9,1]:= '0';



  MemoNote.text :='qui le note specifiche';
end;



procedure TDlg_InfoFabbricato.DisIntestazione;
begin
// GrigliaDati.Cells[1,2]:='Fg';
end;

function  TDlg_InfoFabbricato.GetTitolo(colo : Integer) : String;
begin
 case colo of
  0 : result:=' ';
  1 : result:='Fg.';
  2 : result:='Part.';
  3 : result:='Sub';
  4 : result:='T';
  5 : result:='Via';
  6 : result:='Civ';

  7 : result:='T A';
  8 : result:='Via A';
  9 : result:='Civ A';

  10 : result:='T G';
  11 : result:='Via G';
  12 : result:='Civ G';

  14 : result:='1°';

  21 : result :='Sup.';
  22 : result :='Rendita';
  23 : result :='Pia.';
  24 : result :='Int';

  else result :='';
 end;
end;

procedure  TDlg_InfoFabbricato.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;   GrigliaDati.Row:=0;
end;


procedure  TDlg_InfoFabbricato.svuotaExtra;
var i : Integer;
begin
  for I := 0 to GridExtra.ColCount - 1 do  GridExtra.Cols[I].Clear;
 // GridExtra.RowCount := 2;   GridExtra.Row:=0;
end;

procedure TDlg_InfoFabbricato.vedifoto(cod : Integer);
begin
 case cod of
  1 : Form_FotoEdif.Image1.Picture := Image1.Picture;
  2 : Form_FotoEdif.Image1.Picture := Image2.Picture;
  3 : Form_FotoEdif.Image1.Picture := Image3.Picture;
 end;
 Form_FotoEdif.show;
end;



end.
