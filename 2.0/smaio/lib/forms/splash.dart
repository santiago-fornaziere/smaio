import 'package:flutter/material.dart';
import 'package:smaio/forms/consumidor/form.consumidor.fabricante.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/circularProgress.dart';

// ignore: must_be_immutable
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future futureA = getPosicao();

    Future.wait([futureA]).then((List values) {
      push(context, ConsumidorFabricante(), replace: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
          ),
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
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 50,
          ),
          WidgetCircularProgress(),
        ],
      ),
    );
  }
}
