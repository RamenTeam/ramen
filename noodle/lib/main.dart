import 'package:flutter/material.dart';
import 'package:noodle/src/resources/pages/auth_landing.dart';
import 'package:noodle/src/resources/pages/home_navigation.dart';
import 'package:noodle/src/resources/pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthLanding(
        redirectedPage: Login(),
      ),
    );
  }
}
