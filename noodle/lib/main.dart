import 'package:flutter/material.dart';

import 'package:noodle/screens/home.dart';
import 'package:noodle/screens/loading.dart';
import 'package:noodle/screens/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading(),
    );
  }
}
