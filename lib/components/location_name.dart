import 'package:clima/models/weather_response.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:clima/models/weather_provider.dart';

class LocationNameView extends StatelessWidget {
  final WeatherResponse weatherResponse;
  final String cityName;
  final Color startColor;
  final Color endColor;

  LocationNameView(
      {Key? key,
        required this.weatherResponse,
        required this.cityName,
        required this.startColor,
        required this.endColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_pin,
            color: kIconColor,
            size: kIconSize,
          ),
          const SizedBox(
            width: kMargin2x,
          ),
          Text(
            cityName,
            style: kHeadlineTextStyle,
          ),
          const SizedBox(
            width: kMargin2x,
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: kIconColor,
            size: kIconSize,
          ),
        ],
      ),
      onTap: () async {
        final weatherData =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SearchView(
            startColor: startColor,
            endColor: endColor,
          );
        }));
        if(weatherData != null){
          Provider.of<WeatherData>(context, listen:false).changeData(weatherData);
        }
      },
    );
  }
}