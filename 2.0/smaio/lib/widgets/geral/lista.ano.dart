import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.ano.dart';
import 'package:smaio/models/model.ano.dart';
import 'package:smaio/models/model.modelo.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetAnoLista extends StatelessWidget {
  BuildContext context;
  List<Ano> query;
  Modelo modelo;
  String titulo;
  WidgetAnoLista({
    required this.context,
    required this.query,
    required this.titulo,
    required this.modelo,
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
                        itens.anoDescricao.toString(),
                        style: TextStyle(
                            fontSize: fontSizePequeno,
                            fontWeight: FontWeight.bold,
                            color: corTextoPadrao[1]),
                      ),
                    ),
                    onTap: () => onAvancar(context, itens, modelo),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
