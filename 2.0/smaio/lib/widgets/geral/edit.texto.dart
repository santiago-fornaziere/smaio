import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetEditTexto extends StatelessWidget {
  TextEditingController controller;
  BuildContext context;
  FocusNode? focusNode;
  bool? autofocos;
  String label;
  bool? enabled;
  bool? password;
  Widget? icone;
  VoidCallback? onExit;
  WidgetEditTexto(
      {required this.controller,
      required this.context,
      this.focusNode,
      this.autofocos,
      required this.label,
      this.enabled,
      this.password,
      this.icone,
      this.onExit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(23),
      child: TextFormField(
        onEditingComplete: onExit,
        controller: controller,
        enabled: enabled ?? true,
        autofocus: autofocos ?? false,
        obscureText: password ?? false,
        keyboardType: TextInputType.text,
        validator: (String? text) {
          return (text!.isEmpty) ? 'Preenchimento obrigatório' : null;
        },
        focusNode: focusNode,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: icone,
          fillColor: Colors.grey[50],
          labelText: label,
          /*
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
              width: 2,
            ),
          ),
          */
        ),
      ),
    );
  }
}
