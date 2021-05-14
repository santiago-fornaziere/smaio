import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.item.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/models/model.grupo.dart';
import 'package:smaio/models/model.item.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/notifiers/notifier.item.dart';
import 'package:smaio/notifiers/notifier.peca.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class WidgetComboGrupo extends StatelessWidget {
  TextEditingController descricao;
  BuildContext context;
  String texto;
  TextEditingController codigo;
  String tipo;
  WidgetComboGrupo({
    required this.descricao,
    required this.context,
    required this.texto,
    required this.codigo,
    required this.tipo,
  });

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
                  ? showSnackMessage(context, 'Favor informar o Grupo...')
                  : null,
              decoration: InputDecoration(
                labelText: texto,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: ElevatedButton(
              onPressed: () async {
                lista();
              },
              child: Container(
                height: 50,
                child: Icon(
                  Icons.search,
                  size: 35,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  lista() {
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
                          "Selecione o Grupo",
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
                        rows: dicGrupo
                            .map(
                              (itens) => DataRow(
                                cells: [
                                  DataCell(
                                    Container(
                                      child: Center(
                                        child: Consumer<Sistema>(
                                            builder: (context, sistema, child) {
                                          return listaTipo(
                                              itens, sistema.loja!.lojId!);
                                        }),
                                      ),
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

  Widget listaTipo(Grupo itens, int loja) {
    if (tipo == 'peca') {
      return Consumer<Pecas>(
        builder: (context, lista, child) {
          return TextButton(
            onPressed: () async {
              lista.setShowProgress(true);
              onPress(itens.gruId!, itens.gruDescricao!);
              List<Peca> retorno = await PecaApi.getWhere(
                  ' pec_gru_id = ${itens.gruId} ', 'pec_descricao');
              if (retorno.isNotEmpty) {
                lista.setPecas(retorno);
              } else {
                lista.setPecas(retorno);
              }
            },
            child: SafeArea(
              child: Container(
                child: Center(
                  child: Text(
                    itens.gruDescricao.toString(),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Consumer<Itens>(
        builder: (context, lista, child) {
          return TextButton(
            onPressed: () async {
              lista.setShowProgress(true);
              onPress(itens.gruId!, itens.gruDescricao!);
              List<Item> retorno = await ItemApi.getWhere(
                  'ite_sit_reg = true and ite_gru_id = ${itens.gruId} and ite_loj_id = $loja',
                  'ite_gru_descricao, ite_pec_descricao, ite_sgru_descricao');
              if (retorno.isNotEmpty) {
                lista.setItens(retorno);
              } else {
                lista.setItens([]);
              }
            },
            child: SafeArea(
              child: Container(
                child: Center(
                  child: Text(
                    itens.gruDescricao.toString(),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void onPress(int pCodigo, String pNome) {
    descricao.text = pNome;
    codigo.text = pCodigo.toString();
    Navigator.of(context).pop();
  }
}
