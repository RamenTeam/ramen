import 'package:bloc/bloc.dart';
import 'package:noodle/src/core/bloc/auth/auth_event.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';
import 'package:noodle/src/utils/locator.dart';

import 'auth_state.dart';

class BlocAuth extends Bloc<AuthEvent, AuthState> {
  BlocAuth(AuthState initialState) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is LoginEvent) {
        yield LoadingLoginState();

        await Locator.instance
            .get<AuthenticationRepository>()
            .logInWithEmailAndPassword(
                email: event.email, password: event.password);

        yield LogedState();
      } else if (event is LogoutEvent) {
        yield LoadingLogoutState();

        await Locator.instance.get<AuthenticationRepository>().logout();

        yield UnlogedState();
      } else if (event is SignUpEvent) {
        yield LoadingSignUpState();

        await Locator.instance.get<AuthenticationRepository>().register(
            username: event.username,
            password: event.password,
            confirmPassword: event.confirmPassword,
            email: event.email,
            phone: event.phone,
            firstName: event.firstName,
            lastName: event.lastName);

        yield LoadedSignUpState();
      }
    } catch (e) {
      yield LoginErrorState();
    }
  }
}
