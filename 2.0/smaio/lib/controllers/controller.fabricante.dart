import 'package:flutter/cupertino.dart';
import 'package:smaio/forms/veiculo.loja/novo/form.novo.veiculo.loja.modelo.dart';
import 'package:smaio/models/model.fabricante.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'dart:convert' as converte;
import 'package:http/http.dart' as http;
import 'package:smaio/utils/funcoes.dart';

class FabricanteApi {
  static Future<List<Fabricante>> getAll() async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/fabricante');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<Fabricante> tabela =
            lista.map<Fabricante>((map) => Fabricante.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<Fabricante> tabela = [];
      return tabela;
    }
  }
}

onAvancar(BuildContext context, List<String> files, Fabricante fabricante) {
  push(
      context,
      NovoVeiculoLojaModelo(
        files: files,
        fabricante: fabricante,
      ));
}
