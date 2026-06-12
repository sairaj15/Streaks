import 'dart:math';

class EntryModel {
  EntryModel({
    required this.nameOfTheTask,
    this.learningDone = const [],
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'nameOfTheTask': nameOfTheTask,
      'learningDone': learningDone
          .map((date) => date.toIso8601String())
          .toList(),
      'createdAt': createdAt,
    };
  }

  factory EntryModel.fromJson(Map<String, dynamic> json) {
    return EntryModel(
      nameOfTheTask: json['nameOfTheTask'],
      learningDone: (json['learningDone'] as List)
          .map((date) => DateTime.parse(date))
          .toList(),
      createdAt: json['createdAt'],
    );
  }

  bool isTodayMarked() {
    final today = DateTime.now();
    return learningDone.any(
      (date) =>
          today.year == date.year &&
          today.month == date.month &&
          today.day == date.day,
    );
  }

  bool _isDayMarked(DateTime checkDate) {
    return learningDone.any(
      (date) =>
          date.year == checkDate.year &&
          date.month == checkDate.month &&
          date.day == checkDate.day,
    );
  }

  int getCurrentStreak() {
    int streakCounter = 0;
    DateTime day = DateTime.now();
    while (_isDayMarked(day)) {
      streakCounter++;
      day = day.subtract(Duration(days: 1));
    }

    return streakCounter;
  }

  int getLongestStreak() {
    int streakCounter = 0;
    int longestStreakCounter = 0;
    final sortedArray = [...learningDone]..sort((a, b) => a.compareTo(b));
    for (int i = 0; i < sortedArray.length; i++) {
      streakCounter++;
      if (i + 1 < sortedArray.length) {
        int difference = sortedArray[i + 1].difference(sortedArray[i]).inDays;
        if (difference != 1) {
          longestStreakCounter = max(longestStreakCounter, streakCounter);
          streakCounter = 0;
        }
      }
    }
    return max(longestStreakCounter, streakCounter);
  }

  double getCompletionRate() {
    int totalDaysSinceHabitCreated =
        DateTime.now().difference(createdAt).inDays + 1;
    return (learningDone.length / totalDaysSinceHabitCreated) * 100;
  }

  final String nameOfTheTask;
  final List<DateTime> learningDone;
  final DateTime createdAt;
}
