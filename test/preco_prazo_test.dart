import 'package:flutter_test/flutter_test.dart';
import 'package:sigepweb/sigepweb.dart';
import 'package:sigepweb/src/models/calc_preco_prazo_item.dart';

void main() {
  group('Precos e prazos -', () {
    var sigep = SigepwebPrecoPrazo(isDebug: true);

    test('testa tipo de retorno', () async {
      var calcPrecoPrazo = await sigep.calcPrecoPrazo(
        cepOrigem: '70002900',
        cepDestino: '04547000',
        valorPeso: 1,
      );

      expect(
          calcPrecoPrazo.runtimeType, List<CalcPrecoPrazoItem>().runtimeType);
    });
  });
}
