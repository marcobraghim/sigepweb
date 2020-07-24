import 'package:sigepweb/sigepweb.dart';

main() async {
  var sigep = Sigepweb(contrato: SigepContrato.semContrato());

  var endereco = await sigep.consultaCEP('70002900');

  print(endereco);
}
