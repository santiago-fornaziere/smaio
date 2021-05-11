class Ano {
  int? anoId;
  String? anoDescricao;

  Ano({
    this.anoId,
    this.anoDescricao,
  });

  Ano.fromJson(Map<String, dynamic> json) {
    anoId = json['CONTAGEM'];
    anoDescricao = json['DESCRICAO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ano_id'] = this.anoId;
    data['ano_descricao'] = this.anoDescricao;
    return data;
  }
}
