import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/controllers/controller.veiano.dart';
import 'package:smaio/models/model.ano.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/notifiers/notifier.fabricante.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/notifiers/notifier.veicano.dart';
import 'package:smaio/pages/item/novo/form.item.novo.veiano.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widget.menu.lateral.dart';
import 'package:smaio/utils/widgets/circularProgress.dart';

// ignore: must_be_immutable
class ItemNovoFabricanteLocalizar extends StatefulWidget {
  Ano ano;
  ItemNovoFabricanteLocalizar({
    required this.ano,
  });

  @override
  State<StatefulWidget> createState() => _ItemNovoFabricanteLocalizar();
}

class _ItemNovoFabricanteLocalizar extends State<ItemNovoFabricanteLocalizar> {
  final _fabDescricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<Sistema>(
          builder: (context, sistema, child) {
            return Text(sistema.loja!.lojNome.toString());
          },
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => onClickLogout(context),
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _body(),
      drawer: Consumer<Sistema>(
        builder: (context, sistema, child) {
          return DrawerList(
            usuNivel: sistema.usuario!.usuNivel!,
          );
        },
      ),
    );
  }

  _body() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          formTitulo("NOVO ITEM PARA VENDA", Icons.shopping_cart),
          formCorpoCadastro(context, null, _lista())
        ],
      ),
    );
  }

  _lista() {
    _fabDescricaoController.clear();
    return <Widget>[
      Consumer<Fabricantes>(builder: (context, fabricantes, child) {
        return !fabricantes.showProgress
            ? Column(
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
                                  child: Center(child: Consumer<VeiAnos>(
                                    builder: (context, lista, child) {
                                      return TextButton(
                                        onPressed: () async {
                                          lista.setShowProgress(true);
                                          onPress();
                                          List<VeiAno> retorno =
                                              await VeiAnoApi.getByWhere(
                                                  'vano_vei_fab_id = ${itens.fabId} and vano_ano_id = ${widget.ano.anoId} ',
                                                  'vano_vei_descricao');
                                          lista.setVeiAnos(retorno);
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
              )
            : WidgetCircularProgress();
      }),
    ];
  }

  void onPress() {
    push(context, ItemNovoVeiAnoLocalizar());
  }
}
