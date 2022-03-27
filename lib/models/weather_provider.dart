import 'package:clima/models/weather_response.dart';
import 'package:flutter/cupertino.dart';

class WeatherData extends ChangeNotifier{
  WeatherResponse? weatherData;

  void changeData(dynamic newData){
    weatherData = newData;
    notifyListeners();
  }
}
