import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';

ThemeData darkMode = ThemeData(
  scaffoldBackgroundColor: const Color(0xff242527),
  canvasColor: Colors.black,
  cardColor: Colors.black,
  fontFamily: GoogleFonts.lato().fontFamily,

  // default Color for Whole the App
  primarySwatch: defaultColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: Color(0xff242527),
      elevation: 0,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white)),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

  iconTheme: const IconThemeData(color: Colors.white),
);

ThemeData lightMode = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: backgroundColor,
  canvasColor: Colors.grey[300],
  cardColor: Color(0xFFE5BA73),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  fontFamily: GoogleFonts.lato().fontFamily,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      foregroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.black)),
);
