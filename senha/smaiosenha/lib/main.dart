import 'package:flutter/material.dart';
import 'package:smaiosenha/alterar_senha.dart';
import 'package:smaiosenha/home.dart';
import 'package:window_location_href/window_location_href.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String? href = getHref();
    Uri uri = new Uri.dataFromString(href!);
    String? usuario = uri.queryParameters['usuario'];
    String? codigo = uri.queryParameters['codigo'];
    Map<int, String> lista = uri.pathSegments.asMap();
    return MaterialApp(
      title: 'Smaio - Alteração de senha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFffcc00),
        primarySwatch: Colors.blueGrey,
      ),
      home: ((usuario != null) &&
              (codigo != null) &&
              (lista.containsValue('reset')))
          ? AlterarSenha(
              usuario: usuario,
              codigo: codigo,
            )
          : Home(),
    );
  }
}
