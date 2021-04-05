import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:noodle/app.dart';
import 'package:noodle/src/core/bloc/auth/auth_bloc.dart';
import 'package:noodle/src/core/bloc/auth/auth_state.dart';
import 'package:noodle/src/resources/theme/theme.dart';
import 'package:noodle/src/utils/locator.dart';
import 'package:provider/provider.dart' hide Locator;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Locator.setup();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<BlocAuth>(create: (BuildContext context) => BlocAuth(UnlogedState())),
    ],
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppTheme(),
        )
      ],
      child: MyApp(),
    ),
  ));
}
