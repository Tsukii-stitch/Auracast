import 'package:flutter/material.dart';
import 'pages/weather_page.dart';

void main() {
  runApp(const AuraCastApp());
}

class AuraCastApp extends StatelessWidget {
  const AuraCastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuraCast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: const WeatherPage(),
    );
  }
}
