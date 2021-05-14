import 'package:flutter/material.dart';
import 'package:smaio/models/model.item.dart';
import 'package:smaio/models/model.where.dart';
import 'package:smaio/pages/item/novo/form.item.novo.ano.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'dart:convert' as converte;
import 'package:http/http.dart' as http;
import 'package:smaio/utils/funcoes.dart';

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

  static Future<int> post(Item pRegistro) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/item');
      var response = await http.post(url, headers: headers, body: c);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 400;
    }
  }

  static Future<int> put(Item pRegistro) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/item/${pRegistro.iteId}');
      var response = await http.put(url, headers: headers, body: c);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 400;
    }
  }
}

void onPressNovoItem(BuildContext context) {
  push(context, ItemNovoAnoLocalizar());
}
