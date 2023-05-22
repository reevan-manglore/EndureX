import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData myTheme = ThemeData(
  // Use Material Design 3
  useMaterial3: true,

  // Use Dark Theme
  brightness: Brightness.dark,

  // Color Scheme Seed
  // colorSchemeSeed: const Color(0xFF01FFD0),

  // Font Family
  fontFamily: GoogleFonts.teko().fontFamily,

  // Scaffold Background Color
  scaffoldBackgroundColor: const Color(0xFF0A0320),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1F1025),
    unselectedItemColor: Color(0xFF01FFD0),
    unselectedIconTheme: IconThemeData(color: Color(0xFF01FFD0)),
    selectedItemColor: Color(0xFF8CFF00),
    selectedIconTheme: IconThemeData(
      color: Color(0xFF8CFF00),
    ),
  ),

  // Primary Color
  primaryColor: const Color(0xFF6200EE),

  // Color Scheme
  colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color(0xFF6200EE),
      secondary: const Color(0xFF03DAC6),
      brightness: Brightness.dark),

  // Text Theme
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontSize: 96.0,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.teko().fontFamily,
        color: const Color(0xFFFFFFFF)), // High Contrast Color
    displayMedium: TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.teko().fontFamily,
        color: const Color(0xFFFFFFFF)), // High Contrast Color
    displaySmall: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.teko().fontFamily,
        color: const Color(0xFFFFFFFF)), // High Contrast Color
    headlineMedium: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.teko().fontFamily,
        color: const Color(0xFFFFFFFF)), // High Contrast Color
    headlineSmall: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF)), // High Contrast Color
    titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.teko().fontFamily,
        color: const Color(0xFFFFFFFF)), // High Contrast Color
    titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.teko().fontFamily,
        color: const Color(0xFFFFFFFF)), // High Contrast Color
    titleSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.teko().fontFamily,
        color: const Color(0xFFFFFFFF)), // High Contrast Color
    bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        fontFamily: GoogleFonts.teko().fontFamily,
        color: const Color(0xFFD9D9D9)), // Surface Color
    bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        fontFamily: GoogleFonts.teko().fontFamily,
        color: const Color(0xFFD9D9D9)), // Surface Color
    labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.teko().fontFamily,
        color: const Color(0xFF6200EE)), // Primary Color
  ),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)))),

      backgroundColor:
          MaterialStateProperty.all(const Color(0xFF6200EE)), // Primary Color

      foregroundColor: MaterialStateProperty.all(
          const Color(0xFFFFFFFF)), // High Contrast Color

      overlayColor: MaterialStateProperty.all(
          const Color(0x29000000)), // High Contrast Color with 16% Opacity
    ),
  ),

  // Outlined Button Theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)))),
      backgroundColor:
          MaterialStateProperty.all(const Color(0x00000000)), // Transparent

      foregroundColor:
          MaterialStateProperty.all(const Color(0xFF6200EE)), // Primary Color

      overlayColor: MaterialStateProperty.all(
          const Color(0x29000000)), // High Contrast Color with 16% Opacity
    ),
  ),
// Text Button Theme
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)))),
      backgroundColor:
          MaterialStateProperty.all(const Color(0x00000000)), // Transparent

      foregroundColor:
          MaterialStateProperty.all(const Color(0xFF6200EE)), // Primary Color

      overlayColor: MaterialStateProperty.all(
          const Color(0x29000000)), // High Contrast Color with 16% Opacity
    ),
  ),
// Dialog Theme
  dialogTheme: const DialogTheme(
    // backgroundColor: ,
    elevation: 24.0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
    titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF)), // High Contrast Color
    contentTextStyle: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Color(0xFFFFFFFF),
    ), // High Contrast Color
  ),

// Card Theme
  cardTheme: const CardTheme(
    color: Color(0xFF1F1025),
    elevation: 4.0,
    margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
  ),

// App Bar Theme
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    backgroundColor: Color(0xFF0A0320),
    foregroundColor: Color(0xFFFFFFFF), // High Contrast Color
    iconTheme: IconThemeData(color: Color(0xFFFFFFFF)), // High Contrast Color
    titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF)), // High Contrast Color
    centerTitle: true,
  ),
);
