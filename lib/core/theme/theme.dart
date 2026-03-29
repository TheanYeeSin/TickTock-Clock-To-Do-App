import "package:flutter/material.dart";
import "package:tick_tock/core/theme/custom_themes/app_bar_theme.dart";

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme() => ThemeData(
        useMaterial3: true,
        appBarTheme: TAppBarTheme.lightAppBarTheme(),
      );

  static ThemeData darkTheme() => ThemeData(
        useMaterial3: true,
        appBarTheme: TAppBarTheme.darkAppBarTheme(),
      );
}
