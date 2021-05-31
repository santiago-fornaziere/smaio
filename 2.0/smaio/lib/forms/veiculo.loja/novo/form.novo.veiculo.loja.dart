import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fotos.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/bottonNavigationBar.dart';
import 'package:smaio/widgets/geral/cardFoto.dart';
import 'package:image_picker/image_picker.dart';

class NovoVeiculoLojaFoto extends StatefulWidget {
  @override
  _NovoVeiculoLojaFoto createState() => _NovoVeiculoLojaFoto();
}

class _NovoVeiculoLojaFoto extends State<NovoVeiculoLojaFoto> {
  // bool _showProgress = false;

  String file1 = '';
  String file2 = '';
  String file3 = '';
  String file4 = '';
  String file5 = '';
  String file6 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: 'Cadastramento de veículo / Fotos',
        mostraIcone: false,
      ),
//      backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: corTemaDark,
      bottomNavigationBar: WidgetBottonNavigatorBar(
        avancarFunction: () =>
            onAvancar(context, [file1, file2, file3, file4, file5, file6]),
        mostraAvancar: true,
        context: context,
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Container(
        width: (MediaQuery.of(context).size.width > 800)
            ? MediaQuery.of(context).size.width - 200
            : 500,
        child: Container(
          margin: EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: (MediaQuery.of(context).size.width > 800) ? 3 : 2,
            scrollDirection: Axis.vertical,
            crossAxisSpacing: 16,
            padding: EdgeInsets.all(16),
            children: [
              WidgetCardFoto(
                imagePath: file1,
                onPressed: () => camera(1),
              ),
              WidgetCardFoto(
                imagePath: file2,
                onPressed: () => camera(2),
              ),
              WidgetCardFoto(
                imagePath: file3,
                onPressed: () => camera(3),
              ),
              WidgetCardFoto(
                imagePath: file4,
                onPressed: () => camera(4),
              ),
              WidgetCardFoto(
                imagePath: file5,
                onPressed: () => camera(5),
              ),
              WidgetCardFoto(
                imagePath: file6,
                onPressed: () => camera(6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  camera(int indice) async {
    final _picker = ImagePicker();
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      final image = await _picker.getImage(source: ImageSource.camera);
      setState(() {
        if (image != null) {
          if (indice == 1) {
            file1 = image.path;
          } else if (indice == 2) {
            file2 = image.path;
          } else if (indice == 3) {
            file3 = image.path;
          } else if (indice == 4) {
            file4 = image.path;
          } else if (indice == 5) {
            file5 = image.path;
          } else {
            file6 = image.path;
          }
        }
      });
    } else {
      final image = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (image != null) {
          if (indice == 1) {
            file1 = image.path;
          } else if (indice == 2) {
            file2 = image.path;
          } else if (indice == 3) {
            file3 = image.path;
          } else if (indice == 4) {
            file4 = image.path;
          } else if (indice == 5) {
            file5 = image.path;
          } else {
            file6 = image.path;
          }
        }
      });
    }
  }
}
