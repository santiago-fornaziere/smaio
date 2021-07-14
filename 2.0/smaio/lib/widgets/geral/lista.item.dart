import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fotos.dart';
import 'package:smaio/forms/consumidor/form.consumidor.item.loja.dart';
import 'package:smaio/models/model.foto.dart';
import 'package:smaio/models/model.item.dart';
import 'package:smaio/notifiers/notifier.foto.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/cardItemLista.dart';

// ignore: must_be_immutable
class WidgetItemLista extends StatelessWidget {
  BuildContext context;
  List<Item> query;
  WidgetItemLista({
    required this.context,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height - 150,
        width: MediaQuery.of(context).size.width,
        child: Consumer<Fotos>(builder: (context, fotos, child) {
          return ListView.builder(
              itemCount: query.length,
              itemBuilder: (context, index) {
                var itens = query[index];
                return Consumer<Fotos>(builder: (context, fotos, child) {
                  return InkWell(
                    child: WidgetCardItemLista(item: itens),
                    onTap: () async {
                      fotos.setFotos([]);
                      fotos.setShowProgress(true);
                      push(context, ConsumidorItemLoja(item: itens));
                      List<Foto> retorno =
                          await FotoApi.getByVeiLoja(itens.iteVlojId!);
                      fotos.setFotos(retorno);
                    },
                  );
                });
              });
        }),
      ),
    );
  }
}
