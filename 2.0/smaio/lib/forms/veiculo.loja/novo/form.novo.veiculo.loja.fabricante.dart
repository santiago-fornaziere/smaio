import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fabricante.dart';
import 'package:smaio/models/model.fabricante.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/bottonNavigationBar.dart';
import 'package:smaio/widgets/geral/lista.fabricante.dart';

// ignore: must_be_immutable
class NovoVeiculoLojaFabricante extends StatefulWidget {
  List<String> files;
  NovoVeiculoLojaFabricante({
    required this.files,
  });
  @override
  _NovoVeiculoLojaFabricante createState() => _NovoVeiculoLojaFabricante();
}

class _NovoVeiculoLojaFabricante extends State<NovoVeiculoLojaFabricante> {
  // bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: 'Cadastramento de veículo / Fabricante',
        mostraIcone: false,
        tema: 0,
      ),
//      backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: corTemaDark,
      bottomNavigationBar: WidgetBottonNavigatorBar(
        avancarFunction: null,
        context: context,
        mostraAvancar: false,
      ),
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
      child: Container(
        child: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              WidgetFabricanteLista(
                context: context,
                query: query,
                files: widget.files,
                tema: 0,
                origem: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
