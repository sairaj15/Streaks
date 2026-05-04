class EntryModel {
  EntryModel({required this.nameOfTheTask, this.learningDone = const []});

  Map<String, dynamic> toJson() {
    return {'nameOfTheTask': nameOfTheTask, 'learningDone': learningDone};
  }

  final String nameOfTheTask;
  final List<DateTime> learningDone;
}
