import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:noodle/src/core/bloc/login/login_state.dart';
import 'package:noodle/src/core/models/form/email.dart';
import 'package:noodle/src/core/models/form/password.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value: value, shouldValidate: false);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  Future<void> logInWithEmailAndPassword() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      RamenApiResponse? response =
          await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      // Login successful
      if (response == null) {
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          responseMessage: "",
          success: true,
        ));
      } else {
        // Login failed
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          responseMessage: response.message,
          success: false,
        ));
      }
    } on Exception {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          responseMessage: "Form submission failed!",
          success: false));
    }
  }
}
