// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';
import 'package:noodle/src/core/models/authentication_status.dart';
import 'package:noodle/src/core/models/user.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.UNKNOWN,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.AUTHENTICATED, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.UNAUTHENTICATED);

  final AuthenticationStatus status;
  final User? user;

  @override
  List<dynamic> get props => [status, user?.id];
}
