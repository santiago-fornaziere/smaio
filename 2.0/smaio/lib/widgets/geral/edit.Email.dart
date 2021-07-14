import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

// ignore: must_be_immutable
class WidgetEditEmail extends StatelessWidget {
  TextEditingController controller;
  BuildContext context;
  String label;
  Widget? icone;
  VoidCallback? onExit;
  WidgetEditEmail({
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
          return !(EmailValidator.validate(text!))
              ? 'Este e-mail é inválido'
              : null;
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
