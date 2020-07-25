/// Provide a contract to the connections
/// from API
class SigepContrato {
  String usuario;
  String senha;
  String codAdmin;
  String numContrato;
  String numCartao;
  String cnpj;

  /// Default constructor.
  /// MUST be used when the client do have a contract
  SigepContrato({
    this.usuario,
    this.senha,
    this.codAdmin,
    this.numContrato,
    this.numCartao,
    this.cnpj,
  });

  /// Constructor to the clients without contract
  SigepContrato.semContrato() {
    usuario = '';
    senha = '';
    codAdmin = '';
    numContrato = '';
    numCartao = '';
    cnpj = '';
  }

  /// Contract to make tests over homolog environment
  SigepContrato.homolog() {
    usuario = 'sigep';
    senha = 'n5f9t8';
    codAdmin = '17000190';
    numContrato = '9992157880';
    numCartao = '0067599079';
    cnpj = '34028316000103';
  }
}
