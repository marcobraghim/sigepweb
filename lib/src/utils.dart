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

  /// With this we can avoid magic number, because Correios
  /// will be expecting 1, 2 and 3.
  static String codFormato(FormatoEncomenda formato) {
    String result;
    switch (formato) {
      case FormatoEncomenda.caixa:
        result = '1';
        break;
      case FormatoEncomenda.rolo:
        result = '2';
        break;
      case FormatoEncomenda.envelope:
        result = '3';
        break;
      default:
        throw SigepwebRuntimeError('Formato da encomenda unknown');
    }
    return result;
  }
}
