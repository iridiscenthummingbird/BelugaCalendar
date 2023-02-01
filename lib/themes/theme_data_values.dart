import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeDataValues {
  ThemeData get defaultThemeData => ThemeData(
        fontFamily: 'NotoSans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 1,
          foregroundColor: Color(0xFFFF9D43),
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontFamily: 'NotoSans',
            fontWeight: FontWeight.w600,
            color: Color(0xFF494949),
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        disabledColor: const Color(0xffdbdbdb),
        secondaryHeaderColor: const Color.fromRGBO(73, 73, 73, 0.54),
        unselectedWidgetColor: const Color.fromRGBO(0, 0, 0, 0.54),
        toggleableActiveColor: const Color.fromARGB(255, 204, 223, 225),
        primaryColor: const Color(0xFFFF9D43),
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
          bodyColor: const Color(0xFF494949),
          displayColor: const Color(0xFF494949),
        ),
      );
}
