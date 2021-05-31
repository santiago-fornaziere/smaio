import 'package:flutter/material.dart';
import 'package:smaio/models/model.peca.veiloja.dart';

class PecaVeiLojas extends ChangeNotifier {
  List<PecaVeiLoja> pecas;
  bool showProgress = false;
  PecaVeiLojas({
    required this.pecas,
    required this.showProgress,
  });

  void setPecas(List<PecaVeiLoja> pValue) {
    this.pecas = pValue;
    this.setShowProgress(false);
    notifyListeners();
  }

  void removePecas(PecaVeiLoja pValue) {
    this.pecas.remove(pValue);
    this.setShowProgress(false);
    notifyListeners();
  }

  void addPecas(PecaVeiLoja pValue) {
    this.pecas.add(pValue);
    this.setShowProgress(false);
    notifyListeners();
  }

  void setShowProgress(bool value) {
    this.showProgress = value;
    notifyListeners();
  }

  void udpateBaixaPecas(PecaVeiLoja pValue, int indice) {
    pValue.pecIteId = null;
    pValue.pecIteDescricao = null;
    pValue.pecIteSituacao = null;
    pValue.pecIteValor = null;
    pValue.pecIteVlojId = null;
    this.pecas.setAll(indice, [pValue]);
    this.setShowProgress(false);
    notifyListeners();
  }

  void udpateUpPecas(PecaVeiLoja pValue, int indice) {
    this.pecas.setAll(indice, [pValue]);
    this.setShowProgress(false);
    notifyListeners();
  }

  int getIndice(int pValue) {
    return this.pecas.indexWhere((pec) => pec.pecId == pValue);
  }
}
