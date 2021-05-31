import 'package:flutter/material.dart';
import 'package:smaio/forms/veiculo.loja/pecas/form.peca.peca.dart';
import 'package:smaio/models/model.grupo.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/models/model.peca.veiloja.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/models/model.where.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'dart:convert' as converte;
import 'package:http/http.dart' as http;
import 'package:smaio/utils/funcoes.dart';

class PecaApi {
  static Future<List<Peca>> getWhere(String pWhere, String pOrderBy) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    var where = Where(where: pWhere, orderBy: pOrderBy);
    String jsonWhere = where.toJson();
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/peca/localizar');
      var response = await http.post(url, headers: headers, body: jsonWhere);
      if (response.statusCode == 201) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<Peca> tabela =
            lista.map<Peca>((map) => Peca.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<Peca> tabela = [];
      return tabela;
    }
  }

  static Future<int> put(Peca pRegistro) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/peca/${pRegistro.pecId}');
      var response = await http.put(url, headers: headers, body: c);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 400;
    }
  }

  static Future<int> post(Peca pRegistro) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/peca');
      var response = await http.post(url, headers: headers, body: c);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 400;
    }
  }
}

class PecaVeiLojaApi {
  static Future<List<PecaVeiLoja>> getWhere(
      String pWhere, String pOrderBy, int pId) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    var where = Where(where: pWhere, orderBy: pOrderBy);

    String jsonWhere = where.toJson();
    try {
      var url = Uri.http('$hostapi:9101', 'smaio/peca/veiloja/localizar/$pId');
      var response = await http.post(url, headers: headers, body: jsonWhere);
      if (response.statusCode == 201) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<PecaVeiLoja> tabela =
            lista.map<PecaVeiLoja>((map) => PecaVeiLoja.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<PecaVeiLoja> tabela = [];
      return tabela;
    }
  }
}

void onAvancarGrupo(BuildContext context, VeiculoLoja veiloja, Grupo grupo) {
  push(
      context,
      FormPeca(
        grupo: grupo,
        veiloja: veiloja,
      ));
}
