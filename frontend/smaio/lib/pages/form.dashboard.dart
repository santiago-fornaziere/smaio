import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
//import 'package:smaio/models/model.dashboard.dart';
import 'package:smaio/utils/widget.menu.lateral.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
/*
  final List<GraficoPizza> graficoStatus;
  final List<GraficoPizza> graficoTipo;
  Dashboard({
    required this.graficoStatus,
    required this.graficoTipo,
  });
*/
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<Sistema>(
          builder: (context, sistema, child) {
            return Text(sistema.loja!.lojNome.toString());
          },
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => onClickLogout(context),
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _body(),
      drawer: Consumer<Sistema>(
        builder: (context, sistema, child) {
          return DrawerList(
            usuNivel: sistema.usuario!.usuNivel!,
          );
        },
      ),
    );
  }

  _body() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          formTitulo("DASHBOARD", Icons.dashboard),
          formGrafico(),
        ],
      ),
    );
  }

  Container formGrafico() {
    return Container(
      height: 420,
      width: (MediaQuery.of(context).size.width > 600) ? 800 : 400,
      child: GridView.count(
        crossAxisCount: (MediaQuery.of(context).size.width > 600) ? 2 : 1,
        children: [
          //graficoStatus(widget.graficoStatus),
          //graficoTipo(widget.graficoTipo),
        ],
      ),
    );
  }
}
