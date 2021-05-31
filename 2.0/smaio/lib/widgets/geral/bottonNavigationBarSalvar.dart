import 'package:flutter/material.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/circularProgressMini.dart';

// ignore: must_be_immutable
class WidgetBottonNavigatorBarSalvar extends StatelessWidget {
  BuildContext context;
  bool showProgress;
  VoidCallback onPressed;
  WidgetBottonNavigatorBarSalvar({
    required this.context,
    required this.onPressed,
    required this.showProgress,
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
                  color: corTextoPadrao,
                  fontSize: fontSizePadrao,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width - 350,
            child: Image.asset('assets/img/logo-amarelo.png'),
          ),
          !showProgress
              ? InkWell(
                  onTap: onPressed,
                  child: Container(
                    width: 150,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.all(14),
                    child: Text(
                      'Concluir >>',
                      style: TextStyle(
                        color: corTextoPadrao,
                        fontSize: fontSizePadrao,
                      ),
                    ),
                  ),
                )
              : WidgetCircularProgressMini(),
        ],
      ),
    );
  }
}
