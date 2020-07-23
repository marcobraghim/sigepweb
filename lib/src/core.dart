library sigepweb;

import 'models/contrato.dart';

class Sigepweb {
  // String _homEndpoint =
  //     'https://apphom.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl';

  // String _prodEndpoint =
  //     'https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl';

  final bool isDebug;
  final SigepContrato contrato;

  Sigepweb(
    this.contrato, {
    this.isDebug = false,
  });

  buscaCliente() {}

  buscaServicos() {}

  consultaCEP({String cep}) {
    // var endpoint = _getEndpoint();
  }

  verificaDisponibilidadeServico() {}

  // String _getEndpoint() {
  //   return isDebug ? _homEndpoint : _prodEndpoint;
  // }
}
