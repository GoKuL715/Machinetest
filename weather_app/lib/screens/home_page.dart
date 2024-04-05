// views/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/models/weather.dart';

class HomePage extends StatelessWidget {
  final WeatherController controller;

  const HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter city name',
              ),
              onSubmitted: (cityName) {
                controller.fetchWeather(cityName);
              },
            ),
            ElevatedButton(
              onPressed: () {
                controller.fetchWeather('London'); // Default city
              },
              child: Text('Search'),
            ),
            Consumer<WeatherController>(
              builder: (context, weatherController, _) {
                if (weatherController.errorMessage != null) {
                  return Text(
                    weatherController.errorMessage!,
                    style: TextStyle(color: Colors.red),
                  );
                } else if (weatherController.currentWeather != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Current Weather in ${weatherController.currentWeather!.city}',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('Temperature: ${weatherController.currentWeather!.temperature}°C'),
                      Text('Humidity: ${weatherController.currentWeather!.humidity}%'),
                      Text('Description: ${weatherController.currentWeather!.description}'),
                    ],
                  );
                } else {
                  return Container(); // Placeholder for current weather
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              '5-Day Forecast',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Consumer<WeatherController>(
                builder: (context, weatherController, _) {
                  if (weatherController.forecast != null) {
                    return ListView.builder(
                      itemCount: weatherController.forecast!.length,
                      itemBuilder: (context, index) {
                        final forecastItem = weatherController.forecast![index];
                        return ListTile(
                          title: Text(forecastItem.city),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Temperature: ${forecastItem.temperature}°C'),
                              Text('Humidity: ${forecastItem.humidity}%'),
                              Text('Description: ${forecastItem.description}'),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Consumer({required Widget Function(dynamic context, dynamic weatherController, dynamic _) builder}) {
}
