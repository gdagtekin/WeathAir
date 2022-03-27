import 'package:flutter/material.dart';

const kCloudyStartColor = Color(0xFF66AEF2);
const kCloudyEndColor = Color(0xFF2A3B75);
const kClearStartColor = Color(0xFFEDB124);
const kClearEndColor = Color(0xFFED7200);
const kRainyStartColor = Color(0xFFC7C3F1);
const kRainyEndColor = Color(0xFF182658);
const kNightEndColor = Color(0xFF070B34);
const kNightStartColor = Color(0xFF855988);
const kPrimaryTextColor = Color(0xFFFEFEFE);
const kSecondaryTextColor = Color(0xFFF3F3F3);
const kTertiaryTextColor = Color(0xFFEEEEEE);
const kDividerColor = Color(0x33FFFFFF);
const kCardBackgroundColor = Color(0x33FFFFFF);
const kIconColor = Color(0xFFFEFEFE);
const kTransparent = Color(0x00FFFFFF);
const kSearchViewColor = Color(0x33FFFFFF);
const kSearchColor = Color(0x50FFFFFF);

const kIconSize = 24.0;
const kInfoIconSize = 24.0;
const kHourlyIconSize = 50.0;
const kDailyIconSize = 30.0;
const kMargin1x = 4.0;
const kMargin2x = 8.0;
const kMargin3x = 12.0;
const kMargin4x = 16.0;

const kTemperatureTextStyle = TextStyle(
    color: kPrimaryTextColor,
    fontSize: 80.0,
    fontWeight: FontWeight.w700,
    fontFamily: 'Montserrat',
    letterSpacing: 4.0);

const kTemperatureAlphaTextStyle = TextStyle(
    color: Color(0x00000000),
    fontSize: 80.0,
    fontWeight: FontWeight.w700,
    fontFamily: 'Montserrat',
    letterSpacing: 4.0);

const kLargeTitleTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 32.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w400,
);

const kTitleTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 24.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w700,
);

const kHeadlineTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 20.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w400,
);

const kHeadlineTertiaryTextStyle = TextStyle(
  color: kTertiaryTextColor,
  fontSize: 20.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w400,
);

const kSubHeadlinePrimaryTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 16.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w400,
);

const kSubHeadlineTextStyle = TextStyle(
  color: kTertiaryTextColor,
  fontSize: 14.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w400,
);

SizedBox myMarginVertical() {
  return const SizedBox(
    height: 20.0,
  );
}

SizedBox myMarginHorizontal() {
  return const SizedBox(
    width: 20.0,
  );
}

Divider myDivider() {
  return const Divider(
    height: 20,
    thickness: 1,
    indent: 90,
    endIndent: 90,
    color: kDividerColor,
  );
}

final animations = <String>[
  'weather-sunny.json',
  'weather-cloudy.json',
  'weather-rainy.json',
  'weather-snow.json'
];

final startColor = <Color>[
  kClearStartColor,
  kCloudyStartColor,
  kRainyStartColor,
  kNightStartColor
];

final endColor = <Color>[
  kClearEndColor,
  kCloudyEndColor,
  kRainyEndColor,
  kNightEndColor
];
