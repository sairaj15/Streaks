import 'package:daily_learning_tracker/bloc/entry_bloc.dart';
import 'package:daily_learning_tracker/bloc/entry_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreen extends StatelessWidget {
  final String nameOfTheTask;
  const TaskScreen({super.key, required this.nameOfTheTask});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryBloc, EntryState>(
      builder: (context, state) {
        if (state is StateShowEntries) {
          final entry = state.entries.firstWhere(
            (entry) => entry.nameOfTheTask == nameOfTheTask,
          );
          return Scaffold(
            appBar: AppBar(),
            body: ListView.builder(
              itemCount: entry.learningDone.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(entry.learningDone[index].toString()),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
