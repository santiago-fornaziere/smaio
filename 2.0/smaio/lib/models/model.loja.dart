import 'dart:convert' as convert;

class Loja {
  int? lojId;
  String? lojNome;
  String? lojRazao;
  String? lojAtivacao;
  String? lojDtValidade;
  String? lojCnpj;
  String? lojEmail;
  String? lojTelefone1;
  String? lojTelefone2;
  String? lojCep;
  String? lojLogradouro;
  String? lojNumero;
  String? lojBairro;
  int? lojCidId;
  String? cidNome;
  String? cidUf;
  String? cidPais;
  String? lojStatus;
  var lojLatitude;
  var lojLongitude;
  bool? lojSitReg;

  Loja({
    this.lojId,
    this.lojNome,
    this.lojRazao,
    this.lojAtivacao,
    this.lojDtValidade,
    this.lojCnpj,
    this.lojEmail,
    this.lojTelefone1,
    this.lojTelefone2,
    this.lojCep,
    this.lojLogradouro,
    this.lojNumero,
    this.lojBairro,
    this.lojCidId,
    this.cidNome,
    this.cidUf,
    this.cidPais,
    this.lojStatus,
    this.lojLatitude,
    this.lojLongitude,
    this.lojSitReg,
  });

  Loja.fromJson(Map<String, dynamic> json) {
    lojId = json['loj_id'];
    lojNome = json['loj_nome'];
    lojRazao = json['loj_razao'];
    lojAtivacao = json['loj_ativacao'];
    lojDtValidade = json['loj_dt_validade'];
    lojCnpj = json['loj_cnpj'];
    lojEmail = json['loj_email'];
    lojTelefone1 = json['loj_telefone_1'];
    lojTelefone2 = json['loj_telefone_2'];
    lojCep = json['loj_cep'];
    lojLogradouro = json['loj_logradouro'];
    lojNumero = json['loj_numero'];
    lojBairro = json['loj_bairro'];
    lojCidId = json['loj_cid_id'];
    cidNome = json['cid_nome'];
    cidUf = json['cid_uf'];
    cidPais = json['cid_pais'];
    lojStatus = json['loj_status'];
    lojLatitude = json['loj_latitude'];
    lojLongitude = json['loj_longitude'];
    lojSitReg = json['loj_sit_reg'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loj_id'] = this.lojId;
    data['loj_nome'] = this.lojNome;
    data['loj_razao'] = this.lojRazao;
    data['loj_ativacao'] = this.lojAtivacao;
    data['loj_dt_validade'] = this.lojDtValidade;
    data['loj_cnpj'] = this.lojCnpj;
    data['loj_email'] = this.lojEmail;
    data['loj_telefone_1'] = this.lojTelefone1;
    data['loj_telefone_2'] = this.lojTelefone2;
    data['loj_cep'] = this.lojCep;
    data['loj_logradouro'] = this.lojLogradouro;
    data['loj_numero'] = this.lojNumero;
    data['loj_cid_id'] = this.lojCidId;
    data['loj_bairro'] = this.lojBairro;
    data['cid_nome'] = this.cidNome;
    data['cid_uf'] = this.cidUf;
    data['cid_pais'] = this.cidPais;
    data['loj_status'] = this.lojStatus;
    data['loj_latitude'] = this.lojLatitude.toString().replaceAll('.', ',');
    data['loj_longitude'] =
        double.parse(this.lojLongitude).toString().replaceAll('.', ',');
    data['loj_sit_reg'] = this.lojSitReg;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}

class LojaUsuario {
  Loja? loja;
  String? senha;

  LojaUsuario({
    this.loja,
    this.senha,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loj_id'] = this.loja!.lojId;
    data['loj_nome'] = this.loja!.lojNome;
    data['loj_razao'] = this.loja!.lojRazao;
    data['loj_ativacao'] = this.loja!.lojAtivacao;
    data['loj_dt_validade'] = this.loja!.lojDtValidade;
    data['loj_cnpj'] = this.loja!.lojCnpj;
    data['loj_email'] = this.loja!.lojEmail;
    data['loj_telefone_1'] = this.loja!.lojTelefone1;
    data['loj_telefone_2'] = this.loja!.lojTelefone2;
    data['loj_cep'] = this.loja!.lojCep;
    data['loj_logradouro'] = this.loja!.lojLogradouro;
    data['loj_numero'] = this.loja!.lojNumero;
    data['loj_cid_id'] = this.loja!.lojCidId;
    data['loj_bairro'] = this.loja!.lojBairro;
    data['cid_nome'] = this.loja!.cidNome;
    data['cid_uf'] = this.loja!.cidUf;
    data['cid_pais'] = this.loja!.cidPais;
    data['loj_status'] = this.loja!.lojStatus;
    data['loj_latitude'] =
        this.loja!.lojLatitude.toString().replaceAll('.', ',');
    data['loj_longitude'] =
        this.loja!.lojLongitude.toString().replaceAll('.', ',');
    data['loj_sit_reg'] = this.loja!.lojSitReg;
    data['usu_senha'] = this.senha;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
