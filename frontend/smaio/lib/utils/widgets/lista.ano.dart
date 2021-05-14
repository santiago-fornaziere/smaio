import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fabricante.dart';
import 'package:smaio/models/model.ano.dart';
import 'package:smaio/models/model.fabricante.dart';
import 'package:smaio/notifiers/notifier.fabricante.dart';
import 'package:smaio/pages/item/novo/form.item.novo.fabricante.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class WidgetAnoLista extends StatelessWidget {
  BuildContext context;
  WidgetAnoLista({
    required this.context,
  });

  @override
  Widget build(Object context) {
    return Container(
      child: DataTable(
        dataRowHeight: 60,
        showCheckboxColumn: false,
        showBottomBorder: true,
        columns: [
          DataColumn(
            label: Center(child: Text("Selecio o ano")),
          ),
        ],
        rows: dicAno
            .map(
              (itens) => DataRow(
                cells: [
                  DataCell(
                    Container(
                      child: Center(child: Consumer<Fabricantes>(
                        builder: (context, lista, child) {
                          return TextButton(
                            onPressed: () async {
                              lista.setShowProgress(true);
                              onPressed(itens);
                              List<Fabricante> retorno =
                                  await FabricanteApi.getAll();
                              lista.setFabricantes(retorno);
                            },
                            child: SafeArea(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    itens.anoDescricao.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  onPressed(Ano ano) {
    push(context, ItemNovoFabricanteLocalizar(ano: ano));
  }
}
