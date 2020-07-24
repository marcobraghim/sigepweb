/// Formats for order type
enum FormatoEncomenda { caixa, rolo, envelope }

/// Bellow we have the values of services provided
/// by Correios to customers who don't have a contract
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
    // @todo buscar contrato do cliente para injetar os servicos dele
  };
}
