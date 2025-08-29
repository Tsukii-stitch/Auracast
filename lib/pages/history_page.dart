import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  // Fetch history from SharedPreferences
  Future<List<String>> _getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("moodHistory") ?? [];
  }

  // Clear history
  Future<void> _clearHistory(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("moodHistory");
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("History cleared")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mood + Weather History"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _clearHistory(context),
          )
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: _getHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final history = snapshot.data!;
          if (history.isEmpty) {
            return const Center(child: Text("No history yet."));
          }

          return ListView.separated(
            itemCount: history.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final entry = history[index].split(" | ");
              return ListTile(
                leading: const Icon(Icons.mood),
                title: Text(entry.length > 1 ? entry[1] : "Unknown Mood"),
                subtitle: Text(
                  "${entry.length > 2 ? entry[2] : ''} - ${entry.length > 3 ? entry[3] : ''}",
                ),
              );
            },
          );
        },
      ),
    );
  }
}
