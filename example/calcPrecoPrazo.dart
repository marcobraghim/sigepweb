import 'package:sigepweb/sigepweb.dart';

void main() async {
  var sigep = Sigepweb(contrato: SigepContrato.semContrato(), isDebug: true);

  var calcPrecoPrazo = await sigep.calcPrecoPrazo(
    cepOrigem: '70002900',
    cepDestino: '04547000',
    valorPeso: 1,
  );

  for (var item in calcPrecoPrazo) {
    print('${item.nome}: R\$ ${item.valor}');
  }
}
