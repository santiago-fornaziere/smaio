import 'package:smaio/models/model.item.dart';
import 'package:smaio/models/model.where.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'dart:convert' as converte;
import 'package:http/http.dart' as http;

class ItemApi {
  static Future<List<Item>> getWhere(String pWhere, String pOrderBy) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    var where = Where(where: pWhere, orderBy: pOrderBy);

    String jsonWhere = where.toJson();
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/item/localizar');
      var response = await http.post(url, headers: headers, body: jsonWhere);
      if (response.statusCode == 201) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<Item> tabela =
            lista.map<Item>((map) => Item.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<Item> tabela = [];
      return tabela;
    }
  }

  static Future<Item> post(Item pRegistro) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/item');
      var response = await http.post(url, headers: headers, body: c);
      if (response.statusCode == 201) {
        String json = response.body;
        var lista = converte.json.decode(json);
        Item tabela = Item.fromJson(lista);
        return tabela;
      } else {
        return Item();
      }
    } catch (e) {
      print(e);
      return Item();
    }
  }

  static Future<Item> put(Item pRegistro) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/item/${pRegistro.iteId}');
      var response = await http.put(url, headers: headers, body: c);
      if (response.statusCode == 201) {
        String json = response.body;
        var lista = converte.json.decode(json);
        Item tabela = Item.fromJson(lista);
        return tabela;
      } else {
        return Item();
      }
    } catch (e) {
      print(e);
      return Item();
    }
  }

  static Future<int> patchBaixa(int pId) async {
    String token = await Prefs.getString("token");
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/item/baixa/$pId');
      var response = await http.patch(url, headers: headers);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 401;
    }
  }

  static Future<int> patchVendido(int pId) async {
    String token = await Prefs.getString("token");
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/item/vendido/$pId');
      var response = await http.patch(url, headers: headers);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 401;
    }
  }
}
