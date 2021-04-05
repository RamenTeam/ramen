import 'package:get_it/get_it.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';

class Locator {
  static GetIt _i;
  static GetIt get instance => _i;

  Locator.setup() {
    _i = GetIt.I;

    _i.registerSingleton<AuthenticationRepository>(
      AuthenticationRepository(),
    );
  }
}