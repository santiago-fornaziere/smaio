import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/controllers/controller.veiano.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/models/model.veiculo.dart';
import 'package:smaio/notifiers/notifier.veiculo.dart';
import 'package:smaio/notifiers/notifier.veicano.dart';
import 'package:smaio/pages/veiculo/form.veiculo.alterar.dart';
import 'package:smaio/pages/veiculo/form.veiculo.veiano.dart';
import 'package:smaio/utils/funcoes.dart';

// ignore: must_be_immutable
class WidgetVeiculoLista extends StatelessWidget {
  BuildContext context;
  WidgetVeiculoLista({
    required this.context,
  });

  @override
  Widget build(Object context) {
    return Container(
      child: Consumer<Veiculos>(
        builder: (context, lista, child) {
          lista.veiculos.removeWhere((pec) => pec.veiSitReg == false);
          return DataTable(
            dataRowHeight: 60,
            showCheckboxColumn: false,
            columns: [
              DataColumn(
                label: Text("Veículo"),
              ),
              DataColumn(
                label: Text("Fabricante"),
              ),
              DataColumn(
                label: Text("Opções"),
              )
            ],
            rows: lista.veiculos
                .map(
                  (itens) => DataRow(
                    cells: [
                      DataCell(
                        Container(
                          child: Center(
                            child: Text(
                              itens.veiDescricao.toString(),
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
                              itens.fabNome.toString(),
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
                            child: Consumer<VeiAnos>(
                                builder: (context, veianos, child) {
                              return Row(
                                children: [
// BOTAO EDITAR
                                  TextButton(
                                    onPressed: () async {
                                      List<VeiAno> retorno =
                                          await VeiAnoApi.getByWhere(
                                              'vano_vei_id = ${itens.veiId}',
                                              'vano_ano_id');
                                      veianos.setVeiAnos(retorno);
                                      onPressed(itens);
                                    },
                                    child: Icon(
                                      Icons.account_balance_wallet,
                                      color: Colors.green,
                                    ),
                                  ),
// BOTAO VEIANO
                                  TextButton(
                                    onPressed: () async {
                                      List<VeiAno> retorno =
                                          await VeiAnoApi.getByWhere(
                                              'vano_vei_id = ${itens.veiId}',
                                              'vano_ano_id');
                                      veianos.setVeiAnos(retorno);
                                      push(
                                        context,
                                        VeiculoVeiAno(veiculo: itens),
                                      );
                                    },
                                    child: Icon(
                                      Icons.ballot_outlined,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              );
                            }),
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

  onPressed(Veiculo veiculo) {
    push(context, VeiculoAlterar(veiculo: veiculo));
  }
}
