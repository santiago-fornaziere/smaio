import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/controllers/controller.item.dart';
import 'package:smaio/models/model.item.dart';
import 'package:smaio/models/model.subgrupoveiano.dart';
import 'package:smaio/notifiers/notifier.sistema.dart';
import 'package:smaio/utils/widget.botao.gravar.dart';
import 'package:smaio/utils/widget.form.corpo.dart';
import 'package:smaio/utils/widget.form.titulo.dart';
import 'package:provider/provider.dart';
import 'package:smaio/utils/widgets/edit.decimal.dart';
import 'package:smaio/utils/widgets/edit.texto.dart';

// ignore: must_be_immutable
class ItemNovoFormularioLocalizar extends StatefulWidget {
  SubGrupoVeiAno sgvano;
  ItemNovoFormularioLocalizar({
    required this.sgvano,
  });
  @override
  State<StatefulWidget> createState() => _ItemNovoFormularioLocalizar();
}

class _ItemNovoFormularioLocalizar extends State<ItemNovoFormularioLocalizar> {
  final _formKey = GlobalKey<FormState>();
  final _focus = FocusNode();

  final _iteDescricaoController = TextEditingController();
  final _iteValorController = TextEditingController();

  bool _showProgress = false;

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
            "NOVO ITEM PARA VENDA - ${widget.sgvano.sgvanoVanoAnoDescricao} > ${widget.sgvano.sgvanoVanoVeiFabNome} > ${widget.sgvano.sgvanoVanoVeiDescr} > ${widget.sgvano.sgvanoPecDescricao} > ${widget.sgvano.sgvanoSgruDescricao}",
            Icons.shopping_cart,
            MediaQuery.of(context).size.width,
          ),
          formCorpoCadastro(context, _formKey, _lista())
        ],
      ),
    );
  }

  List<Widget> _lista() {
    return <Widget>[
      WidgetEditTexto(
        context: context,
        descricao: _iteDescricaoController,
        texto: 'Descrição do produto',
        focusNode: _focus,
      ),
      WidgetEditDecimal(
        context: context,
        controller: _iteValorController,
        label: 'R\$ Valor',
      ),
      Consumer<Sistema>(builder: (context, sistema, child) {
        return Container(
          padding: EdgeInsets.all(20),
          child: BotaoGravar(
              showprogress: _showProgress,
              onPressed: () async {
                setState(() {
                  _showProgress = true;
                });
                Item item = new Item();
                item.iteDescricao = _iteDescricaoController.text;
                item.iteSgvanoId = widget.sgvano.sgvanoId;
                item.iteValor = double.parse(_iteValorController.text);
                item.iteSituacao = 'Semi-novo';
                item.iteStatus = 'Á venda';
                item.iteLojId = sistema.loja!.lojId!;
                item.iteLojNome = sistema.loja!.lojNome;
                item.iteSitReg = true;
                int retorno = await ItemApi.post(item);
                if (retorno == 201) {
                  Navigator.pop(context);
                }
              }),
        );
      }),
    ];
  }
}
