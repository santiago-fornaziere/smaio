import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container formTitulo(String pTitulo, pIcone) {
  return Container(
    color: Colors.blueGrey[100],
    padding: EdgeInsets.all(16),
    height: 70,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          pIcone,
          color: Colors.grey[900],
          size: 40,
        ),
        Text(
          pTitulo,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
