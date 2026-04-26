abstract class EntryEvent {}

class EventAddHabit extends EntryEvent {
  EventAddHabit({required this.nameOfTheTask});

  final String nameOfTheTask;
}

class EventMarkDone extends EntryEvent {
  EventMarkDone({required this.nameOfTheTask});

  final String nameOfTheTask;
}
