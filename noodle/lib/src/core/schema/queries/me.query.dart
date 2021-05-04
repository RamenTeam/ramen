const String meQuery = r"""
query {
  me{
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
