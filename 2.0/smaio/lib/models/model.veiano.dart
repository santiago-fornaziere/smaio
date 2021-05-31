import 'dart:convert' as convert;

class VeiAno {
  int? vanoId;
  int? vanoVeiId;
  String? vanoVeiDescricao;
  int? vanoModId;
  String? vanoModDescricao;
  int? vanoVeiFabId;
  String? vanoVeiFabNome;
  int? vanoAnoId;
  String? vanoAnoDescricao;

  VeiAno(
      {this.vanoId,
      this.vanoVeiId,
      this.vanoVeiDescricao,
      this.vanoModId,
      this.vanoModDescricao,
      this.vanoVeiFabId,
      this.vanoVeiFabNome,
      this.vanoAnoId,
      this.vanoAnoDescricao});

  VeiAno.fromJson(Map<String, dynamic> json) {
    vanoId = json['vano_id'];
    vanoVeiId = json['vano_vei_id'];
    vanoVeiDescricao = json['vano_vei_descricao'];
    vanoModId = json['vano_mod_id'];
    vanoModDescricao = json['vano_mod_descricao'];
    vanoVeiFabId = json['vano_vei_fab_id'];
    vanoVeiFabNome = json['vano_vei_fab_nome'];
    vanoAnoId = json['vano_ano_id'];
    vanoAnoDescricao = json['vano_ano_descricao'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vano_id'] = this.vanoId;
    data['vano_vei_id'] = this.vanoVeiId;
    data['vano_vei_descricao'] = this.vanoVeiDescricao;
    data['vano_mod_id'] = this.vanoModId;
    data['vano_mod_descricao'] = this.vanoModDescricao;
    data['vano_vei_fab_id'] = this.vanoVeiFabId;
    data['vano_vei_fab_nome'] = this.vanoVeiFabNome;
    data['vano_ano_id'] = this.vanoAnoId;
    data['vano_ano_descricao'] = this.vanoAnoDescricao;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
