import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_bloc.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_state.dart';
import 'package:noodle/src/resources/pages/auth/register.dart';
import 'package:noodle/src/resources/pages/auth/login.dart';

class LoginNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginNavigationBloc, LoginNavigationState>(
      builder: (context, state) {
        switch (state.currentScreen) {
          case LoginNavigationScreen.Login:
            return LoginScreen();
          case LoginNavigationScreen.Register:
            return RegisterScreen();
          default:
            return Container();
        }
      },
    );
  }
}