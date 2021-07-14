import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.ano.dart';
import 'package:smaio/models/model.ano.dart';
import 'package:smaio/models/model.modelo.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/lista.ano.dart';

// ignore: must_be_immutable
class ConsumidorAno extends StatefulWidget {
  Modelo modelo;
  ConsumidorAno({
    required this.modelo,
  });
  @override
  _ConsumidorAno createState() => _ConsumidorAno();
}

class _ConsumidorAno extends State<ConsumidorAno> {
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
    Future<List<Ano>> future = AnoApi.getbyModelo(widget.modelo.modId!);

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<Ano>> snapshot) {
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
        List<Ano> query = snapshot.data!;
        return _body(query);
      },
    );
  }

  _body(List<Ano> query) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            WidgetAnoLista(
                context: context,
                query: query,
                modelo: widget.modelo,
                titulo:
                    '${widget.modelo.fabNome} > ${widget.modelo.modDescricao}'),
          ],
        ),
      ),
    );
  }
}
