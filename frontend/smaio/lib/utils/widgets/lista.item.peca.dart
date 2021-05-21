import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/models/model.subgrupoveiano.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/notifiers/notifier.peca.dart';
import 'package:smaio/notifiers/notifier.subgrupoveiano.dart';
import 'package:smaio/pages/item/novo/form.item.novo.subgrupoveiano.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/utils/widgets/circularProgress.dart';

// ignore: must_be_immutable
class WidgetItemPecaLista extends StatelessWidget {
  BuildContext context;
  VeiAno veiano;
  WidgetItemPecaLista({
    required this.context,
    required this.veiano,
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
                  ],
                  rows: lista.pecas
                      .map(
                        (itens) => DataRow(
                          cells: [
                            DataCell(
                              Container(
                                child: Center(child: Consumer<SubGrupoVeiAnos>(
                                  builder: (context, lista, child) {
                                    return TextButton(
                                      onPressed: () async {
                                        lista.setShowProgress(true);
                                        onPressed(itens);
                                        List<SubGrupoVeiAno> retorno =
                                            await PecaApi.getSGVanoWhere(
                                                ' sgvano_pec_id = ${itens.pecId} and sgvano_vano_id = ${veiano.vanoId}',
                                                'sgvano_gru_descricao, sgvano_pec_descricao');
                                        lista.setSubGrupoVeiAnos(retorno);
                                      },
                                      child: SafeArea(
                                        child: Container(
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

  onPressed(Peca peca) {
    push(
        context,
        ItemNovoSubGrupoLocalizar(
          veiano: veiano,
          peca: peca,
        ));
  }
}
