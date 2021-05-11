import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/notifiers/notifier.subgrupo.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widget.menu.lateral.dart';
import 'package:smaio/utils/widgets/combo.grupo.dart';
import 'package:smaio/utils/widgets/lista.peca.dart';

class PecaLocalizar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PecaLocalizar();
}

class _PecaLocalizar extends State<PecaLocalizar> {
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
      floatingActionButton:
          Consumer<SubGrupos>(builder: (context, lista, child) {
        return FloatingActionButton(
          onPressed: () {
            lista.setSubGrupos([]);
            onPressNovaPeca(context);
          },
          child: Icon(
            Icons.add,
            size: 40,
          ),
        );
      }),
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
          formTitulo("PEÇAS", Icons.app_registration),
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
      ),
      WidgetPecaLista(
        context: context,
      ),
    ];
  }
}
