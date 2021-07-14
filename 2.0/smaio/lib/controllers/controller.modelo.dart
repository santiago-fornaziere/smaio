import 'package:flutter/material.dart';
import 'package:smaio/forms/consumidor/form.consumidor.veiculo.dart';
import 'package:smaio/forms/veiculo.loja/novo/form.novo.veiculo.loja.veiculo.dart';
import 'package:smaio/models/model.modelo.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'dart:convert' as converte;
import 'package:http/http.dart' as http;
import 'package:smaio/utils/funcoes.dart';

class ModeloApi {
  static Future<List<Modelo>> getAll(int pId) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/modelo/fabricante/$pId');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<Modelo> tabela =
            lista.map<Modelo>((map) => Modelo.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<Modelo> tabela = [];
      return tabela;
    }
  }
}

onAvancar(BuildContext context, List<String> files, Modelo modelo) {
  push(
      context,
      NovoVeiculoLojaVeiculo(
        files: files,
        modelo: modelo,
      ));
}

onAvancarConsumidor(BuildContext context, Modelo modelo) {
  push(
      context,
      ConsumidorVeiculo(
        modelo: modelo,
      ));
}
