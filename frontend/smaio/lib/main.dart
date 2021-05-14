import 'package:flutter/material.dart';
import 'package:smaio/models/model.loja.dart';
import 'package:smaio/notifiers/notifier.fabricante.dart';
import 'package:smaio/notifiers/notifier.item.dart';
import 'package:smaio/notifiers/notifier.peca.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/models/model.usuario.dart';
import 'package:smaio/notifiers/notifier.subgrupo.dart';
import 'package:smaio/notifiers/notifier.subgrupoveiano.dart';
import 'package:smaio/notifiers/notifier.veicano.dart';
import 'package:smaio/notifiers/notifier.veiculo.dart';
import 'package:smaio/pages/form.login.dart';
import 'package:provider/provider.dart';
import 'package:smaio/prefs.dart';

void main() async {
  String email = await Prefs.getString('usu_email');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => Sistema(
                  usuario: Usuario(usuEmail: email),
                  loja: Loja(),
                )),
        ChangeNotifierProvider(
            create: (context) => Veiculos(
                  veiculos: [],
                  showProgress: false,
                )),
        ChangeNotifierProvider(
            create: (context) => Fabricantes(
                  fabricantes: [],
                  showProgress: false,
                )),
        ChangeNotifierProvider(
            create: (context) => VeiAnos(
                  veiAno: [],
                  showProgress: false,
                )),
        ChangeNotifierProvider(
            create: (context) => Pecas(
                  pecas: [],
                  showProgress: false,
                )),
        ChangeNotifierProvider(
            create: (context) => SubGrupos(
                  subGrupo: [],
                  showProgress: false,
                )),
        ChangeNotifierProvider(
            create: (context) => SubGrupoVeiAnos(
                  subGrupoveiAno: [],
                  showProgress: false,
                )),
        ChangeNotifierProvider(
            create: (context) => Itens(
                  itens: [],
                  showProgress: false,
                )),
      ],
      child: MyApp(
        email: email,
      ),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String? email;
  MyApp({
    this.email,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smaio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: LoginPage(
        email: email,
      ),
    );
  }
}
