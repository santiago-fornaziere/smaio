import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/models/model.veiculo.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widgets/lista.veiano.dart';

// ignore: must_be_immutable
class VeiculoVeiAno extends StatefulWidget {
  Veiculo veiculo;
  VeiculoVeiAno({
    required this.veiculo,
  });
  @override
  State<StatefulWidget> createState() => _VeiculoVeiAno();
}

class _VeiculoVeiAno extends State<VeiculoVeiAno> {
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
            "${widget.veiculo.fabNome} / ${widget.veiculo.veiDescricao.toString().toUpperCase()}",
            Icons.ballot_outlined,
            MediaQuery.of(context).size.width,
          ),
          formCorpoCadastro(context, null, _tela())
        ],
      ),
    );
  }

  List<Widget> _tela() {
    return <Widget>[
      WidgetVeiculoAnoLista(
        context: context,
        veiId: widget.veiculo.veiId!,
        permiteExcluir: false,
        alteraSubGrupo: true,
      ),
    ];
  }
}
