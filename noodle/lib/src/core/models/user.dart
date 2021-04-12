import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.id,
      required this.email,
      required this.username,
      required this.bio,
      required this.phoneNumber});

  final String id;

  final String email;

  final String username;

  final String bio;

  final String phoneNumber;

  @override
  List<Object> get props => [id, email, username, bio, phoneNumber];

  static const empty = null;

  static User mock() {
    return new User(
        id: "s3818074",
        email: "khaitruong922",
        username: "khaitruong922",
        bio: "Hello World!",
        phoneNumber: "0908321238");
  }
}
