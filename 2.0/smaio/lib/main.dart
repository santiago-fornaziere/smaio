import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaio/forms/splash.dart';
import 'package:smaio/models/model.loja.dart';
import 'package:smaio/models/model.usuario.dart';
import 'package:smaio/notifiers/notifier.fabricante.dart';
import 'package:smaio/notifiers/notifier.foto.dart';
import 'package:smaio/notifiers/notifier.peca.veiloja.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/notifiers/notifier.veiloja.dart';

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => Sistema(
                  usuario: Usuario(),
                  loja: Loja(),
                )),
        ChangeNotifierProvider(
            create: (context) => Fotos(
                  foto: [],
                  showProgress: false,
                )),
        ChangeNotifierProvider(
            create: (context) => VeiLojas(
                  veilojas: [],
                  showProgress: false,
                )),
        ChangeNotifierProvider(
            create: (context) => PecaVeiLojas(
                  pecas: [],
                  showProgress: false,
                )),
        ChangeNotifierProvider(
            create: (context) => Fabricantes(
                  fabricantes: [],
                  showProgress: false,
                )),
      ],
      child: MyApp(),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
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
      home: SplashPage(),
    );
  }
}
