import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:smaio/forms/consumidor/form.consumidor.foto.visualizar.dart';
import 'package:smaio/forms/veiculo.loja/alterar/form.alterar.visualizar.foto.dart';
import 'package:smaio/forms/veiculo.loja/novo/form.novo.veiculo.loja.fabricante.dart';
import 'package:smaio/models/model.foto.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as converte;

class FotoApi {
  static Future<List<Foto>> getByVeiLoja(int pId) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9198', '/smaio/foto/$pId');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<Foto> tabela =
            lista.map<Foto>((map) => Foto.fromJson(map)).toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<Foto> tabela = [];
      print(e);
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
      var url = Uri.http('$hostapi:9198', '/smaio/foto/$pId');
      var response = await http.delete(url, headers: headers);
      return response.statusCode;
    } catch (e) {
      return 400;
    }
  }

  static Future<int> post(Uint8List foto, int pId) async {
    String token = await Prefs.getString("token");
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/octet-stream",
    };
    try {
      var url = Uri.http('$hostapi:9198', '/smaio/foto/$pId');
      var response = await http.post(url, headers: headers, body: foto);
      if (response.statusCode == 201) {
        String json = response.body;
        return int.parse(json);
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }
}

onAvancar(BuildContext context, List<String> files) {
  push(
      context,
      NovoVeiculoLojaFabricante(
        files: files,
      ));
}

onVisualizarFoto(BuildContext context, Foto foto) {
  push(
      context,
      AlterarVeiculoVisualizarFoto(
        foto: foto,
      ));
}

onVisualizarFotoConsumidor(BuildContext context, Foto foto, String titulo) {
  push(
      context,
      ConsumidorFotoVisualizar(
        foto: foto,
        titulo: titulo,
      ));
}
