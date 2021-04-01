import 'package:flutter/material.dart';

import 'package:noodle/app.dart';
import 'package:provider/provider.dart';
import 'package:noodle/src/resources/theme/theme.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppTheme(),
        )
      ],
      child: MyApp(),
    ),);
}
