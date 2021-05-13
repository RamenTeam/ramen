// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginNavigationCubit extends Cubit<LoginNavigationScreen> {
  LoginNavigationCubit() : super(LoginNavigationScreen.Login);

  void navigate(LoginNavigationScreen screen) {
    emit(screen);
  }
}

enum LoginNavigationScreen {
  Login,
  Register,
}
