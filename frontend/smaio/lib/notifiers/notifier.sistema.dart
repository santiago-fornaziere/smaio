import 'package:flutter/material.dart';
import 'package:smaio/models/model.loja.dart';
import 'package:smaio/models/model.usuario.dart';

class Sistema extends ChangeNotifier {
  Usuario? usuario;
  Loja? loja;
  Sistema({
    this.usuario,
    this.loja,
  });

  void setUsuario(Usuario usuario) {
    this.usuario = usuario;

    notifyListeners();
  }

  void setLoja(Loja loja) {
    this.loja = loja;

    notifyListeners();
  }
}
