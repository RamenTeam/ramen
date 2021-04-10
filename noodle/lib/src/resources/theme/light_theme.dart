import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: HexColor("FCBF30"),
    accentColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: HexColor("FCBF30"),
        unselectedItemColor: Colors.grey));
