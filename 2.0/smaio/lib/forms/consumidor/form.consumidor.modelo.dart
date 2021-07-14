import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.modelo.dart';
import 'package:smaio/models/model.fabricante.dart';
import 'package:smaio/models/model.modelo.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/lista.modelo.dart';

// ignore: must_be_immutable
class ConsumidorModelo extends StatefulWidget {
  Fabricante fabricante;
  ConsumidorModelo({
    required this.fabricante,
  });
  @override
  _ConsumidorModelo createState() => _ConsumidorModelo();
}

class _ConsumidorModelo extends State<ConsumidorModelo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Modelo',
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
    Future<List<Modelo>> future = ModeloApi.getAll(widget.fabricante.fabId!);

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<Modelo>> snapshot) {
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
        List<Modelo> query = snapshot.data!;
        return _body(query);
      },
    );
  }

  _body(List<Modelo> query) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            WidgetModeloLista(
              context: context,
              query: query,
              files: [],
              tema: 1,
              origem: 1,
              fabricante: widget.fabricante.fabNome.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
