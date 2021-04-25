import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/resources/pages/profile/bloc/profile_event.dart';
import 'package:noodle/src/resources/pages/profile/bloc/profile_state.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.userRepository}) : super(ProfileLoadingState()) {
    add(FetchUser());
  }

  final UserRepository userRepository;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchUser) {
      User? user = await userRepository.getUser();
      print(user.toString());
      if (user != null) yield ProfileState(user: user);
    } else if (event is ChangeAvatarRequest) {
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
