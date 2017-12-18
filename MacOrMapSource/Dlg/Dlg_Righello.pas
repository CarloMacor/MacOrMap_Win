unit Dlg_Righello;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm_Righello = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Old_distanza: TLabel;
    EditNuovaDist: TEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Righello: TForm_Righello;

implementation

{$R *.dfm}

uses Varbase, Progetto;

procedure TForm_Righello.BitBtn1Click(Sender: TObject);
var datoinserito : real;
begin
 try
	datoinserito := StrToFloat(EditNuovaDist.text);
	if (datoinserito>0.1) then begin IlProgetto.GrCorrente.updateScalaGR((datoinserito/lastdist)); end;
 finally
 end;
end;

end.
