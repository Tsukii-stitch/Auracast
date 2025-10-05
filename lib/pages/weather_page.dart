import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/weather_service.dart';
import '../widgets/mood_selector.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/icon.dart';
import '../models/recommendation.dart';
import 'forecast_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
    with SingleTickerProviderStateMixin {
  String _temperature = "";
  String _weatherDescription = "";
  bool _isLoading = true;
  String _error = "";
  String? _selectedMood;
  late AnimationController _iconController;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    _iconController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _error = "";
    });

    try {
      final weather = await WeatherService.getCurrentWeather();
      setState(() {
        _temperature = weather.temperature;
        _weatherDescription = weather.description;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _saveMood() async {
    if (_selectedMood == null) return;
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().toIso8601String();
    final entry =
        "$now | $_selectedMood | $_temperature | $_weatherDescription";
    final history = prefs.getStringList("moodHistory") ?? [];
    history.add(entry);
    await prefs.setStringList("moodHistory", history);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Mood saved to history!")),
    );
  }

  List<Recommendation> _getRecommendations() {
    return Recommendation.getRecommendations(
        _selectedMood, _weatherDescription);
  }

  IconData _getWeatherIcon() {
    switch (_weatherDescription) {
      case "Clear Sky":
        return FontAwesomeIcons.sun;
      case "Partly Cloudy":
        return FontAwesomeIcons.cloudSun;
      case "Cloudy":
        return FontAwesomeIcons.cloud;
      case "Rainy":
      case "Drizzle":
      case "Rain Showers":
        return FontAwesomeIcons.cloudRain;
      case "Thunderstorm":
        return FontAwesomeIcons.bolt;
      case "Foggy":
        return FontAwesomeIcons.smog;
      case "Snowy":
        return FontAwesomeIcons.snowflake;
      default:
        return FontAwesomeIcons.cloud;
    }
  }

  List<Color> _getBackgroundColors(String desc) {
    switch (desc) {
      case "Clear Sky":
        return [Colors.orange.shade300, Colors.yellow.shade100];
      case "Partly Cloudy":
        return [Colors.blue.shade200, Colors.white];
      case "Rainy":
      case "Drizzle":
        return [Colors.blueGrey.shade400, Colors.blueGrey.shade100];
      case "Thunderstorm":
        return [Colors.deepPurple.shade700, Colors.grey.shade900];
      case "Snowy":
        return [Colors.lightBlue.shade100, Colors.white];
      default:
        return [Colors.grey.shade300, Colors.white];
    }
  }

  @override
  Widget build(BuildContext context) {
    final recommendations =
        _selectedMood != null ? _getRecommendations() : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('AuraCast'),
        actions: [
          // ✅ Forecast button
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: "View Forecast",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForecastPage()),
              );
            },
          ),
          const TopRightIcon(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchWeather,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getBackgroundColors(_weatherDescription),
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),

                      // Animated weather icon with subtle motion
                      Center(
                        child: AnimatedBuilder(
                          animation: _iconController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, 5 * _iconController.value),
                              child: Icon(
                                _getWeatherIcon(),
                                size: 64,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Daily summary card
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white.withOpacity(0.9),
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.thermostat, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(
                                "$_temperature • $_weatherDescription",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      MoodSelector(
                        selectedMood: _selectedMood,
                        onMoodSelected: (mood) {
                          setState(() {
                            _selectedMood = mood;
                          });
                        },
                      ),

                      const SizedBox(height: 25),

                      // Animated prompt text
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: _selectedMood == null
                            ? const Text(
                                "Select your mood to get personalized vibes ",
                                key: ValueKey('prompt'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              )
                            : Text(
                                _selectedMood == null 
                                  ? "Select your mood to get personalized vibes "
                                  : "Here’s something for your ${_selectedMood!.toLowerCase()} mood ",
                                  style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                      ),

                      const SizedBox(height: 20),

                      // Animated recommendation list
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: _selectedMood != null ? 1 : 0,
                        child: Column(
                          children: recommendations
                              .map((rec) => RecommendationCard(
                                    recommendation: rec,
                                  ))
                              .toList(),
                        ),
                      ),

                      const SizedBox(height: 30),

                      ElevatedButton.icon(
                        onPressed: _selectedMood == null
                            ? null
                            : () async => _saveMood(),
                        icon: const Icon(Icons.save),
                        label: const Text("Save Mood to History"),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
