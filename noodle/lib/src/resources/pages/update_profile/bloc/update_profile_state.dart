import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:noodle/src/core/models/form/bio.dart';
import 'package:noodle/src/core/models/form/name.dart';

class UpdateProfileState extends Equatable {
  UpdateProfileState({
    this.status = FormzStatus.pure,
    this.responseMessage = "",
    this.success = false,
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.bio = const Bio.pure(),
    this.avatarPath = "",
  });

  final Name firstName;
  final Name lastName;
  final Bio bio;
  final String avatarPath;
  final FormzStatus status;
  final String responseMessage;
  final bool success;

  @override
  List<Object> get props =>
      [firstName, lastName, bio, avatarPath, status, responseMessage, success];

  UpdateProfileState copyWith({
    Name? firstName,
    Name? lastName,
    Bio? bio,
    String? avatarPath,
    FormzStatus? status,
    String? responseMessage,
    bool? success,
  }) {
    return UpdateProfileState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      avatarPath: avatarPath ?? this.avatarPath,
      status: status ?? this.status,
      responseMessage: responseMessage ?? this.responseMessage,
      success: success ?? this.success,
    );
  }
}
