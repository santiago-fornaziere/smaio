import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetGrupoConsumidorLista extends StatelessWidget {
  BuildContext context;
  VeiAno veiano;
  WidgetGrupoConsumidorLista({
    required this.context,
    required this.veiano,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: DataTable(
        dataRowHeight: 60,
        showCheckboxColumn: false,
        showBottomBorder: true,
        columns: [
          DataColumn(
            label: Container(
              child: Text(
                '${veiano.vanoVeiFabNome} > ${veiano.vanoVeiDescricao} > ${veiano.vanoAnoDescricao}',
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
        rows: dicGrupo
            .map(
              (itens) => DataRow(
                cells: [
                  DataCell(
                    Center(
                      child: Text(
                        itens.gruDescricao.toString(),
                        style: TextStyle(
                            fontSize: fontSizePequeno,
                            fontWeight: FontWeight.bold,
                            color: corTextoPadrao[1]),
                      ),
                    ),
                    onTap: () =>
                        onAvancarGrupoConsumidor(context, itens, veiano),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
