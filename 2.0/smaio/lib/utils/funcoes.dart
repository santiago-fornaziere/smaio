import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:smaio/prefs.dart';
import 'package:flutter/foundation.dart';
import 'package:smaio/utils/location/utilities/loc.dart';
import 'package:js/js.dart';

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

Future<double> calcDistancia(double lat1, double lon1) async {
  double lat2 = await Prefs.getDouble('latitude');
  double lon2 = await Prefs.getDouble('longitude');

  return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
}

Future<Map<String, double>> getPosicao() async {
  Map<String, double> retorno = {
    "latitude": 0,
    "longitude": 0,
  };
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied ||
        permission != LocationPermission.deniedForever) {
      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
      } catch (e) {
        print(e);
      }
      if (position != null) {
        retorno = {
          "latitude": position.latitude,
          "longitude": position.longitude,
        };

        Prefs.setDouble('latutude', position.latitude);
        Prefs.setDouble('longitude', position.longitude);
        return retorno;
      } else {
        return {
          "latitude": 0,
          "longitude": 0,
        };
      }
    } else {
      return {
        "latitude": 0,
        "longitude": 0,
      };
    }
  } else {
    getCurrentPosition(
      allowInterop(
        (pos) {
          retorno['latitude'] = pos.coords.latitude;
          retorno['longitude'] = pos.coords.longitude;

          Prefs.setDouble('latitude', pos.coords.latitude);
          Prefs.setDouble('longitude', pos.coords.longitude);
        },
      ),
    );
    return retorno;
  }
}

Future<String> getFileData(String path) async {
  return await rootBundle.loadString(path);
}

class CNPJ {
  // Formatar número de CNPJ
  static String format(String cnpj) {
    // Obter somente os números do CNPJ
    var numeros = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

    // Testar se o CNPJ possui 14 dígitos
    if (numeros.length != 14) return cnpj;

    // Retornar CPF formatado
    return "${numeros.substring(0, 2)}.${numeros.substring(2, 5)}.${numeros.substring(5, 8)}/${numeros.substring(8, 12)}-${numeros.substring(12)}";
  }

  // Validar número de CNPJ
  static bool isValid(String cnpj) {
    // Obter somente os números do CNPJ
    var numeros = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

    // Testar se o CNPJ possui 14 dígitos
    if (numeros.length != 14) return false;

    // Testar se todos os dígitos do CNPJ são iguais
    if (RegExp(r'^(\d)\1*$').hasMatch(numeros)) return false;

    // Dividir dígitos
    List<int> digitos =
        numeros.split('').map((String d) => int.parse(d)).toList();

    // Calcular o primeiro dígito verificador
    var calcDv1 = 0;
    var j = 0;
    for (var i in Iterable<int>.generate(12, (i) => i < 4 ? 5 - i : 13 - i)) {
      calcDv1 += digitos[j++] * i;
    }
    calcDv1 %= 11;
    var dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

    // Testar o primeiro dígito verificado
    if (digitos[12] != dv1) return false;

    // Calcular o segundo dígito verificador
    var calcDv2 = 0;
    j = 0;
    for (var i in Iterable<int>.generate(13, (i) => i < 5 ? 6 - i : 14 - i)) {
      calcDv2 += digitos[j++] * i;
    }
    calcDv2 %= 11;
    var dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

    // Testar o segundo dígito verificador
    if (digitos[13] != dv2) return false;

    return true;
  }
}
