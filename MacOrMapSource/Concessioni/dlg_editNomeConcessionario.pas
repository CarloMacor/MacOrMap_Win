unit dlg_editNomeConcessionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm_editNomeConcessionario = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_editNomeConcessionario: TForm_editNomeConcessionario;

implementation

{$R *.dfm}
uses SoggettoConcessione;


procedure TForm_editNomeConcessionario.BitBtn2Click(Sender: TObject);
begin
 if SoggettoConcessionarioCorrente<>nil then
   SoggettoConcessionarioCorrente.descrizione := edit1.Text;
end;

procedure TForm_editNomeConcessionario.FormShow(Sender: TObject);
begin
 if SoggettoConcessionarioCorrente<>nil then
   edit1.Text := SoggettoConcessionarioCorrente.descrizione;
end;

end.
