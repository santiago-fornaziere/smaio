import 'package:flutter/material.dart';
import 'package:smaio/forms/veiculo.loja/alterar/form.alterar.lista.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: 'Cadastramento de veículo / Peças',
        mostraIcone: false,
        tema: 0,
      ),
//      backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: corTemaDark,
      bottomNavigationBar: WidgetBottonNavigatorBar(
        avancarFunction: () =>
            push(context, AlterarLista(loja: widget.veiloja.vlojLojId!)),
        context: context,
        mostraAvancar: true,
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
