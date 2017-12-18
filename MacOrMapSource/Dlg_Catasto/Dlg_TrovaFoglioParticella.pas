unit Dlg_TrovaFoglioParticella;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TForm_TrovaFoglioParticella = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Bot_Grafica: TBitBtn;
    ED_FG: TEdit;
    ED_Part: TEdit;
    Bot_Tabella: TBitBtn;
    RadioGroup1: TRadioGroup;
    Bot_vedofoglio: TBitBtn;
    Bot_vedotuttifogli: TBitBtn;
    procedure Bot_GraficaClick(Sender: TObject);
    procedure Bot_TabellaClick(Sender: TObject);
    procedure Bot_vedotuttifogliClick(Sender: TObject);
    procedure Bot_vedofoglioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_TrovaFoglioParticella: TForm_TrovaFoglioParticella;

implementation

{$R *.dfm}

uses catastoV, interfaccia,ImmobiliDati, Dlg_FabbricatoSingolo;

procedure TForm_TrovaFoglioParticella.Bot_TabellaClick(Sender: TObject);
var fg_str : String;
    part_str : String;
begin
 close;
 if Ed_Fg.Text='' then begin  exit; end;

 fg_str    := Ed_Fg.Text;
 part_str  := Ed_part.Text;

 if part_str='' then
  begin

  end
   else
  begin
   IlCatastoV.FiltraImmobiliFgPart(fg_str,part_str,GliImmobiliDati.listaFabbricatiFiltrata);
   Form_FabbricatoSingolo.mododisegna:=1;
   Form_FabbricatoSingolo.show;
   Form_FabbricatoSingolo.disegna;
  end;
end;




procedure TForm_TrovaFoglioParticella.Bot_vedofoglioClick(Sender: TObject);
begin
 IlCatastoV.vedosolofoglio(Ed_Fg.Text);
  close;
end;

procedure TForm_TrovaFoglioParticella.Bot_vedotuttifogliClick(Sender: TObject);
begin
 IlCatastoV.vedotuttifogli;
  close;
end;

procedure TForm_TrovaFoglioParticella.Bot_GraficaClick(Sender: TObject);
var fg_str : String;
    part_str : String;
begin
 close;
 if Ed_Fg.Text='' then begin  exit; end;

 fg_str    := Ed_Fg.Text;
 part_str  := Ed_part.Text;

 if part_str='' then
  begin
   IlCatastoV.cercaFoglio(fg_str);
   ridisegna;
  end
   else
  begin
   case RadioGroup1.ItemIndex of
    0 : IlCatastoV.cercaFabbricato(fg_str,part_str);
    1 :  IlCatastoV.cercaTerreno(fg_str,part_str);
   end;
   ridisegna;
  end;
  close;
end;



end.
