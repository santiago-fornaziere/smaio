import 'package:flutter/material.dart';
import 'package:smaio/models/model.peca.dart';

class Pecas extends ChangeNotifier {
  List<Peca> pecas;
  bool showProgress = false;
  Pecas({
    required this.pecas,
    required this.showProgress,
  });

  void setPecas(List<Peca> pValue) {
    this.pecas = pValue;
    this.setShowProgress(false);
    notifyListeners();
  }

  void setShowProgress(bool value) {
    this.showProgress = value;
    notifyListeners();
  }

  void removePecas(Peca pValue) {
    this.pecas.remove(pValue);
    this.setShowProgress(false);
    notifyListeners();
  }
}
