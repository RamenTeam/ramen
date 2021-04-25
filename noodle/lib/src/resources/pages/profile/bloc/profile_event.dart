import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends ProfileEvent{}

class ChangeAvatarRequest extends ProfileEvent {}

class OpenImagePicker extends ProfileEvent {}

class ProvideImagePath extends ProfileEvent {
  final String path;

  ProvideImagePath({required this.path});
}

class BioChanged extends ProfileEvent {
  final String bio;

  BioChanged({required this.bio});
}

class SaveProfileChanges extends ProfileEvent {}
