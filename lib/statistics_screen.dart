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
                final entry = entries[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            //color: Colors.blue,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: Text(
                            entry.nameOfTheTask,
                            style: TextStyle(
                              //color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _statItem(
                                'Current Streak',
                                '${entry.getCurrentStreak()} days',
                              ),
                            ),
                            Expanded(
                              child: _statItem(
                                'Longest Streak',
                                '${entry.getLongestStreak()} days',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _statItem(
                                'Days Tracked',
                                '${entry.learningDone.length}',
                              ),
                            ),
                            Expanded(
                              child: _statItem(
                                'Completion Rate',
                                '${entry.getCompletionRate().toStringAsFixed(1)}%',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
