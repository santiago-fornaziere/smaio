import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.veiano.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/models/model.veiculo.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/bottonNavigationBar.dart';
import 'package:smaio/widgets/geral/lista.ano.veiloja.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NovoVeiculoLojaAno extends StatefulWidget {
  List<String> files;
  Veiculo veiculo;
  NovoVeiculoLojaAno({
    required this.files,
    required this.veiculo,
  });
  @override
  _NovoVeiculoLojaAno createState() => _NovoVeiculoLojaAno();
}

class _NovoVeiculoLojaAno extends State<NovoVeiculoLojaAno> {
  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: 'Cadastramento de veículo / Ano',
        mostraIcone: false,
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
    Future<List<VeiAno>> future = VeiAnoApi.getByWhere(
        'vano_vei_id = ${widget.veiculo.veiId}', 'vano_ano_descricao');

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<VeiAno>> snapshot) {
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
        List<VeiAno> query = snapshot.data!;

        return _body(query);
      },
    );
  }

  _body(List<VeiAno> query) {
    return Center(
      child: Container(
        child: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Consumer<Sistema>(builder: (context, sistema, child) {
                return WidgetAnoListaVeiloja(
                  context: context,
                  showProgress: _showProgress,
                  titulo:
                      '${widget.veiculo.fabNome.toString()} > ${widget.veiculo.veiDescricao.toString()}',
                  files: widget.files,
                  query: query,
                  loja: sistema.loja!.lojId!,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
