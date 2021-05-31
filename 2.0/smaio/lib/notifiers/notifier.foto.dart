import 'package:flutter/material.dart';
import 'package:smaio/models/model.foto.dart';

class Fotos extends ChangeNotifier {
  List<Foto> foto;
  bool showProgress;
  Fotos({
    required this.foto,
    required this.showProgress,
  });

  void setFotos(List<Foto> value) {
    this.foto = value;
    this.setShowProgress(false);
    notifyListeners();
  }

  void addFotos(Foto value) {
    this.foto.add(value);
    this.setShowProgress(false);
    notifyListeners();
  }

  void removeFoto(Foto value) {
    this.foto.remove(value);
    this.setShowProgress(false);
    notifyListeners();
  }

  void setShowProgress(bool value) {
    this.showProgress = value;
    notifyListeners();
  }
}
