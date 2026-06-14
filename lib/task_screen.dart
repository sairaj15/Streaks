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
            appBar: AppBar(title: Text(nameOfTheTask)),
            body: ListView.builder(
              itemCount: entry.learningDone.length,
              itemBuilder: (context, index) {
                final date = entry.learningDone[index];
                final formattedDate = '${date.day}/${date.month}/${date.year}';
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    leading: Icon(Icons.calendar_today, color: Colors.blue),
                    title: Text(
                      formattedDate,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('Completed'),
                  ),
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
