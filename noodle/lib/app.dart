import 'package:flutter/services.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/auth/auth_bloc.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_bloc.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/landing/auth_landing.dart';
import 'package:flutter/material.dart';

// import 'package:noodle/src/resources/theme/theme.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:hexcolor/hexcolor.dart';
import 'package:noodle/src/resources/theme/theme.dart';
import 'package:provider/provider.dart';

class RamenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: "Ramen",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.of(context, listen: true).currentTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
              authenticationRepository:
                  Provider.of<AuthenticationRepository>(context, listen: false),
              userRepository:
                  Provider.of<UserRepository>(context, listen: false),
            ),
          ),
          BlocProvider<LoginNavigationBloc>(
            create: (_) => LoginNavigationBloc(),
          )
        ],
        child: AuthLanding(),
      ),
    );
  }
}
