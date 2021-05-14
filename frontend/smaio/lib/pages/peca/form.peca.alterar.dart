import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/pages/peca/form.peca.localizar.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/utils/widget.botao.gravar.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widgets/combo.grupo.dart';
import 'package:smaio/utils/widgets/edit.texto.dart';
import 'package:smaio/utils/widgets/lista.subgrupo.dart';

// ignore: must_be_immutable
class PecaAlterar extends StatefulWidget {
  Peca peca;
  PecaAlterar({
    required this.peca,
  });
  @override
  State<StatefulWidget> createState() => _PecaAlterar();
}

class _PecaAlterar extends State<PecaAlterar> {
  final _formKey = GlobalKey<FormState>();
  final _focus = FocusNode();

  final _pecIdController = TextEditingController();
  final _pecDescricaoController = TextEditingController();
  final _gruIdController = TextEditingController();
  final _gruDescricaoController = TextEditingController();

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
          formTitulo("ALTERAR PEÇAS", Icons.app_registration),
          formCorpoCadastro(context, _formKey, _tela())
        ],
      ),
    );
  }

  List<Widget> _tela() {
    _pecIdController.text = widget.peca.pecId.toString();
    _pecDescricaoController.text = widget.peca.pecDescricao.toString();
    _gruIdController.text = widget.peca.pecGruId.toString();
    _gruDescricaoController.text = widget.peca.pecGruDescricao.toString();
    return <Widget>[
      WidgetEditTexto(
        context: context,
        descricao: _pecIdController,
        texto: 'ID',
        autofocos: false,
        enabled: false,
      ),
      WidgetEditTexto(
        context: context,
        descricao: _pecDescricaoController,
        texto: 'Peça',
        autofocos: true,
        focusNode: _focus,
      ),
      WidgetComboGrupo(
        context: context,
        descricao: _gruDescricaoController,
        texto: 'Alterar o Grupo',
        codigo: _gruIdController,
        tipo: 'peca',
      ),
      Container(
        padding: EdgeInsets.all(20),
        child: BotaoGravar(onPressed: () => onPressed()),
      ),
      Divider(),
      WidgetSubGrupoLista(
        context: context,
        pecId: widget.peca.pecId!,
      ),
    ];
  }

  onPressed() async {
    widget.peca.pecId = int.parse(_pecIdController.text);
    widget.peca.pecDescricao = _pecDescricaoController.text;
    widget.peca.pecGruId = int.parse(_gruIdController.text);
    widget.peca.pecGruDescricao = _gruDescricaoController.text;
    int retorno = await PecaApi.put(widget.peca);
    if (retorno == 202) {
      push(context, PecaLocalizar());
    } else {
      showSnackMessage(context, 'Erro ao alterar o registro...');
    }
  }
}
