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

  final String nameOfTheTask;
  final List<DateTime> learningDone;
}
