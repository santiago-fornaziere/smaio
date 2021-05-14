import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/models/model.subgrupo.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/notifiers/notifier.subgrupo.dart';
import 'package:smaio/pages/peca/form.peca.localizar.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/utils/widget.botao.gravar.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widgets/add.subgrupo.dart';
import 'package:smaio/utils/widgets/combo.grupo.dart';
import 'package:smaio/utils/widgets/edit.texto.dart';

// ignore: must_be_immutable
class PecaNovo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PecaNovo();
}

class _PecaNovo extends State<PecaNovo> {
  final _formKey = GlobalKey<FormState>();
  final _focus = FocusNode();

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
          formTitulo("NOVA PEÇA", Icons.app_registration),
          formCorpoCadastro(context, _formKey, _tela())
        ],
      ),
    );
  }

  List<Widget> _tela() {
    return <Widget>[
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
        texto: 'Selecione o grupo',
        codigo: _gruIdController,
        tipo: 'peca',
      ),
      Divider(),
      WidgetAddSubGrupo(
        context: context,
      ),
      Container(
        padding: EdgeInsets.all(20),
        child: Consumer<SubGrupos>(builder: (context, lista, child) {
          List<SubGrupo> subGrupos = lista.subGrupo;
          return BotaoGravar(onPressed: () => onPressed(subGrupos));
        }),
      )
    ];
  }

  Future<bool> onPressed(List<SubGrupo> subGrupos) async {
    if (_formKey.currentState!.validate()) {
      var novo = Peca(
        pecDescricao: _pecDescricaoController.text,
        pecGruId: int.parse(_gruIdController.text),
        pecGruDescricao: _gruDescricaoController.text,
        pecSitReg: true,
        pecSgrus: subGrupos,
      );
      int retorno = await PecaApi.post(novo);
      if (retorno == 201) {
        push(context, PecaLocalizar());
        return true;
      } else {
        showSnackMessage(context, 'Erro ao inserir nova peça...');
        return false;
      }
    } else {
      return false;
    }
  }
}
