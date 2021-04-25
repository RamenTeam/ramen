import 'package:equatable/equatable.dart';
import 'package:noodle/src/core/models/user_status.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.bio,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.avatarPath,
  });

  final String id;
  final String email;
  final String username;
  final String bio;
  final String avatarPath;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final bool isVerified = true;
  final bool isBanned = false;
  final bool forgotPasswordLock = false;
  final UserStatus status = UserStatus.Online;

  @override
  List<Object> get props => [
        id,
        email,
        username,
        bio,
        avatarPath,
        phoneNumber,
        firstName,
        lastName,
        isVerified,
        isBanned,
        forgotPasswordLock,
        status,
      ];

  static const empty = null;

  static User mock() {
    return new User(
        id: "s3818074",
        email: "khaitruong922",
        username: "khaitruong922",
        bio: "Hello Flutter!",
        phoneNumber: "0908321238",
        firstName: 'Khai',
        lastName: 'Truong',
        avatarPath: "https://imgur.com/UHQMGr8.png");
  }
}
