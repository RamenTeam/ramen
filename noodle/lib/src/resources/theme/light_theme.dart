import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: HexColor("FCBF30"),
    accentColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: HexColor("FCBF30"),
        unselectedItemColor: Colors.grey),
    appBarTheme: AppBarTheme(
        titleTextStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        headline2: TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
        headline3: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(
            color: Colors.black.withAlpha(150), fontWeight: FontWeight.w400)),
    secondaryHeaderColor: Colors.grey.shade50,
    buttonTheme: ButtonThemeData(),
    primaryIconTheme: IconThemeData(color: Colors.black45));
