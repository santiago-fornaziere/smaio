import 'dart:convert' as convert;

class Item {
  int? iteId;
  String? iteDescricao;
  int? iteSgvanoId;
  int? iteGruId;
  String? iteGruDescricao;
  int? itePecId;
  String? itePecDescricao;
  int? iteSgruId;
  String? iteSgruDescricao;
  int? iteVeiId;
  String? iteVeiDescricao;
  int? iteVeiFabId;
  String? iteVeiFabNome;
  int? iteVanoAnoId;
  String? iteVanoAnoDescricao;
  double? iteValor;
  String? iteSituacao;
  String? iteStatus;
  int? iteLojId;
  String? iteLojNome;
  int? iteTraEntrada;
  String? iteTraDtEntrada;
  int? iteTraSaida;
  String? iteTraDtSaida;
  bool? iteSitReg;

  Item(
      {this.iteId,
      this.iteDescricao,
      this.iteSgvanoId,
      this.iteGruId,
      this.iteGruDescricao,
      this.itePecId,
      this.itePecDescricao,
      this.iteSgruId,
      this.iteSgruDescricao,
      this.iteVeiId,
      this.iteVeiDescricao,
      this.iteVeiFabId,
      this.iteVeiFabNome,
      this.iteVanoAnoId,
      this.iteVanoAnoDescricao,
      this.iteValor,
      this.iteSituacao,
      this.iteStatus,
      this.iteLojId,
      this.iteLojNome,
      this.iteTraEntrada,
      this.iteTraDtEntrada,
      this.iteTraSaida,
      this.iteTraDtSaida,
      this.iteSitReg});

  Item.fromJson(Map<String, dynamic> json) {
    iteId = json['ite_id'];
    iteDescricao = json['ite_descricao'];
    iteSgvanoId = json['ite_sgvano_id'];
    iteGruId = json['ite_gru_id'];
    iteGruDescricao = json['ite_gru_descricao'];
    itePecId = json['ite_pec_id'];
    itePecDescricao = json['ite_pec_descricao'];
    iteSgruId = json['ite_sgru_id'];
    iteSgruDescricao = json['ite_sgru_descricao'];
    iteVeiId = json['ite_vei_id'];
    iteVeiDescricao = json['ite_vei_descricao'];
    iteVeiFabId = json['ite_vei_fab_id'];
    iteVeiFabNome = json['ite_vei_fab_nome'];
    iteVanoAnoId = json['ite_vano_ano_id'];
    iteVanoAnoDescricao = json['ite_vano_ano_descricao'];
    iteValor = json['ite_valor'];
    iteSituacao = json['ite_situacao'];
    iteStatus = json['ite_status'];
    iteLojId = json['ite_loj_id'];
    iteLojNome = json['ite_loj_nome'];
    iteTraEntrada = json['ite_tra_entrada'];
    iteTraDtEntrada = json['ite_tra_dt_entrada'];
    iteTraSaida = json['ite_tra_saida'];
    iteTraDtSaida = json['ite_tra_dt_saida'];
    iteSitReg = json['ite_sit_reg'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ite_id'] = this.iteId;
    data['ite_descricao'] = this.iteDescricao;
    data['ite_sgvano_id'] = this.iteSgvanoId;
    data['ite_gru_id'] = this.iteGruId;
    data['ite_gru_descricao'] = this.iteGruDescricao;
    data['ite_pec_id'] = this.itePecId;
    data['ite_pec_descricao'] = this.itePecDescricao;
    data['ite_sgru_id'] = this.iteSgruId;
    data['ite_sgru_descricao'] = this.iteSgruDescricao;
    data['ite_vei_id'] = this.iteVeiId;
    data['ite_vei_descricao'] = this.iteVeiDescricao;
    data['ite_vei_fab_id'] = this.iteVeiFabId;
    data['ite_vei_fab_nome'] = this.iteVeiFabNome;
    data['ite_vano_ano_id'] = this.iteVanoAnoId;
    data['ite_vano_ano_descricao'] = this.iteVanoAnoDescricao;
    data['ite_valor'] = this.iteValor;
    data['ite_situacao'] = this.iteSituacao;
    data['ite_status'] = this.iteStatus;
    data['ite_loj_id'] = this.iteLojId;
    data['ite_loj_nome'] = this.iteLojNome;
    data['ite_tra_entrada'] = this.iteTraEntrada;
    data['ite_tra_dt_entrada'] = this.iteTraDtEntrada;
    data['ite_tra_saida'] = this.iteTraSaida;
    data['ite_tra_dt_saida'] = this.iteTraDtSaida;
    data['ite_sit_reg'] = this.iteSitReg;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
