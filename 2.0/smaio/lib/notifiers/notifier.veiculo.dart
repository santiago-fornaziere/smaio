import 'package:flutter/material.dart';
import 'package:smaio/models/model.veiculo.dart';

class Veiculos extends ChangeNotifier {
  List<Veiculo> veiculos;
  bool showProgress;
  Veiculos({
    required this.veiculos,
    required this.showProgress,
  });

  void setVeiculos(List<Veiculo> pVeiculo) {
    this.veiculos = pVeiculo;
    this.setShowProgress(false);
    notifyListeners();
  }

  void setShowProgress(bool value) {
    this.showProgress = value;
    notifyListeners();
  }
}
