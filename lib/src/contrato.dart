class SigepContrato {
  String usuario;
  String senha;
  String codAdmin;
  String numContrato;
  String numCartao;
  String cnpj;

  SigepContrato({
    this.usuario,
    this.senha,
    this.codAdmin,
    this.numContrato,
    this.numCartao,
    this.cnpj,
  });

  SigepContrato.semContrato() {
    usuario = '';
    senha = '564321';
    codAdmin = '08082650';
    numContrato = '';
    numCartao = '';
    cnpj = '';
  }

  SigepContrato.homolog() {
    usuario = 'sigep';
    senha = 'n5f9t8';
    codAdmin = '17000190';
    numContrato = '9992157880';
    numCartao = '0067599079';
    cnpj = '34028316000103';
  }
}
