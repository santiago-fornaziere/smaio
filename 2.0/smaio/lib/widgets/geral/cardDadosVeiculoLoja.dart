import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smaio/controllers/controller.item.dart';
import 'package:smaio/controllers/controller.veiculoloja.dart';
import 'package:smaio/forms/veiculo.loja/alterar/form.alterar.lista.dart';
import 'package:smaio/models/model.veiculoloja.dart';
import 'package:smaio/utils/const.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/widgets/geral/circularProgressMini.dart';

// ignore: must_be_immutable
class WidgetCardDadosVeiculoLoja extends StatelessWidget {
  VeiculoLoja veiloja;
  WidgetCardDadosVeiculoLoja({
    required this.veiloja,
  });

  bool showProgress = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Container(
        child: ListTile(
          title: Text(
            veiloja.vlojVeiDescricao.toString(),
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            '${veiloja.vlojAnoDescricao} - ${veiloja.vlojVeiFabNome}',
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          leading: (veiloja.foto != null)
              ? Container(
                  child: Image.memory(
                    base64Decode(veiloja.foto),
                    fit: BoxFit.fitHeight,
                  ),
                )
              : Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.grey,
                  size: 50,
                ),
          trailing: !showProgress
              ? Container(
                  height: 50,
                  width: 210,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => baixarcarro(context, veiloja),
                        child: Column(
                          children: [
                            Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 20,
                            ),
                            Text(
                              'Baixar carro',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: fontSizePequeno,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          showProgress = true;
                          bool retorno =
                              await ItemApi.insertAll(veiloja.vlojId!);
                          if (retorno) {
                            showProgress = false;
                            showSnackMessage(
                                context, 'Peças cadastradas com sucesso!');
                          } else {
                            showProgress = false;
                            showSnackMessage(
                                context, 'Erro ao cadastrar as peças...');
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 20,
                            ),
                            Text(
                              'Todas as peças',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: fontSizePequeno,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: 25,
                  width: 25,
                  child: Center(
                    child: WidgetCircularProgressMini(),
                  ),
                ),
        ),
      ),
    );
  }

  baixarcarro(BuildContext context, VeiculoLoja veiloja) async {
    showSnackMessage(context, 'Aguarde confirmação de baixa...');
    showProgress = true;
    (context as Element).markNeedsBuild();
    veiloja.vlojAtivo = false;
    int retorno = await VeiculoLojaApi.patch(veiloja);
    if (retorno == 201) {
      push(
          context,
          AlterarLista(
            loja: veiloja.vlojLojId!,
          ),
          replace: true);

      showProgress = false;
      (context).markNeedsBuild();
    } else {
      showSnackMessage(context, 'Erro ao baixar carro.');
    }
  }
}
