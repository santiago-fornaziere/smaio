import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/models/model.subgrupoveiano.dart';
import 'package:smaio/notifiers/notifier.subgrupo.dart';
import 'package:smaio/utils/funcoes.dart';

// ignore: must_be_immutable
class WidgetSubGrupoAdd extends StatelessWidget {
  BuildContext context;
  int vanoId;
  WidgetSubGrupoAdd({
    required this.context,
    required this.vanoId,
  });

  bool _showProgress = false;

  @override
  Widget build(Object context) {
    return Container(
      child: Consumer<SubGrupos>(
        builder: (context, lista, child) {
          return DataTable(
            dataRowHeight: 60,
            showCheckboxColumn: true,
            showBottomBorder: true,
            columns: [
              DataColumn(
                label: Center(child: Text("Grupo")),
              ),
              DataColumn(
                label: Center(child: Text('Peça')),
              ),
              DataColumn(
                label: Center(child: Text('Subgrupo')),
              ),
              DataColumn(
                label: Container(
                  width: 25,
                  child: Center(
                    child: Text(''),
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
                              itens.sgruGruDescricao.toString(),
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
                              itens.sgruPecDescricao.toString(),
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
                              itens.sgruDescricao.toString(),
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          width: 25,
                          child: TextButton(
                            onPressed: !_showProgress
                                ? () async {
                                    _showProgress = true;
                                    int retorno =
                                        await PecaApi.postSGVano(SubGrupoVeiAno(
                                      sgvanoSgruId: itens.sgruId,
                                      sgvanoVanoId: vanoId,
                                    ));
                                    if (retorno == 201) {
                                      itens.selected = true;
                                      lista.removeSubGrupos(itens);
                                      _showProgress = false;
                                    } else {
                                      showSnackMessage(context,
                                          'Erro ao gravar registro...');
                                      _showProgress = false;
                                    }
                                  }
                                : null,
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.green,
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
}
