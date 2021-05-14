import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/controllers/controller.veiano.dart';
import 'package:smaio/models/model.subgrupoveiano.dart';
import 'package:smaio/notifiers/notifier.subgrupoveiano.dart';
import 'package:smaio/notifiers/notifier.veicano.dart';
import 'package:smaio/pages/veiculo/form.veiculo.veiano.subgrupo.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/utils/widgets/add.veiano.dart';

// ignore: must_be_immutable
class WidgetVeiculoAnoLista extends StatelessWidget {
  BuildContext context;
  int veiId;
  bool permiteExcluir;
  bool alteraSubGrupo;
  WidgetVeiculoAnoLista({
    required this.context,
    required this.veiId,
    required this.permiteExcluir,
    required this.alteraSubGrupo,
  });

  @override
  Widget build(Object context) {
    return Container(
      child: Consumer<VeiAnos>(
        builder: (context, lista, child) {
          return DataTable(
            dataRowHeight: 60,
            showCheckboxColumn: false,
            showBottomBorder: true,
            columns: [
              DataColumn(
                label: Text("Ano"),
              ),
              DataColumn(
                label: WidgetAddVeiAno(
                  context: context,
                  veiId: veiId,
                ),
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
                              itens.vanoAnoDescricao.toString(),
                              style: TextStyle(
                                fontSize: 14,
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
                                child: permiteExcluir
                                    ? Center(
                                        child: TextButton(
                                          onPressed: () async {
                                            int retorno =
                                                await VeiAnoApi.delete(
                                                    itens.vanoId!);
                                            if (retorno == 201) {
                                              lista.removeVeiAnos(itens);
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
                                      )
                                    : null,
                              ),
// botao Subgrupo
                              Container(
                                child: alteraSubGrupo
                                    ? Center(child: Consumer<SubGrupoVeiAnos>(
                                        builder: (context, sgvano, child) {
                                        return TextButton(
                                          onPressed: ((itens.vanoId ?? 0) > 0)
                                              ? () async {
                                                  sgvano.setShowProgress(true);
                                                  List<SubGrupoVeiAno> retorno =
                                                      await PecaApi.getByVeiAno(
                                                          itens.vanoId!);
                                                  sgvano.setSubGrupoVeiAnos(
                                                      retorno);
                                                  push(
                                                      context,
                                                      VeiculoSubGrupoVeiAno(
                                                          veiano: itens));
                                                }
                                              : null,
                                          child: Icon(
                                            Icons.ballot_outlined,
                                            color: Colors.green,
                                          ),
                                        );
                                      }))
                                    : null,
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
}
