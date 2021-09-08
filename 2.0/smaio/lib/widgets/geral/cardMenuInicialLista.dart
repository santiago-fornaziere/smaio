import 'package:flutter/material.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetCardMenuInicialLista extends StatelessWidget {
  Color cor;
  String titulo;
  String subtitulo;
  IconData icone;
  VoidCallback? onPressed;
  double? radius;
  double? margim;
  WidgetCardMenuInicialLista({
    required this.cor,
    required this.titulo,
    required this.subtitulo,
    required this.icone,
    this.onPressed,
    this.radius,
    this.margim,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 0),
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
        margin: EdgeInsets.all(margim ?? 0),
        alignment: Alignment.center,
      ),
    );
  }
}
