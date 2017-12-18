unit Dlg_Info;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls;

type
  TForm_Info = class(TForm)
    Label1: TLabel;
    Lab_Piano: TLabel;
    Label3: TLabel;
    Lab_Disegno: TLabel;
    Bot_VaiPiano: TSpeedButton;
    BotAddsel: TSpeedButton;
    BotTogliSel: TSpeedButton;
    Bot_prec: TSpeedButton;
    Bot_next: TSpeedButton;
    Lab_contatore: TLabel;
    Lab_Info: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Bot_nextClick(Sender: TObject);
    procedure Bot_precClick(Sender: TObject);
    procedure Bot_VaiPianoClick(Sender: TObject);
    procedure BotAddselClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotTogliSelClick(Sender: TObject);
  private
    { Private declarations }
  public
   procedure disegnacorrenteindice;
    { Public declarations }
  end;

var
  Form_Info: TForm_Info;

implementation


{$R *.dfm}

uses progetto, vettoriale,interfaccia,disegnoV,piano,CatastoV,varbase, Civico;



procedure TForm_Info.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Ilprogetto.ListaInfo.clear;
 ridisegna;
end;

procedure TForm_Info.FormShow(Sender: TObject);
begin
 Lab_Info.Visible:=false;
 disegnacorrenteindice;
end;

procedure TForm_Info.Bot_VaiPianoClick(Sender: TObject);
var k,j : Integer;
    locvet : TVettoriale;
    locdisv : TDisegnoV;
    locpian : TPiano;
begin
  if Ilprogetto.indToShow<=Ilprogetto.ListaInfo.Count then begin
   locvet := Ilprogetto.ListaInfo.items[Ilprogetto.indToShow];
   for k:= 0 to Ilprogetto.ListaDisegniV.Count-1 do
    begin
     locdisv := Ilprogetto.ListaDisegniV.items[k];
     if locdisv = locvet._disegno then
      begin
       IlProgetto.cambiadisegnocorrente(k);
       for j:=0 to locdisv.ListaPiani.Count-1 do
        begin
         locpian := locdisv.ListaPiani.items[j];
         if locpian = locvet._piano then
          begin
           IlProgetto.cambiaPianocorrente(j);
           break;
          end;
        end;
       break;
      end;
    end;
  end;
end;

procedure TForm_Info.BotAddselClick(Sender: TObject);
var k : Integer;
    presente : Boolean;
    locvet : TVettoriale;
    loctestvet : TVettoriale;
begin
 presente := false;
 if Ilprogetto.indToShow<=Ilprogetto.ListaInfo.Count then begin
   locvet := Ilprogetto.ListaInfo.items[Ilprogetto.indToShow];
   for k:=0 to Ilprogetto.ListaSelezionati.count-1 do
    begin
     loctestvet := Ilprogetto.ListaSelezionati.items[k];
     if (loctestvet= locvet) then presente := true;
    end;
   if not(presente) then
    begin Ilprogetto.ListaSelezionati.Add(locvet); ridisegna;   end;
 end;
 updateNumSelezionati;
end;

procedure TForm_Info.BotTogliSelClick(Sender: TObject);
var k : Integer;
    presente : Boolean;
    locvet : TVettoriale;
    loctestvet : TVettoriale;
begin
 presente := false;
 if Ilprogetto.indToShow<=Ilprogetto.ListaInfo.Count then begin
   locvet := Ilprogetto.ListaInfo.items[Ilprogetto.indToShow];
   for k:=Ilprogetto.ListaSelezionati.count-1 downto 0 do
    begin
     loctestvet := Ilprogetto.ListaSelezionati.items[k];
     if (loctestvet= locvet) then begin presente := true; Ilprogetto.ListaSelezionati.delete(k); end;
    end;
   if (presente) then ridisegna;
 end;
 updateNumSelezionati;
end;

procedure TForm_Info.Bot_nextClick(Sender: TObject);
begin
 inc(Ilprogetto.indToShow);
 if Ilprogetto.indToShow>=Ilprogetto.ListaInfo.Count then Ilprogetto.indToShow:=Ilprogetto.ListaInfo.Count-1;
 disegnacorrenteindice;
 ridisegna;
end;

procedure TForm_Info.Bot_precClick(Sender: TObject);
begin
 dec(Ilprogetto.indToShow);
 if Ilprogetto.indToShow<0 then Ilprogetto.indToShow:=0;
 disegnacorrenteindice;
 ridisegna;
end;

procedure TForm_Info.disegnacorrenteindice;
var locvet : TVettoriale;
    locCivico : TCivico;
begin
  if Ilprogetto.indToShow<=Ilprogetto.ListaInfo.Count then begin
   locvet := Ilprogetto.ListaInfo.items[Ilprogetto.indToShow];
   if locvet._disegno = ILCatastoV.QUnione then  Lab_Piano.Caption := locvet._piano.nomeFogliopiano
       else Lab_Piano.Caption := locvet._piano.nomepiano;
   if locvet._disegno = ILCatastoV.QUnione then Lab_Disegno.Caption := 'Quadro Unione'
                                           else Lab_Disegno.Caption := locvet._disegno.nomedisegno;
    Lab_contatore.Caption:=IntTostr(Ilprogetto.indToShow+1)+' / '+IntTostr(Ilprogetto.ListaInfo.Count);

    if (locvet.tipo = PCivico) then begin
      Lab_Info.Visible:=true;
      locCivico := Ilprogetto.ListaInfo.items[Ilprogetto.indToShow];
      Lab_Info.caption := locCivico.nomestrada+' n. '+ locCivico.txtciv ;
     end
     else Lab_Info.Visible:=false;


  end;
end;



end.
