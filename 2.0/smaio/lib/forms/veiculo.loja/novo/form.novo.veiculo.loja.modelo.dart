import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.modelo.dart';
import 'package:smaio/models/model.fabricante.dart';
import 'package:smaio/models/model.modelo.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/bottonNavigationBar.dart';
import 'package:smaio/widgets/geral/lista.modelo.dart';

// ignore: must_be_immutable
class NovoVeiculoLojaModelo extends StatefulWidget {
  List<String> files;
  Fabricante fabricante;
  NovoVeiculoLojaModelo({
    required this.files,
    required this.fabricante,
  });
  @override
  _NovoVeiculoLojaModelo createState() => _NovoVeiculoLojaModelo();
}

class _NovoVeiculoLojaModelo extends State<NovoVeiculoLojaModelo> {
  // bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: 'Cadastramento de veículo / Modelo',
        mostraIcone: false,
      ),
//      backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: corTemaDark,
      bottomNavigationBar: WidgetBottonNavigatorBar(
        avancarFunction: null,
        mostraAvancar: false,
        context: context,
      ),
      body: _futureBuilder(),
    );
  }

  _futureBuilder() {
    Future<List<Modelo>> future = ModeloApi.getAll(widget.fabricante.fabId!);

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<Modelo>> snapshot) {
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
        List<Modelo> query = snapshot.data!;

        return _body(query);
      },
    );
  }

  _body(List<Modelo> query) {
    return Center(
      child: Container(
        child: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              WidgetModeloLista(
                context: context,
                query: query,
                fabricante: widget.fabricante.fabNome.toString(),
                files: widget.files,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
