import 'dart:convert' as convert;

class Modelo {
  int? modId;
  String? modDescricao;
  int? modFabId;
  String? fabNome;
  bool? modSitReg;

  Modelo(
      {this.modId,
      this.modDescricao,
      this.modFabId,
      this.fabNome,
      this.modSitReg});

  Modelo.fromJson(Map<String, dynamic> json) {
    modId = json['mod_id'];
    modDescricao = json['mod_descricao'];
    modFabId = json['mod_fab_id'];
    fabNome = json['fab_nome'];
    modSitReg = json['mod_sit_reg'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mod_id'] = this.modId;
    data['mod_descricao'] = this.modDescricao;
    data['mod_fab_id'] = this.modFabId;
    data['fab_nome'] = this.fabNome;
    data['mod_sit_reg'] = this.modSitReg;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
