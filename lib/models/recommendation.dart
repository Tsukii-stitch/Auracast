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

  static List<Recommendation> getRecommendations(String? mood, String weather) {
    mood = mood?.toLowerCase() ?? "";
    weather = weather.toLowerCase();

    // HAPPY
    if (mood == "happy") {
      if (weather.contains("clear")) {
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
          Recommendation(
              title: "Cycling Fun",
              subtitle: "Upbeat Pop Playlist",
              image: "assets/cycling.webp",
              info: "Based on: Clear Sky, Happy Mood"),
          Recommendation(
              title: "Ice Cream Stop",
              subtitle: "Chill Summer Vibes",
              image: "assets/icecream.jpg",
              info: "Based on: Clear Sky, Happy Mood"),
        ];
      } else if (weather.contains("rain") || weather.contains("drizzle")) {
        return [
          Recommendation(
              title: "Rain Dance",
              subtitle: "Upbeat Pop Playlist",
              image: "assets/dance.jpg",
              info: "Based on: Rainy Weather, Happy Mood"),
          Recommendation(
              title: "Board Games Night",
              subtitle: "Fun Indoors",
              image: "assets/games.jpg",
              info: "Based on: Rainy Weather, Happy Mood"),
        ];
      } else if (weather.contains("cloud")) {
        return [
          Recommendation(
              title: "Indoor Café",
              subtitle: "Cozy Jazz",
              image: "assets/cafe.webp",
              info: "Based on: Cloudy Weather, Happy Mood"),
          Recommendation(
              title: "Movie Marathon",
              subtitle: "Comedy Specials",
              image: "assets/ movies.jpg",
              info: "Based on: Cloudy Weather, Happy Mood"),
        ];
      } else if (weather.contains("storm")) {
        return [
          Recommendation(
              title: "Indoor Dance Party",
              subtitle: "Hype EDM Mix",
              image: "assets/dance.jpg",
              info: "Based on: Stormy Weather, Happy Mood"),
          Recommendation(
              title: "Video Game Marathon",
              subtitle: "Exciting Action Games",
              image: "assets/games.jpg",
              info: "Based on: Stormy Weather, Happy Mood"),
        ];
      }
    }

    // MELANCHOLY
    if (mood == "melancholy") {
      if (weather.contains("rain") || weather.contains("drizzle")) {
        return [
          Recommendation(
              title: "Rainy Reads",
              subtitle: "Melancholic Classics",
              image: "assets/rain_read.jpg",
              info: "Based on: Rainy Weather, Melancholy Mood"),
          Recommendation(
              title: "Cozy Blanket",
              subtitle: "Slow Chill Vibe Playlist",
              image: "assets/blanket.jpg",
              info: "Based on: Rainy Weather, Melancholy Mood"),
        ];
      } else if (weather.contains("cloud")) {
        return [
          Recommendation(
              title: "Deep Thoughts",
              subtitle: "Lo-Fi Music",
              image: "assets/thoughts.jpg",
              info: "Based on: Cloudy Weather, Melancholy Mood"),
          Recommendation(
              title: "Art Therapy",
              subtitle: "Sketch or Paint",
              image: "assets/art.jpg",
              info: "Based on: Cloudy Weather, Melancholy Mood"),
        ];
      } else if (weather.contains("storm")) {
        return [
          Recommendation(
              title: "Journaling",
              subtitle: "Write your thoughts",
              image: "assets/journaling.jpg",
              info: "Based on: Stormy Weather, Melancholy Mood"),
          Recommendation(
              title: "Meditation & Tea",
              subtitle: "Quiet Reflection",
              image: "assets/meditation.jpg",
              info: "Based on: Stormy Weather, Melancholy Mood"),
        ];
      }
    }

    // EXCITED
    if (mood == "excited") {
      if (weather.contains("clear")) {
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
              info: "Based on: Clear Sky, Excited Mood"),
        ];
      } else if (weather.contains("storm")) {
        return [
          Recommendation(
              title: "Indoor Dance Party",
              subtitle: "Hype EDM Mix",
              image: "assets/dance.jpg",
              info: "Based on: Stormy Weather, Excited Mood"),
          Recommendation(
              title: "Video Game Marathon",
              subtitle: "Action Soundtracks",
              image: "assets/games.jpg",
              info: "Based on: Stormy Weather, Excited Mood"),
        ];
      }
    }

    // CONTENT
    if (mood == "content") {
      if (weather.contains("cloud")) {
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
      }
    }

    // NEUTRAL
    if (mood == "neutral") {
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

     // Lazy
    if (mood == "lazy") {
      return [
        Recommendation(
            title: "Gray Skies",
            subtitle: "Rainy Day Comfort Mix",
            image: "cozy.jpg",
            info: "Based on: Any Weather, Lazy Mood"),
        Recommendation(
            title: "Fire and Rain",
            subtitle: "Drizzling Beats & Cozy Treats",
            image: "rest_grass.jpg",
            info: "Based on: Any Weather, Lazy Mood"),
      ];
    }

    // DEFAULT
    return [
      Recommendation(
          title: "Explore Something New",
          subtitle: "Curated for You",
          image: "assets/discover.jpg",
          info: "Based on: $weather, $mood Mood"),
    ];
  }
}
