const String getUserQuery = r'''
query GetUser($data : GetUserDto!){
  getUser(data : $data){
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
