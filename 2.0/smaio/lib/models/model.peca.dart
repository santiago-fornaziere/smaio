import 'dart:convert' as convert;

import 'package:smaio/models/model.subgrupo.dart';

class Peca {
  int? pecId;
  String? pecDescricao;
  int? pecGruId;
  String? pecGruDescricao;
  int? pecTraId;
  bool? pecSitReg;
  List<SubGrupo>? pecSgrus;

  Peca({
    this.pecId,
    this.pecDescricao,
    this.pecGruId,
    this.pecGruDescricao,
    this.pecTraId,
    this.pecSitReg,
    this.pecSgrus,
  });

  Peca.fromJson(Map<String, dynamic> json) {
    pecId = json['pec_id'];
    pecDescricao = json['pec_descricao'];
    pecGruId = json['pec_gru_id'];
    pecGruDescricao = json['pec_gru_descricao'];
    pecTraId = json['pec_tra_id'];
    pecSitReg = json['pec_sit_reg'];
    if (json['pec_sgrus'] != null) {
      List<SubGrupo> pecSgrus = [];
      json['pec_sgrus'].forEach((v) {
        pecSgrus.add(new SubGrupo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pec_id'] = this.pecId;
    data['pec_descricao'] = this.pecDescricao;
    data['pec_gru_id'] = this.pecGruId;
    data['pec_gru_descricao'] = this.pecGruDescricao;
    data['pec_tra_id'] = this.pecTraId;
    data['pec_sit_reg'] = this.pecSitReg;
    if (this.pecSgrus != null) {
      data['pec_sgrus'] = this.pecSgrus!.map((v) => v.toMap()).toList();
    } else {
      data['pec_sgrus'] = [];
    }
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
