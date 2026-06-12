import 'package:dailylearningtracker/bloc/entry_bloc.dart';
import 'package:dailylearningtracker/bloc/entry_event.dart';
import 'package:dailylearningtracker/bloc/entry_state.dart';
import 'package:dailylearningtracker/statistics_screen.dart';
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
              backgroundColor: Colors.blue,
              //actions: [StatisticsScreen(state.entries)],
            ),
            body: state.entries.isEmpty
                ? Center(child: Text('No data entries available'))
                : Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsGeometry.all(20),
                          child: ListView.builder(
                            itemCount: state.entries.length,
                            itemBuilder: (context, index) {
                              return Card(
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
                                                  '${state.entries[index].getCurrentStreak()} days',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            InkWell(
                                              focusColor: Colors.blue,
                                              splashColor: Colors.blue,
                                              onTap: () {
                                                state.entries[index]
                                                        .isTodayMarked()
                                                    ? null
                                                    : context.read<EntryBloc>().add(
                                                        EventMarkDone(
                                                          nameOfTheTask: state
                                                              .entries[index]
                                                              .nameOfTheTask,
                                                        ),
                                                      );
                                              },
                                              child: Text(
                                                'Mark Done',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              /* ListTile(
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
                                  onPressed:
                                      state.entries[index].isTodayMarked()
                                      ? null
                                      : () => context.read<EntryBloc>().add(
                                          EventMarkDone(
                                            nameOfTheTask: state
                                                .entries[index]
                                                .nameOfTheTask,
                                          ),
                                        ),
                                ),
                              ); */
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
