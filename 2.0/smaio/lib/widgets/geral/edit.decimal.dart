import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(12),
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: controller,
        enabled: enabled ?? true,
        autofocus: autofocos ?? false,
        keyboardType: TextInputType.number,
        validator: (String? text) {
          return (text!.isEmpty) ? 'Preenchimento obrigatório' : null;
        },
        focusNode: focusNode,
        decoration: InputDecoration(
          prefix: Text(
            'R\$ ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          filled: true,
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
