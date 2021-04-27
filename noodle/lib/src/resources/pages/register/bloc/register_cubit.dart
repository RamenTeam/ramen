import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:noodle/src/core/models/form/confirmed_password.dart';
import 'package:noodle/src/core/models/form/email.dart';
import 'package:noodle/src/core/models/form/name.dart';
import 'package:noodle/src/core/models/form/password.dart';
import 'package:noodle/src/core/models/form/phone_number.dart';
import 'package:noodle/src/core/models/form/username.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';
import 'package:noodle/src/resources/pages/register/bloc/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(const RegisterState());

  final AuthenticationRepository _authenticationRepository;

  void firstNameChanged(String value) {
    final firstName = Name.dirty(value);
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([
        firstName,
        state.lastName,
        state.username,
        state.email,
        state.phoneNumber,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void lastNameChanged(String value) {
    final lastName = Name.dirty(value);
    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate([
        state.firstName,
        lastName,
        state.username,
        state.email,
        state.phoneNumber,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        username,
        state.email,
        state.phoneNumber,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.username,
        email,
        state.phoneNumber,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void phoneNumberChanged(String value) {
    final phoneNumber = PhoneNumber.dirty(value);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.username,
        state.email,
        phoneNumber,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value: value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.username,
        state.email,
        state.phoneNumber,
        password,
        confirmedPassword,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.username,
        state.email,
        state.phoneNumber,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  Future<void> register() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      RamenApiResponse? response = await _authenticationRepository.register(
        firstName: state.firstName.value,
        lastName: state.lastName.value,
        username: state.username.value,
        email: state.email.value,
        phoneNumber: state.phoneNumber.value,
        password: state.password.value,
      );
      // Register successful
      if (response == null) {
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          responseMessage: "",
          success: true,
        ));
      } else {
        // Register failed
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          responseMessage: response.message,
          success: false,
        ));
      }
    } on Exception {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        responseMessage: "Submission failed!",
        success: false,
      ));
    }
  }
}
