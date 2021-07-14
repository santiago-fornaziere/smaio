import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.loja.dart';
import 'package:smaio/controllers/controller.token.dart';
import 'package:smaio/forms/consumidor/form.consumidor.fabricante.dart';
import 'package:smaio/forms/menu.inicial.dart';
import 'package:smaio/models/model.loja.dart';
import 'package:smaio/models/model.usuario.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/prefs.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/botaoPadrao.dart';
import 'package:smaio/widgets/geral/edit.texto.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  String login;
  String senha;
  Login({
    required this.login,
    required this.senha,
  });
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();

  final _focusLogin = FocusNode();

  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    _loginController.text = widget.login;
    _senhaController.text = widget.senha;
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: '',
        tema: 0,
        mostraIcone: true,
        onPressed: () => push(context, ConsumidorFabricante()),
      ),
      // backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: corTemaDark,
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Container(
        width: 400,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.asset(
                'assets/img/logo-amarelo.png',
                height: 98,
              ),
              WidgetEditTexto(
                context: context,
                controller: _loginController,
                label: 'Usuário',
                autofocos: true,
                focusNode: _focusLogin,
              ),
              WidgetEditTexto(
                context: context,
                controller: _senhaController,
                label: 'Senha',
                password: true,
              ),
              Consumer<Sistema>(builder: (context, sistema, child) {
                return WidgetBotaoPadrao(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _showProgress = true;
                      });
                      String token = await TokenApi.post(
                          _loginController.text.toLowerCase().trim(),
                          _senhaController.text);
                      if (token.length > 0) {
                        await Prefs.setString('senha', _senhaController.text);
                        Usuario usuario = await TokenApi.getClaims(token);
                        sistema.setUsuario(usuario);
                        List<Loja> loja = await LojaApi.getByUsuario(
                            usuario.usuId.toString());
                        sistema.setLoja(loja[0]);
                        push(context, MenuInicial());
                        setState(() {
                          _showProgress = false;
                        });
                      } else {
                        setState(() {
                          _showProgress = false;
                        });
                        showMessage(context, 'Erro na validação do usuário.');
                      }
                    } else {
                      setState(() {
                        _showProgress = false;
                      });
                    }
                  },
                  texto: 'Entrar',
                  showProgress: _showProgress,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
