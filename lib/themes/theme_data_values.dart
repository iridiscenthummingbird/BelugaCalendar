import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeDataValues {
  ThemeData get defaultThemeData => ThemeData(
        fontFamily:
            GoogleFonts.rubik(color: const Color(0xFFFFFFFF)).fontFamily,
        // appBarTheme: AppBarTheme(
        //   backgroundColor: Colors.white,
        //   centerTitle: false,
        //   elevation: 1,
        //   foregroundColor: const Color(0xFFFF9D43),
        //   titleTextStyle: GoogleFonts.rubik(
        //     fontSize: 24,
        //     fontWeight: FontWeight.w600,
        //     color: const Color(0xFFFFFFFF),
        //   ),
        // ),
        scaffoldBackgroundColor: Colors.white,
        primaryTextTheme: TextTheme(
          titleLarge: GoogleFonts.rubik(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: GoogleFonts.rubik(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ).apply(
          bodyColor: const Color(0xFFFFFFFF),
          displayColor: const Color(0xFFFFFFFF),
        ),
      );
}
