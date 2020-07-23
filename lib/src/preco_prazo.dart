import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sigepweb/sigepweb.dart';
import 'package:sigepweb/src/constants.dart';
import 'package:sigepweb/src/exceptions/sigepweb_runtime_error.dart';
import 'package:sigepweb/src/models/calc_preco_prazo_item.dart';
import 'package:xml2json/xml2json.dart';

import 'models/contrato.dart';

class SigepwebPrecoPrazo {
  final _endpoint = 'http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx';

  final dio = Dio();

  final bool isDebug;
  SigepContrato contrato;

  /// If a [contrato] is null so [isDebug] must be true
  ///
  SigepwebPrecoPrazo({
    this.contrato,
    this.isDebug = false,
  }) : assert(contrato != null || isDebug) {
    if (isDebug) {
      contrato = SigepContrato.semContrato();
    }
  }

  ///
  /// Result into a list of [CalcPrecoPrazoItem].
  ///
  Future<List<CalcPrecoPrazoItem>> calcPrecoPrazo({
    List<String> servicosList = const [sedexAVista_04014, pacAVista_04510],
    String cepOrigem,
    String cepDestino,
    double valorPeso,
    FormatoEncomenda formatoEncomenda = FormatoEncomenda.caixa,
    int comprimento = 20,
    int altura = 20,
    int largura = 20,
    int diametro = 0,
    bool maosPropria = false,
    double valorDeclarado = 0.0,
    bool avisoRecebimento = false,
  }) async {
    List<CalcPrecoPrazoItem> result = [];

    try {
      Response<String> resp =
          await dio.get("$_endpoint/CalcPrecoPrazo", queryParameters: {
        'nCdEmpresa': contrato.codAdmin,
        'sDsSenha': contrato.senha,
        'nCdServico': servicosList.join(','),
        'sCepOrigem': cepOrigem,
        'sCepDestino': cepDestino,
        'nVlPeso': valorPeso.toString(),
        'nCdFormato': SgUtils.codFormato(formatoEncomenda),
        'nVlComprimento': comprimento.toString(),
        'nVlAltura': altura.toString(),
        'nVlLargura': largura.toString(),
        'nVlDiametro': diametro.toString(),
        'sCdMaoPropria': maosPropria ? 'S' : 'N',
        'nVlValorDeclarado': valorDeclarado.toString(),
        'sCdAvisoRecebimento': avisoRecebimento ? 'S' : 'N',
        'StrRetorno': 'xml',
        'nIndicaCalculo': '3'
      });

      if (resp.statusCode != 200 || resp.data.isEmpty) {
        throw SigepwebRuntimeError();
      }

      // Captura o resultado e faz o parse
      // de XML para JSON
      var xml2json = Xml2Json();
      xml2json.parse(resp.data);
      Map<String, dynamic> apiResult = json.decode(xml2json.toGData());

      if (apiResult['cResultado'] == null ||
          apiResult['cResultado']['Servicos'] == null ||
          apiResult['cResultado']['Servicos']['cServico'] == null) {
        throw SigepwebRuntimeError(
            'Xml result format isn\'t with expected format');
      }

      List servicos = apiResult['cResultado']['Servicos']['cServico'];
      for (Map<String, dynamic> i in servicos) {
        result.add(CalcPrecoPrazoItem.fromJson(i));
      }
    } on Exception catch (e, st) {
      //
      // Se entrar nesta exception entao o problema nao foi
      // necessariamente no package, mas nas suas dependencias
      // como o Dio (talvez conexao de fato), Xml2Json, etc...
      //
      if (isDebug) {
        print(e);
        print(st);
      }

      throw SigepwebRuntimeError(
          'Internal error Sigepweb package. Please consider open an issue into https://github.com/marcobraghim/sigepweb/issues\nOriginal exception was: ${e.toString()}');
    }
    return result;
  }
}
