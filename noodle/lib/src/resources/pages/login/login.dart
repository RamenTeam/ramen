import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/login/bloc/login_cubit.dart';
import 'package:noodle/src/resources/pages/login/login_form.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

///@chungquantin
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(
          userRepository: Provider.of<UserRepository>(context, listen: false)),
      child: LoginForm(),
    );
  }
}
