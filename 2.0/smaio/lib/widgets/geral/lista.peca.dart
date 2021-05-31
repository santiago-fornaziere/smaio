import 'package:flutter/material.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetPecaLista extends StatelessWidget {
  BuildContext context;
  List<Peca> query;
  String titulo;
  VeiculoLoja veiloja;
  VoidCallback? onPressed;
  WidgetPecaLista({
    required this.context,
    required this.query,
    required this.titulo,
    required this.veiloja,
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
                  color: Theme.of(context).primaryColor,
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
                            fontSize: fontSizePequeno, color: corTextoPadrao),
                      ),
                    ),
                    onTap: onPressed,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
