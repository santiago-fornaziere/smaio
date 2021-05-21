import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/controllers/controller.item.dart';
import 'package:smaio/controllers/controller.subgrupo.dart';
import 'package:smaio/models/model.item.dart';
import 'package:smaio/models/model.subgrupo.dart';
import 'package:smaio/notifiers/notifier.item.dart';
import 'package:smaio/notifiers/notifier.subgrupo.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/widgets/circularProgress.dart';

// ignore: must_be_immutable
class WidgetItemLista extends StatelessWidget {
  BuildContext context;
  WidgetItemLista({
    required this.context,
  });

  @override
  Widget build(Object context) {
    return Container(
      child: Consumer<Itens>(
        builder: (context, lista, child) {
          lista.itens.removeWhere((pec) => pec.iteSitReg == false);
          return !lista.showProgress
              ? DataTable(
                  dataRowHeight: 60,
                  showCheckboxColumn: false,
                  showBottomBorder: true,
                  columns: [
                    DataColumn(
                      label: Text("Itens"),
                    ),
                    DataColumn(
                      label: Text("Ações"),
                    )
                  ],
                  rows: lista.itens
                      .map(
                        (itens) => DataRow(
                          cells: [
                            DataCell(
                              Row(
                                children: [
                                      icone(itens.iteStatus),
                                      descricao(itens),
                                ],
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
                                                    itens.iteId!);
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
                                          itens.iteSitReg = false;
                                          int retorno =
                                              await ItemApi.put(itens);
                                          print(retorno);
                                          if (retorno == 201) {
                                            lista.removeItens(itens);
                                          } else {
                                            showSnackMessage(context,
                                                'Erro ao excluir o item...');
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

  onPressed(Item value) {}

  Icon icone(String? iteStatus) {
    if (iteStatus == 'Á venda') {
      return Icon(
        Icons.attach_money,
        color: Colors.green,
        size: 25,
      );
    } else {
      return Icon(
        Icons.beenhere_rounded,
        color: Colors.blueGrey,
        size: 25,
      );
    }
  }

  Column descricao(Item itens) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          itens.iteDescricao.toString(),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        Flexible(
          child: Text(
            '${itens.itePecDescricao.toString()} \n${itens.iteSgruDescricao.toString()}',
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        ),
        Text(
          'R\$ ${formatFloat.format(itens.iteValor ?? 0)}',
          style: TextStyle(
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
