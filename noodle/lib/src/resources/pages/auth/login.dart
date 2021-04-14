import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/auth/auth_bloc.dart';
import 'package:noodle/src/core/bloc/login/login_cubit.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_bloc.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_event.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/login_form.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

///@chungquantin
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(
          Provider.of<AuthenticationRepository>(context, listen: false)),
      child: LoginForm(),
    );


  }
}
