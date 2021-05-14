import 'package:flutter/material.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/models/model.subgrupo.dart';
import 'package:smaio/models/model.subgrupoveiano.dart';
import 'package:smaio/models/model.where.dart';
import 'package:smaio/pages/peca/form.peca.novo.dart';
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

  static Future<List<SubGrupoVeiAno>> getByVeiAno(int pID) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/peca/sgvano/veiano/$pID');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<SubGrupoVeiAno> tabela = lista
            .map<SubGrupoVeiAno>((map) => SubGrupoVeiAno.fromJson(map))
            .toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<SubGrupoVeiAno> tabela = [];
      return tabela;
    }
  }

  static Future<List<SubGrupo>> getByGrupo(int pID) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/peca/subgrupo/grupo/$pID');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<SubGrupo> tabela =
            lista.map<SubGrupo>((map) => SubGrupo.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<SubGrupo> tabela = [];
      return tabela;
    }
  }

  static Future<List<SubGrupo>> getSGWhere(
      String pWhere, String pOrderBy, int pSgvanoVanoId) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    var where = WhereSubGrupoVeiAno(
        where: pWhere,
        orderBy: pOrderBy,
        sgvanoVanoId: pSgvanoVanoId.toString());
    String jsonWhere = where.toJson();

    try {
      var url = Uri.http('$hostapi:9101', '/smaio/peca/subgrupo/localizar');
      var response = await http.post(url, headers: headers, body: jsonWhere);
      if (response.statusCode == 201) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<SubGrupo> tabela =
            lista.map<SubGrupo>((map) => SubGrupo.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<SubGrupo> tabela = [];
      return tabela;
    }
  }

  static Future<int> deleteSGVano(int pID) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/peca/sgvano/$pID');
      var response = await http.delete(url, headers: headers);
      return response.statusCode;
    } catch (e) {
      return 400;
    }
  }

  static Future<int> postSGVano(SubGrupoVeiAno pRegistro) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/peca/sgvano');
      var response = await http.post(url, headers: headers, body: c);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 400;
    }
  }
}

void onPressNovaPeca(BuildContext context) {
  push(context, PecaNovo());
}
