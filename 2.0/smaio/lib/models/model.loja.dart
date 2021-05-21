import 'dart:convert' as convert;

class Loja {
  int? lojId;
  String? lojNome;
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
  String? cidNome;
  String? cidUf;
  String? cidPais;
  String? lojStatus;

  Loja(
      {this.lojId,
      this.lojNome,
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
      this.cidNome,
      this.cidUf,
      this.cidPais,
      this.lojStatus});

  Loja.fromJson(Map<String, dynamic> json) {
    lojId = json['loj_id'];
    lojNome = json['loj_nome'];
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
    cidNome = json['cid_nome'];
    cidUf = json['cid_uf'];
    cidPais = json['cid_pais'];
    lojStatus = json['loj_status'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loj_id'] = this.lojId;
    data['loj_nome'] = this.lojNome;
    data['loj_ativacao'] = this.lojAtivacao;
    data['loj_dt_validade'] = this.lojDtValidade;
    data['loj_cnpj'] = this.lojCnpj;
    data['loj_email'] = this.lojEmail;
    data['loj_telefone_1'] = this.lojTelefone1;
    data['loj_telefone_2'] = this.lojTelefone2;
    data['loj_cep'] = this.lojCep;
    data['loj_logradouro'] = this.lojLogradouro;
    data['loj_numero'] = this.lojNumero;
    data['loj_bairro'] = this.lojBairro;
    data['cid_nome'] = this.cidNome;
    data['cid_uf'] = this.cidUf;
    data['cid_pais'] = this.cidPais;
    data['loj_status'] = this.lojStatus;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
