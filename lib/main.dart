import 'package:flutter/material.dart';
import 'screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoalHub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Colors.greenAccent),
      ),
      home: MyHomePage(),
    );
  }
}