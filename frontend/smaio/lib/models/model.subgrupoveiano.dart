import 'dart:convert' as convert;

class SubGrupoVeiAno {
  int? sgvanoId;
  int? sgvanoSgruId;
  String? sgvanoSgruDescricao;
  String? sgvanoPecDescricao;
  int? sgvanoGruId;
  String? sgvanoGruDescricao;
  int? sgvanoVanoId;
  String? sgvanoVanoAnoDescricao;
  String? sgvanoVanoVeiDescr;
  int? sgvanoVanoVeiFabId;
  String? sgvanoVanoVeiFabNome;

  SubGrupoVeiAno(
      {this.sgvanoId,
      this.sgvanoSgruId,
      this.sgvanoSgruDescricao,
      this.sgvanoPecDescricao,
      this.sgvanoGruId,
      this.sgvanoGruDescricao,
      this.sgvanoVanoId,
      this.sgvanoVanoAnoDescricao,
      this.sgvanoVanoVeiDescr,
      this.sgvanoVanoVeiFabId,
      this.sgvanoVanoVeiFabNome});

  SubGrupoVeiAno.fromJson(Map<String, dynamic> json) {
    sgvanoId = json['sgvano_id'];
    sgvanoSgruId = json['sgvano_sgru_id'];
    sgvanoSgruDescricao = json['sgvano_sgru_descricao'];
    sgvanoPecDescricao = json['sgvano_pec_descricao'];
    sgvanoGruId = json['sgvano_gru_id'];
    sgvanoGruDescricao = json['sgvano_gru_descricao'];
    sgvanoVanoId = json['sgvano_vano_id'];
    sgvanoVanoAnoDescricao = json['sgvano_vano_ano_descricao'];
    sgvanoVanoVeiDescr = json['sgvano_vano_vei_descr'];
    sgvanoVanoVeiFabId = json['sgvano_vano_vei_fab_id'];
    sgvanoVanoVeiFabNome = json['sgvano_vano_vei_fab_nome'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sgvano_id'] = this.sgvanoId;
    data['sgvano_sgru_id'] = this.sgvanoSgruId;
    data['sgvano_sgru_descricao'] = this.sgvanoSgruDescricao;
    data['sgvano_pec_descricao'] = this.sgvanoPecDescricao;
    data['sgvano_gru_id'] = this.sgvanoGruId;
    data['sgvano_gru_descricao'] = this.sgvanoGruDescricao;
    data['sgvano_vano_id'] = this.sgvanoVanoId;
    data['sgvano_vano_ano_descricao'] = this.sgvanoVanoAnoDescricao;
    data['sgvano_vano_vei_descr'] = this.sgvanoVanoVeiDescr;
    data['sgvano_vano_vei_fab_id'] = this.sgvanoVanoVeiFabId;
    data['sgvano_vano_vei_fab_nome'] = this.sgvanoVanoVeiFabNome;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
