/// Determina um contrato para ser usado nos servicos
class SigepContrato {
  String? usuario;
  String? senha;
  String? codAdmin;
  String? numContrato;
  String? numCartao;
  String? cnpj;

  /// Construtor padrão.
  /// DEVE ser usado quando o cliente de fato tem um contrato
  SigepContrato({
    this.usuario,
    this.senha,
    this.codAdmin,
    this.numContrato,
    this.numCartao,
    this.cnpj,
  });

  /// Usado para clientes que nao tem contrato
  SigepContrato.semContrato() {
    usuario = '';
    senha = '';
    codAdmin = '';
    numContrato = '';
    numCartao = '';
    cnpj = '';
  }

  /// Usado para testes em ambiente de homologacao
  SigepContrato.homolog() {
    usuario = 'sigep';
    senha = 'n5f9t8';
    codAdmin = '08082650';
    numContrato = '9992157880';
    numCartao = '0067599079';
    cnpj = '34028316000103';
  }
}
