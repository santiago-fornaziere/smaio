import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.modelo.dart';
import 'package:smaio/models/model.modelo.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetModeloLista extends StatelessWidget {
  BuildContext context;
  List<Modelo> query;
  String fabricante;
  int tema;
  int origem;
  List<String> files;
  WidgetModeloLista({
    required this.context,
    required this.query,
    required this.fabricante,
    required this.files,
    required this.tema,
    required this.origem,
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
                  color: (tema == 0)
                      ? Theme.of(context).primaryColor
                      : Colors.white,
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
                            fontSize: fontSizePequeno,
                            fontWeight: FontWeight.bold,
                            color: corTextoPadrao[tema]),
                      ),
                    ),
                    onTap: () => (origem == 0)
                        ? onAvancar(
                            context,
                            files,
                            itens,
                          )
                        : onAvancarConsumidor(
                            context,
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
