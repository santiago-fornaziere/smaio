import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.item.dart';
import 'package:smaio/controllers/controller.semresultado.dart';
import 'package:smaio/forms/consumidor/form.consumidor.fabricante.dart';
import 'package:smaio/models/model.item.dart';
import 'package:smaio/models/model.peca.dart';
import 'package:smaio/models/model.veiano.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/circularProgressMini.dart';
import 'package:smaio/widgets/geral/edit.texto.dart';
import 'package:smaio/widgets/geral/lista.item.dart';

// ignore: must_be_immutable
class ConsumidorItem extends StatefulWidget {
  VeiAno veiano;
  Peca peca;
  ConsumidorItem({
    required this.veiano,
    required this.peca,
  });
  @override
  _ConsumidorItem createState() => _ConsumidorItem();
}

bool _showProgress = false;
final _formKey = GlobalKey<FormState>();

final _emailController = TextEditingController();
final _foneController = TextEditingController();

final _focus = FocusNode();

class _ConsumidorItem extends State<ConsumidorItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/img/logo-top.png',
          height: 22,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () => push(context, ConsumidorFabricante()),
            child: Container(
              width: 80,
              child: Icon(
                Icons.home,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _futureBuilder(),
    );
  }

  _futureBuilder() {
    Future<List<Item>> future;
    if (widget.veiano.vanoId! > 0) {
      future = ItemApi.getWhere(
          'ite_sit_reg = true and ite_pec_id = ${widget.peca.pecId} and ite_mod_id = ${widget.veiano.vanoModId} and ite_vano_ano_id = ${widget.veiano.vanoAnoId} and ite_vei_id = ${widget.veiano.vanoVeiId}',
          'ite_pec_descricao');
    } else {
      future = ItemApi.getWhere(
          'ite_sit_reg = true and ite_pec_id = ${widget.peca.pecId} and ite_mod_id = ${widget.veiano.vanoModId} and ite_vano_ano_id = ${widget.veiano.vanoAnoId}',
          'ite_pec_descricao');
    }

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<Item>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Não foi possível concluir esta ação!",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Item> query = snapshot.data!;
        return query.isNotEmpty ? _body(query) : _bodySemRegistro();
      },
    );
  }

  _body(List<Item> query) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Center(
                child: Text(
                  '${widget.peca.pecDescricao.toString()} - ${widget.veiano.vanoVeiFabNome.toString()} / ${widget.veiano.vanoModDescricao.toString()}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: fontSizePadrao,
                  ),
                ),
              ),
            ),
            Expanded(
              child: WidgetItemLista(
                context: context,
                query: query,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _bodySemRegistro() {
    return Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Desculpe!!!!!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'Nenhuma peça cadastrada com as características solicitadas. Deixe seu contato que todos os Ferro velhos serão notificados.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: fontSizePadrao,
                      ),
                    ),
                  ),
                  Container(
                    width: 600,
                    child: WidgetEditTexto(
                      controller: _emailController,
                      context: context,
                      label: 'e-mail',
                      focusNode: _focus,
                      // autofocos: true,
                    ),
                  ),
                  Container(
                    width: 600,
                    child: WidgetEditTexto(
                      controller: _foneController,
                      context: context,
                      label: 'Fone (Whatsapp)',
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _showProgress = true;
                          });
                          onEnviarSemResultado(
                              context,
                              widget.peca,
                              widget.veiano,
                              _emailController.text,
                              _foneController.text);
                          _emailController.clear();
                          _foneController.clear();
                          setState(() {
                            _showProgress = false;
                          });
                        } else {
                          setState(() {
                            _showProgress = false;
                          });
                        }
                      },
                      child: !_showProgress
                          ? Text('Enviar')
                          : WidgetCircularProgressMini(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
