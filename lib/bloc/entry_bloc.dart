import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dailylearningtracker/bloc/entry_event.dart';
import 'package:dailylearningtracker/bloc/entry_state.dart';
import 'package:dailylearningtracker/models/entry_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  EntryBloc() : super(StateShowEntries(entries: [])) {
    on<EventAddHabit>(_onEventAddHabit);
    on<EventMarkDone>(_onEventMarkDone);
  }

  void _onEventAddHabit(EventAddHabit event, emit) {
    final List<EntryModel> currentEntries = (state as StateShowEntries).entries;
    EntryModel newEntry = EntryModel(nameOfTheTask: event.nameOfTheTask);
    final updatedEntries = [...currentEntries, newEntry];
    emit(StateShowEntries(entries: updatedEntries));
    _setEntries(updatedEntries);
  }

  void _onEventMarkDone(EventMarkDone event, emit) {
    final List<EntryModel> currentEntries = (state as StateShowEntries).entries;
    final DateTime learningDone = DateTime.now();
    final List<EntryModel> updatedEntry = currentEntries.map((entry) {
      if (entry.nameOfTheTask == event.nameOfTheTask) {
        return EntryModel(
          nameOfTheTask: entry.nameOfTheTask,
          learningDone: [...entry.learningDone, learningDone],
        );
      } else {
        return entry;
      }
    }).toList();
    emit(StateShowEntries(entries: updatedEntry));
  }

  Future<void> _setEntries(List<EntryModel> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(
      entries.map((entry) => entry.toJson()).toList(),
    );
    await prefs.setString('entries', jsonString);
  }
}
