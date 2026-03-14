import 'package:flutter/material.dart';
import 'package:tick_tock/core/constants/path.dart';
import 'package:tick_tock/features/category/presentation/screens/category_settings_screen.dart';
import 'package:tick_tock/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TickTock",
      home: MainScreen(),
      routes: {
        CATEGORY_SETTINGS_PATH: (final context) =>
            const CategorySettingsScreen(),
      },
    );
  }
}
