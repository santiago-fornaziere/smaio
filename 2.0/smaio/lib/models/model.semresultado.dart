import 'dart:convert' as convert;

class SemResultado {
  int? sresId;
  int? sresPecId;
  int? sresModId;
  int? sresAnoId;
  bool? sresLido;
  String? sresEmail;
  String? sresTelefone;

  SemResultado({
    this.sresId,
    this.sresPecId,
    this.sresModId,
    this.sresAnoId,
    this.sresLido,
    this.sresEmail,
    this.sresTelefone,
  });

  SemResultado.fromJson(Map<String, dynamic> json) {
    sresId = json['sres_id'];
    sresPecId = json['sres_pec_id'];
    sresModId = json['sres_mod_id'];
    sresAnoId = json['sres_ano_id'];
    sresLido = json['sres_lido'];
    sresEmail = json['sres_email'];
    sresTelefone = json['sres_telefone'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sres_id'] = this.sresId;
    data['sres_pec_id'] = this.sresPecId;
    data['sres_mod_id'] = this.sresModId;
    data['sres_ano_id'] = this.sresAnoId;
    data['sres_lido'] = this.sresLido;
    data['sres_email'] = this.sresEmail;
    data['sres_telefone'] = this.sresTelefone;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
