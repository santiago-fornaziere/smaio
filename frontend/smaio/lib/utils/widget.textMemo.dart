import 'package:flutter/material.dart';

Widget textMemo(pcontroller, pTexto, pFocus, {int pLines = 3}) => TextFormField(
      autofocus: true,
      maxLines: pLines,
      focusNode: pFocus,
      controller: pcontroller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: pTexto,
        border: OutlineInputBorder(),
      ),
      validator: (String? text) {
        return (text!.isEmpty) ? 'Preenchimento obrigatório' : null;
      },
    );
