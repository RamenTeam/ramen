import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:noodle/src/core/models/form/email.dart';
import 'package:noodle/src/core/models/form/password.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/sharedpreference_repository.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/login/bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.userRepository}) : super(const LoginState());

  final UserRepository userRepository;

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
      ErrorMessage? err = await userRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      // Login successful
      if (err == null) {
        User? user = await userRepository.getCurrentUser();
        PersistentStorage.setUser(user as User);
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          responseMessage: "",
          success: true,
        ));
      } else {
        // Login failed
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          responseMessage: err.message,
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
