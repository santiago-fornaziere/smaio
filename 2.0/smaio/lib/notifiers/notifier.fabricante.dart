import 'package:flutter/material.dart';
import 'package:smaio/models/model.fabricante.dart';

class Fabricantes extends ChangeNotifier {
  List<Fabricante> fabricantes;
  List<Fabricante>? fabricantesFilter;
  bool showProgress = false;
  Fabricantes({
    required this.fabricantes,
    this.fabricantesFilter,
    required this.showProgress,
  });

  void setFabricantes(List<Fabricante> pFabricantes) {
    this.fabricantes = pFabricantes;
    this.fabricantesFilter = pFabricantes;
    this.setShowProgress(false);
    notifyListeners();
  }

  void setShowProgress(bool value) {
    this.showProgress = value;
    notifyListeners();
  }

  void filtroFabricantes(String pValue) {
    this.fabricantesFilter = this.fabricantes;
    this.fabricantesFilter = this
        .fabricantes
        .where((element) =>
            element.fabNome!.toUpperCase().contains(pValue.toUpperCase()))
        .toList();

    notifyListeners();
  }
}
