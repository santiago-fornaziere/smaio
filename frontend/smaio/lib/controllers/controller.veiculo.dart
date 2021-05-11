import 'package:flutter/material.dart';
import 'package:smaio/models/model.veiculo.dart';
import 'package:smaio/pages/veiculo/form.veiculo.alterar.dart';
import 'package:smaio/pages/veiculo/form.veiculo.novo.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'dart:convert' as converte;
import 'package:http/http.dart' as http;
import 'package:smaio/utils/funcoes.dart';

class VeiculoApi {
  static Future<List<Veiculo>> getAll(int pId) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/veiculo/fabricante/$pId');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<Veiculo> tabela =
            lista.map<Veiculo>((map) => Veiculo.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<Veiculo> tabela = [];
      return tabela;
    }
  }

  static Future<int> put(Veiculo pRegistro) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/veiculo/${pRegistro.veiId}');
      var response = await http.put(url, headers: headers, body: c);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 400;
    }
  }

  static Future<int> post(Veiculo pRegistro) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/veiculo');
      var response = await http.post(url, headers: headers, body: c);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 400;
    }
  }
}

void onPressAlterar(BuildContext context, Veiculo veiculo) {
  push(context, VeiculoAlterar(veiculo: veiculo));
}

void onPressNovoVeiculo(BuildContext context) {
  push(context, VeiculoNovo());
}
