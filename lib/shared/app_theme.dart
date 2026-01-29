import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: FColors.orange,
    appBarTheme: AppBarTheme(centerTitle: true, elevation: 0),
    textTheme: GoogleFonts.oswaldTextTheme(ThemeData.light().textTheme),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: FColors.blackSoft,
    textTheme: GoogleFonts.oswaldTextTheme(ThemeData.dark().textTheme),
  );
}
