import 'dart:convert';

import 'package:sigepweb/sigepweb.dart';
import 'package:sigepweb/src/constants.dart';

/// Model para retorno do servico calcPrecoPrazo
class CalcPrecoPrazoItemModel {
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

  /// Construtor padrao
  CalcPrecoPrazoItemModel({
    this.nome,
    this.codigo,
    this.valor,
    this.prazoEntrega,
    this.valorMaoPropria,
    this.valorAvisoRecebimento,
    this.valorDeclarado,
    this.entregaDomiciliar,
    this.entregaSabado,
    this.codErro,
    this.msgErro,
    this.valorSemAdicionais,
    this.obsFim,
  });

  /// Popula a model a partir do resultado do servico calcPrecoPrazo
  CalcPrecoPrazoItemModel.fromJson(Map<String, dynamic> json)
      : codigo = json['Codigo']?.padLeft(5, '0'),
        valor = SgUtils.toDouble(json['Valor']),
        prazoEntrega = int.tryParse(json['PrazoEntrega']) ?? 0,
        valorMaoPropria = SgUtils.toDouble(json['ValorMaoPropria']),
        valorAvisoRecebimento = SgUtils.toDouble(json['ValorAvisoRecebimento']),
        valorDeclarado = SgUtils.toDouble(json['ValorValorDeclarado']),
        entregaDomiciliar = (json['EntregaDomiciliar'] == 'S'),
        entregaSabado = (json['EntregaSabado'] == 'S'),
        codErro = json['Erro'],
        msgErro = json['MsgErro'],
        valorSemAdicionais = SgUtils.toDouble(json['ValorSemAdicionais']),
        obsFim = json['obsFim'] {
    //
    // with the code we set the name of the service
    nome = ServicosPostagem.nomeServico[codigo] ?? 'Correios';
  }

  /// Traduz esta model para json
  Map<String, dynamic> toJson() => {
        'nome': nome,
        'codigo': codigo,
        'valor': valor,
        'prazoEntrega': prazoEntrega,
        'valorMaoPropria': valorMaoPropria,
        'valorAvisoRecebimento': valorAvisoRecebimento,
        'valorDeclarado': valorDeclarado,
        'entregaDomiciliar': entregaDomiciliar,
        'entregaSabado': entregaSabado,
        'codErro': codErro,
        'msgErro': msgErro,
        'valorSemAdicionais': valorSemAdicionais,
        'obsFim': obsFim,
      };

  /// Imprime esta model como um json valido
  @override
  String toString() {
    return json.encode(toJson());
  }
}
