import 'package:sigepweb/src/constants.dart';
import 'package:sigepweb/src/exceptions/sigepweb_runtime_error.dart';

/// A branch of methods useful for small
/// tasks. All these methods are grouped
/// into a class and are static so we can
/// create tests over every one.
class SgUtils {
  ///
  /// Correios will be retrieving monetary values
  /// with brazilian currency format, BRL, but without
  /// preffix 'R$'. This method will format it
  /// to be like a double value.
  static double toDouble(String strVal) {
    String formatted = strVal.trim().replaceAll('.', '').replaceAll(',', '.');
    return double.tryParse(formatted) ?? 0.0;
  }

  /// Format cep number to be only numbers with 8 positions only.
  static String formataCEP(String cep) {
    cep = cep.replaceAll(RegExp(r'[^0-9]'), '');

    if (cep.length < 8) {
      throw SigepwebRuntimeError(
          'CEP code number is wrong. It must be always 8 numbers');
    }
    return cep.substring(0, 8);
  }

  /// With this we can avoid magic number, because Correios
  /// will be expecting 1, 2 and 3.
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
