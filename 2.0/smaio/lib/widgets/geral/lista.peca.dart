import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/models/model.grupo.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetPecaLista extends StatelessWidget {
  BuildContext context;
  List<Peca> query;
  String titulo;
  VeiAno veiano;
  Grupo grupo;
  VoidCallback? onPressed;
  WidgetPecaLista({
    required this.context,
    required this.query,
    required this.titulo,
    required this.veiano,
    required this.grupo,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTable(
        dataRowHeight: 60,
        showCheckboxColumn: false,
        showBottomBorder: true,
        columns: [
          DataColumn(
            tooltip: 'Clique sobre a peça',
            label: Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Text(
                titulo,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        rows: query
            .map(
              (itens) => DataRow(
                cells: [
                  DataCell(
                    Center(
                      child: Text(
                        itens.pecDescricao.toString(),
                        style: TextStyle(
                          fontSize: fontSizePequeno,
                          color: corTextoPadrao[1],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () => onAvancarPecaConsumidor(
                      context,
                      itens,
                      veiano,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
