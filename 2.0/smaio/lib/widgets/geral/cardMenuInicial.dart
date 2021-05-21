import 'package:flutter/material.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetCardMenuInicial extends StatelessWidget {
  Color cor;
  String titulo;
  String subtitulo;
  IconData icone;
  VoidCallback? onPressed;
  WidgetCardMenuInicial({
    required this.cor,
    required this.titulo,
    required this.subtitulo,
    required this.icone,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.all(
            const Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icone,
              size: 40,
            ),
            Text(
              titulo,
              style: TextStyle(
                  color: corTextoPadraoEscura, fontSize: fontSizePadrao),
            ),
            Text(
              subtitulo,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.clip,
              softWrap: true,
              style: TextStyle(
                  color: corTextoPadraoEscura, fontSize: fontSizePequeno),
            ),
          ],
        ),
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
      ),
    );
  }
}
