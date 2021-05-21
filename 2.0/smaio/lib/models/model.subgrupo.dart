import 'dart:convert' as convert;

import 'package:smaio/models/model.subgrupoveiano.dart';

class SubGrupo {
  int? sgruId;
  String? sgruDescricao;
  int? sgruGruId;
  String? sgruGruDescricao;
  int? sgruPecId;
  String? sgruPecDescricao;
  bool? sgruSitReg;
  bool? sgruPecSitReg;
  int? sgruTraId;
  String? sgruTraDtLancamento;
  int? sgruUsuId;
  String? sgruUsuNome;
  bool? selected = false;
  List<SubGrupoVeiAno>? sgruVanos;

  SubGrupo({
    this.sgruId,
    this.sgruDescricao,
    this.sgruGruId,
    this.sgruGruDescricao,
    this.sgruPecId,
    this.sgruPecDescricao,
    this.sgruSitReg,
    this.sgruPecSitReg,
    this.sgruTraId,
    this.sgruTraDtLancamento,
    this.sgruUsuId,
    this.sgruUsuNome,
    this.selected,
    this.sgruVanos,
  });

  SubGrupo.fromJson(Map<String, dynamic> json) {
    sgruId = json['sgru_id'];
    sgruDescricao = json['sgru_descricao'];
    sgruGruId = json['sgru_gru_id'];
    sgruGruDescricao = json['sgru_gru_descricao'];
    sgruPecId = json['sgru_pec_id'];
    sgruPecDescricao = json['sgru_pec_descricao'];
    sgruSitReg = json['sgru_sit_reg'];
    sgruPecSitReg = json['sgru_pec_sit_reg'];
    sgruTraId = json['sgru_tra_id'];
    sgruTraDtLancamento = json['sgru_tra_dt_lancamento'];
    sgruUsuId = json['sgru_usu_id'];
    sgruUsuNome = json['sgru_usu_nome'];
    selected = false;
    if (json['sgru_vanos'] != null) {
      List<SubGrupoVeiAno> sgruVanos = [];
      json['c'].forEach((v) {
        sgruVanos.add(new SubGrupoVeiAno.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sgru_id'] = this.sgruId;
    data['sgru_descricao'] = this.sgruDescricao;
    data['sgru_gru_id'] = this.sgruGruId;
    data['sgru_gru_descricao'] = this.sgruGruDescricao;
    data['sgru_pec_id'] = this.sgruPecId;
    data['sgru_pec_descricao'] = this.sgruPecDescricao;
    data['sgru_sit_reg'] = this.sgruSitReg;
    data['sgru_pec_sit_reg'] = this.sgruPecSitReg;
    data['sgru_tra_id'] = this.sgruTraId;
    data['sgru_tra_dt_lancamento'] = this.sgruTraDtLancamento;
    data['sgru_usu_id'] = this.sgruUsuId;
    data['sgru_usu_nome'] = this.sgruUsuNome;
    if (this.sgruVanos != null) {
      data['sgru_vanos'] = this.sgruVanos!.map((v) => v.toMap()).toList();
    } else {
      data['sgru_vanos'] = [];
    }

    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
