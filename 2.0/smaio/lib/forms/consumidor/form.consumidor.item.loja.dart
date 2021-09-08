import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smaio/forms/consumidor/form.consumidor.fabricante.dart';
import 'package:smaio/forms/consumidor/form.consumidor.foto.visualizar.dart';
import 'package:smaio/models/model.foto.dart';
import 'package:smaio/models/model.item.dart';
import 'package:smaio/notifiers/notifier.foto.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:provider/provider.dart';
import 'package:smaio/widgets/geral/circularProgress.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
            fontSize: fontSizePadrao,
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
      bottomNavigationBar: Material(
        elevation: 20,
        child: Container(
          color: Colors.amber,
          height: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${widget.item.iteLojLogradouro.toString()} ${widget.item.iteLojNumero.toString()}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                '${widget.item.iteLojBairro.toString()} -  ${widget.item.iteLojCidNome.toString()}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _body(),
    );
  }

  _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children: [
            Card(
              child: Container(
                margin: EdgeInsets.all(10),
                height: 60,
                child: ListTile(
                  title: Text(
                    widget.item.iteLojNome.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    'Tel.: ${widget.item.iteLojTelefone1} / ${widget.item.iteLojTelefone2} \ne-mail: ${widget.item.iteLojEmail}',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  leading: (defaultTargetPlatform == TargetPlatform.android ||
                          defaultTargetPlatform == TargetPlatform.iOS)
                      ? Text(
                          'Distância \n${formatFloat.format(widget.item.iteDistancia)} Km',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10),
                        )
                      : null,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width - 50,
              height: 100,
              color: Colors.black,
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
                  ? Expanded(
                      child: Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: false,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                          ),
                          items: listaImagem(fotos.foto),
                        ),
                      ),
                    )
                  : Container(),
            )
          : WidgetCircularProgress();
    });
  }

  List<Widget> listaImagem(List<Foto> fotos) {
    return fotos
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        InkWell(
                          onTap: () => push(
                              context,
                              ConsumidorFotoVisualizar(
                                foto: item,
                                titulo: widget.item.iteDescricao.toString(),
                              )),
                          child: Image.network(item.fotFoto.toString(),
                              fit: BoxFit.cover, width: 1000.0),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              'No. ${fotos.indexOf(item) + 1}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
  }
}
