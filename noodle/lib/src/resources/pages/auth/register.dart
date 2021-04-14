import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/register/register_cubit.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/register_form.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(
          Provider.of<AuthenticationRepository>(context, listen: false)),
      child: RegisterForm(),
    );
  }
}
