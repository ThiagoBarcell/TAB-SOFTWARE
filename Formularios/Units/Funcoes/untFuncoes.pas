unit untFuncoes;

interface

uses
  System.Classes, System.SysUtils, FireDAC.Comp.Client, System.IniFiles,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, Vcl.Controls, System.Types,
  Winapi.Windows, Winapi.Messages;


  Type
  TFuncoesGerais = Class
  private
  oConexao : TFDConnection;

  public
  // GETs
  Function getConexao : TFDConnection;

  // SETs
  procedure setConection( fValor : TFDConnection );


  //Fun��es criadas na Unit
  function ProcCriaQry : TFDQuery;
  function ValidaLogin( sUsuario, sSenha : String ) : Boolean;

  //Procedures criadas na Unit
  procedure ConfiguraConexao( oConexao : TFDConnection; oDriverFB : TFDPhysFBDriverLink ;aArquivoIni : tinifile );
  procedure ArredondaEdt(Control: TWinControl);

  End;

implementation

{ TFuncoesGerais }

procedure TFuncoesGerais.setConection(fValor: TFDConnection);
begin
  oConexao := fValor;
end;

function TFuncoesGerais.ValidaLogin( sUsuario, sSenha : String ) : Boolean;
var
  oQryValida : TFDQuery;
begin
  try
    oQryValida := ProcCriaQry;
    oQryValida.Close;
    oQryValida.SQL.Clear;
    oQryValida.open( ' SELECT USU_NOME, USU_SENHA FROM INFO_USUARIOS WHERE USU_NOME = ' + #39 + sUsuario + #39 + ' AND ' + 'USU_SENHA = ' + #39 + sSenha + #39 );
    if oQryValida.IsEmpty then
      result := false
    else
      result := true
  finally
    FreeAndNil( oQryValida );
  end;
end;

{ TFuncoesGerais }

procedure TFuncoesGerais.ConfiguraConexao( oConexao : TFDConnection; oDriverFB : TFDPhysFBDriverLink ;aArquivoIni : tinifile );
begin
  //Configura os caminhos da BPL e do Banco do Cliente.
  oConexao.Params.Database := aArquivoIni.ReadString( 'EMPRESA', 'CAMINHO_BANCO', '' );
  oDriverFB.VendorLib      := aArquivoIni.ReadString( 'EMPRESA', 'CAMINHO_BPL', '' );
end;

function TFuncoesGerais.getConexao: TFDConnection;
begin
  Result := oConexao;
end;

procedure TFuncoesGerais.ArredondaEdt(Control: TWinControl);
var
   R: TRect;
   Rgn: HRGN;
begin
  with Control do  begin
    R := ClientRect;
    rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 10, 10);
    Perform(EM_GETRECT, 0, lParam(@r)) ;
    InflateRect(r, - 4, - 4) ;
    Perform(EM_SETRECTNP, 0, lParam(@r)) ;
    SetWindowRgn(Handle, rgn, True) ;
    Invalidate;
  end;
end;

function TFuncoesGerais.ProcCriaQry: TFDQuery;
var oQuery : TFDQuery;
begin
  oQuery := TFDQuery.Create( Nil );
  oQuery.Connection := oConexao;
  Result := oQuery;
end;

end.
