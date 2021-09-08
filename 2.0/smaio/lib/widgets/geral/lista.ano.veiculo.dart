import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.veiano.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetVeiAnoLista extends StatelessWidget {
  BuildContext context;
  List<VeiAno> query;
  String titulo;
  int tema;
  int origem;
  WidgetVeiAnoLista({
    required this.context,
    required this.query,
    required this.titulo,
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
            tooltip: 'Escolha abaixo o Ano do Veículo',
            label: Container(
              child: Text(
                titulo,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 15,
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
                        itens.vanoAnoDescricao.toString(),
                        style: TextStyle(
                            fontSize: fontSizePequeno,
                            fontWeight: FontWeight.bold,
                            color: corTextoPadrao[tema]),
                      ),
                    ),
                    onTap: () => onAvancarConsumidor(
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
