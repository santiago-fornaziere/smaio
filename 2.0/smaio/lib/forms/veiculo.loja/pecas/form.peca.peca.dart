import 'package:flutter/material.dart';
import 'package:smaio/models/model.grupo.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/notifiers/notifier.peca.veiloja.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/bottonNavigationBar.dart';
import 'package:provider/provider.dart';
import 'package:smaio/widgets/geral/lista.peca.veiloja.dart';

// ignore: must_be_immutable
class FormPeca extends StatefulWidget {
  VeiculoLoja veiloja;
  Grupo grupo;
  FormPeca({
    required this.veiloja,
    required this.grupo,
  });
  @override
  _FormPeca createState() => _FormPeca();
}

class _FormPeca extends State<FormPeca> {
  // bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: widget.grupo.gruDescricao.toString(),
        mostraIcone: false,
      ),
//      backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: corTemaDark,
      bottomNavigationBar: WidgetBottonNavigatorBar(
        avancarFunction: null,
        context: context,
        mostraAvancar: false,
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Container(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Consumer<PecaVeiLojas>(builder: (context, lista, child) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                WidgetPecaVeiLojaLista(
                  context: context,
                  titulo: widget.grupo.gruDescricao.toString(),
                  veiloja: widget.veiloja,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
