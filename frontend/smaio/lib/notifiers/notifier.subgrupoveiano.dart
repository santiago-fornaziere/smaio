import 'package:flutter/material.dart';
import 'package:smaio/models/model.subgrupoveiano.dart';

class SubGrupoVeiAnos extends ChangeNotifier {
  List<SubGrupoVeiAno> subGrupoveiAno;
  SubGrupoVeiAnos({
    required this.subGrupoveiAno,
  });

  void setSubGrupoVeiAnos(List<SubGrupoVeiAno> pValue) {
    this.subGrupoveiAno = pValue;
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
