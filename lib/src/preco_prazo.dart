import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:xml2json/xml2json.dart';

import 'contrato.dart';

class SigepwebPrecoPrazo {
  final _endpoint = 'http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx';

  final dio = Dio();

  final bool isDebug;
  final SigepContrato contrato;

  SigepwebPrecoPrazo(
    this.contrato, {
    this.isDebug = false,
  });

  calcPrecoPrazo() async {
    //
    Response<String> resp =
        await dio.get("$_endpoint/CalcPrecoPrazo", queryParameters: {
      'nCdEmpresa': '08082650',
      'sDsSenha': '564321',
      'nCdServico': '04510,04014',
      'sCepOrigem': '70002900',
      'sCepDestino': '04547000',
      'nVlPeso': '1',
      'nCdFormato': '1',
      'nVlComprimento': '20',
      'nVlAltura': '20',
      'nVlLargura': '20',
      'nVlDiametro': '0',
      'sCdMaoPropria': 'N',
      'nVlValorDeclarado': '0',
      'sCdAvisoRecebimento': 'N',
      'StrRetorno': 'xml',
      'nIndicaCalculo': '3'
    });

    Map result;

    print(resp.data);

    if (resp.statusCode == 200 && resp.data.isNotEmpty) {
      var xml2json = Xml2Json();
      xml2json.parse(resp.data);

      result = json.decode(xml2json.toGData());
    } else {
      print(resp.data);
    }
    return result;
  }

  calcPreco() {}

  calcPrazo() {}
}
