import 'dart:convert' as convert;

class Usuario {
  String? usuId;
  String? usuNome;
  String? usuNivel;
  String? usuEmail;

  Usuario({this.usuId, this.usuNome, this.usuNivel, this.usuEmail});

  Usuario.fromJson(Map<String, dynamic> json) {
    usuId = json['usu_id'];
    usuNome = json['usu_nome'];
    usuNivel = json['usu_nivel'];
    usuEmail = json['usu_email'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usu_id'] = this.usuId;
    data['usu_nome'] = this.usuNome;
    data['usu_nivel'] = this.usuNivel;
    data['usu_email'] = this.usuEmail;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
