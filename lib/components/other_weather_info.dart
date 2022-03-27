import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherOtherInfo extends StatelessWidget {
  const WeatherOtherInfo(
      {Key? key,
      required this.windSpeed,
      required this.humidity,
      required this.realFeel})
      : super(key: key);

  final String windSpeed;
  final String humidity;
  final String realFeel;

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kCardBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InfoItem(
            iconData: Icons.air,
            infoData: '$windSpeed km/h',
            hintText: t!.wind,
          ),
          InfoItem(
            iconData: CupertinoIcons.drop,
            infoData: '$humidity%',
            hintText: t.humidity,
          ),
          InfoItem(
            iconData: Icons.thermostat,
            infoData: '$realFeel°',
            hintText: t.realFeel,
          ),
        ],
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  const InfoItem({
    Key? key,
    required this.iconData,
    required this.infoData,
    required this.hintText,
  }) : super(key: key);

  final IconData iconData;
  final String infoData;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: kIconColor,
          size: kInfoIconSize,
        ),
        const SizedBox(
          height: kMargin2x,
        ),
        Text(
          infoData,
          style: kHeadlineTextStyle,
        ),
        const SizedBox(
          height: kMargin2x,
        ),
        Text(
          hintText,
          style: kSubHeadlineTextStyle,
        ),
      ],
    );
  }
}
