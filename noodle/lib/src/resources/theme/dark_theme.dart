import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
    primaryColor: HexColor("FCBF30"),
    accentColor: HexColor("090909"),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor("090909"),
        selectedItemColor: HexColor("FCBF30"),
        unselectedItemColor: Colors.grey),
    appBarTheme: AppBarTheme(
        titleTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        headline2: TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
        headline3: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(
            color: Colors.white.withAlpha(150), fontWeight: FontWeight.w400)),
    secondaryHeaderColor: HexColor("131313"),
    buttonTheme: ButtonThemeData(),
    primaryIconTheme: IconThemeData(color: HexColor("505050")));
