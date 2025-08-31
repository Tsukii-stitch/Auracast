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
  // Define available moods with corresponding emojis.
  Widget build(BuildContext context) {
    final Map<String, String> moodEmojis = {
      "Content": "🙂",
      "Neutral": "😐",
      "Happy": "😊",
      "Melancholy": "😔",
      "Excited": "🤩",
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        const Text("How are you feeling?", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        // Horizontal scrollable list of moods as ChoiceChips
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: moodEmojis.entries.map((entry) {
              // Check if the current mood is selected
              final isSelected = selectedMood == entry.key;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  // Display the mood label (e.g., "Happy") with its emoji
                  label: Text(entry.key),
                  avatar: Text(entry.value),
                  // Highlight if selected
                  selected: isSelected,
                  selectedColor: Colors.blue.shade100,
                  // Change label color depending on selection
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey[700],
                  ),
                  // When a mood is tapped, call the parent callback
                  onSelected: (_) => onMoodSelected(entry.key),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
