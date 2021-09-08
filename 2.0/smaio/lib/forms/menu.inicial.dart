import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.menu.inicial.dart';
import 'package:smaio/forms/form.login.dart';
import 'package:smaio/models/model.loja.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:provider/provider.dart';
import 'package:smaio/widgets/geral/cardMenuInicialLista.dart';

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
          height: 0,
          titulo: '',
          mostraIcone: false,
          tema: 0,
        ),
        // backgroundColor: Color.fromRGBO(231, 135, 41, 1),
        backgroundColor: Theme.of(context).primaryColor,
        body: _body(sistema.loja!),
        bottomNavigationBar: Container(
          height: 20,
          child: Column(
            children: [
              Text(
                'Dúvidas, visite a nossa página: www.smaio.com.br',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }

  _body(Loja loja) {
    return Center(
      child: Container(
        width: 500,
        child: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(0),
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        const Radius.circular(20.0),
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    height: 120,
                    width: 120,
                    child: Image.asset('assets/img/logo-amarelo.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  loja.lojNome.toString().toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 25),
                child: Text(
                  'Número de cadastro: ${loja.lojId.toString()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              WidgetCardMenuInicialLista(
//                cor: Colors.deepOrange,
                cor: Color.fromRGBO(237, 154, 63, 1),
                titulo: 'Novo veículo',
                subtitulo: 'Cadastro de veículos e peças para venda',
                icone: Icons.car_repair,
                onPressed: () => onPressNovo(context),
              ),
              Consumer<Sistema>(builder: (context, sistema, child) {
                return WidgetCardMenuInicialLista(
//                  cor: Colors.orange,
                  cor: Color.fromRGBO(251, 176, 66, 1),
                  titulo: 'Alterar dados',
                  subtitulo:
                      'Alteração de dados dos veículos (fotos, adição e exclusão de peças)',
                  icone: Icons.chrome_reader_mode_outlined,
                  onPressed: () =>
                      onPressAlterar(context, sistema.loja!.lojId!),
                );
              }),
              WidgetCardMenuInicialLista(
                cor: Color.fromRGBO(252, 213, 56, 1),
//                cor: Colors.amber,
                titulo: 'Meus dados',
                subtitulo: 'Alteração de dados da empresa',
                icone: Icons.home_work_sharp,
                onPressed: () => onPressCadastroLoja(context, loja),
              ),
              WidgetCardMenuInicialLista(
                cor: Color.fromRGBO(253, 225, 113, 1),
//                cor: Colors.yellowAccent,
                titulo: 'Sair',
                subtitulo: '',
                icone: Icons.close,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Login(login: '')),
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
