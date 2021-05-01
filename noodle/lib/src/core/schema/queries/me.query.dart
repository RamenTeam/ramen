const String meQuery = r"""
query GetCurrentUser{
  me{
    id
    firstName,
    lastName,
    username,
    email,
    phoneNumber,
    connections{
      id,
      firstName,
      lastName,
      username,
      avatarPath
    }
    avatarPath,
    bio
  }
}
""";
