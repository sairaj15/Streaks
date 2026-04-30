import 'package:dailylearningtracker/bloc/entry_bloc.dart';
import 'package:dailylearningtracker/bloc/entry_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EntryBloc(),
      child: BlocBuilder<EntryBloc, EntryState>(
        builder: (context, state) {
          if (state is StateShowEntries) {
            final entries = state.entries;
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
                  ListView.builder(
                    itemCount: state.entries.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.entries[index].nameOfTheTask),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
