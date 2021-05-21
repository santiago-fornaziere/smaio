import 'package:flutter/material.dart';
import 'package:smaio/utils/const.dart';

// ignore: must_be_immutable
class WidgetBottonNavigatorBar extends StatelessWidget {
  VoidCallback? avancarFunction;
  BuildContext context;
  WidgetBottonNavigatorBar({
    required this.context,
    this.avancarFunction,
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
                  color: corTextoPadrao,
                  fontSize: fontSizePadrao,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width - 300,
            child: Image.asset('assets/img/logo-amarelo.png'),
          ),
          InkWell(
            onTap: avancarFunction,
            child: Container(
              width: 100,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.all(14),
              child: Text(
                'Avançar >>',
                style: TextStyle(
                  color: corTextoPadrao,
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
