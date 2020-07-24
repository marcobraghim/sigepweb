import 'package:flutter_test/flutter_test.dart';
import 'package:sigepweb/sigepweb.dart';
import 'package:sigepweb/src/constants.dart';
import 'package:sigepweb/src/exceptions/sigepweb_runtime_error.dart';
import 'package:sigepweb/src/models/calc_preco_prazo_item_model.dart';
import 'package:sigepweb/src/models/consulta_cep_model.dart';

void main() {
  var sigep = Sigepweb(isDebug: true);

  group('calcPrecoPrazo -', () {
    test('testa tipo de retorno', () async {
      var calcPrecoPrazo = await sigep.calcPrecoPrazo(
        cepOrigem: '70002900',
        cepDestino: '04547000',
        valorPeso: 1,
      );

      expect(
        calcPrecoPrazo.runtimeType,
        List<CalcPrecoPrazoItemModel>().runtimeType,
      );
    });
  });

  group('consultaCEP -', () {
    test('tipo de retorno', () async {
      expect(
        await sigep.consultaCEP('70002900'),
        isInstanceOf<ConsultaCepModel>(),
      );
    });

    test('CEP inexistente', () async {
      expect(
        await sigep.consultaCEP('01000100'),
        isInstanceOf<ConsultaCepModel>(),
      );
    });

    test('CEP com hífem', () async {
      expect(
        await sigep.consultaCEP('70002-900'),
        isInstanceOf<ConsultaCepModel>(),
      );
    });

    test('CEP nada a ver', () {
      expect(
        () async => await sigep.consultaCEP('a5sdf45'),
        throwsA(isInstanceOf<SigepwebRuntimeError>()),
      );
    });
  });

  group('Utils - String para double:', () {
    test("'27,80' para 27.80", () {
      expect(SgUtils.toDouble('27,80'), 27.80);
    });

    test("'1.527,80' para 1527.80", () {
      expect(SgUtils.toDouble('1.527,80'), 1527.80);
    });

    test("'must fail' para 0.0", () {
      expect(SgUtils.toDouble('must fail'), 0.0);
    });
  });

  group('Utils - Formato de encomenda:', () {
    test('Caixa', () {
      expect(SgUtils.codFormato(FormatoEncomenda.caixa), '1');
    });

    test('Rolo', () {
      expect(SgUtils.codFormato(FormatoEncomenda.rolo), '2');
    });

    test('Envelope', () {
      expect(SgUtils.codFormato(FormatoEncomenda.envelope), '3');
    });
  });

  group('Utils - Formata CEP', () {
    test('com hifen', () {
      expect(SgUtils.formataCEP('12345-678'), '12345678');
    });

    test('correto', () {
      expect(SgUtils.formataCEP('12345678'), '12345678');
    });

    test('muito longo', () {
      expect(SgUtils.formataCEP('12345-6789'), '12345678');
    });

    test('nada a ver', () {
      expect(
        () => SgUtils.formataCEP('654as6df4'),
        throwsA(isInstanceOf<SigepwebRuntimeError>()),
      );
    });
  });
}
