import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<List<String>> _getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("moodHistory") ?? [];
  }

  Future<void> _deleteEntry(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList("moodHistory") ?? [];
    if (index >= 0 && index < history.length) {
      history.removeAt(index);
      await prefs.setStringList("moodHistory", history);
      setState(() {}); // refresh UI
    }
  }

  Future<void> _deleteAllEntries() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("moodHistory");
    setState(() {});
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Entry"),
        content: const Text("Are you sure you want to delete this entry?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _deleteEntry(index);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAll() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete All"),
        content: const Text("Are you sure you want to delete all history?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _deleteAllEntries();
            },
            child: const Text("Delete All", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _getHistory(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final history = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Mood + Weather History"),
            actions: [
              if (history.isNotEmpty) // ✅ only show if history exists
                IconButton(
                  icon: const Icon(Icons.delete_forever, color: Colors.red),
                  onPressed: _confirmDeleteAll,
                ),
            ],
          ),
          body: Container(
            color: Colors.white, // plain white background
            child: history.isEmpty
                ? const Center(child: Text("No history yet."))
                : ListView.separated(
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
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(index),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
