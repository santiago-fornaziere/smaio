import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.texto.dart';
import 'package:smaio/forms/consumidor/form.consumidor.fabricante.dart';
import 'package:smaio/forms/form.faleconosco.dart';
import 'package:smaio/forms/form.informacoes.legais.dart';
import 'package:smaio/forms/form.login.dart';
import 'package:smaio/forms/form.suporte.dart';
import 'package:smaio/forms/loja/form.loja.novo.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Config extends StatefulWidget {
  @override
  _Config createState() => _Config();
}

class _Config extends State<Config> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: '',
        mostraIcone: false,
        tema: 0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => push(context, ConsumidorFabricante()),
        child: Icon(Icons.home),
        backgroundColor: Colors.black,
        foregroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _body() {
    return Center(
      child: ListView(
        children: [
          Column(
            children: [
              Container(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () => onFaleConosco(),
                  child: Text(
                    'Sugestões e Reclamações',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () => onSuporte(),
                  child: Text(
                    'Suporte',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () => onSite(),
                  child: Text(
                    'Site',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () => onInformacoesLegais(),
                  child: Text(
                    'Informações Legais',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => onInstragram(),
                      child: Image.asset(
                        'assets/img/instagram.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => onFacebook(),
                      child: Image.asset(
                        'assets/img/facebook.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () => onCadastrar(),
                  child: Text(
                    'Quero me cadastrar',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () => onJaSouCadastrado(),
                  child: Text(
                    'Já sou cadastrado',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  onJaSouCadastrado() async {
    String login = await Prefs.getString('usu_email');
    //String senha = await Prefs.getString('senha');
    push(context, Login(login: login));
  }

  onFaleConosco() {
    push(context, FormFaleConosco());
  }

  onSuporte() {
    push(context, FormSuporte());
  }

  onInformacoesLegais() async {
    String texto = await TextoApi.getInfLegais();
    push(context, FormInformacoesLegais(texto: texto));
  }

  onSite() async {
    const url = 'http://www.smaio.com.br/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possivel acessar $url';
    }
  }

  onInstragram() async {
    const url = 'https://www.instagram.com/smaio.pecas/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possivel acessar $url';
    }
  }

  onFacebook() async {
    const url = 'https://www.facebook.com/profile.php?id=100000000000000';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possivel acessar $url';
    }
  }

  onCadastrar() async {
    push(context, CadastroLojaNovo(), replace: true);
  }
}
