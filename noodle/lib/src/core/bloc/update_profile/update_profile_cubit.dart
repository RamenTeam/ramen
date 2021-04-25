import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:noodle/src/core/bloc/login/login_state.dart';
import 'package:noodle/src/core/bloc/update_profile/update_profile_state.dart';
import 'package:noodle/src/core/models/form/bio.dart';
import 'package:noodle/src/core/models/form/email.dart';
import 'package:noodle/src/core/models/form/name.dart';
import 'package:noodle/src/core/models/form/password.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this._userRepository) : super(UpdateProfileState());

  final UserRepository _userRepository;

  void firstNameChanged(String value) {
    final firstName = Name.dirty(value);
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([
        firstName,
        state.lastName,
        state.bio,
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
        state.bio,
      ]),
    ));
  }

  void bioChanged(String value) {
    final bio = Bio.dirty(value);
    emit(state.copyWith(
      bio: bio,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        bio,
      ]),
    ));
  }

  Future<void> updateProfile() async {
    if (!state.status.isValidated) return;
    print("Calling update profile to server");
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      RamenApiResponse? response = await _userRepository.updateProfile(
        firstName: state.firstName.value,
        lastName: state.lastName.value,
        bio: state.bio.value,
      );

      // Update successful
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
