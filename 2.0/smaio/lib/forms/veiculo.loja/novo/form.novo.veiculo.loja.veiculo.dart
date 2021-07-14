import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.veiculo.dart';
import 'package:smaio/models/model.modelo.dart';
import 'package:smaio/models/model.veiculo.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/bottonNavigationBar.dart';
import 'package:smaio/widgets/geral/lista.veiculo.dart';

// ignore: must_be_immutable
class NovoVeiculoLojaVeiculo extends StatefulWidget {
  List<String> files;
  Modelo modelo;
  NovoVeiculoLojaVeiculo({
    required this.files,
    required this.modelo,
  });
  @override
  _NovoVeiculoLojaVeiculo createState() => _NovoVeiculoLojaVeiculo();
}

class _NovoVeiculoLojaVeiculo extends State<NovoVeiculoLojaVeiculo> {
  // bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: 'Cadastramento de veículo / Veículo',
        mostraIcone: false,
        tema: 0,
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
    Future<List<Veiculo>> future = VeiculoApi.getAll(widget.modelo.modId!);

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<Veiculo>> snapshot) {
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
        List<Veiculo> query = snapshot.data!;

        return _body(query);
      },
    );
  }

  _body(List<Veiculo> query) {
    return Center(
      child: Container(
        child: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              WidgetVeiculoLista(
                context: context,
                query: query,
                titulo:
                    '${widget.modelo.fabNome.toString()} > ${widget.modelo.modDescricao.toString()}',
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
