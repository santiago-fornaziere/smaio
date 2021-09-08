import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.faleconosco.dart';
import 'package:smaio/forms/form.config.dart';
import 'package:smaio/forms/form.login.dart';
import 'package:smaio/models/model.faleconosco.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/circularProgressMini.dart';
import 'package:smaio/widgets/geral/edit.texto.dart';

// ignore: must_be_immutable
class FormFaleConosco extends StatefulWidget {
  @override
  _FormFaleConosco createState() => _FormFaleConosco();
}

bool _showProgress = false;
final _formKey = GlobalKey<FormState>();

final _emailController = TextEditingController();
final _foneController = TextEditingController();
final _nomeController = TextEditingController();
final _textoController = TextEditingController();

final _focus = FocusNode();

class _FormFaleConosco extends State<FormFaleConosco> {
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
    );
  }

  _body() {
    return Container(
      width: 600,
      margin: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
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
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Sugestões e Reclamações',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                    ),
                  ),
                ),
                WidgetEditTexto(
                  controller: _textoController,
                  context: context,
                  label: 'Mensagem',
                  focusNode: _focus,
                  autofocos: true,
                  qtdeLinhas: 5,
                ),
                WidgetEditTexto(
                  controller: _nomeController,
                  context: context,
                  label: 'Nome',
                ),
                WidgetEditTexto(
                  controller: _emailController,
                  context: context,
                  label: 'e-mail',
                ),
                WidgetEditTexto(
                  controller: _foneController,
                  context: context,
                  label: 'Telefone',
                ),
                Container(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _showProgress = true;
                        });
                        onEnviarFaleConosco(
                            context,
                            _nomeController.text,
                            _textoController.text,
                            _emailController.text,
                            _foneController.text);
                        setState(() {
                          _showProgress = false;
                        });
                        _nomeController.clear();
                        _textoController.clear();
                        _emailController.clear();
                        _foneController.clear();
                      } else {
                        setState(() {
                          _showProgress = false;
                        });
                      }
                    },
                    child: !_showProgress
                        ? Text('Enviar')
                        : WidgetCircularProgressMini(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  onJaSouCadastrado() async {
    String login = await Prefs.getString('usu_email');
    //String senha = await Prefs.getString('senha');
    push(context, Login(login: login));
  }

  Future<void> onEnviarFaleConosco(BuildContext context, String nome,
      String texto, String email, String fone) async {
    setState(() {
      _showProgress = true;
    });
    FaleConosco faleconosco = FaleConosco(
      fconNome: nome,
      fconTexto: texto,
      fconEmail: email,
      fconFone: fone,
      fconLido: false,
    );
    await FaleConoscoApi.post(faleconosco);
    push(context, Config(), replace: true);
  }
}
