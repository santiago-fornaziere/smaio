import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/controllers/controller.peca.dart';
import 'package:smaio/models/model.subgrupo.dart';
import 'package:smaio/notifiers/notifier.subgrupo.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/utils/widgets/add.veiano.subgrupo.dart';

// ignore: must_be_immutable
class WidgetAddSubGrupoVeiAno extends StatelessWidget {
  TextEditingController descricao;
  BuildContext context;
  String texto;
  TextEditingController codigo;
  int vanoId;

  WidgetAddSubGrupoVeiAno({
    required this.descricao,
    required this.context,
    required this.texto,
    required this.codigo,
    required this.vanoId,
  });

  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
        ),
        WidgetSubGrupoAdd(
          context: context,
          vanoId: vanoId,
        ),
      ],
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
                                      child: Center(child: Consumer<SubGrupos>(
                                        builder: (context, lista, child) {
                                          return TextButton(
                                            onPressed: !_showProgress
                                                ? () async {
                                                    _showProgress = true;
                                                    List<SubGrupo> retorno =
                                                        await PecaApi.getSGWhere(
                                                            'sgru_gru_id = ${itens.gruId} and sgru_pec_sit_reg = true and sgvano_id is null',
                                                            'sgru_pec_id',
                                                            vanoId);
                                                    if (retorno.isNotEmpty) {
                                                      lista.setSubGrupos(
                                                          retorno);
                                                      onPress(itens.gruId!,
                                                          itens.gruDescricao!);
                                                      _showProgress = false;
                                                    } else {
                                                      showSnackMessage(context,
                                                          'Erro na consulta...');
                                                      _showProgress = false;
                                                    }
                                                  }
                                                : null,
                                            child: Container(
                                              height: 60,
                                              width: 300,
                                              child: Center(
                                                child: Text(
                                                  itens.gruDescricao.toString(),
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

  void onPress(int pCodigo, String pNome) {
    descricao.text = pNome;
    codigo.text = pCodigo.toString();
    Navigator.of(context).pop();
  }
}
