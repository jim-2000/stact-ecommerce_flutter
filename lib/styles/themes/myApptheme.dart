import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyappTheme {
  static ThemeData mytheme(bool isDark, BuildContext context) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF181818) : Colors.deepPurple,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFB82CF0),
      ),
      textTheme: isDark
          ? TextTheme(
              headline1: GoogleFonts.openSans(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
          : TextTheme(
              headline1: GoogleFonts.openSans(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
    );
  }
}
