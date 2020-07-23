import 'package:sigepweb/sigepweb.dart';
import 'package:sigepweb/src/constants.dart';

class CalcPrecoPrazoItem {
  String nome;
  String codigo;
  double valor;
  int prazoEntrega;
  double valorMaoPropria;
  double valorAvisoRecebimento;
  double valorDeclarado;
  bool entregaDomiciliar;
  bool entregaSabado;
  String codErro;
  Map msgErro;
  double valorSemAdicionais;
  Map obsFim;

  CalcPrecoPrazoItem.fromJson(Map<String, dynamic> json)
      : codigo = json['Codigo']['\$t']?.padLeft(5, '0'),
        valor = SgUtils.toDouble(json['Valor']['\$t']),
        prazoEntrega = int.tryParse(json['PrazoEntrega']['\$t']) ?? 0,
        valorMaoPropria = SgUtils.toDouble(json['ValorMaoPropria']['\$t']),
        valorAvisoRecebimento =
            SgUtils.toDouble(json['ValorAvisoRecebimento']['\$t']),
        valorDeclarado = SgUtils.toDouble(json['ValorValorDeclarado']['\$t']),
        entregaDomiciliar = (json['EntregaDomiciliar']['\$t'] == 'S'),
        entregaSabado = (json['EntregaSabado']['\$t'] == 'S'),
        codErro = json['Erro']['\$t'],
        msgErro = json['MsgErro']['\$t'],
        valorSemAdicionais =
            SgUtils.toDouble(json['ValorSemAdicionais']['\$t']),
        obsFim = json['obsFim']['\$t'] {
    //
    // with the code we set the name of the service
    nome = ServicosPostagem.nomeServico[codigo] ?? 'Correios';
  }
}
