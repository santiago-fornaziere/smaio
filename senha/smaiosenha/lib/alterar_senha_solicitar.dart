import 'package:flutter/material.dart';
import 'package:smaiosenha/controller/controller_usuario.dart';
import 'package:smaiosenha/funcoes.dart';
import 'package:smaiosenha/home.dart';
import 'package:smaiosenha/widgets/botaoPadrao.dart';
import 'package:smaiosenha/widgets/edit.texto.dart';

// ignore: must_be_immutable
class EsqueciSenha extends StatefulWidget {
  @override
  State<EsqueciSenha> createState() => _EsqueciSenha();
}

class _EsqueciSenha extends State<EsqueciSenha> {
  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();

  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      backgroundColor: Colors.orange[50],
    );
  }

  _body() {
    return Center(
      child: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(
              const Radius.circular(40.0),
            ),
          ),
          padding: EdgeInsets.all(16),
          height: 300,
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/logo-amarelo.png',
                height: 98,
              ),
              WidgetEditTexto(
                controller: _loginController,
                context: context,
                label: 'e-mail',
              ),
              SizedBox(
                height: 10,
              ),
              WidgetBotaoPadrao(
                showProgress: _showProgress,
                texto: 'Alterar senha',
                onPressed: () => buscaAlterar(_loginController.text),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buscaAlterar(String text) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showProgress = true;
      });
      Retorno retorno = await UsuarioApi.consultaEmail(text);
      if (retorno.status == 200) {
        UsuarioApi.enviarEmail(int.parse(retorno.texto));
        setState(() {
          _showProgress = false;
        });
        push(context, Home(), replace: true);
      } else {
        showMessage(
            context, 'E-mail não encontrado na base de dados da Smaio.');
        setState(() {
          _showProgress = false;
        });
      }
    } else {
      setState(() {
        _showProgress = false;
      });
    }
  }
}
