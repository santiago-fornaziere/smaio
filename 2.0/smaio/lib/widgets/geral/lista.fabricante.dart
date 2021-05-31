import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fabricante.dart';
import 'package:smaio/models/model.fabricante.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetFabricanteLista extends StatelessWidget {
  BuildContext context;
  List<Fabricante> query;
  List<String> files;
  WidgetFabricanteLista({
    required this.context,
    required this.query,
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
            label: Container(
              child: Text(
                '',
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
                        itens.fabNome.toString(),
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
