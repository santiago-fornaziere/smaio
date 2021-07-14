import 'package:flutter/material.dart';
import 'package:smaio/forms/form.config.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';

// ignore: must_be_immutable
class FormInformacoesLegais extends StatefulWidget {
  String texto;
  FormInformacoesLegais({
    required this.texto,
  });
  @override
  _FormInformacoesLegais createState() => _FormInformacoesLegais();
}

class _FormInformacoesLegais extends State<FormInformacoesLegais> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: '',
        onPressed: () => push(context, Config()),
        mostraIcone: true,
        tema: 1,
      ),
      backgroundColor: Colors.red,
      body: _body(),
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
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Informações legais',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.texto,
                  style:
                      TextStyle(fontSize: fontSizePequeno, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
