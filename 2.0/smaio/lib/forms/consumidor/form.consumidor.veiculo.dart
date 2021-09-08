import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.veiculo.dart';
import 'package:smaio/models/model.modelo.dart';
import 'package:smaio/models/model.veiculo.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/lista.veiculo.dart';

// ignore: must_be_immutable
class ConsumidorVeiculo extends StatefulWidget {
  Modelo modelo;
  ConsumidorVeiculo({
    required this.modelo,
  });
  @override
  _ConsumidorVeiculo createState() => _ConsumidorVeiculo();
}

class _ConsumidorVeiculo extends State<ConsumidorVeiculo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Veículo',
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
      floatingActionButton: TextButton(
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(
              const Radius.circular(50.0),
            ),
          ),
          child: Center(
            child: Text(
              'Todos >>',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onPressed: () => onAvancarTodos(context, widget.modelo),
      ),
    );
  }

  _futureBuilder() {
    Future<List<Veiculo>> future = VeiculoApi.getAll(widget.modelo.modId!);

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<Veiculo>> snapshot) {
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
        List<Veiculo> query = snapshot.data!;
        return _body(query);
      },
    );
  }

  _body(List<Veiculo> query) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            WidgetVeiculoLista(
              context: context,
              query: query,
              files: [],
              tema: 1,
              origem: 1,
              titulo:
                  '${widget.modelo.fabNome} > ${widget.modelo.modDescricao.toString()}',
            ),
          ],
        ),
      ),
    );
  }
}
