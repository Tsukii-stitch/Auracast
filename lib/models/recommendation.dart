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
          // Extra
          Recommendation(
              title: "Beach Hangout",
              subtitle: "Tropical Vibes",
              image: "assets/beach.jpg",
              info: "Based on: Clear Sky, Happy Mood"),
          Recommendation(
              title: "Photo Walk",
              subtitle: "Capture the Joy",
              image: "assets/photo_walk.jpg",
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
          // Extra
          Recommendation(
              title: "Cooking Fun",
              subtitle: "Wholesome Recipes",
              image: "assets/cooking.jpg",
              info: "Based on: Rainy Weather, Happy Mood"),
          Recommendation(
              title: "Sing-Along",
              subtitle: "Cheerful Karaoke",
              image: "assets/karaoke.jpg",
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
              image: "assets/movies.jpg",
              info: "Based on: Cloudy Weather, Happy Mood"),
          // Extra
          Recommendation(
              title: "Puzzle Time",
              subtitle: "Brain Teasers",
              image: "assets/puzzle.jpeg",
              info: "Based on: Cloudy Weather, Happy Mood"),
          Recommendation(
              title: "Creative Journaling",
              subtitle: "Happy Thoughts",
              image: "assets/journaling.jpg",
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
          // Extra
          Recommendation(
              title: "Creative Crafts",
              subtitle: "DIY Projects",
              image: "assets/crafts.jpg",
              info: "Based on: Stormy Weather, Happy Mood"),
          Recommendation(
              title: "Virtual Hangout",
              subtitle: "Call Friends Online",
              image: "assets/virtual.jpg",
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
          // Extra
          Recommendation(
              title: "Piano Reflections",
              subtitle: "Soft Instrumentals",
              image: "assets/piano.jpg",
              info: "Based on: Rainy Weather, Melancholy Mood"),
          Recommendation(
              title: "Poetry Hour",
              subtitle: "Write or Read Poems",
              image: "assets/poetry.jpg",
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
          // Extra
          Recommendation(
              title: "Photography Mood",
              subtitle: "Capture the Clouds",
              image: "assets/camera.jpg",
              info: "Based on: Cloudy Weather, Melancholy Mood"),
          Recommendation(
              title: "Candlelight Calm",
              subtitle: "Ambient Relaxation",
              image: "assets/candle.jpg",
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
          // Extra
          Recommendation(
              title: "Listen to Audiobooks",
              subtitle: "Immersive Stories",
              image: "assets/audiobook.jpg",
              info: "Based on: Stormy Weather, Melancholy Mood"),
          Recommendation(
              title: "Soft Sketching",
              subtitle: "Draw the Storm",
              image: "assets/sketch.jpg",
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
          // Extra
          Recommendation(
              title: "Skateboarding",
              subtitle: "Energetic Beats",
              image: "assets/skate.jpg",
              info: "Based on: Clear Sky, Excited Mood"),
          Recommendation(
              title: "Road Trip",
              subtitle: "Highway Anthems",
              image: "assets/roadtrip.jpg",
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
          // Extra
          Recommendation(
              title: "Creative Music Session",
              subtitle: "Make Your Own Beats",
              image: "assets/music.jpg",
              info: "Based on: Stormy Weather, Excited Mood"),
          Recommendation(
              title: "Workout Challenge",
              subtitle: "Push Your Limits",
              image: "assets/workout.webp",
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
          // Extra
          Recommendation(
              title: "Slow Cooking",
              subtitle: "Wholesome Recipes",
              image: "assets/slowcook.jpg",
              info: "Based on: Cloudy Weather, Content Mood"),
          Recommendation(
              title: "Light Gardening",
              subtitle: "Peaceful Outdoors",
              image: "assets/garden.jpg",
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
        // Extra
        Recommendation(
            title: "Organize & Declutter",
            subtitle: "Minimalist Energy",
            image: "assets/declutter.jpg",
            info: "Based on: Any Weather, Neutral Mood"),
        Recommendation(
            title: "Casual Browsing",
            subtitle: "Relax with Articles",
            image: "assets/reading.jpg",
            info: "Based on: Any Weather, Neutral Mood"),
      ];
    }

    // LAZY
    if (mood == "lazy") {
      return [
        Recommendation(
            title: "Cozy Escape",
            subtitle: "Warm Vibes & Relaxing Tunes",
            image: "cozy.jpg",
            info: "Based on: Any Weather, Lazy Mood"),
        Recommendation(
            title: "Peaceful Pause",
            subtitle: "Gentle Rhythms for a Calm Mind",
            image: "rest_grass.jpg",
            info: "Based on: Any Weather, Lazy Mood"),
        // Extra
        Recommendation(
            title: "Nap Time",
            subtitle: "Soft Background Ambience",
            image: "assets/nap.jpg",
            info: "Based on: Any Weather, Lazy Mood"),
        Recommendation(
            title: "Comfort Food",
            subtitle: "Snack & Relax",
            image: "assets/snacks.webp",
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
