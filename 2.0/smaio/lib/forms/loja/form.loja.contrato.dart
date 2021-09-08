import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.loja.dart';
import 'package:smaio/forms/form.login.dart';
import 'package:smaio/models/model.loja.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/circularProgressMini.dart';

// ignore: must_be_immutable
class CadastroLojaContrato extends StatefulWidget {
  LojaUsuario loja;
  String contrato;
  CadastroLojaContrato({
    required this.loja,
    required this.contrato,
  });

  @override
  _CadastroLojaContrato createState() => _CadastroLojaContrato();
}

class _CadastroLojaContrato extends State<CadastroLojaContrato> {
  bool _showProgress = false;
  bool _concordo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contrato de adesão',
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Container(
        width: 500,
        child: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/img/logo-escura.png',
                  height: 80,
                ),
              ),

              // incluir o texto e o checkbox
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.contrato,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: fontSizePequeno, color: Colors.black),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                      checkColor: Colors.white,
                      value: _concordo,
                      onChanged: (bool? value) {
                        setState(() {
                          _concordo = value!;
                        });
                      }),
                  Text('Li e concordo.'),
                ],
              ),
              Container(
                margin: EdgeInsets.all(30),
                child: !_showProgress
                    ? ElevatedButton(
                        onPressed: _concordo
                            ? () async {
                                RetornoLoja retorno =
                                    await LojaApi.post(widget.loja);
                                if (retorno.statusCode == 201) {
                                  setState(() {
                                    _showProgress = false;
                                  });
                                  showSnackMessage(context,
                                      'Cadastro enviado, a Smaio entrará em contato para orientações de como iniciar seus anuncios.');
                                  push(
                                      context,
                                      Login(
                                        login: widget.loja.loja!.lojEmail
                                            .toString(),
                                      ),
                                      replace: true);
                                } else {
                                  setState(() {
                                    _showProgress = false;
                                  });
                                  showSnackMessage(
                                      context,
                                      'Erro ao gravar os dados: ' +
                                          retorno.mensagem);
                                }
                              }
                            : null,
                        child: Container(
                          height: 40,
                          child: Center(
                            child: Text(
                              'Salvar',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : WidgetCircularProgressMini(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
