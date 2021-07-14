import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fotos.dart';
import 'package:smaio/forms/consumidor/form.consumidor.fabricante.dart';
import 'package:smaio/models/model.item.dart';
import 'package:smaio/notifiers/notifier.foto.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/cardFotoFile.dart';
import 'package:provider/provider.dart';
import 'package:smaio/widgets/geral/circularProgress.dart';

// ignore: must_be_immutable
class ConsumidorItemLoja extends StatefulWidget {
  Item item;
  ConsumidorItemLoja({
    required this.item,
  });
  @override
  _ConsumidorItemLoja createState() => _ConsumidorItemLoja();
}

class _ConsumidorItemLoja extends State<ConsumidorItemLoja> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.item.iteVeiDescricao.toString()} - ${widget.item.iteVanoAnoDescricao.toString()}',
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: corTextoPadrao[1],
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () => push(context, ConsumidorFabricante()),
            child: Container(
              width: 80,
              child: Icon(
                Icons.home,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Container(
                margin: EdgeInsets.all(10),
                height: 80,
                child: ListTile(
                  title: Text(
                    widget.item.iteLojNome.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: fontSizePadrao),
                  ),
                  subtitle: Text(
                    'Tel.: ${widget.item.iteLojTelefone1} / ${widget.item.iteLojTelefone2} \ne-mail: ${widget.item.iteLojEmail}',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  leading: Text(
                    'Distância \n${formatFloat.format(widget.item.iteDistancia)} Km',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: fontSizePadrao),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.item.iteLojCidNome.toString()),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width - 50,
              height: 100,
              color: Colors.black,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.item.itePecDescricao.toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      widget.item.iteGruDescricao.toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      widget.item.iteStatus.toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: fontSizePadrao,
                      ),
                    ),
                    Text(
                      formatFloat.format(widget.item.iteValor ?? 0),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: fontSizePadrao,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _fotos(),
          ],
        ),
      ),
    );
  }

  _fotos() {
    return Consumer<Fotos>(builder: (context, fotos, child) {
      return !fotos.showProgress
          ? Container(
              child: fotos.foto.isNotEmpty
                  ? Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: MediaQuery.of(context).size.height - 320,
                      child: GridView.builder(
                        itemCount: fotos.foto.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          var itens = fotos.foto[index];
                          return WidgetCardFotoFile(
                            image: base64Decode(itens.fotFoto),
                            onPressed: () => onVisualizarFotoConsumidor(context,
                                itens, widget.item.iteLojNome.toString()),
                          );
                        },
                      ),
                    )
                  : Container(),
            )
          : WidgetCircularProgress();
    });
  }
}
