import 'package:flutter/material.dart';
import 'package:smaio/models/model.veiano.dart';

class VeiAnos extends ChangeNotifier {
  List<VeiAno> veiAno;
  bool showProgress = false;
  VeiAnos({
    required this.veiAno,
    required this.showProgress,
  });

  void setVeiAnos(List<VeiAno> pValue) {
    this.veiAno = pValue;
    this.setShowProgress(false);
    notifyListeners();
  }

  void setShowProgress(bool value) {
    this.showProgress = value;
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
