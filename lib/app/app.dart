import 'package:flutter/material.dart';
import 'package:sparkosol_task_manager/presentation/views/home_screen.dart';

class SparkosolTaskManager extends StatelessWidget {
  const SparkosolTaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sparkosol Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}