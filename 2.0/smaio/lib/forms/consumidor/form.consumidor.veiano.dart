import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.veiano.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/models/model.veiculo.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/lista.ano.veiculo.dart';

// ignore: must_be_immutable
class ConsumidorVeiAno extends StatefulWidget {
  Veiculo veiculo;
  ConsumidorVeiAno({
    required this.veiculo,
  });
  @override
  _ConsumidorVeiAno createState() => _ConsumidorVeiAno();
}

class _ConsumidorVeiAno extends State<ConsumidorVeiAno> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ano',
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontSize: 25,
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
    Future<List<VeiAno>> future = VeiAnoApi.getByWhere(
        'vano_vei_id = ${widget.veiculo.veiId}', 'vano_ano_descricao');

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<VeiAno>> snapshot) {
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
        List<VeiAno> query = snapshot.data!;
        return _body(query);
      },
    );
  }

  _body(List<VeiAno> query) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            WidgetVeiAnoLista(
                context: context,
                query: query,
                tema: 1,
                origem: 1,
                titulo:
                    '${widget.veiculo.fabNome} > ${widget.veiculo.veiDescricao}'),
          ],
        ),
      ),
    );
  }
}
