import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

// calcPriceTerm(
//   nCdServico: "04014",
//   sCepOrigem: "69097374",
//   sCepDestino: "13480010",
//   nVlPeso: "1",
//   nCdFormato: "1",
//   nVlComprimento: "20",
//   nVlAltura: "10",
//   nVlLargura: "20",
//   nVlDiametro: "0",
//   sCdMaoPropria: "N",
//   nVlValorDeclarado: "0",
//   sCdAvisoRecebimento: "N",
// ).then((Result result) {
//   print("Valor do frete: ${result.valor}");
//   print("Prazo de Entrega: ${result.prazo}");
//   print("Valor da Mão Própria: ${result.vmp}");
//   print("Valor do Aviso de Recebimento: ${result.valor}");
//   print("Valor do Valor Declarado: ${result.vvd}");
//   print("Possui Entrega Domiciliar (S - Sim , N - Não): ${result.entrDom}");
//   print("Possui Entrega ao Sábados (S - Sim , N - Não): ${result.entrSa}");
//   print("Valor sem Adicionais: ${result.vsa}");
// });

Future<Result> calcPriceTerm({
  String nCdEmpresa,
  String sDsSenha,
  String nCdServico,
  String sCepOrigem,
  String sCepDestino,
  String nVlPeso,
  String nCdFormato,
  String nVlComprimento,
  String nVlAltura,
  String nVlLargura,
  String nVlDiametro,
  String sCdMaoPropria,
  String nVlValorDeclarado,
  String sCdAvisoRecebimento,
  String strRetorno,
  String nIndicaCalculo,
}) async {
  Xml2Json xml2json = new Xml2Json();

  if (nCdEmpresa == null) {
    nCdEmpresa = "08082650";
  }

  if (sDsSenha == null) {
    sDsSenha = "564321";
  }

  if (strRetorno == null) {
    strRetorno = "xml";
  }

  if (nIndicaCalculo == null) {
    nIndicaCalculo = "3";
  }

  if (nVlPeso == null) {
    nVlPeso = "0";
  }

  if (nVlComprimento == null) {
    nVlComprimento = "0";
  }

  if (nVlAltura == null) {
    nVlAltura = "0";
  }

  if (nVlLargura == null) {
    nVlLargura = "0";
  }

  if (nVlDiametro == null) {
    nVlDiametro = "0";
  }

  if (nVlValorDeclarado == null) {
    nVlValorDeclarado = "0";
  }

  Result result = null;

  try {
    String endpoint = "http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx/CalcPrecoPrazo?";
    endpoint += "nCdEmpresa=$nCdEmpresa&";
    endpoint += "sDsSenha=$sDsSenha&";
    endpoint += "nCdServico=$nCdServico&";
    endpoint += "sCepOrigem=$sCepOrigem&";
    endpoint += "sCepDestino=$sCepDestino&";
    endpoint += "nVlPeso=$nVlPeso&";
    endpoint += "nCdFormato=$nCdFormato&";
    endpoint += "nVlComprimento=$nVlComprimento&";
    endpoint += "nVlAltura=$nVlAltura&";
    endpoint += "nVlLargura=$nVlLargura&";
    endpoint += "nVlDiametro=$nVlDiametro&";
    endpoint += "sCdMaoPropria=$sCdMaoPropria&";
    endpoint += "nVlValorDeclarado=$nVlValorDeclarado&";
    endpoint += "sCdAvisoRecebimento=$sCdAvisoRecebimento&";
    endpoint += "StrRetorno=$strRetorno&";
    endpoint += "nIndicaCalculo=$nIndicaCalculo";

    http.Response reponse = await http.get(endpoint);

    if (reponse.statusCode == 200) {
      xml2json.parse(reponse.body);

      var resultadomap = xml2json.toGData();

      result = Result.fromJson(json.decode(resultadomap)["cResultado"]["Servicos"]["cServico"]);
    } else if (reponse.statusCode == 500) {
      print(reponse.body);
    }
  } catch (e) {
    print(e);
  }

  return result;
}

CalcTerm({
  String nCdServico,
  String sCepOrigem,
  String sCepDestino,
  String strRetorno,
  String nIndicaCalculo,
}) async {
  Xml2Json xml2json = new Xml2Json();

  if (strRetorno == null) {
    strRetorno = "xml";
  }

  if (nIndicaCalculo == null) {
    nIndicaCalculo = "3";
  }

  try {
    http.Response reponse =
        await http.get("http://ws.correios.com.br/calculador/CalcPrazo.asmx/CalcPrazo?&nCdServico=$nCdServico&sCepOrigem=$sCepOrigem&sCepDestino=$sCepDestino");

    if (reponse.statusCode == 200) {
      xml2json.parse(reponse.body);

      var resultadomap = xml2json.toGData();

      return Result.fromJson(json.decode(resultadomap)["cResultado"]["Servicos"]["cServico"]);
    }
  } catch (e) {
    print(e);
  }
}

class Result {
  Result(
    this.codigo,
    this.valor,
    this.prazo,
    this.vsa,
    this.vvd,
    this.vmp,
    this.entrDom,
    this.entrSa,
    this.error,
    this.msgErro,
    this.vRec,
  );

  Result.fromJson(Map<String, dynamic> json)
      : codigo = json["Codigo"]["\$t"],
        valor = json["Valor"]["\$t"],
        prazo = json["PrazoEntrega"]["\$t"],
        vsa = json["ValorSemAdicionais"]["\$t"],
        vRec = json["ValorAvisoRecebimento"]["\$t"],
        vmp = json["ValorMaoPropria"]["\$t"],
        vvd = json["ValorValorDeclarado"]["\$t"],
        entrDom = json["EntregaDomiciliar"]["\$t"],
        entrSa = json["EntregaSabado"]["\$t"],
        error = json["Erro"]["\$t"],
        msgErro = json["MsgErro"]["\$t"];

  Map<String, dynamic> toJson() => {
        'Codigo': codigo,
        'Valor': valor,
        'PrazoEntrega': prazo,
        'ValorSemAdicionais': vsa,
        'ValorMaoPropria': vmp,
        'ValorValorDeclarado': vvd,
        'EntregaDomiciliar': entrDom,
        'EntregaSabado': entrSa,
        'Erro': error,
        'MsgErro': msgErro,
        'ValorAvisoRecebimento': vRec
      };

  final String codigo;

  final String valor;

  final String prazo;

  final String vsa;

  final String vmp;

  final String vvd;

  final String entrDom;

  final String entrSa;

  final String error;

  final String msgErro;

  final String vRec;
}
