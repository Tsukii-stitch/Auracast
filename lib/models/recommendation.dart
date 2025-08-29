class Recommendation {
  final String title;
  final String subtitle;
  final String image;
  final String info;

  Recommendation({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.info,
  });

  static List<Recommendation> getRecommendations(
      String? mood, String weather) {
    mood = mood?.toLowerCase() ?? "";
    weather = weather.toLowerCase();

    if (mood == "happy" && weather.contains("clear")) {
      return [
        Recommendation(
            title: "Picnic Time",
            subtitle: "Outdoor Chill Vibes",
            image: "assets/picnic.jpg",
            info: "Based on: Clear Sky, Happy Mood"),
        Recommendation(
            title: "Sunset Walk",
            subtitle: "Feel-Good Indie",
            image: "assets/sunset_walk.jpg",
            info: "Based on: Clear Sky, Happy Mood"),
      ];
    } else if (mood == "melancholy" && weather.contains("rain")) {
      return [
        Recommendation(
            title: "Rainy Reads",
            subtitle: "Melancholic Classics",
            image: "assets/rain_read.jpg",
            info: "Based on: Rainy Weather, Melancholy Mood"),
        Recommendation(
            title: "Cozy Blanket",
            subtitle: "Slow Piano Playlist",
            image: "assets/blanket.jpg",
            info: "Based on: Rainy Weather, Melancholy Mood"),
      ];
    } else if (mood == "excited" && weather.contains("clear")) {
      return [
        Recommendation(
            title: "Adventure Time",
            subtitle: "High-Energy Rock",
            image: "assets/adventure.jpg",
            info: "Based on: Clear Sky, Excited Mood"),
        Recommendation(
            title: "Go For a Run",
            subtitle: "Cardio Beats",
            image: "assets/run.jpg",
            info: "Based on: Sunny Weather, Excited Mood"),
      ];
    } else if (mood == "content" && weather.contains("cloudy")) {
      return [
        Recommendation(
            title: "Cafe & Read",
            subtitle: "Relaxing Jazz",
            image: "assets/coffee.jpg",
            info: "Based on: Cloudy Weather, Content Mood"),
        Recommendation(
            title: "Creative Flow",
            subtitle: "Instrumental Vibes",
            image: "assets/study.jpg",
            info: "Based on: Cloudy Weather, Content Mood"),
      ];
    } else if (mood == "neutral") {
      return [
        Recommendation(
            title: "Focus Mode",
            subtitle: "Ambient Study Mix",
            image: "assets/focus.jpg",
            info: "Based on: Any Weather, Neutral Mood"),
        Recommendation(
            title: "Time to Reflect",
            subtitle: "Thoughtful Podcasts",
            image: "assets/reflect.webp",
            info: "Based on: Any Weather, Neutral Mood"),
      ];
    }

    return [
      Recommendation(
          title: "Explore Something New",
          subtitle: "Curated for You",
          image: "assets/discover.jpg",
          info: "Based on: $weather, $mood Mood"),
    ];
  }
}
