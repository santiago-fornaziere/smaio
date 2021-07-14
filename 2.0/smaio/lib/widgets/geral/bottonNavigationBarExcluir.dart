import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.fotos.dart';
import 'package:smaio/forms/menu.inicial.dart';
import 'package:smaio/models/model.foto.dart';
import 'package:smaio/notifiers/notifier.foto.dart';
import 'package:smaio/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/circularProgressMini.dart';

// ignore: must_be_immutable
class WidgetBottonNavigatorBarExcluir extends StatelessWidget {
  Foto foto;
  BuildContext context;
  WidgetBottonNavigatorBarExcluir({
    required this.context,
    required this.foto,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.black54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 100,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(14),
              child: Text(
                '<< Voltar',
                style: TextStyle(
                  color: corTextoPadrao[0],
                  fontSize: fontSizePadrao,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width - 350,
            child: InkWell(
              onTap: () => push(context, MenuInicial()),
              child: Image.asset('assets/img/logo-amarelo.png'),
            ),
          ),
          Consumer<Fotos>(builder: (context, lista, child) {
            return !lista.showProgress
                ? InkWell(
                    onTap: () async {
                      lista.setShowProgress(true);
                      int retorno = await FotoApi.delete(foto.fotId!);
                      if (retorno == 202) {
                        Navigator.of(context).pop();
                        lista.removeFoto(foto);
                      }
                    },
                    child: Container(
                      width: 150,
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Excluir foto',
                              style: TextStyle(
                                color: corTextoPadrao[0],
                                fontSize: fontSizePadrao,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.delete_forever,
                            color: corTextoPadrao[0],
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  )
                : WidgetCircularProgressMini();
          }),
        ],
      ),
    );
  }
}
