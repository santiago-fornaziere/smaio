import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.menu.inicial.dart';
import 'package:smaio/forms/form.login.dart';
import 'package:smaio/models/model.loja.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/cardMenuInicial.dart';
import 'package:provider/provider.dart';

class MenuInicial extends StatefulWidget {
  @override
  _MenuInicial createState() => _MenuInicial();
}

class _MenuInicial extends State<MenuInicial> {
  // bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Sistema>(builder: (context, sistema, child) {
      return Scaffold(
        appBar: WidgetAppBarTransparente(
          titulo:
              '${sistema.loja!.lojNome.toString()} \n${sistema.usuario!.usuEmail.toString()}',
          mostraIcone: false,
          tema: 0,
        ),
//      backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: corTemaDark,
        body: _body(sistema.loja!),
      );
    });
  }

  _body(Loja loja) {
    return Center(
      child: Container(
        width: 500,
        child: Container(
          margin: EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2,
            scrollDirection: Axis.vertical,
            crossAxisSpacing: 16,
            padding: EdgeInsets.all(16),
            children: [
              WidgetCardMenuInicial(
                cor: Colors.amber,
                titulo: 'Novo veículo',
                subtitulo: 'Cadastro de veículos e peças para venda',
                icone: Icons.car_repair,
                onPressed: () => onPressNovo(context),
              ),
              Consumer<Sistema>(builder: (context, sistema, child) {
                return WidgetCardMenuInicial(
                  cor: Colors.blueAccent,
                  titulo: 'Alterar dados',
                  subtitulo: 'Alteração de dados dos veículos',
                  icone: Icons.chrome_reader_mode_outlined,
                  onPressed: () =>
                      onPressAlterar(context, sistema.loja!.lojId!),
                );
              }),
              WidgetCardMenuInicial(
                cor: Colors.lime,
                titulo: 'Meus dados',
                subtitulo: 'Alteração de dados da empresa',
                icone: Icons.home_work_sharp,
                onPressed: () => onPressCadastroLoja(context, loja),
              ),
              WidgetCardMenuInicial(
                cor: Colors.teal,
                titulo: 'Sair',
                subtitulo: '',
                icone: Icons.close,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => Login(login: '', senha: '')),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
