import 'package:smaiosenha/const.dart';
import 'package:http/http.dart' as http;

class Retorno {
  int status;
  String texto;
  Retorno({
    required this.status,
    required this.texto,
  });
}

class UsuarioApi {
  static Future<Retorno> consultaReset(int pID) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9199', '/smaio/consultareset/$pID');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        Retorno tabela = new Retorno(
            status: response.statusCode, texto: response.body.toString());
        return tabela;
      } else {
        return new Retorno(status: 400, texto: response.body.toString());
      }
    } catch (e) {
      return new Retorno(
          status: 400, texto: 'Erro ao carregar dados do usuário.');
    }
  }

  static Future<Retorno> resetSenha(int pID, String pSenha) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9199', '/smaio/resetsenha/$pID');
      var response = await http.put(url, headers: headers, body: pSenha);
      if (response.statusCode == 200) {
        Retorno tabela = new Retorno(
            status: response.statusCode, texto: response.body.toString());
        return tabela;
      } else {
        return new Retorno(status: 400, texto: response.body.toString());
      }
    } catch (e) {
      return new Retorno(
          status: 400, texto: 'Erro ao carregar dados do usuário.');
    }
  }

  static Future<Retorno> consultaEmail(String pEmail) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9199', '/smaio/email');
      var response = await http.post(url, headers: headers, body: pEmail);
      if (response.statusCode == 200) {
        Retorno tabela = new Retorno(
            status: response.statusCode, texto: response.body.toString());
        return tabela;
      } else {
        return new Retorno(status: 400, texto: response.body.toString());
      }
    } catch (e) {
      return new Retorno(
          status: 400, texto: 'Erro ao carregar dados do usuário.');
    }
  }

  static Future<Retorno> enviarEmail(int pID) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9197', '/smaio/resetsenha/enviaemail/$pID');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        Retorno tabela = new Retorno(
            status: response.statusCode, texto: response.body.toString());
        return tabela;
      } else {
        return new Retorno(status: 400, texto: response.body.toString());
      }
    } catch (e) {
      return new Retorno(
          status: 400, texto: 'Erro ao carregar dados do usuário.');
    }
  }
}
