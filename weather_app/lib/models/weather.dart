// models/weather.dart
class Weather {
  final String city;
  final double temperature;
  final double humidity;
  final String description;

  Weather({
    required this.city,
    required this.temperature,
    required this.humidity,
    required this.description,
  });
}
