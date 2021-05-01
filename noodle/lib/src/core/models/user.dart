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
      "https://cdn.inprnt.com/thumbs/26/d5/26d5806851b003ee5c68858487f6a5e5.jpg?response-cache-control=max-age=2628000";

  static const User mock = User(
    id: "s3818074",
    email: "khaitruong209@gmail.com",
    username: "khaitruong922",
    bio: "Hello Flutter!",
    phoneNumber: "0908321238",
    firstName: 'Khai',
    lastName: 'Truong',
    avatarPath: "https://imgur.com/UHQMGr8.png",
  );
  static const User mock1 = User(
    id: "s3818075",
    email: "tinchung@gmail.com",
    username: "tinchung123",
    bio: "Hello World!",
    phoneNumber: "0908321236",
    firstName: 'Tin',
    lastName: 'Chung',
    avatarPath:
        "https://cdn.inprnt.com/thumbs/26/d5/26d5806851b003ee5c68858487f6a5e5.jpg?response-cache-control=max-age=2628000",
  );
  static const User mock2 = User(
    id: "s3818076",
    email: "tinhuynh@gmail.com",
    username: "tinhuynh123",
    bio: "Hello Universe!",
    phoneNumber: "0908321237",
    firstName: 'Tin',
    lastName: 'Huynh',
    avatarPath:
        "https://cdn.inprnt.com/thumbs/26/d5/26d5806851b003ee5c68858487f6a5e5.jpg?response-cache-control=max-age=2628000",
  );
}
