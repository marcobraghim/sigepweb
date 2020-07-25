import 'package:sigepweb/src/constants.dart';
import 'package:sigepweb/src/exceptions/sigepweb_runtime_error.dart';

/// Diversos metodos que vao realizar pequenas tarefas. Todos estes metodos
/// poderiam ser apenas simples funcoes, mas neste caso elas precisariam
/// ser privadas para nao gerar conflitos nos projetos que vao usar este package
/// e até aqui parece muito bom usar apenas funcoes privadas, mas isso gera um
/// problema: Funcoes privadas nao podem ser testadas, por isso agrupamos
/// estas funcoes nesta classe.
class SgUtils {
  ///
  /// Os correios retornam valores monetarios em formato de moeda brasileira
  /// BRL, mas sem o prefixo R$. Este metodo vai formatar esses valores para
  /// poderem ser transformados em double
  static double toDouble(String strVal) {
    String formatted = strVal.trim().replaceAll('.', '').replaceAll(',', '.');
    return double.tryParse(formatted) ?? 0.0;
  }

  /// Formata um dado [cep] para apenas numeros com apenas 8 posicoes.
  ///
  /// Se o [cep], depois de formatado, nao alcançar 8 posicoes então lançará
  /// [SigepwebRuntimeError]
  static String formataCEP(String cep) {
    cep = cep.replaceAll(RegExp(r'[^0-9]'), '');

    if (cep.length < 8) {
      throw SigepwebRuntimeError(
          'Código do CEP inválido, deve numérico com 8 posições');
    }
    return cep.substring(0, 8);
  }

  /// Este metodo evita numeros magicos, pois os Correios esperam para formatos
  /// de encomendas de caixa, rolo e envelope os valores respectivamente 1, 2 e
  /// 3
  static String codFormato(FormatoEncomenda formato) {
    String result;
    if (formato == FormatoEncomenda.caixa) {
      result = '1';
    } else if (formato == FormatoEncomenda.rolo) {
      result = '2';
    } else if (formato == FormatoEncomenda.envelope) {
      result = '3';
    }
    return result;
  }
}
