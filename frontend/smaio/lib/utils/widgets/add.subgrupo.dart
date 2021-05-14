import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/models/model.subgrupo.dart';
import 'package:smaio/notifiers/notifier.subgrupo.dart';

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
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Consumer<SubGrupos>(
        builder: (context, lista, child) {
          return DataTable(
            dataRowHeight: 60,
            showCheckboxColumn: false,
            showBottomBorder: true,
            columns: [
              DataColumn(
                label: Container(
                  height: 60,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    bottom: 5,
                    top: 0,
                    left: 15,
                    right: 15,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width -
                            (MediaQuery.of(context).size.width / 6) -
                            150,
                        child: TextFormField(
                          controller: _sgruDescricaoController,
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
            ],
            rows: lista.subGrupo
                .map(
                  (itens) => DataRow(
                    cells: [
                      DataCell(
                        Container(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width -
                                    (MediaQuery.of(context).size.width / 6) -
                                    120,
                                child: Center(
                                  child: Text(
                                    itens.sgruDescricao.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
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
