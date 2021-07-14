import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fotos.dart';
import 'package:smaio/models/model.foto.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/notifiers/notifier.foto.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/bottonNavigationBarAlterar.dart';
import 'package:smaio/widgets/geral/cardDadosVeiculoLoja.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:smaio/widgets/geral/cardFotoFile.dart';
import 'package:smaio/widgets/geral/circularProgressMini.dart';

// ignore: must_be_immutable
class AlterarVeiculo extends StatefulWidget {
  VeiculoLoja veiloja;
  bool botaoVoltar;
  AlterarVeiculo({
    required this.veiloja,
    required this.botaoVoltar,
  });
  @override
  _AlterarVeiculo createState() => _AlterarVeiculo();
}

class _AlterarVeiculo extends State<AlterarVeiculo> {
  // bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: 'Gerenciar peças do veículo',
        mostraIcone: false,
        tema: 0,
      ),
      backgroundColor: corTemaDark,
      bottomNavigationBar: WidgetBottonNavigatorBarAlterar(
        context: context,
        veiloja: widget.veiloja,
        voltar: widget.botaoVoltar,
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
        child: Container(
      child: Container(
        child: ListView(
          children: [
            WidgetCardDadosVeiculoLoja(
              veiloja: widget.veiloja,
            ),
            _addFoto(),
            _fotos(),
          ],
        ),
      ),
    ));
  }

  _fotos() {
    return Consumer<Fotos>(builder: (context, lista, child) {
      return Container(
        child: lista.foto.isNotEmpty
            ? Container(
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.height - 200,
                child: GridView.builder(
                  itemCount: lista.foto.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    var itens = lista.foto[index];
                    return WidgetCardFotoFile(
                      image: base64Decode(itens.fotFoto),
                      onPressed: () => onVisualizarFoto(context, itens),
                    );
                  },
                ),
              )
            : Container(),
      );
    });
  }

  _addFoto() {
    return Consumer<Fotos>(builder: (context, lista, child) {
      return !lista.showProgress
          ? (lista.foto.length < 6)
              ? InkWell(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width - 100,
                    height: 100,
                    color: Colors.black38,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Adicionar foto',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    lista.setShowProgress(true);
                    final _picker = ImagePicker();
                    if (defaultTargetPlatform == TargetPlatform.android ||
                        defaultTargetPlatform == TargetPlatform.iOS) {
                      final image =
                          await _picker.getImage(source: ImageSource.camera);
                      if (image != null) {
                        try {
                          Uint8List bytes = await image.readAsBytes();
                          int retorno =
                              await FotoApi.post(bytes, widget.veiloja.vlojId!);
                          if (retorno > 0) {
                            var addfoto = new Foto(
                              fotFoto: base64Encode(bytes),
                              fotId: retorno,
                            );
                            lista.addFotos(addfoto);
                          } else {
                            showSnackMessage(context,
                                'Erro ao gravar foto, o serviço pode estar indisponível no momento...');
                            lista.setShowProgress(false);
                          }
                        } catch (e) {
                          print(e);
                          lista.setShowProgress(false);
                        }
                      }
                    } else {
                      final image =
                          await _picker.getImage(source: ImageSource.gallery);
                      if (image != null) {
                        try {
                          Uint8List bytes = await image.readAsBytes();
                          int retorno =
                              await FotoApi.post(bytes, widget.veiloja.vlojId!);
                          if (retorno > 0) {
                            var addfoto = new Foto(
                              fotFoto: base64Encode(bytes),
                              fotId: retorno,
                            );
                            lista.addFotos(addfoto);
                          } else {
                            showSnackMessage(context,
                                'Erro ao gravar foto, o serviço pode estar indisponível no momento...');
                            lista.setShowProgress(false);
                          }
                        } catch (e) {
                          print(e);
                          lista.setShowProgress(false);
                        }
                      }
                    }
                  },
                )
              : Container(
                  margin: EdgeInsets.all(8),
                )
          : Container(
              margin: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width - 100,
              height: 100,
              color: Colors.black38,
              child: WidgetCircularProgressMini(),
            );
    });
  }
}
