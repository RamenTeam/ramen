import 'package:equatable/equatable.dart';
import 'package:noodle/src/core/models/user_status.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.username = "",
    this.bio = "",
    this.avatarPath = defaultAvatarPath,
    this.name = "",
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
  final String name;
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
        name,
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
    id: "d549f6b1-974b-4123-9009-fb9164f83bb6",
    email: "khaitruong209@gmail.com",
    username: "khaitruong922",
    bio: "Hello Flutter!",
    phoneNumber: "0908321238",
    firstName: 'Khai',
    lastName: 'Truong',
    name: 'Khai Truong',
    avatarPath: "https://imgur.com/UHQMGr8.png",
  );
  static const User mock1 = User(
    id: "493d951c-a7e3-422b-83d3-667d434849f0",
    email: "tinchung@gmail.com",
    username: "tinchung123",
    bio: "Hello World!",
    phoneNumber: "0908321236",
    firstName: 'Tin',
    lastName: 'Chung',
    name: 'Tin Chung',
    avatarPath:
        "https://cdn.inprnt.com/thumbs/26/d5/26d5806851b003ee5c68858487f6a5e5.jpg?response-cache-control=max-age=2628000",
  );
  static const User mock2 = User(
    id: "bec74d9a-3416-4041-85c2-db6be3b68728",
    email: "tinhuynh@gmail.com",
    username: "tinhuynh123",
    bio: "Hello Universe!",
    phoneNumber: "0908321237",
    firstName: 'Tin',
    lastName: 'Huynh',
    name: 'Tin Huynh',
    avatarPath:
        "https://cdn.inprnt.com/thumbs/26/d5/26d5806851b003ee5c68858487f6a5e5.jpg?response-cache-control=max-age=2628000",
  );
}
