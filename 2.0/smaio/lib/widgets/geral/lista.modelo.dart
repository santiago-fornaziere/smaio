import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.modelo.dart';
import 'package:smaio/models/model.modelo.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetModeloLista extends StatelessWidget {
  BuildContext context;
  List<Modelo> query;
  String fabricante;
  List<String> files;
  WidgetModeloLista({
    required this.context,
    required this.query,
    required this.fabricante,
    required this.files,
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
            tooltip: 'Escolha abaixo o Modelo',
            label: Container(
              child: Text(
                fabricante,
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
                        itens.modDescricao.toString(),
                        style: TextStyle(
                            fontSize: fontSizePequeno, color: corTextoPadrao),
                      ),
                    ),
                    onTap: () => onAvancar(
                      context,
                      files,
                      itens,
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
