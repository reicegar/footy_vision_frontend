import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static TextTheme _buildTextTheme(TextTheme base) {
    return GoogleFonts.oswaldTextTheme(base).copyWith(
      // DISPLAY: Large, short important text (e.g., Scoreboard numbers)
      displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold, letterSpacing: -0.25),
      displayMedium: GoogleFonts.oswald(fontSize: 45, fontWeight: FontWeight.bold),
      displaySmall: GoogleFonts.oswald(fontSize: 36, fontWeight: FontWeight.normal),

      // HEADLINE: High-emphasis text (e.g., Screen headers)
      headlineLarge: GoogleFonts.oswald(fontSize: 32, fontWeight: FontWeight.w700),
      headlineMedium: GoogleFonts.oswald(fontSize: 28, fontWeight: FontWeight.w600),
      headlineSmall: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.w500),

      // TITLE: Medium-emphasis text (e.g., Card titles, Modal headers)
      titleLarge: GoogleFonts.oswald(fontSize: 22, fontWeight: FontWeight.w500),
      titleMedium: GoogleFonts.oswald(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleSmall: GoogleFonts.oswald(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),

      // BODY: Longer passages of text (e.g., Article content, Descriptions)
      bodyLarge: GoogleFonts.oswald(fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.5),
      bodyMedium: GoogleFonts.oswald(fontSize: 14, fontWeight: FontWeight.normal, letterSpacing: 0.25),
      bodySmall: GoogleFonts.oswald(fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.4),

      // LABEL: Smallest text (e.g., Button text, Tags, Form hints)
      labelLarge: GoogleFonts.oswald(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1),
      labelMedium: GoogleFonts.oswald(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      labelSmall: GoogleFonts.oswald(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5),
    );
  }

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: FColors.orange,
    appBarTheme: AppBarTheme(centerTitle: true, elevation: 0),
    textTheme: _buildTextTheme(ThemeData.light().textTheme),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: FColors.blackSoft,
    textTheme: _buildTextTheme(ThemeData.dark().textTheme),
  );
}
