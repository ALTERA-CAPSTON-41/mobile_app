// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kGreen1 = const Color(0xff1AC09C);
Color kGreen2 = const Color(0xffA6EBD9);
Color kGreey = const Color(0xffC5C5C5);
Color kBlack = Colors.black;
Color kwhite = Colors.white;

String admin = "ADMIN";
String docotor = "DOCTOR";
String nurse = "NURSE";

const double margin = 30.0;

final TextStyle kHeading5 = GoogleFonts.openSans(
  fontSize: 23,
  fontWeight: FontWeight.w400,
);

final TextStyle kHeading6 = GoogleFonts.openSans(
  fontSize: 19,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
  color: Colors.white,
);

final TextStyle kSubtitle = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.15,
  color: Colors.white,
);

final TextStyle kBodyText = GoogleFonts.openSans(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
  color: Colors.white,
);

final TextStyle kBodyText2 = GoogleFonts.openSans(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
  color: Colors.white,
);

Map<String, String>? headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

final kColorScheme = ColorScheme(
  primary: kGreen1,
  secondary: kGreen2,
  surface: kwhite,
  background: kwhite,
  error: Colors.red,
  onPrimary: kwhite,
  onSecondary: Colors.white,
  onSurface: Colors.black87,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.light,
);
