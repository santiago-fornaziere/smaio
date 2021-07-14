import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetDividerTexto extends StatelessWidget {
  String texto;
  WidgetDividerTexto({
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8),
            child: Divider(),
          ),
        ),
        Text(
          'Dados de usuário',
          style: TextStyle(
            fontSize: 9,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8),
            child: Divider(),
          ),
        ),
      ],
    );
  }
}
