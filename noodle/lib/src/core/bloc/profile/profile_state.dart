import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:noodle/src/core/models/user.dart';

class ProfileState extends Equatable {
  ProfileState({required this.user});

  final User user;

  @override
  // TODO: implement props
  List<Object> get props => [user];
}
