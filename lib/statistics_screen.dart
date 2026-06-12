import 'package:daily_learning_tracker/models/entry_model.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  final List<EntryModel> entries;

  const StatisticsScreen({required this.entries, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(entries[index].nameOfTheTask),
                  subtitle: Text(
                    'Current Streak:${entries[index].getCurrentStreak()}\nLongest Streak: ${entries[index].getLongestStreak()}\nDays Tracked: ${entries[index].learningDone.length}\nCompletion Rate: ${entries[index].getCompletionRate().toStringAsFixed(1)}%',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
