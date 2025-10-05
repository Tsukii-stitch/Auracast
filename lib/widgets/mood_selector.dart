import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that allows the user to select their current mood.
/// 
/// Displays a horizontal list of moods with emojis, letting the user pick one.
/// The selected mood is highlighted, and a callback is triggered when a mood is chosen.
class MoodSelector extends StatefulWidget {
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
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_isScrolling) {
      setState(() => _isScrolling = true);
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted && !_scrollController.position.isScrollingNotifier.value) {
        setState(() => _isScrolling = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
          height: 60,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                HapticFeedback.selectionClick();
              }
              return true;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                boxShadow: _isScrolling
                    ? [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
              ),
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: moodEmojis.entries.map((entry) {
                  final isSelected = widget.selectedMood == entry.key;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        widget.onMoodSelected(entry.key);
                        HapticFeedback.mediumImpact();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.all(isSelected ? 8 : 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.shade100
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.blue.shade200,
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
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
                                color: isSelected
                                    ? Colors.black
                                    : Colors.grey[700],
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
          ),
        ),
      ],
    );
  }
}
