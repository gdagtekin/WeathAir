import 'package:clima/models/daily.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class DailyWeather extends StatefulWidget {
  const DailyWeather({Key? key, required this.daily}) : super(key: key);
  final List<Daily> daily;

  @override
  _DailyWeatherState createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  bool sevenDaysOpen = false;
  String sevenDaysText = "";

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    WeatherModel weather = WeatherModel();
    setState(() {
      if (sevenDaysOpen) {
        sevenDaysText = t!.threeDayForecast;
      } else {
        sevenDaysText = t!.sevenDayForecast;
      }
    });

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DailyItem(
            weather: weather,
            daily: widget.daily,
            dayName: t!.today,
            index: 0,
          ),
          DailyItem(
            weather: weather,
            daily: widget.daily,
            dayName: t.tomorrow,
            index: 1,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: (sevenDaysOpen == true ? 5 : 1),
            itemBuilder: (context, index) {
              return DailyItem(
                  weather: weather,
                  daily: widget.daily,
                  dayName: weather
                      .timestampToDay(widget.daily[index + 2].dt.toInt(), t),
                  index: index + 2);
            },
          ),
          const SizedBox(
            height: kMargin2x,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: kCardBackgroundColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: GestureDetector(
              child: Text(
                sevenDaysText,
                style: kSubHeadlineTextStyle,
              ),
              onTap: () {
                setState(() {
                  sevenDaysOpen = !sevenDaysOpen;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DailyItem extends StatelessWidget {
  const DailyItem({
    Key? key,
    required this.weather,
    required this.daily,
    required this.dayName,
    required this.index,
  }) : super(key: key);

  final WeatherModel weather;
  final List<Daily> daily;
  final String dayName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              dayName,
              style: kHeadlineTextStyle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Lottie.asset(
                'assets/${weather.getWeatherAnimation(daily[index].weather.first.id.toInt(), false)}',
                width: kDailyIconSize,
                height: kDailyIconSize,
                animate: false),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    '${daily[index].temp.max.round().toStringAsFixed(0)}°',
                    style: kHeadlineTextStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '${daily[index].temp.min.round().toStringAsFixed(0)}°',
                    style: kHeadlineTertiaryTextStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
