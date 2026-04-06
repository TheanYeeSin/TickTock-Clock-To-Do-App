import "package:flutter/material.dart";
import "package:ticktock/core/constants/path.dart";
import "package:ticktock/core/theme/theme.dart";
import "package:ticktock/features/category/presentation/screens/category_settings_screen.dart";
import "package:ticktock/presentation/screens/main_navigator_screen.dart";

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
        home: const MainNavigatorScreen(),
        routes: {
          categorySettingPath: (final context) =>
              const CategorySettingsScreen(),
        },
      );
}
