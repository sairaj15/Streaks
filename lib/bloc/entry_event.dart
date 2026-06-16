abstract class EntryEvent {}

class EventAddHabit extends EntryEvent {
  EventAddHabit({required this.nameOfTheTask});

  final String nameOfTheTask;
}

class EventMarkDone extends EntryEvent {
  EventMarkDone({required this.nameOfTheTask});

  final String nameOfTheTask;
}

class EventLoadEntries extends EntryEvent {}

class EventDeleteEntries extends EntryEvent {
  EventDeleteEntries({required this.nameOfTheTask});

  final String nameOfTheTask;
}
