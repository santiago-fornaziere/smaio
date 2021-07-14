import 'package:flutter/material.dart';
import 'package:smaio/forms/menu.inicial.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';

// ignore: must_be_immutable
class WidgetBottonNavigatorBarFinalizar extends StatelessWidget {
  BuildContext context;
  WidgetBottonNavigatorBarFinalizar({
    required this.context,
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
              Navigator.pop(context);
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
            width: MediaQuery.of(context).size.width - 300,
            child: InkWell(
              onTap: () => push(context, MenuInicial()),
              child: Image.asset('assets/img/logo-amarelo.png'),
            ),
          ),
          InkWell(
            onTap: () {
              push(context, MenuInicial());
            },
            child: Container(
              width: 100,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.all(14),
              child: Text(
                'Finalizar >>',
                style: TextStyle(
                  color: corTextoPadrao[0],
                  fontSize: fontSizePadrao,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
