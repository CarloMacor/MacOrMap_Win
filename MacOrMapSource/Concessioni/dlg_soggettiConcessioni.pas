unit dlg_soggettiConcessioni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Buttons, Vcl.ExtCtrls;

type
  TForm_sogConc = class(TForm)
    PanTop: TPanel;
    Bot_Add: TSpeedButton;
    Bot_NonAssociati: TSpeedButton;
    PanLeft: TPanel;
    GrigliaDati: TStringGrid;
    PanRight: TPanel;
    PanBottom: TPanel;
    But_edit: TSpeedButton;
    But_Alfab: TSpeedButton;
    SpeedButton1: TSpeedButton;
    But_Export: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure GrigliaDatiDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GrigliaDatiClick(Sender: TObject);
    procedure Bot_NonAssociatiClick(Sender: TObject);
    procedure Bot_AddClick(Sender: TObject);
    procedure But_editClick(Sender: TObject);
    procedure GrigliaDatiDblClick(Sender: TObject);
    procedure But_AlfabClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure But_ExportClick(Sender: TObject);
  private
    { Private declarations }
  public
   function   GetTitolo(colo : Integer) : String;
   procedure  svuota;
   procedure  disegnaLocale;

    { Public declarations }
  end;

var
  Form_sogConc: TForm_sogConc;

implementation

{$R *.dfm}
uses LeConcessioni,SoggettoConcessione,varbase, dlg_contrattiConcessioni,
  dlg_editNomeConcessionario, ContrattoConcessione,progetto,ConcessioniV,PartConc;




procedure TForm_sogConc.FormShow(Sender: TObject);
begin
 GrigliaDati.row :=0;
 GrigliaDati.SetFocus;
 disegnaLocale;
end;

function  TForm_sogConc.GetTitolo(colo : Integer) : String;
begin
 case colo of
  0 : result:='id';
  1 : result:='Descrizione';
  2 : result:='Cont.';
  3 : result:='Dis.';
  else result :='';
 end;
end;


procedure TForm_sogConc.GrigliaDatiClick(Sender: TObject);
var infocell : String;
    loccontratto  : TContrattoConcessione;
    k : Integer;
    daviser : Boolean;
begin
 if GrigliaDati.row > 0  then
  begin
   if GrigliaDati.Col = 2 then
   begin
    SoggettoConcessionarioCorrente := ConcessioniTolfa.ListaSoggettiConcessioni.items[GrigliaDati.Row-1];
    infocell := GrigliaDati.Cells[0,GrigliaDati.row];
    if infocell<>'' then
     begin
      Form_contrattiConcessioni.infiltro :=true;
       ConcessioniTolfa.FiltraContratti(infocell);
       Form_contrattiConcessioni.show;
       Form_contrattiConcessioni.disegnaLocale;
     end  else Form_contrattiConcessioni.hide;
   end;

   if GrigliaDati.Col = 3 then // i Disegni;
   begin
     Ilprogetto.OpenConcessioni;

     SoggettoConcessionarioCorrente := ConcessioniTolfa.ListaSoggettiConcessioni.items[GrigliaDati.Row-1];

    infocell := GrigliaDati.Cells[0,GrigliaDati.row];
    if infocell<>'' then
     begin
       if Not(Inconcessioniproduction) then begin  end; // LeconcessioniV.ApriConcessioniTutte;
       ConcessioniTolfa.FiltraContrattiDisegni(infocell);
       for k:=0 to ConcessioniTolfa.ListaContrattiDisegniFiltrata.count-1 do
        begin
         loccontratto := ConcessioniTolfa.ListaContrattiDisegniFiltrata.items[k];
//         showmessage(loccontratto.idcontratto);
          // ApriDisegnoDaBottone(dirDisegniConcessioni+searchResult.Name);
         if Inconcessioniproduction then IlProgetto.apriDisegnoConcessioni(1,loccontratto.idcontratto,GrigliaDati.Cells[1,GrigliaDati.row])
          else
           begin
            if (k=0) then begin daviser:= LeconcessioniV.seVisibiledisegnodaCod(loccontratto.idcontratto);   LeconcessioniV.spegnituttiDisegni;  end;
            LeConcessioniV.apriseassentedaCod(loccontratto.idcontratto);
            LeConcessioniV.MettivisibiledisCod(loccontratto.idcontratto,not(daviser));
           end;
        end;

       if Not(Inconcessioniproduction) then begin LeconcessioniV.ZoomtuttoilVisibile; end;
     end

   end;

  end;
end;

procedure TForm_sogConc.GrigliaDatiDblClick(Sender: TObject);
var infocell : String;
    loccontratto  : TContrattoConcessione;
    k : Integer;

begin

exit;

 if GrigliaDati.row > 0  then
  begin
   if GrigliaDati.Col = 3 then // i Disegni;
   begin
     SoggettoConcessionarioCorrente := ConcessioniTolfa.ListaSoggettiConcessioni.items[GrigliaDati.Row-1];

    infocell := GrigliaDati.Cells[0,GrigliaDati.row];
    if infocell<>'' then
     begin
       ConcessioniTolfa.FiltraContrattiDisegni(infocell);
       for k:=0 to ConcessioniTolfa.ListaContrattiDisegniFiltrata.count-1 do
        begin
         loccontratto := ConcessioniTolfa.ListaContrattiDisegniFiltrata.items[k];
//         showmessage(loccontratto.idcontratto);
//          ApriDisegnoDaBottone(dirDisegniConcessioni+searchResult.Name);
         IlProgetto.apriDisegnoConcessioni(2,loccontratto.idcontratto,GrigliaDati.Cells[1,GrigliaDati.row]);

        end;
     end

   end;
  end;
 //
end;

procedure TForm_sogConc.GrigliaDatiDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var S: string;
    SavedAlign: word;
    LDelta : Integer;
begin
   if ARow = 0 then begin  // ACol is zero based
 //   S := GrigliaDati.Cells[ACol, ARow]; // cell contents
    case Acol of
     0, 1,2 ,3 :
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
      2 :
       begin
        if (GrigliaDati.Cells[ACol,Arow]<>'0') then
         begin
          if (GrigliaDati.Cells[ACol,Arow]='1') then
            GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+2, image_doc_rid)
           else
            GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+2, image_docs_rid)
         end;
       end;
      3 :
       begin
        if (GrigliaDati.Cells[ACol,Arow]<>'0') then
         begin
          if (GrigliaDati.Cells[ACol,Arow]='1') then
            GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+2, image_map_rid)
           else
            GrigliaDati.Canvas.Draw(Rect.Left+2, Rect.Top+2, image_mappe_rid)
         end;
       end;
    end;
  end;
end;

procedure TForm_sogConc.SpeedButton1Click(Sender: TObject);
var k,j : integer;
    locsoggetto : TSoggettoConcessione;
    sottoggetto : TSoggettoConcessione;
    locContratto : TContrattoConcessione;
begin
    for k:=ConcessioniTolfa.ListaSoggettiConcessioni.count-1 downto 1 do
     begin
      locsoggetto := ConcessioniTolfa.ListaSoggettiConcessioni.items[k-1];
      sottoggetto := ConcessioniTolfa.ListaSoggettiConcessioni.items[k];
      if StrComp(PChar(locsoggetto.descrizione),PChar(sottoggetto.descrizione)) = 0 then
       begin
        for j:=sottoggetto.elencoContratti.Count-1 downto 0 do
         begin
          locContratto := sottoggetto.elencoContratti.items[j];
          locContratto.idConcessonario:=locsoggetto.id;
          locsoggetto.elencoContratti.Add(locContratto);
          sottoggetto.elencoContratti.delete(j);
         end;
         ConcessioniTolfa.ListaSoggettiConcessioni.delete(k);
//         break;
       end;
     end;
end;

procedure  TForm_sogConc.svuota;
var i : Integer;
begin
  for I := 0 to GrigliaDati.ColCount - 1 do  GrigliaDati.Cols[I].Clear;
  GrigliaDati.RowCount := 1;
end;

procedure TForm_sogConc.Bot_AddClick(Sender: TObject);
var locsoggetto  : TSoggettoConcessione;
//    preind : Integer;
    presoggetto  : TSoggettoConcessione;
begin
   inc(ConcessioniTolfa.ultimoIdSoggetto);
   locsoggetto := TSoggettoConcessione.Create;
   ConcessioniTolfa.ListaSoggettiConcessioni.Add(locsoggetto);
   locsoggetto.id          := IntToStr(ConcessioniTolfa.ultimoIdSoggetto);
   locsoggetto.descrizione := 'Nuovo Soggetto';
   locsoggetto.CFIVA       := '';
   disegnaLocale;
end;

procedure TForm_sogConc.Bot_NonAssociatiClick(Sender: TObject);
begin
 ConcessioniTolfa.salva;
end;

procedure TForm_sogConc.But_AlfabClick(Sender: TObject);
begin
 ConcessioniTolfa.RiordinaAlfabeticamenteSoggerri;
 disegnaLocale;
end;

procedure TForm_sogConc.But_editClick(Sender: TObject);
begin
 if GrigliaDati.Row>0 then
  begin
    SoggettoConcessionarioCorrente := ConcessioniTolfa.ListaSoggettiConcessioni.items[GrigliaDati.Row-1];
    Form_editNomeConcessionario.showmodal;
    disegnaLocale;
  end;
end;




procedure TForm_sogConc.But_ExportClick(Sender: TObject);
var k,j,m : Integer;
    locsoggetto  : TSoggettoConcessione;
    locContratto : TContrattoConcessione;
    F : TextFile;
    G : TextFile;
    supTot : Integer;
    supStrContratto : String;
    supContratto : Integer;
    coda : Integer;
    supTotTot : Integer;
    decrqual : String;
    locpartconc :  TPartConc;
    locCatpart : Integer;
    locClapart : Integer;

    locsuppart : Integer;

    supvarie   : Integer;
    sup26      : Integer;
    suporto    : Integer;
    suportoirr : Integer;
    suppasccespug : Integer;
    supseminativo : Integer;
    supboscoced   : Integer;
    supcastfrutto : Integer;
    supseminarbor : Integer;
    supfrutteto   : Integer;
    suppascolo    : Integer;
    suppascarb    : Integer;
    supvigneto    : Integer;
    supfabrurale  : Integer;
    supincoltprod : Integer;
    supcava       : Integer;
    supurbano     : Integer;

    testsomma : Integer;

begin
 assignFile(F,'test.txt'); rewrite(F);
 assignFile(G,'colla.txt'); rewrite(G);

 //

 write(F,'Descrizione');
 write(F,',Totale');
 write(F,',Varie');
 write(F,',Seminativo');
 write(F,',Sem arboreo');
 write(F,',Inc. prod.');
 write(F,',Pascolo');
 write(F,',Pascolo cesp.');
 write(F,',Pascolo arb');
 write(F,',Bosco ced.');
 write(F,',orto irriguo');
 write(F,',orto');

 write(F,',cast frutto');
 write(F,',frutteto');
 write(F,',vigneto');
 write(F,',cava');
 write(F,',urbano');
 write(F,',fab rurale');
 write(F,',altro');


 writeln(F,'');
   supTotTot:=0;
    for k:= 0 to ConcessioniTolfa.ListaSoggettiConcessioni.count-1 do
     begin
      supTot :=0;

      supvarie :=0;
      sup26    :=0;
      suporto  :=0;
      suportoirr :=0;
      suppasccespug := 0;
      supseminativo := 0;
      supboscoced   :=0;
      supcastfrutto :=0;
      supseminarbor :=0;
      supfrutteto   :=0;
      suppascolo    :=0;
      suppascarb    :=0;
      supvigneto    :=0;
      supfabrurale  :=0;
      supincoltprod :=0;
      supcava       :=0;
      supurbano     :=0;


      locsoggetto := ConcessioniTolfa.ListaSoggettiConcessioni.items[k];
      write(F,locsoggetto.descrizione);
      for j:=0 to locsoggetto.elencoContratti.Count-1 do
       begin
        locContratto    := locsoggetto.elencoContratti.items[j];
        supStrContratto := locContratto.superficietotale;
        if supStrContratto<>'' then
         begin
          val (supStrContratto,supContratto,coda);
          if coda=0 then begin supTot :=supTot+supContratto; end else showmessage('No sup '+locsoggetto.descrizione);
         end
          else
         begin
          if locContratto.supforfettaria=0 then locContratto.calcolasup else showmessage('Forf=0 '+locsoggetto.descrizione);
          supStrContratto := locContratto.superficietotale;
          val (supStrContratto,supContratto,coda);
          if supContratto=0 then
           begin
 //           writeln(G,'sup a 0 '+locsoggetto.descrizione);  showmessage( 'sup=0 '+locsoggetto.descrizione);
           end;
          if coda=0 then begin supTot :=supTot+supContratto; end else showmessage('No sup2 '+locsoggetto.descrizione);
         end;

         if (locContratto.supforfettaria=1) then begin supvarie      := supvarie+supContratto; continue; end;


         for m:=0 to locContratto.ListaParteParticelle.Count-1 do
          begin
           locCatpart :=0; locClapart :=0;

           locpartconc := locContratto.ListaParteParticelle.items[m];
           if (locpartconc.Sup='') then locpartconc.Sup:='0';
           val (locpartconc.Sup,locsuppart,coda);
           if coda<>0 then begin
             writeln(G,'No sup  '+locsoggetto.descrizione+'  '+locpartconc.Fg+' '+locpartconc.Part);
             continue;
           end;

           if locpartconc.categoria = 'modello 26'  then locCatpart :=1;
           if locpartconc.categoria = 'orto irrig'  then locCatpart :=2;
           if locpartconc.categoria = 'pasc cespug' then locCatpart :=3;
           if locpartconc.categoria = 'seminativo'  then locCatpart :=4;
           if locpartconc.categoria = 'bosco ceduo' then locCatpart :=5;
           if locpartconc.categoria = 'cast frutto' then locCatpart :=6;
           if locpartconc.categoria = 'semin arbor' then locCatpart :=7;
           if locpartconc.categoria = 'frutteto'    then locCatpart :=8;
           if locpartconc.categoria = 'pascolo'     then locCatpart :=9;
           if locpartconc.categoria = 'pasc arb'    then locCatpart :=10;
           if locpartconc.categoria = 'vigneto'     then locCatpart :=11;
           if locpartconc.categoria = 'fab rurale'  then locCatpart :=12;
           if locpartconc.categoria = 'incolt prod' then locCatpart :=13;
           if locpartconc.categoria = 'orto'        then locCatpart :=14;
           if locpartconc.categoria = 'cava'        then locCatpart :=15;
           if locpartconc.categoria = 'Urbano'      then locCatpart :=16;
           if locpartconc.categoria = 'FU'          then locCatpart :=16;
           if locpartconc.categoria = 'ex FU'       then locCatpart :=16;
           if locpartconc.categoria = 'fu d accert' then locCatpart :=16;
           if locpartconc.categoria = ''            then locCatpart :=17;
 //          if locpartconc.categoria = 'autovia sp'  then locCatpart :=18;


           case locCatpart of
             0, 17 : begin  //             writeln(G,'--'+locpartconc.categoria);
               supvarie      := supvarie+locsuppart;
               end;
             1 : begin sup26         := sup26+locsuppart; end;
             2 : begin suportoirr    := suportoirr+locsuppart; end;
             3 : begin suppasccespug := suppasccespug+locsuppart; end;
             4 : begin supseminativo := supseminativo+locsuppart; end;
             5 : begin supboscoced   := supboscoced+locsuppart; end;
             6 : begin supcastfrutto := supcastfrutto+locsuppart; end;
             7 : begin supseminarbor := supseminarbor+locsuppart; end;
             8 : begin supfrutteto   := supfrutteto+locsuppart; end;
             9 : begin suppascolo    := suppascolo+locsuppart; end;
            10 : begin suppascarb    := suppascarb+locsuppart; end;
            11 : begin supvigneto    := supvigneto+locsuppart; end;
            12 : begin supfabrurale  := supfabrurale+locsuppart; end;
            13 : begin supincoltprod := supincoltprod+locsuppart; end;
            14 : begin suporto       := suporto+locsuppart; end;
            15 : begin supcava       := supcava+locsuppart; end;
            16 : begin supurbano     := supurbano+locsuppart; end;
            else begin end;
           end;


          end;
       end;
       write(F,',');  write(F,supTot);

  //     if locContratto.supforfettaria=1 then begin testsomma := StrToInt(locContratto.superficietotale); end;

        testsomma := supvarie + sup26 + suportoirr + suppasccespug + supseminativo +
                     supboscoced + supcastfrutto + supseminarbor + supfrutteto +
                     suppascolo + suppascarb + supvigneto + supfabrurale + supincoltprod +
                     suporto + supcava + supurbano;



       write(F,',');  write(F,sup26);
       write(F,',');  write(F,supseminativo);
       write(F,',');  write(F,supseminarbor);
       write(F,',');  write(F,supincoltprod);
       write(F,',');  write(F,suppascolo);
       write(F,',');  write(F,suppasccespug);
       write(F,',');  write(F,suppascarb);
       write(F,',');  write(F,supboscoced);
       write(F,',');  write(F,suportoirr);
       write(F,',');  write(F,suporto);
       write(F,',');  write(F,supcastfrutto);
       write(F,',');  write(F,supfrutteto);
       write(F,',');  write(F,supvigneto);
       write(F,',');  write(F,supcava);
       write(F,',');  write(F,supurbano);
       write(F,',');  write(F,supfabrurale);
       write(F,',');  write(F,supvarie);



  //     write(F,',');  write(F,testsomma);
  //     if testsomma<>supTot then begin  writeln(G,'-'+locsoggetto.descrizione+'  tot:'+IntTostr(supTot)+' test:'+IntToStr(testsomma)); end;

       supTotTot  := supTotTot+supTot;
       writeln(F,'');

     end;

       writeln(F,','+IntToStr(supTotTot));

  closefile(F);
  closefile(G);
end;

procedure TForm_sogConc.disegnaLocale;
var k : Integer;
    locsoggetto : TSoggettoConcessione;
    lastInd : Integer;
begin
 lastInd := GrigliaDati.row;
 svuota;
    GrigliaDati.RowCount:= ConcessioniTolfa.ListaSoggettiConcessioni.count+1;
    for k:= 0 to ConcessioniTolfa.ListaSoggettiConcessioni.count-1 do
     begin
      locsoggetto := ConcessioniTolfa.ListaSoggettiConcessioni.items[k];
      GrigliaDati.Cells[0,k+1]:= locsoggetto.id;
      GrigliaDati.Cells[1,k+1]:= locsoggetto.descrizione;
      GrigliaDati.Cells[2,k+1]:= IntToStr(locsoggetto.elencoContratti.Count);
      GrigliaDati.Cells[3,k+1]:= IntToStr(locsoggetto.elencoContratti.Count);
     end;

 if ((lastInd>0) and (lastInd<= ConcessioniTolfa.ListaSoggettiConcessioni.count)) then
  begin GrigliaDati.row := lastInd; end;

end;


end.
