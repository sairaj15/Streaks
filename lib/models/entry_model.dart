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

  final String nameOfTheTask;
  final List<DateTime> learningDone;
}
