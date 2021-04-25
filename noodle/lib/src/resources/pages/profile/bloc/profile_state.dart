import 'package:equatable/equatable.dart';
import 'package:noodle/src/core/models/user.dart';

class ProfileState extends Equatable {
  ProfileState({this.user});

  final User? user;

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class ProfileLoadingState extends ProfileState {
  ProfileLoadingState() : super(user: null);
}
