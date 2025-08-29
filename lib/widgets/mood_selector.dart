import 'package:flutter/material.dart';

class MoodSelector extends StatelessWidget {
  final String? selectedMood;
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
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("How are you feeling?", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: moodEmojis.entries.map((entry) {
              final isSelected = selectedMood == entry.key;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(entry.key),
                  avatar: Text(entry.value),
                  selected: isSelected,
                  selectedColor: Colors.blue.shade100,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey[700],
                  ),
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
