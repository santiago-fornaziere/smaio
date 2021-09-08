import 'package:flutter/material.dart';
import 'package:smaiosenha/alterar_senha_sucesso.dart';
import 'package:smaiosenha/controller/controller_usuario.dart';
import 'package:smaiosenha/funcoes.dart';
import 'package:smaiosenha/widgets/botaoPadrao.dart';
import 'package:smaiosenha/widgets/edit.texto.dart';

// ignore: must_be_immutable
class AlterarSenha extends StatefulWidget {
  String usuario;
  String codigo;

  AlterarSenha({
    required this.usuario,
    required this.codigo,
  });

  @override
  State<AlterarSenha> createState() => _AlterarSenha();
}

class _AlterarSenha extends State<AlterarSenha> {
  final _formKey = GlobalKey<FormState>();

  final _senha1Controller = TextEditingController();
  final _senha2Controller = TextEditingController();

  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alterar senha de ${widget.usuario}'),
      ),
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
          height: 450,
          width: 400,
          child: Column(
            children: [
              Image.asset(
                'assets/img/logo-amarelo.png',
                height: 98,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Informe sua nova senha',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              WidgetEditTexto(
                context: context,
                controller: _senha1Controller,
                label: 'Senha',
                autofocos: true,
                enabled: true,
                password: true,
              ),
              SizedBox(
                height: 10,
              ),
              WidgetEditTexto(
                context: context,
                controller: _senha2Controller,
                label: 'Confirmação',
                autofocos: false,
                enabled: true,
                password: true,
              ),
              SizedBox(
                height: 10,
              ),
              WidgetBotaoPadrao(
                showProgress: _showProgress,
                texto: 'Salvar',
                onPressed: () => resetSenha(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  resetSenha() async {
    if (_formKey.currentState!.validate() &&
        (_senha1Controller.text == _senha2Controller.text)) {
      setState(() {
        _showProgress = true;
      });
      Retorno retorno =
          await UsuarioApi.consultaReset(int.parse(widget.codigo));
      if (retorno.status == 200) {
        Retorno alterar = await UsuarioApi.resetSenha(
            int.parse(widget.codigo), _senha1Controller.text);
        if (alterar.status == 200) {
          push(context, AlterarSenhaSucesso(), replace: true);
          setState(() {
            _showProgress = false;
          });
        } else {
          showSnackMessage(context, 'Erro ao alterar a senha.');
          setState(() {
            _showProgress = false;
          });
        }
      } else {
        showSnackMessage(context, retorno.texto);
        setState(() {
          _showProgress = false;
        });
      }
    } else {
      if (_senha1Controller.text != _senha2Controller.text) {
        showMessage(context, 'Valores digitados são diferentes...');
      }
      setState(() {
        _showProgress = false;
      });
    }
  }
}
