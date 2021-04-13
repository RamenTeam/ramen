import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/profile/profile_event.dart';
import 'package:noodle/src/core/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required user}) : super(ProfileState(user: user));

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ChangeAvatarRequest) {
      // show actions
    } else if (event is OpenImagePicker) {
      // open image picker
    } else if (event is ProvideImagePath) {
      // do something
    } else if (event is BioChanged) {
      print("Bio changed!");
      // change bio
    } else if (event is SaveProfileChanges) {
      // save
    }
  }
}
