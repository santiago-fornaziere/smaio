import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

Future push(BuildContext context, Widget page, {bool replace = false}) {
  if (replace == true) {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
  return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}

// função para corrigir acentuação
String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

strToDate(String strDate) {
  if (strDate.length < 5) {
    return "";
  } else {
    DateTime pDate = DateTime.parse(strDate);
    var dt = formatDate(pDate, [dd, '/', mm, '/', yyyy]);
    return dt;
  }
}

strToHora(String strDate) {
  if (strDate.length < 5) {
    return "";
  } else {
    DateTime pDate = DateTime.parse(strDate);
    var dt = formatDate(pDate, [HH, ':', nn, ':', ss]);
    return dt;
  }
}

showMessage(context, pTexto) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(pTexto),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}

showSnackMessage(context, String pTexto, {int pDuracao = 2}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(pTexto),
      duration: Duration(seconds: pDuracao),
    ),
  );
}
