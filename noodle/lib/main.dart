import 'package:flutter/material.dart';

import 'package:noodle/screens/home.dart';
import 'package:noodle/screens/loading.dart';
import 'package:noodle/screens/profile.dart';

import 'constants/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.loading,
      routes: {
        Routes.loading: (context) => Loading(),
        Routes.home: (context) => Home(),
        Routes.profile: (context) => Profile(),
      },
    );
  }
}
