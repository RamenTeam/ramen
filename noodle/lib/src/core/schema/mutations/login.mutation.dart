const String loginMutation = r'''
mutation($data: LoginDto!){
  login(data:$data){
    path
    message
  }
}
''';