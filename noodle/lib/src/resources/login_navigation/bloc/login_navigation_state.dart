// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

class LoginNavigationState extends Equatable {
  const LoginNavigationState._(
      {this.currentScreen = LoginNavigationScreen.Login});

  final LoginNavigationScreen currentScreen;

  const LoginNavigationState.login()
      : this._(currentScreen: LoginNavigationScreen.Login);

  const LoginNavigationState.register()
      : this._(currentScreen: LoginNavigationScreen.Register);

  @override
  // TODO: implement props
  List<Object> get props => [currentScreen];
}

enum LoginNavigationScreen {
  Login,
  Register,
}
