import 'dart:convert' show json;
import 'package:http/http.dart' as http show get;

class DailyForecast {
  final String date;
  final String maxTemp;
  final String minTemp;
  final String description;
  final int weatherCode;

  DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.description,
    required this.weatherCode,
  });
}

class Weather {
  final String temperature;
  final String description;
  final int weatherCode;

  Weather({
    required this.temperature,
    required this.description,
    required this.weatherCode,
  });
}

class WeatherService {
  static const double _latitude = 15.143;
  static const double _longitude = 120.575;

  /// ✅ Get current weather
  static Future<Weather> getCurrentWeather() async {
    final url =
        "https://api.open-meteo.com/v1/forecast?latitude=$_latitude&longitude=$_longitude&current_weather=true&timezone=auto";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final current = data["current_weather"];

      final temp = current["temperature"];
      final code = current["weathercode"];

      return Weather(
        temperature: temp != null ? "${temp.round()}°C" : "N/A",
        description: _mapWeatherCodeToDescription(code),
        weatherCode: code,
      );
    } else {
      throw Exception("Error fetching current weather: ${response.statusCode}");
    }
  }

  /// ✅ Get 7-day forecast
  static Future<List<DailyForecast>> getForecast() async {
    final url =
        "https://api.open-meteo.com/v1/forecast?latitude=$_latitude&longitude=$_longitude&daily=temperature_2m_max,temperature_2m_min,weathercode&timezone=auto";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final daily = data["daily"];

      List<DailyForecast> forecastList = [];
      for (int i = 0; i < daily["time"].length; i++) {
        forecastList.add(
          DailyForecast(
            date: daily["time"][i],
            maxTemp: "${daily["temperature_2m_max"][i].round()}°C",
            minTemp: "${daily["temperature_2m_min"][i].round()}°C",
            description: _mapWeatherCodeToDescription(daily["weathercode"][i]),
            weatherCode: daily["weathercode"][i],
          ),
        );
      }
      return forecastList;
    } else {
      throw Exception("Error fetching forecast: ${response.statusCode}");
    }
  }

  /// ✅ Shared description mapping
  static String _mapWeatherCodeToDescription(int code) {
    if (code == 0) return "Clear Sky";
    if (code >= 1 && code <= 3) return "Partly Cloudy";
    if (code == 45 || code == 48) return "Foggy";
    if (code >= 51 && code <= 57) return "Drizzle";
    if (code >= 61 && code <= 67) return "Rainy";
    if (code >= 71 && code <= 77) return "Snowy";
    if (code >= 80 && code <= 82) return "Rain Showers";
    if (code >= 95 && code <= 99) return "Thunderstorm";
    return "Cloudy";
  }
}
