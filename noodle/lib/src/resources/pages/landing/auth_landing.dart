import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/auth/auth_bloc.dart';
import 'package:noodle/src/core/bloc/auth/auth_event.dart';
import 'package:noodle/src/core/bloc/auth/auth_state.dart';
import 'package:noodle/src/core/models/authentication_status.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/resources/pages/auth/register.dart';
import 'package:noodle/src/resources/pages/auth/login.dart';
import 'package:noodle/src/resources/pages/navigation/home_navigation.dart';
import 'package:noodle/src/resources/pages/navigation/login_navigation.dart';
import 'package:noodle/src/resources/pages/navigation/tab_navigation_provider.dart';
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
