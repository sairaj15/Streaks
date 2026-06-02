import 'package:dailylearningtracker/bloc/entry_bloc.dart';
import 'package:dailylearningtracker/bloc/entry_event.dart';
import 'package:dailylearningtracker/bloc/entry_state.dart';
import 'package:dailylearningtracker/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dailylearningtracker/add_entry_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryBloc, EntryState>(
      builder: (context, state) {
        if (state is StateShowEntries) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Daily Learning Tracker',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: ListView.builder(
                      itemCount: state.entries.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.entries[index].nameOfTheTask),
                          subtitle: Text(
                            '${state.entries[index].getCurrentStreak()}days',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskScreen(
                                  nameOfTheTask:
                                      state.entries[index].nameOfTheTask,
                                ),
                              ),
                            );
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.check_sharp),
                            onPressed: state.entries[index].isTodayMarked()
                                ? null
                                : () => context.read<EntryBloc>().add(
                                    EventMarkDone(
                                      nameOfTheTask:
                                          state.entries[index].nameOfTheTask,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Text('Add Entry'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEntryScreen()),
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
