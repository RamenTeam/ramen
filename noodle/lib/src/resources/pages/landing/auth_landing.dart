import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/auth/auth_bloc.dart';
import 'package:noodle/src/core/bloc/auth/auth_event.dart';
import 'package:noodle/src/core/bloc/auth/auth_state.dart';
import 'package:noodle/src/core/models/authentication_status.dart';
import 'package:noodle/src/resources/pages/auth/register.dart';
import 'package:noodle/src/resources/pages/auth/login.dart';
import 'package:noodle/src/resources/pages/navigation/home_navigation.dart';
import 'package:noodle/src/resources/pages/splash/splash.dart';

class AuthLanding extends StatefulWidget {
  AuthLanding({Key? key}) : super(key: key);

  @override
  _AuthLandingState createState() => _AuthLandingState();
}

class _AuthLandingState extends State<AuthLanding> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(AuthenticationStatusChanged(AuthenticationStatus.UNKNOWN));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.AUTHENTICATED:
                  Navigator.pushReplacement(context, HomeNavigation.route());
                  break;
                case AuthenticationStatus.UNAUTHENTICATED:
                  Navigator.pushReplacement(context, LoginScreen.route());
                  break;
                default:
                  break;
              }
            },
            child: child);
      },
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
