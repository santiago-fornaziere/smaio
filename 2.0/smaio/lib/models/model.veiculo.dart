import 'dart:convert' as convert;

class Veiculo {
  int? veiId;
  String? veiDescricao;
  int? veiFabId;
  String? fabNome;
  bool? veiSitReg;

  Veiculo(
      {this.veiId,
      this.veiDescricao,
      this.veiFabId,
      this.fabNome,
      this.veiSitReg});

  Veiculo.fromJson(Map<String, dynamic> json) {
    veiId = json['vei_id'];
    veiDescricao = json['vei_descricao'];
    veiFabId = json['vei_fab_id'];
    fabNome = json['fab_nome'];
    veiSitReg = json['vei_sit_reg'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vei_id'] = this.veiId;
    data['vei_descricao'] = this.veiDescricao;
    data['vei_fab_id'] = this.veiFabId;
    data['fab_nome'] = this.fabNome;
    data['vei_sit_reg'] = this.veiSitReg;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
