import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:task_manager/models/weather.dart';

class WeatherWidget extends StatefulWidget {
  final String city;

  const WeatherWidget({super.key, required this.city});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late Weather _weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData(widget.city);
  }

  Future<void> _fetchWeatherData(String city) async {
    const apiKey =
        '325f9d7f12152f03736506fa3d14fe72'; // Replace with your OpenWeatherMap API key
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _weatherData = Weather.fromJson(jsonData, city);
      });
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/mountains.jpg', // Provide your image path here
            fit: BoxFit.cover,
          ),
          Center(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              color: Colors.white.withOpacity(0.5),
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                // ignore: unnecessary_null_comparison
                child: _weatherData != null
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'City: ${_weatherData.city}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Temperature: ${_weatherData.temperature.toStringAsFixed(1)}°C',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Description: ${_weatherData.description}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
