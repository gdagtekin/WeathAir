import 'package:clima/models/hourly.dart';
import 'package:clima/models/current.dart';
import 'package:clima/models/daily.dart';

class WeatherResponse {
  WeatherResponse({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
    required this.daily,
  });
  late final num lat;
  late final num lon;
  late final String timezone;
  late final num timezoneOffset;
  late final Current current;
  late final List<Hourly> hourly;
  late final List<Daily> daily;
  late final String locationName;

  WeatherResponse.fromJson(Map<String, dynamic> json){
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    current = Current.fromJson(json['current']);
    hourly = List.from(json['hourly']).map((e)=>Hourly.fromJson(e)).toList();
    daily = List.from(json['daily']).map((e)=>Daily.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lon'] = lon;
    _data['timezone'] = timezone;
    _data['timezone_offset'] = timezoneOffset;
    _data['current'] = current.toJson();
    _data['hourly'] = hourly.map((e)=>e.toJson()).toList();
    _data['daily'] = daily.map((e)=>e.toJson()).toList();
    return _data;
  }
}






