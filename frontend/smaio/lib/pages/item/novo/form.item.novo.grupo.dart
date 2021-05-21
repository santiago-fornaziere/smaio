import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widgets/combo.grupo.dart';
import 'package:smaio/utils/widgets/lista.item.peca.dart';

// ignore: must_be_immutable
class ItemNovoGrupoLocalizar extends StatefulWidget {
  VeiAno veiano;
  ItemNovoGrupoLocalizar({
    required this.veiano,
  });

  @override
  State<StatefulWidget> createState() => _ItemNovoGrupoLocalizar();
}

class _ItemNovoGrupoLocalizar extends State<ItemNovoGrupoLocalizar> {
  final _gruDescricaoController = TextEditingController();
  final _gruIdController = TextEditingController();

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
            "NOVO ITEM PARA VENDA - ${widget.veiano.vanoAnoDescricao} > ${widget.veiano.vanoVeiFabNome} > ${widget.veiano.vanoVeiDescricao}",
            Icons.shopping_cart,
            MediaQuery.of(context).size.width,
          ),
          formCorpoCadastro(context, null, _lista())
        ],
      ),
    );
  }

  List<Widget> _lista() {
    return <Widget>[
      WidgetComboGrupo(
        context: context,
        descricao: _gruDescricaoController,
        texto: 'Selecione o grupo',
        codigo: _gruIdController,
        tipo: 'peca',
      ),
      WidgetItemPecaLista(
        context: context,
        veiano: widget.veiano,
      ),
    ];
  }
}