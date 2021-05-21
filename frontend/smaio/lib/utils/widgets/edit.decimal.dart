import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetEditDecimal extends StatelessWidget {
  TextEditingController controller;
  BuildContext context;
  FocusNode? focusNode;
  bool? autofocos;
  String label;
  bool? enabled;
  WidgetEditDecimal({
    required this.controller,
    required this.context,
    this.focusNode,
    this.autofocos,
    required this.label,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(23),
      child: TextFormField(
        controller: controller,
        enabled: enabled ?? true,
        autofocus: autofocos ?? false,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        validator: (String? text) {
          return (text!.isEmpty) ? 'Preenchimento obrigatório' : null;
        },
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
