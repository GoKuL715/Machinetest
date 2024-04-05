// main.dart
import 'package:flutter/material.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/home_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(
        controller: WeatherController(),
      ),
    );
  }
}
