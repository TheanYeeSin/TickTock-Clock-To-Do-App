import "package:flutter/material.dart";
import "package:ticktock/core/theme/custom_themes/app_bar_theme.dart";
import "package:ticktock/core/theme/custom_themes/color_scheme.dart";

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme() => ThemeData(
        useMaterial3: true,
        appBarTheme: TAppBarTheme.lightAppBarTheme(),
        colorScheme: TColorScheme.lightColorScheme(),
      );

  static ThemeData darkTheme() => ThemeData(
        useMaterial3: true,
        appBarTheme: TAppBarTheme.darkAppBarTheme(),
        colorScheme: TColorScheme.darkColorScheme(),
      );
}
