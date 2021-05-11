import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/controllers/controller.subgrupo.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/models/model.subgrupo.dart';
import 'package:smaio/notifiers/notifier.peca.dart';
import 'package:smaio/notifiers/notifier.subgrupo.dart';
import 'package:smaio/pages/peca/form.peca.alterar.dart';
import 'package:smaio/utils/funcoes.dart';

// ignore: must_be_immutable
class WidgetPecaLista extends StatelessWidget {
  BuildContext context;
  WidgetPecaLista({
    required this.context,
  });

  @override
  Widget build(Object context) {
    return Container(
      child: Consumer<Pecas>(
        builder: (context, lista, child) {
          lista.pecas.removeWhere((pec) => pec.pecSitReg == false);
          return DataTable(
            dataRowHeight: 60,
            showCheckboxColumn: false,
            columns: [
              DataColumn(
                label: Text("Peça"),
              ),
              DataColumn(
                label: Text("Grupo"),
              ),
              DataColumn(
                label: Text("Opções"),
              )
            ],
            rows: lista.pecas
                .map(
                  (itens) => DataRow(
                    cells: [
                      DataCell(
                        Container(
                          child: Center(
                            child: Text(
                              itens.pecDescricao.toString(),
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
                            child: Text(
                              itens.pecGruDescricao.toString(),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Row(
                            children: [
// BOTAO EDITAR
                              Consumer<SubGrupos>(
                                  builder: (context, subgrupos, child) {
                                return Container(
                                  width: 25,
                                  child: TextButton(
                                    onPressed: () async {
                                      List<SubGrupo> retorno =
                                          await SubGrupoApi.getByPeca(
                                              itens.pecId!);
                                      subgrupos.setSubGrupos(retorno);
                                      onPressed(itens);
                                    },
                                    child: Icon(
                                      Icons.account_balance_wallet,
                                      color: Colors.green,
                                    ),
                                  ),
                                );
                              }),
// BOTAO EXCLUIR
                              Container(
                                width: 25,
                                child: TextButton(
                                  onPressed: () async {
                                    itens.pecSitReg = false;
                                    int retorno = await PecaApi.put(itens);
                                    if (retorno == 202) {
                                      lista.removePecas(itens);
                                    } else {
                                      showSnackMessage(
                                          context, 'Erro ao excluir peça...');
                                    }
                                  },
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
                              )
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

  onPressed(Peca peca) {
    push(context, PecaAlterar(peca: peca));
  }
}
