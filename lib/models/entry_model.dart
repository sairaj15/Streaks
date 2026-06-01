class EntryModel {
  EntryModel({required this.nameOfTheTask, this.learningDone = const []});

  Map<String, dynamic> toJson() {
    return {
      'nameOfTheTask': nameOfTheTask,
      'learningDone': learningDone
          .map((date) => date.toIso8601String())
          .toList(),
    };
  }

  factory EntryModel.fromJson(Map<String, dynamic> json) {
    return EntryModel(
      nameOfTheTask: json['nameOfTheTask'],
      learningDone: (json['learningDone'] as List)
          .map((date) => DateTime.parse(date))
          .toList(),
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

  final String nameOfTheTask;
  final List<DateTime> learningDone;
}
