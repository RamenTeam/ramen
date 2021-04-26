import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/models/authentication_status.dart';
import 'package:noodle/src/resources/login_navigation/login_navigation.dart';
import 'package:noodle/src/resources/pages/auth/bloc/auth_bloc.dart';
import 'package:noodle/src/resources/pages/auth/bloc/auth_state.dart';
import 'package:noodle/src/resources/pages/home_navigation//home_navigation.dart';
import 'package:noodle/src/resources/pages/splash/splash.dart';

class AuthLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.AUTHENTICATED:
            return HomeNavigation();
          case AuthenticationStatus.UNAUTHENTICATED:
            return LoginNavigation();
          default:
            return SplashScreen();
        }
      },
    );
  }
}
