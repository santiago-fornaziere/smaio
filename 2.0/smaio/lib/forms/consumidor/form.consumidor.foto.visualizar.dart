import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smaio/forms/consumidor/form.consumidor.fabricante.dart';
import 'package:smaio/models/model.foto.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/funcoes.dart';

// ignore: must_be_immutable
class ConsumidorFotoVisualizar extends StatefulWidget {
  Foto foto;
  String titulo;
  ConsumidorFotoVisualizar({
    required this.foto,
    required this.titulo,
  });
  @override
  _ConsumidorFotoVisualizar createState() => _ConsumidorFotoVisualizar();
}

class _ConsumidorFotoVisualizar extends State<ConsumidorFotoVisualizar> {
  // bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Sistema>(builder: (context, sistema, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.titulo),
          actions: [
            InkWell(
              onTap: () => push(context, ConsumidorFabricante()),
              child: Container(
                width: 80,
                child: Icon(
                  Icons.home,
                ),
              ),
            )
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: _body(),
      );
    });
  }

  _body() {
    return Center(
        child: Container(
      child: ListView(
        children: [
          Image.memory(
            base64Decode(widget.foto.fotFoto),
            fit: BoxFit.fill,
          )
        ],
      ),
    ));
  }
}
