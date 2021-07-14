import 'package:smaio/models/model.faleconosco.dart';
import 'package:http/http.dart' as http;
import 'package:smaio/utils/const.dart';

class FaleConoscoApi {
  static Future<int> post(FaleConosco pRegistro) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      String c = pRegistro.toJson();
      var url = Uri.http('$hostapi:9101', '/smaio/faleconosco');
      var response = await http.post(url, headers: headers, body: c);
      print(response.body);

      return response.statusCode;
    } catch (e) {
      print(e);
      return 401;
    }
  }
}
