import 'package:flutter/material.dart';
import 'package:smaiosenha/alterar_senha_solicitar.dart';
import 'package:smaiosenha/funcoes.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      backgroundColor: Colors.orange[50],
    );
  }

  _body() {
    return Center(
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
            SizedBox(
              height: 16,
            ),
            TextButton(
                onPressed: () => esqueciSenha(),
                child: Text('Esqueci minha senha'))
          ],
        ),
      ),
    );
  }

  esqueciSenha() {
    push(context, EsqueciSenha());
  }
}
