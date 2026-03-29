import "package:flutter/material.dart";
import "package:tick_tock/core/constants/path.dart";
import "package:tick_tock/core/theme/theme.dart";
import "package:tick_tock/features/category/presentation/screens/category_settings_screen.dart";
import "package:tick_tock/presentation/screens/main_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "TickTock",
        theme: TAppTheme.lightTheme(),
        darkTheme: TAppTheme.darkTheme(),
        home: const MainScreen(),
        routes: {
          categorySettingPath: (final context) =>
              const CategorySettingsScreen(),
        },
      );
}
