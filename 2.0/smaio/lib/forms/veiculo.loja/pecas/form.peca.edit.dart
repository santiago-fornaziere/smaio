import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.item.dart';
import 'package:smaio/models/model.item.dart';
import 'package:smaio/models/model.peca.veiloja.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/notifiers/notifier.peca.veiloja.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/appBarTransparente.dart';
import 'package:smaio/widgets/geral/bottonNavigationBarSalvar.dart';
import 'package:smaio/widgets/geral/controller.mask.float.dart';
import 'package:smaio/widgets/geral/edit.decimal.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FormPecaEdit extends StatefulWidget {
  VeiculoLoja veiloja;
  PecaVeiLoja peca;
  int indice;
  List<bool> isSelectedTipo;
  FormPecaEdit({
    required this.veiloja,
    required this.peca,
    required this.indice,
    required this.isSelectedTipo,
  });
  @override
  _FormPecaEdit createState() => _FormPecaEdit();
}

class _FormPecaEdit extends State<FormPecaEdit> {
  final _formKey = GlobalKey<FormState>();

  final _valorController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final _descricaoController = TextEditingController();

  final _focus = FocusNode();

  bool _showProgress = false;

  int tipoID = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarTransparente(
        titulo: widget.peca.pecDescricao.toString(),
        mostraIcone: false,
        tema: 0,
      ),
//      backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: corTemaDark,
      bottomNavigationBar:
          Consumer<PecaVeiLojas>(builder: (context, lista, child) {
        return WidgetBottonNavigatorBarSalvar(
          context: context,
          onPressed: () async {
            setState(() {
              _showProgress = true;
            });
            _descricaoController.text = condicaoPecas[tipoID];
            try {
              Item item = Item(
                iteId: widget.peca.pecIteId,
                iteDescricao: _descricaoController.text,
                iteVlojId: widget.veiloja.vlojId,
                itePecId: widget.peca.pecId,
                iteValor: _valorController.numberValue,
                iteSituacao: 'Semi-novo',
                iteStatus: 'A venda',
                iteSitReg: true,
                iteTraEntrada: 0,
              );
              Item retorno;
              if (widget.peca.pecIteId == null) {
                retorno = await ItemApi.post(item);
              } else {
                retorno = await ItemApi.put(item);
              }
              if (retorno.iteId != null) {
                widget.peca.pecIteValor = retorno.iteValor;
                widget.peca.pecIteDescricao = retorno.iteDescricao;
                widget.peca.pecIteId = retorno.iteId;
                widget.peca.pecIteVlojId = retorno.iteVlojId;
                lista.udpateUpPecas(widget.peca, widget.indice);
                setState(() {
                  _showProgress = false;
                });
                Navigator.pop(context);
              } else {
                setState(() {
                  _showProgress = false;
                });
                showSnackMessage(context, 'Erro ao gravar dados...');
                lista.setShowProgress(false);
              }
            } catch (e) {
              setState(() {
                _showProgress = false;
              });
              showSnackMessage(context, 'Erro ao gravar dados...');
              lista.setShowProgress(false);
            }
          },
          showProgress: _showProgress,
        );
      }),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Container(
        width: 500,
        margin: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                padding: EdgeInsets.only(left: 23),
                child: Text(
                  'Valor atual \nR\$ ${formatFloat.format(widget.peca.pecIteValor ?? 0)}',
                  style: TextStyle(
                    color: corTextoPadrao[0],
                  ),
                ),
              ),
              WidgetEditDecimal(
                controller: _valorController,
                context: context,
                autofocos: true,
                focusNode: _focus,
                label: (widget.peca.pecIteId == null)
                    ? 'Novo valor da peça R\$'
                    : 'Valor da peça R\$',
              ),
              toogleButtonDescricao(),
            ],
          ),
        ),
      ),
    );
  }

  toogleButtonDescricao() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Qual o estado da peça?',
              style: TextStyle(
                fontSize: fontSizePadrao,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ToggleButtons(
            fillColor: Colors.green,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Icon(
                      Icons.fiber_new_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                    Text(
                      condicaoPecas[0],
                      style: TextStyle(
                        fontSize: fontSizePequeno,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Icon(
                      Icons.bedtime_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                    Text(
                      condicaoPecas[1],
                      style: TextStyle(
                        fontSize: fontSizePequeno,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Icon(
                      Icons.broken_image_sharp,
                      size: 60,
                      color: Colors.white,
                    ),
                    Text(
                      condicaoPecas[2],
                      style: TextStyle(
                        fontSize: fontSizePequeno,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < widget.isSelectedTipo.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    widget.isSelectedTipo[buttonIndex] = true;
                    tipoID = index;
                  } else {
                    widget.isSelectedTipo[buttonIndex] = false;
                  }
                }
              });
            },
            isSelected: widget.isSelectedTipo,
          ),
        ],
      ),
    );
  }
}
