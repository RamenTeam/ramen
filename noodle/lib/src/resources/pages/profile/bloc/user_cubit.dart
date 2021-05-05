import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';

class UserCubit extends Cubit<User?> {
  final UserRepository userRepository;

  UserCubit({required this.userRepository}) : super(null);

  User? getUser() {
    return state;
  }

  Future<void> fetchUser() async {
    User? user = await userRepository.getCurrentUser();
    emit(user);
  }

  Future<void> logout() async {
    ErrorMessage? err = await userRepository.logout();
    if (err == null) emit(null);
  }
}
