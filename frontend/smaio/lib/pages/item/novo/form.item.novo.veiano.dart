import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/models/model.ano.dart';
import 'package:smaio/models/model.fabricante.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widgets/lista.veiculo.veiano.dart';

// ignore: must_be_immutable
class ItemNovoVeiAnoLocalizar extends StatefulWidget {
  Ano ano;
  Fabricante fabricante;
  ItemNovoVeiAnoLocalizar({
    required this.ano,
    required this.fabricante,
  });
  @override
  State<StatefulWidget> createState() => _ItemNovoVeiAnoLocalizar();
}

class _ItemNovoVeiAnoLocalizar extends State<ItemNovoVeiAnoLocalizar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<Sistema>(
          builder: (context, sistema, child) {
            return Text(sistema.loja!.lojNome.toString());
          },
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => onClickLogout(context),
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          formTitulo(
            "NOVO ITEM PARA VENDA - ${widget.ano.anoDescricao} > ${widget.fabricante.fabNome}",
            Icons.shopping_cart,
            MediaQuery.of(context).size.width,
          ),
          formCorpoCadastro(context, null, _lista())
        ],
      ),
    );
  }

  List<Widget> _lista() {
    return <Widget>[
      WidgetVeiculoVeiAnoLista(
        context: context,
      ),
    ];
  }
}
