import 'package:flutter/material.dart';
import 'package:smaio/models/model.item.dart';

class Itens extends ChangeNotifier {
  List<Item> itens;
  bool showProgress = false;
  Itens({
    required this.itens,
    required this.showProgress,
  });

  void setItens(List<Item> pValue) {
    this.itens = pValue;
    this.setShowProgress(false);
    notifyListeners();
  }

  void removeItens(Item pValue) {
    this.itens.remove(pValue);
    notifyListeners();
  }

  void setShowProgress(bool value) {
    this.showProgress = value;

    notifyListeners();
  }
}
