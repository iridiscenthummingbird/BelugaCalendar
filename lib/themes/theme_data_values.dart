import 'package:beluga_calendar/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeDataValues {
  ThemeData get defaultThemeData => ThemeData(
        fontFamily: GoogleFonts.rubik().fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          foregroundColor: const Color(0xFF1C1243),
          titleTextStyle: GoogleFonts.rubik(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1C1243),
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF643FDB),
        primaryColorDark: const Color(0xFF1C1243),
        primaryColorLight: const Color(0xffffffff),
        primaryTextTheme: TextTheme(
          titleLarge: GoogleFonts.rubik(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: GoogleFonts.rubik(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          displayLarge: GoogleFonts.rubik(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          displayMedium: TextStyle(
            fontFamily: Assets.fonts.sourceSansProRegular,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ).apply(
          bodyColor: const Color(0xFF1C1243),
          displayColor: const Color(0xFF1C1243),
        ),
      );
}
