import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.item.dart';
import 'package:smaio/forms/veiculo.loja/pecas/form.peca.edit.dart';
import 'package:smaio/models/model.peca.veiloja.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/notifiers/notifier.peca.veiloja.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:provider/provider.dart';
import 'package:smaio/widgets/geral/circularProgressMini.dart';

// ignore: must_be_immutable
class WidgetPecaVeiLojaLista extends StatelessWidget {
  BuildContext context;
  String titulo;
  VeiculoLoja veiloja;
  VoidCallback? onPressed;
  WidgetPecaVeiLojaLista({
    required this.context,
    required this.titulo,
    required this.veiloja,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height - 100,
      child: Consumer<PecaVeiLojas>(builder: (context, lista, child) {
        return ListView.builder(
          itemCount: lista.pecas.length,
          itemBuilder: (context, index) {
            var itens = lista.pecas[index];
            return Card(
              color: Colors.black87,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text(
                      itens.pecDescricao.toString(),
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: fontSizePadrao,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: (itens.pecIteId != null)
                        ? Text(
                            itens.pecIteDescricao.toString(),
                            style: TextStyle(
                              fontSize: fontSizePequeno,
                              color: Colors.white,
                            ),
                          )
                        : null,
                    leading: (itens.pecIteId != null)
                        ? InkWell(
                            onTap: () async {
                              lista.setShowProgress(true);
                              showLoadCheck(context);
                              int retorno =
                                  await ItemApi.patchBaixa(itens.pecIteId!);
                              if (retorno == 201) {
                                lista.udpateBaixaPecas(
                                    itens, lista.getIndice(itens.pecId!));
                              } else {
                                lista.setShowProgress(false);
                                showSnackMessage(
                                    context, 'Erro ao gravar dados...');
                              }
                            },
                            child: Icon(
                              Icons.check_box_outlined,
                              color: Colors.green[800],
                              size: 50,
                            ),
                          )
                        : Icon(
                            Icons.check_box_outline_blank,
                            color: Colors.grey,
                            size: 50,
                          ),
                    trailing: (itens.pecIteId != null)
                        ? Column(
                            children: [
                              Text(
                                formatFloat.format(itens.pecIteValor ?? 0),
                                style: TextStyle(
                                  fontSize: fontSizePadrao,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.greenAccent,
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 80,
                                padding: EdgeInsets.all(0),
                                child: TextButton(
                                  onPressed: () async {
                                    lista.setShowProgress(true);
                                    showLoadCheck(context);

                                    int retorno = await ItemApi.patchVendido(
                                        itens.pecIteId!);
                                    if (retorno == 201) {
                                      lista.udpateBaixaPecas(
                                          itens, lista.getIndice(itens.pecId!));
                                    } else {
                                      lista.setShowProgress(false);
                                      showSnackMessage(
                                          context, 'Erro ao gravar dados...');
                                    }
                                  },
                                  child: Text(
                                    'Vendido',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : null,
                    onTap: () {
                      int indice = lista.getIndice(itens.pecId!);
                      onSelecionaPeca(itens, indice);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  onSelecionaPeca(PecaVeiLoja peca, int indice) {
    List<bool> select = [false, false, false];
    if (peca.pecIteDescricao == condicaoPecas[0]) {
      select = [true, false, false];
    } else if (peca.pecIteDescricao == condicaoPecas[1]) {
      select = [false, true, false];
    } else if (peca.pecIteDescricao == condicaoPecas[2]) {
      select = [false, false, true];
    }
    push(
      context,
      FormPecaEdit(
          veiloja: veiloja, peca: peca, indice: indice, isSelectedTipo: select),
    );
  }
}

showLoadCheck(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10,
          content: Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              alignment: Alignment.center,
              height: 120,
              width: 150,
              child: Consumer<PecaVeiLojas>(builder: (context, lista, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: lista.showProgress
                          ? Text(
                              'Enviando dados...',
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              'Item alterado.',
                              textAlign: TextAlign.center,
                            ),
                    ),
                    !lista.showProgress
                        ? ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Container(
                              height: 60,
                              width: 100,
                              child: Center(
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : WidgetCircularProgressMiniDark(),
                  ],
                );
              }),
            ),
          ),
        );
      });
}
