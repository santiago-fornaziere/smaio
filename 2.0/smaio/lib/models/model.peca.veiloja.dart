import 'dart:convert' as convert;

class PecaVeiLoja {
  int? pecId;
  String? pecDescricao;
  int? pecGruId;
  String? pecGruDescricao;
  int? pecIteId;
  String? pecIteDescricao;
  var pecIteValor;
  String? pecIteSituacao;
  int? pecIteVlojId;
  String? pecDtEntrada;

  PecaVeiLoja(
      {this.pecId,
      this.pecDescricao,
      this.pecGruId,
      this.pecGruDescricao,
      this.pecIteId,
      this.pecIteDescricao,
      this.pecIteValor,
      this.pecIteSituacao,
      this.pecIteVlojId,
      this.pecDtEntrada});

  PecaVeiLoja.fromJson(Map<String, dynamic> json) {
    pecId = json['pec_id'];
    pecDescricao = json['pec_descricao'];
    pecGruId = json['pec_gru_id'];
    pecGruDescricao = json['pec_gru_descricao'];
    pecIteId = json['pec_ite_id'];
    pecIteDescricao = json['pec_ite_descricao'];
    pecIteValor = json['pec_ite_valor'];
    pecIteSituacao = json['pec_ite_situacao'];
    pecIteVlojId = json['pec_ite_vloj_id'];
    pecDtEntrada = json['pec_dt_entrada'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pec_id'] = this.pecId;
    data['pec_descricao'] = this.pecDescricao;
    data['pec_gru_id'] = this.pecGruId;
    data['pec_gru_descricao'] = this.pecGruDescricao;
    data['pec_ite_id'] = this.pecIteId;
    data['pec_ite_descricao'] = this.pecIteDescricao;
    data['pec_ite_valor'] = this.pecIteValor;
    data['pec_ite_situacao'] = this.pecIteSituacao;
    data['pec_ite_vloj_id'] = this.pecIteVlojId;
    data['pec_dt_entrada'] = this.pecDtEntrada;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
