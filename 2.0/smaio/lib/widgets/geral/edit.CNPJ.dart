import 'package:flutter/material.dart';
import 'package:smaio/utils/funcoes.dart';

// ignore: must_be_immutable
class WidgetEditCNPJ extends StatelessWidget {
  TextEditingController controller;
  BuildContext context;
  String label;
  Widget? icone;
  VoidCallback? onExit;
  WidgetEditCNPJ({
    required this.controller,
    required this.context,
    required this.label,
    this.icone,
    this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        onEditingComplete: onExit,
        controller: controller,
        keyboardType: TextInputType.text,
        validator: (String? text) {
          print('teste ' + text.toString());
          return !(CNPJ.isValid(text!)) ? 'Este CNPJ é inválido' : null;
        },
        decoration: InputDecoration(
          filled: true,
          prefixIcon: icone,
          fillColor: Colors.grey[50],
          labelText: label,
        ),
      ),
    );
  }
}
