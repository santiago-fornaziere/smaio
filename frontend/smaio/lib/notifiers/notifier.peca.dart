import 'package:flutter/material.dart';
import 'package:smaio/models/model.peca.dart';

class Pecas extends ChangeNotifier {
  List<Peca> pecas;
  Pecas({
    required this.pecas,
  });

  void setPecas(List<Peca> pValue) {
    this.pecas = pValue;
    notifyListeners();
  }

  void removePecas(Peca pValue) {
    this.pecas.remove(pValue);
    notifyListeners();
  }
}
