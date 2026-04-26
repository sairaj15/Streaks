class EntryModel {
  EntryModel({required this.nameOfTheTask, this.learningDone = const []});

  final String nameOfTheTask;
  final List<DateTime> learningDone;
}
