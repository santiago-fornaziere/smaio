import 'package:smaio/models/model.dashboard.dart';
import 'package:smaio/pages/form.login.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as converte;
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:random_color/random_color.dart';

class DashboardApi {
  static Future<List<GraficoPizza>> getByStatus(int pID) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9001', '/bfcall/dashboard/status/$pID');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<GraficoPizza> tabela = lista
            .map<GraficoPizza>((map) => GraficoPizza.fromJson(map))
            .toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<GraficoPizza> tabela = [];
      return tabela;
    }
  }

  static Future<List<GraficoPizza>> getByTipo(int pID) async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9001', '/bfcall/dashboard/tipo/$pID');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        List lista = converte.json.decode(json);
        List<GraficoPizza> tabela = lista
            .map<GraficoPizza>((map) => GraficoPizza.fromJson(map))
            .toList();
        return tabela;
      } else {
        return [];
      }
    } catch (e) {
      List<GraficoPizza> tabela = [];
      return tabela;
    }
  }
}

onClickLogout(BuildContext context) async {
  String email = await Prefs.getString('usu_email');
  push(
      context,
      LoginPage(
        email: email,
      ),
      replace: true);
}

AspectRatio graficoStatus(List<GraficoPizza> query) {
  List<Widget> _filhos = [];
  _filhos.add(
    Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            centerSpaceRadius: 50,
            sectionsSpace: 1,
            startDegreeOffset: 100,
            sections: showingSectionsStatus(query),
          ),
        ),
      ),
    ),
  );

  return AspectRatio(
    aspectRatio: 1.3,
    child: Card(
      elevation: 5.0,
      borderOnForeground: false,
      color: fundoBranco,
      child: Container(
        padding: EdgeInsets.all(25),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Text(
              "Chamados por Status",
              style: styleTexto(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _filhos,
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

List<PieChartSectionData> showingSectionsStatus(List<GraficoPizza> query) {
  List<PieChartSectionData> _sessoes = [];
  for (GraficoPizza row in query) {
    _sessoes.add(
      PieChartSectionData(
        value: row.cONTAGEM!.toDouble(),
        radius: 80,
        color: RandomColor().randomColor(),
        title: '${row.dESCRICAO}\nQtde : ${row.cONTAGEM}',
        titleStyle: TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
        titlePositionPercentageOffset: 0.55,
      ),
    );
  }
  return _sessoes;
}

AspectRatio graficoTipo(List<GraficoPizza> query) {
  List<Widget> _filhos = [];
  _filhos.add(
    Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            centerSpaceRadius: 50,
            sectionsSpace: 1,
            startDegreeOffset: 100,
            sections: showingSectionsTipo(query),
          ),
        ),
      ),
    ),
  );

  return AspectRatio(
    aspectRatio: 1.3,
    child: Card(
      elevation: 5.0,
      borderOnForeground: false,
      color: fundoBranco,
      child: Container(
        padding: EdgeInsets.all(25),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Text(
              "Chamados por Tipo",
              style: styleTexto(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _filhos,
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

List<PieChartSectionData> showingSectionsTipo(List<GraficoPizza> query) {
  List<PieChartSectionData> _sessoes = [];
  for (GraficoPizza row in query) {
    _sessoes.add(
      PieChartSectionData(
        value: row.cONTAGEM!.toDouble(),
        radius: 80,
        color: RandomColor().randomColor(),
        title: '${row.dESCRICAO}\nQtde : ${row.cONTAGEM}',
        titleStyle: TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
        titlePositionPercentageOffset: 0.55,
      ),
    );
  }
  return _sessoes;
}
