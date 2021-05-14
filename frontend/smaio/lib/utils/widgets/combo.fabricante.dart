import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fabricante.dart';
import 'package:smaio/controllers/controller.veiculo.dart';
import 'package:smaio/models/model.fabricante.dart';
import 'package:smaio/models/model.veiculo.dart';
import 'package:smaio/notifiers/notifier.fabricante.dart';
import 'package:smaio/notifiers/notifier.veiculo.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class WidgetComboFabricante extends StatelessWidget {
  TextEditingController descricao;
  BuildContext context;
  String texto;
  TextEditingController codigo;
  WidgetComboFabricante({
    required this.descricao,
    required this.context,
    required this.texto,
    required this.codigo,
  });

  final _fabDescricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      child: Wrap(
        children: [
          Container(
            width: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width / 6) -
                150,
            child: TextFormField(
              controller: descricao,
              enabled: false,
              validator: (String? text) => (text!.isEmpty)
                  ? showSnackMessage(context, 'Favor informar o Fabricante...')
                  : null,
              decoration: InputDecoration(
                labelText: texto,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Consumer<Fabricantes>(builder: (context, query, child) {
              return ElevatedButton(
                onPressed: () async {
                  List<Fabricante> fabricantes = await FabricanteApi.getAll();
                  query.setFabricantes(fabricantes);
                  lista();
                },
                child: Container(
                  height: 50,
                  child: Icon(
                    Icons.search,
                    size: 35,
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  lista() {
    _fabDescricaoController.clear();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10,
          content: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(
                      Icons.close,
                      size: 25,
                    ),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 400,
                height: 600,
                margin: EdgeInsets.all(20),
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Consumer<Fabricantes>(
                      builder: (context, fabricantes, child) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 20, top: 10),
                          child: TextFormField(
                            autofocus: true,
                            controller: _fabDescricaoController,
                            validator: (String? text) => (text!.isEmpty)
                                ? showSnackMessage(
                                    context, 'Favor informar o Fabricante...')
                                : null,
                            decoration: InputDecoration(
                              labelText: 'Fabricante',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              fabricantes.filtroFabricantes(value);
                            },
                          ),
                        ),
                        DataTable(
                          dataRowHeight: 60,
                          showCheckboxColumn: false,
                          showBottomBorder: true,
                          columns: [
                            DataColumn(
                              label: Text(""),
                            )
                          ],
                          rows: fabricantes.fabricantesFilter!
                              .map(
                                (itens) => DataRow(
                                  cells: [
                                    DataCell(
                                      Container(
                                        child: Center(child: Consumer<Veiculos>(
                                          builder: (context, lista, child) {
                                            return TextButton(
                                              onPressed: () async {
                                                lista.setShowProgress(true);
                                                onPress(itens.fabId!,
                                                    itens.fabNome!);
                                                List<Veiculo> veiculos =
                                                    await VeiculoApi.getAll(
                                                        itens.fabId!);
                                                lista.setVeiculos(veiculos);
                                              },
                                              child: SafeArea(
                                                child: Container(
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
                                            );
                                          },
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    );
                  }),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void onPress(int pCodigo, String pNome) {
    descricao.text = pNome;
    codigo.text = pCodigo.toString();
    Navigator.of(context).pop();
  }
}
