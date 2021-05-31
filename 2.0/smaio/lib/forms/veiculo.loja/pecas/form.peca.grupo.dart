import 'package:flutter/material.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/bottonNavigationBar.dart';
import 'package:smaio/widgets/geral/lista.grupo.dart';

// ignore: must_be_immutable
class PecaGrupo extends StatefulWidget {
  VeiculoLoja veiloja;
  PecaGrupo({
    required this.veiloja,
  });
  @override
  _PecaGrupo createState() => _PecaGrupo();
}

class _PecaGrupo extends State<PecaGrupo> {
  // bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: 'Cadastramento de veículo / Peças',
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
        margin: EdgeInsets.all(16),
        child: ListView(
          children: [
            WidgetGrupoLista(
              context: context,
              veiloja: widget.veiloja,
            ),
          ],
        ),
      ),
    );
  }
}
