import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.veiano.dart';
import 'package:smaio/models/model.ano.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/notifiers/notifier.veicano.dart';
import 'package:smaio/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/funcoes.dart';

// ignore: must_be_immutable
class WidgetAddVeiAno extends StatelessWidget {
  BuildContext context;
  int veiId;
  WidgetAddVeiAno({
    required this.context,
    required this.veiId,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        lista(dicAno);
      },
      child: Icon(
        Icons.add_circle,
        color: Colors.green,
      ),
    );
  }

  lista(List<Ano> query) {
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
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "Selecione o Ano",
                        ),
                      ),
                      DataTable(
                        dataRowHeight: 60,
                        showCheckboxColumn: false,
                        columns: [
                          DataColumn(
                            label: Text(""),
                          )
                        ],
                        rows: query
                            .map(
                              (itens) => DataRow(
                                cells: [
                                  DataCell(
                                    Container(
                                      child: Center(child: Consumer<VeiAnos>(
                                        builder: (context, lista, child) {
                                          return TextButton(
                                            onPressed: () async {
                                              var veiano = VeiAno(
                                                vanoAnoId: itens.anoId,
                                                vanoAnoDescricao:
                                                    itens.anoDescricao,
                                                vanoVeiId: veiId,
                                              );
                                              int retorno =
                                                  await VeiAnoApi.post(veiano);
                                              if (retorno == 201) {
                                                lista.addVeiAnos(veiano);
                                                onPress();
                                              } else {
                                                showSnackMessage(context,
                                                    'Erro ao cadastrar vinculo de veículo e ano...');
                                              }
                                            },
                                            child: Container(
                                              height: 60,
                                              width: 300,
                                              child: Center(
                                                child: Text(
                                                  itens.anoDescricao.toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
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
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void onPress() {
    Navigator.of(context).pop();
  }
}
