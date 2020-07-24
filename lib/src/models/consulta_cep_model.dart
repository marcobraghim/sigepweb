import 'dart:convert';

class ConsultaCepModel {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String cidade;
  String estado;

  ConsultaCepModel({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
  });

  ConsultaCepModel.fromJson(Map<String, dynamic> json)
      : cep = json['cep']['\$t'],
        logradouro = json['end']['\$t'],
        complemento = json['complemento2']['\$t'],
        bairro = json['bairro']['\$t'],
        cidade = json['cidade']['\$t'],
        estado = json['uf']['\$t'];

  Map<String, dynamic> toJson() => {
        'cep': cep,
        'logradouro': logradouro,
        'complemento': complemento,
        'bairro': bairro,
        'cidade': cidade,
        'estado': estado,
      };

  @override
  String toString() {
    return json.encode(toJson());
  }
}
