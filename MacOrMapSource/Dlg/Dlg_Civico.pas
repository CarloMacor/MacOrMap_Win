unit Dlg_Civico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm_txtCivico = class(TForm)
    Edit_nrCiv: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    inedit : boolean;
    { Public declarations }
  end;

var
  Form_txtCivico: TForm_txtCivico;


implementation

{$R *.dfm}

uses civico;

procedure TForm_txtCivico.FormShow(Sender: TObject);
begin
 Edit_nrCiv.Text:='';
 if inedit then
  begin
   if CivicoinEdit<>nil then Edit_nrCiv.Text:= CivicoinEdit.txtciv;
  end;

 Edit_nrCiv.SetFocus;
end;

end.
