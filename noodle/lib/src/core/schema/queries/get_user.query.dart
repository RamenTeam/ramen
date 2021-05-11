const String getUserQuery = r"""
query GetUser($data: GetUserDto!){
  getUser(data:$data){
    id
    firstName,
    lastName,
    name,
    username,
    email,
    phoneNumber,
    connections{
      id,
      name,
      username,
      avatarPath
    }
    avatarPath,
    bio
  }
}
""";
