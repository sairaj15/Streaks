import 'package:dailylearningtracker/bloc/entry_bloc.dart';
import 'package:dailylearningtracker/bloc/entry_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_screen.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EntryBloc>(
      create: (context) => EntryBloc(),
      child: BlocBuilder<EntryBloc, EntryState>(
        builder: (context, state) {
          return MaterialApp(title: 'Learning Tracker', home: HomeScreen());
        },
      ),
    );
  }
}
