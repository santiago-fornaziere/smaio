import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.veiculo.dart';
import 'package:smaio/models/model.veiculo.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetVeiculoLista extends StatelessWidget {
  BuildContext context;
  List<Veiculo> query;
  String titulo;
  List<String> files;
  WidgetVeiculoLista({
    required this.context,
    required this.query,
    required this.titulo,
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
            tooltip: 'Escolha abaixo o Veículo',
            label: Container(
              child: Text(
                titulo,
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
                        itens.veiDescricao.toString(),
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
