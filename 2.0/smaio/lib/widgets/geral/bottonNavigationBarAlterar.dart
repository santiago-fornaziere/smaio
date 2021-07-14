import 'package:flutter/material.dart';
import 'package:smaio/forms/menu.inicial.dart';
import 'package:smaio/forms/veiculo.loja/pecas/form.peca.grupo.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';

// ignore: must_be_immutable
class WidgetBottonNavigatorBarAlterar extends StatelessWidget {
  BuildContext context;
  VeiculoLoja veiloja;
  bool voltar;
  WidgetBottonNavigatorBarAlterar({
    required this.context,
    required this.veiloja,
    required this.voltar,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.black54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              !voltar
                  ? push(context, MenuInicial())
                  : Navigator.of(context).pop();
            },
            child: Container(
              width: 100,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(14),
              child: Text(
                '<< Voltar',
                style: TextStyle(
                  color: corTextoPadrao[0],
                  fontSize: fontSizePadrao,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width - 350,
            child: InkWell(
              onTap: () => push(context, MenuInicial()),
              child: Image.asset('assets/img/logo-amarelo.png'),
            ),
          ),
          InkWell(
            onTap: () {
              push(
                  context,
                  PecaGrupo(
                    veiloja: veiloja,
                  ));
            },
            child: Container(
              width: 150,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.all(14),
              child: Text(
                'Alterar peças >>',
                style: TextStyle(
                  color: corTextoPadrao[0],
                  fontSize: fontSizePadrao,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
