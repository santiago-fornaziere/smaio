import 'package:flutter/material.dart';
import 'package:smaio/models/model.fabricante.dart';

class Fabricantes extends ChangeNotifier {
  List<Fabricante> fabricantes;
  List<Fabricante>? fabricantesFilter;
  Fabricantes({
    required this.fabricantes,
    this.fabricantesFilter,
  });

  void setFabricantes(List<Fabricante> pFabricantes) {
    this.fabricantes = pFabricantes;
    this.fabricantesFilter = pFabricantes;

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
