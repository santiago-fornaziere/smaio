import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fabricante.dart';
import 'package:smaio/forms/form.config.dart';
import 'package:smaio/models/model.fabricante.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/lista.fabricante.dart';

// ignore: must_be_immutable
class ConsumidorFabricante extends StatefulWidget {
  @override
  _ConsumidorFabricante createState() => _ConsumidorFabricante();
}

class _ConsumidorFabricante extends State<ConsumidorFabricante> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: '',
        onPressed: () => push(context, Config()),
        mostraIcone: true,
        tema: 1,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _futureBuilder(),
    );
  }

  _futureBuilder() {
    Future<List<Fabricante>> future = FabricanteApi.getAll();

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<Fabricante>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Não foi possível concluir esta ação!",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Fabricante> query = snapshot.data!;

        return _body(query);
      },
    );
  }

  _body(List<Fabricante> query) {
    return Center(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            padding: EdgeInsets.all(16),
            height: 120,
            width: 120,
            child: Image.asset('assets/img/logo-amarelo.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Selecione o fabricante',
              style:
                  TextStyle(fontSize: fontSizePadrao, color: corTextoPadrao[1]),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 260,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                WidgetFabricanteLista(
                  context: context,
                  query: query,
                  files: [],
                  tema: 1,
                  origem: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
