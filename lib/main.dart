import 'package:flutter/material.dart';

import '/core/di/data_di.dart';
import '/features/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dataDI.initDependencies();

  runApp(const TasksOrganizer());
}

class TasksOrganizer extends StatelessWidget {
  const TasksOrganizer({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks Organizer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
