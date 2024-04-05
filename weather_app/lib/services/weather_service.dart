// services/weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class WeatherService {
  static const String apiKey = 'b39c7464ab56df782ab4652f7da5fd99';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> getCurrentWeather(String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather(
        city: data['name'],
        temperature: data['main']['temp'].toDouble(),
        humidity: data['main']['humidity'].toDouble(),
        description: data['weather'][0]['description'],
      );
    } else {
      throw Exception('Failed to load current weather');
    }
  }

  Future<List<Weather>> getForecast(String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl/forecast?q=$city&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['list'] as List;
      return data.map((item) {
        return Weather(
          city: city,
          temperature: item['main']['temp'].toDouble(),
          humidity: item['main']['humidity'].toDouble(),
          description: item['weather'][0]['description'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load forecast');
    }
  }
}
