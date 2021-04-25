import 'package:equatable/equatable.dart';
import 'package:noodle/src/core/models/user.dart';

class ProfileState extends Equatable {
  ProfileState({required this.user});

  User? user;

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
