program TAB_SOFTWARE;

uses
  Vcl.Forms,
  frmLogin in 'Formularios\frmLogin.pas' {LoginFrm},
  frmGeralDM in 'Formularios\frmGeralDM.pas' {GeralDMfrm: TDataModule},
  frmPrincipal in 'Formularios\frmPrincipal.pas' {TelaPrincipalFrm},
  untFuncoes in 'Formularios\Units\Funcoes\untFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'TAB_SOFTWARE';
  Application.CreateForm(TGeralDMfrm, GeralDMfrm);
  Application.CreateForm(TLoginFrm, LoginFrm);
  Application.Run;
end.