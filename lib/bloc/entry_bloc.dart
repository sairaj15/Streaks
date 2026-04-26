import 'package:bloc/bloc.dart';
import 'package:dailylearningtracker/bloc/entry_event.dart';
import 'package:dailylearningtracker/bloc/entry_state.dart';
import 'package:dailylearningtracker/models/entry_model.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  EntryBloc() : super(StateShowEntries(entries: [])) {
    on<EventAddHabit>((event, emit) {
      final List<EntryModel> currentEntries =
          (state as StateShowEntries).entries;
      EntryModel newEntry = EntryModel(nameOfTheTask: event.nameOfTheTask);
      final updatedEntries = [...currentEntries, newEntry];
      emit(StateShowEntries(entries: updatedEntries));
    });
    on<EventMarkDone>((event, emit) {});
  }
}
