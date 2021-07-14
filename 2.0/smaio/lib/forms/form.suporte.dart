import 'package:flutter/material.dart';
import 'package:smaio/forms/consumidor/form.consumidor.fabricante.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

// ignore: must_be_immutable
class FormSuporte extends StatefulWidget {
  @override
  _FormSuporte createState() => _FormSuporte();
}

class _FormSuporte extends State<FormSuporte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: '',
        mostraIcone: true,
        onPressed: () => Navigator.of(context).pop(),
        tema: 1,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () => push(context, ConsumidorFabricante()),
        child: Icon(Icons.home),
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
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Suporte',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSizePadrao,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Divider(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => onEmail(),
                      child: Image.asset(
                        'assets/img/gmail.png',
                        height: 80,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => onWhatsapp(),
                      child: Image.asset(
                        'assets/img/whatsapp.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  onEmail() async {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'atendimento@smaio.com.br',
        queryParameters: {'subject': 'Atendimento'});
    launch(_emailLaunchUri.toString());
  }

  onWhatsapp() async {
    String url = '';
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      final link = WhatsAppUnilink(
        phoneNumber: phone,
        text: "Olá Smaio! Preciso de ajuda.",
      );
      url = '$link';
    } else {
      url = "https://api.whatsapp.com/send?phone=$phone";
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possivel acessar $url';
    }
  }
}
