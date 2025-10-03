import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({super.key});

  // ✅ Helper to pick an icon based on weather code
  IconData getWeatherIcon(int code) {
    if (code == 0) return Icons.wb_sunny; // Clear sky
    if (code >= 1 && code <= 3) return Icons.cloud; // Cloudy
    if (code == 45 || code == 48) return Icons.cloud; // Fog
    if (code >= 51 && code <= 67) return Icons.grain; // Drizzle / Rain
    if (code >= 71 && code <= 77) return Icons.ac_unit; // Snow
    if (code >= 80 && code <= 82) return Icons.cloud_queue; // Showers
    if (code >= 95 && code <= 99) return Icons.bolt; // Thunderstorm
    return Icons.help_outline; // Default if unknown
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("7-Day Forecast")),
      body: FutureBuilder<List<DailyForecast>>(
        future: WeatherService.getForecast(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final forecast = snapshot.data!;
          if (forecast.isEmpty) {
            return const Center(child: Text("No forecast available."));
          }

          return ListView.builder(
            itemCount: forecast.length,
            itemBuilder: (context, index) {
              final day = forecast[index];

              return Card(
                child: ListTile(
                  leading: Icon(
                    getWeatherIcon(day.weatherCode),
                    color: Colors.blueAccent,
                    size: 32,
                  ),
                  title: Text(day.date),
                  subtitle: Text(day.description),
                  trailing: Text("${day.maxTemp} / ${day.minTemp}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
