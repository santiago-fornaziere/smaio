import 'dart:convert' as convert;

class Where {
  String? where;
  String? orderBy;

  Where({
    this.where,
    this.orderBy,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['where'] = this.where;
    data['orderby'] = this.orderBy;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}

class WhereSubGrupoVeiAno {
  String? where;
  String? orderBy;
  String? sgvanoVanoId;

  WhereSubGrupoVeiAno({
    this.where,
    this.orderBy,
    this.sgvanoVanoId,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['where'] = this.where;
    data['orderby'] = this.orderBy;
    data['sgvano_vano_id'] = this.sgvanoVanoId;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
