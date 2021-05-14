//import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/controllers/controller.token.dart';
import 'package:smaio/models/model.usuario.dart';
import 'package:smaio/pages/form.login.loja.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  String? email;
  LoginPage({
    this.email,
  });
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();

  final _loginFocus = FocusNode();

  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: _body(context),
    );
  }

  _body(context) {
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.all(
                  const Radius.circular(40.0),
                ),
              ),
              padding: EdgeInsets.all(40),
              width: 400,
              height: 415,
              child: ListView(
                children: [
                  _sizeBoxImg(),
                  _textFieldLogin(_loginController),
                  _sizeBox(10),
                  _textFieldSenha(_senhaController),
                  _sizeBox(10),
                  _botaoEntrar(context, _showProgress),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _sizeBox(double pSize) {
    return SizedBox(
      height: pSize,
    );
  }

  _sizeBoxImg() {
    return SizedBox(
        height: 120,
        width: 100,
        child: Image.asset(
          "img/logo.png",
        ));
  }

  _textFieldLogin(TextEditingController c) {
    _loginController.text = widget.email ?? '';
    return TextFormField(
      controller: c,
      autofocus: true,
      keyboardType: TextInputType.text,
      validator: (String? text) {
        return (text!.isEmpty) ? 'Preenchimento obrigatório' : null;
      },
      focusNode: _loginFocus,
      decoration: InputDecoration(
        labelText: "Usuário",
        labelStyle: TextStyle(
          color: Colors.grey[900],
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
    );
  }

  _textFieldSenha(TextEditingController c) {
    return TextFormField(
      controller: c,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: (String? text) {
        return (text!.isEmpty) ? 'Preenchimento obrigatório' : null;
      },
      decoration: InputDecoration(
        labelText: "Senha",
        labelStyle: TextStyle(
          color: Colors.grey[900],
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
    );
  }

  _botaoEntrar(BuildContext context, bool _showProgress) {
    return ElevatedButton(
      onPressed: () => _showProgress ? null : _onPressEntrar(context),
      child: _showProgress
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Container(
              height: 40,
              child: Center(
                child: Text(
                  "Entrar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
    );
  }

  void _onPressEntrar(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showProgress = true;
      });
      String retorno =
          await TokenApi.post(_loginController.text, _senhaController.text);
      if (retorno.isNotEmpty) {
        Usuario usuario = await TokenApi.getClaims(retorno);
        push(context, LoginLojaPage(usuario: usuario), replace: true);
        _loginController.clear();
        _senhaController.clear();
        setState(() {
          _showProgress = false;
        });
      } else {
        setState(() {
          _showProgress = false;
        });
        showMessage(context, 'Erro na validação de usuário e senha.');
      }
    }
  }
}
