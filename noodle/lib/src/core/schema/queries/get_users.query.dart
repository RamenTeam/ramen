const String getUsersQuery = r'''
query{
  getUsers{
    id
    firstName,
    lastName,
    username,
    email,
    phoneNumber,
    avatarPath,
    bio
  }
}
''';
