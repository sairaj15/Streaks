import 'package:flutter/material.dart';
import 'home_screen.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Learning Tracker', home: HomeScreen());
  }
}
