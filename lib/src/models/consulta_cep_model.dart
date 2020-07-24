import 'dart:convert';

/// Model to the return of service consultaCEP
class ConsultaCepModel {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String cidade;
  String estado;

  /// Default constructor
  ConsultaCepModel({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
  });

  /// Constructor to json data
  ConsultaCepModel.fromJson(Map<String, dynamic> json)
      : cep = json['cep']['\$t'],
        logradouro = json['end']['\$t'],
        complemento = json['complemento2']['\$t'],
        bairro = json['bairro']['\$t'],
        cidade = json['cidade']['\$t'],
        estado = json['uf']['\$t'];

  /// Translate this model to json
  Map<String, dynamic> toJson() => {
        'cep': cep,
        'logradouro': logradouro,
        'complemento': complemento,
        'bairro': bairro,
        'cidade': cidade,
        'estado': estado,
      };

  /// Prints this model as a valid string
  @override
  String toString() {
    return json.encode(toJson());
  }
}
