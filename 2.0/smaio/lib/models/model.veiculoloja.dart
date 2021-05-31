import 'dart:convert' as convert;

class VeiculoLoja {
  int? vlojId;
  int? vlojVanoId;
  int? vlojVeiId;
  String? vlojVeiDescricao;
  int? vlojVeiFabId;
  String? vlojVeiFabNome;
  int? vlojAnoId;
  String? vlojAnoDescricao;
  int? vlojModId;
  String? vlojModDescricao;
  int? vlojLojId;
  String? vlojLojNome;
  var foto;
  bool? vlojAtivo;
  bool? vlojSitReg;

  VeiculoLoja({
    this.vlojId,
    this.vlojVanoId,
    this.vlojVeiId,
    this.vlojVeiDescricao,
    this.vlojVeiFabId,
    this.vlojVeiFabNome,
    this.vlojAnoId,
    this.vlojAnoDescricao,
    this.vlojModId,
    this.vlojModDescricao,
    this.vlojLojId,
    this.vlojLojNome,
    this.foto,
    this.vlojAtivo,
    this.vlojSitReg,
  });

  VeiculoLoja.fromJson(Map<String, dynamic> json) {
    vlojId = json['vloj_id'];
    vlojVanoId = json['vloj_vano_id'];
    vlojVeiId = json['vloj_vei_id'];
    vlojVeiDescricao = json['vloj_vei_descricao'];
    vlojVeiFabId = json['vloj_vei_fab_id'];
    vlojVeiFabNome = json['vloj_vei_fab_nome'];
    vlojAnoId = json['vloj_ano_id'];
    vlojAnoDescricao = json['vloj_ano_descricao'];
    vlojModId = json['vloj_mod_id'];
    vlojModDescricao = json['vloj_mod_descricao'];
    vlojLojId = json['vloj_loj_id'];
    vlojLojNome = json['vloj_loj_nome'];
    foto = json['vloj_foto'];
    vlojAtivo = json['vloj_ativo'];
    vlojSitReg = json['vloj_sit_reg'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vloj_id'] = this.vlojId;
    data['vloj_vano_id'] = this.vlojVanoId;
    data['vloj_vei_id'] = this.vlojVeiId;
    data['vloj_vei_descricao'] = this.vlojVeiDescricao;
    data['vloj_vei_fab_id'] = this.vlojVeiFabId;
    data['vloj_vei_fab_nome'] = this.vlojVeiFabNome;
    data['vloj_ano_id'] = this.vlojAnoId;
    data['vloj_ano_descricao'] = this.vlojAnoDescricao;
    data['vloj_mod_id'] = this.vlojModId;
    data['vloj_mod_descricao'] = this.vlojModDescricao;
    data['vloj_loj_id'] = this.vlojLojId;
    data['vloj_loj_nome'] = this.vlojLojNome;
    data['vloj_ativo'] = this.vlojAtivo;
    data['vloj_sit_reg'] = this.vlojSitReg;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
