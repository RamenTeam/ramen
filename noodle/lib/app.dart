import 'package:flutter/services.dart';
import 'package:noodle/src/resources/pages/landing/auth_landing.dart';
import 'package:noodle/src/resources/pages/navigation/home_navigation.dart';
import 'package:noodle/src/resources/pages/login/login.dart';
import 'package:flutter/material.dart';
// import 'package:noodle/src/resources/theme/theme.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:noodle/src/resources/pages/register/register.dart';
import 'package:noodle/src/constants/app_route.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: "Ramen",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: HexColor("FCBF30"), accentColor: Colors.white),
      home: RegisterScreen(),
    );
  }
}
