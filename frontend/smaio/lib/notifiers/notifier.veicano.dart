import 'package:flutter/material.dart';
import 'package:smaio/models/model.veiano.dart';

class VeiAnos extends ChangeNotifier {
  List<VeiAno> veiAno;
  VeiAnos({
    required this.veiAno,
  });

  void setVeiAnos(List<VeiAno> pValue) {
    this.veiAno = pValue;
    notifyListeners();
  }

  void addVeiAnos(VeiAno pValue) {
    this.veiAno.add(pValue);
    notifyListeners();
  }

  void removeVeiAnos(VeiAno pValue) {
    this.veiAno.remove(pValue);
    notifyListeners();
  }
}
