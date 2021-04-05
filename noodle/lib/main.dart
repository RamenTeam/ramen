import 'package:flutter/material.dart';

import 'package:noodle/app.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:noodle/src/resources/theme/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppTheme(),
        )
      ],
      child: RamenApp(
        authenticationRepository: AuthenticationRepository(),
        userRepository: UserRepository(),
      ),
    ),
  );
}
