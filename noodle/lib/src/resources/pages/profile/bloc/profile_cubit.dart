import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/profile/bloc/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository;

  ProfileCubit({required this.userRepository})
      : super(ProfileState(user: null)) {
    fetchUser();
  }

  User? getUser() {
    return state.user;
  }

  Future<void> fetchUser() async {
    User? user = await userRepository.getUser();
    emit(ProfileState(user: user));
  }
}
