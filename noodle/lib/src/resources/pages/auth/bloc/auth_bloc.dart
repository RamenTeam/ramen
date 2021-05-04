import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/models/authentication_status.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/auth/bloc/auth_event.dart';
import 'package:noodle/src/resources/pages/auth/bloc/auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })   : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState?> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      print("StatusChanged");
      AuthenticationState state =
          await _mapAuthenticationStatusChangedToState(event);
      print(state.props);
      yield state;
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    print(event.status);
    switch (event.status) {
      case AuthenticationStatus.UNAUTHENTICATED:
        return AuthenticationState.unauthenticated();
      case AuthenticationStatus.AUTHENTICATED:
        final user = await _tryGetUser();
        return user != null
            ? AuthenticationState.authenticated(user)
            : AuthenticationState.unauthenticated();
      case AuthenticationStatus.FETCHING_CURRENT_USER:
        final user = await _tryGetUser();
        return user != null
            ? AuthenticationState.authenticated(user)
            : AuthenticationState.unauthenticated();
      case AuthenticationStatus.LOGOUT_REQUESTED:
        final res = await _logout();
        return res == null
            ? AuthenticationState.unauthenticated()
            : AuthenticationState.unknown();
      default:
        return const AuthenticationState.unknown();
    }
  }

  FutureOr<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getCurrentUser();
      return user;
    } on Exception {
      return null;
    }
  }

  FutureOr<ErrorMessage?> _logout() async {
    try {
      return await _authenticationRepository.logout();
    } on Exception {
      return null;
    }
  }

  Future<ErrorMessage?> loginWithUsernameAndPassword({
    required String email,
    required String password,
  }) async {
    return await _authenticationRepository.logInWithEmailAndPassword(
        email: email, password: password);
  }
}
