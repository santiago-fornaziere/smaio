import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smaio/models/model.foto.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:provider/provider.dart';
import 'package:smaio/widgets/geral/bottonNavigationBarExcluir.dart';

// ignore: must_be_immutable
class AlterarVeiculoVisualizarFoto extends StatefulWidget {
  Foto foto;
  AlterarVeiculoVisualizarFoto({
    required this.foto,
  });
  @override
  _AlterarVeiculoVisualizarFoto createState() =>
      _AlterarVeiculoVisualizarFoto();
}

class _AlterarVeiculoVisualizarFoto
    extends State<AlterarVeiculoVisualizarFoto> {
  // bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Sistema>(builder: (context, sistema, child) {
      return Scaffold(
        appBar: WidgetAppBarTransparente(
          titulo:
              '${sistema.loja!.lojNome.toString()} \n${sistema.usuario!.usuEmail.toString()}',
          mostraIcone: false,
        ),
//      backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: corTemaDark,
        body: _body(),
        bottomNavigationBar: WidgetBottonNavigatorBarExcluir(
          context: context,
          foto: widget.foto,
        ),
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
