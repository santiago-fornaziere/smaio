import 'package:smaio/models/model.usuario.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as converte;

class UsuarioApi {
  static Future<List<Usuario>> getByAberto() async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', 'smaio/usuario/empresa');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<Usuario> tabela =
            lista.map<Usuario>((map) => Usuario.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<Usuario> tabela = [];
      return tabela;
    }
  }
}
