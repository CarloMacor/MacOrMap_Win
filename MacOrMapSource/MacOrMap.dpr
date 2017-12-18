program MacOrMap;

{$R *.dres}

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  DisegnoV in 'Vector\DisegnoV.pas',
  Piano in 'Vector\Piano.pas',
  DisegnoR in 'Raster\DisegnoR.pas',
  uRaster in 'Raster\uRaster.pas',
  Vettoriale in 'Vector\Vettoriale.pas',
  Vertice in 'Vector\Vertice.pas',
  Testo in 'Vector\Testo.pas',
  Simbolo in 'Vector\Simbolo.pas',
  Punto in 'Vector\Punto.pas',
  Polylinea in 'Vector\Polylinea.pas',
  Cerchio in 'Vector\Cerchio.pas',
  Arco in 'Vector\Arco.pas',
  DefSimbolo in 'Vector\DefSimbolo.pas',
  Vcl.Themes,
  Vcl.Styles,
  uVector in 'Vector\uVector.pas',
  DisegnoGR in 'Raster\DisegnoGR.pas',
  Dlg_SpostaTerritorio in 'Dlg\Dlg_SpostaTerritorio.pas' {Form_SpostaTerritorio},
  Dlg_Fabbricato in 'Dlg_Catasto\Dlg_Fabbricato.pas' {Dlg_InfoFabbricato},
  Dlg_Griglia in 'Dlg\Dlg_Griglia.pas' {Form_Griglia},
  Dlg_Righello in 'Dlg\Dlg_Righello.pas' {Form_Righello},
  Dlg_Crocicchi in 'Dlg\Dlg_Crocicchi.pas' {Form_Crocicchi},
  Costanti in 'Utilita\Costanti.pas',
  Funzioni in 'Utilita\Funzioni.pas',
  InitApply in 'Main\InitApply.pas',
  Varbase in 'Main\Varbase.pas',
  Utility1 in 'Utilita\Utility1.pas',
  Proiezioni in 'Utilita\Proiezioni.pas',
  Interfaccia in 'Main\Interfaccia.pas',
  Progetto in 'Main\Progetto.pas',
  UViste in 'Utilita\UViste.pas',
  CatastoV in 'Vector\CatastoV.pas',
  Anagrafe in 'Tributi\Anagrafe.pas',
  Residente in 'Tributi\Residente.pas',
  Famiglia in 'Tributi\Famiglia.pas',
  FabCatDati in 'Tributi\FabCatDati.pas',
  ImmobiliDati in 'Tributi\ImmobiliDati.pas',
  Dlg_Testo in 'Dlg\Dlg_Testo.pas' {Form_Text},
  Dlg_Info in 'Dlg\Dlg_Info.pas' {Form_Info},
  ListaDefSimboli in 'Vector\ListaDefSimboli.pas',
  Dlg_Simbolo in 'Dlg\Dlg_Simbolo.pas' {Form_Simbolo},
  TerCatDati in 'Tributi\TerCatDati.pas',
  Dlg_Terreno in 'Dlg_Catasto\Dlg_Terreno.pas' {Dlg_InfoTerreno},
  Dlg_FotoFabbricato in 'Dlg_Catasto\Dlg_FotoFabbricato.pas' {Form_FotoEdif},
  Proprietario in 'Tributi\Proprietario.pas',
  Possesso in 'Tributi\Possesso.pas',
  Soggetto in 'Tributi\Soggetto.pas',
  Dlg_Soggetti in 'Dlg_Catasto\Dlg_Soggetti.pas' {Form_Soggetti},
  Tares in 'Tributi\Tares.pas',
  Dlg_Tares in 'Dlg_Catasto\Dlg_Tares.pas' {Form_Tares},
  Dlg_TaresSingola in 'Dlg_Catasto\Dlg_TaresSingola.pas' {Form_TaresSingola},
  Dlg_FabbricatoSingolo in 'Dlg_Catasto\Dlg_FabbricatoSingolo.pas' {Form_FabbricatoSingolo},
  Dlg_possessiTutti in 'Dlg_Catasto\Dlg_possessiTutti.pas' {Form_PossessiTutti},
  Dlg_possessoPrimaCasa in 'Dlg_Catasto\Dlg_possessoPrimaCasa.pas' {Form_PossessoPrimaCasa},
  Dlg_possessiImmobile in 'Dlg_Catasto\Dlg_possessiImmobile.pas' {Form_PossessiImmobile},
  FunzioniconListe in 'Utilita\FunzioniconListe.pas',
  Dlg_TerrenoSingolo in 'Dlg_Catasto\Dlg_TerrenoSingolo.pas' {Form_TerrenoSingolo},
  Dlg_TrovaFoglioParticella in 'Dlg_Catasto\Dlg_TrovaFoglioParticella.pas' {Form_TrovaFoglioParticella},
  Dlg_ImportTracciato in 'Dlg_Catasto\Dlg_ImportTracciato.pas' {Form_Tracciato},
  Dlg_Imu in 'Dlg_Catasto\Dlg_Imu.pas' {Form_Imu},
  Imu in 'Tributi\Imu.pas',
  dlgAnagrafe in 'Dlg_Catasto\dlgAnagrafe.pas' {FormAnagrafe},
  dlgAnagrafeSingola in 'Dlg_Catasto\dlgAnagrafeSingola.pas' {Form_AnagrafeSingola},
  Dlg_ImuSingola in 'Dlg_Catasto\Dlg_ImuSingola.pas' {Form_Imu_Singola},
  Dlg_Raster in 'Dlg\Dlg_Raster.pas' {Form_GestRaster},
  Dlg_Vector in 'Dlg\Dlg_Vector.pas' {Form_GestVettoriale},
  dlg_InfoAnagrafe in 'Dlg_Catasto\dlg_InfoAnagrafe.pas' {Form_InfoAnagrafe},
  Civico in 'Vector\Civico.pas',
  Dlg_Civico in 'Dlg\Dlg_Civico.pas' {Form_txtCivico},
  dlg_EditFgPartSub_Anagrafe in 'Dlg_Catasto\dlg_EditFgPartSub_Anagrafe.pas' {Form_EditFgAnagrafe},
  Dlg_TestCivicoStrade in 'Dlg\Dlg_TestCivicoStrade.pas' {Form_TestInfo},
  dlg_EditIndirizzo_Anagrafe in 'Dlg_Catasto\dlg_EditIndirizzo_Anagrafe.pas' {Form_editIndirizzoAnagrafe},
  Dlg_EditTesto in 'Dlg\Dlg_EditTesto.pas' {Form_editTesto},
  dlgAnagrafeEdificio in 'Dlg_Catasto\dlgAnagrafeEdificio.pas' {Form_anagEdificio},
  SoggettoConcessione in 'Concessioni\SoggettoConcessione.pas',
  ContrattoConcessione in 'Concessioni\ContrattoConcessione.pas',
  LeConcessioni in 'Concessioni\LeConcessioni.pas',
  dlg_soggettiConcessioni in 'Concessioni\dlg_soggettiConcessioni.pas' {Form_sogConc},
  dlg_contrattiConcessioni in 'Concessioni\dlg_contrattiConcessioni.pas' {Form_contrattiConcessioni},
  dlg_contrattoConcessione in 'Concessioni\dlg_contrattoConcessione.pas' {Form_contrattoConcessione},
  PartConc in 'Concessioni\PartConc.pas',
  dlg_editNomeConcessionario in 'Concessioni\dlg_editNomeConcessionario.pas' {Form_editNomeConcessionario},
  dlg_particellaConcessione in 'Concessioni\dlg_particellaConcessione.pas' {Form_editPartConc},
  ConcessioniV in 'Vector\ConcessioniV.pas',
  Dlg_dist in 'Dlg\Dlg_dist.pas' {Form_Infodist},
  Dlg_stampa in 'Dlg\Dlg_stampa.pas' {Form_Stampa};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TForm_SpostaTerritorio, Form_SpostaTerritorio);
  Application.CreateForm(TDlg_InfoFabbricato, Dlg_InfoFabbricato);
  Application.CreateForm(TForm_Griglia, Form_Griglia);
  Application.CreateForm(TForm_Righello, Form_Righello);
  Application.CreateForm(TForm_Crocicchi, Form_Crocicchi);
  Application.CreateForm(TForm_Text, Form_Text);
  Application.CreateForm(TForm_Info, Form_Info);
  Application.CreateForm(TForm_Simbolo, Form_Simbolo);
  Application.CreateForm(TDlg_InfoTerreno, Dlg_InfoTerreno);
  Application.CreateForm(TForm_FotoEdif, Form_FotoEdif);
  Application.CreateForm(TForm_Soggetti, Form_Soggetti);
  Application.CreateForm(TForm_Tares, Form_Tares);
  Application.CreateForm(TForm_TaresSingola, Form_TaresSingola);
  Application.CreateForm(TForm_FabbricatoSingolo, Form_FabbricatoSingolo);
  Application.CreateForm(TForm_PossessiTutti, Form_PossessiTutti);
  Application.CreateForm(TForm_PossessoPrimaCasa, Form_PossessoPrimaCasa);
  Application.CreateForm(TForm_PossessiImmobile, Form_PossessiImmobile);
  Application.CreateForm(TForm_TerrenoSingolo, Form_TerrenoSingolo);
  Application.CreateForm(TForm_TrovaFoglioParticella, Form_TrovaFoglioParticella);
  Application.CreateForm(TForm_Tracciato, Form_Tracciato);
  Application.CreateForm(TForm_Imu, Form_Imu);
  Application.CreateForm(TFormAnagrafe, FormAnagrafe);
  Application.CreateForm(TForm_AnagrafeSingola, Form_AnagrafeSingola);
  Application.CreateForm(TForm_Imu_Singola, Form_Imu_Singola);
  Application.CreateForm(TForm_GestRaster, Form_GestRaster);
  Application.CreateForm(TForm_GestVettoriale, Form_GestVettoriale);
  Application.CreateForm(TForm_InfoAnagrafe, Form_InfoAnagrafe);
  Application.CreateForm(TForm_txtCivico, Form_txtCivico);
  Application.CreateForm(TForm_EditFgAnagrafe, Form_EditFgAnagrafe);
  Application.CreateForm(TForm_TestInfo, Form_TestInfo);
  Application.CreateForm(TForm_editIndirizzoAnagrafe, Form_editIndirizzoAnagrafe);
  Application.CreateForm(TForm_editTesto, Form_editTesto);
  Application.CreateForm(TForm_anagEdificio, Form_anagEdificio);
  Application.CreateForm(TForm_sogConc, Form_sogConc);
  Application.CreateForm(TForm_contrattiConcessioni, Form_contrattiConcessioni);
  Application.CreateForm(TForm_contrattoConcessione, Form_contrattoConcessione);
  Application.CreateForm(TForm_editNomeConcessionario, Form_editNomeConcessionario);
  Application.CreateForm(TForm_editPartConc, Form_editPartConc);
  Application.CreateForm(TForm_Infodist, Form_Infodist);
  Application.CreateForm(TForm_Stampa, Form_Stampa);
  Application.Run;
end.
