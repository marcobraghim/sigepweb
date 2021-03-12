import 'dart:convert';

/// Model para retorno do servico consultaCEP
class ConsultaCepModel {
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? cidade;
  String? estado;

  /// Construtor padrao
  ConsultaCepModel({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
  });

  /// Construtor para popular model com resultado do servico consultaCEP
  ConsultaCepModel.fromJson(Map<String, dynamic> json)
      : cep = json['cep']['\$t'],
        logradouro = json['end']['\$t'],
        complemento = json['complemento2']['\$t'],
        bairro = json['bairro']['\$t'],
        cidade = json['cidade']['\$t'],
        estado = json['uf']['\$t'];

  /// Traduz esta model para json
  Map<String, dynamic> toJson() => {
        'cep': cep,
        'logradouro': logradouro,
        'complemento': complemento,
        'bairro': bairro,
        'cidade': cidade,
        'estado': estado,
      };

  /// Imprime esta model como um json valido
  @override
  String toString() {
    return json.encode(toJson());
  }
}
