import 'package:flutter/material.dart';
import 'package:smaio/models/model.subgrupo.dart';

class SubGrupos extends ChangeNotifier {
  List<SubGrupo> subGrupo;
  SubGrupos({
    required this.subGrupo,
  });

  void setSubGrupos(List<SubGrupo> pValue) {
    this.subGrupo = pValue;
    notifyListeners();
  }

  void addSubGrupos(SubGrupo pValue) {
    this.subGrupo.add(pValue);
    notifyListeners();
  }

  void removeSubGrupos(SubGrupo pValue) {
    this.subGrupo.remove(pValue);
    notifyListeners();
  }

  void udpateSubGrupos(SubGrupo pValue, int indice) {
    this.subGrupo.setAll(indice, [pValue]);
    notifyListeners();
  }

  int getIndice(int pValue) {
    return this.subGrupo.indexWhere((sg) => sg.sgruId == pValue);
  }
}
