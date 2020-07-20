import 'package:flutter_test/flutter_test.dart';
import 'package:sigepweb/sigepweb.dart';

void main() {
  test('Testa consulta de precos e prazos', () async {
    var contrato = SigepContrato.semContrato();
    var sigep = SigepwebPrecoPrazo(contrato);

    // Testa o tipo de retorno
    expect(
      (await sigep.calcPrecoPrazo()).runtimeType,
      Map<String, dynamic>().runtimeType,
    );
  });
}
