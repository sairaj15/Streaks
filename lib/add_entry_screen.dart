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
  String? _errorText;
  @override
  void initState() {
    super.initState();
    addEntryController.addListener(() {
      setState(() {
        _errorText = addEntryController.text.isEmpty
            ? 'Habit Name must not be empty'
            : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryBloc, EntryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Add Habit')),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40),
                Icon(Icons.auto_stories, size: 64, color: Colors.blue),
                SizedBox(height: 16),
                Text(
                  'Add a New Habit',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Track your daily learning journey',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                TextField(
                  controller: addEntryController,
                  decoration: InputDecoration(
                    hintText: 'Enter Habit Name',
                    errorText: _errorText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.track_changes),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final nameOfTheTask = addEntryController.text;
                    if (addEntryController.text.isNotEmpty) {
                      context.read<EntryBloc>().add(
                        EventAddHabit(nameOfTheTask: nameOfTheTask),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Add Habit',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    addEntryController.dispose();
    super.dispose();
  }
}
