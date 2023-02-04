import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeDataValues {
  ThemeData get defaultThemeData => ThemeData(
        // fontFamily: GoogleFonts.rubik().fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          foregroundColor: const Color(0xFF1C1243),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontFamily: GoogleFonts.rubik().fontFamily,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1C1243),
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF643FDB),
        primaryColorDark: const Color(0xFF1C1243),
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
          titleSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          displayMedium: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          labelMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w300,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ).apply(
          bodyColor: const Color(0xFF1C1243),
          displayColor: const Color(0xFF1C1243),
        ),
      );
}
