import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Main entry point for the application.
void main() {
  runApp(const WeatherApp());
}

// The root widget of the application.
class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      home: const WeatherHomePage(),
    );
  }
}

// A StatefulWidget to handle fetching and displaying weather data.
class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  // Latitude and longitude for Angeles City, Pampanga, Philippines.
  static const double _latitude = 15.143;
  static const double _longitude = 120.575;

  // State variables for the weather data.
  String _cityName = 'Angeles City';
  String _temperature = '';
  // The Open-Meteo API provides a weather code; we will convert it to a description.
  String _weatherDescription = '';
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  // Fetches weather data from the Open-Meteo API.
  Future<void> _fetchWeatherData() async {
    setState(() {
      _isLoading = true;
      _error = '';
      _temperature = ''; // Reset temperature and description while loading
      _weatherDescription = '';
    });

    // The URL is constructed as a simple string to ensure compatibility with older http package versions.
    // This approach, combined with a compatible package version, should resolve the "No such method" error.
    final String url = 'https://api.open-meteo.com/v1/forecast?'
        'latitude=$_latitude&'
        'longitude=$_longitude&'
        'hourly=temperature_2m,weather_code&'
        'current_weather=true&'
        'timezone=auto';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Open-Meteo provides the current temperature under the 'current_weather' object.
        final currentTemperature = data['current_weather']['temperature'];
        final weatherCode = data['current_weather']['weathercode'];

        // A simple mapping for weather codes to descriptions.
        String description = '';
        if (weatherCode >= 0 && weatherCode <= 3) {
          description = 'Clear Sky';
        } else if (weatherCode >= 45 && weatherCode <= 48) {
          description = 'Foggy';
        } else if (weatherCode >= 51 && weatherCode <= 57) {
          description = 'Drizzle';
        } else if (weatherCode >= 61 && weatherCode <= 67) {
          description = 'Rainy';
        } else if (weatherCode >= 71 && weatherCode <= 75) {
          description = 'Snowy';
        } else if (weatherCode >= 80 && weatherCode <= 82) {
          description = 'Rain Showers';
        } else if (weatherCode >= 85 && weatherCode <= 86) {
          description = 'Snow Showers';
        } else if (weatherCode >= 95 && weatherCode <= 99) {
          description = 'Thunderstorm';
        } else {
          description = 'Unknown';
        }

        setState(() {
          _temperature = '${currentTemperature.round()}°C';
          _weatherDescription = description;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load weather data: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'An error occurred: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Angeles City Weather'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? const CircularProgressIndicator()
              : _error.isNotEmpty
                  ? Text(_error)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 40,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _cityName,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _temperature,
                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _weatherDescription.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton.icon(
                          onPressed: _fetchWeatherData,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Refresh'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
