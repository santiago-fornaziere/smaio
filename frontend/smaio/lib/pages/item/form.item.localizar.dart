import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/controllers/controller.item.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widget.menu.lateral.dart';
import 'package:smaio/utils/widgets/combo.grupo.dart';
import 'package:smaio/utils/widgets/lista.item.dart';

class ItemLocalizar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemLocalizar();
}

class _ItemLocalizar extends State<ItemLocalizar> {
  final _formKey = GlobalKey<FormState>();

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onPressNovoItem(context);
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      drawer: Consumer<Sistema>(
        builder: (context, sistema, child) {
          return DrawerList(
            usuNivel: sistema.usuario!.usuNivel!,
          );
        },
      ),
    );
  }

  _body() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          formTitulo(
            "ITENS PARA VENDA",
            Icons.shopping_cart,
            MediaQuery.of(context).size.width,
          ),
          formCorpoCadastro(context, _formKey, _tela())
        ],
      ),
    );
  }

  List<Widget> _tela() {
    return <Widget>[
      WidgetComboGrupo(
        context: context,
        descricao: _gruDescricaoController,
        texto: 'Selecione o grupo',
        codigo: _gruIdController,
        tipo: 'item',
      ),
      WidgetItemLista(
        context: context,
      ),
    ];
  }
}
