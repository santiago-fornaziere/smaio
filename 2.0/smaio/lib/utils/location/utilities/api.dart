// ignore_for_file: argument_type_not_assignable

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/location.dart';

var _url = Uri.http('geolocation-db.com', '/json/');

class LocationAPI {
  LocationAPI();

  Future<String> fetchData() async {
    var _city = '';
    final resp = await http.get(_url);
    print(resp);

    if (resp.statusCode == 200) {
      final _data = LocationModel.fromJson(json.decode(resp.body));

      _city = _data.city.toString();
    }

    return _city;
  }
}
