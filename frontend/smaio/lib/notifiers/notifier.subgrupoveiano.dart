import 'package:flutter/material.dart';
import 'package:smaio/models/model.subgrupoveiano.dart';

class SubGrupoVeiAnos extends ChangeNotifier {
  List<SubGrupoVeiAno> subGrupoveiAno;
  bool showProgress;
  SubGrupoVeiAnos({
    required this.subGrupoveiAno,
    required this.showProgress,
  });

  void setSubGrupoVeiAnos(List<SubGrupoVeiAno> pValue) {
    this.subGrupoveiAno = pValue;
    this.setShowProgress(false);
    notifyListeners();
  }

  void setShowProgress(bool value) {
    this.showProgress = value;
    notifyListeners();
  }

  void addVeiAnos(SubGrupoVeiAno pValue) {
    this.subGrupoveiAno.add(pValue);
    notifyListeners();
  }

  void removeVeiAnos(SubGrupoVeiAno pValue) {
    this.subGrupoveiAno.remove(pValue);
    notifyListeners();
  }
}
