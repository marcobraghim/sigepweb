import 'package:flutter_test/flutter_test.dart';
import 'package:sigepweb/sigepweb.dart';
import 'package:sigepweb/src/constants.dart';
import 'package:sigepweb/src/exceptions/sigepweb_runtime_error.dart';
import 'package:sigepweb/src/models/calc_preco_prazo_item_model.dart';
import 'package:sigepweb/src/models/consulta_cep_model.dart';

void main() {
  test('Instância sem contrato', () {
    expect(
      () => Sigepweb(),
      throwsA(isA<SigepwebRuntimeError>()),
    );
  });

  var sigepHomolog = Sigepweb(isDebug: true);
  var sigepSemContrato = Sigepweb(contrato: SigepContrato.semContrato());

  group('calcPrecoPrazo -', () {
    test('retorno OK', () async {
      var calcPrecoPrazo = await sigepSemContrato.calcPrecoPrazo(
        cepOrigem: '70002900',
        cepDestino: '04547000',
        valorPeso: 1,
      );

      expect(calcPrecoPrazo, isA<List<CalcPrecoPrazoItemModel>>());
    });

    test('retorno OK para 1 servico apenas', () async {
      var calcPrecoPrazo = await sigepSemContrato.calcPrecoPrazo(
          cepOrigem: '70002900',
          cepDestino: '04547000',
          valorPeso: 1,
          servicosList: [ServicosPostagem.sedexAVista_04014]);

      expect(calcPrecoPrazo, isA<List<CalcPrecoPrazoItemModel>>());
    });

    test('Exception esperada para homolog', () {
      expect(
        () async => await sigepHomolog.calcPrecoPrazo(
          cepOrigem: '70002900',
          cepDestino: '04547000',
          valorPeso: 1,
        ),
        throwsA(isA<SigepwebRuntimeError>()),
      );
    });

    test('lista de servicos vazia', () {
      expect(
        () async => await sigepHomolog.calcPrecoPrazo(
          cepOrigem: '70002900',
          cepDestino: '04547000',
          valorPeso: 1,
          servicosList: [],
        ),
        throwsA(isA<SigepwebRuntimeError>()),
      );
    });
  });

  group('consultaCEP -', () {
    test('tipo de retorno', () async {
      expect(
        await sigepHomolog.consultaCEP('70002900'),
        isA<ConsultaCepModel>(),
      );
    });

    test('CEP inexistente', () async {
      expect(
        await sigepHomolog.consultaCEP('01000100'),
        isA<ConsultaCepModel>(),
      );
    });

    test('CEP com hífem', () async {
      expect(
        await sigepHomolog.consultaCEP('70002-900'),
        isA<ConsultaCepModel>(),
      );
    });

    test('CEP nada a ver', () {
      expect(
        () async => await sigepHomolog.consultaCEP('a5sdf45'),
        throwsA(isA<SigepwebRuntimeError>()),
      );
    });
  });

  group('SgUtils - String para double:', () {
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

  group('SgUtils - Formato de encomenda:', () {
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

  group('SgUtils - Formata CEP', () {
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
        throwsA(isA<SigepwebRuntimeError>()),
      );
    });
  });
}
