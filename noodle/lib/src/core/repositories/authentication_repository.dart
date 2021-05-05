import 'dart:async';

import 'package:noodle/src/core/models/authentication_status.dart';

// @chungquantin
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  /// {@macro authentication_repository}
  AuthenticationRepository();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.UNAUTHENTICATED;
    yield* _controller.stream;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.

//This is for testing only
  void setAuthenticated() {
    _controller.add(AuthenticationStatus.AUTHENTICATED);
  }

//This is for testing only
  void setUnauthenticated() {
    _controller.add(AuthenticationStatus.UNAUTHENTICATED);
  }

  void dispose() => _controller.close();
}
