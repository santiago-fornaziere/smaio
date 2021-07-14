import 'package:flutter/material.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/lista.grupo.consumidor.dart';

// ignore: must_be_immutable
class ConsumidorGrupo extends StatefulWidget {
  VeiAno veiano;
  ConsumidorGrupo({
    required this.veiano,
  });
  @override
  _ConsumidorGrupo createState() => _ConsumidorGrupo();
}

class _ConsumidorGrupo extends State<ConsumidorGrupo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecione o que você Busca',
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
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            WidgetGrupoConsumidorLista(
              context: context,
              veiano: widget.veiano,
            ),
          ],
        ),
      ),
    );
  }
}
