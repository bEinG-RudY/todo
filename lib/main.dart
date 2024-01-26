import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Screen/Task_Screen.dart';
import 'package:todo/viewmodel/task_viewmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskViewmodel(),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: TaskScreen()),
    );
  }
}
