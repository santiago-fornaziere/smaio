import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/controllers/controller.subgrupo.dart';
import 'package:smaio/models/model.subgrupo.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/notifiers/notifier.subgrupo.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/utils/widget.botao.gravar.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widgets/edit.texto.dart';

// ignore: must_be_immutable
class SubGrupoAlterar extends StatefulWidget {
  SubGrupo subGrupo;
  int subGrupoIndice;
  SubGrupoAlterar({
    required this.subGrupo,
    required this.subGrupoIndice,
  });
  @override
  State<StatefulWidget> createState() => _SubGrupoAlterar();
}

class _SubGrupoAlterar extends State<SubGrupoAlterar> {
  final _formKey = GlobalKey<FormState>();
  final _focus = FocusNode();

  final _sgruIdController = TextEditingController();
  final _sgruDescricaoController = TextEditingController();

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
          formTitulo("SUBGRUPO", Icons.app_registration),
          formCorpoCadastro(context, _formKey, _tela())
        ],
      ),
    );
  }

  List<Widget> _tela() {
    _sgruIdController.text =
        widget.subGrupo.sgruId != null ? widget.subGrupo.sgruId.toString() : '';
    _sgruDescricaoController.text = widget.subGrupo.sgruDescricao ?? '';
    return <Widget>[
      WidgetEditTexto(
        context: context,
        descricao: _sgruIdController,
        texto: 'ID',
        autofocos: false,
        enabled: false,
      ),
      WidgetEditTexto(
        context: context,
        descricao: _sgruDescricaoController,
        texto: 'Subgrupo',
        autofocos: true,
        focusNode: _focus,
      ),
      Consumer<SubGrupos>(builder: (context, lista, child) {
        return Container(
          padding: EdgeInsets.all(20),
          child: BotaoGravar(onPressed: () async {
            widget.subGrupo.sgruDescricao = _sgruDescricaoController.text;
            if (widget.subGrupo.sgruId != null) {
              int retorno = await SubGrupoApi.put(widget.subGrupo);
              if (retorno == 202) {
                lista.udpateSubGrupos(widget.subGrupo, widget.subGrupoIndice);
                Navigator.pop(context);
              } else {
                showSnackMessage(context, 'Erro ao alterar o registro...');
              }
            } else {
              int retorno = await SubGrupoApi.post(widget.subGrupo);
              if (retorno == 201) {
                lista.addSubGrupos(widget.subGrupo);
                Navigator.pop(context);
              } else {
                showSnackMessage(context, 'Erro ao inserir o registro...');
              }
            }
          }),
        );
      }),
    ];
  }
}
