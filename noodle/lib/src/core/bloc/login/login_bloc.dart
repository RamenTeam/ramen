import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/login/login_event.dart';
import 'package:noodle/src/core/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginError) {
      yield LoginState(errorMessage: event.errorMessage);
    }
  }
}
