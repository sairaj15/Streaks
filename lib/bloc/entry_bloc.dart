import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:daily_learning_tracker/bloc/entry_event.dart';
import 'package:daily_learning_tracker/bloc/entry_state.dart';
import 'package:daily_learning_tracker/models/entry_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  EntryBloc() : super(StateShowEntries(entries: [])) {
    on<EventAddHabit>(_onEventAddHabit);
    on<EventMarkDone>(_onEventMarkDone);
    on<EventLoadEntries>(_onEventLoadEntries);
  }

  void _onEventAddHabit(EventAddHabit event, emit) {
    final List<EntryModel> currentEntries = (state as StateShowEntries).entries;
    EntryModel newEntry = EntryModel(
      nameOfTheTask: event.nameOfTheTask,
      createdAt: DateTime.now(),
    );
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
          createdAt: entry.createdAt,
        );
      } else {
        return entry;
      }
    }).toList();
    emit(StateShowEntries(entries: updatedEntry));
    _setEntries(updatedEntry);
  }

  Future<void> _setEntries(List<EntryModel> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(
      entries.map((entry) => entry.toJson()).toList(),
    );
    await prefs.setString('entries', jsonString);
  }

  Future<void> _onEventLoadEntries(
    EventLoadEntries event,
    Emitter<EntryState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('entries');
    if (jsonString == null) return;
    final json = jsonDecode(jsonString);
    final entries = (json as List)
        .map((item) => EntryModel.fromJson(item))
        .toList();

    emit(StateShowEntries(entries: entries));
  }
}
