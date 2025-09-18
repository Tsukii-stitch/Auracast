import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/weather_service.dart';
import '../widgets/mood_selector.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/icon.dart';
import '../models/recommendation.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _temperature = "";
  String _weatherDescription = "";
  bool _isLoading = true;
  String _error = "";
  String? _selectedMood;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
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
        return Icons.wb_sunny;
      case "Rainy":
        return Icons.beach_access;
      case "Thunderstorm":
        return Icons.flash_on;
      default:
        return Icons.cloud;
    }
  }

  @override
  Widget build(BuildContext context) {
    final recommendations =
        _selectedMood != null ? _getRecommendations() : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('AuraCast'),
        actions: const [
          TopRightIcon(),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                // 🌥️ Cloudy background theme
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blueGrey.shade200,
                      Colors.grey.shade400,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Icon(_getWeatherIcon(), size: 28),
                          const SizedBox(width: 8),
                          Text("$_temperature, $_weatherDescription",
                              style: const TextStyle(fontSize: 18)),
                        ],
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

                      const SizedBox(height: 30),

                      // ⭐ Animated recommendations list
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: _selectedMood == null
                            ? const SizedBox.shrink()
                            : Column(
                                key: ValueKey(_selectedMood),
                                children: recommendations
                                    .map((rec) => RecommendationCard(
                                          recommendation: rec,
                                        ))
                                    .toList(),
                              ),
                      ),

                      const SizedBox(height: 30),

                      // ⬅️ Reverted back to original Save button
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
