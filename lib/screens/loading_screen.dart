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

  @override
  void initState() {
    super.initState();
    getLocationData();

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void getLocationData() async {
    WeatherResponse weatherData = await WeatherModel().getLocation(context);
    String locationName = await WeatherModel().getLocationName();
    weatherData.locationName = locationName;
    Provider.of<WeatherData>(context, listen: false).changeData(weatherData);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));
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
