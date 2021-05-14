import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widget.menu.lateral.dart';
import 'package:smaio/utils/widgets/lista.ano.dart';

class ItemNovoAnoLocalizar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemNovoAnoLocalizar();
}

class _ItemNovoAnoLocalizar extends State<ItemNovoAnoLocalizar> {
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
          formTitulo("NOVO ITEM PARA VENDA", Icons.shopping_cart),
          formCorpoCadastro(context, null, _tela())
        ],
      ),
    );
  }

  List<Widget> _tela() {
    return <Widget>[
      WidgetAnoLista(
        context: context,
      ),
    ];
  }
}