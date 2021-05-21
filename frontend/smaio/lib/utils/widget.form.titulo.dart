import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container formTitulo(String pTitulo, pIcone, double pWidth) {
  return Container(
    color: Colors.blueGrey[100],
    padding: EdgeInsets.all(16),
    height: 70,
    width: pWidth,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          pIcone,
          color: Colors.grey[900],
          size: 40,
        ),
        Flexible(
          child: Text(
            pTitulo,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
