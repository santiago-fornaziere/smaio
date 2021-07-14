import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fabricante.dart';
import 'package:smaio/models/model.fabricante.dart';
import 'package:smaio/notifiers/notifier.foto.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class WidgetFabricanteLista extends StatelessWidget {
  BuildContext context;
  List<Fabricante> query;
  List<String> files;
  int tema; // origem 0 = dark / 1 = light
  int origem; // origem 0 = loja / 1 = consumidor
  WidgetFabricanteLista({
    required this.context,
    required this.query,
    required this.files,
    required this.tema,
    required this.origem,
  });

  final _fabDescricaoController = TextEditingController();
  List<Fabricante> lista = [];

  @override
  Widget build(BuildContext context) {
    _fabDescricaoController.text.length == 0 ? lista = query : lista = lista;
    return Container(
      child: Consumer<Fotos>(builder: (context, fotos, child) {
        return DataTable(
          dataRowHeight: 60,
          showCheckboxColumn: false,
          showBottomBorder: false,
          columns: [
            DataColumn(
              label: Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 50,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: Container(
                    width: 300,
                    child: TextFormField(
                      autofocus: true,
                      controller: _fabDescricaoController,
                      validator: (String? text) => (text!.isEmpty)
                          ? showSnackMessage(
                              context, 'Favor informar o Fabricante...')
                          : null,
                      decoration: InputDecoration(
                        filled: true,
                        suffixIcon: TextButton(
                          onPressed: () {
                            lista = query
                                .where((element) => element.fabNome!
                                    .toUpperCase()
                                    .contains(_fabDescricaoController.text
                                        .toUpperCase()))
                                .toList();

                            (context as Element).markNeedsBuild();
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[50],
                        labelText: '',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          rows: lista
              .map(
                (itens) => DataRow(
                  cells: [
                    DataCell(
                      Center(
                        child: Text(
                          itens.fabNome.toString(),
                          style: TextStyle(
                            fontSize: fontSizePequeno,
                            color: corTextoPadrao[tema],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        fotos.setFotos([]);
                        (origem == 0)
                            ? onAvancar(
                                context,
                                files,
                                itens,
                              )
                            : onAvancarConsumidor(
                                context,
                                itens,
                              );
                      },
                    ),
                  ],
                ),
              )
              .toList(),
        );
      }),
    );
  }
}
