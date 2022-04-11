import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/weather_screen.dart';
import 'package:clima/models/weather_response.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:clima/models/weather_provider.dart';
import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  int index = 0;
  Timer? _timer;
  int start = 6;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    checkIsManuel();

    index = Random().nextInt(4) + 1;
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          index++;
          _controller.value = 0;
        });
      }
    });
  }

  Future<void> checkIsManuel() async {
    final SharedPreferences prefs = await _prefs;
    final bool isManuel = (prefs.getBool(isLocationManuel) ?? false);
    if (isManuel) {
      final num latitude = num.parse(prefs.getString(manuelLatitude) ?? "0");
      final num longitude = num.parse(prefs.getString(manuelLongitude) ?? "0");
      if (latitude == 0 || longitude == 0) {
        getLocationData();
        startTimer();
      } else {
        getLocationDataWithLatLan(latitude, longitude);
      }
    } else {
      getLocationData();
      startTimer();
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
          getLocationDataWithLatLan(41.0351, 28.9833);
          showSnackMessage(context);
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    if(_timer != null) {
      _timer?.cancel();
    }
    super.dispose();
  }

  void getLocationData() async {
    try {
      WeatherResponse weatherData = await WeatherModel().getLocation(context);
      String locationName = await WeatherModel().getLocationName();
      weatherData.locationName = locationName;
      Provider.of<WeatherData>(context, listen: false).changeData(weatherData);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LocationScreen();
      }));
    } catch (e) {
      getLocationDataWithLatLan(41.0351, 28.9833);
      showSnackMessage(context);
    }
  }

  void getLocationDataWithLatLan(num latitude, num longitude) async {
    WeatherResponse weatherData =
        await WeatherModel().getLocationWithLatLon(latitude, longitude);
    String locationName = await WeatherModel().getLocationName();
    weatherData.locationName = locationName;
    Provider.of<WeatherData>(context, listen: false).changeData(weatherData);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));
  }

  void showSnackMessage(BuildContext context) {
    var t = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        t!.defaultLocation,
        style: kSubHeadlinePrimaryTextStyle,
      ),
      duration: const Duration(seconds: 5),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = (MediaQuery.of(context).size.width);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kTransparent,
    ));

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              startColor[index % animations.length],
              endColor[index % animations.length]
            ],
          ),
        ),
        child: Center(
          child: Lottie.asset(
            'assets/${animations[index % animations.length]}',
            width: (screenWidth - ((screenWidth / 100) * 30)),
            height: 200,
            repeat: false,
            animate: true,
            controller: _controller,
            onLoaded: (animations) {
              _controller
                ..duration = (animations.duration * 0.7)
                ..forward();
            },
          ),
        ),
      ),
    );
  }
}
