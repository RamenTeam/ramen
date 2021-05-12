import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/resources/pages/home_navigation//home_navigation.dart';
import 'package:noodle/src/resources/pages/login_navigation/login_navigation.dart';
import 'package:noodle/src/resources/pages/profile/bloc/user_cubit.dart';

class AuthLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, User?>(
      builder: (context, state) {
        if (state == null) return LoginNavigation();
        return HomeNavigation();
      },
    );
  }
}
