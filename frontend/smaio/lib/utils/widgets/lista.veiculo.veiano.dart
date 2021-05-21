import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/notifiers/notifier.veicano.dart';
import 'package:smaio/pages/item/novo/form.item.novo.grupo.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/utils/widgets/circularProgress.dart';

// ignore: must_be_immutable
class WidgetVeiculoVeiAnoLista extends StatelessWidget {
  BuildContext context;
  WidgetVeiculoVeiAnoLista({
    required this.context,
  });

  @override
  Widget build(Object context) {
    return Container(
      child: Consumer<VeiAnos>(
        builder: (context, lista, child) {
          return !lista.showProgress
              ? DataTable(
                  dataRowHeight: 60,
                  showCheckboxColumn: false,
                  showBottomBorder: true,
                  columns: [
                    DataColumn(
                      label: Text("Veículos"),
                    ),
                  ],
                  rows: lista.veiAno
                      .map(
                        (itens) => DataRow(
                          cells: [
                            DataCell(
                              Container(
                                child: Center(
                                  child: Text(
                                    itens.vanoVeiDescricao.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                push(
                                    context,
                                    ItemNovoGrupoLocalizar(
                                      veiano: itens,
                                    ));
                              },
                            ),
                          ],
                        ),
                      )
                      .toList(),
                )
              : WidgetCircularProgress();
        },
      ),
    );
  }
}
