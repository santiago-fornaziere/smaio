import 'package:flutter/cupertino.dart';
import 'package:smaio/forms/veiculo.loja/alterar/form.alterar.lista.dart';
import 'package:smaio/forms/veiculo.loja/novo/form.novo.veiculo.loja.fabricante.dart';
import 'package:smaio/models/model.loja.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:smaio/forms/form.loja.dart';

void onPressNovo(BuildContext context) {
  String file1 = '';
  String file2 = '';
  String file3 = '';
  String file4 = '';
  String file5 = '';
  String file6 = '';

  List<String> files = [];
  files.add(file1);
  files.add(file2);
  files.add(file3);
  files.add(file4);
  files.add(file5);
  files.add(file6);

  push(context, NovoVeiculoLojaFabricante(files: files));
}

void onPressAlterar(BuildContext context, int loja) {
  push(
      context,
      AlterarLista(
        loja: loja,
      ));
}

void onPressCadastroLoja(BuildContext context, Loja loja) {
  push(
      context,
      CadastroLoja(
        loja: loja,
      ));
}
