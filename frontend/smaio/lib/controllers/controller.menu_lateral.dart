//import 'package:smaio/controllers/controller.dashboard.dart';
import 'package:smaio/pages/form.dashboard.dart';
import 'package:smaio/pages/peca/form.peca.localizar.dart';
import 'package:smaio/pages/veiculo/form.veiculo.localizar.dart';
import 'package:smaio/utils/funcoes.dart';
import 'package:flutter/material.dart';

onClickDashboard(BuildContext context) async {
  push(
    context,
    Dashboard(
        //graficoStatus: await DashboardApi.getByStatus(usuarioID),
        //graficoTipo: await DashboardApi.getByTipo(usuarioID),
        ),
    replace: true,
  );
}

onClikVeiculos(BuildContext context) async {
  push(context, VeiculoLocalizar());
}

onClikPecas(BuildContext context) async {
  push(context, PecaLocalizar());
}
