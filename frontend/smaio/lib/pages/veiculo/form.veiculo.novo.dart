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

// ignore: must_be_immutable
class VeiculoNovo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VeiculoNovo();
}

class _VeiculoNovo extends State<VeiculoNovo> {
  final _formKey = GlobalKey<FormState>();
  final _focus = FocusNode();

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
            "NOVO VEÍCULO",
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
        texto: 'Selecione o Fabricante',
        codigo: _fabIdController,
      ),
      Container(
        padding: EdgeInsets.all(20),
        child: BotaoGravar(onPressed: () => onPressed()),
      )
    ];
  }

  onPressed() async {
    var novo = Veiculo(
      veiDescricao: _veiDescricaoController.text,
      veiFabId: int.parse(_fabIdController.text),
      fabNome: _fabNomeController.text,
      veiSitReg: true,
    );
    int retorno = await VeiculoApi.post(novo);
    if (retorno == 201) {
      push(context, VeiculoLocalizar());
    } else {
      showSnackMessage(context, 'Erro ao inserir novo veículo...');
    }
  }
}
