import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widgets/add.subgrupoveiano.dart';

// ignore: must_be_immutable
class VeiculoSubGrupoNovoVeiAno extends StatefulWidget {
  VeiAno veiano;
  VeiculoSubGrupoNovoVeiAno({
    required this.veiano,
  });
  @override
  State<StatefulWidget> createState() => _VeiculoSubGrupoNovoVeiAno();
}

class _VeiculoSubGrupoNovoVeiAno extends State<VeiculoSubGrupoNovoVeiAno> {
  final _formKey = GlobalKey<FormState>();

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
          formTitulo(
            "${widget.veiano.vanoVeiFabNome} / ${widget.veiano.vanoVeiDescricao.toString().toUpperCase()} - ${widget.veiano.vanoAnoDescricao}",
            Icons.ballot_outlined,
            MediaQuery.of(context).size.width,
          ),
          formCorpoCadastro(context, _formKey, _tela())
        ],
      ),
    );
  }

  List<Widget> _tela() {
    return <Widget>[
      WidgetAddSubGrupoVeiAno(
        context: context,
        codigo: _gruIdController,
        descricao: _gruDescricaoController,
        texto: 'Grupos',
        vanoId: widget.veiano.vanoId!,
      ),
    ];
  }
}
