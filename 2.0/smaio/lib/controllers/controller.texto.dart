import 'package:http/http.dart' as http;
import 'package:smaio/utils/const.dart';

class TextoApi {
  static Future<String> getContrato() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/contrato');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        return json;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  static Future<String> getInfLegais() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8",
    };
    try {
      var url = Uri.http('$hostapi:9101', '/smaio/inflegais');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String json = response.body;
        return json;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }
}
