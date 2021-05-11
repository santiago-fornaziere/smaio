import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/notifiers/notifier.subgrupoveiano.dart';
import 'package:smaio/utils/funcoes.dart';

// ignore: must_be_immutable
class WidgetSubGrupoVeiAnoLista extends StatelessWidget {
  BuildContext context;
  WidgetSubGrupoVeiAnoLista({
    required this.context,
  });

  bool _showProgress = false;

  @override
  Widget build(Object context) {
    return Container(
      child: Consumer<SubGrupoVeiAnos>(
        builder: (context, lista, child) {
          return DataTable(
            dataRowHeight: 60,
            showCheckboxColumn: false,
            columns: [
              DataColumn(
                label: Center(
                  child: Text("Grupo"),
                ),
              ),
              DataColumn(
                label: Center(child: Text('Peça')),
              ),
              DataColumn(
                label: Center(child: Text('SubGrupo')),
              ),
              DataColumn(
                label: Container(
                  width: 25,
                  child: Text(''),
                ),
              ),
            ],
            rows: lista.subGrupoveiAno
                .map(
                  (itens) => DataRow(
                    cells: [
                      DataCell(
                        Container(
                          child: Center(
                            child: Text(
                              itens.sgvanoGruDescricao.toString(),
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          child: Center(
                            child: Text(
                              itens.sgvanoPecDescricao.toString(),
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          child: Center(
                            child: Text(
                              itens.sgvanoSgruDescricao.toString(),
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          child: Row(
                            children: [
// botao excluir
                              Container(
                                width: 25,
                                child: TextButton(
                                  onPressed: !_showProgress
                                      ? () async {
                                          _showProgress = true;
                                          int retorno =
                                              await PecaApi.deleteSGVano(
                                                  itens.sgvanoId!);
                                          if (retorno == 201) {
                                            lista.removeVeiAnos(itens);
                                            _showProgress = false;
                                          } else {
                                            showSnackMessage(context,
                                                'Erro ao excluir o registro...');
                                            _showProgress = false;
                                          }
                                        }
                                      : null,
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
