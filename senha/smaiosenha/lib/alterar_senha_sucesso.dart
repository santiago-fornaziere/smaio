import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AlterarSenhaSucesso extends StatefulWidget {
  @override
  State<AlterarSenhaSucesso> createState() => _AlterarSenhaSucesso();
}

class _AlterarSenhaSucesso extends State<AlterarSenhaSucesso> {
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
        child: Center(
          child: Text(
            'Senha alterada com sucesso!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
