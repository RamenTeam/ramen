abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final email;
  final password;
  LoginEvent({this.email, this.password});
}

class LogoutEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final username;
  final password;
  final confirmPassword;
  final email;
  final phone;
  final firstName;
  final lastName;
  SignUpEvent({this.username, this.email, this.password, this.confirmPassword, this.phone, this.firstName, this.lastName});
}

class ForgotPasswordEvent extends AuthEvent {}

class ResendCodeEvent extends AuthEvent {
  final email;
  ResendCodeEvent({this.email});
}

class ResetStateEvent extends AuthEvent {}