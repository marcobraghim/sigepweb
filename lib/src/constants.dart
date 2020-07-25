/// Formatos de encomenda aceitos pelos Correios. Para transformar isso
/// em seus respectivos numeros utilize o metodo estatico [SgUtils.codFormato]
enum FormatoEncomenda { caixa, rolo, envelope }

/// Abaixo temos a lista de servicos providos pelos Correios
/// para clientes que nao tem contrato.
///
/// @todo buscar contrato do cliente para injetar os servicos dele
class ServicosPostagem {
  static const sedexAVista_04014 = '04014';
  static const pacAVista_04510 = '04510';
  static const sedex12AVista_04782 = '04782';
  static const sedex10AVista_04790 = '04790';
  static const sedexHojeAVista_04804 = '04804';

  static var nomeServico = {
    ServicosPostagem.sedexAVista_04014: 'Sedex',
    ServicosPostagem.pacAVista_04510: 'PAC',
    ServicosPostagem.sedex12AVista_04782: 'Sedex 12',
    ServicosPostagem.sedex10AVista_04790: 'Sedex 10',
    ServicosPostagem.sedexHojeAVista_04804: 'Sedex Hoje',
  };
}
