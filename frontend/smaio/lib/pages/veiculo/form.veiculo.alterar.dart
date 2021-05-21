import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/controllers/controller.veiculo.dart';
import 'package:smaio/models/model.veiculo.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/pages/veiculo/form.veiculo.localizar.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/utils/widget.botao.gravar.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widgets/combo.fabricante.dart';
import 'package:smaio/utils/widgets/edit.texto.dart';
import 'package:smaio/utils/widgets/lista.veiano.dart';

// ignore: must_be_immutable
class VeiculoAlterar extends StatefulWidget {
  Veiculo veiculo;
  VeiculoAlterar({
    required this.veiculo,
  });
  @override
  State<StatefulWidget> createState() => _VeiculoAlterar();
}

class _VeiculoAlterar extends State<VeiculoAlterar> {
  final _formKey = GlobalKey<FormState>();
  final _focus = FocusNode();

  final _veiIdController = TextEditingController();
  final _veiDescricaoController = TextEditingController();
  final _fabIdController = TextEditingController();
  final _fabNomeController = TextEditingController();

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
            "ALTERAR VEÍCULOS",
            Icons.car_repair,
            MediaQuery.of(context).size.width,
          ),
          formCorpoCadastro(context, _formKey, _tela())
        ],
      ),
    );
  }

  List<Widget> _tela() {
    _veiIdController.text = widget.veiculo.veiId.toString();
    _veiDescricaoController.text = widget.veiculo.veiDescricao.toString();
    _fabIdController.text = widget.veiculo.veiFabId.toString();
    _fabNomeController.text = widget.veiculo.fabNome.toString();
    return <Widget>[
      WidgetEditTexto(
        context: context,
        descricao: _veiIdController,
        texto: 'ID',
        autofocos: false,
        enabled: false,
      ),
      WidgetEditTexto(
        context: context,
        descricao: _veiDescricaoController,
        texto: 'Veículo',
        autofocos: true,
        focusNode: _focus,
      ),
      WidgetComboFabricante(
        context: context,
        descricao: _fabNomeController,
        texto: 'Alterar o Fabricante',
        codigo: _fabIdController,
      ),
      Container(
        padding: EdgeInsets.all(20),
        child: BotaoGravar(onPressed: () => onPressed()),
      ),
      Divider(),
      WidgetVeiculoAnoLista(
        context: context,
        veiId: widget.veiculo.veiId!,
        permiteExcluir: true,
        alteraSubGrupo: false,
      ),
    ];
  }

  onPressed() async {
    widget.veiculo.veiId = int.parse(_veiIdController.text);
    widget.veiculo.veiDescricao = _veiDescricaoController.text;
    widget.veiculo.veiFabId = int.parse(_fabIdController.text);
    widget.veiculo.fabNome = _fabNomeController.text;
    int retorno = await VeiculoApi.put(widget.veiculo);
    if (retorno == 202) {
      push(context, VeiculoLocalizar());
    } else {
      showSnackMessage(context, 'Erro ao alterar o registro...');
    }
  }
}
