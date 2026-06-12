import 'package:daily_learning_tracker/bloc/entry_bloc.dart';
import 'package:daily_learning_tracker/bloc/entry_event.dart';
import 'package:daily_learning_tracker/bloc/entry_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddEntryState();
}

class _AddEntryState extends State<StatefulWidget> {
  final TextEditingController addEntryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryBloc, EntryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              TextField(controller: addEntryController),
              InkWell(
                onTap: () {
                  final nameOfTheTask = addEntryController.text;
                  context.read<EntryBloc>().add(
                    EventAddHabit(nameOfTheTask: nameOfTheTask),
                  );
                },
                child: Text('Add Habit'),
              ),
            ],
          ),
        );
      },
    );
  }
}
