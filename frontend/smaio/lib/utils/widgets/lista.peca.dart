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
import 'package:smaio/utils/widgets/circularProgress.dart';

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
          return !lista.showProgress
              ? DataTable(
                  dataRowHeight: 60,
                  showCheckboxColumn: false,
                  showBottomBorder: true,
                  columns: [
                    DataColumn(
                      label: Text("Peças"),
                    ),
                    DataColumn(
                      label: Text("Ações"),
                    )
                  ],
                  rows: lista.pecas
                      .map(
                        (itens) => DataRow(
                          cells: [
                            DataCell(
                              Text(
                                itens.pecDescricao.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
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
                                      child: TextButton(
                                        onPressed: () async {
                                          itens.pecSitReg = false;
                                          int retorno =
                                              await PecaApi.put(itens);
                                          if (retorno == 202) {
                                            lista.removePecas(itens);
                                          } else {
                                            showSnackMessage(context,
                                                'Erro ao excluir peça...');
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
                )
              : WidgetCircularProgress();
        },
      ),
    );
  }

  onPressed(Peca peca) {
    push(context, PecaAlterar(peca: peca));
  }
}
