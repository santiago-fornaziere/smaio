import 'package:flutter/material.dart';
import 'package:smaio/models/model.veiculo.dart';

class Veiculos extends ChangeNotifier {
  List<Veiculo> veiculos;
  Veiculos({
    required this.veiculos,
  });

  void setVeiculos(List<Veiculo> pVeiculo) {
    this.veiculos = pVeiculo;

    notifyListeners();
  }
}
