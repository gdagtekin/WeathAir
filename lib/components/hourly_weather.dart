import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/models/weather_response.dart';

class HourlyList extends StatelessWidget {
  const HourlyList({
    Key? key,
    required this.weatherRes,
    required this.weather,
  }) : super(key: key);

  final WeatherResponse weatherRes;
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    var now = weatherRes.hourly[0].dt;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 120,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: (weatherRes.hourly.length > 24 ? 24 : 0),
            itemBuilder: (context, index) {
              var hourly = weatherRes.hourly[index];
              return HourlyWeather(
                hour: weather.timestampToHour(hourly.dt.toInt()),
                weatherIcon: weather.getWeatherAnimation(
                  hourly.weather[0].id.toInt(),
                  weather.isNightForHourly(now, hourly.dt,
                      weatherRes.current.sunrise, weatherRes.current.sunset),
                ),
                temp: hourly.temp.round().toStringAsFixed(0),
              );
            },
          ),
        ),
      ],
    );
  }
}

class HourlyWeather extends StatelessWidget {
  const HourlyWeather(
      {Key? key,
      required this.hour,
      required this.weatherIcon,
      required this.temp})
      : super(key: key);
  final String hour;
  final String weatherIcon;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      decoration: BoxDecoration(
        color: kCardBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            hour,
            style: kSubHeadlineTextStyle,
          ),
          const SizedBox(
            height: kMargin1x,
          ),
          Lottie.asset('assets/$weatherIcon',
              width: kHourlyIconSize, height: kHourlyIconSize, animate: false),
          const SizedBox(
            height: kMargin1x,
          ),
          Text(
            '$temp°',
            style: kHeadlineTextStyle,
          ),
        ],
      ),
    );
  }
}
