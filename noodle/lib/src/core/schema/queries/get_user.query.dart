const String getUserQuery = r'''
query GetUser($data : GetUserDto!){
  getUser(data : $data){
    id
    email
    username
    bio
    phoneNumber
  }
}
''';
