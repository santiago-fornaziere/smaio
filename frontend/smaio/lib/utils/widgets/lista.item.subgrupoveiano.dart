import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/notifiers/notifier.subgrupoveiano.dart';
import 'package:smaio/pages/item/novo/form.item.novo.formulario.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/utils/widgets/circularProgress.dart';

// ignore: must_be_immutable
class WidgetItemSubGrupoVeiAnoLista extends StatelessWidget {
  BuildContext context;
  WidgetItemSubGrupoVeiAnoLista({
    required this.context,
  });

  @override
  Widget build(Object context) {
    return Container(
      child: Consumer<SubGrupoVeiAnos>(
        builder: (context, lista, child) {
          return !lista.showProgress
              ? DataTable(
                  dataRowHeight: 60,
                  showBottomBorder: true,
                  showCheckboxColumn: false,
                  columns: [
                    DataColumn(
                      label: SafeArea(
                        child: Container(
                          child: Text(
                            'Peça - Subgrupo',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: lista.subGrupoveiAno
                      .map(
                        (itens) => DataRow(
                          cells: [
                            DataCell(
                              Container(
                                child: Center(child: Consumer<SubGrupoVeiAnos>(
                                  builder: (context, lista, child) {
                                    return TextButton(
                                      onPressed: () async {
                                        push(
                                            context,
                                            ItemNovoFormularioLocalizar(
                                              sgvano: itens,
                                            ),
                                            replace: true);
                                      },
                                      child: SafeArea(
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              itens.sgvanoSgruDescricao
                                                  .toString(),
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
                )
              : WidgetCircularProgress();
        },
      ),
    );
  }
}
