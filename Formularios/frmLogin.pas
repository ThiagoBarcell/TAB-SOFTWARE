unit frmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinsDefaultPainters,
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, dxGDIPlusClasses, dxBarBuiltInMenu,
  cxControls, cxPC, frmGeralDM, frmPrincipal, untFuncoes;

type
  TLoginFrm = class(TForm)
    pnlPrincipal: TPanel;
    btnFechar: TcxButton;
    Image1: TImage;
    pagLogin: TcxPageControl;
    tabLogin: TcxTabSheet;
    btnAcessar: TcxButton;
    edtSenha: TEdit;
    edtUsuario: TEdit;
    Label2: TLabel;
    tabCadastro: TcxTabSheet;
    Label1: TLabel;
    edtCadUsuario: TEdit;
    edtCadSenha: TEdit;
    btnSalvar: TcxButton;
    btnMudaLogin: TcxButton;
    btnMudaCadastro: TcxButton;
    procedure btnFecharClick(Sender: TObject);
    procedure btnMudaCadastroClick(Sender: TObject);
    procedure btnMudaLoginClick(Sender: TObject);
    procedure btnAcessarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginFrm: TLoginFrm;

implementation

{$R *.dfm}

procedure TLoginFrm.btnAcessarClick(Sender: TObject);
var
 bLogin : Boolean;
begin

  if ( edtSenha.Text <> '' ) and ( edtUsuario.Text <> '' ) then
  begin
    bLogin := GeralDMfrm.funcoes.ValidaLogin( edtUsuario.Text, edtSenha.Text );
      if bLogin then
        Close
      else
        MessageBox( Handle, pwidechar( 'N�o foi encontrado o login! Por favor fa�a seu cadastro. ' ), 'Aten��o', MB_OK + MB_ICONWARNING );
  end
  else
  MessageBox( Handle, pwidechar( 'Por favor, preencha todos os campos acima! ' ), 'Aten��o', MB_OK + MB_ICONWARNING );
end;

procedure TLoginFrm.btnFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TLoginFrm.btnMudaCadastroClick(Sender: TObject);
begin
  pagLogin.ActivePageIndex := 1;
end;

procedure TLoginFrm.btnMudaLoginClick(Sender: TObject);
begin
  pagLogin.ActivePageIndex := 0;
end;

procedure TLoginFrm.btnSalvarClick(Sender: TObject);
begin
  if ( edtCadUsuario.Text <> '' ) and ( edtCadSenha.Text <> '' )then
  begin
    GeralDMfrm.qryUsuarioLogin.Insert;
    GeralDMfrm.qryUsuarioLoginUSU_NOME.AsString := edtCadUsuario.Text;
    GeralDMfrm.qryUsuarioLoginUSU_SENHA.AsString := edtCadSenha.Text;
    GeralDMfrm.qryUsuarioLogin.Post;
    edtCadUsuario.Clear;
    edtCadSenha.Clear;
  end
  else
  MessageBox( Handle, pwidechar( 'Por favor preencha todos os campos antes de salvar!' ), 'Aten��o', MB_OK + MB_ICONWARNING );

end;

procedure TLoginFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TelaPrincipalFrm := TTelaPrincipalFrm.Create(self);
  TelaPrincipalFrm.ShowModal;
end;

procedure TLoginFrm.FormCreate(Sender: TObject);
begin
  GeralDMfrm.qryUsuarioLogin.Open;
  GeralDMfrm.funcoes.setConection( GeralDMfrm.DB_CONEXAO );

  //Tras a tela de login como padrao
  pagLogin.ActivePageIndex := 0;

  //Arredonda os edits
  GeralDMfrm.funcoes.arredondaedt( edtUsuario );
  GeralDMfrm.funcoes.arredondaedt( edtSenha );
  GeralDMfrm.funcoes.arredondaedt( edtCadUsuario );
  GeralDMfrm.funcoes.arredondaedt( edtCadSenha );
end;

end.