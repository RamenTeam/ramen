// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/resources/login_navigation/bloc/login_navigation_event.dart';
import 'package:noodle/src/resources/login_navigation/bloc/login_navigation_state.dart';

class LoginNavigationBloc
    extends Bloc<LoginNavigationEvent, LoginNavigationState> {
  LoginNavigationBloc() : super(LoginNavigationState.login());

  @override
  Stream<LoginNavigationState> mapEventToState(
      LoginNavigationEvent event) async* {
    if (event is NavigateToLogin) {
      yield LoginNavigationState.login();
    } else if (event is NavigateToRegister) {
      yield LoginNavigationState.register();
    }
  }
}
