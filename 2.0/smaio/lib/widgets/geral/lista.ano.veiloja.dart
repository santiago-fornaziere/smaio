import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.veiculoloja.dart';
import 'package:smaio/forms/veiculo.loja/alterar/form.alterar.veiculo.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/notifiers/notifier.veiloja.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/circularProgress.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class WidgetAnoListaVeiloja extends StatelessWidget {
  BuildContext context;
  String titulo;
  List<VeiAno> query;
  List<String> files;
  int loja;
  bool? showProgress = false;
  WidgetAnoListaVeiloja({
    required this.context,
    required this.titulo,
    required this.files,
    required this.query,
    required this.loja,
    this.showProgress,
  });

  @override
  Widget build(BuildContext context) {
    return !(showProgress ?? false)
        ? Container(
            child: Consumer<VeiLojas>(builder: (context, lista, child) {
              return !lista.showProgress
                  ? DataTable(
                      dataRowHeight: 60,
                      showCheckboxColumn: false,
                      showBottomBorder: true,
                      columns: [
                        DataColumn(
                          label: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            child: Center(
                              child: Text(
                                titulo,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      rows: query
                          .map(
                            (itens) => DataRow(
                              cells: [
                                DataCell(
                                  Center(
                                    child: Text(
                                      itens.vanoAnoDescricao.toString(),
                                      style: TextStyle(
                                          fontSize: fontSizePequeno,
                                          color: corTextoPadrao),
                                    ),
                                  ),
                                  onTap: () async {
                                    try {
                                      lista.setShowProgress(true);
                                      VeiculoLoja veiloja = new VeiculoLoja(
                                        vlojVanoId: itens.vanoId,
                                        vlojAnoDescricao:
                                            itens.vanoAnoDescricao,
                                        vlojVeiDescricao:
                                            itens.vanoVeiDescricao,
                                        vlojVeiFabNome: itens.vanoVeiFabNome,
                                        vlojLojId: loja,
                                      );

                                      VeiculoLoja retorno =
                                          await VeiculoLojaApi.post(veiloja);
                                      if (retorno.vlojId != null) {
                                        veiloja.vlojId = retorno.vlojId;
                                        lista.setVeiLojas([veiloja]);
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AlterarVeiculo(
                                                          veiloja: veiloja,
                                                          botaoVoltar: false,
                                                        )),
                                                (Route<dynamic> route) =>
                                                    false);
                                      } else {
                                        showSnackMessage(
                                            context, 'Erro ao gravar dados...');
                                        lista.setShowProgress(false);
                                      }
                                    } catch (e) {
                                      print(e);
                                      lista.setShowProgress(false);
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    )
                  : WidgetCircularProgress();
            }),
          )
        : WidgetCircularProgress();
  }
}
