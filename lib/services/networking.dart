import 'package:clima/models/weather_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  String url;

  Future<WeatherResponse?> getOneCallWeather() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  Future getCurrentWeather() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
      return "";
    }
  }
}
