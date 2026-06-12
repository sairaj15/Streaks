import 'package:dailylearningtracker/models/entry_model.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  final List<EntryModel> entries;

  const StatisticsScreen({required this.entries, super.key});

  int totalHabits() {
    return entries.length;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
