class GraficoPizza {
  int? cONTAGEM;
  String? dESCRICAO;

  GraficoPizza({
    this.cONTAGEM,
    this.dESCRICAO,
  });

  GraficoPizza.fromJson(Map<String, dynamic> json) {
    cONTAGEM = json['CONTAGEM'];
    dESCRICAO = json['DESCRICAO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CONTAGEM'] = this.cONTAGEM;
    data['DESCRICAO'] = this.dESCRICAO;
    return data;
  }
}
