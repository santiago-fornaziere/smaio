class Grupo {
  int? gruId;
  String? gruDescricao;

  Grupo({
    this.gruId,
    this.gruDescricao,
  });

  Grupo.fromJson(Map<String, dynamic> json) {
    gruId = json['gru_id'];
    gruDescricao = json['gru_descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gru_id'] = this.gruId;
    data['gru_descricao'] = this.gruDescricao;
    return data;
  }
}
