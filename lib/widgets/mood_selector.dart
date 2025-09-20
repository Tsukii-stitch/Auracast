import 'package:flutter/material.dart';

/// A widget that allows the user to select their current mood.
/// 
/// Displays a horizontal list of moods with emojis, letting the user pick one.
/// The selected mood is highlighted, and a callback is triggered when a mood is chosen.
class MoodSelector extends StatelessWidget {
  // The currently selected mood (can be null if no mood is selected yet).
  final String? selectedMood;
  // Callback function to notify the parent widget when a mood is selected.
  final Function(String) onMoodSelected;

  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> moodEmojis = {
      "Content": "🙂",
      "Neutral": "😐",
      "Happy": "😊",
      "Melancholy": "😔",
      "Excited": "🤩",
      "Lazy": "🥱",
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        const Text("How are you feeling?", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        // Horizontal scrollable list of moods
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: moodEmojis.entries.map((entry) {
              final isSelected = selectedMood == entry.key;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => onMoodSelected(entry.key),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.all(isSelected ? 8 : 4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Emoji with zoom effect
                        AnimatedScale(
                          scale: isSelected ? 1.5 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          child: Text(
                            entry.value,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          entry.key,
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
