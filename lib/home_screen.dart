import 'package:daily_learning_tracker/bloc/entry_bloc.dart';
import 'package:daily_learning_tracker/bloc/entry_event.dart';
import 'package:daily_learning_tracker/bloc/entry_state.dart';
import 'package:daily_learning_tracker/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_learning_tracker/add_entry_screen.dart';
import 'package:daily_learning_tracker/statistics_screen.dart';

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
              title: Text('Streaks', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue,
              actions: [
                IconButton(
                  icon: Icon(Icons.bar_chart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StatisticsScreen(entries: state.entries),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: state.entries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.track_changes,
                          size: 80,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No habits yet',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tap + to add your first habit',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsGeometry.all(20),
                          child: ListView.builder(
                            itemCount: state.entries.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskScreen(
                                      nameOfTheTask:
                                          state.entries[index].nameOfTheTask,
                                    ),
                                  ),
                                ),
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Delete Habit'),
                                      content: Text(
                                        'Do you want to delete the habit?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.read<EntryBloc>().add(
                                              EventDeleteEntries(
                                                nameOfTheTask: state
                                                    .entries[index]
                                                    .nameOfTheTask,
                                              ),
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsetsGeometry.fromLTRB(
                                      20,
                                      20,
                                      20,
                                      20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.entries[index].nameOfTheTask,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                        ),
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.local_fire_department,
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                  ),
                                                  Text(
                                                    '${state.entries[index].getCurrentStreak()} ${state.entries[index].getCurrentStreak() == 1 ? 'day' : 'days'}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              InkWell(
                                                focusColor: Colors.blue,
                                                splashColor: Colors.blue,
                                                onTap:
                                                    state.entries[index]
                                                        .isTodayMarked()
                                                    ? null
                                                    : () {
                                                        context.read<EntryBloc>().add(
                                                          EventMarkDone(
                                                            nameOfTheTask: state
                                                                .entries[index]
                                                                .nameOfTheTask,
                                                          ),
                                                        );
                                                      },
                                                child: Text(
                                                  state.entries[index]
                                                          .isTodayMarked()
                                                      ? '✓'
                                                      : 'Mark Done',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    color:
                                                        state.entries[index]
                                                            .isTodayMarked()
                                                        ? Colors.grey
                                                        : Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
              child: Icon(Icons.add),
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
