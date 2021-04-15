const String meQuery = r"""
query GetCurrentUser{
  me{
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
""";
