import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:lottie/lottie.dart';

class MainWeatherView extends StatelessWidget {
  const MainWeatherView({
    Key? key,
    required this.icon,
    required this.description,
    required this.temp,
    required this.day,
    required this.screenWidth,
  }) : super(key: key);

  final String icon;
  final String description;
  final String temp;
  final String day;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          'assets/$icon',
          width: (screenWidth - ((screenWidth / 100) * 40)),
          height: 200,
        ),
        Text(
          description,
          style: kLargeTitleTextStyle,
        ),
        const SizedBox(
          height: 4.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '°',
              style: kTemperatureAlphaTextStyle,
            ),
            Text(
              temp,
              style: kTemperatureTextStyle,
            ),
            const Text(
              '°',
              style: kTemperatureTextStyle,
            ),
          ],
        ),
        const SizedBox(
          height: 4.0,
        ),
        Text(
          day,
          style: kHeadlineTextStyle,
        ),
        const SizedBox(
          height: 12.0,
        ),
      ],
    );
  }
}
