import 'package:flutter/material.dart';
import 'package:taskmanager/core/theme/constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: kWhite,

    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      surface: kWhite,
      error: kRed,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: kWhite,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: kBlack,
      ),
      titleTextStyle: TextStyle(
        color: kBlack,
        fontSize: 20,
        fontWeight: kFW700,
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30,
        fontWeight: kFW700,
        color: kBlack,
      ),

      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: kFW600,
        color: kBlack,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: kFW500,
        color: kDarkGray,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: kFW400,
        color: kLightGray,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhite,
        minimumSize: const Size(
          double.infinity,
          55,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: kFW600,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kWhite,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: kBorderColor,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: kBorderColor,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: kThirdColor,
          width: 1.5,
        ),
      ),
    ),

   
  );
}



/// BRAND COLORS
const Color kPrimaryColor = Color(0xff050B2C);
const Color kSecondaryColor = Color(0xff24558F);
const Color kThirdColor = Color(0xff3986E2);

/// BASIC COLORS
const Color kBlack = Color(0xff000000);
const Color kWhite = Color(0xffffffff);

/// GRAY COLORS
const Color kDarkGray = Color(0xff4B5563);
const Color kLightGray = Color(0xff9CA3AF);
const Color kBorderColor = Color(0xffE5E7EB);

/// STATUS COLORS
const Color kRed = Color(0xffEF4444);
const Color kYellow = Color(0xffFACC15);
const Color kOrange = Color(0xffF97316);