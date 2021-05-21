import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/controllers/controller.veiculo.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widget.menu.lateral.dart';
import 'package:smaio/utils/widgets/combo.fabricante.dart';
import 'package:smaio/utils/widgets/lista.veiculo.dart';

class VeiculoLocalizar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginLojaPage();
}

class _LoginLojaPage extends State<VeiculoLocalizar> {
  final _formKey = GlobalKey<FormState>();

  final _fabNomeController = TextEditingController();
  final _fabIdController = TextEditingController();

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
        onPressed: () => onPressNovoVeiculo(context),
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
            "VEÍCULOS",
            Icons.car_repair,
            MediaQuery.of(context).size.width,
          ),
          formCorpoCadastro(context, _formKey, _tela())
        ],
      ),
    );
  }

  List<Widget> _tela() {
    return <Widget>[
      WidgetComboFabricante(
        context: context,
        descricao: _fabNomeController,
        texto: 'Selecione o fabricante',
        codigo: _fabIdController,
      ),
      WidgetVeiculoLista(
        context: context,
      ),
    ];
  }
}
