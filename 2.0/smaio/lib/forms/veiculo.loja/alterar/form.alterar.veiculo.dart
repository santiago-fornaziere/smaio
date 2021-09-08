import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fotos.dart';
import 'package:smaio/controllers/controller.item.dart';
import 'package:smaio/controllers/controller.veiculoloja.dart';
import 'package:smaio/forms/menu.inicial.dart';
import 'package:smaio/forms/veiculo.loja/alterar/form.alterar.lista.dart';
import 'package:smaio/forms/veiculo.loja/alterar/form.alterar.visualizar.foto.dart';
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
import 'package:smaio/widgets/geral/circularProgress.dart';
import 'package:smaio/widgets/geral/circularProgressMini.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  bool _showProgress = false;
  Configuration config = Configuration();

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
      floatingActionButton: !_showProgress
          ? Container(
              height: 110,
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => baixarcarro(context, widget.veiloja),
                    child: Container(
                      width: 100,
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            'Baixar carro',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _showProgress = true;
                      bool retorno =
                          await ItemApi.insertAll(widget.veiloja.vlojId!);
                      if (retorno) {
                        _showProgress = false;
                        showSnackMessage(
                            context, 'Peças cadastradas com sucesso!');
                      } else {
                        _showProgress = false;
                        showSnackMessage(
                            context, 'Erro ao cadastrar as peças...');
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            'Add todas peças',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: 25,
              width: 25,
              child: Center(
                child: WidgetCircularProgressMini(),
              ),
            ),
    );
  }

  _body() {
    config = Configuration(
      outputType: ImageOutputType.jpg,
      quality: 100,
      useJpgPngNativeCompressor: true,
    );
    return Center(
        child: Container(
      child: Container(
        child: ListView(
          children: [
            WidgetCardDadosVeiculoLoja(
              veiloja: widget.veiloja,
            ),
            (defaultTargetPlatform == TargetPlatform.android ||
                    defaultTargetPlatform == TargetPlatform.iOS)
                ? _addFotoMobile()
                : _addFotoWeb(),
            _fotos(),
          ],
        ),
      ),
    ));
  }

  _fotos() {
    return Consumer<Fotos>(builder: (context, fotos, child) {
      return !fotos.showProgress
          ? Container(
              child: fotos.foto.isNotEmpty
                  ? Container(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        items: listaImagem(fotos.foto),
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
                              AlterarVeiculoVisualizarFoto(
                                foto: item,
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

  _addFotoWeb() {
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
                    final foto = await _picker.getImage(
                        source: ImageSource.gallery,
                        maxHeight: 900,
                        maxWidth: 1200);

                    if (foto != null) {
                      try {
                        Uint8List bytes = await foto.readAsBytes();
                        Foto retorno =
                            await FotoApi.post(bytes, widget.veiloja.vlojId!);
                        // ignore: unnecessary_null_comparison
                        if (retorno != null) {
                          var addfoto = retorno;
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

  _addFotoMobile() {
    return Consumer<Fotos>(builder: (context, lista, child) {
      return !lista.showProgress
          ? (lista.foto.length < 6)
              ? Container(
                  alignment: Alignment.topCenter,
                  height: 150,
                  width: 150,
                  padding: EdgeInsets.all(1),
                  child: Consumer<Fotos>(builder: (context, lista, child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            final _picker = ImagePicker();
                            final image = await _picker.getImage(
                              source: ImageSource.camera,
                              maxHeight: 900,
                              maxWidth: 1200,
                            );
                            if (image != null) {
                              try {
                                Uint8List bytes = await image.readAsBytes();
                                Foto retorno = await FotoApi.post(
                                    bytes, widget.veiloja.vlojId!);
                                // ignore: unnecessary_null_comparison
                                if (retorno != null) {
                                  var addfoto = retorno;
                                  lista.addFotos(addfoto);
                                  lista.setShowProgress(false);
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
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Câmera',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.photo_camera_outlined,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final _picker = ImagePicker();

                            final image = await _picker.getImage(
                              source: ImageSource.gallery,
                              maxHeight: 900,
                              maxWidth: 1200,
                            );
                            if (image != null) {
                              try {
                                Uint8List bytes = await image.readAsBytes();
                                Foto retorno = await FotoApi.post(
                                    bytes, widget.veiloja.vlojId!);
                                // ignore: unnecessary_null_comparison
                                if (retorno != null) {
                                  var addfoto = retorno;
                                  lista.addFotos(addfoto);
                                  lista.setShowProgress(false);
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
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Galeria',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.photo_album_outlined,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
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

  baixarcarro(BuildContext context, VeiculoLoja veiloja) async {
    showSnackMessage(context, 'Aguarde confirmação de baixa...');
    _showProgress = true;
    (context as Element).markNeedsBuild();
    veiloja.vlojAtivo = false;
    int retorno = await VeiculoLojaApi.patch(veiloja);
    if (retorno == 201) {
      push(
          context,
          AlterarLista(
            loja: veiloja.vlojLojId!,
          ),
          replace: true);

      _showProgress = false;
      push(context, MenuInicial());
    } else {
      showSnackMessage(context, 'Erro ao baixar carro.');
    }
  }
}
