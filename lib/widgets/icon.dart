import 'package:flutter/material.dart';
import '../pages/history_page.dart';

class TopRightIcon extends StatelessWidget {
  const TopRightIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HistoryPage()),
        );
      },
      icon: const Icon(Icons.history),  // <-- built-in material icon here
      tooltip: 'View History',
    );
  }
}
