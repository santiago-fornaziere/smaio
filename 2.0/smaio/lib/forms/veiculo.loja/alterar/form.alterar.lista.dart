import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fotos.dart';
import 'package:smaio/controllers/controller.veiculoloja.dart';
import 'package:smaio/forms/veiculo.loja/alterar/form.alterar.veiculo.dart';
import 'package:smaio/models/model.foto.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/notifiers/notifier.foto.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/bottonNavigationBar.dart';
import 'package:provider/provider.dart';
import 'package:smaio/widgets/geral/circularProgress.dart';

// ignore: must_be_immutable
class AlterarLista extends StatefulWidget {
  int loja;
  AlterarLista({
    required this.loja,
  });
  @override
  _AlterarLista createState() => _AlterarLista();
}

class _AlterarLista extends State<AlterarLista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: 'Alteração de dados dos veículos',
        mostraIcone: false,
        tema: 0,
      ),
//      backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: corTemaDark,
      bottomNavigationBar: WidgetBottonNavigatorBar(
        context: context,
        mostraAvancar: false,
      ),
      body: _futureBuilder(),
    );
  }

  _futureBuilder() {
    Future<List<VeiculoLoja>> future = VeiculoLojaApi.getAll(widget.loja);

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<VeiculoLoja>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Não foi possível concluir esta ação!",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<VeiculoLoja> query = snapshot.data!;

        return _body(query);
      },
    );
  }

  _body(List<VeiculoLoja> query) {
    query.removeWhere((veiloja) => veiloja.vlojAtivo == false);
    return Container(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: query.length,
        itemBuilder: (context, index) {
          var itens = query[index];
          return Consumer<Fotos>(builder: (context, lista, child) {
            return !lista.showProgress
                ? InkWell(
                    child: Container(
                      color: Colors.black38,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: (itens.foto != null)
                                ? Image.memory(
                                    base64Decode(itens.foto),
                                    fit: BoxFit.scaleDown,
                                    height: 95,
                                  )
                                : Icon(
                                    Icons.camera_alt_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                          ),
                          Text(
                            itens.vlojVeiDescricao.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            itens.vlojAnoDescricao.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () async {
                      lista.setFotos([]);
                      lista.setShowProgress(true);
                      push(
                          context,
                          AlterarVeiculo(
                            veiloja: itens,
                            botaoVoltar: true,
                          ));
                      List<Foto> fotos =
                          await FotoApi.getByVeiLoja(itens.vlojId!);
                      lista.setFotos(fotos);
                    },
                  )
                : WidgetCircularProgress();
          });
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
      ),
    );
  }
}
