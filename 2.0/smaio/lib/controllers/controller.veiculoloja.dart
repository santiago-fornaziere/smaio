import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as converte;

class VeiculoLojaApi {
  static Future<List<VeiculoLoja>> getAll(int pId) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/veiculoloja/loja/$pId');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<VeiculoLoja> tabela =
            lista.map<VeiculoLoja>((map) => VeiculoLoja.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      List<VeiculoLoja> tabela = [];
      return tabela;
    }
  }

  static Future<int> delete(int pId) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      var url = Uri.http('$hostapi:9101', '/smaio/veiculoloja/$pId');
      var response = await http.delete(url, headers: headers);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 400;
    }
  }

  static Future<VeiculoLoja> post(VeiculoLoja pRegistro) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/veiculoloja');
      var response = await http.post(url, headers: headers, body: c);
      if (response.statusCode == 201) {
        String json = response.body;
        var lista = converte.json.decode(json);
        VeiculoLoja tabela = VeiculoLoja.fromJson(lista);
        return tabela;
      } else {
        return VeiculoLoja();
      }
    } catch (e) {
      print(e);
      return VeiculoLoja();
    }
  }

  static Future<int> patch(VeiculoLoja pRegistro) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http(
          '$hostapi:9101', '/smaio/veiculoloja/update/${pRegistro.vlojId}');
      var response = await http.post(url, headers: headers, body: c);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 400;
    }
  }
}
