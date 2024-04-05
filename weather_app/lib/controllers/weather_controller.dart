// controllers/weather_controller.dart
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherController extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  Weather? currentWeather;
  List<Weather>? forecast;
  String? errorMessage;

  Future<void> fetchWeather(String city) async {
    try {
      currentWeather = await _weatherService.getCurrentWeather(city);
      forecast = await _weatherService.getForecast(city);
      errorMessage = null;
    } catch (e) {
      currentWeather = null;
      forecast = null;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
