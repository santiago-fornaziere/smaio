import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/controllers/controller.veiano.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/notifiers/notifier.subgrupo.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widgets/lista.subgrupoveiano.dart';

// ignore: must_be_immutable
class VeiculoSubGrupoVeiAno extends StatefulWidget {
  VeiAno veiano;
  VeiculoSubGrupoVeiAno({
    required this.veiano,
  });
  @override
  State<StatefulWidget> createState() => _VeiculoSubGrupoVeiAno();
}

class _VeiculoSubGrupoVeiAno extends State<VeiculoSubGrupoVeiAno> {
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
      floatingActionButton:
          Consumer<SubGrupos>(builder: (context, subgrupo, child) {
        return FloatingActionButton(
          onPressed: () {
            subgrupo.setSubGrupos([]);
            onPressNovoSubGrupoVeiAno(context, widget.veiano);
          },
          child: Icon(
            Icons.add,
            size: 40,
          ),
        );
      }),
    );
  }

  _body() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          formTitulo(
            "${widget.veiano.vanoVeiFabNome} / ${widget.veiano.vanoVeiDescricao.toString().toUpperCase()} - ${widget.veiano.vanoAnoDescricao}",
            Icons.ballot_outlined,
            MediaQuery.of(context).size.width,
          ),
          formCorpoCadastro(context, null, _tela())
        ],
      ),
    );
  }

  List<Widget> _tela() {
    return <Widget>[
      WidgetSubGrupoVeiAnoLista(
        context: context,
      ),
    ];
  }
}
