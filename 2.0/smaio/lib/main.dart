import 'package:flutter/material.dart';
import 'package:smaio/forms/form.login.dart';
import 'package:provider/provider.dart';
import 'package:smaio/models/model.loja.dart';
import 'package:smaio/models/model.usuario.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/prefs.dart';

Future<void> main() async {
  String login = await Prefs.getString('usu_email');
  String senha = await Prefs.getString('senha');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => Sistema(
                  usuario: Usuario(
                    usuEmail: login,
                    usuSenha: senha,
                  ),
                  loja: Loja(),
                )),
      ],
      child: MyApp(login: login, senha: senha),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String login;
  String senha;
  MyApp({
    required this.login,
    required this.senha,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smaio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFffcc00),
        primarySwatch: Colors.blueGrey,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          hintStyle: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
      home: Login(
        login: login,
        senha: senha,
      ),
    );
  }
}
