import 'package:flutter/material.dart';
import 'package:smaio/models/model.veiculoloja.dart';

class VeiLojas extends ChangeNotifier {
  List<VeiculoLoja> veilojas;
  bool showProgress;
  VeiLojas({
    required this.veilojas,
    required this.showProgress,
  });

  void setVeiLojas(List<VeiculoLoja> pVeiculo) {
    this.veilojas = pVeiculo;
    this.setShowProgress(false);
    notifyListeners();
  }

  void setShowProgress(bool value) {
    this.showProgress = value;
    notifyListeners();
  }
}
