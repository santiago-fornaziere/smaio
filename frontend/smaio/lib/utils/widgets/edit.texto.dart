import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetEditTexto extends StatelessWidget {
  TextEditingController descricao;
  BuildContext context;
  FocusNode? focusNode;
  bool? autofocos;
  String texto;
  bool? enabled;
  WidgetEditTexto({
    required this.descricao,
    required this.context,
    this.focusNode,
    this.autofocos,
    required this.texto,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(23),
      child: TextFormField(
        controller: descricao,
        enabled: enabled ?? true,
        autofocus: autofocos ?? false,
        keyboardType: TextInputType.text,
        validator: (String? text) {
          return (text!.isEmpty) ? 'Preenchimento obrigatório' : null;
        },
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: texto,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
