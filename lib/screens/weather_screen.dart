import 'package:weather/weather.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  String cityCurrent = 'Saratov';
  late String _changedInputCity = cityCurrent;
  final WeatherFactory wf = WeatherFactory("fe6fe6a63b80cd1f3dc6c3f2fed7fb1c",
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
              double? temperature =
                  weatherData!.temperature!.celsius!.roundToDouble();
              final String date =
                  '${weatherData.date!.day}.${weatherData.date!.month} ';
              final double windSpeed = weatherData.windSpeed!.roundToDouble();
              final String? country = weatherData.country;
              final String? weatherDescription = weatherData.weatherDescription;

              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 200,
                        height: 40,
                        child: TextField(
                          onChanged: (vale) => cityCurrent = vale,
                          decoration: const InputDecoration(
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
                          _changedInputCity = cityCurrent;
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
                    'Дата: $date',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Город: $_changedInputCity',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Страна: $country',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Температура: $temperature °C',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Скорость ветра: $windSpeed м/с',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Погода: $weatherDescription',
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
