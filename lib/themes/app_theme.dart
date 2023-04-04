import 'package:c317_mobile/themes/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: _textTheme,
);

ThemeData appThemeDark = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: _textTheme,
);

TextTheme _textTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(fontSize: 57, fontWeight: FontWeight.w600),
  displayMedium: GoogleFonts.poppins(fontSize: 45, fontWeight: FontWeight.w600),
  displaySmall: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w600),
  headlineLarge: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w600),
  headlineMedium: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w600),
  headlineSmall: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
  titleLarge: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
  titleMedium: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400),
  titleSmall: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w200),
  bodyLarge: GoogleFonts.poppins(fontSize: 18),
  bodyMedium: GoogleFonts.poppins(fontSize: 16),
  bodySmall: GoogleFonts.poppins(fontSize: 14),
);
