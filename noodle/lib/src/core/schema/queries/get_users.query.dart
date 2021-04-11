const String getUsersQuery = r'''
query{
  getUsers{
    id
    email
    username
    bio
    phoneNumber
  }
}
''';
