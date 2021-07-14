import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/models/model.peca.veiloja.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/notifiers/notifier.peca.veiloja.dart';
import 'package:smaio/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:smaio/widgets/geral/circularProgress.dart';

// ignore: must_be_immutable
class WidgetGrupoLista extends StatelessWidget {
  BuildContext context;
  VeiculoLoja veiloja;
  WidgetGrupoLista({
    required this.context,
    required this.veiloja,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: Consumer<PecaVeiLojas>(builder: (context, lista, child) {
        return !lista.showProgress
            ? DataTable(
                dataRowHeight: 60,
                showCheckboxColumn: false,
                showBottomBorder: true,
                columns: [
                  DataColumn(
                    label: Container(
                      child: Text(
                        '\ ${veiloja.vlojVeiFabNome} \ ${veiloja.vlojVeiDescricao} - ${veiloja.vlojAnoDescricao}',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                rows: dicGrupo
                    .map(
                      (itens) => DataRow(
                        cells: [
                          DataCell(
                              Center(
                                child: Text(
                                  itens.gruDescricao.toString(),
                                  style: TextStyle(
                                      fontSize: fontSizePequeno,
                                      color: corTextoPadrao[0]),
                                ),
                              ), onTap: () async {
                            lista.setShowProgress(true);
                            List<PecaVeiLoja> retorno =
                                await PecaVeiLojaApi.getWhere(
                                    'pec_gru_id = ${itens.gruId}',
                                    'pec_descricao',
                                    veiloja.vlojId!);
                            lista.setPecas(retorno);
                            onAvancarGrupo(
                              context,
                              veiloja,
                              itens,
                            );
                          }),
                        ],
                      ),
                    )
                    .toList(),
              )
            : WidgetCircularProgress();
      }),
    );
  }
}
