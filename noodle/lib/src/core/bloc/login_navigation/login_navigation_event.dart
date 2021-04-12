// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class LoginNavigationEvent extends Equatable {
  const LoginNavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateToLogin extends LoginNavigationEvent{}
class NavigateToRegister extends LoginNavigationEvent{}
