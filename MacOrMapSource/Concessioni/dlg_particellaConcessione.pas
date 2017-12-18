unit dlg_particellaConcessione;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm_editPartConc = class(TForm)
    Label1: TLabel;
    Edit_Fg: TEdit;
    Label2: TLabel;
    Edit_part: TEdit;
    Label3: TLabel;
    Edit_miaPart: TEdit;
    Label4: TLabel;
    Edit_Sup: TEdit;
    Label5: TLabel;
    Edit_cat: TEdit;
    Label6: TLabel;
    Edit_classe: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure disegnalocale;
  end;

var
  Form_editPartConc: TForm_editPartConc;

implementation

{$R *.dfm}

uses PartConc;

procedure TForm_editPartConc.BitBtn2Click(Sender: TObject);
begin
    PartConcessioneCorrente.fg        := Edit_Fg.Text;
    PartConcessioneCorrente.Part      := Edit_part.Text;
    PartConcessioneCorrente.MioPart   := Edit_miaPart.Text;
    PartConcessioneCorrente.Sup       := Edit_Sup.Text;
    PartConcessioneCorrente.categoria := Edit_cat.Text;
    PartConcessioneCorrente.classe    := Edit_classe.Text;
end;

procedure TForm_editPartConc.disegnalocale;
begin
    Edit_Fg.Text      := PartConcessioneCorrente.fg;
    Edit_part.Text    := PartConcessioneCorrente.Part;
    Edit_miaPart.Text := PartConcessioneCorrente.MioPart;
    Edit_Sup.Text     := PartConcessioneCorrente.Sup;
    Edit_cat.Text     := PartConcessioneCorrente.categoria;
    Edit_classe.Text  := PartConcessioneCorrente.classe;
end;


procedure TForm_editPartConc.FormShow(Sender: TObject);
begin
 disegnalocale;
 Edit_miaPart.SetFocus;
end;

end.



