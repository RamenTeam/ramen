const String meQuery = r"""
query GetCurrentUser{
  me{
    id
    email
    username
    bio
    phoneNumber
    name
  }
}
""";
