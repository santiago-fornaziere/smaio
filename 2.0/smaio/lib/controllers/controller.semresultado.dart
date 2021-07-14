import 'package:flutter/cupertino.dart';
import 'package:smaio/forms/consumidor/form.consumidor.fabricante.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/models/model.semresultado.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:http/http.dart' as http;
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';

class SemResultadoApi {
  static Future<int> post(SemResultado pRegistro) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/semresultado');
      var response = await http.post(url, headers: headers, body: c);

      return response.statusCode;
    } catch (e) {
      print(e);
      return 401;
    }
  }
}

onEnviarSemResultado(BuildContext context, Peca peca, VeiAno veiano,
    String email, String fone) async {
  SemResultado sres = SemResultado(
    sresLido: false,
    sresAnoId: veiano.vanoAnoId,
    sresModId: veiano.vanoModId,
    sresPecId: peca.pecId,
    sresEmail: email,
    sresTelefone: fone,
  );
  int retorno = await SemResultadoApi.post(sres);
  if (retorno == 201) {
    showSnackMessage(context,
        'Sua solicitação foi enviada  para todos os nossos fornecedores com sucesso.');
  }
  push(context, ConsumidorFabricante());
}
