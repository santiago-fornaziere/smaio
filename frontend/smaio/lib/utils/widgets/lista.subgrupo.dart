import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/controllers/controller.subgrupo.dart';
import 'package:smaio/models/model.subgrupo.dart';
import 'package:smaio/notifiers/notifier.subgrupo.dart';
import 'package:smaio/pages/peca/form.subgrupo.dart';
import 'package:smaio/utils/funcoes.dart';

// ignore: must_be_immutable
class WidgetSubGrupoLista extends StatelessWidget {
  BuildContext context;
  int pecId;
  WidgetSubGrupoLista({
    required this.context,
    required this.pecId,
  });

  @override
  Widget build(Object context) {
    return Container(
      child: Consumer<SubGrupos>(
        builder: (context, lista, child) {
          lista.subGrupo.removeWhere((pec) => pec.sgruSitReg == false);
          return DataTable(
            dataRowHeight: 60,
            showCheckboxColumn: false,
            columns: [
              DataColumn(
                label: Text("Subgrupo"),
              ),
              DataColumn(
                label: TextButton(
                  onPressed: () {
                    push(
                        context,
                        SubGrupoAlterar(
                            subGrupo: SubGrupo(
                              sgruPecId: pecId,
                              sgruSitReg: true,
                            ),
                            subGrupoIndice: lista.getIndice(-1)));
                  },
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
            rows: lista.subGrupo
                .map(
                  (itens) => DataRow(
                    cells: [
                      DataCell(
                        Container(
                          child: Center(
                            child: Text(
                              itens.sgruDescricao.toString(),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          child: Center(
                            child: Row(
                              children: [
// BOTAO EDITAR
                                Container(
                                  width: 25,
                                  child: TextButton(
                                    onPressed: () async {
                                      push(
                                          context,
                                          SubGrupoAlterar(
                                              subGrupo: itens,
                                              subGrupoIndice: lista
                                                  .getIndice(itens.sgruId!)));
                                    },
                                    child: Icon(
                                      Icons.account_balance_wallet,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
// BOTAO EXCLUIR
                                Container(
                                  width: 25,
                                  child: TextButton(
                                    onPressed: () async {
                                      itens.sgruSitReg = false;
                                      int retorno =
                                          await SubGrupoApi.put(itens);
                                      if (retorno == 202) {
                                        lista.removeSubGrupos(itens);
                                      } else {
                                        showSnackMessage(context,
                                            'Erro ao excluir o registro...');
                                      }
                                    },
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

  onClikVeiAno(int veiId) {}
}
