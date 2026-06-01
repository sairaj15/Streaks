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

  bool isTodayMarked() {
    final today = DateTime.now();
    return learningDone.any(
      (date) =>
          today.year == date.year &&
          today.month == date.month &&
          today.day == date.day,
    );
  }

  int getCurrentStreak() {
    int streakCounter = 0;
    DateTime today = DateTime.now();
    learningDone.map((date) {
      while (!isTodayMarked()) {
        streakCounter++;
        today.subtract(Duration(days: 1));
      }
    });
    return streakCounter;
  }

  final String nameOfTheTask;
  final List<DateTime> learningDone;
}
