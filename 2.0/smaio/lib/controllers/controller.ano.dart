import 'package:flutter/material.dart';
import 'package:smaio/forms/consumidor/form.consumidor.grupo.dart';
import 'package:smaio/models/model.ano.dart';
import 'package:smaio/models/model.modelo.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'dart:convert' as converte;
import 'package:http/http.dart' as http;
import 'package:smaio/utils/funcoes.dart';

class AnoApi {
  static Future<List<Ano>> getbyModelo(int pId) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/ano/modelo/$pId');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<Ano> tabela = lista.map<Ano>((map) => Ano.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<Ano> tabela = [];
      return tabela;
    }
  }
}

onAvancar(BuildContext context, Ano ano, Modelo modelo) {
  VeiAno veiano = VeiAno(
    vanoAnoId: ano.anoId,
    vanoAnoDescricao: ano.anoDescricao,
    vanoModId: modelo.modId,
    vanoModDescricao: modelo.modDescricao,
    vanoVeiFabId: modelo.modFabId,
    vanoVeiFabNome: modelo.fabNome,
    vanoId: 0,
    vanoVeiDescricao: '',
    vanoVeiId: 0,
  );
  push(context, ConsumidorGrupo(veiano: veiano));
}
