import 'package:equatable/equatable.dart';
import 'package:noodle/src/core/models/user_status.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.username = "",
    this.bio = "",
    this.avatarPath = defaultAvatarPath,
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.connections = const [],
    this.phoneNumber = "",
  });

  final String id;
  final String email;
  final String username;
  final String bio;
  final String avatarPath;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final List<User> connections;
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
        connections,
        isVerified,
        isBanned,
        forgotPasswordLock,
        status,
      ];

  static const empty = null;
  static const String defaultAvatarPath =
      "https://xaydunghoanghung.com/wp-content/uploads/2020/11/JaZBMzV14fzRI4vBWG8jymplSUGSGgimkqtJakOV.jpeg";

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
