import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/models/model.subgrupo.dart';
import 'package:smaio/notifiers/notifier.subgrupo.dart';
import 'package:smaio/utils/funcoes.dart';

// ignore: must_be_immutable
class WidgetAddSubGrupo extends StatelessWidget {
  BuildContext context;
  WidgetAddSubGrupo({
    required this.context,
  });

  final _sgruDescricaoController = TextEditingController();

  @override
  Widget build(Object context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Consumer<SubGrupos>(
        builder: (context, lista, child) {
          return DataTable(
            dataRowHeight: 50,
            showCheckboxColumn: false,
            columns: [
              DataColumn(
                label: Container(
                  width: 300,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 5,
                    top: 5,
                  ),
                  child: Wrap(
                    children: [
                      Container(
                        width: 200,
                        child: TextFormField(
                          controller: _sgruDescricaoController,
                          validator: (String? text) => (text!.isEmpty)
                              ? showSnackMessage(
                                  context, 'Favor informar o Subgrupo...')
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Adicionar Subgrupo',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Consumer<SubGrupos>(
                            builder: (context, lista, child) {
                          return TextButton(
                            onPressed: () {
                              if (_sgruDescricaoController.text.length > 0) {
                                lista.addSubGrupos(SubGrupo(
                                  sgruDescricao: _sgruDescricaoController.text,
                                  sgruSitReg: true,
                                ));
                                _sgruDescricaoController.clear();
                              }
                            },
                            child: Container(
                              height: 50,
                              child: Icon(
                                Icons.add_circle,
                                color: Colors.green,
                                size: 35,
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 25,
                  child: Text(''),
                ),
              ),
            ],
            rows: lista.subGrupo
                .map(
                  (itens) => DataRow(
                    cells: [
                      DataCell(
                        Container(
                          width: 290,
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
                          width: 25,
                          child: Center(
                            child: TextButton(
                              onPressed: () async {
                                lista.removeSubGrupos(itens);
                              },
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
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
