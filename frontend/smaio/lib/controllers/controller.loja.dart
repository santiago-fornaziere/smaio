import 'package:smaio/models/model.loja.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'dart:convert' as converte;
import 'package:http/http.dart' as http;

class LojaApi {
  static Future<List<Loja>> getByUsuario(String pID) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/loja/usuario/$pID');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<Loja> tabela =
            lista.map<Loja>((map) => Loja.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<Loja> tabela = [];
      return tabela;
    }
  }
}