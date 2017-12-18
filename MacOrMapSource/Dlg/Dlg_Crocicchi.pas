unit Dlg_Crocicchi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm_Crocicchi = class(TForm)
    BitBtn1: TBitBtn;
    Edit_X1: TEdit;
    Edit_Y1: TEdit;
    Edit_X2: TEdit;
    Edit_Y2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
   procedure svuota;
    { Public declarations }
  end;

var
  Form_Crocicchi: TForm_Crocicchi;

implementation

{$R *.dfm}
uses varbase;

procedure TForm_Crocicchi.FormShow(Sender: TObject);
begin
 Edit_X1.Enabled:=false; Edit_X2.Enabled:=false;
 Edit_Y1.Enabled:=false; Edit_Y2.Enabled:=false;

 case fasecomando of
  0 : begin Edit_X1.Enabled:=true; Edit_X1.SetFocus; end;
  1 : begin Edit_Y1.Enabled:=true; Edit_Y1.SetFocus; end;
  2 : begin Edit_X2.Enabled:=true; Edit_X2.SetFocus; end;
  3 : begin Edit_Y2.Enabled:=true; Edit_Y2.SetFocus; end;

 end;

end;

procedure TForm_Crocicchi.svuota;
begin
 Edit_X1.Text:=''; Edit_X2.Text:='';
 Edit_Y1.Text:=''; Edit_Y2.Text:='';
 Edit_X1.Enabled:=false; Edit_X2.Enabled:=false;
 Edit_Y1.Enabled:=false; Edit_Y2.Enabled:=false;

end;


end.
