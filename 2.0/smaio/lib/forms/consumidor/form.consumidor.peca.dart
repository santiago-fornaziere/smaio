import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/models/model.grupo.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/lista.peca.dart';

// ignore: must_be_immutable
class ConsumidorPeca extends StatefulWidget {
  VeiAno veiano;
  Grupo grupo;
  ConsumidorPeca({
    required this.veiano,
    required this.grupo,
  });
  @override
  _ConsumidorPeca createState() => _ConsumidorPeca();
}

class _ConsumidorPeca extends State<ConsumidorPeca> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecione a Peça desejada',
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: corTextoPadrao[1],
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _futureBuilder(),
    );
  }

  _futureBuilder() {
    Future<List<Peca>> future = PecaApi.getWhere(
        'pec_sit_reg = true and pec_gru_id = ${widget.grupo.gruId}',
        'pec_descricao');

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<Peca>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Não foi possível concluir esta ação!",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Peca> query = snapshot.data!;
        return _body(query);
      },
    );
  }

  _body(List<Peca> query) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            WidgetPecaLista(
              context: context,
              query: query,
              titulo:
                  '${widget.veiano.vanoVeiDescricao} > ${widget.veiano.vanoAnoDescricao} > ${widget.grupo.gruDescricao}',
              grupo: widget.grupo,
              veiano: widget.veiano,
            ),
          ],
        ),
      ),
    );
  }
}
