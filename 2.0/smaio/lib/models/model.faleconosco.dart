import 'dart:convert' as convert;

class FaleConosco {
  int? fconId;
  String? fconTexto;
  String? fconNome;
  String? fconFone;
  String? fconEmail;
  bool? fconLido;

  FaleConosco(
      {this.fconId,
      this.fconTexto,
      this.fconNome,
      this.fconFone,
      this.fconEmail,
      this.fconLido});

  FaleConosco.fromJson(Map<String, dynamic> json) {
    fconId = json['fcon_id'];
    fconTexto = json['fcon_texto'];
    fconNome = json['fcon_nome'];
    fconFone = json['fcon_fone'];
    fconEmail = json['fcon_email'];
    fconLido = json['fcon_lido'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fcon_id'] = this.fconId;
    data['fcon_texto'] = this.fconTexto;
    data['fcon_nome'] = this.fconNome;
    data['fcon_fone'] = this.fconFone;
    data['fcon_email'] = this.fconEmail;
    data['fcon_lido'] = this.fconLido;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
