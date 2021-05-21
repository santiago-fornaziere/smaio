import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widgets/lista.item.subgrupoveiano.dart';

// ignore: must_be_immutable
class ItemNovoSubGrupoLocalizar extends StatefulWidget {
  VeiAno veiano;
  Peca peca;
  ItemNovoSubGrupoLocalizar({
    required this.veiano,
    required this.peca,
  });

  @override
  State<StatefulWidget> createState() => _ItemNovoSubGrupoLocalizar();
}

class _ItemNovoSubGrupoLocalizar extends State<ItemNovoSubGrupoLocalizar> {
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
    );
  }

  _body() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          formTitulo(
              "NOVO ITEM PARA VENDA - ${widget.veiano.vanoAnoDescricao} > ${widget.veiano.vanoVeiFabNome} > ${widget.veiano.vanoVeiDescricao} > ${widget.peca.pecDescricao}",
              Icons.shopping_cart,
              MediaQuery.of(context).size.width),
          formCorpoCadastro(context, null, _lista())
        ],
      ),
    );
  }

  List<Widget> _lista() {
    return <Widget>[
      WidgetItemSubGrupoVeiAnoLista(
        context: context,
      ),
    ];
  }
}
