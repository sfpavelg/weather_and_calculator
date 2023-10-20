//
// import 'package:flutter/material.dart';
//
// class WeatherScreen extends StatefulWidget {
//   const WeatherScreen({super.key});
//
//   @override
//   _WeatherScreenState createState() => _WeatherScreenState();
// }
//
// class _WeatherScreenState extends State<WeatherScreen> {
//   // Declare weather variables
//
//   // Define weather API integration logic and user interface
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         // Build weather user interface
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _cityName = 'Saratov';

  Future<Map<String, dynamic>> _fetchWeather() async {
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$_cityName&appid=YOUR_API_KEY');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  void initState() {
    super.initState();
    // Start fetching weather data every 2-3 seconds
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      setState(() {
        _fetchWeather();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _fetchWeather(),
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              final weatherData = snapshot.data;

              // Extract necessary weather data from the response
              final temperature = weatherData?['main']['temp'];
              final description = weatherData?['weather'][0]['description'];

              return Column(
                children: [
                  Text(
                    'City: $_cityName',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Temperature: $temperature °C',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description: $description',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Failed to load weather data');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}