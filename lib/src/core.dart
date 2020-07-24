library sigepweb;

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sigepweb/sigepweb.dart';
import 'package:sigepweb/src/exceptions/sigepweb_runtime_error.dart';
import 'package:sigepweb/src/models/calc_preco_prazo_item_model.dart';
import 'package:sigepweb/src/models/consulta_cep_model.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

import 'models/contrato.dart';

/// A classe principal
class Sigepweb {
  /// Endpoint para caso de ambiente de testes
  String _homEndpoint =
      'https://apphom.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl';

  /// Endpoint para caso de ambiente de producao
  String _prodEndpoint =
      'https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl';

  final bool isDebug;
  SigepContrato contrato;
  final dio = Dio();

  /// Constructor
  Sigepweb({
    this.contrato,
    this.isDebug = false,
  }) : assert(contrato != null || isDebug) {
    if (isDebug) {
      contrato = SigepContrato.semContrato();
    }
  }

  /// Result into a list of [CalcPrecoPrazoItem].
  Future<List<CalcPrecoPrazoItemModel>> calcPrecoPrazo({
    List<String> servicosList = const [
      ServicosPostagem.sedexAVista_04014,
      ServicosPostagem.pacAVista_04510,
    ],
    String cepOrigem,
    String cepDestino,
    double valorPeso = .5,
    FormatoEncomenda formatoEncomenda = FormatoEncomenda.caixa,
    int comprimento = 20,
    int altura = 20,
    int largura = 20,
    int diametro = 0,
    bool maosPropria = false,
    double valorDeclarado = 0.0,
    bool avisoRecebimento = false,
  }) async {
    //
    // O Endpoint para calculo de preco e prazo eh o unico diferente
    // (ate agora)
    final String endpoint =
        'http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx';

    List<CalcPrecoPrazoItemModel> result = [];

    try {
      Response<String> resp =
          await dio.get("$endpoint/CalcPrecoPrazo", queryParameters: {
        'nCdEmpresa': contrato.codAdmin,
        'sDsSenha': contrato.senha,
        'nCdServico': servicosList.join(','),
        'sCepOrigem': SgUtils.formataCEP(cepOrigem),
        'sCepDestino': SgUtils.formataCEP(cepDestino),
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
        result.add(CalcPrecoPrazoItemModel.fromJson(i));
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

  /// A partir do [cep] este metodo busca na API
  /// o resultado que sera embutido na model [ConsultaCepModel].
  /// Poderá disparar [SigepwebRuntimeError] caso o CEP seja
  /// inválido.
  Future<ConsultaCepModel> consultaCEP(String cep) async {
    var endpoint = _getEndpoint();

    try {
      // https://medium.com/@markos12/consumindo-o-webservice-dos-correios-soap-via-extensão-do-1b087bf290fb

      var envelope = '''
        <soapenv:Envelope
          xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
          xmlns:cli="http://cliente.bean.master.sigep.bsb.correios.com.br/">
          <soapenv:Header/>
          <soapenv:Body>
            <cli:consultaCEP>
              <cep>${SgUtils.formataCEP(cep)}</cep>
            </cli:consultaCEP>
          </soapenv:Body>
        </soapenv:Envelope>
      ''';

      var response = await http.post(
        endpoint,
        headers: {'Content-Type': 'text/xml; encoding=iso-8859-1'},
        body: envelope,
      );

      if (response.statusCode != 200 || response.body.isEmpty) {
        throw SigepwebRuntimeError();
      }

      // Captura o resultado e faz o parse
      // de XML para JSON
      var xml2json = Xml2Json();
      xml2json.parse(response.body);
      Map<String, dynamic> apiResult = json.decode(xml2json.toGData());

      var soapBodyEnvelope =
          apiResult['soap\$Envelope']['soap\$Body']['ns2\$consultaCEPResponse'];

      if (soapBodyEnvelope['return'] == null) {
        return ConsultaCepModel();
      }

      return ConsultaCepModel.fromJson(soapBodyEnvelope['return']);
      //
      //
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
  }

  /// Determina a URL da API a partir do ambiente de execussao atual
  /// usando [isDebug]
  String _getEndpoint() {
    return isDebug ? _homEndpoint : _prodEndpoint;
  }
}
