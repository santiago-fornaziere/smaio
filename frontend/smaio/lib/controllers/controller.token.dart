import 'package:smaio/models/model.usuario.dart';
import 'package:smaio/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:smaio/prefs.dart';
import 'dart:convert';

class TokenApi {
  static Future<String> post(String login, String senha) async {
    var params = jsonEncode({'email': "$login", 'senha': "$senha"});

    try {
      var url = Uri.http('$hostapi:9199', '/smaio/token');
      var response = await http.post(
        url,
        body: params,
      );
      if (response.statusCode == 200) {
        String token = response.body;
        await Prefs.setString('token', token);
        return token;
      } else {
        return '';
      }
    } catch (e) {
      print("erro de comunicação: $e");
      return '';
    }
  }

  static Future<Usuario> getClaims(String pToken) async {
    String token = pToken;

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/claim');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var retorno = json.decode(response.body);
        Usuario usuario = Usuario.fromJson(retorno);
        await Prefs.setString('usu_email', usuario.usuEmail.toString());
        return usuario;
      } else {
        return Usuario();
      }
    } catch (e) {
      print(e);
      return Usuario();
    }
  }
}
