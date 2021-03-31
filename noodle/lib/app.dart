import 'package:flutter/services.dart';
import 'package:noodle/src/resources/pages/auth_landing.dart';
import 'package:noodle/src/resources/pages/home_navigation.dart';
import 'package:noodle/src/resources/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:noodle/src/resources/theme/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: "Ramen",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.of(context, listen: true).currentTheme,
      initialRoute: "/auth-landing",
      routes: {
        "/": (_) => HomeNavigation(),
        "/login": (_) => LoginScreen(),
        "/auth-landing": (_) => AuthLanding()
      },
    );
  }
}
