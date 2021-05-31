import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/models/model.where.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'dart:convert' as converte;
import 'package:http/http.dart' as http;

class VeiAnoApi {
  static Future<List<VeiAno>> getByWhere(String pWhere, String pOrderBy) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    var where = Where(where: pWhere, orderBy: pOrderBy);

    String jsonWhere = where.toJson();
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/veiano/localizar');
      var response = await http.post(url, headers: headers, body: jsonWhere);
      if (response.statusCode == 201) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<VeiAno> tabela =
            lista.map<VeiAno>((map) => VeiAno.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<VeiAno> tabela = [];
      return tabela;
    }
  }

  static Future<int> post(VeiAno pRegistro) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/veiano');
      var response = await http.post(url, headers: headers, body: c);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 400;
    }
  }

  static Future<int> delete(int pID) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      var url = Uri.http('$hostapi:9101', '/smaio/veiano/$pID');
      var response = await http.delete(url, headers: headers);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 400;
    }
  }
}
