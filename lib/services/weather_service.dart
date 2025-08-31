import 'dart:convert';
import 'package:http/http.dart' as http;

class Weather {
  final String temperature;
  final String description;

  Weather({required this.temperature, required this.description});
}

class WeatherService {
  static const double _latitude = 15.143;
  static const double _longitude = 120.575;

  static Future<Weather> getCurrentWeather() async {
    final url =
        "https://api.open-meteo.com/v1/forecast?latitude=$_latitude&longitude=$_longitude&current_weather=true&timezone=auto";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final temp = data["current_weather"]["temperature"];
      final weatherCode = data["current_weather"]["weathercode"];

      String description;

      // Map codes to descriptive weather
      if (weatherCode == 0) {
        description = "Clear Sky";
      } else if (weatherCode >= 1 && weatherCode <= 3) {
        description = "Partly Cloudy";
      } else if (weatherCode == 45 || weatherCode == 48) {
        description = "Foggy";
      } else if (weatherCode >= 51 && weatherCode <= 57) {
        description = "Drizzle";
      } else if (weatherCode >= 61 && weatherCode <= 67) {
        description = "Rainy";
      } else if (weatherCode >= 80 && weatherCode <= 82) {
        description = "Rain Showers";
      } else if (weatherCode >= 95 && weatherCode <= 99) {
        description = "Thunderstorm";
      } else {
        description = "Cloudy";
      }

      return Weather(temperature: "${temp.round()}°C", description: description);
    } else {
      throw Exception("Error fetching weather: ${response.statusCode}");
    }
  }
}
