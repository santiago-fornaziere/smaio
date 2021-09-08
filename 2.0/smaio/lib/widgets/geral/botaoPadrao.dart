import 'package:flutter/material.dart';
import 'package:smaio/widgets/geral/circularProgressMini.dart';

// ignore: must_be_immutable
class WidgetBotaoPadrao extends StatelessWidget {
  VoidCallback? onPressed;
  String texto;
  bool showProgress;
  WidgetBotaoPadrao({
    this.onPressed,
    required this.texto,
    required this.showProgress,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        child: !showProgress
            ? Text(
                texto,
                style: TextStyle(
                  fontSize: 24,
                ),
              )
            : WidgetCircularProgressMini(),
      ),
    );
  }
}
