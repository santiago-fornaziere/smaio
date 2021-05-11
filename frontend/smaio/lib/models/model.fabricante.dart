import 'dart:convert' as convert;

class Fabricante {
  int? fabId;
  String? fabNome;

  Fabricante({this.fabId, this.fabNome});

  Fabricante.fromJson(Map<String, dynamic> json) {
    fabId = json['fab_id'];
    fabNome = json['fab_nome'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fab_id'] = this.fabId;
    data['fab_nome'] = this.fabNome;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
