import 'package:weather/weather.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityNameDefault = 'Saratov';
  late String _changedInputCity = cityNameDefault;
  final WeatherFactory wf = WeatherFactory(
      "fe6fe6a63b80cd1f3dc6c3f2fed7fb1c",
      language: Language.RUSSIAN);

  Future<Weather> _fetchWeather(String cityName) async {
    Weather w = await wf.currentWeatherByCityName(cityName);
    return w;
  }

  @override
  void initState() {
    super.initState();
    // Start fetching weather data every 2-3 seconds
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() {
        _fetchWeather(_changedInputCity);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<Weather>(
          future: _fetchWeather(_changedInputCity),
          builder: (BuildContext context, AsyncSnapshot<Weather> weather) {
            if (weather.hasData) {
              final weatherData = weather.data;

              // Extract necessary weather data from the response
              double? temperature =
                  weatherData!.temperature!.celsius!.roundToDouble();
              final String description =
                  'Дата: ${weatherData.date!.day}.${weatherData.date!.month} ';

              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 200,
                        height: 40,
                        child: TextField(
                          onChanged: (vale) => _changedInputCity = vale,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Введите город',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _fetchWeather(_changedInputCity);
                        },
                        child: const Text(
                          'Изменить',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'City: $_changedInputCity',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Temperature: $temperature °C',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description: $description',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
