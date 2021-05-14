import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widget.menu.lateral.dart';
import 'package:smaio/utils/widgets/lista.veiculo.veiano.dart';

// ignore: must_be_immutable
class ItemNovoVeiAnoLocalizar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemNovoVeiAnoLocalizar();
}

class _ItemNovoVeiAnoLocalizar extends State<ItemNovoVeiAnoLocalizar> {
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
          formCorpoCadastro(context, null, _lista())
        ],
      ),
    );
  }

  List<Widget> _lista() {
    return <Widget>[
      WidgetVeiculoVeiAnoLista(
        context: context,
      ),
    ];
  }
}
