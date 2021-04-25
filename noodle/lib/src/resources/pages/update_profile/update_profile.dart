import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/resources/pages/register/bloc/register_cubit.dart';
import 'package:noodle/src/resources/pages/update_profile/bloc/update_profile_cubit.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/register/register_form.dart';
import 'package:noodle/src/resources/pages/profile/local_build/update_profile_form.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({required this.userRepository, required this.user}) : super();
  final UserRepository userRepository;
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdateProfileCubit(userRepository),
      child: UpdateProfileForm(user: user),
    );
  }
}
