unit dlg_InfoAnagrafe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm_InfoAnagrafe = class(TForm)
    Label3: TLabel;
    Lab_Associate: TLabel;
    Label1: TLabel;
    LabNumfam: TLabel;
    Label2: TLabel;
    LabNumRes: TLabel;
    Label4: TLabel;
    Lab_nocivico: TLabel;
    Label6: TLabel;
    lab_snc: TLabel;
    lab_rap1: TLabel;
    lab_rap2: TLabel;
    lab_rap3: TLabel;
    Label5: TLabel;
    Lab_tofix: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_InfoAnagrafe: TForm_InfoAnagrafe;

implementation

{$R *.dfm}

uses Anagrafe,Famiglia;

procedure TForm_InfoAnagrafe.FormShow(Sender: TObject);
var conta, k  : Integer;
    locfam : TFamiglia;
    rap : real;
begin

 LabNumFam.Caption:= IntToStr(LaAnagrafe.listaFamiglie.count);
 LabNumRes.Caption:= IntToStr(LaAnagrafe.listaResidenti.count);

 conta := 0;
 for k:=0 to LaAnagrafe.listaFamiglie.count-1 do
  begin
   locfam := LaAnagrafe.listaFamiglie.items[k];
   if locfam.associato then inc(conta);
  end;
 Lab_Associate.Caption:= IntToStr(conta);
 rap := (conta/LaAnagrafe.listaFamiglie.count)*100;
 lab_rap1.Caption:= FloatToStrF(rap, ffGeneral, 4, 4);


 conta := 0;
 for k:=0 to LaAnagrafe.listaFamiglie.count-1 do
  begin
   locfam := LaAnagrafe.listaFamiglie.items[k];
   if locfam.civico='' then inc(conta);
  end;
 Lab_nocivico.Caption:= IntToStr(conta);
 rap := (conta/LaAnagrafe.listaFamiglie.count)*100;
 lab_rap2.Caption:= FloatToStrF(rap, ffGeneral, 4, 4);

 conta := 0;
 for k:=0 to LaAnagrafe.listaFamiglie.count-1 do
  begin
   locfam := LaAnagrafe.listaFamiglie.items[k];
   if Uppercase(locfam.civico)='SNC' then inc(conta);
  end;
 lab_snc.Caption:= IntToStr(conta);
 rap := (conta/LaAnagrafe.listaFamiglie.count)*100;
 lab_rap3.Caption:= FloatToStrF(rap, ffGeneral, 4, 4);

 conta := 0;
 for k:=0 to LaAnagrafe.listaFamiglie.count-1 do
  begin
   locfam := LaAnagrafe.listaFamiglie.items[k];
   if locfam.associato then continue;
   if locfam.civico='' then continue;
   if UpperCase(locfam.civico)='SNC' then continue;
   inc(conta);
  end;
 lab_tofix.Caption:= IntToStr(conta);



end;

end.
