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
