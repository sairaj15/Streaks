import 'package:dailylearningtracker/models/entry_model.dart';

abstract class EntryState {}

class StateShowEntries extends EntryState {
  StateShowEntries({required this.entries});

  final List<EntryModel> entries;
}
