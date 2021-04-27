import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    this.newAvatarFilePath = "",
  }) {
    if (newAvatarFilePath.isNotEmpty)
      image = Image.file(File(newAvatarFilePath));
    else if (avatarPath.isEmpty)
      image = Image.asset("assets/images/ramen-bowl-light.png");
    else
      image = Image.network(avatarPath);
  }
  final Name firstName;
  final Name lastName;
  final Bio bio;
  final String avatarPath;
  final String newAvatarFilePath;
  late Image image;
  final FormzStatus status;
  final String responseMessage;
  final bool success;

  @override
  List<Object> get props => [
        firstName,
        lastName,
        bio,
        avatarPath,
        newAvatarFilePath,
        status,
        responseMessage,
        success
      ];

  UpdateProfileState copyWith({
    Name? firstName,
    Name? lastName,
    Bio? bio,
    String? avatarPath,
    String? newAvatarFilePath,
    FormzStatus? status,
    String? responseMessage,
    bool? success,
  }) {
    return UpdateProfileState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      avatarPath: avatarPath ?? this.avatarPath,
      newAvatarFilePath: newAvatarFilePath ?? this.newAvatarFilePath,
      status: status ?? this.status,
      responseMessage: responseMessage ?? this.responseMessage,
      success: success ?? this.success,
    );
  }
}
