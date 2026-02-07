import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/shared/app_theme_controller.dart';
import 'package:footy_vision_frontend/shared/constants.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Check current brightness to show the correct icon
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: isDark ? FColors.orange : Colors.white),
      onPressed: () {
        AppThemeController.toggleTheme();
      },
      tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
    );
  }
}
