import 'package:flutter/material.dart';

class AppThemeController {
  // A ValueNotifier that holds the current ThemeMode
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);

  // A simple function to toggle it
  static void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
