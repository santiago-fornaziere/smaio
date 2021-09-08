import 'dart:convert' as convert;

class Item {
  int? iteId;
  String? iteDescricao;
  int? iteVlojId;
  int? iteGruId;
  String? iteGruDescricao;
  int? itePecId;
  String? itePecDescricao;
  int? iteVeiId;
  String? iteVeiDescricao;
  int? iteModId;
  String? iteModDescricao;
  int? iteVeiFabId;
  String? iteVeiFabNome;
  int? iteVanoAnoId;
  String? iteVanoAnoDescricao;
  var iteValor;
  String? iteSituacao;
  String? iteStatus;
  int? iteLojId;
  String? iteLojNome;
  String? iteLojTelefone1;
  String? iteLojTelefone2;
  String? iteLojEmail;
  int? iteLojCidId;
  String? iteLojCidNome;
  int? iteTraEntrada;
  String? iteTraDtEntrada;
  int? iteTraSaida;
  String? iteTraDtSaida;
  bool? iteSitReg;
  String? iteFoto;
  double? iteDistancia;
  var iteLojLatitude;
  var iteLojLongitude;
  int? iteFotoQtde;
  String? iteLojLogradouro;
  String? iteLojNumero;
  String? iteLojComplemento;
  String? iteLojBairro;

  Item({
    this.iteId,
    this.iteDescricao,
    this.iteVlojId,
    this.iteGruId,
    this.iteGruDescricao,
    this.itePecId,
    this.itePecDescricao,
    this.iteVeiId,
    this.iteVeiDescricao,
    this.iteModId,
    this.iteModDescricao,
    this.iteVeiFabId,
    this.iteVeiFabNome,
    this.iteVanoAnoId,
    this.iteVanoAnoDescricao,
    this.iteValor,
    this.iteSituacao,
    this.iteStatus,
    this.iteLojId,
    this.iteLojNome,
    this.iteLojTelefone1,
    this.iteLojTelefone2,
    this.iteLojEmail,
    this.iteLojCidId,
    this.iteLojCidNome,
    this.iteTraEntrada,
    this.iteTraDtEntrada,
    this.iteTraSaida,
    this.iteTraDtSaida,
    this.iteSitReg,
    this.iteFoto,
    this.iteDistancia,
    this.iteLojLatitude,
    this.iteLojLongitude,
    this.iteFotoQtde,
    this.iteLojLogradouro,
    this.iteLojNumero,
    this.iteLojBairro,
  });

  Item.fromJson(Map<String, dynamic> json) {
    iteId = json['ite_id'];
    iteDescricao = json['ite_descricao'];
    iteVlojId = json['ite_vloj_id'];
    iteGruId = json['ite_gru_id'];
    iteGruDescricao = json['ite_gru_descricao'];
    itePecId = json['ite_pec_id'];
    itePecDescricao = json['ite_pec_descricao'];
    iteVeiId = json['ite_vei_id'];
    iteVeiDescricao = json['ite_vei_descricao'];
    iteModId = json['ite_mod_id'];
    iteModDescricao = json['ite_mod_descricao'];
    iteVeiFabId = json['ite_vei_fab_id'];
    iteVeiFabNome = json['ite_vei_fab_nome'];
    iteVanoAnoId = json['ite_vano_ano_id'];
    iteVanoAnoDescricao = json['ite_vano_ano_descricao'];
    iteValor = json['ite_valor'];
    iteSituacao = json['ite_situacao'];
    iteStatus = json['ite_status'];
    iteLojId = json['ite_loj_id'];
    iteLojNome = json['ite_loj_nome'];
    iteLojTelefone1 = json['ite_loj_telefone1'];
    iteLojTelefone2 = json['ite_loj_telefone2'];
    iteLojEmail = json['ite_loj_email'];
    iteLojCidId = json['ite_loj_cid_id'];
    iteLojCidNome = json['ite_loj_cid_nome'];
    iteTraEntrada = json['ite_tra_entrada'];
    iteTraDtEntrada = json['ite_tra_dt_entrada'];
    iteTraSaida = json['ite_tra_saida'];
    iteTraDtSaida = json['ite_tra_dt_saida'];
    iteSitReg = json['ite_sit_reg'];
    iteFoto = json['ite_foto'];
    iteLojLatitude = json['ite_loj_latitude'];
    iteLojLongitude = json['ite_loj_longitude'];
    iteFotoQtde = json['ite_fot_qtde'] ?? 0;
    iteLojLogradouro = json['ite_loj_logradouro'];
    iteLojNumero = json['ite_loj_numero'];
    iteLojBairro = json['ite_loj_bairro'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ite_id'] = this.iteId;
    data['ite_descricao'] = this.iteDescricao;
    data['ite_vloj_id'] = this.iteVlojId;
    data['ite_gru_id'] = this.iteGruId;
    data['ite_gru_descricao'] = this.iteGruDescricao;
    data['ite_pec_id'] = this.itePecId;
    data['ite_pec_descricao'] = this.itePecDescricao;
    data['ite_vei_id'] = this.iteVeiId;
    data['ite_vei_descricao'] = this.iteVeiDescricao;
    data['ite_mod_id'] = this.iteModId;
    data['ite_mod_descricao'] = this.iteModDescricao;
    data['ite_vei_fab_id'] = this.iteVeiFabId;
    data['ite_vei_fab_nome'] = this.iteVeiFabNome;
    data['ite_vano_ano_id'] = this.iteVanoAnoId;
    data['ite_vano_ano_descricao'] = this.iteVanoAnoDescricao;
    data['ite_valor'] = this.iteValor;
    data['ite_situacao'] = this.iteSituacao;
    data['ite_status'] = this.iteStatus;
    data['ite_loj_id'] = this.iteLojId;
    data['ite_loj_nome'] = this.iteLojNome;
    data['ite_loj_telefone1'] = this.iteLojTelefone1;
    data['ite_loj_telefone2'] = this.iteLojTelefone2;
    data['ite_loj_email'] = this.iteLojEmail;
    data['ite_loj_cid_id'] = this.iteLojCidId;
    data['ite_loj_cid_nome'] = this.iteLojCidNome;
    data['ite_tra_entrada'] = this.iteTraEntrada;
    data['ite_tra_dt_entrada'] = this.iteTraDtEntrada;
    data['ite_tra_saida'] = this.iteTraSaida;
    data['ite_tra_dt_saida'] = this.iteTraDtSaida;
    data['ite_sit_reg'] = this.iteSitReg;
    data['ite_foto'] = this.iteFoto;
    data['ite_loj_latitude'] = this.iteLojLatitude;
    data['ite_loj_longitude'] = this.iteLojLongitude;
    data['ite_fot_qtde'] = this.iteFotoQtde;
    data['ite_loj_logradouro'] = this.iteLojLogradouro;
    data['ite_loj_numero'] = this.iteLojNumero;
    data['ite_loj_bairro'] = this.iteLojBairro;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
