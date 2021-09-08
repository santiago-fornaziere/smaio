import 'dart:convert' as convert;

class Foto {
  int? fotId;
  String? fotFoto;
  int? fotVlojId;
  int? fotIndice;

  Foto({
    this.fotId,
    this.fotFoto,
    this.fotVlojId,
    this.fotIndice,
  });

  Foto.fromJson(Map<String, dynamic> json) {
    fotId = json['fot_id'];
    fotFoto = json['fot_foto'];
    fotVlojId = json['fot_vloj_id'];
    fotIndice = json['fot_indice'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fot_id'] = this.fotId;
    data['fot_foto'] = this.fotFoto;
    data['fot_vloj_id'] = this.fotVlojId;
    data['fot_indice'] = this.fotIndice;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
