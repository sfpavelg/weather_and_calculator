
import 'package:flutter/material.dart';
import 'package:weather_and_calculator/screens/calc_screen.dart';
import 'package:weather_and_calculator/screens/form_screen.dart';
import 'package:weather_and_calculator/screens/weather_screen.dart';


class HomeScreen extends StatelessWidget {
   const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormScreen()),
              );
            },
            child: const Text('Form'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalcScreen()),
              );
            },
            child: const Text('Calculator'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  WeatherScreen()),
              );
            },
            child: const Text('Weather'),
          ),
        ],
      ),
    );
  }
}